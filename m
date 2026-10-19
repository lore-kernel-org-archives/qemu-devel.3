Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF518606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UTp03ggD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X5ngLzfW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvaB-0002Mh-0p; Mon, 19 Oct 2026 18:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xIva9-0002Lr-4F
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:11:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xIva7-0001m3-4l
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:11:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLa4AH2892393
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wx2a8bcGxUyR+xtG080ozgfBANidSLx7tMqCn5uG96E=; b=UTp03ggDxhjmjN+n
 1KjIBmkUVxT4Ghq55jnXsZUouPohhqBAT5TbGMCnzWCEy4s7GfKlMYg7U+CM2zmd
 6x9ULuLeqNdwy+EPFqOlBUqjjADfxx4MpEqZobRv1sIu/iPVCSt81NjiFQQOYpWm
 NUQog7kAlOygzprTMK2NsS2bULuJdyEl9vRLnuDiadZi2WgA4EHShODFPfnXqHxP
 UuVWeH6hDE3Oxk9vGOXqLZwkhDNwAkEpjOJVom8XnGRzdyEwuEQXlqlhWZnpjEJu
 VxOgIDUf2WH+EvBI0v0Eq+xrtJlLUrGTEH1aC5poSGEkKrlwPBfEWX8ZC6hB36KK
 kt4qaw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0ujb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:11:43 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4cc89e86e9eso4074495b6e.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792447903; cv=none;
 d=google.com; s=arc-20260327;
 b=PnJSxemjyo6P2R5rSBq51WhqJXZGu0MN8qY0K2Zp7YFu/eszmVuruyUWH+bWxcYVfK
 n8Kjq8AUeOqIWFf//yg9/eNPQmeGccnQWzMiAovaS12To/uqKbB7KWLEPxgelC4Fxqaj
 GR1m9QU5ql1qMkotE0IYNKhfZEZ/9b4Oa2xE4QfaETq1z7BXVwmXqdi5iSHVOuM5K4CX
 Z0u2Mkf86ghERsAjhx0QSS+S3SEuYi5gvkxTdEyIyRjedFnqSYydMueuAzBduzPFYsHF
 GDD+s53ZJgFLaGCDXmXNgJgQQbUwoDI0iL4TnE4AdwByD58xvxxgkxNbn1azoRvMMpoA
 TyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wx2a8bcGxUyR+xtG080ozgfBANidSLx7tMqCn5uG96E=;
 fh=zXimAHwLWr+vIicNp30VyqFcXJZ/v2gPS6S6e1RH6HY=;
 b=Vw6QQHM6YnYjBWfjiFKMvyUpTUO4yucRZB6e8CsyI781vg/l2IqYfWzYfgUNHBj5k/
 9nvmMpTyTkCA9ukEVmmLANCeAWqsT80BFCSPi9MIxzfyw10/vi+GUGabN6Bg6DA9J1DX
 ia2H0c2nqK/r7T2N6/qVcZeoK7S0m/x+3Yw43vgb2rF0OaeEC0sp3BD4sjI1YOzPtVCR
 Zyd7842nyDGDC/ZRRPduwZZUCvAuyWowSxYhTw7nZXcUSg0I+p97/3SdYN1H2hhyv/eo
 MNGrEHOBosYXrs0NHCqcP0G3gUOuTpOW+UHzubuu3+27OaAvHBnUCLDpT/a/8CnkeonD
 9CfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792447903; x=1793052703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wx2a8bcGxUyR+xtG080ozgfBANidSLx7tMqCn5uG96E=;
 b=X5ngLzfWVQw2XDF4H6aqfEdjYpYu0bGUejTVxn5ROskELz1g3c77oqPltOTGsZHl9Q
 DDpVJFvlOXCxyzOGI9zc/ZPZooYoGr7U9Mi3Nd4Ice7rJDQM0WuvnIFPEQ97Vbe0V+DP
 z7q5LZc9P9YRsC3CzwLtCPcnRda4i6YBxy0226eyoZ33ChC9MQx9F4/AiMJ33eoabitB
 gktQDnfKlKFM6FiGWwXGWrv742YTzGLKxVIx1qNRNieUzFopukpReMzEyNxz3DTIBCEI
 M0FdonAQpBQz4zqpo23J4WAe3WynKv23b14xlrjzXEVpYjDmRVS1udkSQQmsARdv0n5F
 +ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792447903; x=1793052703;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wx2a8bcGxUyR+xtG080ozgfBANidSLx7tMqCn5uG96E=;
 b=jZ5X76USgbggdcVSx7A5QwW3u+3CCqOxb39tyowh2wp7R+2Gsvwj27PCEeSD9XT45L
 PF5mjpy0BJdLWq77ctNPRgnpxgUVG79i4NNuRWHPdFUq2GPJPimUFkD5xg0kQohC9Rtm
 mOeTHwEaErWxVACZ4XzSQykBCe6dh4uTna8Nr9hL4st8cuVtDgyfMArCEONANNQW0ZIm
 VDG1tVArFLi/geohThTsgbhovSFKjMqmhZYy8ehsholIeXLs2xQV0CKkXb/0k3NjJjLZ
 nFS42953rjJMaaSUpXISZQG0Bd/EcGwdYnAe6jWsViqXPIBmjzzFk/PZGBeI/gv6wH1q
 YDyg==
