Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5816C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42i7-00083B-Tg; Tue, 08 Sep 2026 16:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42i5-00082g-D5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:46:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42i3-000692-GZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:46:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688GLn6W3502014
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 20:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uKJ5p7YFc2Y5edMq8FPydi+aR4LSVBVfbCP0Kbl+pvs=; b=n3hSmpvl0/+Mt4jh
 dzyQ1aPwrsZ0Xp5ytJtziWZ3STzjn4JAWMdpDfmWAX/FifOKC4IrzPywiyxz+ClL
 nn6iOPVGQPNWgMN1+7mEHXIL5uuoQt0Yq7y1hyBdEm48tA9H5cWRwZjK3DdLwBGa
 aqoPfo3Ji92KVh/vRA5WneV3xHDdOQP4D0TD9eqht6g6ZBnRMSM7p2bWUbNYvLv5
 NjeJXJNTTkxH26QzMcfZw/tF6HsYUWMYz/zpzwQPY8dU1QGHSBvVzzh3ZFwK4yDQ
 2cGP71NFYEmcKtPImp0U7WHJHwLTuWzKkcXGwcaa8m3LVFxd4KFrJzOAZ2+4Fgys
 8G3AJw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjntph7d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:46:25 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b36cf0d9d3so4748345eaf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788900385; cv=none;
 d=google.com; s=arc-20260327;
 b=T10i8G52m23MHYtgZOyFRT85yt/QDEedMTujqOABCLwWlSQ8gLzGeWkkBJfNR9EsLx
 JVbamfazWoSszeClH/0OD32ppRUUMH15kr5qn0ItZuZ40tWxixPq7MDxIoiAHtsW/mGH
 l6QAwL1LgUZvdY1JDG29PhkKIa5Rxsy/G15f4JiK09bN2um8KNALSPKtod1CRwBDiH04
 yv/6NWUw0e1zBQyQ5IpoUuVeKFvVCZL26oyl7K0nUO5oC2TeW48bgW6P1Ug8DlmF7itV
 lLVy5WL9qPtS6FKn9LPGNlKdDPdu01F+86R+AI3pMUqijbbUdRQM5FAZJc5Uj3q54qXo
 zR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uKJ5p7YFc2Y5edMq8FPydi+aR4LSVBVfbCP0Kbl+pvs=;
 fh=LfxqVHs7iB+giXalVcz/pbqkbOXeZSBmGzkNDoDAtdQ=;
 b=Oz48r/thiqezRNgTfWck+7vZLMDI67rVybweLTSZ6DHwcluEfl0nbKpQ7sYlMecACw
 yhLnh+Zoo2JDOzzWyWcjmibqbQThEJqRL66Ms3ssxdqRKFRL3KjL3rXd4V9Pivgxxxt8
 SjgQjUUehSSMWZw0GFa5DhbHDhg8rX+RUPaYSTQ8bS6rivDDNayQpKfexk4MS65ddTR4
 XZIIq9Nexmp3yWZKti0u7IMECHVMCXbJzlNY5m5qf7HiaqlTEQRn9Al7FVakasCSYnSX
 kScq9KI0gcRIVsRFofDF+bcT1uThxHYhLrwd1R9i+6u8XeBYYxzePTy9TwwRCzvesZ1Q
 YnVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788900385; x=1789505185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uKJ5p7YFc2Y5edMq8FPydi+aR4LSVBVfbCP0Kbl+pvs=;
 b=GUlj8kUDxgdU20qdghVsEk8vyojkCtKcmXukP3g+zSQrLRRl1GTbWX8WuOQ7Mb5apm
 PPmttQhEarO03b/8jyngCyvy4+7H/iVExbawRAr3LP6SXj/4S1C1c3RWRQ4UMxfukPHh
 Kh321K0uW/UPqxcqELSzsBEWlwlmvmeBPCE7RQJuw9oID1WaN1SvMkdT5vzLzPlDINnw
 6nK/EQqtquIcQS1DtFu/e7QABCV/vciv5ihucxij/+oLMm8vmXUV0DUOcuSn3cPXD8xC
 Zgbx+nNtqRDI8vNzx9GX0WoLPBZV1o0u4+ktj+ftbIWCR0e7FR9czPLLKb7XVm/tKP7x
 khWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788900385; x=1789505185;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uKJ5p7YFc2Y5edMq8FPydi+aR4LSVBVfbCP0Kbl+pvs=;
 b=SDb3p2iy8kAkNemci1Jxd8+VFtF9AWFvWBsxDlbYJsrriXPAFcYb6LKqaEsPtO/5k7
 lHPjOQ3XSjUudtZWLILaHi6gIIV7rbql14y0Ht9KT106QdRgDIf65PF5XbIrqyRbG2H9
 GWl6GzZm/d8fyswDVYuxofMo1t+MAPTBis4tDJ0xa9pOCX3Prvc/TO3jQvELK4MkutIx
 FoX91Oe1cN2HCaYH0VLHZWPxfz2EKjLdZQ0QaBTu+ZhPP5c4veQuR9IuY8O6j1NF+jje
 o6IhV7/ld6VoOFP2wLk8E23zbcDMBX9gnBKUDB3g1np5d/1p0LhxCuDLNdiWk4j6Kib3
 kJWw==
