Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3300CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZHtO-0006e2-Fe; Mon, 15 Jun 2026 20:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHtM-0006dp-Ga
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:43:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHtK-0007K7-Tg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:43:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0O0li1484151
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1d3fdOCF5vb57uCMNJUfQOB2GBWzkkYnI37ridFqMQM=; b=ElbyDBfyFKu/6TVv
 fWwsLyBIZVxpX/kzJTKPCvUfoGOf+IceWUhIHUEMqPlDpjSMmLhLJMTUOIyalKcV
 DLRAQwh/4sQ7M+BrTeYsp+KsyF0Ad00GYdGiT9NpaHE8aUdCCslCJHCjk4iVUyHM
 NlRWVNbGr133vnGdR1FDEoui8hVcq6H8Ph/af3YFSEZqRuWtoJXoaSn1P7eFJCP2
 e9FbLDz689XzCslKev3ETOsMTx1G/t/uFWS/F1wsG9dfIBTBSSaadSIBpxvLH5rR
 NI03kdR/mfaeWm8dewU6oUiOGrlmJUds8TtRzGHVPg3kOd/5MsUAwxt6vRqfgsI3
 bDERQQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjuv1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:42:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cceb0317b3so61864936d6.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570575; x=1782175375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1d3fdOCF5vb57uCMNJUfQOB2GBWzkkYnI37ridFqMQM=;
 b=PLjC2oICflguKyuQnrNZnWW/+09qzpJK2Evxfu24pBlZAwd4T0YeMGTKh9Q/UurLx3
 /InExs7clSjjXGQez7xzxo0dXdvnbxk2orWCG/YtlqKKIQ2uEQyR3B3Ftd5WuS0BRpJ5
 G3wwnoV2es2sWwz49MxdOAqdKQ2Y9mWRWl5ijJR2s0bwsbhP03bMCXraBgtddOO2lqJs
 uvNu/WdF956xw7iaiqlvvjDD7rqQbzOLJyV5jzUJ19oFrMUbzrKkp2MxkyfVLaI4Phih
 fCmst/uz113PkNECi4rROQ7KgqvXf2HbSH46ChPp9qRBAAGzsnDX8kevdhglDEOd37lg
 5b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570575; x=1782175375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1d3fdOCF5vb57uCMNJUfQOB2GBWzkkYnI37ridFqMQM=;
 b=I7AUOJ4XtultrFHovYCM6TqJDYQ6iicDGnla0n2ncdJQjgYoNQ6awHdZPvFSvkZb9y
 cPie3y90D04APc/gKDlFjhRskTXCmvCMqMrz7ivyMyb6ABhOznSNnp6+wBYCOeyPR0b0
 D5afkBkIOW5x+L1LWG0AygenV7TXCV64slgf/8fXXk9Waqx66PDfqi2duPMw8dTqna8R
 JlXYWfny3tU9UByO86wIS8fy3X/mnH3fyJqT5DLbVbaDsmbvd4s08baKd5r7/X5V1+A5
 WhINRgOdbjWRd/k1sDbc/GAcLwy1qH+seY88rKTvbYKIuoD0RIB0XzIr5u+/dPbMSV9q
 4SUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BzAZP81tcFr6zvYLZEkb04hGTpnS5gSnkkJD/a0osj4DBz78X5BCTYW5SlGWDAsSp33YHBQIPgR8m@nongnu.org
X-Gm-Message-State: AOJu0Yyer53Mw8srjFPDx+tzpEkZptjfbhNjdzY2Gi6zskQ5Wk9j/2qx
 etCEdiySfTOgPPl4lqsNIm/4rpyyoARJ1LhiHzPiIpt5IV2Vjpd8Uq/t7v9d8J5zXzeWM+zBJ0U
 9jMfCxI+yIPfi3ymvYv+IKO9q9HIx4GdEFMTLRvb85b/cKQ8UVZk/jVim3w==
