Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0E606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jSyzuLbC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EW+5FAfZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2ad-0000dg-1h; Thu, 22 Oct 2026 19:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2aZ-0000dD-IM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:52:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2aY-00013I-0H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:52:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFI3v050098
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 45hUsI2QIgpxeh+V7sWe+ZJcCCossBTTDcabPNY23Hs=; b=jSyzuLbCuCPfSoQV
 fjCpx2GeXjX1LP53pokEke/0j9h1A4QU3gqppo/tuFtQ6p8GJMiVPIQrqrPoW4xi
 9MME+DtW4LraB2DnYzSp6zlx+rbslOP/cW6596TSKWegeOm27UlFhJk7fqMCS2gx
 OPOFCJEwPNBetuEDQPjZeMUe1kCfByfVWcG0fSDGzd/IcHGvyNdzNGsVBW3EYknZ
 eiUT5RP+1gtWkU4vYI09q2PMm/TIB5sXVFYJt9SswW0DNP1z1fYppfdU0OK9K/w9
 FdwjlPpfNer5bCHLrJV/6FpbmdBcvB+i5uoI8r1P2TOA1fuYBK3hOqgfLRmzKzgw
 mkGKLw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms11np-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:52:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so260840a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792713167; x=1793317967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=45hUsI2QIgpxeh+V7sWe+ZJcCCossBTTDcabPNY23Hs=;
 b=EW+5FAfZ2OSMarrpKA093Td36i9OKXIuArXEvx7cD5z8CfArtJ1XIBJupZMMIke9gP
 FCLvPSNm5ffqtri2YkY7Nnia07l5CF6MPKTNMkXWDwD1+r2zBeJ77Vg5lJqvT0q/KiS5
 2LdkbrkNRxmFav+0NVW/ZxMJhVW3Q7UYUqJLw62E0lJBpjDndy4PlSYsilfnxzUVIFbH
 Vr3WBvqNWc1sm8wFCJEdC+eihNuM01gIK9cBZNvZMXX36fo3k8oOxmlyQ0tTYtg0Nm0D
 plyapdiqdLhCZgUND6/rWKqkeZ/ug7RE8iC9v+CF27RArYwktaJEfmXugFe67MNg2Kng
 tPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713167; x=1793317967;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=45hUsI2QIgpxeh+V7sWe+ZJcCCossBTTDcabPNY23Hs=;
 b=kRLkJt6Dd+VzVAj5tZyarWu1YYoTAt7cVl3evDUwW+GGJ3SCtO2ppJKSFvO2Bifmyt
 HXEwliIk+04Hk6ExzoSH0wYPCrUwj2OGhriHtGcxzm+/GAnULyQRJZA/WoIh00R0jp0i
 2DFwcABbdCEJ/tnNm2EdoLd3B6lnX8YLJjJGoImZiqOL2elg0KuUuErIerwegFvO1fNS
 xihSEBGLhp052vpRZ4QxDuOzyCR9EYEuDhoSNXE2O+BuY4oz1SGwf1udwm49U5WHxBO7
 C1kKmqUt0LflaLqBdohEzDtELuW/J2jh3LrpI/FblGZ8LyoIMNKcdI/uXB909tKnucHB
 2Y/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfgpfIAquT8d439YY6h9BObx6/jkSIPxZO2NRWigx2kmOdO7SKwNc7HuT5g12YUVwTcjo5FwZOMbwh@nongnu.org
X-Gm-Message-State: AFq9FYItXbB1OTG8dhHvpBwU9w7Ff83uIhfpVo5BHmIG4K3XupwrEb+V
 +L1M89KagaMCcnW0ytJLRSbbr/NmkCkD6pwUEvk/95eyd/elYujH/32l3GH82p3PiFjIc9v6GNO
 XIbbSaez20AfPAYfGFtYQP2/+UeNBlrwpmtiI2Drudrb51C/Mg5mQl/eYhA==
