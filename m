Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24507EFCE41
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsEo-0007Ml-2K; Wed, 04 Mar 2026 14:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsEm-0007MQ-V6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:50:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsEl-0008PA-9b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:50:28 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624H7r7D1455832
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2026 19:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wyN/4BG/goUjV8dbqPdC6LOW
 aej4FAtxjiM6Y0Qspc0=; b=Zt+PXiOcNvR/lFkjwFT/bImA0whCmI8fG9uVpyFC
 QiL26n3jl5IYf9/UizSIX/tZASl/2d/wEHa1YlbulPCyiE4K+hr1C/3c50ihV/wR
 Sh/YH18zdtKjmI13UDSy/n+CjKWIbZTpIgcWTmJ7INu1M0R9t8lgdMyFWUlrKX7F
 I8HfI0etrpBeNlDCzuwm/JP4CGkuqIn3HWQ0VJtI95lEanKAqX55+m0CMneLvvm5
 1o+4M2AUF6MfE4ouy10VjxJNfggPNltlCw3i2k7DQ1Ca9JXToldK3FTONwk3biIJ
 j/F89jAPX/VvUxA3K3kOePhiKTY2DBtGJsvxlZWZM5ckEg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpj181xe7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 19:50:25 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79832285fa1so129576567b3.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 11:50:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772653825; cv=none;
 d=google.com; s=arc-20240605;
 b=WOU/v4cGFNcHzgZMkz2jS53lfq67KJ4EUbtXOqyPdV/jAaI9zHIuWFbh3W0z+POSxZ
 rOOVhSJpijzYbv008k/nbiGY5vWCfnCJmGOo8BmfYedtxohyPEgI4WY+PAPvb2mwxU8s
 3MpEN5VL7wi69zEVwL5XC/eRKfeKTwKmOsVV+aT430JNRFx2wMnr9+UE5vO3ZEQjd1vl
 3EJ1GDAufzibB8d9fcc+StXw6G+gOTQSXG1z0IF4jK3LbiTRZcIenHou5zBWXvh911Ln
 VR8YToUJ2iT02P7wBrZQkypYtziKlNUmxW3akPtWcoILY3UqcqxyuRSiqh8/KwcTBeax
 WmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wyN/4BG/goUjV8dbqPdC6LOWaej4FAtxjiM6Y0Qspc0=;
 fh=ZkF59/h3jLPv6skd/937d0ggkzu/ZlJAFr8l0a5NQas=;
 b=H/S3D5dfNfM5j7wL0eNA4Vsov80CxyyEERWTVK6JkYE2CyuR9y6ai+0JUlokmajd+n
 BYQVT3Ss9WQXh3psKLhx8m/liRkskKNB1Nm2w1XV1D85TZzd95+LD/RMOsSdRFlYe8bL
 EHTFBGoTOS9vm8KXKa9I1igSS6huSd8dZIs6Mvg51ApyGOMH9NcBEckOr3RJMH1+n+Gl
 El3/O73gG26IT0MI0Jvt5Loz5k9c0tKi8Jhz7OEgvteF2dsZwddovKvasiEEHW2rkxF/
 XjhMRLa4tyjLxk2ffZ2t08sHs1PzmjKMTRHNutSrTUsarncssHyKQgDIaemr4xz4Mq8j
 sTWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772653825; x=1773258625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wyN/4BG/goUjV8dbqPdC6LOWaej4FAtxjiM6Y0Qspc0=;
 b=J0PVfPjzPdyvtyL9E4c9dbIgamTklKaohJ3GbuoXHhaqxS1sdCRg7cagA9UJnCgCZQ
 Q1YFxWSIPEcI4mfI3QQI/bApBLe5laeFwicce4DM4NUHqqXQu/qVpmGzt6zUi3cimIz2
 0zqPV7G2jfYgRiUr9r10ckPARORgF04U2HFEYXFTbQZjEJTSalqup43dlYWc93Vn3cOc
 O1cYnwx6Eu17Tv/3o8oSKl/6GXVVXeegMJfrCTd/0mFcdWS/v5Of9DHja5AMd7w41GmL
 uBl7692KvC1ND+9zSp91Tirf36vOIWDL8G3TyCGL3RBHXbFhOutKweU9+kNV4YoDmZYR
 NURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772653825; x=1773258625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyN/4BG/goUjV8dbqPdC6LOWaej4FAtxjiM6Y0Qspc0=;
 b=QyRw7bLJj87vp5NUvzbqxFdIQzPZc9iMfTjlV5GJMsnvlsPVPxUykpg44sLU+Wz8Wi
 K8uH1v585thqTCRl57p84I13sKVkaObLmWEM87ZuEgdYCHCaPRv6rdgE1tzjcyOgxMUI
 anRYcpS81R3707Z3LlBGL2PEXTELjedyD0YGAnqothS9jn/EyNGfGkj1+jGpSSHibaBp
 b6f+f/N/j19kIgc3D2ndlKOJ1WHr8FORxJMbZAgOvL2HbVpcJNlf7wOHbuX4B9FbK+bz
 DZRpzxbRrexEE6WYTw2O47W2Yg6h1xz5d6Er+xWVVGuO1Xih7qPRkX19O26Kw5EemxvR
 HDIQ==
