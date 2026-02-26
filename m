Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED918FD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 20:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vviGR-0005XQ-K3; Thu, 26 Feb 2026 15:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vviGK-0005X3-Ls
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:47:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vviGI-0006UY-Lm
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:47:08 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QI4ccR1395110
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 20:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2RfD0NK1m/dIXeElyGr1pmIL
 l4sNVn7gFv/l+q+9F4M=; b=QKDVi6iMRNOs+nmrjcxvs6KJ5/CrMEMp5OfEN7sL
 JzaajjLpfgT3RcFOjTZ0SIH44LZemS8inUNI4L/QpNNmo0hqt7iVSwqiJqxe6RCh
 XO92RnBPqwqlwKl35Y68kQaxbWpvtCzNLN0SAZslFCD2DDxwnyRTCNFG8ZtuPSh/
 BigNCJ/1GSDcfyvcD8iNkeuxEAtXBpyrRY0cpdqoD/TTp9tWg6jkdydJNHGgiCld
 qf15dM5rT4cv2NxJ2RwVqk6YW6BAH0L2m0OfXtD+liXJ4z1tYmKaX2OPlvK3oAwW
 DAKCgEHfgv6e9gg7lS4/7IB2/EY9cJENSYiWDBHnMX5HTA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r0p7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 20:47:03 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79832285fa1so26172757b3.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 12:47:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772138822; cv=none;
 d=google.com; s=arc-20240605;
 b=PvUOWMd8VsetDDV8Kdx9mLa3uim+z7koQSRZtIdcA6DdVe9QngvZ32hKmJDEDaJYId
 uHul8bw0PqWOoJSWEG3o3JkkBMOU5O60eP9avYVlKZ0N5xDWls8EOAvYdhvE9xac1zKR
 HbBOsDQmkP/gpZybn4HRInZnoqL5goEWKiM4SxD+lj9bZKc/I7gsK8fiKcRoQstmU4NO
 4okCV5T+Py0JsBd9lj7uUafwmzS1T+VAhWT3wh39RVLzx1lxrRJDW5wgLKkYdW7SE2xG
 ClHvv45wQq/6iPOSRw15DA50friReuLK96rCaqkOIt8u094EU/isP3Dh7ABfvsVwGANd
 7ZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2RfD0NK1m/dIXeElyGr1pmILl4sNVn7gFv/l+q+9F4M=;
 fh=2mRKpBkuEr4XcogeeCwYU0v5a6vK5Uax8y8sGzFBfgQ=;
 b=LUutdGb9/cQg29vhmOa5rUhsCDBSSglUiDlDy2moEuRHwWKQeBjRIQ+EgmHSc/tQCZ
 N3J+7Tj+RCOa2EE/kG5X9sGmyM4n2wqr7fCHw8UZ68WkECGAZCgpMt00pLPtJjbUr0c0
 UF7Ms6EGVjrksUu0p2pnYPFx82ibpn70beNnsXLecrOcLfOt6Yhj7gOZ9kx5gHrIu5WH
 rhxfKjCKo3KOwof4T4XCPQ1Je8bYAp6j2Dcytp+Zw4bn1nOLJVhPZZnDr4O2vYO82uiT
 PNiKz7cF9kb0hACZrsiTSQCYQUWygiSzHMqjX3vzGw15WwI1N+Nxo9OiTpKcyFDMCYo0
 o8gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772138822; x=1772743622; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2RfD0NK1m/dIXeElyGr1pmILl4sNVn7gFv/l+q+9F4M=;
 b=dn9VOwuZ+kkbV/PRJ+Uml+gYWoMxMccS2GSkTujtbsspqge+Qm9QOIgA8pC+WfGy9m
 OGhzw+tWSZJsXTNg4Db4W1jxYIapr2CAd3F3nhp5Lyx3Q2aBKalM3Eilmsp+jWRJY6u2
 MrStYtvWMcbrllU2eWFUyIm+tqugoDYdGr5thNPdcSuLJZ7Cbs//piEDe7mgRWl0Eodg
 A/NAbVJA88pMckPu4UODLmFDnOssGg1NYY7SarSSS/ah5fwvG0dl878YBlhJnwlS/m9o
 Fhw5AzXSv9gjQT4w3tMJ2m/B5CMNfxMf7wd/ABoIJRPGkKdTHyShqEOAUhulU/wppm6g
 fjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772138822; x=1772743622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RfD0NK1m/dIXeElyGr1pmILl4sNVn7gFv/l+q+9F4M=;
 b=j+Wc5eiQKeTdaF9LLZI1ebY0HOKx/OrlUkqQQKcsSjS7MgbHv9jKbNcVdjqGNMmKvq
 Rb9Bq3GpRfiWfY30Ouuv/jJNpTaK9kZNOEPc65b/ZZ1M+LpNtfYSGnHePerXwEItz8A5
 0/0hjGtjThRh+4OnqguCaOIfOMX/Rf78MLJGgl2MovCQpKMQdh1DoI1yGjgpv8GcxwJ4
 gtFIYyJhOByUsrAtL5i7ZMIBMZLY7QVfVeiqVcCuyuW14Efbbuj6zdm3qlRvn1RlQMfu
 kvWK/yzTLJiGo9dhGwsyBrQlYTDJWS/GkLIPRC4imniTHoyPg0pPoYyzEXz82m65V5iH
 77AQ==
