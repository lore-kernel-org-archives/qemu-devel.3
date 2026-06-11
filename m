Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC2BCD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZ7Y-0006H1-CZ; Thu, 11 Jun 2026 02:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZ7W-0006F9-UP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:42:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZ7V-0004RF-C1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:42:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GCB03843609
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gmzzsIqFmZoYfm8M0rjp/DD25RwJE352GmJYRit/whg=; b=My5NhvqIJyjd63qk
 uxf/+atoeZIiDZXubWdOAwrTtRYVZBnobm69JNdG4QyOqDlbUlH9gvZwJ2Gbxjar
 trn27P2VpEzcwgUacPr+Mk5c9AZMnVszNbe7eFb6lR3lHFirCF3CJbCtVvN3sN5z
 Ndk0vTABwsKb2N77UFLWSqQsEUJp1kpgx7GhPsMsryRWn+ZGFRxjAxnZJ4TMWbqB
 sCjN3Bo02/Uv8cvP+FJ46hD7zVq0mwbcVC4ZTDfS2VqPU+mf/9QcWsiQkEcI1Okx
 m12dvF4hTQOVYR7K0dkHYT1vxEqpZhpkMXQLuTe9WTBmn+JrG74s4cXu+wmIMEQ7
 0Du0pQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe7020mq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:42:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517e054fe07so38785981cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781160148; x=1781764948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gmzzsIqFmZoYfm8M0rjp/DD25RwJE352GmJYRit/whg=;
 b=PHojJjP4FNAqNpp/IeUBw0a9PkbsaYN0m5A3hrbsY5RhXREQcxnW082dGt3VsLIIeO
 Usz/FwwzoYVf0ZRueBuBSdzAmvg7U7T92FpoMYIhMvmp+XhwrWDgB6kp6k+qerKBpezP
 2WkRyIJIXbY1p8vHcGEmqHDz/v9b2K/Wiw4KLob6QmF+Vs39QWSkNypQ4D0Plp35VEBV
 gWpABlqVZRbDu9k4jUh/QGcFTq6Wzq2af3/UaDXVEvekYl7xezbFAnQup7aoLPpNYAEB
 B0sr7hB3Ge7yb0eXqxh65Mfu5zAMxaOnq5OeKt/Pz2J5T+V3ED7rG30feNz8TYv9M+ZE
 4hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781160148; x=1781764948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmzzsIqFmZoYfm8M0rjp/DD25RwJE352GmJYRit/whg=;
 b=eoQEfm0puSN46hN7YLXh1/tFPC8pkrlh7I6lW/BmZG6a/ZEAi8pI9sstKVzUutApN0
 ftN4grivIfdFXg0YCBmx+m5ET/oxWzeXxUjqJl+gkXCbIqcboqYIYgEyas3s8f1AzRgQ
 U3a1tQNVMch4t5c2d2/TxmDKeRzWVVrB6cgLKsJXq0ONA01r7ejudRFecvNBdu7vpFbC
 gFStzJ0OHSrjGroduzYOQAf/qvH+wyNZTxDbW2iMh3sx7Mp50uWQhAzGYRCJ8G3x3kdJ
 Pp1JZ2NJHPjQB9qV3ZEjhRbccL9JxC2fd7URxVdbIv6SACYnrdX5Vi2j13xPvpO+ECpE
 /BCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ83QaQs5LMFy6foKBiDCwu8ScilXABPwlWwLB1JFgvZNkmCW0JAM4gNTHjjnCnFoTt2raXgjOs43ISb@nongnu.org
X-Gm-Message-State: AOJu0YzfI+MsvyIoPC1jBIKkg8AJW0DG8o8k/j/zyoQCk92y3ytmifZJ
 /64WyH+PYUuJ79FJD8giDxPSIQfLIDu892BI30xKVmo60H8vksAcn8wnqE3KeKiWdAaBuX6VZCw
 DybnF9+qxhq3Vr/scdI3vktSmHqOWwiZcKaSxZeBliXDd+MzGE1vYpUO3yQ==
