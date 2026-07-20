Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211DFC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkBp-0006ZH-VZ; Mon, 20 Jul 2026 05:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlkBj-0006Yd-Qi
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:21:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlkBh-0007xb-37
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:21:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RgPm1774822
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wny+pFIYYieXfGQIfChRa0oX9UwdTtf96vAUVTaW6cE=; b=bJJkt4j9De9Reovs
 Xc8jkM8/z+d83xcNnoEyHYG0yWZCmX12Zu5aGuf1qHLQ+CMCe3I/98oaodkRWKLA
 dhL3UNIeRs9ru9cyMIFsRv6mMr004luAScw8kWOeQpEW4Nsh0MVTh0s+2/nUtWz+
 sEx1c//1vJOVe9ZIx1CivDdYmyLPqxRfE4gDNSP7Gm5uuhI3A7izGIjTPh5YtN1g
 eB/ccmcS4jqRW6ibRBOBsWnRVaWQBfqcQhZSe43qalMWxcwPUUVKQ0TW+2PiubAv
 UAO9nc6rnLRjDsG55TB3ijVYa5JQNWNckhbE6InhIDEI+d1k7+4udekcdwY18Jb5
 p5bA9A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af5fev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:21:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-520a00c7a03so96711801cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784539283; x=1785144083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wny+pFIYYieXfGQIfChRa0oX9UwdTtf96vAUVTaW6cE=;
 b=dY/meE5iV6MptoOfrJ8BR3eJT9jnyxQLrOpuD2eXWZvcg7p0oDOmMCeMJyj5ONgXVi
 /NB41sEY9dS9rrV8XxEZMeKxgiuKc1sNeVt+GzvDhM/u2rRHlm98SYQLUPZ9ZquACyM+
 9xAoSdvSvno7mbx0vgmah/2jRblELYfpAYbSHIFnn+gVOAjZYZZ32DgQgRN8rCm9U2yw
 PKASrJyvSvfcy0t/4Hv0n8KuIQzJjD1NtrqyWXzjcnerbZFGYN7tcdo7K1ACbtvfjVI5
 H2Ghlsvv9AexqF0vaRUgke6mPnUbTI4uoDNpqWcO6DO+K539Ghnh2yz/6rX8W7nurniY
 3Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784539283; x=1785144083;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wny+pFIYYieXfGQIfChRa0oX9UwdTtf96vAUVTaW6cE=;
 b=l0GFltqUU5w6L36LEUH3kiJNyNVrNgl4Z0YY4vOwYEcL+1GoBXV5lfH95hXg8VB04B
 fnP1U/0ChLnPCa8jTQ/44cmkOu5I+RBazGZX670UBBnjKaBLD8scdW+E++VOBK0AOlIT
 07O0J+U/U4UeoXmF2AkORn1AftNHBPHbC/Lvw9bgbesCJV4ATIepsS7mnvB1g78rWTH/
 eDXNYOrYjNShpxHu+NGRs0MvlfF18fvmQgII+cuLxloPrHh/Gt7muWK1/ei1CMKIO8su
 BzUiK92KhPKJiOaNH21EypOXihOk8Qrm5ws9FRWPrsQ5LRPt+TMQBsgBMziQfpxl82HQ
 90kA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8yjajCAL3C/oAHQ71CFEQ1Qc/JjMs8tGRYHL+AG9duL+WRg+xVnPUXSH0+SGphuQiEQv0BbuMdvXh@nongnu.org
X-Gm-Message-State: AOJu0YyXnUolkWzkJs78F2f5TPC2PmaqZGBZxFy/H4RMsmDQNla2XysG
 Ggy3pHy/YJJYgKRLQs3QBal49MhzPvH9Z50efgXCO4PacOwXXDg9uRqgOpzZLJ84bW0h5Afbpb3
 NKO3CWmaYPEsyqYXpxQ5nzgSzBBtbdW5BIKCsDpMtp6gJmGtJYtMg55Ydog==
