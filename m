Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED301CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1ej-0002Af-7T; Thu, 06 Nov 2025 10:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vH1eh-0002AW-2b
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:12:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vH1ef-0001t5-4y
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:12:06 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6F9xLa3362881
 for <qemu-devel@nongnu.org>; Thu, 6 Nov 2025 15:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=P9lsnnENprHLOcOK2SD24FwY
 8Y08+vBhQdGs1ajS0cA=; b=Jyuw6Bv9pvRUMF0ehkAn/ktk/D9aRQHQJsOqjDf5
 qpSYWsnVaysAUEu2bMRVT6+3zu1O/clt6noey+1+qzAdWCaJsDaxvpqKeW+LZJfY
 uXA1EQNtZnY2XZZdXColp6ONl/NLu/oOWUqbx/m5Owy9497aB22WhBHkFKgi4WeX
 asCD2Poeq8lBK6e6ll/7yFi6Z0docVTcmaNecHenafKg8zH8PFp3PUNaf2oWhGyx
 n7NVKx3SmuSv+VxS8y1CoHhxy+kd54Dq+h/B+1FZmAWuB6XoOvjliVSSCt+o9EW+
 94b/37+4RHyfsnVZXJC+eUsV/H6GwmSFnqeM8eYXPW0fTQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pt59d57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 15:11:59 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e2d3351abso1638067d50.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762441919; x=1763046719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9lsnnENprHLOcOK2SD24FwY8Y08+vBhQdGs1ajS0cA=;
 b=Q/6zM3sMU22sfnbIK8ToAeNHM1WFiHhiXG3Uw1jslnl9bkfg3QgB6xEAjp1vNVkl+m
 iMgtx72op9ZamyT9UIMjc0YwE5ri+MOYBhi+QtvZApTQ6ezCbI7GVKKZOz1lVE3dv5Vn
 G1v6aL4e3+42s+n3hx0t4e0skyp7Zh9mCij4vKVe0vfdYDkhXGDO/md0KFKjPKbpaFBX
 zz6FCNgmXnyWsUmTAuDXF2/YX1Cfulyc0EAa+TF+3pg4fnupLwq8JJxFyPv7ppULk/Pd
 2Q0ts5FBue47UNeR4MOtz8mgGp016p3jYjtCT00dU1reQsVsVM6xiHZiNHMC1JX4tIZq
 wTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762441919; x=1763046719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9lsnnENprHLOcOK2SD24FwY8Y08+vBhQdGs1ajS0cA=;
 b=q/DoNfPTeWk7ZoA72wn26fqqg/gYgLs1qK32rLJ1VLqxNI2nIzC0NrHEBpfjNnpWnL
 wBGPwA4cdhiif6a+E/nbLszbARW8+A9OYQMY/hav0uTJd8IVo6/wRH+5gjSfQeBJzki2
 4o1eG4M8EzkXgEdvH5JveZoOSvaRXF4bBb6IPwEH0/XNrIjys3mH67cThkqfVAa58eDs
 RDQxo2pfbwnUdjvYaSJLUNqwylpsx6MhagyXSjM3xeQWVrwGowsvqz4i5iybHUePPRzw
 3fPAMM2elOwPKOaCaVb+pfAxHMAC3M8N74pdyqIoA0taiCfNOIzstlgpGxg4JUokFaN6
 Rl1Q==
X-Gm-Message-State: AOJu0YxKqtCGhlvufVoPv8kRM7l29+WNV/5X2qmwj+/ctWnGzwwxcaVy
 hEZJ5trgrA+WD5Xim5sscOZ1TeLtAp3YrMlV44ZvdxHnSotr0S6+H63bYf2sGAjOxu7+hhuhXtV
 sE7apJbUQ3C5qzi9K3uZkZ30M5pUi7f7g82t9/8Vg6ZRlhjJurDv1hUcyjIOFM70TMH+xEyzCfd
 3siuKPfLKvRWGy2rQqzlJ9aWhVu6cIvsUL
X-Gm-Gg: ASbGnctliqSxaqJUlCsbaZWB++gkR7MKbwut0BJlmsEaiKjfGmJADyjiCexvB4F95Ab
 tKJUPR4L+/4O99UmwlKuDVN9BXgE0GJJpQ8IjAqJaPMJlgzTas5YWlceEnBgOK2OoHMyWJZruf4
 rJcZDSO8srARu8tfAwUaRNFtUUj09zJUl/xHh4IXysVPBhTq6aVxcrFefGXAvFK4WL/nALx54UD
 AFk4dInEySBOw==
X-Received: by 2002:a05:690c:6e11:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-786a4126567mr122592067b3.17.1762441918430; 
 Thu, 06 Nov 2025 07:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf4tBQJg8rEPx8zGm9Ul9DtMgVsA+h4BwdptLGLVlemETfOrYi/Sm32KoqbL4Lv7XKU20a9Ntlc3h8WqS6nVA=
X-Received: by 2002:a05:690c:6e11:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-786a4126567mr122591537b3.17.1762441917779; Thu, 06 Nov 2025
 07:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 09:11:45 -0600
