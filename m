Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20453EF8FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxock-0001WX-8x; Wed, 04 Mar 2026 10:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxocj-0001WC-0m
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:58:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxocf-0007C5-Vf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:58:56 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624DAQkf1421868
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2026 15:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ktZ49vw1gKwqo6ji8I/Nnd/o
 KXPagoDTzo8pU7nLIfE=; b=Lr+o19fX2GnyXRYE5edk7Mp49cPOFRNXVgoHQ1O9
 AdUAMkP/BMmNXvEwKIDy7kLRyp0t4L331+o+7O/U5N2vuCZLjZFECN46TECY6V+4
 54q+8qainP57MyX9zD9IXTcqBMF1pNg9FiQqMGxABqyVNuLz3FvThJV+hNJLYVtr
 cXV5+3Vgp78GlrsmMLizdF4g9rc/IPnVuapdjypc7PWQ/vv5yQtpIw2trE8KrfqI
 rDD9SMm54EvcilsIRMj996E8P/28K/XrylzPW6p+P3Ivz/J4jOlwe5bfOgNxsG//
 P+L0A5mOMTfDHGP8oVuyFadNAASh+CFWQT6EWKQXS583wQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpe8u1yqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 15:58:50 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79881805767so74429537b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772639930; cv=none;
 d=google.com; s=arc-20240605;
 b=fyplyC6VT5M/jf6viuZzNcDZ/Q95Atqoi3xQ3a7e4PrV6VaE6T9FFIqwdDl7bAAyKl
 V3eb9bGBAlegROIhHnTp0iE/2gGeNgIQLFA1twu8lW+jb38Sy1X+ML3TVabdXiMOcOmT
 aYya07tdF/BqjXEvT4FeTzpl0BAttsGAYo/jM2xI0UJ4D7E4cf3AHa15UNtsMJi5IYYM
 pjGlCBIM7rGFPSGh1mpN0lH62vC3wKPri3wTX6VUM2F+rUJeG3QJtMMrP5uKer3fnoym
 5oELAM31FnZ3yg821zHdyW+S2fLsz9sIeFsCvMeAUpR9KtNFOEQlvrgtMSVaHBt1DKe7
 3aBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ktZ49vw1gKwqo6ji8I/Nnd/oKXPagoDTzo8pU7nLIfE=;
 fh=d4znsSXZpCzOW1zLdZJM7PLBsdVc7xqkYVVjtCgJLzg=;
 b=P/xDeTvs+kIEdt2L8DLipokkPJF942d+qcuWfFL83e0bAO84/RF3odIRrhrAG4w5UR
 4kzR2gwLmFjGSbojlqguXFyjHAuh1eidzHawdmkxTk+He09C2pGl64HrXw6FebLkWCzF
 0jFU8QY0eD9CSrPUtFgbXpib8IvntHWie33S4u3fudcEKMs/mFDMnbNLXyxvwcUCsDXx
 R2qAssF3m0xxQ4/qatCN0Inu+QYHkrtaLT2m4N7zVD61mEkdR8ZtJBmufPWJujxEsRtA
 bStmoSfqjTR7crOg0uEdWqrPhKTK3xIS41QZwZhCC3h5p1LWvkl9n7z2inKRHXLa07UP
 0V9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772639930; x=1773244730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktZ49vw1gKwqo6ji8I/Nnd/oKXPagoDTzo8pU7nLIfE=;
 b=UV/9XVfwyffLjvK43vKwJtwtDJsRIGTlMCGPJMVLSNeQlkW9v/7F8LNFe89jwwtr6L
 5+b/VauuI9SafnUx1R+32y0YzSxptSRT5PjexAjtQRKASLlM5S81twSrBo7zf2TN4/Sw
 GQnW5r7g8Xa+rmz3HtZ7Hf0iz+6vOyVo6q1xJZGH+tEMPX0j95enalbLNimWPnzEKeTm
 zUeE9kKBZOfTa1gQPJNgawaKVYWsiFXieU35klI/CNgMfnQItvg7r5x2svFH2Tq6Jgzv
 ENPqi+Hgw+isFDtnuDv4QC5AdFJLFaLFf5RrL5jHh2L4eU/+SUWlQeC26ZHY2IRbFhdv
 +WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772639930; x=1773244730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktZ49vw1gKwqo6ji8I/Nnd/oKXPagoDTzo8pU7nLIfE=;
 b=kOa7ihcrrAkiu4uAcC87DfGbAkxkLYkPulp3u3D3aA84yIT76vBcAGE8QEu9uZigX/
 cPqDZ8T4bTzbix0qUW+poCNYEbrjclF9APEyGPFNF+mx+gAjQuyJWa09pUmtqpCxx2Pe
 wEYVp2UGioSAmsGYZ+Y2KmPncQ9cI/Z4JiCFTslMZ040W17YQrrSpZSWFtjfa4QcH+yI
 VL5V3Tok16/ZZ2s3/N6diC6nuglTtwvLeNknyFzIXwP9KQ5Z4c1fh0vun3+7Ue6sTYdN
 9VAC+tXr+EFwTmvAEp+1nN59JwjgoAwPOxlG8i7fP5b9XcFzuFVGoSv4J1mzW+UAMHst
 MdOw==
