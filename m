Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C99C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHf7-00029U-Os; Wed, 26 Aug 2026 13:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHf6-00024i-58
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:43:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHf3-00055R-AR
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:43:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGubhQ2103197
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YxIPwGeB7/ZlCIWmxFJTmwFJFI/msk9+/rR/I8P8AIA=; b=KX3vmRu+6ws598VE
 YPZCvmJ42j13Xs0gSR4LJbLBw/zraNoIy17Zz6nOFc+TpsoG9BbaSvon9UWYx+EV
 NtW23uUBda9FTewG4jkC7nN/VuGtc50hPm2CwC3wTZoXGhrHjRm8BPqp8iRzB3QG
 /AFXp70EpN4LCaNOmW+e2N/hkQH3omdf+f5O/+5Qf3h8apt5dK/lPXEjnWPoT1DD
 pNp7EiqW2V5eXAJxk5qKZSV/ugmembvGSfK2ddnk45nws4IaSDDI84iYzePIvnyo
 +H/RzkoHUPz3GcORXLZqlohlOlUa3NqVLH/UmNVjLLAee6XmH9oWYkRIL/l9nXJI
 Qkl/gQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbs25s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:43:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso9850191cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766218; x=1788371018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YxIPwGeB7/ZlCIWmxFJTmwFJFI/msk9+/rR/I8P8AIA=;
 b=A0rchc+3hJDGHSkQCcKph8IxtE4IsItDYlp/sOCh/3e8MNyaEzUgt51wKfJgFo0Lz4
 20bHm6JwHwCHh4SJ7jJa4nsgCYiJyraKSsv9O/9v95rJ7H/lpq2kK14DYwuodoqc5bcE
 U5k36pGvakxB9BbsPkcpQIpmnxFyfDW+vV5rY3WvbzbB4onY4f5c44eymB6aH2OTK0nN
 nRo+uRzBF4mRn7ZyOdns2ErHdOnbYIToFzE1P4MRIvoY/nYcB6zKX46pVAmgjWkBROBe
 RoiUaXCFl7iod8eSqYE9YRj+2/SFiemV23bbgBZNeMfiNK9Xvc7eqyNn4NvV9DtKrEHk
 FDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766218; x=1788371018;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YxIPwGeB7/ZlCIWmxFJTmwFJFI/msk9+/rR/I8P8AIA=;
 b=isIoZw1+7GQEzDJrMAy5HniN4rml1TKbqSXKPHDGtt+p6872i0OBiuvaXooAq4EiAK
 5OrBT2bybqRaf/HIXE0d6fVSrvy0w/TRlXJ4Tz0mey1MUJdzCn9oLovRlRLvzY/9sPcn
 2FrrOMPsFFpnFz+opZT52ilNUB1Fy5RLWzedktJS1sDDhbldX0rz5shTIBywzljqOZdi
 jAGFy2SMxKlxCTujYexFeZUJFC06+ZSjNzSgxVKko8x7fHsXhFhZuoJmHZ5Z8W9xyjTq
 c0SrA2RDkAE0iRJMDIDYCdj6mUv9RgDTllBVY8slV6N/U8U6XItMALGB/PSHgdNKLcRk
 Yc0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7Rfopdw9SKQgUZ97dYIBkc0pRP8BCiQVODJ0dszODcu+xRz3HLDSps/mubVLnHaPjf89PgZCuyGgK@nongnu.org
X-Gm-Message-State: AFuF++k6nnUiSqdsD+/ANX/YLJ3WVw8//NKqliai44stBXoEhdkNH7x1
 3p35h78mo9agnEA3B/u0I/dEi9dl2YNhqTxtL+88xlZGp95/wv8WMz489pGzvKz3KU1PxRiUluV
 Ykni26kodTMqNwzCTKp4AOlYBO1tLHU0zGI5VcfuKpqEZKc5QKDpQEzfCaXGYHugzow==
X-Gm-Gg: AR+sD11wmEjkHxYOsOvmAS3pt9oZljQVDrGXPxRZZbcA/2hmbq4IY6Vn2Th0JssKYks
 Jc9h2yknTxQQmRpvuvD0XTnia58Djj5QqHxVtBxDl9k8ANBTZgwV+X72B9D1VFL7s1CX/4r4kZi
 hV7JxILsAYm/FMAJKe75IsVdN0DrrW152uhuTDSXTNHWha37DaBHXAJ/8ohu74k3SOkPZfOnrpF
 KxHxgyo2oB1WmZohkHa31dfPm29E+7VgqlBqkdlze3gCCfhbxQUbDml/4jYWPh5x49iaiFuYTyF
 dPZeeyTWsh4s3NF1W0p39o9XBvfLDN6Zx0i8Unmq0+E55B2dHV/sWqKKmo5gGvvdAkSNq1/uFX/
 CBAkwNisv8Gaf60rSGm83ZWV1qiKzPKNFR5yXsO6uJ3Q6
