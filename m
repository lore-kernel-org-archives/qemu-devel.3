Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1231BC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1lh-0002oB-Ot; Tue, 07 Jul 2026 05:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1lf-0002np-LN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:07:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1ld-0001aY-JK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:07:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E1iJ3209723
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U7F7VWVXbuYsSkYVNMs8x/xFE0rNwTFcjeULvJTk39o=; b=PAz9zhBlRQpcHgSu
 Ufj8y5lAa58h7P8nbYReUtojcbTik2JhsAFtdiXZJhV5iEBlTKuxgGFcl49N/aBL
 VlPc7dEsI+GEKUklxOUTJqv6b4AdevHfZYrhPUQ/VbtvgOKkTZDzQJE0mO0UcnY0
 KUpE1HYoIKkFQ3Xtng0SjLAkj6ss4mT5VrV0vdxe7uQKRX81nZgWXWOQTHW7kfdK
 S65oLJTLMRMW0ILbTk1qusb4XrgkegZlfYRbeXJdSn+41eEYEFjlssVOzpHUDU47
 dUPzOJ/PuJtLKoZ56fJlH5NoiPF9YxSOwVoBUQMkJPEspXmdI4kFqHZV9/4Y0fIM
 b2tRCQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj8k5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:06:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c19493ac2so36522831cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783415217; x=1784020017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7F7VWVXbuYsSkYVNMs8x/xFE0rNwTFcjeULvJTk39o=;
 b=LHM06LlSQ3begJqb1C3AQ93VnfuS/xr1j+oEn8Bv1uS1L+eB5W6up07AY2jWVIWG5h
 7lLFHc0ZRC17E/NorbrSNwaJLAzJVwAc/UnM0bPWWVhpMOK0jMcNXGS0FKhFiL+GQLxI
 kFEUj+z/U2Tm3tUHjiPr2yt+sXt/0TJRlYQj2egr0v88hn+iP/fyY+bdLjGkAhNh5Lph
 fALGMCkJqsGqM/VtKAloNHY/sXFzVkU9b1NrH29/40fSGbqfvxQaEgU3oFzHhjJWDnOR
 cV4YqEJ0qEOygxgBguZEo5N6zEkKvuSjB3UsjFiPafWcgS/DOtdCWpDUL7WTPKn0DcYj
 /yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783415217; x=1784020017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7F7VWVXbuYsSkYVNMs8x/xFE0rNwTFcjeULvJTk39o=;
 b=kqXTm3cqeLzA4HktuAnjaWHBK7OG+kVYVZUhvOJIS8w7ms/soYOt/Ne1Rxtcn9dGY2
 F7EfFsCVeqRsHkZ3nEvPem0tqZ+2MODkoP9B6NHafBgEvAJ8DvymlNkPCLLXtbbaPgNX
 Re4hclOIkYnvv5Qv8BxmiGwRjw9RXxNxIGGlWGFo6JT1feudkZojgs2X66bPh8QwarMW
 hgIVMXB5kmhVU3yl0FWNmS0VPr+kyyOToJnz+n3m1Rl8znbaD4JaDNMWYeA6qJFGOji1
 50hOYjdWK1ZpYhS+TLaek/EO2jVFqmjg752JpcHXlwO011Hw+Td97JuL1wD7Z4lcEMBz
 60hA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6gErefrlqxiE20CSRFkovTg2SjFTyirMtq+rtnnW2XSrKl4sc2bxgidpWNf0oP4qFyDOAIoc1vJwo@nongnu.org
X-Gm-Message-State: AOJu0Ywev8/lD/owOytw4uR6FfBB3aZMB1L8r8ZNejTxP06Hx2Uq0vaO
 RjYkSerJkjMLPiRHq51jvR0bBA/XhEp4MqJz+EwVThbA2CpJ2Uu9ODExVk3TnAXJEqEEBykIdb3
 xZVcmR5PRmaO4y97Smh11mVMj0P1XArhMjOuTYWtcYckfHh2KHjeKnJ/lag==
