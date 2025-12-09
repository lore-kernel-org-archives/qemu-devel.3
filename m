Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B8CD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3EZ-00067s-FP; Tue, 09 Dec 2025 14:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vT3EX-00067k-3G
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:18:49 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vT3EV-0006au-Av
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:18:48 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B9Gid573736410
 for <qemu-devel@nongnu.org>; Tue, 9 Dec 2025 19:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=F5Cs5uEuu7GnFMuak1GdUOEe
 e4wwebOiMtZ1nTtBK40=; b=fJK+Ma/ElOgbeZwHi26+WGQK7hrUMHF19B4zwZ1P
 SCuecRQ1LhG3TiuP/o0+MW4/appm++UYY4zBvyDeOS2iHDrs/DQQpuMc9Rolms8K
 2HgwEEuXkETdOGajacu84S1YPHIMh1ajRAv/h5k6/gxPSXbSrpY13K4LNaDI2Ei+
 /NlMFY/r6V5kfbqSimv+xL0QitrMFrWkgAE4N19CjYeSr9yfgHHivSfSZy870789
 xWjUtOjgHX9ld1YPg/BnuWtgAWqQrwLVjWeL6fKi5jKhAaUuRMH3jo5iiHZhqBQH
 GTld658nk45nvVH3bpNF+l+SL6fekWTXe2goMIcl4B3NVw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp4vrttu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 19:18:45 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-640b8f1f66cso8081988d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765307924; x=1765912724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5Cs5uEuu7GnFMuak1GdUOEee4wwebOiMtZ1nTtBK40=;
 b=kY8RmpfGqhS2VnLx2o5iGNa/3Rm7xDKePxscnrhC3NVV5g2caEc6mAGB/DTZmi6e0z
 Z0Fa4fE4gDCXZrH/LowvAupO92hmejAK9O2blw5lDiTZx2gNsQN0OZIjEfKgSd6fmZHS
 tXBhI8PFM7UfrAJfcKaON4NPKF2tGu/noV0m87Xq0BL2rZgX+kLLfTxRDZa45bbMi1D1
 4u3G68oXlDEV9SKAjWjRzSyymv1Oyxj6V4cH1Vw4IIP/3ZOIEJqQmnQRObpOdrVNooTQ
 C6UNSDYDevZiHBn2Cal6xhD3bvua7sq6xZjaKEHQEk4kXqzEzXfzl1vyJ0zIBeWPRTBu
 /wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765307924; x=1765912724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5Cs5uEuu7GnFMuak1GdUOEee4wwebOiMtZ1nTtBK40=;
 b=nLLaIYrMSK+r8dhvObSHt7i5hCDqQ2a2mUz8wSW75TZfN11azSkYughDY3luZ6Qh26
 NeWeGSPetkKuW9t5fveekLjmvEFK1kRBV8cWU2YUF9ny57HgmdeSZETHdc+W+z8M1Ehn
 IfcezmMltOtkdA3bNb8hmpYLDwSfsMmd/h0Mggq3OWORddrF1BLSb9US8WQk2kvb9CO3
 mYvWe/lUW77iTYvMqypIDWa8oVwbmIGZcO+zaUUD4uSTH8b9U5RntI9FCkMPmXlXDZeC
 Kkcndz5pab8ygzVoYRJJpOu6HAdQU7x8LLJdYKvZN+HQfMlHOKCe1M/VrkayH8bFrV89
 omZw==
X-Gm-Message-State: AOJu0YwxoR/NlRrSWPpoIq9cvQrSjzRuylr3VvwKPjLrwsF4MFX6qTZ3
 SxtIi3ZK3Z+1GLRi74MaqrkQnBxGeAWmDI13xgQQREWwh93OMZZXB1lfiM8m4rpXAF2BJXHEBAo
 35/EW3vk0wlfY6IOHuxhkzYm5y65NVS+F4cIst9Mry8VXD+HqJVAOb33mp6dIaKnC5oWPp+0Nfj
 i/geUgBSccxasyU22h9TuqRnWP20RBao4+
X-Gm-Gg: AY/fxX7ou28lrgrRNER0zDzC43cJh8Q8BlqdtGLsN3EI/hrRTL6w/lzfnP8yPqM6D76
 vhJ5zhhgM87NwD6i4hP+QNaGNb0HJaUHweJ2Y6sTooQuXzA5X/IP3ISpKoNpBJbI+t40nI1dRKL
 ezVz3h3i/cINvm2GoCHAryqNQH+OgpA8/rarB6JLt5KAWeefgpDAVZv4Vy/9S72caOo0c=
X-Received: by 2002:a05:690e:11cd:b0:644:6ad4:fdfd with SMTP id
 956f58d0204a3-6446ad4fff6mr1367596d50.71.1765307924151; 
 Tue, 09 Dec 2025 11:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2tymj2+GJ1JVHewDnevHl9SfaPJeLKY16a9OLYjyA7sygp2hP4j81BO7FViP6zbc0gIAjLpMJHRSpbbSnbHQ=
X-Received: by 2002:a05:690e:11cd:b0:644:6ad4:fdfd with SMTP id
 956f58d0204a3-6446ad4fff6mr1367580d50.71.1765307923758; Tue, 09 Dec 2025
 11:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 13:18:27 -0600
