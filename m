Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C18F4BB7A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuyAc-00065T-NG; Tue, 24 Feb 2026 14:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vuyAP-0005uZ-NW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:34:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vuyAM-00010k-6V
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:33:55 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OHCAXr2220909
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9fXSe3X5msEQOn7m8uSq0kyX
 sNKt5ils+7WtBT7kiKs=; b=WgkK+jVDuQpMgKK8Em4CHt4f165ZeOFNkaraw/Im
 QZi1a8UXCM80PmbppcFoEf7aODCi7d/gImn2K5yGQh1Dk9QcLlc07sO6XQo/hTLs
 Pr9HZsoAzFZPQdDTJU6GRSsqB1JspuypLttc1e5NLz2I4BWyYKoFm0BpRzDa+0xo
 q0i5ScmGYfDddx+0pa6gGPPwvTLF6iylTg3ktbs7HbgaFH6GqYgU4fTA9T1AR/8j
 wz23ihc/M+SadqC0Y0LJ2Di02rD8qbEJ9a8B1NEdodmhzXLVzb8fdrFla4hPDylv
 jAn+w+hmUhvRE0fkWQPumsaRSw4SmAJnLLT92r7r+qEs2g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e3ave6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:33:51 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-649c2a1b438so8637201d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:33:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961630; cv=none;
 d=google.com; s=arc-20240605;
 b=WxSgOIbHkyVgQ/e2QVoabuZ8mqCne8MagPy1G0h+RCl7/BlkK9fCVCk/Q/k5RIvflU
 Lh1EwZ7m17W8Vxh3aSkXOugul0zffsa2rwvADtPwaoMaaUjiiqpAX1lfoRfphIq8GJpC
 vYOBx/X/ME8vdcgc9C3ro9YqJvSq/dY9LxDUH3zB84NrOdsJdRZRM3oa8nlJKJroJ9hi
 gshkXxI24w3+cg3ZFPsrXktK1p+yTqEUejtkDiCrtl2H3ZRXWYN0LZDZ9L7l5RNvZD5h
 2qhsf+40UY/tSLm7i0ioQXXf09WOg3+zBshyHN2UjyyfVUKnSpcvj/sZr3Iie4DEirbS
 xteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9fXSe3X5msEQOn7m8uSq0kyXsNKt5ils+7WtBT7kiKs=;
 fh=yu814cA08wuY4V8jItBqeAdCck7y9xjLffuAyMr9Gfo=;
 b=P07Tt9P/isr4mUCcgD2F37L+n9EG1sE3jRlee5XxnoxMsA/lmz2gV+4EfLItL/7afT
 zjdOjUsee/Vn5t1fWf360t/yyL4183ewfcC+wIvU9Up53LJY/bGeaVwl1KjyGWhkAelr
 5rmyory4gb7mUm56x+n8JyJU/J+2ifJM+XSZ8OdjPomTFqq85IkgCq0y8ulisp+boRPA
 hXZY8HQtPQwHut5xeK4kdElx7SiA/1yD0cFgfbPrnwbg4guMAtlQbh7p6yWge8un+OJx
 hCUYzIDIIRhtdAzid/vOk3B/8QSpdA1471YqYTXRythkoMqii92cNcCRpffWhVmxoCr9
 nSGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771961630; x=1772566430; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9fXSe3X5msEQOn7m8uSq0kyXsNKt5ils+7WtBT7kiKs=;
 b=Opc5IQynd36ZyL2QjVArDdmk6b9HETgL9bJVVXGiXVAVyRVHQuT8nLBy+cdEM+ysx4
 CvzWtRoQSXZMOVZVJi8alRoKnOsp+/EtOe7zIV7lfcSD1MZBtg95ke8TpBlE2azN3e3A
 fYfnjdOg9z1FqoLGv5lP72ZlAoolJBI1CWlZAHxR56JYRhVbH0dmJUUjLVSWxVXt8RUb
 FeBHJ9FwbQiiplejwtDRZkFCc++zs1XwBp12zNIzG7mj+jvzTVxCmDVp20+WXU9nWsFW
 9GFmPxI1ClnMiq2znpR5KwqC8FulJzDKyPQHAZAAMjuCg3KR8wVtoPmIheW5mqcMcFFG
 FuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961630; x=1772566430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fXSe3X5msEQOn7m8uSq0kyXsNKt5ils+7WtBT7kiKs=;
 b=ueY+ga6dOg+TeAhrLdO15F+RssH2DLEeVt1S/of1uIwkucXSXBrE28khfe/yWms9ac
 DRm4F8WwxM8cXbCGIQCdNGhqzjn3FEq0TaRHkdv+JXK1Sdj94fPk4MbeNwiLPpLZrOSS
 DsdJuF139fYkhgZETU1HE9VTTv/MOZ6k8tAYjWuKOXeHciFslyZuXvL4HvZI4OsHGmpY
 q8CO1q06b6zIAhmYSMYt+5dRorCVfF3FQtFKkkvE7CRHH7g5WCC/ugsqskS8LU6y9atr
 vF8F+uA4AC88PcsrIAV+KyOlpp+YBeADkAQSoNk1lVRjlzB32xh3xRIrZTO/crwv7hLz
 Xtiw==
