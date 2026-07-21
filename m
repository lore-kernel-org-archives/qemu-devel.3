Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9DCC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7Or-00068r-ED; Tue, 21 Jul 2026 06:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Ol-00068Z-Fw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:08:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Oi-0007G8-R5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:08:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LA7v1t4107655
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zep7k1KYXigap4/4sfTGRxW65KzUV9jJTxxouK3JVx0=; b=nEvVqzeh8SKsHUP1
 Is5E7gA5w5yNVefqivC4oEeMJJ7fWlhHSiXLMyER8p2Laj9BjP99BjCxQrSuYHDi
 xZ9JJUIcMPaqXd14QYbFq3i0FJuqO3IvD4nga+HZvMuazEbt4JqCwHprNyBL8rJX
 qAKaUmVuq843Tzl9FdO0rmk/Q7wKIzGEH+nN6/y6PxoRJ54ZBHQ5Kr5XfXn7UKyv
 trUUl1xg3iAj71iWzmh5fSUjPvl+mKM8sp3XDz8jbktmqM1hDNec81CUO8SrExnG
 qHRVA6CCUaVIBQxXdTVyblgB2XNXiYkXHGgLfhj0AF0WA1/mf6WQ2XasxhwdpEXk
 RuPAxQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqnand5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:08:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so171369081cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628502; x=1785233302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zep7k1KYXigap4/4sfTGRxW65KzUV9jJTxxouK3JVx0=;
 b=kUG8Cjyr2Lc/WGUEF5hnLL8dkr3+XeNFh9ZJY3g0DHVjUZuR1KwgA7qcPHNN/a3hKy
 iCDAJilHJOdG1N4JPFY4UC8yzrVQ4jGNOuOyi6rNQ7OTYAEWURGJdtY4dZrCmpXGLWmA
 gtJAEC7GAC8FG56YMN8wXcoXioTtoa77H70gK7HPMc7ooBixhfQ/j3w3ILX6To/C1l/0
 HgdnzArTaxq740wpQtKsYYhzUopVaSKgh56z/n3Ywu/HSksYBNwS7lgvzktsHgYLTTwU
 ljctBZzSYUtBpyvaPGRbn8upvNG9aeENU8WwivfO0Yj3k2BFZPZT51JV+3hRh3aJ+5yb
 n4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628502; x=1785233302;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zep7k1KYXigap4/4sfTGRxW65KzUV9jJTxxouK3JVx0=;
 b=T1ZY86C+FX8pDDJd3q/Ka3ju60s2+44zBCZOxyzPUZUUdRKrdk8Fm9rE/DIfNTto3d
 hIS+O4q1P4aqmrOjts+tRK8RUMXnWAGVZ3fBRixlIu/D1BhdZzEcVNe+DmLbRp36gmGE
 Ci3Qh+OFa+eE4KLZBGm+oFfsXcSyfDnQKoN87K0pupiTKSV98QxKH2wc2PyhWfuLWkiV
 Tm/PszJS+dnSGXh1E9d+BstY52o7yrsLmORtzajqNhmRfLJj0tNFJb5mnC/Xz0K6eqDi
 Dzxmcn9+lOUIBSK+1GoCZCFx2gIMGWCNWODR1762XmVXPRHv7LvihivnBBFf9M1Z1p5Z
 WqRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUB/5wT29wNZCkM2VdrnX8AmMZ0rL3ZPpu1kiDgHHjhH2b8+YGctW3f/M7qfqYaUZh84AG8npvhj8i@nongnu.org
X-Gm-Message-State: AOJu0YwjGXkAvScDuDegQcrMtK6a+vrhrJ3V2Rd/lO1Uxmx/gWgwVZd2
 VCUx1AhuvpsqbpPudTrDqAe9JYlCe79kJX53HgtRnsCKsUpHCctl7U1BakSxw+eQPA+esQNlFCY
 0I+cn5KB4E7gQhV7nh10DzTSfmGrSysaCKgeaz7rI73x3GQIf31csqYvlBg==