X-Gm-Message-State: AFq9FYJ6bSS4KhDS8Qi3gJE6GTMmztewu7BZr8sX+zt1CNdol+OJeRGl
 +W46xwFkZyxL2hv5x/84cwnxPCYqr38AUv315YnFiPIY88cL2iCoSx4AqtFrcLo/D30Z0c4FQ6W
 H5bgzAiBtuHIyojnzLxfk+md39TCe796CUGNHLO/z/GlnTQ+jHx8RB8+cPDs8QD/ds1lgRd32kT
 T7mRITsNKHcoAY4DxoknTUmkW5Np7YwSzL
X-Gm-Gg: AYBFou2+M+VeFBUJ5tZZfmV+wc5q+ZvRcdOMWgx0VqZURKx+e+NUQDlT6AuGDFAFohC
 O9TzNE16A2KVtIh/jLr07J2yCj/zvw3pV/K0S6KXXPhegUyYsXYIQ2HgAvjoHvPEHJKr99LbCxL
 hbzuLlnOiQUZFfUlivmWhiESsrZNcPsz9JD3m9UpuLJEHd/YUg5Q06jP+bf0+MbrhYVIW3Bz3PQ
 dy6i4TaXrNaJFrMAik=
X-Received: by 2002:a05:6808:1985:b0:4d5:27da:a492 with SMTP id
 5614622812f47-53cd65acae1mr8064204b6e.44.1792447903330; 
 Mon, 19 Oct 2026 15:11:43 -0700 (PDT)
X-Received: by 2002:a05:6808:1985:b0:4d5:27da:a492 with SMTP id
 5614622812f47-53cd65acae1mr8064191b6e.44.1792447902880; Mon, 19 Oct 2026
 15:11:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016170848.4024042-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261016170848.4024042-1-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:11:31 -0500
X-Gm-Features: AclHuK_SAoox1vJQ6ageClkCcVWeXkILtw0geors-NnTgt4xZFVlzLE4WilUJp4
Message-ID: <CAJ+KCYN_aEF-WQ47FSVfukbpwKKW7KWgRu0ScP4RwhVf-TpdBw@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: fix the allocframe framekey
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX8dS7BpmlxLNX
 0Zd32Bk1YJKx+0BQ0IAZIdf5ClLmxiGwZryToKhTN9bjZfUorxn/v+SgkmNrp4irnftvDW3/mUr
 tQ0Dx4rtAIaoRHXkFmipwEf2X1P5ggo=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad695a0 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=OAePBemRBBZk33O0WyMA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: Gld4a4aQkYBKwaY9aDxpxfVTJYQxqGBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX14T5LCvmEKnO
 7uDJKt6bBqO48j+k6tAnFxxhw/N/20uh8be8RtAfhP8EWDaQ9r2w/Oqsmkb1DXfdPtg0XXRIq9B
 NHm7cuNNcQOdlXg6wPGR/AX2FvWt5vXmRQBX/tOkxTal8B95junRGbHG31jPmd8RldAOXFtCgs2
 4mwqJQzJzFyWMW3GI+WUuF6UalIKLrzX8CpFzdZRqsPs00IsA8zUyIfJwuij7SYBBY971kT9Prs
 qNTdw3mOQau90b+IpPjw7MkTP0GeXh0vA8NcR97GOFAiJGRTgXzkKjVRyyxOoVNiXrpVvvoZrZv
 FhlIzYEmFuJ7r48JnwP/y+vQwKwF+U1O+rjKGsVzjIWgfNt3BzOVUHiX/HxAbTZ57iYgpPx7VS+
 uiJOYUUmFC1wcasdqCu0b186exR06IeuOqJhPNRLnJa/FWLlm8yPQe02ifEM9eVHVFeZxuybzjs
 Cqo9OnbYS8x/Q6k2bEg==
X-Proofpoint-GUID: Gld4a4aQkYBKwaY9aDxpxfVTJYQxqGBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190088
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 12:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> The frame that allocframe pushes is {LR, FP}, and what is scrambled is
> the LR word: FRAMEKEY is XOR'd into the upper 32 bits.  The generated
> code for fFRAME_SCRAMBLE built the key from FRAMEKEY in both halves of
> a 64-bit value, so it scrambled FP as well.  deallocframe and
> dealloc_return only undo the upper word, so a FP restored from a frame
> pushed with a non-zero FRAMEKEY was corrupt.

I think the commit message is not quite right. AFAICT the error only
shows up when idef-parser is used, FRAMEKEY is not 0, and allocframe
is followed by dealloc_return.

That also means the test doesn't cover the case that actually breaks,
because it pops the frame with deallocframe. allocframe and
deallocframe have the same bug, so FP comes back correct either way.
Only the first check catches the bug, through the wrong FP word that
allocframe stores in memory. The other checks pass with or without the
fix.

