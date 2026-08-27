Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B21C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVxt-0002fl-6F; Thu, 27 Aug 2026 05:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVxq-0002et-SV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:00:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVxn-0002mM-Pv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:00:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RD5O3591973
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 93Elx8uh+fcEyji4DcGiL3WJC1H4GfPjD0F6hFnUXSI=; b=QC+apwadmbkZ19eO
 5ouR4xaSXrcnqvX5kH54qizhlvwTS0clXwX6nN3cX3RMEMCEBPOpzZcMcmLIV85l
 RBs6w1PS60AtBiX9a0UKBESn9GI/1M6AfKQzg6mxl0EVkFdZXnMcyMEE/nAyCE1q
 CIeLsv4PpjFxl9FaBnzXWrWAC61xhiBmEpRiagl+KvNsvUdKAoTfi/6k2py+kg6S
 aWGUH0uzXegC6G+kUYYP+IocO0SUjjtfCVIfHn99D21w3qX0Lfc1Znv3cpc7cKa5
 AneM7Nx9cu1pOwzKWebiDRtrTm9Paz4To6y1cKc5clKYNEu3hQwUqKuSgEcC0SgH
 bQg91g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egjyfv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:59:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso15991391cf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787821198; x=1788425998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=93Elx8uh+fcEyji4DcGiL3WJC1H4GfPjD0F6hFnUXSI=;
 b=Y4Zu4eJs0IkGIrgWDy0eiE4JCKUsCe7v0s5w7LOKGeQAwV4sJcXKLyeznkovyrtmW9
 BCxOT1oDe4kwyHTyYLLaZTf0Tp1H638zH0MV2D53xzs5CLigha8jQSsGSK+T3/nqo1ZM
 fRpYJlK1yNlhDrgfcD3MHIlG7xAMcooVOAxqOfojD0Jf/bT0pVa0Dp7VBjGDmEYvFBEg
 yNACTgRsRB7PT2aSvW8fNYZWaQNyNDjJRzP9kuzTYwj24zIoaOw8MtSW0tD2qdmYiwDp
 dwlDR0LtwY7vL9dBprAoh9U/zymDm2qdr5RSbQTW0atzbaIPrLFQMA3yQVIgwdFM2yx0
 Ni8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821198; x=1788425998;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=93Elx8uh+fcEyji4DcGiL3WJC1H4GfPjD0F6hFnUXSI=;
 b=WSFLxQ7S/+jxmx1DRmJAiiH7HZzaLQC5MvXe+UsU1hPbcQsqjkMzRP+wlMnBYq4erF
 FUaDobJPY3jHxxbX+fAqsZ28A7C/ZgeyxgPcK1+eVmOcO8M3YL1wN4TaW32oqPt5qiLz
 fooaxc4bTIN81zPBd1EnhXt73rNALE6IqdfQbbRLQ5JaBoTY6yCdnJqOE4Ai2olVHz2R
 B+ijkflvuVVVGQv3k8QJjvlfrRzXkXsH5i6cLl4coPXeuMNqKoWHB2OBSd26IsxYjw5o
 ToAW1TipwR5wk2DCbEZceJYamShYQL3+PPsy9XnSEoU7IceVfPO428HILTiFzdhtTyvb
 le0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpehE3fZ7r7ww+xQ7pm9iAsy+DnWiKxqIj+YjCp4DgZJZgbT/uqU4wdXsg2MZCU5aknTbx3nwn/KmRj@nongnu.org
X-Gm-Message-State: AFuF++kRJe3Z8J/MH7QT51bW5LSRhZHJgA4PfCzH82x/6X+uSIoFK90J
 abOZJJdRNimRZZ05blJC0f0og2D9AO3q3vgr3qu5PW+/isYGpgqOyxFuu8iOO4GOscIb8edvZhE
 j1fn/Wz0khrs0CrtjTV2aimxpnHmA9arkahKHZQYU7XiEWPY1Uh5CXfYX2A==