X-Received: by 2002:ac8:58c9:0:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52e4227150amr78209261cf.16.1787766218579; 
 Wed, 26 Aug 2026 10:43:38 -0700 (PDT)
X-Received: by 2002:ac8:58c9:0:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52e4227150amr78208551cf.16.1787766217978; 
 Wed, 26 Aug 2026 10:43:37 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ec343sm441730266b.57.2026.08.26.10.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:43:37 -0700 (PDT)
Message-ID: <f5d26ec2-7d6a-4441-afd9-fa064d4da1f2@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 44/49] build-sys: make HMP source files conditional on
 have_hmp
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-44-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-44-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 123eXtTtEh4WCLuIPuGXPLINbZ0WVmC5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX6S17fqcIRSVB
 ExX8BYGd9+Zaju7JAHBEN85uhSL88tsDbagaxYw/59PUZNRDQpiAsi+v5rEkwREkLN5E0HT1gd3
 V0dr/00TyO31rkgi8zBoTMB+AI9EH2k=
X-Proofpoint-GUID: 123eXtTtEh4WCLuIPuGXPLINbZ0WVmC5
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8f25cb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=3WJfbomfAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=u4UR4SPWC-xz7FWC19kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX8U/GxjLJprJP
 JMIhsvn6Naz9k5I26BNF+sXFszwmOI91QPbyvGLeOiHnUh0TYfjnkGrCc/oOJ0L+UhWiPesE5cs
 aaRJDr1VnU5C/J2ij3216Nq7suP0wmOPI4MCXMMiz76U508zSMWfJOF99JB96i2bDagv7AOcjS+
 lfvvz92+i2vSctTIA75uaubbPFxM4tJkWLduLZWzRPU+bDqrRWJujnJ5dqjcZt0YtujM+oYRdoL
 BYbuJ3YlDhMqPLw1QUWhzZL1V2ye35mIifcbsb6EMPRYkDexKmxooHKX3vSXZ2GPlu41dIcfoFx
 IKnAQ76us2iOvdSpz7V4Oir/oLq7CmMZXK3iTWe+N+XwxrPB72bEouLXfl8F/yfwAJvxkgFFKIH
 kFYJbDJRzGLLQsrxWLdqFDH2xxzu2o8gRq+lHaD3dBIK2qXY0KlRKVO8fC6FqBIZGLf74NCuO6v
 dlkfiItcexnEZsIyv2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260148
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Exclude all *-hmp-cmds.c files and HMP-only source files from the
> build when HMP is disabled.
> 
> Also conditionalise the hmp-commands.hx header generation and the
> test-hmp qtest.
> 
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/meson.build         |  4 +++-
>   backends/meson.build      |  5 ++++-
>   block/monitor/meson.build |  4 +++-
>   chardev/meson.build       |  5 ++++-
>   disas/meson.build         |  4 +++-
>   dump/meson.build          |  5 ++++-
>   hw/core/meson.build       |  5 +++--
>   hw/i386/meson.build       |  4 +++-
>   hw/net/meson.build        |  4 +++-
>   hw/pci/meson.build        |  4 +++-
>   hw/virtio/meson.build     |  4 +++-
>   meson.build               |  2 +-
>   migration/meson.build     |  4 +++-
>   monitor/hmp.c             |  2 --
>   monitor/meson.build       |  9 +++++++--
>   net/meson.build           |  4 +++-
>   qom/meson.build           |  4 +++-
>   stats/meson.build         |  5 ++++-
>   stubs/meson.build         | 12 +++++++-----
>   system/meson.build        | 11 ++++++++---
>   tests/qtest/meson.build   |  8 +++++++-
>   trace/meson.build         |  5 ++++-
>   ui/meson.build            |  4 +++-
>   23 files changed, 86 insertions(+), 32 deletions(-)


> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 39ac8c9edc09..e16930c43197 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -24,7 +24,9 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
>   i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
>   i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>                                   if_false: files('sgx-stub.c'))
> -stub_ss.add(files('sgx-hmp-stub.c'))
> +if have_hmp
> +  stub_ss.add(files('sgx-hmp-stub.c'))

This doesn't sound right: this is a stub and we shouldn't bother to
conditionally include it.

hmp_info_sgx() is defined in sgx.c, which you #ifdef guarded few
patches before in #40 "Guard HMP command implementations with CONFIG_HMP".

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


> +endif

