Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD6C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocqv-0003ko-BR; Tue, 28 Jul 2026 04:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocqo-0003cl-4l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:07:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocqm-0005QC-Ow
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:07:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82Fpb2144841
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e/mFDzIs+X1tT0mEhnOkB8sY3Nj4lqj6npTR0EIh5zE=; b=cbcBu+/kc0WIJ3ws
 4Dx3CdkillpgeTPNucibEkPVl3dxGMUn7PPzMrPVrGYfNiHXTh04eoJ4eqfzkqMg
 y+Ra+VcgRUk9rapFNZmM9VYT7XHyw2xjGrzDIx4DluVcPp7wgNDyszRgXaGhodx8
 AazxFqyvwFNXi9OLFWSAXqEiXVwasOCTNfT5isKASk4ZIGH+XWJDaOXu+8E8yF3f
 k4DZg+fkVg9gGNXaCUi0QzxmM482qwEHXwbwSh2QIdkutN3I7pm7rL7BUPyhEbCB
 W1Y9Lhns/mmgK0RH7szGZviZSP4weA5WykCO73W8MmiJC6oK7OXOn+atEy5PVk7J
 ms/Ciw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19gw61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:07:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso42941951cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226062; x=1785830862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e/mFDzIs+X1tT0mEhnOkB8sY3Nj4lqj6npTR0EIh5zE=;
 b=e9bHmKDsPxnNxrnpzectsjMDx0tIrKqXUxqnbL2+mPSwfyCcd3iPYj+ze3O/JDsjTM
 Pi4jSnDWYg2tCeHn2ZXAh+OcoHz/YO6fncOuxFKpcjeOXkP2I/v/PaSFKhgww7O0LWSx
 HuLbFbguCLniRXNVUk4esLdca+4Lr4ZJGebk8rh4k4/j3qa+9Lvg6I2JtSsSEMdHY+CH
 QI3vYyDOFLPb2vL4z9K3FCLFCobhjlgaYrlVpUZtzllYYpASkGQ8nPFFYXBBBDVMFJ9g
 lPjKmQZ5N2Q0iNel0Q3ul2WADqzwLE8YTnWXXIULpk74T30RurlQPw9xrj2nGopm4lrf
 /dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226062; x=1785830862;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e/mFDzIs+X1tT0mEhnOkB8sY3Nj4lqj6npTR0EIh5zE=;
 b=b+m70w24l4JSUcRtxG9FXywEKF3VoGq7osH8gkU390rl4o/aTu+JPAZW3898Y/X19R
 rwhABuK60kSRRXhE8JxdWgGyVILIyzR2mpAWQ1GjwAv2IZW0zC/dfycGMDUGYnUSJv2o
 nW/umOeZ3uCXQnP5bpt4Q+E3MIXhQtHwCe4k795M14P3kE1EMTvnGPdQ7gDQigbFi0lb
 IK7l70vj1YxYOX+t3+5tkxsw2+qOp+OIQfYwM3YGu3tVJhGZ87gkrXSr+XdXhOEWB3VN
 PHnG7XGb4u/qgE5ezSOqkk2vQgTfbhGyv6vpSAMFbGQUgzm9HgL1DNum7BVc+1OfNqGr
 rn0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RranaSayeThZceYz09pgALaTW7rExNS8oRLmiX5Su9tHVnJQcxn2sd3Lb/f52/op1+/zGc77daj6F1D@nongnu.org
X-Gm-Message-State: AOJu0Yz26EtDjPFIaP/fFtcxi0WwlKL958vYAUTM3dMewT55HZFSOTGW
 Quz/tlGs5TSWKUJU7yDImpD8v7uD901NmqVwS4xdB7G3XxCDN/oUwrlRZT1Dcztnzx5kViZxm9p
 BJrvQ87h2f67Ks2K2HwwSSRtKtlhbMXebbCuDGUkke/oSpRjwG6cWp5JLEA==