X-Gm-Gg: AfdE7ckRkZSxAZlvU+UKz7Lh6uq2b9wy7wTWsRhL+kwK37mnGOIeKz8DbUxqeGqW6PJ
 Y04JOluDiSpN1wqhs96WMZNUnG09Nob+ReyvYDStjuQm2Yvb25mfFeTWdAtMm3qbEFPT+5IRu4T
 PEjbLenWrPVJiNkHscMdl6/9ybi36Xd8958FSeF1yHdPY0Px9kFz2aUXIUGSN2kHxgMalJWb8B7
 kz+Bic98bip8f6Vwzxq/d5oIDXZO7DK40LPj9Zp5rxGbjdEj+OESO3U7fVpW6M3U3ntgzX+ihFh
 zLvfpmdgJ2A18ViEMkx6+iFQQVhPFImNnCvu8+OHp2I37NnF5kV0xODET2q3O134IwANQ+vi1u4
 16uho2t1f9ZBdy4kA1+ezD5q0AvuR2fNJtbV3baJ42aLVzpHlJks=
X-Received: by 2002:ac8:7fc8:0:b0:51c:7b11:41a0 with SMTP id
 d75a77b69052e-5213f379a67mr121334991cf.77.1784539283205; 
 Mon, 20 Jul 2026 02:21:23 -0700 (PDT)
X-Received: by 2002:ac8:7fc8:0:b0:51c:7b11:41a0 with SMTP id
 d75a77b69052e-5213f379a67mr121334821cf.77.1784539282743; 
 Mon, 20 Jul 2026 02:21:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee926dsm26486942f8f.35.2026.07.20.02.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 02:21:21 -0700 (PDT)
Message-ID: <0a880952-78e1-40ae-9600-559877479125@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] hw/riscv: add RPMI FDT helpers
Content-Language: en-US
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-4-subrahmanya.lingappa@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260714075659.2258023-4-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXx5wFFk/t9cDz
 MJ9+11QKwPRbdJ5ocfUlSMcOtzDxm1rSMAVyD2+C7O5HU3OF3yEbx2HsKgUjkl315EbiLXPbBnU
 uGBpKA+phxlRCpKPCeDN5J5ObQ9flZ4=
X-Proofpoint-GUID: 2_6BLDj5GoiiUM0iCtiuYjXdkndnNvtv
X-Proofpoint-ORIG-GUID: 2_6BLDj5GoiiUM0iCtiuYjXdkndnNvtv
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5de893 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GI28Jwp6_UHTV3f1XaUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXxhRWqoFQ4SvF
 CSpdPvsszIgFuTXoO/7pmEpQMrLu10QCPE3V0d0q35qOX1eyDVmcv8jzQxtVUW7hOtYqZq4IvZ9
 zZd7dlZlwek9gsIhiN5N/RA3FonTkGziEz8e3VyUTXGt35r9S+I1wPsvVScnA4Wn8eoby7xQrXN
 mkRDlyLY0b1hR0FBW/xTiFDcsJiK7rB3SlirbJV/DWyE165NfK2/mirrEsZGGfnKMQSLPZUWCF1
 8jubq5DDvQ7XcVK7VaZh9p3YrjKOInsC9xXJmAMSMKB5VeWeO7X+fqobX5oHAw+56cWPR7X429c
 ck29a9AycTY0/n94V5xb805iQAx1+hDKWKOTVspV6CbG/+Bu5RDp+quxda5O6UnUvgqPG0LSmjq
 haRrdZ1zYq/Ue6aRVvqReGVbwTQxrNnaswx3RlvVGkaAfWQfgRQEKGX6mfv82HMwdoHUjt1czjH
 NtMESbe9e+dlp2g0JOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/7/26 09:56, Subrahmanya Lingappa wrote:
> Add helper routines for describing RPMI shared-memory mailbox transports
> and service child nodes in the RISC-V virt device tree.
> 
> The helpers keep RPMI node construction in one place so the virt machine
> can add service groups without open-coding compatible strings, channel
> IDs, interrupts, and shared-memory references at each call site.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---
>   hw/riscv/meson.build        |   1 +
>   hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 hw/riscv/rpmi-fdt.c
>   create mode 100644 include/hw/riscv/rpmi-fdt.h
> 
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index b70a054579..529ec273fd 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
>   riscv_ss.add(files('fdt-common.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>   riscv_ss.add(files('riscv_hart.c'))
> +riscv_ss.add(files('rpmi-fdt.c'))

Doesn't this depend on CONFIG_RISCV_RPMI?

>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>   riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))