X-Gm-Message-State: AOJu0YzKQ8tjGqD40/l4XQxTJXSswMS73lhCmwLuaGeu7usCFEPVFqEw
 GhRO9wPnrSH/xj0ptqflnDh0mfafXc4mSoD6Z7W8nZfNgSWxW8+wh1xylXX6PwYQBtdX9OcnMwZ
 j1HTCgeg742biK60n8/wyRTmvuPyfiPJyG+6D24auNAse7I1wthbeHQHvDzPDTclYgt2Y1kLKnk
 UPBsNHNvUAZQxAT9nqrQ07avEMN3ajE86g
X-Gm-Gg: ATEYQzw8np+NC9CTmnjLG7voRUD8or7kx6EFTGSB3wuMm/Anlk0CMlqmcaQ0Je5594J
 6IviswQOr5Oswiy/Xw4bfun2ZPhJgAVTj2q2A2L3yxi7VtnuCwkwK2pb2sarU3PP+jwzxH4etbT
 0TrgowO4gyEnqPZTeJDWH2AmexGqYqcqpk7FTG8gtW0Ssme3X8uBgiiM1D/X5hvpEdv8Oamv/Uk
 wmiOmg=
X-Received: by 2002:a05:690c:385:b0:798:65eb:aff5 with SMTP id
 00721157ae682-798c6bb0892mr19108347b3.8.1772639929882; 
 Wed, 04 Mar 2026 07:58:49 -0800 (PST)
X-Received: by 2002:a05:690c:385:b0:798:65eb:aff5 with SMTP id
 00721157ae682-798c6bb0892mr19108187b3.8.1772639929358; Wed, 04 Mar 2026
 07:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
 <20260303210553.2044313-2-brian.cain@oss.qualcomm.com>
 <87bjh3ps0l.fsf@draig.linaro.org>
In-Reply-To: <87bjh3ps0l.fsf@draig.linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 09:58:33 -0600
X-Gm-Features: AaiRm53WkGmWf8dfh_OGr4245qISbzGawLP9qKfFjQzL7bPBzbXrt8gseoq7a1Y
Message-ID: <CAEqNhNaXFb1nn+yhJ94od75XFpx=igYRYfQBkztKreMo+-91Pw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tests/docker: Update hexagon cross toolchain to
 22.1.0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, berrange@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004df0d6064c34e550"
X-Proofpoint-ORIG-GUID: fZc2fnViWD1pvtk9du_yvQTwndfKmWg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyOSBTYWx0ZWRfXwJSsVgsqy9Zw
 xQQMgvDchaDqKrhq4sx3bBPEJD+v9yP87zCk0/DgWoLvMN9CCizU8+hqS9aTipqwtYGRJ7tKt+K
 yjR9uOSGfff5fPbd8AmEpwZDGqiMN59ARhSPOI5Tmy8TWIvMqZSsU7g9Q8vyEGvwiR//27qEG0Q
 7VTL1OuvbPJZsT2hDBzIY00p9xviniCLBWEbq1BM/IEKu8ZmdDyFTP5Vl8JfazmACN/lc41QiKk
 ukMfKo7SC1QcEgVdimkcK0uupAaVOMqpE2J64JgdoqWhkbzROsF8ALx2s0RmHpXe/gwQWJMokFv
 sVyvzR0dVJRcpL2MFUktzwhxb057dqbMGyYUcSy/LdAhCPv43ODG5bdWNlQG1Oye+fXYNttHlq2
 +r4NLnFWdT33jhT0tHfx4mCSuJ2oB+sz5664DDFvEYpH0iZXxIelMKuPZjqB6/LbNcEzV//t5Of
 jPMYiW0x9pU6aaoEIOQ==