X-Gm-Features: AWmQ_bk1c5Q1qP-KdWku0Mn2NSxa_PVkPfG8WO5eo0bAwhfECM_wVbOul79psWM
Message-ID: <CAEqNhNa89Xicx=GLa7+c5paMQLYUpn98_OHLSsHYiuYYi3a=1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Hexagon (target/hexagon) Improve USR handling
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000007260570642ee7c1a"
X-Proofpoint-GUID: 3N2P-U4vn9xik2-ZUPcpONqiwpJEUGuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEyMCBTYWx0ZWRfXxTJq6QA3gp/q
 BmCv1d4eqlukv+agjaJZ+nAELzZVJXQHiblzxFei2jNeidp7ksrXhqATkyDKE/t8EUIWhOiQ2/t
 +iV8p1WZRon1sbWsaR05BkH1llNxZoTU7gsEa+WgFoSSDHAY/ipIL7Ppf3J8c8tmRh9g/bHyx9P
 6n96jy1YVGBLSIMb8eM/WSTSKVz9inpC8DiBAHkNUhjnhzeKwFSNL1X/AkqSP5yK5dx70y3vBre
 4N/l9ZPRF+EoP1DjuR+bcKARlUaAJtBUP4wAB/99d+5kLVy97aldXsktewtUzX94Mgeg5VaXIsR
 mZdnphNlVIcBqNfwwY/lVYr9vu9TtWWnW8Cxb3wAGGZXFffH9hkjWckNL8G3AiIDlLw6c/wfJnU
 tWSbp/5chMRDg2xM7nHYFt5Um26stw==
X-Authority-Analysis: v=2.4 cv=XNI9iAhE c=1 sm=1 tr=0 ts=690cbabf cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=-yHnPg5qZgIk5m184MoA:9 a=QEXdDO2ut3YA:10 a=JDzSH76gJ6vzs0__fFUA:9
 a=ehfph_7ouGavFRLO:21 a=lqcHg5cX4UMA:10 a=chlNtPgKP_UA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-ORIG-GUID: 3N2P-U4vn9xik2-ZUPcpONqiwpJEUGuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060120
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000007260570642ee7c1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:25=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com>
wrote:

> Currently, any instruction that writes USR disables short-circuiting a
> packet.  When the write is implicit, we can allow the short-circuit.
>

This series is now queued at https://github.com/quic/qemu branch
hex-next-express


>
> Changes in v2:
> - Properly handle implicit USR writes when packet commit is necessary
> - Added test case
>
> Changes in v3:
> - Address feedback from Brian Cain <brian.cain@oss.qualcomm.com>
>     Use symbolic/named operands in inline asm
> - Added more packet test cases
>
>
> Taylor Simpson (3):
>   Hexagon (target/hexagon) Add pkt_need_commit argument to arch_fpop_end
>   Hexagon (target/hexagon) Implicit writes to USR don't force packet
>     commit
>   Hexagon (tests/tcg/hexagon) Add test for USR changes in packet
>
>  target/hexagon/arch.h              |   2 +-
>  target/hexagon/gen_tcg.h           | 114 ++++++------
>  target/hexagon/helper.h            | 114 ++++++------
>  target/hexagon/translate.h         |   1 +
>  target/hexagon/arch.c              |   3 +-
>  target/hexagon/op_helper.c         | 287 +++++++++++++++++------------
>  target/hexagon/translate.c         |  35 ++--
>  tests/tcg/hexagon/usr.c            |  54 ++++++
>  target/hexagon/gen_helper_funcs.py |   8 +-
>  target/hexagon/gen_tcg_funcs.py    |   4 +
>  10 files changed, 371 insertions(+), 251 deletions(-)
>
> --
> 2.43.0
>
>

--0000000000007260570642ee7c1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 5, =
2025 at 3:25=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson=
@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Currently, any instruction that writes =
USR disables short-circuiting a<br>
packet.=C2=A0 When the write is implicit, we can allow the short-circuit.<b=
r></blockquote><div><br></div><div>This series is now queued at=C2=A0<a hre=
f=3D"https://github.com/quic/qemu">https://github.com/quic/qemu</a> branch =
hex-next-express</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Changes in v2:<br>
- Properly handle implicit USR writes when packet commit is necessary<br>
- Added test case<br>
<br>
Changes in v3:<br>
- Address feedback from Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
=C2=A0 =C2=A0 Use symbolic/named operands in inline asm<br>
- Added more packet test cases<br>
<br>
<br>
Taylor Simpson (3):<br>
=C2=A0 Hexagon (target/hexagon) Add pkt_need_commit argument to arch_fpop_e=
nd<br>
=C2=A0 Hexagon (target/hexagon) Implicit writes to USR don&#39;t force pack=
et<br>
=C2=A0 =C2=A0 commit<br>
=C2=A0 Hexagon (tests/tcg/hexagon) Add test for USR changes in packet<br>
<br>
=C2=A0target/hexagon/arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11=
4 ++++++------<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11=
4 ++++++------<br>
=C2=A0target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
=C2=A0target/hexagon/arch.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A03 +-<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 287 +++=
++++++++++++++------------<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3=
5 ++--<br>
=C2=A0tests/tcg/hexagon/usr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 54 ++++++<br>
=C2=A0target/hexagon/gen_helper_funcs.py |=C2=A0 =C2=A08 +-<br>
=C2=A0target/hexagon/gen_tcg_funcs.py=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A010 files changed, 371 insertions(+), 251 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000007260570642ee7c1a--

