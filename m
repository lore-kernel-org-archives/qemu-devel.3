Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E355CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgYI-0003RZ-Sz; Fri, 02 Oct 2026 12:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgYH-0003Qu-FK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:56:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgYD-0000hx-Qk
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:56:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692GiogX1834395
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 16:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xqWLDMdlgNuKNyTBIRrR0Uo9OVhZFSiyXvjcl6VvLrQ=; b=n85nkrknfdWyuYIT
 1h91IsRPO4SIBR0ZFK6GQmBeN3q5YQ+THKb6b37bvGXv+efzc0cFlABgeA0mf20y
 hhWTAkealdQFLNwdJkhJGmJzKk4ZJ9gsnFjQNVCaBJDf++7BwhTUZBoz903EsBL0
 5DenDtCytjB1YlaDHyBw+7PXiSZzAecyCpt2Iqq+TvYwG8ZU5u54bjMXtO9tE300
 n+e4bu9cb/XLLw8v1tItOCmy6f/0I7GvwAjhUPUeLITFZRWtghhtihO/CBiRBEH6
 g0tQ41SVQFgHmQwjgTEFzwyCIVglJt1k4FZlIR8LL7kaysLa7tMHJs+iIcrZQ6rE
 73F2mw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ec98kkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 16:55:59 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4c55ba309c2so154513b6e.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960159; cv=none;
 d=google.com; s=arc-20260327;
 b=rXSQe9m3FTnM+2/mtejQ0HJaPknrNOZ82FkksKvjtJ/djdS7pZYqzR3sPwKsDJOdxy
 dVh6CRlS9dpjWXOu48UUmBuJ8Trx95Y7aYTRdsb8HguYnjBLYrYVH/nafYCUSR90hb/W
 aQHZa19T9j2yzOt0oYREvSwxmiBAHsVNcP8Zh9QlIEEOS82fX96PYMyob+GnypUULMe0
 O90AQ0xlXVUhIyTsTQjMzX94Ten3LjZQnrABnSPb+AhrHaEpUGuyV4YZWktVWmZ304pY
 rLNG6xMeNqW0bO2PoR+iN0e4ODOzhf2aa8c+UOdtVzhXHiPdxiByZE4iwu10FYJcM+0n
 WdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xqWLDMdlgNuKNyTBIRrR0Uo9OVhZFSiyXvjcl6VvLrQ=;
 fh=11nfX6Do8EaL1FMi+r6eKWxDDoA7QEpVbFRn3KjheFE=;
 b=B3Tx5gRd1LysDrGKQwxdEJKf8C1nonKWBFyCO8U0LY+Rr/SGlw06CHKpNw82NOsWPD
 M/jyXOdKwi5ojNERU6k6Fs7KrLzBu0lyyE6wDsQIHGqTNf3Yw2AnQAd7pGjXE+QMJZjV
 516VJZw/w3YgXfZPaCnF4yn/l6MwV6U1VHvqbH7t/rpJGvKJHNO3/6j9ODyYXAHJiTec
 tq3XXbJwstjfFaQF7UHo8xwgqbIWLJaDjUbMPtQRTIpPb+WeTCDz01/sArFzp5d/CgG+
 Lfd3W2rG9dX80QMjTUDGLVnTHdlnrkh8pds59Wi3/mLS2vpbLsdglto/ZlFEdCg/NUkt
 afPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790960159; x=1791564959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xqWLDMdlgNuKNyTBIRrR0Uo9OVhZFSiyXvjcl6VvLrQ=;
 b=jdNeOOxoT6g85uQcqrKibyFh8ph8puWgLzPqLSVy9zqGMJMN5VbqGAuk58CXfu4zwd
 5UP66uB4CRoMAl7JICLOXaiBislO+k0JaUEZBJ+ypcj7OSSQvcPLQQGrR6e0tX7eXkd5
 1skNVHF/asZ41laVxw8ggELmkiv6kwMEDoBwHZl8jtTX3NXlWM2PL0IuA87GtoJQxPO4
 WnnHQLSo88ulwY9I/iZZ8tImlS0zzinVsQnQ2aQVCnDKHH8MwRRuUTgkMras9EX5tEun
 URtyjRl0/vWriKL2SgTIAZNLzaPe0kPYA31N1x53OApr+Xp8r6u2H8QCc2CroJCNIoCn
 gkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960159; x=1791564959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xqWLDMdlgNuKNyTBIRrR0Uo9OVhZFSiyXvjcl6VvLrQ=;
 b=T5en/2AlQyTEk8QQlIX9eXPAOkCHIEAzkvQGGVIvlh51v6FGSmy4TELGcEuzh1MI+7
 N49yxcHSaO4k+ws/JwDA8gPZqDuvcBjWTFxvhClWRvL4l22LkbKhMoJrjOdqh5TJUNcf
 uFtHBQVDTfnffvjkAE+b8RUEyenFGqPlH1p9ImRUZmoaYSiiRAIzdLH0cyWYTJacaZOx
 j9w7IMWXXo51gg1h4mBu6cBGiU4PR1gSpB4fHSSOzAEFNfRYIPz2kdzde3DUcR85i4nd
 s3T39RzXykhrRFZj2+ssPAA0PMmAb6pZ21p9a5a0fobPUCOSiCfym6s80FsHABWV1DT6
 DKPg==
