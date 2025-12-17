Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E45ED66B81
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVvzO-0008Mi-Fm; Wed, 17 Dec 2025 13:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vVvzK-0008ML-0o
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:11:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vVvzG-0001yE-Sl
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:11:01 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BHHMtgq3981266
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 18:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JAYI8S4sYwYl7EChrMVCoF7S
 wN4z6RZN4gUx1n+zxo4=; b=amHLmRMo4cadqKaQ/g7sOoNscZRcfSAnilFKTaSu
 z/PmxYDgZ0gnQqAGHtrll2n2XwTRTDve6rHealIbLb6NYULP0IxVjjVbVmWC8wTq
 IjT6YsYo4kqRa+JYlu35C5Zkg1yeThjwkfo3rqjd9jNSbbQdEpJJ6I1eE6q9k/Qx
 pab57w/P/BvbLl4l+H5/lM670e3oqBG33SOAKgvnu+S1LKjpbLXt03KRqg73R8TS
 HQkbqHUfP+9ru5loZ1au018nZq+DU2GMm8PPBqmmgBOMLvfKmW/FvH3WxnWzvZrK
 1lIVpLS8lrsMlcSitDWIEittF093YZGGyLOLs+Bm3OcNZw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v784qy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 18:10:56 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-645599517c5so5245910d50.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765995055; x=1766599855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JAYI8S4sYwYl7EChrMVCoF7SwN4z6RZN4gUx1n+zxo4=;
 b=GFqYrUeySDGhB0D1cvODwPNMqwx61trGPyjPCiILYhDFLxUwqRUfKdKEiE/0LCsurJ
 9NjQ239P9dX/fXmv8IjZNn1R2K25O+spZ9py24TAr8mlRLDFjXAxUY7etwnI1BAT6CrL
 Cg69v1X2gU8Jo8IFSpZW0hk+x9hJm/H4LgJaKUG30frnN8Iz0Obyl284JG8MZzdj6p5P
 6u93vUuX3BW5xWNqmGdYIpemQ/jDAFipT37V1exoiRT7YejtCzJzeBLseT+JVzs5XwrH
 clqssETwC12AnwOJq2/7fjdO0pOsheRE8IbGzLIkXW/cEd5aHseQTZ3dgXrqTsnrughX
 Ei4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765995055; x=1766599855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAYI8S4sYwYl7EChrMVCoF7SwN4z6RZN4gUx1n+zxo4=;
 b=o8AZBPS6AH25BFfWzWaG729L5LLyE9suMl1fEoA5kln0TlJ6b0BO19Vk9kqUb7Vgbz
 FZgY3t07tVysfT6JTN3zEopfz1BiHVmuY1HHlnH6Bo4w0vR6hG9XWdwFZY5m4j9HmPSf
 cnH7h1Jsrg86KycubjpqLX42f70Eb8QWQQmmeytfRBqns8KsUllNBmugV6lLpwfsGwNr
 JzDR81q83br3bU2YLKwgxG4YeRBfA7b89ounkbqLKxQqWpU/CS+KObmtmPFCIzq13BOV
 +1Yj6Yk+grFQLQtidV8/VEXcR/NewYw1pM60u/BCSdGYWlIstmdSaxAI3BrwRaznrIE1
 rfSQ==
X-Gm-Message-State: AOJu0YwuTiw3YgQsPJRtSaIGm0OGyTD9SM6gN4mIaD+1WD4n2chaIjMU
 UrkngnPmGTbZWLc9NGpfxxAIbohzRQG5ZoZvf78ZEry9lCnDwCkb8tQkRbSk/COR9DJ+uIGbQjM
 gCw5fk6UmyHYtJJFQ0sPEoiWAC9KSCRGTIT0AD4s9Dvk6Qnb62jmg8IC5kn82WclhIBG4rcMDak
 5UwacSNtb53W+0pMW2LpcLoJuXQmo6a68d
X-Gm-Gg: AY/fxX7Aqwx4AX+g8UgdSCWBp8YyY911XpT6J1yHOzy3Ng0SH/1P3mBrk4u0Ffro9ev
 UeSOS9DT57oJhN4op6AgQgDkTzEPhgMYKmSdZsvYcUQZdSnyhKztcB4Zp8uAUwTh26DN2aLeYkI
 6zjdoHm5auDwbtrpltLlts66jUIPsm6wnMcAaylqe+NNoO2rc9CGJRQdD4//6pCQgSpi0=
