Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B5BD0D141
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWz3-0004d1-TR; Wed, 07 Jan 2026 12:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vdWyi-0004Y0-3U
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:05:49 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vdWyg-0002tm-Hr
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:05:47 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6079ehYX2988614
 for <qemu-devel@nongnu.org>; Wed, 7 Jan 2026 17:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RtCW7I1q9ze034KTpj1/imWx
 OwDBeM+T62crw9vYBOE=; b=H85netOEZdcmglN17Fbe1OfFvmurqmhotUax4HP0
 nabKTcRIpzgkFLHLRTN7Rqx2yqtwGvzySLNZ3CBfzekFrC4MwO/Fk3dQPVEtp8Bo
 uiNPW3Cx21VPsSJt1mk1CW6+5r6Gl7x/0RQvJOOlvQ8tKpml304CWTbvgwyNlcAu
 i9y52HnHK+C5vxamyp09tt6sazrAF1qhrkaMCCCwUbODms45zlWpMecnzwkyg+pH
 h+DUgS0nZ+d7e/OJ7hgoXQwESMGuDpVDkR5CjbWgHzUdXNeW7kncomlkG0iQgqq3
 otHTwRDC5phSkUeAyBFmtkPBK3dVdS2bWaCSSmp8FyeZXQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn2nscgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 17:05:41 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-63e32e1737aso3166766d50.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767805540; x=1768410340; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RtCW7I1q9ze034KTpj1/imWxOwDBeM+T62crw9vYBOE=;
 b=iOiFm4MIwEVKGk/Usl43CJnxWJMdaX6UPNF3qlq+x1P1NDHDlau5vwX6WZlNo50xAp
 NGVeWSsFc8IworGRZDAbrPKR7HglAdioQmxgH8kG72RSCQpXBs3ehhMtys5qfyqKGH/r
 HZ2e/DOj32PgGLeOib7OlBWDoSc4geNYa0ufx0mZRHanhVtAwqCPp9tngZ7hgifoYOrb
 sfLF7nPZSg3OcU2u0W4dhPkI2AVVrh1/ZWGVpa3XFH5GkAAhEU3dBikDFwn5LAJwVg7x
 kY1xyu5izivdpvgnQEoD0NHl2MSsgNBzB1lJvpVJ27F4NWptgPMlxxkC2SPixtkAp8AR
 +7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767805540; x=1768410340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtCW7I1q9ze034KTpj1/imWxOwDBeM+T62crw9vYBOE=;
 b=Hs2zn1ayWVy1shbgz/uCz5y8hTV3rZmEMn5qPdF+/VgIBWJBOHrZkw/AfSw7sDksMB
 AeqS7GZuN8aWHB448zTLvwptMWu4tAUZOTXZ8XZfJP70cgWD/N9rsIrcsEyiMUaGGKX4
 arydEKd9TEgGNbnFESSD1gs856ccgEdYmvuPVr8g75J9NWoKfCC+JcBsYEleHOjNcERz
 rr00Jm17Y449nwuhTDPvCKSnRIgAIQQLYnbP0iu6qRNCTZ25R88OC/0Y216o57aFmz+q
 POch0vzjyAAfnl653/6KVNt7OxgTqdy5SpGi07jGzQsqQ2wkWTR191mV8aNwormNUoJ7
 7x7g==
X-Gm-Message-State: AOJu0YyyhRV20rLS80k6LTDXQJqr4ykowEDR5moD7jB2ULDI1KXCM6B6
 MU7nOV3nR99IzqI53YguHqrpxgoRe+bRO+EUx5qHh+0to5fWWCaRDXH0iwcdsVwr61fpiPfAqLH
 LXPVjgT9m5GtGey1imWIviQ5PeOulzT9bb9ZfkQID8QXAmSw4Hwfrkp5zgvgxvCtE3Nm0Ji1ocX
 BV2VndyblEl30Y9jzxTpizAi6PAawC1QRr
X-Gm-Gg: AY/fxX4ZztHIxowlJ/WwmewXclYvp+ufrQzlbriGWYU0aqq4aNFb4xhnPXpCwhOg9UZ
 bv7NX9+d1jVmKKTZvtsWfZzawPWP3ftIXTu9+Mhdir84rU0+DqM05AYBI1eXS/Y9IC9p8mRuPrH
 M6nS3HMijDcRKQZ+N5Zgtp7R183oqxs9xwgzCvBimjzuLEt1D0TDKXif2eKhl5DRF+xrbr
X-Received: by 2002:a53:de4b:0:b0:644:4986:4559 with SMTP id
 956f58d0204a3-64716b75d59mr2107103d50.22.1767805540378; 
 Wed, 07 Jan 2026 09:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzlI9sBqmhpZxGgDnYi/s+Alsfg+xuIUrHyc8RzA5iHx3RD4MlnQP2B+XQFPu/RRO5xahL5og6OHx67/7j6pU=
