Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB747C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrilF-0006z1-OR; Wed, 05 Aug 2026 17:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhs3-0005Sz-7h
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:05:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhs1-0005tZ-FX
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:05:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HRo9i2912492
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 20:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OjTBt/gQGKJc8eAskbxmaAp4wuTjR3YP/g/YnNANSdM=; b=hSNRi17qpi2gFB3R
 7cYKQLuZThBXIvF+JJSqi1U6FQbgpXUGU7jHkc05fSzCnOSzGCPEAJKqfzZWRF2J
 bZRYJkUCyBebBC2nQBCoM1yy7MDzUr2PhbgFhfdWlwqsbZcUSLgw+7uCO68AIxr8
 4ZU+58wK28DC0pdUvH+v6pcfbCyK9fiaaTvyvSpDbuBmECy4ZP/gBYldf77s4SZJ
 xpqAeQJ6pVZVF0NCt6BhfEXEP+F+ezECjB18my1GRnNlG+ivm7FplsMw0nOtipm/
 tjb2AXmwmp1RttO0iYjJW7tsRxTjPnKVMjR+jSFVjSDmF2NitFLZYh5mZgqvU4VA
 Dv0ozA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f58nmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:05:43 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6ae4622d842so1234212eaf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785960342; cv=none;
 d=google.com; s=arc-20260327;
 b=eEe330zdCrpI4EDOmya61okp8UB2y0cXh44YKJqLdLw8iohhAoHKkPMrJ8ym4QtVQg
 ZOe48r95BC+qyHf3mO8+5fmnxVX4cygR/mKSei6mhSiEpPDfLCAVVEM79Uo6n1iVEDTb
 rXVHwSg1NcpXs6NC9XgEWjG+jun8iPbtlA4+DvWPzXmD+eB/WX41SbdvfUYWRQjPr5OY
 J4rlNEAlrb2810q6gWyZXIB/qa+bask9gpKPna77slZMvmEWGpvsXELc7I8Xky2iMKf2
 IXQmnkwkhlo5W2RM0j1sAnaHoxsJVxOkH5CluAvj7WTeZO1DbTCrALVO+d3eFCXV7Sly
 mLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OjTBt/gQGKJc8eAskbxmaAp4wuTjR3YP/g/YnNANSdM=;
 fh=Ojiz9TE6n0gwa8Sqy4epYViWg+Us2CPvSyvRXAzRpcM=;
 b=B2JcBeo7MIn2BjDeqS06synZWiaOuvqFM9OsjuLPQcd5kLVGgROyCL9BgodlHwGdt5
 YdDlN85mumr0cEAwLtRAKqXEksCYHWbM175OB/WAQUT3gLfhSP0FHKnusmR0Qbvvh0nH
 Ap2ztP1pUch+Tm/Rc44HJdcUVrcLceroo4WEGtX3VkxpBg6ubJGAn45hcYbwz+i3wMFK
 fFdbdKrn53CQPEmc1dH/fCB9FfK5IZ8CHHiMVDcXJj0q5R6FDa6HgR8egyNmwvac6bvQ
 XuvE5i9KX+38ZbXjtAzjBsmClC75q52A7FrOSB1+S6LWmyEIs5Ds0YHjWUG4ci5zM1gc
 t5pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785960342; x=1786565142; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OjTBt/gQGKJc8eAskbxmaAp4wuTjR3YP/g/YnNANSdM=;
 b=d+XNnNblbU0Y0BNlTbE1/mTRZiIsDNhXchxNpjr+ZIWsPkqZydd/ShIROvyQqzfx8s
 SUf7nhu75Cty9Mvn/hU3wLC+dJOltTccVu3297EtY+b2OX0bpfBg18Ye3wVQNIIilJrW
 g7t9JGmqoZyPDidrt+H2Bh6Suce4g8f4/0Jx+CfAwv07Nj8jBIdvDKbuWEPlTgBekAYj
 O6mVJDTxwT5+dt3sXvvlMpII1cEB5VMCSeo2e0T1+BGilK7O0uB9OVaLtPUXaAkn9xRN
 /PqfRiRdtMX7kNItilbm276O6damWTVQT1R31THfYtvS2m3Wrvwm/vUm3+JXfQn/BWDI
 1+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960342; x=1786565142;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OjTBt/gQGKJc8eAskbxmaAp4wuTjR3YP/g/YnNANSdM=;
 b=cdCOPLdCvOTUrMxpCK4vbKjs1S1A3TZSDkjUoGd5fd/Efn+H5XNQ1SmXi+xINzTvqL
 P2TtkWuSI2r9zQnv9hXUDQhGwudNvdrygQJp933rZr6EgjauutWrdc/raEqcMAKr5EO1
 R176yxJkgZXUBOwQP5iMYzf5jOvIer/ydfshXL1vyQNFXlmBHBhn5VY4RXc90PTAQT1Q
 CENfARDOam7tJpVvwuZiNBonBY4F98gHaFTtuXRrkmsYjruLDvQeZY71gKfOwgQPABp1
 1z+ay791Q8WCgzoxWm3TeDtiuGZfBSKp0QzufC269KIi5r7se7ZPJUea+8YTNiVF7wGZ
 DHIw==