X-Received: by 2002:a05:690e:1187:b0:644:60d9:8651 with SMTP id
 956f58d0204a3-6455567e274mr14172069d50.96.1765995055480; 
 Wed, 17 Dec 2025 10:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG22oiL1vrX2+oEv9GBqouWO2GOiNkbW7g9kMN0v9O2xYKdYOEdlxy3FFuq/vWtJ4JrSwAdzWpVGX7DQa/YQWU=
X-Received: by 2002:a05:690e:1187:b0:644:60d9:8651 with SMTP id
 956f58d0204a3-6455567e274mr14172054d50.96.1765995054878; Wed, 17 Dec 2025
 10:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20251217144211.95032-1-philmd@linaro.org>
In-Reply-To: <20251217144211.95032-1-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 12:10:39 -0600
X-Gm-Features: AQt7F2pFxKiksABlZtcpCAk8_olFrbSEgEteEqlMUaNv-R_JuOHIbPx_HF9baCo
Message-ID: <CAEqNhNZKhNWbMsGfT2_BdzDRKLZ03KjEaUtaim04upoQJ+quAQ@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Include missing 'cpu.h' header in
 'internal.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ebfa09064629c3a0"
X-Proofpoint-ORIG-GUID: bGxjXOWHa5KlWTIiv409WlqKbuJSetb7
X-Proofpoint-GUID: bGxjXOWHa5KlWTIiv409WlqKbuJSetb7
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=6942f230 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=jes78ldr6eyxAPFlORkA:9 a=QEXdDO2ut3YA:10 a=s0m16PFOyf00l4jPi5oA:9
 a=o8ZsNmgYwwGp3ILO:21 a=lqcHg5cX4UMA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfX/A+aZi7x5rsD
 DeoQiKnoDfw3gjRpEw5QvXWNtd49KXQt2UTkvYNw4strw5S4ja4ZyJmSPNyYnIYNaLzqLQQDcoj
 sGS3Baao8wUDy+wtfZQAvADdV2ju5vg00/xLGUlHn7vpnIqW6mqBJywJJmPB8ZFqi2pXS63NMUi
 1mZxTyp8kKg9rRMZGFFtU1ktOkHzBLwueKefe+AAJDdB/Py72OAi33AygoPjlm9tvKvUyC1K8DV
 dO/kf4f7NxQogpvIoVdJ3J/WrOnEM3Ik3fj2neTjZ65Kw5yhNdIzDAB5Xh9S4EkPoOSvyG4r+Dt
 nEr+ZMVDapdcMw1zW4BtdGU8OyAmiGqiDG6yrIRA+QSXDX1gsAilE0NpqYA8fCUEu99jx02d9I9
 nFVYysEUPeVViiiHs6eaGJ2fKog+lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

--000000000000ebfa09064629c3a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:42=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Both CPUHexagonState and TOTAL_PER_THREAD_REGS are defined
> in "cpu.h" which is luckily indirectly included. However when
> refactoring unrelated files we get:
>
>   In file included from target/hexagon/helper.h:18,
>                    from include/exec/helper-proto.h.inc:56,
>                    from include/exec/helper-proto.h:13,
>                    from target/hexagon/op_helper.c:22:
>   target/hexagon/internal.h: At top level:
>   target/hexagon/internal.h:29:25: error: unknown type name
> =E2=80=98CPUHexagonState=E2=80=99; did you mean =E2=80=98CPUPluginState=
=E2=80=99?
>      29 | void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
>         |                         ^~~~~~~~~~~~~~~
>         |                         CPUPluginState
>   target/hexagon/internal.h:30:25: error: unknown type name
> =E2=80=98CPUHexagonState=E2=80=99; did you mean =E2=80=98CPUPluginState=
=E2=80=99?
>      30 | void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
>         |                         ^~~~~~~~~~~~~~~
>         |                         CPUPluginState
>   target/hexagon/internal.h:31:20: error: unknown type name
> =E2=80=98CPUHexagonState=E2=80=99; did you mean =E2=80=98CPUPluginState=
=E2=80=99?
>      31 | void hexagon_debug(CPUHexagonState *env);
>         |                    ^~~~~~~~~~~~~~~
>         |                    CPUPluginState
>   target/hexagon/internal.h:33:44: error: =E2=80=98TOTAL_PER_THREAD_REGS=
=E2=80=99
> undeclared here (not in a function)
>      33 | extern const char * const
> hexagon_regnames[TOTAL_PER_THREAD_REGS];
>         |                                            ^~~~~~~~~~~~~~~~~~~~=
~
>
> Fix that by including the missing header.
>
> We don't need the "qemu/log.h" since commit 0cb73cb5a02 ("target/hexagon:
> Remove HEX_DEBUG/HEX_DEBUG_LOG"): remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/hexagon/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 32e96f00d97..5fc837ae229 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -18,7 +18,7 @@
>  #ifndef HEXAGON_INTERNAL_H
>  #define HEXAGON_INTERNAL_H
>
> -#include "qemu/log.h"
> +#include "target/hexagon/cpu.h"
>
>  int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> --
> 2.52.0
>
>