X-Gm-Gg: AfdE7cm09NKdIhSzkvgSGQhfC4Hlykm3XX3lleJ9NAoJObbESqn+SJMnc7YpZ5izLTP
 J6JYW9k3g+0Cdx0uWTN4E3PPbu69pnHpejXUPhiIuVwDWh0IkKb3z7ifQYwHOa9QDj41W5e+1Mj
 3fNz1n/yUvyKQmCPjMew/8L/EACYfWBWDfi1CCL0/7nclMHb2TshtAzR6usTav3b3BL5euHVDBI
 8pK8HJNMV8W5Td0zS4iYnqTLC+6VjSJ0ADihQkL2Nkv/yFLCmFw35v9f+Zvd8SRrp+oyQfUPzvC
 zRYZpEkFfZv0x8n5mJUZD/Ra7cf9lBRLJElE5FUeEoGdXzc9dWSluhZlHtYz33Vo+9L1pxZVyT/
 OtFdpa7CYvqsWhbtlyDIwXPFhE28iuSZ/CUa2GujvbOnogOvPmQ88VnPoUnOV+w==
X-Received: by 2002:ac8:5949:0:b0:51c:19d8:e30a with SMTP id
 d75a77b69052e-51c747dd37fmr45461051cf.15.1783415216845; 
 Tue, 07 Jul 2026 02:06:56 -0700 (PDT)
X-Received: by 2002:ac8:5949:0:b0:51c:19d8:e30a with SMTP id
 d75a77b69052e-51c747dd37fmr45460761cf.15.1783415216290; 
 Tue, 07 Jul 2026 02:06:56 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad84bc3dsm89713866b.21.2026.07.07.02.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:06:55 -0700 (PDT)
Message-ID: <09e531b7-0478-4172-b68c-33c92a352ae9@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ebpf: fix swapped toeplitz/indirection args in set_data
 trace
Content-Language: en-US
To: yujun <yujun@kylinos.cn>, Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <ybendito@redhat.com>, qemu-devel@nongnu.org
References: <20260629090116.266561-1-yujun@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629090116.266561-1-yujun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cc1b1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 65O27vP5rnoRK7vov4DxLajjEGWx0ru3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NyBTYWx0ZWRfX/1TlF/UyGElk
 tV6YIANZgDYf6XeOr0HKL8AlyEyV/DR4Y6j9I6pjNu4deR7ZtJhnVI6/Ow/ovj7NNEWcFhLqQjr
 FIFPU356fJK3uGHZEYCUne+2vbzEo976QAeOYH9xRaJ5ugXD/S/R27veSkgRCHkuksUh/qOqU9T
 6Yz8ZTTmXZ6wr110N3mgTfHmyHTwu9pcfM6WUKCOsHGAyqGN1TsTtNCcwQDWCKyKx1MCg5/PQp6
 +kQE63fmjH8WNNMurgtKGK1rKL4922I4EBJr/fNB6++lryuBhLPdgntkH43GmwQnaxHCq57/JBv
 yaQ09QsNv+z8ERjcwAxr638yr3Y5tXUBbZWSHizReBwKmWJtJQ4jQYesIGtY1kOwqeuLRe25T2n
 I9FIY2ZaC7zJdon7JDPm00wnrp/qqshL0audJzHPjGwGvc2LeJQEqdXPVzVht1Yd5W6SWJTBo2n
 HGF2fILE0vvPzuVvpnw==
X-Proofpoint-ORIG-GUID: 65O27vP5rnoRK7vov4DxLajjEGWx0ru3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NyBTYWx0ZWRfX1aB19RqvN+h2
 v92UH7l2+DHuxnPUrwgKRilBPE7BtTjLIW2KcjYcIKQEpcR6h5qmeTgim/A2Bb+nz9QGhqLNAv0
 +fl8LYn20v63bFGDhaoHy6ANy9rn+Qc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/6/26 11:01, yujun wrote:
> trace_ebpf_rss_set_data() passes its third and fourth arguments to
> the toeplitz-ptr and indirection-ptr fields defined in trace-events.
> ebpf_rss_set_all() passed indirections_table and toeplitz_key in the
> opposite order, so tracing mislabeled the two pointers.
> 
> Match the argument order already used by trace_ebpf_rss_mmap().
> 
> Fixes: f5cae19d10 ("ebpf: improve trace event coverage to all key operations")
> Signed-off-by: yujun <yujun@kylinos.cn>
> ---
>   ebpf/ebpf_rss.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