X-Gm-Message-State: AOJu0YyaffHf/RolXcwa7d/93BErhdR7F+hrK6zDhOrzUDG2aZh0yoLd
 uYJYIXvaRxOFnSEvV49JlLoNAIkfq6a07vaJB4+qTflHVzvy6kPTYnZ/CAiEWqKBAHe0pasQtjf
 YcDnDKVRKGKRLarP4616eJTVDkzpNjGLnkNc9D0DBf94W4h3e6lFbwkDAUx19cqwcnes4/RTfTM
 jhKxw5aaYVQzNDd2vEpuTjWSUB3Ib0bzyg
X-Gm-Gg: AR+sD13N7xwYGYgXYlfdalvPwqQjIchAprbekD93nWvyClVoz9ZwTMMghYUS602fzKT
 wsKDeB2Ved8lufFxFZF5mDBHldWpfDfF40G7JRcQ6whgPGL8GhEy26N8v/aeTabVrbTQMiVXw77
 Sm9rwV5nl1r+y0VQlfeK5LK589gDm7fYm3x7rPqvJmovPG3cwxIgPL3ufM9z4=
X-Received: by 2002:a05:6820:180f:b0:6aa:d97f:4564 with SMTP id
 006d021491bc7-6ae96ffab30mr5065043eaf.28.1785960342395; 
 Wed, 05 Aug 2026 13:05:42 -0700 (PDT)
X-Received: by 2002:a05:6820:180f:b0:6aa:d97f:4564 with SMTP id
 006d021491bc7-6ae96ffab30mr5065007eaf.28.1785960341874; Wed, 05 Aug 2026
 13:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
 <20260805165225.3117924-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260805165225.3117924-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:05:30 -0500
X-Gm-Features: AUfX_my1Lrazen5ot_rTAeKzTzNOfIy_VIs3O64sZYK0_KzdHEPb9SOk3_qxIK8
Message-ID: <CAJ+KCYMNvxKvnwi6H=i0cU7P4gQMABNBR_zH=-MorLL+J=NzvQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/hexagon: add GVec overrides for HVX vector
 average
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZxcTnP6OfxPNbsiVukdBXKoXn_KUX6-X
X-Proofpoint-ORIG-GUID: ZxcTnP6OfxPNbsiVukdBXKoXn_KUX6-X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfXzHvQO17qGRpB
 DHjkZe8jlPFNKbvvyJFxuPzjsa2M0incKy+8hURs8yCW/2W4ewz9He9dQV1zH09zICvJc4rHrup
 rTcw+8oJvCTHwjed4dNb2qYG7LOaZNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfXw6x8YiN5JVkl
 PM+W55sqtj4DP++AnV6N1S0GYGqaaxdrPcoJcxvp+gMUoee9hM7ToF24AV0wNB+KSyAmm3D3iha
 ixbYLNxzbuWwjJ2Ds0TIiU6l8TUUfiGJJAYTOTiAwtwjWf1e1aULTHcoDiEsVSsh+mSr6kv8jvG
 rxu+uzauPuQPmEgv+oI4PjbZgr2lPXO7dm9cnVPyObTgU3RnHOGU5J9tccfaQMLp0fZ3upZDx8g
 K0v9PAVylkSLW7Ul0ewDVnp8s5hgJC5HRuyO7h7pV+R78cp2j63+Ip8QoTuhAfr6aSkb8NssZnb
 dAw+ApA7HZC66n233+kkD4vRHUhJYFXAOIT7v/SwIxTm/jwrwUn+gZTnfopnICmg1xaNAm3cMVQ
 lAPNS9Os1L2DkhEykkIE+Ny8DSPveCw/iE58xTI7qlUKgSEvVIV69sph2XEqINbykXPTmYK+BsR
 a6VUCzgAli8WirJUE0w==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a739797 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Aug 2026 17:02:48 -0400
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

On Wed, Aug 5, 2026 at 11:52=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