X-Gm-Gg: AfdE7cmQbdAsgUapXLbFjQmm9zukvs5ZaeMQt1W/FWcr6hTF7VDAibMkKEbR4TcWGMz
 ab3If3SDb9E/MrddaZ7Vbg3Wb0Mk8IlTG8tec18Lxu3n+kymtmzV6ElWkTtKP10yZyAPTa6rRVo
 zGTQ7k/+2WVBT7igVpmVpymJWilHhiPaHQvr2pHTpWAXquj2CEfSqB59TMIqhcpduX3Uvchs/Gk
 ycMObO014QxR9W9WoS6GU9zXea1cPo2vArF8G6CDZFgrLnEzC67GpxxggdBxnZ+oeAKPDGDzJep
 669aVEO7b/HMhBLbOceSltIncuLU/DLa75bI4grvkkl/BsXC2HqeONhJJs8fRponj8p5ZFuwTce
 /9xRbl14sivzdxXTAS2m43fcpHSpm9H0qYLZDZJc99eYaTBmDeWc=
X-Received: by 2002:ac8:590a:0:b0:51b:feee:b08b with SMTP id
 d75a77b69052e-5213f669e2fmr165751791cf.45.1784628502102; 
 Tue, 21 Jul 2026 03:08:22 -0700 (PDT)
X-Received: by 2002:ac8:590a:0:b0:51b:feee:b08b with SMTP id
 d75a77b69052e-5213f669e2fmr165751541cf.45.1784628501741; 
 Tue, 21 Jul 2026 03:08:21 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm60042915e9.3.2026.07.21.03.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:08:20 -0700 (PDT)
Message-ID: <d4115b32-67ce-496b-8a7a-97c9fd8daf64@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/region: Clarify dma-buf failure messages
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260715070622.198400-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260715070622.198400-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwNyBTYWx0ZWRfX8sYeNBATWAW/
 PDraaIG2b1yDtuGqvlwQo8PKe+Mx3GZvTqSdks+EXeYt2ofTOvVr6K//orHVOrS9WdtGPNXDueL
 5ab4JWRX0XDxoQAZCzLtQCkB5DWPMho3iH0s8v3a3Ll596bhR9EaGJ6I5vRMLfpiL5MfO1V7DHz
 37AX+TpkbLiM0Qjqjm0X8uqXSiJhjJeh4vFM2oJjPhyi+qNrFBIkZJzDEnDypR8+4BXRNFuS+No
 V84QpQf19iqE6/SheCa/reZCvkTB8mSwsOkA0nxYUyWYZ+4/dVs0OE90vzrAVtyP6BtLd5YpV8a
 Y26vdJbdrVnJRtEKYFOCENLTWYPLZ2BBd0pOAUy/kD0rSKQ8nTVenhH4clW9gZipZB8NIA94Y6S
 yTiOuRX2eF2KEcNG2q9N4d2gfQDhLjj1Vox976FwAVGRKrVI6bWeE16xbEKPkXMtXDMFeXc6Ep9
 Sf2IpAgkSwcah0xzcSg==
X-Proofpoint-ORIG-GUID: m8z1P4BIokQ0FnD7gvc6tcqJwaGwyDYr
X-Proofpoint-GUID: m8z1P4BIokQ0FnD7gvc6tcqJwaGwyDYr
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5f4516 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwNyBTYWx0ZWRfX7rsIGvuCvSZm
 CjMJxvt54mgqpulMYAbeZSrDeBltiZgQ+AQHTDpFSSbk5RWyaa3s5EsRWIu72QdojRsd0YZRiy8
 OGkxLbRghOD958fGtSVh9mUXSoV8J5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210107
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

On 15/7/26 09:06, CÃ©dric Le Goater wrote:
> The dma-buf failure messages in vfio_region_create_dma_buf() say "PCI
> BAR IOMMU mappings may fail", which suggests the BAR is broken. In
> practice, only P2P DMA is affected -- normal passthrough uses the mmap
> fallback.
> 
> Reword both messages to mention P2P DMA explicitly and clarify that
> the mmap fallback is in use. Use warn_report_err_once() at the call
> site so per-BAR repetition on mdev devices is suppressed.
> 
> Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/region.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

