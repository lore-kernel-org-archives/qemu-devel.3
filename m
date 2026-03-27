Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6736710F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6DF9-00026K-6X; Fri, 27 Mar 2026 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1w6DF7-00025y-Hy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 15:53:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1w6DF6-0004CR-5f
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 15:53:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2i6C1458620
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qd0Pk74ydHdV4h1UgEkpT8cLx7DkI2ZsW4jMdkVqiiM=; b=ISgHeZz22edg0g+W
 tRehEIluxPAM+06wJwYsxKgMmL06DKVTxMdGyTsrmDp7HYDE7JejeAByDVzyg/PG
 Hg2Nm+YOPRiNOyGrY0Bd7EyLeiiU/kMAhBF8Uo18wKwr4ZZl3LqwtCTKl1YCb4L4
 hgqxF8saLLTfJH7iUsu59UcuffxVnsBEBb2h7xQP9VE6MEwR5CHDIGgzawCrT/p/
 hKhe8SDaM2/mJSWSf9KEJW3qKRijdAzVzCO1HvTs6s1S2dolZjk51KAU4Fo77Y2L
 ALSfV8ITZJK97IFfR2vUQYBJbG61UdeZR/Zsh2qsUasWahLavjLithRGHNgRpNCc
 GZcghw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6m6en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 19:53:13 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79ac9fad874so42259817b3.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 12:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774641193; cv=none;
 d=google.com; s=arc-20240605;
 b=ScFu4fp8YTGXBZLPv7zLYkUlOLIU7k4YJkwWJC2mRhw/d+KrWXEV7kfBfcvIR5IePq
 KxFxLF0kFGlAaX73B+ugGkCHqqmyRlF2s5qOczfwSa0EmQm8qKe7tf5Di8DuSnyJz5gC
 pCYQQQ9cVcFFjiWHXmwQPBUQgMo3WVs+J4LyahQMrzsXtFKk3aSCM8EYWcKZeUbOa25g
 7Z2TKKrRIul5QE4uygvbIioPczdkkOLFpVYUZaUn5U3T0TPwBsEjx44AtCSAlZV3pLOG
 ooArOMB36BJinTtSEthJn67m5EtsdHIatoinQe+r3DqHYEDtnD3ciz/apzuM72Y+JyIs
 QbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qd0Pk74ydHdV4h1UgEkpT8cLx7DkI2ZsW4jMdkVqiiM=;
 fh=D097zTbKkV0h0ZARb1Gldh/JYIcedmez16P/3jPTZfs=;
 b=KDplb5r3EcHdYjFrhE8dQpNoP4X/uxfG4RxyguDJwOYYceRSJhE0nBXfJYUrwMwRrO
 +ZzT0kFeRlCJb2om7IcUISWhZVWvp3CAvTZE1q48hyn2+TNYI/oqxSc+6F8TwnjC0rsr
 7t7MXwiVualU7aNQQoWuX+EFB3vyh20mI4s+2Rw+8i62MvdeI606wE4ZnmDr4zNx6Api
 k98Xz/mwgyobVFYLSssq2/JI8tg9HlV++YXKg1zxJwEuAvciGxeOfNVxsyHHBayBp3SX
 xWER9v3QYbfyBZKkLqqSwEkaCrl2EfJriG5wl6WDmF+sWAXDjCE4lXDEtkbK5p5n0N0B
 aYhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774641193; x=1775245993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qd0Pk74ydHdV4h1UgEkpT8cLx7DkI2ZsW4jMdkVqiiM=;
 b=YX2SxLEbfBpSyd5Xwz83TqAJSELPYtRx84f1/0j/+D7QNu/6DDIMJqNCnHyyp7/Ie1
 zzmvnivoccCuxc9d9fMBtE9AjCmU56YC83c7UsyAifx5w4m4UZACO/DU1wcg9CML4DgL
 6oSAM5vvmOELZK1ypT1ZcWRMse0EYLeU1yz3lKON8p5LY6xdXreYkJzKx3U2F1cvq/ir
 6YGPMb/B+772sN4g93gPTrP75dYXsU1W9T9jcapO01taM10l/u40SatfaPWTPxRklpFG
 MDUgRt2a8595SSS1sIK3cp23vz+OA8GuW8MlD4u+x5nVtmwFnGodBukfIR3HbfPkB66U
 ZQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774641193; x=1775245993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qd0Pk74ydHdV4h1UgEkpT8cLx7DkI2ZsW4jMdkVqiiM=;
 b=rNIuJ8Ww0gFmPZmifsHUnPZEGZo3QLyRFJbaXrwJPpyEt40Z1srggn04QuWU4jh6wK
 uG0cYsRozZzeGzj4OxmBCc5skofQliqxVG4iXQequ5in7HmuLo6zEMhZhquBNfPwu4Rt
 qWhYWXmGqgi8Xft+MzMF9i7iwFRWdhzbbSCofe2yfF8ekh5xL5t7qwPr8BpkooveFqsF
 IBl3s0/YnmYS6jAzZcGXPmZ2yvYwjVGvOyi0Y7IFjzkqK4LzASzt/TWW3i86vI94Ax8o
 iTLC0YHfUX+B3nTx4b8Gg8vtjcqPdjI7YV/ZmRoPI50nJk5afO7YD+zvZjXLkS9aN6T7
 JBnQ==