X-Gm-Message-State: AOJu0Ywxmpn14y2ByjqybeHD2e87x4LVrdQ7dkHEeGyyD1hnNFpXTpR6
 cKziYZ+Jduh1+kHS0UtqZRzq9HdgM9emDm4Lt7t7UrVY8OBgLYTcxcfanQpzT4FyDnk1tz3lE0B
 etDCnJm8h32qYmXfrWhrf5wKZSEjRdLLB+BB5i7T9GCC0eeGM6CkszWOOya7TKOwMjIt+x6rvW5
 KX20nKGh3HXnUJHeYKHjZNtDPQc2cY8tdI
X-Gm-Gg: ATEYQzzL/pxdb1tNSHWycZLM11alJNDrXEcgEc5/VN5Tsk1HWY7OMfPunt3wSoJ0SAd
 5krNcWYrW+KUxPNJZYgyHTu2PGLLS+6Gedm3o4u12ZopQZboFAlZHBypSgP3936I6GRSEHqS/C/
 TzYRUAK0A8nK3MxfV2OdwUwzfeZ1rn41/ZQuNEQsPKPOeI2jGuLi7fAWxYYW+/V03ukXvdSqI/h
 uPwqYI=
X-Received: by 2002:a05:690c:62c1:b0:798:7ab2:eb8b with SMTP id
 00721157ae682-798c6bd8d4amr31437347b3.1.1772653824947; 
 Wed, 04 Mar 2026 11:50:24 -0800 (PST)
X-Received: by 2002:a05:690c:62c1:b0:798:7ab2:eb8b with SMTP id
 00721157ae682-798c6bd8d4amr31437127b3.1.1772653824550; Wed, 04 Mar 2026
 11:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
 <87tsuvo509.fsf@draig.linaro.org> <87o6l3o4yc.fsf@draig.linaro.org>