--000000000000ebfa09064629c3a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 17, 2025 at=
 8:42=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@l=
inaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Both CPUHexagonState and TOTAL_PER_THREAD_REGS =
are defined<br>
in &quot;cpu.h&quot; which is luckily indirectly included. However when<br>
refactoring unrelated files we get:<br>
<br>
=C2=A0 In file included from target/hexagon/helper.h:18,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from i=
nclude/exec/helper-proto.h.inc:56,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from i=
nclude/exec/helper-proto.h:13,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from t=
arget/hexagon/op_helper.c:22:<br>
=C2=A0 target/hexagon/internal.h: At top level:<br>
=C2=A0 target/hexagon/internal.h:29:25: error: unknown type name =E2=80=98C=
PUHexagonState=E2=80=99; did you mean =E2=80=98CPUPluginState=E2=80=99?<br>
=C2=A0 =C2=A0 =C2=A029 | void hexagon_debug_vreg(CPUHexagonState *env, int =
regnum);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUPluginState<br>
=C2=A0 target/hexagon/internal.h:30:25: error: unknown type name =E2=80=98C=
PUHexagonState=E2=80=99; did you mean =E2=80=98CPUPluginState=E2=80=99?<br>
=C2=A0 =C2=A0 =C2=A030 | void hexagon_debug_qreg(CPUHexagonState *env, int =
regnum);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUPluginState<br>
=C2=A0 target/hexagon/internal.h:31:20: error: unknown type name =E2=80=98C=
PUHexagonState=E2=80=99; did you mean =E2=80=98CPUPluginState=E2=80=99?<br>
=C2=A0 =C2=A0 =C2=A031 | void hexagon_debug(CPUHexagonState *env);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 CPUPluginState<br>
=C2=A0 target/hexagon/internal.h:33:44: error: =E2=80=98TOTAL_PER_THREAD_RE=
GS=E2=80=99 undeclared here (not in a function)<br>
=C2=A0 =C2=A0 =C2=A033 | extern const char * const hexagon_regnames[TOTAL_P=
ER_THREAD_REGS];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~<br>
<br>
Fix that by including the missing header.<br>
<br>
We don&#39;t need the &quot;qemu/log.h&quot; since commit 0cb73cb5a02 (&quo=
t;target/hexagon:<br>
Remove HEX_DEBUG/HEX_DEBUG_LOG&quot;): remove it.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/hexagon/internal.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:brian.=
cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h<br>
index 32e96f00d97..5fc837ae229 100644<br>
--- a/target/hexagon/internal.h<br>
+++ b/target/hexagon/internal.h<br>
@@ -18,7 +18,7 @@<br>
=C2=A0#ifndef HEXAGON_INTERNAL_H<br>
=C2=A0#define HEXAGON_INTERNAL_H<br>
<br>
-#include &quot;qemu/log.h&quot;<br>
+#include &quot;target/hexagon/cpu.h&quot;<br>
<br>
=C2=A0int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);<br>
=C2=A0int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);=
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--000000000000ebfa09064629c3a0--