X-Gm-Message-State: AOJu0YzivNPMy9ZiamcSS7IHBDgBEeatFh+6OJjW88uSWOADLtAgsnxH
 HcQYyDv6KbvW+dMTEwnzK2PjnCpFy9etQUuGI6PCc+C2Bx9LfyRcZsX1+0JpU5GC0auYSKutYI8
 jLCLuxlVj46PJFFPtkW204CUJKKqAsQlxuHVUztC9Qw9L8TROErHSzWWsio8NkNHrkuhVj0n25T
 wQxa+MYu3n8cncXVuv85gTOBEldS6yZJ3E
X-Gm-Gg: ATEYQzyGcsS6BWAVctonF8H3NXpMDBQsMzqc9KrFGV84QjSgiHAGsijjeq3tMWM+zn7
 E02pyXnXiq668cYU4AQcVOrGYFru3vFcMi/6xfoVQCkioo4viBcNOUW29SGfia8qVjtpoDD1U3i
 O/6m9G6m4knTwqLktcPl1bjEjN01+NAJbdwDOh/PsrqeD0zzcuCIQk7a3/7Fb3fOCsAelLdgw7l
 2knk7TV
X-Received: by 2002:a05:690e:1517:b0:64a:e366:f501 with SMTP id
 956f58d0204a3-64c789c7fb3mr10178710d50.20.1771961630503; 
 Tue, 24 Feb 2026 11:33:50 -0800 (PST)
X-Received: by 2002:a05:690e:1517:b0:64a:e366:f501 with SMTP id
 956f58d0204a3-64c789c7fb3mr10178697d50.20.1771961630027; Tue, 24 Feb 2026
 11:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 13:33:33 -0600
X-Gm-Features: AaiRm53_KEaJyIKv86b-ajPTy-ey7O-T0C6PgHYPam3Ehd32AQjA35iP73M_-_Q
Message-ID: <CAEqNhNZ8o0CKVpSmjCrQ+9L3aPzduPd79RXFZiaVHYs-QcfNQg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Hexagon (target/hexagon) Check for multiwrites in
 analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000837dc6064b96f7cc"
X-Authority-Analysis: v=2.4 cv=DfIaa/tW c=1 sm=1 tr=0 ts=699dfd1f cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VwTeSv3KUUhyx1eAI5kA:9 a=QEXdDO2ut3YA:10
 a=vf1jFiC6xc7gg9pFXU0A:9 a=ZEW1YBCnoDo9kzrp:21 a=lqcHg5cX4UMA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: xhkfvtMJckJ5TCDpkV-P59_jSXrV83CA
