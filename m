Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C9606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLKCCzmm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j99i0ISS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOj5L-0006Dw-8G; Wed, 04 Nov 2026 17:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOj5J-0006D6-0I
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:03:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOj5H-0007ms-GP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:03:56 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4LuBME1148942
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 22:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gbDk36pZrzgSv8UFAmRI0Kh75EpHejqlgM6yR7YwnPI=; b=dLKCCzmmDu+3QsO6
 TuJodYGzi8+YaEY/hxhQmK68sOmAT4pJUkCcW6aRfcVMA0s9mpuoB6+iS4J1Q7io
 1SEBIoK1jbTe+Vuc7laYOmSAi9Mu5V9u167ivINPGrjtJblutDGxjiTgdYNsqav4
 yCIYInj8FTgCYxa6KnhWl1fdBy8omvflf4SVmlslKEC5dn8oGk1l1dGIUqJtg9M6
 6U0+BclGS/sSjUuAPniOB1J/pzhe+dFXs2oikWqpZWAaZEHGoC4EIjgNZe5Q+o+S
 gF3Umt5O1Y6TgdBIF2RxNMmjfPn0sa93Y1N29Mi3qh7bX90aXYa6Zb5I40o3CdAi
 dc5pkw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3r82n81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 22:03:52 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-83edc5c5ae9so809620a34.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829829; cv=none;
 d=google.com; s=arc-20260327;
 b=dcjRLc0VQQiikb8Mnd1Xz0sePtxlu4GUUUjYMvrLbG7ZS5FwD/N3snDTV0YZb7BbQV
 NlHD+XWGpj7CIEDnV16YaHjfqNg5cJaphER538c4OPxBJu3ZxoPZYvx79xt8FkX0F9zD
 sqT7C0klO9vNDaApqkzTdKUFDC4bm2zDnVrHBx/LPAczHsdSE2ivnFYG9ez7LYgI3QZl
 F8oMddD9EPR0NlHYtRRaMkJnd4iEq3ffZ17qyhHDiQPrZEHPVCwamlxxz73L+5yCh3UQ
 MIzJjP8NYGAyXgOo1d5n0a3BqbnNc5FH59Nuj26NPzqr1a8RUs+BqnvjOyHJoMdyYkbR
 3Now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gbDk36pZrzgSv8UFAmRI0Kh75EpHejqlgM6yR7YwnPI=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=cuXlDL934YN+XYe5y/BWA1l6ifI5mQ4ehKSf4b4TvA7nsjxTdaCjgJliEy3N/gy7l9
 jpOt1+3BJ73vBOfFMDdRiUO/85k5LyghfAfv6ZX03Ap3H2JQjl9v4/cFYgnligmr5Cnz
 Jzv8hh/ZqO93aWrIHcU3CD4+snD7dBo9cFxjzv9XrOEkcnldK8U/Kn5utdk8RpmzHqcf
 1/gUjPMk8IhvHaJIq8BGh//pOIte/PXR1oOsf4mwMjRwfHsxfVVZluxHiliWOdOk7XbM
 xDSDu/ZV6nXGQmkfsWNkPKnSwVm0kq5Iwdyb4rCg0HUy9xx9frDSby7+mRCY0Uqdu8Co
 TgPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793829828; x=1794434628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gbDk36pZrzgSv8UFAmRI0Kh75EpHejqlgM6yR7YwnPI=;
 b=j99i0ISSGbtei9/HWMjW24sxmYGkV/i44J9+UiegblaQl9qmtGlRQoYwAL0rU/JDwD
 nMwfDmwAPBNetfWQa3Yo7YbEPjMZO1wrXlr1UYr8k6NWwFokeMN9SomnehswuCCaw1uB
 uMYgwKamALAclcWnh3QEDhE1orQ96fPLVbCiB/Zs9EwQHu4L1gxvZrBdampMg36Yh4hf
 fREkRsVg2e9F1qElHDGVgP7VjCjf12DJUf1Xdyh+MrMT4IdAxoeJWH3Ok7/pdcVl0/gK
 JcfYuq3ODOYnnN1HfuF6LLIympwh/8WSOu61erVVh8Q3bGcQg5ddnmkQ6Jk5M64ruiOL
 9I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829828; x=1794434628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gbDk36pZrzgSv8UFAmRI0Kh75EpHejqlgM6yR7YwnPI=;
 b=p+6bz/NZ2fjRNEP2i+DlhqT2054zB8JzTcHE/DxuvDGqNMXhb5J0cnau2VJG+i0fTW
 koPFSM+V1P6qBTQctOa62KN7Cl+HWTdsYVaWhgdVwT3GuY9PiR9DeV69YFfUkUSU0X5O
 ZaoJB0GXCU/KWvKFNY1tJboL1kX13Nu2tTeECCxZEYJmEaXh+6UA/rzMsp+UtkeXrEa/
 19xirvx7im4O5em6Ol/CYy+qnilUEDEDoQDpAz6bc/mHoi7PbdM2x8+EugfMX8sQtdNe
 KH+AGAe3j1T2j08hc3DyiXvVC188zE4ku8KdmJeRxLjvu4ogJv6k0t1ajcG1SKSupCmi
 qeQg==