X-Gm-Gg: Acq92OE5a+YlRvhwmLStsnW359MRyxh9rubEv9aOafOoAXYGXSf7pl+ZJQTV6GJ0qlP
 Bl3NcY1aXsCq5cALCWAObhThPQ9JnLpQQuuPSe50WMykFjarandiC8QZ+TXDcFLcVBjXtsmbrTX
 H8AYur8mcdreOERr1gRkJcu8oSaADl2dWg47f3oq9/0Rd43Vn/xlU4flGWB0UDHvP2SLogx0TWt
 pYhK8E/z6ybQTDJkebQ6gIl8KuE/RFhkkdE9Y3Wl5d011Ji/xgI0qGBW9FgGIjWDt4U6LksU22Y
 teE27TkTfM+Fypi9QOejJmgs0Z1wWchU2zCGkORPHRkLUv6Stwkymipzh0xHlujYqplb30Dsf2j
 eDXfLgU2/zZKTFaaOQjxxG4q1PGOvKGuhAnjlRSzZn9q0449korBBZFm9/vlaQ7a3ouc4laNXCT
 InfkBHJg==
X-Received: by 2002:a05:622a:28b:b0:517:6e5b:ebd9 with SMTP id
 d75a77b69052e-517ee244a94mr23003381cf.31.1781160147634; 
 Wed, 10 Jun 2026 23:42:27 -0700 (PDT)
X-Received: by 2002:a05:622a:28b:b0:517:6e5b:ebd9 with SMTP id
 d75a77b69052e-517ee244a94mr23003101cf.31.1781160147148; 
 Wed, 10 Jun 2026 23:42:27 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb668c9f4sm17602766b.56.2026.06.10.23.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:42:25 -0700 (PDT)
Message-ID: <d92662fc-5483-4505-9330-7271d666bc37@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 08:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
Content-Language: en-US
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-5-adityag@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610090800.3672832-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EGP9m1awgImDcOqZCMub0LeeEWJ-Frse
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a58d4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=QKpl30L47EuW14pftawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfX0e/Fc0+kGu1H
 y2oA51H4+LMCMQFGRtH10iGPbhAonqa7GlolOCrgBiOCXTbQSb1Nzw78NXIdSFwbbsT9PLwA9TY
 3NNkYcq+Fsc5qVDMtkudvFfih3fw+f1BsTMZ/Cbq38yMtBsg1mwVPU0Mz4Oe5KFMAcbztmEQvom
 w6LrzyHZkKahqIF/Ij/xNWbAo9HgTzt85pw7mhrYGOqv4omSc84q7kf2NKkuuHlqDg7HK2D94hs
 RflmPzaifCNgKk8+/pjaE75aAS5nVcY+u6v5t1w/QZFTdR80YT1tBprd+7Eh5yZWCo0ZQpKZWzK
 2EK/jJDgifaEv5M6Cu/XtZSLDdTmMBUCIAovt+lx/Qab4rGA+7KR83RQwNdk20QqPk9xFvKXM7v
 Ko+WA0OqFpbqhIIh8GqEJ2u8u0JkZCiQm45W+ioqxTs0XPljLRMOIYcU1K08IiaYjrDJY4P06pt
 5LNLwhyURhkLkNc8Z0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfXy58pumqDkSA5
 n5HRas5f4bvlnc8jW9nIpbT0P8bUcTDkO/p6XrTBGAY8svLPy5/MJ3eCoUOGki8ec2oU5ViXpgk
 p/+XOp+m9Stg1k8XdVnD/Ul2wgD7z0s=
X-Proofpoint-ORIG-GUID: EGP9m1awgImDcOqZCMub0LeeEWJ-Frse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/6/26 11:08, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> With no use of 8E and 8NVL, in powernv chips or spapr cores, remove the
> CPU definitions for the cores
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/about/deprecated.rst | 9 ---------
>   target/ppc/cpu-models.c   | 6 ------
>   target/ppc/cpu-models.h   | 4 ----
>   target/ppc/cpu_init.c     | 6 ------
>   target/ppc/kvm.c          | 4 +---
>   5 files changed, 1 insertion(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

