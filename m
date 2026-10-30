Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnmPZTby;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVLuXxIh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMbQh-0000gx-Nj; Thu, 29 Oct 2026 21:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbQf-0000gp-R2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:29:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbQd-00082l-Ka
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:29:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKN901530125
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MjLHi9XI4SQmX9rK74/0E9bFPkWOqjilg+HFoVwuiOg=; b=cnmPZTbyWg5wAvsN
 OfC8MxCyB+VnqkjwDvz96vl3BYw5N9xcoTaUS6KSfS5ZfXKFyOlLggzsnxBELK5C
 m8fwzYlyW56VZflEN9Zy0TKpgupdt5oko13kqVrZQ1Yxf/GvhuyZqGYOO0rIbeb9
 HbARxyQdnYadBlosL/kFzpeRl1YkHEpmw3yMlBG+FqwpWsNQ3+/jHB9UG0dI4wj8
 1oGPezMIEkW58YkumUPUW+Sb+//htvuWR3pIuDCutmTPwd2EDlILOYkbyoZ/uOVs
 0agM2pGSzxkm5Gp+5ph/sWQ3GBaWxmJVjLyFOgjcRbhQK0yiJjjYwYnI0jZ97ZgV
 AcYitw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgmpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:29:08 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-54dbbf252cdso296464b6e.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793323748; cv=none;
 d=google.com; s=arc-20260327;
 b=MwyAVET01wG8XUVA5tZgBZ+Azzq7JZvJcw7U6oLMPJGK/a7Elcu6IKokmyRsOWO8V8
 EzLwjnoOk9WhbDBQoO9rRx5vur8yqzybceIauwnSkcTLxL/m1YffDlHswI4zK08aXHdS
 ylhHu3YLogCzErP2jgcz8tViM8OQWreqL6I+E4pXINrRE7MAbFMdpwSuN/OAiwigxea6
 a9xJjOBFbW0Zss/C7MIRSiWkuWz6WJSFhP0xBSrsxNzontJ7pC6736cwHUp7yam+TBt9
 YUnQri63LKWUkQ+fhy9x1/qFB8G8pugtCEpYB05aOtxRcKxk93M5KjS+pj19AbjADOwZ
 C8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MjLHi9XI4SQmX9rK74/0E9bFPkWOqjilg+HFoVwuiOg=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=rTcFMa60KC8/L6e3e8lNCv7VXTD01s7/MVkJ4nCAUyaqdYFvJSv/gXfBSUqJ5gv2gc
 sJs6MZUiVGHqWSmlMbEazinZYiQML4L3w3CCge9/AdMtpL5RWpkfYQT3HqRw6L8v6fMB
 vR14HB26IV2IqYdwInRD4J3FejhWybgs7cjiCi6b9Az/B6jGHpSsSLZgwajIIg1P1oI+
 ZqI81ka8dRVAjFuOYReTzG7u3IyHiymuLdsVB4zlujIsGIdcUXSfHc6K+EnqR0sbkaHm
 mlfOBrsosRiroyk707HvsmXnqzkxXaoU1VcqeuIE4AHzJObyM3p6R4YhlVJRgN+rfvGd
 58oQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793323748; x=1793928548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MjLHi9XI4SQmX9rK74/0E9bFPkWOqjilg+HFoVwuiOg=;
 b=PVLuXxIh3B9JmJkTICvgeTRYKD5uFC+RXylP437VxjFsf7aLlXiTemsR0aaAd3C3eW
 FWTIXJ7SehCaojefW1DDI8uLe+kNhW8Ys1YzmsWCKVXneHMd9+dtUPVlhKNvkYVIPr17
 iDxoQcmeFSH0UjtscFAMukaeYrtqNMMeYrzchnKiqHqPwoK/HeACwg691nctemwJiCsQ
 A5k/ekRd0cpDVDbeS2m8ZG4qeKIQbumoi1PeYK1bpXLNHbrxkai/VE5lCbXDw9s91bfL
 3rZ/QqmfooyNLoO8mRebqfbiIYkgfvrmkSPu623yFKdAM9BzQG88EJBzeYEp6jr7YMaS
 G6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793323748; x=1793928548;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MjLHi9XI4SQmX9rK74/0E9bFPkWOqjilg+HFoVwuiOg=;
 b=eCFChb4oIlX6pwK+hFcqT9y33vbrpubdDRp3Al9Je8gYhyB9iChsQRRkFGvinesyPq
 ZyALfdmgI+jiK7NNzLxgI7FvX0NxY6rE8nUAqriTsAJJ8jnacO7kbOtRmJZ/3U2M4Fqu
 ys4Sv7yIqS0FD7iG4IjTHyNhkBdqGDRwBEwt+1CnVycVxqzKTwWWF+0XwdVtGNGp2D61
 7zgakHM3lIPGDI5MTheYuQcmOhF51vrUSnWWdvCqPJOp9zJi0XpEafbM0YuYhizDEiib
 1uo7pRYXUyp0MPiGgJkRoeh2ljQSvxqT114I/WVJO7DePE6QIrcmr4+lsYWxu1aAJGBt
 IERw==
X-Gm-Message-State: AFq9FYL0W3FLILhQxGu8Y1+Of2tJnp14KklMNur0YNXbxqwAsLol4jUD
 Ghxjbz/WmGE0S82I2zaKoTFwpWsgS4sh4h3mPXXQ3Owa1ldpTBgbN6jiDgba8NbqtPZ91tYMpMp
 lYnm+B847FWOzgKhNJoOdHd2kAEWHFob+IyR4jolJFM8hxr4fokv7ft2GkmeYDWciTQgF/r5NTs
 VPCefEqzWxKLKdwZQT3yMvP4Por2uGP+bN