X-Gm-Message-State: AOJu0Yx//U6Pyce3XV5IlJBU4icKPJUsmd29O3n9oCRNYQHURZQn2MKj
 /XkHAniG1kKdQUgSimLOzHvzQmwSt1pySImYSV10Wcn8m05MQKXLivdhLzaQwNhGikNBDbxSm83
 n6wOV/3cvHAPku/10FxkKRLOHO+txBAWzyywHMpHHEGJGYItIyHJhvpFuGZ+SSU+4IdIVjNG2t7
 FajU3/Eb47QiC1QZbXanMf+44R4x2DxIUfyNtEyHjL
X-Gm-Gg: ATEYQzzXsOajTh3EywLErZpsm9NWf6D+04xo0xsXoO99NKdhjeMln1vs1PAQz03azfZ
 iCdp+NCm1QLm4hUesOC/JE7zUuoHM1dviCpN6mUWWwCkjCa/jk2o6NtzTr+4xMFpH2ucMp/FXao
 pP/OuMVDZBzYOMNvoAoOro3w0FCWX/oqKwLzE52Hf6/3/EbV/IHkY99N4JvFLTP+bI4AwSD6TJN
 FfPTYE=
X-Received: by 2002:a05:690e:4488:b0:649:c308:90b8 with SMTP id
 956f58d0204a3-64cc2025934mr392355d50.6.1772138822157; 
 Thu, 26 Feb 2026 12:47:02 -0800 (PST)
X-Received: by 2002:a05:690e:4488:b0:649:c308:90b8 with SMTP id
 956f58d0204a3-64cc2025934mr392343d50.6.1772138821738; Thu, 26 Feb 2026
 12:47:01 -0800 (PST)
MIME-Version: 1.0
References: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 14:46:46 -0600
X-Gm-Features: AaiRm505PwIH2owKF-X4-y7m-LzbIKPy5x4F27QctC6Rfmf0MMX8V32M2tU_aXM
Message-ID: <CAEqNhNYcTQvWuYFVT7Y0TFu1yOLkKS48S+JvHkoyPnW8_272DA@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/multiarch/linux-test: use portable alternative
 for dirent64
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, laurent@vivier.eu
Content-Type: multipart/alternative; boundary="000000000000f67613064bc038f9"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4OSBTYWx0ZWRfXxW3HsPX6426t
 hu8TLEWRaTYFBMK306nHIKdHZUeaiIselhVfL8Ixx5HvuLsCm3YfpNZb4KLTxo3Ro0Bz5NRAJZM
 RmA/bQaVqsyDKdlaz3CniYzSOcmBb9bn8RfOZizRVfPcaeJUraybDGExjnfJSQA9ka/OCtTqiJs
 KJVR/cTn5RoeT5MKAGGbbN8Flo+YwQUcBsc/lpcqwxnneATudsZuBhGR4zoUx/L7fcLRjZAkZU/
 p6vRfpVw21d0u9IQUsnSQwLqhsrsJ8W/zUgBHF7AbsA5zG0brWDXgkqfW0DRNvImCpjted6P7Zp
 DKgR4E0vZx67ZwQXj9gV/Nt+LrJSnZ/HTs8jYNbaxKflHybq03AoDLeMubl7uLk22FSWB9MRsP8
 U8wp9hlObcl2oQWHnqfZ3Eiau96TjTsNu6yBxIk/LXe95AenSohAPaAmNSV1yVkAqjO44D5z3jV
 CleYVp+tKhWupOYZvEA==
