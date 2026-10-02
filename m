Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44242CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgWW-0002X9-D3; Fri, 02 Oct 2026 12:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgWU-0002Ws-Pr
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:54:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgWT-0000R1-BM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:54:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692GjixW1835782
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 16:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRPfopnGjgzhsbtu11AJoHGNyV5yp+d1MxcLZ+yt/IE=; b=XYp4v/UTojxmnWD/
 d5CxeTT6IQyfoTpzV9a5bdQ4SQmWy/SgoKeDOCYwmnN0WU1YDEzynNJ1RDUa/DiU
 AaAIsPR0cj52scQm2LAI0JwbJWE0Fgh0Oct++8+zorX6HkPtb7C8P7V8C5rGdEaH
 ynSmlXZFDROvtEI2IKElAPvJumu8yyIQVu8PnndA8y6zx1WOFQrD9UgSPLuXLsSg
 sX/B7TYpzQ5ZOP+fFB6c5XjA3cVdRIpv4V3XJrw8NVrnlR7veRUoo5W7mRIH4Fs6
 dUIzHve1txhCjyqYeWHKi5Zrnszz1W49GTypBSjEGjASZ1Dtd2PoZJefhK/6lGDw
 Y5tPGQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ec98jue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 16:54:11 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b2f2b8d88fso132280b6e.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960051; cv=none;
 d=google.com; s=arc-20260327;
 b=qPJw9PFjLAbaWZAeRcksfdJQwlOIekp+KwH57NKQxsRXGbbBN14C/Ktti/rndJ09m+
 y4ckdU1lBniHBWI22GnZTetNiAN4vJ6pby4qp4EEp1YKbD88rx815h9b966fUefvS5ay
 wXGP5t3Qlr1kiO7v1+DFMM2TRg64MFNxU+WSH5p7rdIcGz8R6AEEHhAoseFEepwtn/Kf
 gglYe5ByyARP+ye5S4VsXTfP6hjzZMvhd9ftefsVLpnrbrWA2o/WI9yZGcA+pd1xfIMr
 8JY8dGLipWYzNkNqH5Ktjeg114K+cwLUCQeVIC1SpbsuDSkpBqvb0TKMEnMc52ZIsGA/
 pIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HRPfopnGjgzhsbtu11AJoHGNyV5yp+d1MxcLZ+yt/IE=;
 fh=11nfX6Do8EaL1FMi+r6eKWxDDoA7QEpVbFRn3KjheFE=;
 b=UFqvkh7qJSizEIzp2rINtYDiMBLypcjTnTfmQyuXUWgxphOS3yQwX2pzUltvFcAEbp
 o6EtrL07k4sNzeIJDDLmfTgN9zJxHOz+nKPPWAvRhxhcgKzZ/vtQU7zKQbHTxISof1Gg
 j8ElUWtakfngyBufIH+kQWhVWuN/ARgBkVOUDhQi29wc8zoAQrTC7iCv+s6NPKuWMTQL
 VnZyPBukroJWmTb1cj+jM3URM9VjEnD1ODOkTcdmc7FtZrR+n2vhW/rcBtvkUma+ia12
 ff/HrLqmMpoQbf8fTKNvaolUsRXpvwbVMB456+QLX+DP3w6MCY5qf3OWcwX33KyVWxcS
 mnBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790960051; x=1791564851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HRPfopnGjgzhsbtu11AJoHGNyV5yp+d1MxcLZ+yt/IE=;
 b=XyPQ/f+dxMWKSttJgGRlT0mLcV5rMhkn2HTawEDyCw4/2EP1hQseYM4u+wI7HG5br0
 TQb4O6YgVXVYuUulQZg/XQJoE46Wq93k7xklGLjCaia+jTELy36TwGpJbcWmCYeGMtRH
 Qb9qW8akENSacTYmVMqa6fEMn+0EbtW5BQeGvQXamdYMW0DGSGcoKVGvQ8PzZhrwWeWB
 S+5TVD2jAFPoS6JnWdo+HTuD83Mlkds1SzOz5x7lQ4aLGzSQlAt8qz72g50IriTQ8/5P
 u8xDj84KocbHbOrCb7c82HFf1sPSjMpIfKB/w6kJhT9HkO8R51uI4Aod954bnwpdOpfj
 YlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960051; x=1791564851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HRPfopnGjgzhsbtu11AJoHGNyV5yp+d1MxcLZ+yt/IE=;
 b=JCYKylC8GA5WmLsWbsBemq9UaBxa/86jdu9RiZm7Mmag8TRW2CKE5SLIN9yhRMncB3
 ViktJk9YqnhQPH0njN35U9gxXqOW7towFFV+P8nd/3bIZgeeB7B7RaRVxCe2+e6tUBp5
 BvextP1ESy7uwMjYQnvOo2hzPDzDbLl8MiuOJoefh0RnhVi39apQ4WkjKuRSx6dsjhAq
 USoEYWCJsvnk7MLHnwYjXWbMGO0XSCrcH+1z60/4tjU9dIpFaJCTTjRRpqEjbMRVbFmJ
 Ieu/SHObShaMdguYDuusqabI5zXmTGmBeLJ+M6MuMQ+DxqwrdY4wKAv5Q9AFsrDHpefV
 lG9A==
