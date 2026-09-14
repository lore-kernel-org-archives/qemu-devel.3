Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4DC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Clp-0007NM-4z; Mon, 14 Sep 2026 15:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Clm-0007M0-8V
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:55:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Cli-0001PW-TB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:55:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYdRg262605
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/ld2GI9r9FNdMvfPLdQXZA8p
 9Kut9Lfi6RUkiPs+uQU=; b=eXehmUeoC5ADp4Hq6xYOv6QO2fsMO45ldrwbkCEB
 nbaSzdIPzWJgSI/UiPyZTffQi2hEiVR/gS2ktHQJ7A4+dyfHZLT7T6t3QZm+LEJo
 5sQwijw+gum73oHhrk1kwlqLvEfj7W9298WC1VUkkwIXzISabJb1zs092OFY03J3
 AFs1EOnwJurQ8uxP5+Dg5ZD7KC3cYuMBC0MvWxppKu87drAqNYW3fhUxLgbTcrOi
 OlrTdDgjhdIUMsTzgsg4fxdAK80DRpxApx2QOjos48WMSjVo9i42rdpfCYKUrIkQ
 J3KH0mYaMDGjrkbXSmH9hnrhRg461B6pds2j7gnoSIHrZw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpergacmn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:55:06 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6c18e7d53b9so306177eaf.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415705; cv=none;
 d=google.com; s=arc-20260327;
 b=kAZpk4b7j2yi1OFvh1kiOy4anu6YPBcP2Q75gJe3fW0DARr/4teuuqVeZFLW4p13LE
 N8PlLeCqz7Rn6ISOg0/hXISA+HMQpEjZrfVNwWm6UgTaOeIriSa/Yfzi8h/C3Z7ctCB7
 lhgYjHemdwUevlcFpzuecFLHSpXExD94Plt3k+GTVB/+Jhd0ZRUOtqoLxW815HqGwci+
 oAMhYN/+oAQO9XvmsKL3EDXDE9xR7jyItflyujPUsvrRZ7CGD04AMBjr6Qk+eabzKl1b
 DtbhQGk2tt84fN+KuApuXRozA693C2P0b3ksE2aCoQZlWfVJyX6R6AN+RoI68iLVbbLd
 lHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/ld2GI9r9FNdMvfPLdQXZA8p9Kut9Lfi6RUkiPs+uQU=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=QVF2LF6lwW/zAudCV54+0Gx3x9/OKMb2A5qx5q3dKsDZJUvUWAT2W0MmlTiRZblXHY
 QZlJ0U0vKMgdXIKvglpcABPNp8PrKDH5c2VMjJW4yf9Q3WLxz6b4NAK2sVhJtEbtIx9a
 tFrl3gVvsoLeBbav6ndfDuNkyWc7QfL5va2HwHnqcdWvetGJ69CYJQp38MI9TOZSUSzs
 ghssd8dLrsZ/Crso/qiO8V7SpW5C4cd4ElAX34E12auwRovyWVe+CndeYQDUedK13FgV
 bH7M5WdAiI3Q4B75+jCm+aEbO4L0sO+VxyA4xx724o8GbNgnDwfo24DCQY1Ny1sONg35
 H6IA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789415705; x=1790020505; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/ld2GI9r9FNdMvfPLdQXZA8p9Kut9Lfi6RUkiPs+uQU=;
 b=F4+6JEpDTXR3cbOCF8Wl4XvM6QnT/wl5MeXLZSN/brwPw98BdD1p1jUXw90RJXOal8
 1Xjc34mfcfSxY0FK9fOiJKoy67Tn/pTd4uA8ntZth1oAAWGqqYZZUf1pq3+PlwsVgkP1
 OXzOvtMAZBe/gNgJraO9vRWbUFJGwIh2iaLmmKSkR0sr3b4tCvadWVOCQ50XiKSmj/bo
 +Iqerf31ql43XK4ZqgUzqPwZSPeZgAiTjPF+ggpoVVgGMjWsmDaru8AiLNNRVxttzb7w
 Mgfnsvm7EFwFmlmfPhfwEuEEc8zNBCaAAUxsKcfPGDP1eLVQf6T4JbmXzeaoawVUE1X6
 fgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789415705; x=1790020505;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/ld2GI9r9FNdMvfPLdQXZA8p9Kut9Lfi6RUkiPs+uQU=;
 b=yt/XU2CpcsmVZBNL/ENps6dffF4eWRCpT5WrBx4n8Uso03D9LFyE3pF/+QSFzwGWfG
 ADdME3MMR+fBMhtyYABlfwk7C6ghzFZbiYtGhf7/1ZhvnmmENMDnExVfegGB8j71OoZH
 F7TYyV34/XX/09gKVB9fptAlSC+9I9adFakCujXo9tRH1gZlVbbxc/SG4zL0IZZmM+An
 ZACMuEaJ75zPDPyKFZhFCYotUKXD0DwrGB6vy8x1eGwhYv3v7nsmFEZPxS6iD9LRUHQ2
 TbwdLCC4+lOp4A6NEWsMoItCxqTgLpNKLgIQfj6CYwFYr9g5aLYRquoVWAJfgWuTjOv3
 rzIA==