X-Proofpoint-ORIG-GUID: xhkfvtMJckJ5TCDpkV-P59_jSXrV83CA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE2NyBTYWx0ZWRfX+zNJNg0+itsJ
 Vr/jgFHG201HohrLIpX3U89po88o/TN/86nA9BnLIeYEZo74YwajJa8N9eb05Dofd25P9XJnHHW
 O5O2EXmXPFaHozVVv5nhUM6vZhMDM25PUjPZFS5z62KGeB5PMCUNoOQMMUGmllYOSMgW9ofhaTE
 mur9PWCxVLaNYY+8CDo0GiFbSSflUmG0WiHg6thM9N3ezESI0oBa5UK3TD2Z61pnpWTfpUa58mI
 d5vG7rj+OvOgIoM14W36nSwbSaW+cyF4N0rxZLx05F6oABzSCX/22vRrnueWKSEgfGOkjrwykzC
 dpFm1Yo+hdSZLKzZhyShsLeop4zhQMu+TYJHrXWfc6Dpfm+Olfe4+2R1t82U/BuoMxTVS3/7OuI
 jPN34jZ1mD7HrTs5yqdhM94ImXIWmo/2s6J2gEbw6AAsb6b809vM7VnVQjf27/TzCm4PYCq3px8
 edhaTA8j+20CbONio9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240167
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000837dc6064b96f7cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:56=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> Currently, we check for register multiwrites during packet decode. The
> downside of this approach is that it only checks a single destination
> register for each instruction.  During analyze_packet, we can check
> for more than one instruction.  Further, we can check for different
> types of registers.  This series adds checks for HVX v-registers and
> q-registers.
>
> Note that multiple writes to a predicate register are allowed on Hexagon.
>
> Taylor Simpson (8):
>   Hexagon (target/hexagon) Move code out of gen_start_packet
>   Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
>   Hexagon (tests/tcg/hexagon) Add tests for multi-destination
>     instructions
>   Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
>   Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
>   Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
>   Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
>   Hexagon (target/hexagon) Remove old way of detecting register
>     multiwrites
>
>  target/hexagon/insn.h               |   4 -
>  target/hexagon/translate.h          |  25 +++++-
>  target/hexagon/decode.c             |  54 ------------
>  target/hexagon/translate.c          |  77 ++++++++++++-----
>  tests/tcg/hexagon/multiple-writes.c | 129 ++++++++++++++++++++++++++++
>  target/hexagon/gen_trans_funcs.py   |  10 ---
>  tests/tcg/hexagon/Makefile.target   |   1 +
>  7 files changed, 210 insertions(+), 90 deletions(-)
>
>
For this entire series:

Tested-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



> --
> 2.43.0
>
>

--000000000000837dc6064b96f7cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 23, 2026 at=
 2:56=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.=
com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Currently, we check for register multiwrites d=
uring packet decode. The<br>
downside of this approach is that it only checks a single destination<br>
register for each instruction.=C2=A0 During analyze_packet, we can check<br=
>
for more than one instruction.=C2=A0 Further, we can check for different<br=
>
types of registers.=C2=A0 This series adds checks for HVX v-registers and<b=
r>
q-registers.<br>
<br>
Note that multiple writes to a predicate register are allowed on Hexagon.<b=
r>
<br>
Taylor Simpson (8):<br>
=C2=A0 Hexagon (target/hexagon) Move code out of gen_start_packet<br>
=C2=A0 Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet<=
br>
=C2=A0 Hexagon (tests/tcg/hexagon) Add tests for multi-destination<br>
=C2=A0 =C2=A0 instructions<br>
=C2=A0 Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet=
<br>
=C2=A0 Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes<br>
=C2=A0 Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet=
<br>
=C2=A0 Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes<br>
=C2=A0 Hexagon (target/hexagon) Remove old way of detecting register<br>
=C2=A0 =C2=A0 multiwrites<br>
<br>
=C2=A0target/hexagon/insn.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A04 -<br>
=C2=A0target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
25 +++++-<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 54 ------------<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
77 ++++++++++++-----<br>
=C2=A0tests/tcg/hexagon/multiple-writes.c | 129 +++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/gen_trans_funcs.py=C2=A0 =C2=A0|=C2=A0 10 ---<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A07 files changed, 210 insertions(+), 90 deletions(-)<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace">For this entire series:</div><div class=3D"gmail_def=
ault" style=3D"font-family:monospace"><br></div><div class=3D"gmail_default=
" style=3D"font-family:monospace">Tested-by: Brian Cain &lt;<a href=3D"mail=
to:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace">Reviewed-by: Bri=
an Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.q=
ualcomm.com</a>&gt;</div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000837dc6064b96f7cc--