X-Gm-Gg: Acq92OEr3aOmr7SUh/cCrAXa0SdcymbgLscghGQxEg8Ou2GIay3IcYAinPdc85wlqJb
 ihbWGPOJKQsfSMaDXbGSHmeID4l4L11mZHQfr1kxrTHJ2ot8rYOeFXAXS52I/KAKe26MVd/+oLj
 myGQDXAJxEs9fQIiwaydBGc4pYhlk6CS+5jzME3NNJaSV947IO+VGC+S5sSXWeCOqTLLI4tv8lW
 Ft2GEs+ZvfAcVn8iBrlCETgrXMfycHUfhTRDFtDbQvA6OodMeBVrh06l/hYsRBLmjpohiSh7I6F
 qW/iJD7b0uINa4xijdrCkL8GnAn6XmYP6Rpayp6xKYMLj3cqRKR1xzxjRBuPab0tljDLDmb2Jhr
 dEgjqhyPpQuryZAx4giusH8H+0DhiC+HdnJ9RcCBLIaSA0Q5tQ3jm4tUutpbsIilBVryWyTSs
X-Received: by 2002:a05:620a:2844:b0:915:c365:ffcf with SMTP id
 af79cd13be357-91c48a35cc1mr229440985a.54.1781570575439; 
 Mon, 15 Jun 2026 17:42:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2844:b0:915:c365:ffcf with SMTP id
 af79cd13be357-91c48a35cc1mr229437885a.54.1781570574983; 
 Mon, 15 Jun 2026 17:42:54 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3a4easm37045825e9.3.2026.06.15.17.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:42:53 -0700 (PDT)
Message-ID: <317cdabd-b4a0-4ef8-b65e-f2b5d7456cd3@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks
 ATS cap
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-4-nathanc@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615204849.3659647-4-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX5UYmljljbo48
 KjB8nLrsDcXP+IqkBkxXxUdfP2VJuzzBCND5uo8kM4WILBsOsLHq4Eag6rQ9iGItXvcFgd658Lx
 fno+4yEVpZF/bZYvy8UeLys0EMNEFVk9mE5XuNDMTpZSlPMskdZqfU112I/TYo+LFnD7fdmVE0L
 2VwJbVGD7E8+QNWAxvvqYcle9+uNwX84mVAQwtEYUrvA/k5TX2RB3sIifNLfTJ6yG4Crpqj8Wkp
 WWib2S1nKAXyzykWJwb2JAQwjMPoFn5zqYUS3N0xmetYihJIPgU+CLDGdLKfyeuTJ+sn9cpnIr6
 9dWu6bC5AX6hfjFMLfcNPeP+zEoXQQP9ZUCQuN28E9ztCgV8GKaWEKeT1v/jXSMk4ncbft0j/J6
 c2OodBCbbQkmgKZQOgVtoDmt5WgVITdUOOWHiBqIuggzuNHQWjCf0cCImhznQGt6nPYRzBKzK3H
 25NTAACj/vAma19lLeg==
X-Proofpoint-ORIG-GUID: SVCv94PjwKdi6Kf3HyEtyCOdj3BONSxh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX/20SltaWhGwD
 YDH0BkvFXMtcbbIhaBt9pjlCrt6Oi50vQ5yozk339Z7kCbKllClOzMwdDP4yMqe249+k4ZvlTZz
 FmCUjza4rB3kPpcIHw2DRYUJmsbx4+k=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a309c10 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=YEEdSeXSiwHJo-MB3zkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: SVCv94PjwKdi6Kf3HyEtyCOdj3BONSxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

On 15/6/26 22:48, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Emit a warning when ats=on is requested but the physical device does not
> advertise ATS, since ATS cannot be exposed to the guest in this case.
> 
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   hw/vfio/pci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0f592ada89..49ba6813ee 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2592,6 +2592,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
>       bool pasid_cap_added = false;
> +    bool ats_cap_present = false;
>       Error *err = NULL;

         ^^^^^^^^^^

>       uint32_t header;
>       uint16_t cap_id, next, size;
> @@ -2680,6 +2681,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>               break;
>           case PCI_EXT_CAP_ID_ATS:
> +            ats_cap_present = true;
>               /*
>                * If ATS is requested and supported according to the kernel, add
>                * the ATS capability. If not supported according to the kernel or
> @@ -2699,6 +2701,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>           error_report_err(err);

             ^^^^^^^^^^^^^^^^

>       }
>   
> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
> +        warn_report("vfio-pci: ats=on requested, but host device has no "
> +                    "ATS extended capability");
> +    }

At a quick glance vfio_pci_add_capabilities() should pass its @errp
to vfio_add_ext_cap() so the latter can propagate any error instead
of calling error_report_err() or warn_report(). I note this is
pre-existing and could be cleaned later, IMHO the sooner the better
but up to the maintainers.

Regards,

Phil.