X-Gm-Message-State: AFuF++nla8mvfBuLqOwMQyGU7iH34gt7Syhhlb9+Yvjh9ZnlRe5YEDw1
 h07NweR2ozyjJCvYGGrhTf3plQmUibFc8bQUsV8rwKITnsJKUCDDfeNsb28xUR/gryRnhoekSTs
 +fmnjWVI+1D/LU4p1SscbYLOttmwK48wjqz0bwPmNqAf8rn8zSnGJmy8R+YN8U3H5s270bFfPsM
 /1UhAZRqTyHdOVXnkhGeKWOMM/OupZm742
X-Gm-Gg: AYBFou3b6wOvD83uTUoXL59WzLtcclHP4EmZTaYxsCKl6yhKtw+cWLoiBEf4Nk/Zovy
 6E7EFhfIXfj7eGZuzfl1p4nkNj+Gif7mry3nlD25Mb/Siha3ihV3tskjTgYD5HZn4p6zVhRYqX7
 s6O8sEOW+KmIEF06skjxPEtrsY11JJ04dMRphFI5Zh7tBJZAhlWEHaGlyO54sOdgPchSSHyhJ/U
 ou23CxgrrEXTQhk2Q==
X-Received: by 2002:a05:6820:190b:b0:6c3:5bdd:1740 with SMTP id
 006d021491bc7-6c6379f62b5mr507964eaf.13.1789415705613; 
 Mon, 14 Sep 2026 12:55:05 -0700 (PDT)
X-Received: by 2002:a05:6820:190b:b0:6c3:5bdd:1740 with SMTP id
 006d021491bc7-6c6379f62b5mr507947eaf.13.1789415705196; Mon, 14 Sep 2026
 12:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-9-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-9-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:54:53 -0500
X-Gm-Features: AcwNN1VQ0VwdurH5PhmBe_1Om33ZJaZ6mXa8KBPsr_fBmyYlZD_bS-K5okNKpJo
Message-ID: <CAJ+KCYNtwp-dBgaBnxVt7=wW6BOSUif2HLoOcg0M=97PP75BQQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] Hexagon (target/hexagon) Check for greg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="00000000000076cad8065b76cfa6"
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa8511a cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=e8ChnuIcIb7UfIZNrVAA:9 a=QEXdDO2ut3YA:10
 a=djaPdrTxQDvRn2H3e7kA:9 a=Zrk_TyTFAL8RANuL:21 a=lqcHg5cX4UMA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: iMqBTjpwlqymlQmkxh6mHfY8Vp7ZvPWx