X-Gm-Gg: AR+sD13qVLpO1pZFJayJNtGDxfw90cEax+lryzVGsHtL/RYxKpX/dp8V4jX2BSaDUXJ
 irQvnS+tEZBCYpfXtvE380fBx5Aq9mJvLIWj0wCCkFjcjTLKIigtMTWq7chwh/RQwh5DTAD4epa
 /ycFwCFt/3io20pKXuaXpj0WRM7Pxnfre7+o5v8T8aKqfknRFsnFHl7+Ru/+OnddYae7A5NnZK5
 JcCOZX8bfXjfThr1s32DmbXivKYmwBvmXd9nGuI3fvXk+/S0fEPbGUbpNE3MkxC1IifVaif+HHE
 dlbCI92S5Usc8N63yVslQYbt9BgQP2a7oVvtF3pcOHeqMkrSCHmUuKSO+mXl9x3Bnz4qynxt2A5
 BFOHIVIQqEPlKuCeHSDcgqknxdW8LozP9xNMOAINLyX3Xjhru8as=
X-Received: by 2002:a05:622a:1a99:b0:51c:1529:2c0 with SMTP id
 d75a77b69052e-529d71d71c5mr9601211cf.43.1785226062303; 
 Tue, 28 Jul 2026 01:07:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1a99:b0:51c:1529:2c0 with SMTP id
 d75a77b69052e-529d71d71c5mr9601071cf.43.1785226061913; 
 Tue, 28 Jul 2026 01:07:41 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm56390609f8f.0.2026.07.28.01.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:07:41 -0700 (PDT)
Message-ID: <b62b0a80-da02-471c-a5e3-af511f00dbaf@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/net: fix rx_desc_len on migration load
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260722112449.1386162-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722112449.1386162-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68634e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ZFFegcXCCrcJ7u4HAfoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX5mcikAstHGZI
 V3TeAYf4ZqFJhG5t5rjjkVzXAEpMhMCfuZPnqlEAZcMNOj6Y46i2bhzRktbZJ+tgD9L4OhBzdoU
 mkeKRxa9ohkuLSxIikYEgLriCBvMgoYO7JndK5VyuYnmJ52kZtsqLco99/C5pbggPP1SXcn4JZO
 nat3vSNdQa70YvMmzieRFZoRakbZiLl0xsVX0l9fa0bp/Lqfq3NGp6uSzYbNhIRRTQ+utYWFY3z
 SvG8/qdGO7JdsljlJjQ5UdJ5NZyP/WUCPka3VyeKdxQPvt8WIc/mJ/kFgD9qNxacTZXl2vNTqMK
 I+UwXv0ojylIYAO2jt8pz7FERgNwGBMRqcmAMMpG/7ejxqsfhkNABdeVvfVii1JL4KXUsyKKlgv
 KUZN3Z3QvCIBR4CTfE82YdFW+G2xeEejIxVfXd5DiOZbas6VwvSGU7q2nOFYQ4FirF5WTSgmJ3M
 1S0el+fHufuMJNFGS5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXyLP3uCF7W4WW
 mfc+o6nAtYvGuQSAy1ldn8/6+UAKaW+tEetcFkQ212YOQ6ZwbQYmNo7RutY2zcvkLUzDLCno+a/
 Su27PK6rgCxCy4GiKJVyPEnSUIJLgQI=
X-Proofpoint-GUID: 54p9ipMM8FET9FqHX3OmZU9azASLfhF2
X-Proofpoint-ORIG-GUID: 54p9ipMM8FET9FqHX3OmZU9azASLfhF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280069
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

On 22/7/26 13:24, Laurent Vivier wrote:

> Laurent Vivier (2):
>    hw/net/e1000e: recalculate rx_desc_len on migration load
>    hw/net/igb: recalculate rx_desc_len on migration load
> 
>   hw/net/e1000e_core.c | 18 +++++++++++++-----
>   hw/net/igb_core.c    |  2 ++
>   2 files changed, 15 insertions(+), 5 deletions(-)

Queued via hw-misc, thanks.