X-Gm-Gg: AR+sD13iCrehEXqTUh//9l9oPo6F1eCKg564A+qBvovNqeA5AdygF9J2LKWCxlTgDqL
 47bLe9WDbfEANTjCbrgZn6I1fx065hmGlRlyV5DeDm5b4V1pW09Wgo4VCFvFZJPY68iZr5C7N7c
 O5WrL1wGZnm8lDJnKpUhX+tb9CYwST9/VgaoPNIlXnKRQpCnfGiiGS1dpDNpTCTOzbnlmc3gMiO
 F9KECM4yG/pUQ6BrzKc/UsjG0cy/Uyc8Vr6HUvbLRGMJpTcdfEx/2CoSTRbjsu+zBOR9ijXmJvP
 B+2LDYtNhi96RdM71hh+Sp4sd6Ez0WfW8czCI0104P7MXsLAaJmTx88vtA1jxB2wZvdkq28d2VP
 jVnti4FGbJnAZoh+QvBukheYiU4ukwNH6YaKqogx7FeUDbety
X-Received: by 2002:a05:622a:e111:10b0:52f:acf2:110c with SMTP id
 d75a77b69052e-52facf2202fmr8665511cf.3.1787821197752; 
 Thu, 27 Aug 2026 01:59:57 -0700 (PDT)
X-Received: by 2002:a05:622a:e111:10b0:52f:acf2:110c with SMTP id
 d75a77b69052e-52facf2202fmr8665391cf.3.1787821197289; 
 Thu, 27 Aug 2026 01:59:57 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28fe2ecsm7506998f8f.37.2026.08.27.01.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:59:56 -0700 (PDT)
Message-ID: <0c27d481-b005-439c-8eb1-559d4c40029b@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] edk2: drop 32-bit build config (ia32 and arm),
 update aarch64 vars
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260824164751.1700783-1-kraxel@redhat.com>
 <20260824164751.1700783-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824164751.1700783-5-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lNroQV1NMDaySjc_gAMgSxcMliIOSAfl
X-Proofpoint-ORIG-GUID: lNroQV1NMDaySjc_gAMgSxcMliIOSAfl
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8ffc8e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MyBTYWx0ZWRfXyTE6ngOMy5hL
 YvFe4BrDuuFoD2+7wLLS5cUMO0Qi2dn364+JDJg2NWeyxBUbyxKgT3qn3mWulSEmn85NCnxEdE6
 /APyk1beeuNM3Kcr+Vfabc2aoMsjjQEmv7Lhu2gUJCRR4DTOoIaKAhFj5bDCWpFojokEIU/xzCH
 bdVHOZwqmIs3csjbTaw5TjTwpr6hwfAIo04Tm1KV7+FegJpvrOsPg6BaOahxu4DDITWPdQ8Gujl
 Vf9gFB3si2rTByDaAsgfRCSd/W3a2iXXbbTYVQqR3f7zCbd+KSqECq9lV84sf94VQL4A9CVzCDI
 uWQ9x5b09I3vGbJ/wixsWJ3EkMMdov8miJxUQ5Rv+aFB7WvmSHl1s64SoN42AkrJdBIt2bfopTK
 RxOOkkroHKqKxC3btgHzqtNx+haOFIyTXrYbEpVA/STgSpAih2Chn0i/IICsX95TjQkImEbNz8x
 zXYzCvKreKTHTLr8ZZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MyBTYWx0ZWRfXx3wju1aA8GVv
 m4Eeisc8wog5d7KpnLTacdmTmBciZvASCNKL7PPq02UuLD4Qy1H/Ch7nLVtT4zF0936PsATZTT1
 Sr/OzeXL+WIDmi45l7mKwod0FhitRVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270073
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

On 24/8/26 18:47, Gerd Hoffmann wrote:
> Upstream edk2 has dropped support for 32-bit architectures.
> Remove the build config for these builds.
> 
> Update aarch64 config and test cases, aarch64 used to share
> the 'vars' image with arm.
> 
> Drop references to the 32-bit builds in a number of places.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/functional/aarch64/test_virt_vbsa.py   |  2 +-
>   tests/qtest/bios-tables-test.c               | 34 +++++++--------
>   pc-bios/descriptors/50-edk2-i386-secure.json | 34 ---------------
>   pc-bios/descriptors/60-edk2-aarch64.json     |  2 +-
>   pc-bios/descriptors/60-edk2-arm.json         | 31 --------------
>   pc-bios/descriptors/60-edk2-i386.json        | 33 ---------------
>   pc-bios/descriptors/meson.build              |  3 --
>   pc-bios/meson.build                          |  6 +--
>   roms/edk2-build.config                       | 44 ++------------------
>   9 files changed, 23 insertions(+), 166 deletions(-)
>   delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>   delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
>   delete mode 100644 pc-bios/descriptors/60-edk2-i386.json

\o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