X-Proofpoint-ORIG-GUID: iMqBTjpwlqymlQmkxh6mHfY8Vp7ZvPWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4NCBTYWx0ZWRfX/sz7q7zIsar5
 BwBPopA/a01QJDGaBzmgmNE7vXm2lb7WP11j1+YDzSuDLqU3cQciV5Bk9tULDkhIjrI5cKTJ57C
 8YXRu0q3dxu04T7j78390iC4r97Sx+kL8TIRLtI3IQ8RYLsQaJ7sezwajJp1UB5C20tJCPwiCR2
 CyS+8qst1EJRCwarEn8+9syJVZzEZ9iRaJUNdDiP2wdrg5VMs1KgUzP2Bfur1CWfdO9ajj/w6Pw
 HoSzNM4j89/QqWUqwDamBMRGNrXuY0JjSQqaSw4CDmBJTOXDFKojYqCOyRO+3RtmWzrDn5cH9/v
 12Zeowt5rvaY6w3MMhLVkz3zUZChOyLSFBwn6eWz2eohsM/XT51T2HbuJAskvR8DrnQGdG77n/r
 YPLmTbKfZA0LyXEhaa9psd10QADTn9HbGhkdtnd7nSX1IR8/MxPWnW6A47YSEvqX8UaZyY8YrWz
 RgGwVkte4Nr0NYKYdHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4NCBTYWx0ZWRfXyr8ssADWIZdv
 tEldnox3Mu4SfuFnz/7kYoQY0wjYU+tAbuVqN1fyS9LpyzOIGb4L7RbTh3tOjB3yrR9QNfuyEsm
 q3XCzci09kh0rx0xtVHnUVHuGL+yZss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140284
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000076cad8065b76cfa6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h | 11 +++++++++--
>  target/hexagon/translate.c |  8 ++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 815eecb60a..f469452daa 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -575,6 +575,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
>      bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
>  #ifndef CONFIG_USER_ONLY
>      ctx->greg_log_idx =3D 0;
> +    bitmap_zero(ctx->gregs_written, NUM_GREGS);
> +    bitmap_zero(ctx->qregs_multi_write, NUM_GREGS);

Should this be `*g*regs_multi_write` and not `*q*regs_multi_write`?

--00000000000076cad8065b76cfa6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson &lt=
;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&g=
t; wrote:<br>&gt;<br>&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mail=
to:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;<br>&gt; ---<b=
r>&gt; =C2=A0target/hexagon/translate.h | 11 +++++++++--<br>&gt; =C2=A0targ=
et/hexagon/translate.c | =C2=A08 ++++++++<br>&gt; =C2=A02 files changed, 17=
 insertions(+), 2 deletions(-)<br>&gt;<br>&gt; diff --git a/target/hexagon/=
translate.c b/target/hexagon/translate.c<br>&gt; index 815eecb60a..f469452d=
aa 100644<br>&gt; --- a/target/hexagon/translate.c<br>&gt; +++ b/target/hex=
agon/translate.c<br>&gt; @@ -575,6 +575,8 @@ static void clear_pkt_ctx(Disa=
sContext *ctx)<br>&gt; =C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;predicated_r=
egs, TOTAL_PER_THREAD_REGS);<br>&gt; =C2=A0#ifndef CONFIG_USER_ONLY<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0ctx-&gt;greg_log_idx =3D 0;<br>&gt; + =C2=A0 =C2=A0bit=
map_zero(ctx-&gt;gregs_written, NUM_GREGS);<br>&gt; + =C2=A0 =C2=A0bitmap_z=
ero(ctx-&gt;qregs_multi_write, NUM_GREGS);<div><br></div><div>Should this b=
e `<b>g</b>regs_multi_write` and not `<span style=3D"background-color:trans=
parent"><b>q</b>regs_multi_write`?</span></div></div>

--00000000000076cad8065b76cfa6--