X-Authority-Analysis: v=2.4 cv=FpAIPmrq c=1 sm=1 tr=0 ts=69a856ba cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=qC_FGOx9AAAA:8
 a=-xXSUO77XZEE9VOigQ4A:9 a=QEXdDO2ut3YA:10 a=CWF9k5F9zN4m7vfhv9kA:9
 a=x8F-H4h0xVcPpkm1:21 a=lqcHg5cX4UMA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=cvBusfyB2V15izCimMoJ:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: fZc2fnViWD1pvtk9du_yvQTwndfKmWg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000004df0d6064c34e550
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 8:51=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Brian Cain <brian.cain@oss.qualcomm.com> writes:
>
> > Update the hexagon cross-compiler Docker container to use toolchain
> > version 22.1.0, replacing the previous 12.Dec.2023 release.
> >
> > This requires upgrading the base image from Debian 11 to Debian 13
> > because the new toolchain needs glibc >=3D 2.34. Additional changes
> > to accommodate the new base image and toolchain:
> >
> > - Use DEB822 format for enabling deb-src (Debian 13 sources format)
> > - Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
> >   LLVM-based toolchain
> > - Add zstd for the new .tar.zst archive format
> > - Replace pip3 install tomli with python3-tomli system package
> >   (Debian 13 enforces PEP 668)
> > - Update artifact URL domain to artifacts.codelinaro.org
> >
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I assume you will merge with your next hexagon PR?
>
>
Yeah - can do.  But I'd prefer to put it in its own PR just so we isolate
the impact of toolchain changes from anything else.

Can you review Matheus' dirent64 change when you get a chance?  That is
required for the new toolchain.

https://lore.kernel.org/qemu-devel/af31d21c4d668cfb940ba4159f584fa6454c3d82=
.1772107448.git.matheus.bernardino@oss.qualcomm.com/



> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000004df0d6064c34e550
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2026 at =
8:51=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.o=
rg">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt; writes:<=
br>
<br>
&gt; Update the hexagon cross-compiler Docker container to use toolchain<br=
>
&gt; version 22.1.0, replacing the previous 12.Dec.2023 release.<br>
&gt;<br>
&gt; This requires upgrading the base image from Debian 11 to Debian 13<br>
&gt; because the new toolchain needs glibc &gt;=3D 2.34. Additional changes=
<br>
&gt; to accommodate the new base image and toolchain:<br>
&gt;<br>
&gt; - Use DEB822 format for enabling deb-src (Debian 13 sources format)<br=
>
&gt; - Add libc++1, libc++abi1, libunwind-19 runtime deps for the new<br>
&gt;=C2=A0 =C2=A0LLVM-based toolchain<br>
&gt; - Add zstd for the new .tar.zst archive format<br>
&gt; - Replace pip3 install tomli with python3-tomli system package<br>
&gt;=C2=A0 =C2=A0(Debian 13 enforces PEP 668)<br>
&gt; - Update artifact URL domain to <a href=3D"http://artifacts.codelinaro=
.org" rel=3D"noreferrer" target=3D"_blank">artifacts.codelinaro.org</a><br>
&gt;<br>
&gt; Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@l=
inaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcom=
m.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
<br>
Acked-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" ta=
rget=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
I assume you will merge with your next hexagon PR?<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace">Yeah - can do.=C2=A0 But I&#39;d prefer to put it in=
 its own PR just so we isolate the impact of toolchain changes from anythin=
g else.</div><br></div><div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace">Can you review Matheus&#39; dirent64 change when you get a ch=
ance?=C2=A0 That is required for the new toolchain.</div><div class=3D"gmai=
l_default" style=3D"font-family:monospace"><br></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace"><a href=3D"https://lore.kernel.org/q=
emu-devel/af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.b=
ernardino@oss.qualcomm.com/">https://lore.kernel.org/qemu-devel/af31d21c4d6=
68cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcom=
m.com/</a></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--0000000000004df0d6064c34e550--