X-Gm-Message-State: AFuF++kKk7TP1zTzvPcYQJGOrV5CJulI3zhvLi5eNZ0nMlb1j4FtRCYS
 5Kh6916v39Mkp2we6R/7IzkRiZ0Da9b14QEh3oJyj0iGbr4s/IErNsMUdEW9kBW76qCpZNW/Zv+
 GGM8trqV+1M9La1oOQn+gEn6ebQLFrYk1DG2d1FQWNbcV4kwY70cgReSW53dKcRQEAD2u3k73FD
 7qd7hMzVg6dTsk+2MMwWxVRZR6ae/UYnIda8WHAOqfQoA=
X-Gm-Gg: AYBFou1Mm9GvbwnQIQYadUDsDF1iRSOWNrjLXBnuKLbLZDQH8rqpwspqOPEj445xpnH
 LV172en/7CJqYcXDmSfFQTj0Ua/WmGNYPDEQCuEX4UoT0qxuH3EnTH5Z+7qrWs2J92czN12sgzR
 N9LFpgYjJ37FMEIAge4ErtGVETU/hfiWPwThj1qFHFtPI1Y+mztzk4oCJXFA==
X-Received: by 2002:a05:6820:3401:10b0:6b1:51fa:3562 with SMTP id
 006d021491bc7-6bdcddff004mr1577888eaf.34.1788900384531; 
 Tue, 08 Sep 2026 13:46:24 -0700 (PDT)
X-Received: by 2002:a05:6820:3401:10b0:6b1:51fa:3562 with SMTP id
 006d021491bc7-6bdcddff004mr1577845eaf.34.1788900384106; Tue, 08 Sep 2026
 13:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
 <20260908133512.2353957-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260908133512.2353957-4-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:46:13 -0500
X-Gm-Features: AcwNN1VE5t8oh_3-O9270CxPmGvgeT4wmhemp-7KEOfVr6AtwrCVHFTPgK1HKEo
Message-ID: <CAJ+KCYNk_cw85DEqYkLXJL64RfR3JVPWCWPbQpXt3heT8r+Wgg@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/hexagon: add the v79 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIyNiBTYWx0ZWRfXxmi60ef2JgLM
 Pp/vIyx7qocWkU78374SwBFcC9kl+iBQ01QEGwoIpQ+XVKba4Lx3dJl5XvYj1EGhSoBUOQihDU5
 vNiZcO8AhQ5ESiyaCagexQKUqfNrR+/mibIvGmnOqYdUjBsMaqPf/lKgeiqSW0q5GIpgcpn+SXT
 wJ4NdQXoiQN8ZFXzSP+IMfg7gtQWmDSVQ6sUY9lllBxUYf9DKOf3/7YlJglw06XhajpOf3pRmiS
 c4BLMR+dtp/GdTEkXBsSPTrAenXS4Mm+r+OuCCgsvTTLW7XdjIxx/UXso0S2hQkgH6rFawnoPqB
 7rF0LxYFq38GeCraXaFO95Cj+iKMgbma1FC0iZnotKVHqtiWwl4+VLfcYn6ptT3EwjBAXav8EE6
 u7a02GCw86AInW2x/h6rel86GE3jld3gSz0BrYHJvnJfC45qnIzgGIBOnJanYCODvEjr+UNX99p
 4lypEchiZ6c5hSrr0pw==
X-Authority-Analysis: v=2.4 cv=N+AZ0W9B c=1 sm=1 tr=0 ts=6aa07421 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=fcfxNbFOMLb4drGsxzMA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: bKRGWp5GWVHuBvYVdh3YTsKFs0oOU_Xq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIyNiBTYWx0ZWRfX2O3RuoAtfdvZ
 u2WT0utlMomksMk/nXNDAmCDlDhMp3/FAwq626oJaVpFK1c65rotSsGNSDI4yCKrW0Jn7V8A6vi
 SUHE1iiru1NyhP3vuJ9GCkPu/hdWUmQ=
X-Proofpoint-GUID: bKRGWp5GWVHuBvYVdh3YTsKFs0oOU_Xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080226
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Tue, Sep 8, 2026 at 8:35=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> v79 adds a ":nt" non-temporal cache-locality hint to the
> post-increment store family and to dcfetch/dczeroa.
>
> None of the ":nt" mnemonics are accepted by the assembler yet, so the new
> test embeds them via .word.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/attribs_def.h.inc      |   2 +
>  tests/tcg/hexagon/check_rev_gating.c  |  32 +++++-
>  tests/tcg/hexagon/v79_scalar.c        | 157 ++++++++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc     |  23 ++++
>  target/hexagon/imported/encode_pp.def |  19 ++++
>  target/hexagon/imported/ldst.idef     |  21 ++++
>  target/hexagon/imported/system.idef   |   2 +
>  tests/tcg/hexagon/meson.build         |   1 +
>  8 files changed, 251 insertions(+), 6 deletions(-)
>  create mode 100644 tests/tcg/hexagon/v79_scalar.c

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