X-Gm-Message-State: AFuF++nbhrvHvEKTFO/wAHU62D1m48XEiV6y1ddBD/AxjngIDJY5n+sg
 cBBn0Y970n8hftUQ4FGPT3AgnQfc4Vfww28dEH+Y/R1X/LACPAYl6398XPsap1eOUSYLM7pmB0P
 258EYbK7Kk6k0qZJCkBETd9J4ZnEL9QQkRkcAHSI5hi+dGrYnEGVRbIYAdEv4bLpALxCj3sBYLk
 EKERkN6bP8byJTCnP1oCt5vBCCLMaaHDD6
X-Gm-Gg: AYBFou3pnY7FNC0x8hf0lenbn0xk7B6nDhmzb7aXrwAQhsUw9UddStIYTFQDKL7UR3w
 kahr5/vNubWKHi5T9NMdSSYB4WjDWXJDt8Tlvp+5EwMRQe0aQJ1ILyx8APlhC4Nv2JHzhAoUhOQ
 88vANLB97gA5IUYrYMby9bZb6SoXKYyZ0r2I8g/SU63Otn8t714L4N7XFTp3jiDL4okRP+b4/kp
 f3QxmrP6Qbz7sRx7Q==
X-Received: by 2002:a05:6808:179c:b0:4f4:7dda:99bb with SMTP id
 5614622812f47-4f52a572423mr2419279b6e.33.1790960051089; 
 Fri, 02 Oct 2026 09:54:11 -0700 (PDT)
X-Received: by 2002:a05:6808:179c:b0:4f4:7dda:99bb with SMTP id
 5614622812f47-4f52a572423mr2419253b6e.33.1790960050458; Fri, 02 Oct 2026
 09:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:53:59 -0500
X-Gm-Features: AclHuK9UzrCoQlBEB1Mvqm3whw4i_UGvKDqf6__UzsGpPUVnsQiSLJaZ7RH7k3I
Message-ID: <CAJ+KCYOLEXCV4CRMYdhS1jTk60sC9ZyswYqNVrO8BnymghFhzg@mail.gmail.com>
Subject: Re: [PATCH 08/10] target/hexagon: select QFloat inst semantics by rev
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: l0R1VE3VJTqov0X_QRRfVQbI0oo7qTjb
X-Authority-Analysis: v=2.4 cv=Ie8Symqa c=1 sm=1 tr=0 ts=6abfe1b3 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfXxchpsHjFrT4g
 DjhhWXttWUU5KaW1zfH6v0QbUvqGVJdpHsdu2dridmob0JaIvQX/wByv7syuVt5MbKGpT8sjMXx
 MlvuvFr63r/sVphwXjsQMprKUNiusNc=
X-Proofpoint-ORIG-GUID: l0R1VE3VJTqov0X_QRRfVQbI0oo7qTjb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX2RRQCiayTRq3
 eFJZvmbN9ooBSGXz1u4qSU53e4xPLK8bXunbHuByXafS77h1F9qB6Rm2WhWgpGahDYnRnLIbBXE
 LZlft5abQxSjMRktmYu6N2bPeg9Ad57vwYkc8WGlYj102IxTUhpbt0DTcgwUmY14fGk+eKKfeiW
 EFh32pS+1f2XCZL/A7qFLC095bZlscfXoUdx7sicdVekPcaCnImf88EzwxxC1q9+M1BV+AGBq25
 pQFmV/AnopGIoAo5LCHIiGOSt1mmlwlmGybRKXktpSSL5kCwZcEpW+rbJi1vzcTWzLwVx+bIJII
 ZzyUrbJvj71C7FtNQpx51W46eFmgyz153xijvkeb+B3b440RQ+VI3siur3KYFAO97r8rAFYhtni
 6v7mKvHKpA1JMWEWkcxgLKwHZjbkEK/WUft+tStoUWJZfWYmHm2o4WLMerk+aFU5WVa/u7G+eju
 +YyEW9KYVapZ97bih0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020067
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

On Sat, Sep 26, 2026 at 2:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h                | 109 +++++++++++++
>  target/hexagon/mmvec/mmvec.h                 |  35 ++++
>  target/hexagon/tag_rev_info.c.inc            |  41 +++++
>  target/hexagon/imported/mmvec/encode_ext.def |  51 ++++++
>  target/hexagon/imported/mmvec/ext.idef       | 162 +++++++++++++++++++
>  5 files changed, 398 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