X-Gm-Message-State: AFuF++lQKTyPVeNltcCgwzSBJyjJ4j5NdR0HxWchQOQO4r6fMuo7IoH+
 Zj55IGLKwskp7XuiWKF/FvFA0fhCSRtoMUfjVWVxEsag9JqpDb4RUthfUS8mgyiw6Dd5IAB7wrO
 NT//9of6npdKJT7JTNH1QkApB8hr6BOQAZOFFCuUg2zkN24/YaW7BRJg+IrbiN+HjboXoo7jjks
 IVUNIvN5Z81o7cRyNPuewu8gMPnFO+DasL
X-Gm-Gg: AYBFou0PKNvWInTVKeVfSHvnXbswgDkAIv97KOu0h1FvhN06c1Dn4/7Z5wxM7zPknes
 ENRRqOXJgXHWMpLooU3w8iXpxhKBNaZ5dmAXGb3Hwy2T9bYW0DxTq41X04THWsiQ7RJpPO3zyuk
 jEd+ksEI4DM44wQinwhLIBYRQlA/uiru4ys3bnbrfJyl3m/ajGpaiDrfp6Ioun+BP22rRy4uQhj
 sC1R4FaflEYWivojw==
X-Received: by 2002:a05:6808:1582:b0:4ed:7045:d3bc with SMTP id
 5614622812f47-4f52a782444mr2306421b6e.32.1790960159120; 
 Fri, 02 Oct 2026 09:55:59 -0700 (PDT)
X-Received: by 2002:a05:6808:1582:b0:4ed:7045:d3bc with SMTP id
 5614622812f47-4f52a782444mr2306395b6e.32.1790960158481; Fri, 02 Oct 2026
 09:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-11-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-11-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:55:47 -0500
X-Gm-Features: AclHuK8TlM1EpFi2Ns61FTESon_A5ddaxiKaGAsafM9WeNPebzqvUWeJUxgO5u4
Message-ID: <CAJ+KCYPM0hd_hKR0s=tr4fkSak38n6qxoHk4Hc=9tgXMyDY3xg@mail.gmail.com>
Subject: Re: [PATCH 10/10] tests/tcg/hexagon: add v81, ext-QFloat tests
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ukruSX1IjZvsbwsRiuMZ82fZbAono9kV
X-Authority-Analysis: v=2.4 cv=Ie8Symqa c=1 sm=1 tr=0 ts=6abfe220 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=LZBDz1dbrZyKtt0saukA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX0tuOr3ALaZye
 gu0FNzyXsY/QdsWfLJrAp7cu8lZXAnyGaYi4euwgVSvlhsIhlejtD6smbV3Fq/4Gm5/RRz/aC6X
 y5uLvsHNKsRZxIpx4sFNbFzR9ljnKv0=
X-Proofpoint-ORIG-GUID: ukruSX1IjZvsbwsRiuMZ82fZbAono9kV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX6IOdjqMgeGqD
 M/DFxaexNp4bhg8B6urGYVrP1GEln3g4JGB0YO4U6x9G3OlqTgMQ/DMYoTCMDqNL5PMiG0F9fwz
 REUnYWgPwki93Kf6CX/YKozLlfjl9EN5X01Iw5k7RIK9QRxEjWGLK4d7jKDOFqluJldYvBeqQdh
 MEW7EtZPnIKQhCy930E83AKXoE9q6dc9qH/X23rclDdSxhSAaxiC5yIvzeHrHEwMEexZJqb/JqG
 7pgExbM3q2CV5leF3msl5JD3GJf5WIM2HHwjUulRvce5J7cedl1bVu5Qk8ajXPMVcgaSz8tJUiU
 g79aoDduGWO+gAUS0xHHdyH1AxX6fvgtRBfuqkDY9A+IQ/0O9UFDattxht1pMIdEpYhftXZESbz
 5U4DBZcLulmhQA1PEarRzxSzQ94UUL8/BodbbKL0w83x5BCO47tyO3VT9B+7Ef2LYoElwm6nPoH
 HFUijpcsPxSm0/Dg5pg==
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
>  tests/tcg/hexagon/check_rev_gating.c |  12 +-
>  tests/tcg/hexagon/hvx_ext.c          | 222 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/qfloat_v81.c       | 119 ++++++++++++++
>  tests/tcg/hexagon/v81_hvx.c          | 220 ++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build        |  25 +++
>  5 files changed, 597 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/hexagon/hvx_ext.c
>  create mode 100644 tests/tcg/hexagon/qfloat_v81.c
>  create mode 100644 tests/tcg/hexagon/v81_hvx.c

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