X-Received: by 2002:a53:de4b:0:b0:644:4986:4559 with SMTP id
 956f58d0204a3-64716b75d59mr2107085d50.22.1767805539868; Wed, 07 Jan 2026
 09:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20251224160708.89085-1-philmd@linaro.org>
 <20251224160708.89085-4-philmd@linaro.org>
In-Reply-To: <20251224160708.89085-4-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 11:05:24 -0600
X-Gm-Features: AQt7F2rdZW8XIrOBYEFdgChl9GPlArQoVDZjLqwS7MamZ9hoAWgY2AVDt_lQlFU
Message-ID: <CAEqNhNZnpuXo5fKJFg_9ig8gw4Hgx4kPgY2dGSzdG5KAHKKbhA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] configs/targets: Forbid Hexagon to use legacy
 native endianness API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003c76d30647cf4de2"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEzNSBTYWx0ZWRfX4z0dm2Jk4ZaT
 ovEM7+2PwooUV8B85YleEqdEiVqFaPVTPR1lDPm4lFMpVGhfYVv3ddV4u19wJkAjsJf25ahtgjR
 PR67xO5Nulan7BqFtaEkHgKg4A9p8ZT5DWPnKeJ5PN7roaJt5epaGfy1YJ3kY1wy02lfNGORk3w
 ZX9tRah6fLgwWeRc5XNVRHCMqYMKgqIR7R36ZOaztrlCa5nbmh3aOzDTpyuTD7gceUgvo0oXgdb
 5WvYKWM7+X9GVoxXtJhqKIcSji34ACpOE+pylOvk94CIYBiRrO3LZ/03tNqPv6RkXqIKFZrW6Ud
 J5AtY5jcQwJ0RDJtmO/m5xdWSe4ohVQg65P3aFvOSZKd8mbhfUkWaJmPMFnxirYkhh8Nt+CD9dV
 GZvdn6BmXPIJpzOLhjcfmPsYQs87nhuELyXduEVlwHQQ2lK6WrG4Ldss199WUkFzZ4yQE/uHKq8
 QNsdsJQESPJmcfoWB2Q==
X-Authority-Analysis: v=2.4 cv=CYEFJbrl c=1 sm=1 tr=0 ts=695e9265 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=CjeyidwC-jpWUi_oe4sA:9 a=QEXdDO2ut3YA:10 a=P42SzZsFAkGMRQW4UBoA:9
 a=8d9DbF3GtaKlsBmb:21 a=lqcHg5cX4UMA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: g5rBlaydYD5vl1Lug6_qWman71L2NCci
X-Proofpoint-ORIG-GUID: g5rBlaydYD5vl1Lug6_qWman71L2NCci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070135
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

--0000000000003c76d30647cf4de2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 10:07=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> The qemu-hexagon binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Preliminary commits allowing this final change:
>
>   - beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
>   - fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

 configs/targets/hexagon-linux-user.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/hexagon-linux-user.mak
> b/configs/targets/hexagon-linux-user.mak
> index aec1a04d1b4..6763e2111d5 100644
> --- a/configs/targets/hexagon-linux-user.mak
> +++ b/configs/targets/hexagon-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_XML_FILES=3Dgdb-xml/hexagon-core.xml
> gdb-xml/hexagon-hvx.xml
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_SYSTBL_ABI=3Dcommon,32,hexagon,time32,stat64,rlimit,renameat
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>
>

--0000000000003c76d30647cf4de2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 24, 2025 at=
 10:07=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">The qemu-hexagon binary is buildable without a=
 single use<br>
of the legacy &quot;native endian&quot; API. Unset the transitional<br>
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid<br>
further uses of the legacy API.<br>
<br>
Preliminary commits allowing this final change:<br>
<br>
=C2=A0 - beb38fda0f0 target/hexagon: Replace MO_TE -&gt; MO_LE<br>
=C2=A0 - fdcb7483ae0 target/hexagon: Explode MO_TExx -&gt; MO_TE | MO_xx<br=
>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:brian.ca=
in@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><div class=3D=
"gmail_default" style=3D"font-family:monospace"><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0configs/targets/hexagon-linux-user.mak | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexag=
on-linux-user.mak<br>
index aec1a04d1b4..6763e2111d5 100644<br>
--- a/configs/targets/hexagon-linux-user.mak<br>
+++ b/configs/targets/hexagon-linux-user.mak<br>
@@ -3,3 +3,4 @@ TARGET_XML_FILES=3Dgdb-xml/hexagon-core.xml gdb-xml/hexagon=
-hvx.xml<br>
=C2=A0TARGET_SYSTBL=3Dsyscall.tbl<br>
=C2=A0TARGET_SYSTBL_ABI=3Dcommon,32,hexagon,time32,stat64,rlimit,renameat<b=
r>
=C2=A0TARGET_LONG_BITS=3D32<br>
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--0000000000003c76d30647cf4de2--