X-Gm-Message-State: APuU4Z+ZgSWwPG0DLM26CAT2N55dRDWxifsfKYM/EFjXnmrERhwLyrN0
 gZgfmMGukZ3OzZ0II8OI3Bd2yVgOnd5NvMx4E+FDeCip6v+mXKVjO8EYNEruaTCwYDEWLFwrjP6
 RQWaQsQhsB6Isp5LDcfxUQdXdu9f1cfWLIi78LRtRP/VM95YXv7BvF7cf0uAtuQ86YP7fR+/+15
 ZNc4ILgO15aEB78Ok3bqpYAckW7DpFRIGV
X-Gm-Gg: AYBFou35wbQzpZTby3IhMdlhTEyCXtHP9ZOhmnN43QtSeu8Pn7vMv5ga51gtt2scUIx
 nkexqPJ5Fegt2ZwHMQ71YpyNm+OqJRIkx8S/jjoeuCUWd8RcZvp2sHm8wUwtLSKZ8wdjOprw4dc
 jqIPL8I/FEUqRG/+XcqwvLEB6w0IgvgQQkZJRW0IzyQGMI+8wst2/ANk2y3/L1cCWWlVCIvryvV
 uRYMQG4dcigWVG2Cw==
X-Received: by 2002:a05:6808:250d:b0:53e:8376:dfbf with SMTP id
 5614622812f47-5640ddeb467mr11480318b6e.40.1793829828546; 
 Wed, 04 Nov 2026 14:03:48 -0800 (PST)
X-Received: by 2002:a05:6808:250d:b0:53e:8376:dfbf with SMTP id
 5614622812f47-5640ddeb467mr11480291b6e.40.1793829828097; Wed, 04 Nov 2026
 14:03:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103192358.28589-1-anjo@rev.ng>
 <20261103192358.28589-5-anjo@rev.ng>
In-Reply-To: <20261103192358.28589-5-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 16:03:37 -0600
X-Gm-Features: AclHuK9MwR13jqljUVXU6Mp-T1ysfyRgkvXc0uH_wrkeQ-Xf60kqMWHjiixMyVs
Message-ID: <CAJ+KCYO+tFRRcgY+H9SrQAv9Xj+n_GhY-Ya449N9-u9n_B_BFg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] linux-user/hexagon: Reset hlx_ctx pointer on cpu
 clone
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: rqBL5Ub_Ez4WfPnp-9r822TwATqTrnGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4NyBTYWx0ZWRfX6DviHDM0hJL9
 CPLo42qVUvpKblWOveqiSmnDVjdmYdePfr11n98luunKfBg8iuVQvk2IgknIkMygSVfLYTKX2HT
 2SXloD5NMuQRI0gaka1S0a58ecp1wVTWDigWBFQpBy0jqAMjTI1D8TLexiYNIuUIMBn11r1p4Ep
 pr0HI/0tVrLOnwu2Q2s/7g1Yz1dRHChGmCJ5YwptkNI/OTptj8h8hr9c8zA+tcxOgK99dGQCjhT
 u+Tw7HUf4Zkvi0Y9Y0IwchgzidXZGeUtLno9zdBvzLxSBu4ZY+pkzHguVfmSaR5d4aUIFyGDmK/
 2/il/4kLTDbq7sh7BpsF3c7gqFoimXDrx/PO8mQNuhF7B0LUPJtbDsDPCnHwWeTf4HGIBky1GuN
 r1hQodHeJQmaSHAcPTsB0/CPEfxO8dLcjq07dvpuBpeYY2MZ9N57FnkGBGK54gzuryBNGID1ML/
 MsxcnxGfhL8GkpTgw5A==
X-Proofpoint-GUID: rqBL5Ub_Ez4WfPnp-9r822TwATqTrnGY
X-Authority-Analysis: v=2.4 cv=UuP2pOwB c=1 sm=1 tr=0 ts=6aebabc8 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=iJNQwNXsOhaXHjpXn9wA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4NyBTYWx0ZWRfX4z5zHXD3A9DT
 b2LMZiWtWT7icHOjtT+F04nOJRRJtxy6jRB5/RNdZv3kGuO0lzrtp5Ja8NmaRrRyRTquek247fd
 Pk6z6kK1vaFGoVrZOifEVUUBRNQoWaU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040087
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 1:18=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote:
>
> Currently hlx_ctx retains the pointer to the hlx_user_ctx of its parent.
> Another way to go is similar to hvx_ctx, which in user-mode, is just the
> struct itself rather than a pointer to the struct.
>
> Fixes: cf0bfbc338eaeef2b ("target/hexagon: manage HLX contexts through CC=
R")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  linux-user/hexagon/target_cpu.h | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