X-Gm-Features: AQt7F2rT-bXegDo0aLllpB3V5X51lq2yDwex5UmXWAb3IskaJ15aSk9_7_TVZmI
Message-ID: <CAEqNhNYM_uqUHK6M_dg49xw4B41+KRV6DHq9P9shM_EoEcStug@mail.gmail.com>
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000b714ac064589c7a1"
X-Proofpoint-GUID: KwIzdQfci2-1nJoF8GOSUb5Qi4fGIowM
X-Proofpoint-ORIG-GUID: KwIzdQfci2-1nJoF8GOSUb5Qi4fGIowM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDE0NiBTYWx0ZWRfX3D5P7iRM5ttg
 R0pgOvaYOlIhHdDWucNvnMRTUGkFH4G9VkEoaK7m0jFu3ApfljNHm6hZOoxlSpRXrIFIf0GpTcP
 oaRWf84MxZ7SnStllNQBLtnkuBkEbP7JmMDnAK+REbSbPJPMzAClMrBh1hKwkZH9gpAtVgawdZm
 mhfrU1LAd8odBSv54VzfSM8ObF/nUKGikoghjZeInIHGLuyLe4ODtlVGPKVDm49yxDuGbSjO2Ll
 Uiqz8fb2LuCEE0k3iDV/B/EiVuWPc/2B5ojfHJGvsJyI5LF/Ur/n0XOUYYE19kW+/Qw+HMLABX8
 mq7IrTAhd3b+z0rMHhqD17+zGvbRsL0btgNQQ0tRCwT4c9GY5dvlJtF8ut+3ctNt4i+RSgYc04q
 6Osh6xkFuWwrojXshZI0JwOeOX/6pg==
X-Authority-Analysis: v=2.4 cv=IoYTsb/g c=1 sm=1 tr=0 ts=69387615 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=ih0KZ4qlk0rNm3-gH-IA:9 a=QEXdDO2ut3YA:10 a=s_7aovIEGbHaChXEymkA:9
 a=AvU29m0MNXN0fl-c:21 a=lqcHg5cX4UMA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512090146
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000b714ac064589c7a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:00=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> The changes to packet processing have made some of the end-of-instruction
> processing obsolete.  With the addition of gen_analyze_funcs.py and the
> ability to short-circuit a packet commit, we no longer need to "log" the
> register writes of each instruction.
>
> Taylor Simpson (4):
>   Hexagon (target/hexagon) Remove gen_log_reg_write
>   Hexagon (target/hexagon) s/gen_log_pred_write/gen_pred_write
>   Hexagon (target/hexagon) s/gen_log_vreg_write/gen_vreg_write
>   Hexagon (target/hexagon) s/log_write/gen_write
>

These commits are now queued for post-10.2 (11.0?) at
https://github.com/quic/qemu/commits/hex-next-express/

Thanks!



>
>  target/hexagon/gen_tcg.h                    | 11 ++-
>  target/hexagon/genptr.h                     |  3 +-
>  target/hexagon/genptr.c                     | 86 +++++++++------------
>  target/hexagon/idef-parser/parser-helpers.c |  4 +-
>  target/hexagon/README                       | 10 ++-
>  target/hexagon/gen_tcg_funcs.py             |  3 +-
>  target/hexagon/hex_common.py                | 56 +++++++-------
>  7 files changed, 77 insertions(+), 96 deletions(-)
>
> --
> 2.43.0
>
>

--000000000000b714ac064589c7a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14, 2025 at=
 5:00=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.=
com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">The changes to packet processing have made som=
e of the end-of-instruction<br>
processing obsolete.=C2=A0 With the addition of gen_analyze_funcs.py and th=
e<br>
ability to short-circuit a packet commit, we no longer need to &quot;log&qu=
ot; the<br>
register writes of each instruction.<br>
<br>
Taylor Simpson (4):<br>
=C2=A0 Hexagon (target/hexagon) Remove gen_log_reg_write<br>
=C2=A0 Hexagon (target/hexagon) s/gen_log_pred_write/gen_pred_write<br>
=C2=A0 Hexagon (target/hexagon) s/gen_log_vreg_write/gen_vreg_write<br>
=C2=A0 Hexagon (target/hexagon) s/log_write/gen_write<br></blockquote><div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-family:monospace"=
>These commits are now queued for post-10.2 (11.0?) at=C2=A0<a href=3D"http=
s://github.com/quic/qemu/commits/hex-next-express/">https://github.com/quic=
/qemu/commits/hex-next-express/</a></div><div class=3D"gmail_default" style=
=3D"font-family:monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:monospace">Thanks!</div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++-<br>
=C2=A0target/hexagon/genptr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 86 +++++++++------------<br>
=C2=A0target/hexagon/idef-parser/parser-helpers.c |=C2=A0 4 +-<br>
=C2=A0target/hexagon/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++-<br>
=C2=A0target/hexagon/gen_tcg_funcs.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 56 +++++++-------<br>
=C2=A07 files changed, 77 insertions(+), 96 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000b714ac064589c7a1--