X-Proofpoint-GUID: HGjebCFrzLiU0DlRlV_Eb3gda-pvO8vI
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a0b147 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=tCq-HSl-ELVsLlyTUy8A:9 a=QEXdDO2ut3YA:10
 a=j04qRQNzvzOmC0sR-oMA:9 a=64vGg_Bmrr6Wyx9g:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: HGjebCFrzLiU0DlRlV_Eb3gda-pvO8vI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f67613064bc038f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 6:08=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> dirent64 and readdir64 are glibc-specific and not portable to other
> C libraries such as musl. Define _FILE_OFFSET_BITS=3D64 instead, which
> portably instructs all libc implementations to use 64-bit file offsets,
> making readdir() and struct dirent equivalent to their 64-bit variants.
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



>  tests/tcg/multiarch/linux/linux-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/multiarch/linux/linux-test.c
> b/tests/tcg/multiarch/linux/linux-test.c
> index bf6e0fda26..0fa3165602 100644
> --- a/tests/tcg/multiarch/linux/linux-test.c
> +++ b/tests/tcg/multiarch/linux/linux-test.c
> @@ -16,6 +16,7 @@
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
> +#define _FILE_OFFSET_BITS 64
>  #define _GNU_SOURCE
>  #include <stdarg.h>
>  #include <stdlib.h>
> @@ -83,7 +84,7 @@ static void test_file(void)
>      struct utimbuf tbuf;
>      struct iovec vecs[2];
>      DIR *dir;
> -    struct dirent64 *de;
> +    struct dirent *de;
>      /* TODO: make common tempdir creation for tcg tests */
>      char template[] =3D "/tmp/linux-test-XXXXXX";
>      char *tmpdir =3D mkdtemp(template);
> @@ -191,7 +192,7 @@ static void test_file(void)
>          error("opendir");
>      len =3D 0;
>      for(;;) {
> -        de =3D readdir64(dir);
> +        de =3D readdir(dir);
>          if (!de)
>              break;
>          if (strcmp(de->d_name, ".") !=3D 0 &&
> --
> 2.37.2
>
>

--000000000000f67613064bc038f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 26, 2026 at=
 6:08=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.b=
ernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">dirent64 and=
 readdir64 are glibc-specific and not portable to other<br>
C libraries such as musl. Define _FILE_OFFSET_BITS=3D64 instead, which<br>
portably instructs all libc implementations to use 64-bit file offsets,<br>
making readdir() and struct dirent equivalent to their 64-bit variants.<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:br=
ian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0tests/tcg/multiarch/linux/linux-test.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/l=
inux/linux-test.c<br>
index bf6e0fda26..0fa3165602 100644<br>
--- a/tests/tcg/multiarch/linux/linux-test.c<br>
+++ b/tests/tcg/multiarch/linux/linux-test.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0 *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
=C2=A0 *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
=C2=A0 */<br>
+#define _FILE_OFFSET_BITS 64<br>
=C2=A0#define _GNU_SOURCE<br>
=C2=A0#include &lt;stdarg.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
@@ -83,7 +84,7 @@ static void test_file(void)<br>
=C2=A0 =C2=A0 =C2=A0struct utimbuf tbuf;<br>
=C2=A0 =C2=A0 =C2=A0struct iovec vecs[2];<br>
=C2=A0 =C2=A0 =C2=A0DIR *dir;<br>
-=C2=A0 =C2=A0 struct dirent64 *de;<br>
+=C2=A0 =C2=A0 struct dirent *de;<br>
=C2=A0 =C2=A0 =C2=A0/* TODO: make common tempdir creation for tcg tests */<=
br>
=C2=A0 =C2=A0 =C2=A0char template[] =3D &quot;/tmp/linux-test-XXXXXX&quot;;=
<br>
=C2=A0 =C2=A0 =C2=A0char *tmpdir =3D mkdtemp(template);<br>
@@ -191,7 +192,7 @@ static void test_file(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error(&quot;opendir&quot;);<br>
=C2=A0 =C2=A0 =C2=A0len =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0for(;;) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 de =3D readdir64(dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 de =3D readdir(dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!de)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(de-&gt;d_name, &quot;.&quot;) =
!=3D 0 &amp;&amp;<br>
-- <br>
2.37.2<br>
<br>
</blockquote></div></div>

--000000000000f67613064bc038f9--