X-Gm-Message-State: AOJu0YwmtoJH7pogen3/Ce0kcOniVKD2AN8izih2yez+7yvhHSqnXUs0
 jqjB6hp77YG1n8Y4L9XtfWob3Eid1mpRaSPZJG4ovwKc0GCqEBBDxW239YVvTR00iACFRX4v99b
 XPIkY470HDRUhjQTS5LIEfopB3EbNpjVzEo9FCngBXa+awMVEMf1uDY9IUER8Y60tea6KcHzeF3
 s7lb5UeJKaZVNhSNZxL4SUlJci3au5bh+K
X-Gm-Gg: ATEYQzyub5h+z1dmfqW1tWDpZbgCAchJOxiRuhUGUY1rkw+FqGcEX2q4LOqd2J38TwJ
 cgudGoow4/BzetxesVTHrE3Kc4e86jivTIa3Sm3M2j5iHacIBIgB+GlSFzCRAd0u1v7n9bRhzlB
 TFOWZRhm3oFpoqmZPDBz7HDvD63qfLoLvVlHWVCXA+HKYDqaR/GeNQz8/v4uWrhcXCnYM1TB+5o
 qf9+NM=
X-Received: by 2002:a05:690e:4005:b0:64e:a7d4:473a with SMTP id
 956f58d0204a3-64ff7448831mr3829350d50.67.1774641192795; 
 Fri, 27 Mar 2026 12:53:12 -0700 (PDT)
X-Received: by 2002:a05:690e:4005:b0:64e:a7d4:473a with SMTP id
 956f58d0204a3-64ff7448831mr3829325d50.67.1774641192322; Fri, 27 Mar 2026
 12:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
 <20260217212245.95321-8-ltaylorsimpson@gmail.com>
In-Reply-To: <20260217212245.95321-8-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 14:53:01 -0500
X-Gm-Features: AQROBzD2I4NLqXrxEcwVIsGCh8XUGu43Qh_1nUq6tsPaBrLq9TQ4MCiVeqB3_o4
Message-ID: <CAJ+KCYPf+Ux_ustV4iOma+Q5kV5H__JVAeHxfDSe32ig0NXPmg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] tests/tcg/hexagon: Add test for revision-gated
 instruction decoding
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c6e029 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: BH5aLjAHk71i12beNV1F27v6tmlITp_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX8cE75V7maEwk
 aGjIjnZBWFsNpJWBYWtPTmXrlJRpzAjcyU/NEsJNPNIFFC1nWiiqkPWJyHNvrLln0QAmVj6hDbx
 atH9IkO56K9JoLP8t4xK2nUfVCbRaZDF3smdCtFwvKic7ppPZ+VlsfYJB6BxDdah07XZ4+ZNjn0
 zVNrQTIq9C9EI8szIUQxGTU85dfHYs+8nCKXVNL4D0Ndk2stewwqy5DqYkmNQJTbWh5m51xvTe5
 3ksuOptFKhiEFo5O+UwfrGM2NstXai/VbPbN+f0HlkMAevM+1Y6gCE3bOj4Mcq6Um6/DBuCIYbO
 Ts1zAPbRrwY1C+/3l5IY4+Y36PHjE8eZucGmgOQipLvQCVWnHAnEcWu2uH1rpmcvl/zWP/TS6zY
 2QrUvmlKqf0V1AdpqKVnEcHj7QRH9sXxqP8f9OgOqWw932GTGMFdscLskuxw78mAPvFq4h0VbYm
 59JNY1uNw9laRtlbuBA==
X-Proofpoint-ORIG-GUID: BH5aLjAHk71i12beNV1F27v6tmlITp_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Feb 17, 2026 at 3:23=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> From: Brian Cain <brian.cain@oss.qualcomm.com>
>
> Add check_rev_gating, a linux-user test that verifies the decoder
> rejects instructions from a newer CPU revision than the one selected
> by the ELF binary's e_flags.
>
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/check_rev_gating.c | 141 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target    |   6 ++
>  2 files changed, 147 insertions(+)
>  create mode 100644 tests/tcg/hexagon/check_rev_gating.c

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