X-Gm-Gg: AYBFou1C1BlqMRiqOLJAl3srh3HA8oioo+3s1iUTA2QNBLQPRLEhSBxNsOFsLLkCz4W
 EpDSrgaz4U/hmzd/cu31AXTE7af0St2itmkfhhmMnazBqO2Hd2WMr/8Zl0oIJH4QG7vX0JitvTn
 G/n7EpigGhPyUsjSk15ugziHdkx5ABBT1wZEbrxw7UFkz7cSbptpZwwMd1lw48jk+VCbXBssEvK
 GW1g7uwpOV4Jfn2raYI074oumG7LNLn68S86cZpXmDhuC6NVRqhEr7LpYgul991pLz8XWIFkrUX
 u63OfjGfe/J/64p/gAd5QaYN6ToxuiwAeqw0hxzJFQ1Ikplx1++8oyaT3kHFzlg+DwzLv6vF+ge
 DYhkCDiPEdpQCZrWXhRHLRZBgpHV5WGo5luue4NPG5pFSKb7eHL3yYbXqBzlIkrFWOYZ82w==
X-Received: by 2002:a17:90b:3941:b0:3ac:77c8:ac29 with SMTP id
 98e67ed59e1d1-3adce5e6a00mr307371a91.15.1792713167319; 
 Thu, 22 Oct 2026 16:52:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3941:b0:3ac:77c8:ac29 with SMTP id
 98e67ed59e1d1-3adce5e6a00mr307361a91.15.1792713166915; 
 Thu, 22 Oct 2026 16:52:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adcdb1f8b9sm397505a91.2.2026.10.22.16.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 16:52:46 -0700 (PDT)
Message-ID: <2c632bed-aebf-473c-b09c-80074a2ca701@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:52:45 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/16] hw/hexagon: introduce hex-board abstraction
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
 <20261022230048.2160400-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022230048.2160400-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX2ZpxeJc8htqe
 p0S8sFx1w1vJPtmcifRncTYChoWIX9NgIr037+yx1MqJEdZaZ2Wtyg3NkdgnfuNo8ZtTiZTALfZ
 85mzwIJs99GU/QSuyevIr2I13n4gDyij2v8+E7i3EPXBX3CtK9+EBUa6touF10l52ttjblZFMdJ
 3SvMEIxUJf6jlo0UHqudgGiSspqKHJk2DuJL0pAo+oVeiTYyZG0QpI/Ls3kl84CFwQs80d/hRtL
 3VIvVm9MlPrB7XlIK2fB5ZuN5j9cgehJph09BWEGxPRKwsZhwHi/f224TQUbQcGd2wCFZw6j3FM
 ksPDFgHf84Foo0AZwBTevyEU9o5juXA6XJxwF5W+FhtmP3ifDVvjoZTPwS086g3zobMAqJ0PEvP
 kX8E4Jkwr8dn4UWYOFHSfYq/PB31B9+2WKZUMeQIgHcxMeOZiwzThpTxnXfy+5+/nydd4UM4gdV
 Xc5aQHNjfgseKfwb2NA==
X-Proofpoint-GUID: NnRnCxGRblT5zcCMYf0CNRFBtsIpPfuy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfXz7vKscjPIhVa
 m0jhKxhKoEmfkRlBBwM1LCT97ZgqZLMRhl+Vup6w1Z2UzdkRUZnMUtVnE2NNlk5HCzwYc515klv
 1yllhSdMPcVd0Vupj9lkKo43DfWxZh8=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adaa1d0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=sKGTi2AOazVunw9h_BAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: NnRnCxGRblT5zcCMYf0CNRFBtsIpPfuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 4:00 PM, Brian Cain wrote:
> Move what virt.c does to build a board out of it into helpers in a new
> hex-board.c, so that other Hexagon machines that describe themselves
> with a generated device tree can reuse it.
> 
> This will be used by future commits.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                    |   2 +
>  include/hw/hexagon/hex-board.h |  65 ++++++++
>  hw/hexagon/hex-board.c         | 265 +++++++++++++++++++++++++++++++++
>  hw/hexagon/Kconfig             |   9 +-
>  hw/hexagon/meson.build         |   1 +
>  5 files changed, 340 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/hexagon/hex-board.h
>  create mode 100644 hw/hexagon/hex-board.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