X-Gm-Gg: AYBFou19KsY0YDVHmkz5z2/pimvxpx7WvEGm7EQjI9qMf1NG3XJuyqSrab6znckX1PY
 ZyYZr0G74jvLyEP5Jd6vpGv29ftnJLkv0QOHiAxu83e94PsalPZlGnVg5nJ2doi57+36nlDRq83
 fARQhQpvIUwHhQq51KYhS3q8QzMNAZEyJ+8JM4l93bb1ngK/JFb9PBJSQqlIaGw4jvxuz4OsI95
 sQFRBkW0PWoNMJ/qSA=
X-Received: by 2002:a05:6808:1811:b0:54f:ee4e:51ed with SMTP id
 5614622812f47-5640dcb8774mr755926b6e.19.1793323747767; 
 Thu, 29 Oct 2026 18:29:07 -0700 (PDT)
X-Received: by 2002:a05:6808:1811:b0:54f:ee4e:51ed with SMTP id
 5614622812f47-5640dcb8774mr755903b6e.19.1793323747220; Thu, 29 Oct 2026
 18:29:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-5-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:28:55 -0500
X-Gm-Features: AclHuK9fRdvNp5NPi-Z-GD1yinc5cdj2yksmq9e_xMjc8uLdoerRsuskbjH2AbI
Message-ID: <CAJ+KCYPkOvjksBpeCaECZwKyjvTaxmEx2UzQMo9Y5n71ahdx7Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] target/hexagon: import HMX instruction definitions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: eR7ugSIYqUJMwdyScEw2PkhgLwgZEJWA
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae3f2e4 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=7np3Ac_fZ-WTbpGUDPMA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwNSBTYWx0ZWRfX22Pe0pqKZV6u
 nFmG6pwPIpFjvnje0Lp6yUMfScRcJj2dGWA78DpTlPfkSs6qXQEBnCppZmnkFzpk2JWgkJu4gsh
 fGyGMNRVAagv49/cV7dHFzA1shRwCTMX/ENUKwjuMZyqLNirCd9hdyoas2vYRsH+GUeBMtYVPbH
 AMvHUmk5k8RsEpzCTFvGqOwjBNI4n3hV5jX9RPGT3wuJ2EWBsWNjldDZMbIrebZI3lOglJANjlM
 HgKIN55VoQZgpPT6v+VdbGku+Bj6Y08qRGf5gMemWWZoYxyaOhj8KBFSwMvqI0K/yM9ZLl2kk4a
 ErYGvMMnbdDlnsdjGvF0n4SDzmiYXgSpAUz50tRG+i5mcejZ1Hxn1WyQsGyCeSiPnIKpf2gTM6l
 2OHaxjfnL7JjEq8xW+iOZyP8QNz8ZFz0Y6rXYsrNk18+GvlwviG5tB8NoW7hQX/PGnl430kJnhv
 Kr7tkrGQCdfHmW2WDHA==
X-Proofpoint-ORIG-GUID: eR7ugSIYqUJMwdyScEw2PkhgLwgZEJWA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwNSBTYWx0ZWRfX6lnF/LYwvAzF
 zNh/WPLyrLMLhdjUPMpzYJlgH0Ncaw5zMwGY/BZR9XKJX8sd9NXauFcGxg9iFQ7DvjrsLfLYJIS
 LDcnqHzS8+fnXD2GeWqu3ePX+FLlUi8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On Thu, Oct 29, 2026 at 6:03=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Import the HMX instruction encodings and definitions.  The semantics are
> no-ops for now.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/tag_rev_info.c.inc          | 247 +++++++++++++++++++++
>  target/hexagon/imported/allext.idef        |   6 +
>  target/hexagon/imported/allextenc.def      |   4 +
>  target/hexagon/imported/hmx/encode_ext.def | 149 +++++++++++++
>  target/hexagon/imported/hmx/ext.idef       | 175 +++++++++++++++
>  5 files changed, 581 insertions(+)
>  create mode 100644 target/hexagon/imported/hmx/encode_ext.def
>  create mode 100644 target/hexagon/imported/hmx/ext.idef
>
> diff --git a/target/hexagon/tag_rev_info.c.inc b/target/hexagon/tag_rev_i=
nfo.c.inc
> index da0b1a648cf..5a57d66fa45 100644
> --- a/target/hexagon/tag_rev_info.c.inc
> +++ b/target/hexagon/tag_rev_info.c.inc
> @@ -620,6 +620,253 @@ static const struct tag_rev_info tag_rev_info[XX_LA=
ST_OPCODE] =3D {

Some instructions have a wrong intro revision. These are the ones I found:

Marked v81, should be v79:
- M8_mxmem_blk_sm_act_f8
- M8_mxmem_sm_act_f8
- M8_mxmemu_blk_sm_act_f8
- M8_mxmems_blk_sm_act_f8
- M8_mxmemd_blk_sm_act_f8
- M8_mxmem_wei_f8
- M8_mxmems_wei_f8
- M8_mxmemdr_wei_f8
- M8_mxmemdp_wei_f8
- M8_mxmema_wei_f8
- M8_mxmemdi_wei_f8

Marked v75, should be v79:
- M8_mxmem_deep: mxmem(Rs,Rt):deep=3Dcvt
- M8_mxmem_cm_deep: mxmem(Rs,Rt):cm:deep=3Dcvt