In-Reply-To: <87o6l3o4yc.fsf@draig.linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 13:50:08 -0600
X-Gm-Features: AaiRm50kcMSBG44KZsLxg9CLHtd4vDh8Dv_063kUXe_QX3GA5QnzfkeEbXL2KUc
Message-ID: <CAEqNhNYMuskrQ4-mnQxzQAthvKhZVSVnjNQO71O_ExWzVBcFVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Update hexagon cross container to 22.1.0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, berrange@redhat.com
Content-Type: multipart/alternative; boundary="00000000000085b501064c3821ca"
X-Proofpoint-GUID: bSniTft0eoTUxgrw2VnweVKWUwD7VWGh
X-Proofpoint-ORIG-GUID: bSniTft0eoTUxgrw2VnweVKWUwD7VWGh
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69a88d01 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=N-SiO541P3_EnR599YAA:9
 a=QEXdDO2ut3YA:10 a=FvBX37Pc_9MEplDOwHEA:9 a=dXOqwp3O5lLdEZJw:21
 a=lqcHg5cX4UMA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MiBTYWx0ZWRfX4jRxkTDbFZ71
 J7oPIUGde8v2SPhZaNCMMjMxagYtz/QBQqEE6NFb22Xj9bgGt7pq3lmoXzDm4xNfKkZLFeBtRQ7
 rSaSfxVZeJ/XAl2Cp33AR2FKY//OIjNMHVoZ1SI3fEkagqsCAdzyzwpQ2+kTGoWhGKqIGWdoeXq
 d1Bc2/olWTMTh367oMZRGp5GKKQYPy5J70ToNFtEC9gwjUkVXb1bKbVD6lTc1+K+u/Y5zSng2R8
 WPKMKfOqPC+gbhV5kamHMVri9nufvCJcb8G65bujHXsCNmy/rucxLycKqrY6c40o7bcqk73L2VX
 piKcjizT+PDywk1VLmn9ZI8oMZyDypkv0hIxxzsyg2AoEGnOEKdyNYkno0PmMZUQ8SnQfaMVoZR
 JUwX+J80Pd+c+l5hP/298QiI2wt9X6nDN3atbdODWPG25CAxuHQ3Bylp1T94nv1iMDyF/LT0z7i
 ekd0hEXqCJIQ1V+h1Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040162
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

--00000000000085b501064c3821ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Brian Cain <brian.cain@oss.qualcomm.com> writes:
> >
> >> *** Note *** that this patch should not land without
> >> "tests/tcg/multiarch/linux-test: use portable alternative for dirent64=
",
> >> a newer musl present in this toolchain exposes this test issue.
> >>
> >> Changes in v3:
> >>  * change debian from 12->13
> >
> > Actually I meant to grab this one, but I get merge conflicts :-/
>
> Conflicts with:
>
> e2d4646a026 * tests/docker: upgrade most non-lcitool debian tests to
> debian 13
>
>
oops.  I'll rebase and send a v4.



> >
> >
> >>
> >> Changes in v2:
> >> * none -> v2 was unintentionally chosen for the first rev of
> >> this patch.  :(
> >>
> >> v2:
> https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@os=
s.qualcomm.com/
> >> v1: <none>
> >>
> >> Brian Cain (1):
> >>   tests/docker: Update hexagon cross toolchain to 22.1.0
> >>
> >>  .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++-------=
-
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--00000000000085b501064c3821ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2026 at =
11:54=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.=
org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benn=
ee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; writes:<br>
<br>
&gt; Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com" target=
=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; *** Note *** that this patch should not land without<br>
&gt;&gt; &quot;tests/tcg/multiarch/linux-test: use portable alternative for=
 dirent64&quot;,<br>
&gt;&gt; a newer musl present in this toolchain exposes this test issue.<br=
>
&gt;&gt;<br>
&gt;&gt; Changes in v3:<br>
&gt;&gt;=C2=A0 * change debian from 12-&gt;13<br>
&gt;<br>
&gt; Actually I meant to grab this one, but I get merge conflicts :-/<br>
<br>
Conflicts with:<br>
<br>
e2d4646a026 * tests/docker: upgrade most non-lcitool debian tests to debian=
 13<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace">oops.=C2=A0 I&#39;ll rebase and send a v4.</div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Changes in v2:<br>
&gt;&gt; * none -&gt; v2 was unintentionally chosen for the first rev of<br=
>
&gt;&gt; this patch.=C2=A0 :(<br>
&gt;&gt;<br>
&gt;&gt; v2: <a href=3D"https://lore.kernel.org/qemu-devel/20260303175444.1=
540049-1-brian.cain@oss.qualcomm.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@oss=
.qualcomm.com/</a><br>
&gt;&gt; v1: &lt;none&gt;<br>
&gt;&gt;<br>
&gt;&gt; Brian Cain (1):<br>
&gt;&gt;=C2=A0 =C2=A0tests/docker: Update hexagon cross toolchain to 22.1.0=
<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 .../dockerfiles/debian-hexagon-cross.docker=C2=A0 =C2=A0| 19=
 +++++++++++--------<br>
&gt;&gt;=C2=A0 1 file changed, 11 insertions(+), 8 deletions(-)<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--00000000000085b501064c3821ca--

