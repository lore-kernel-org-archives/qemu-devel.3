Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA11FE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 03:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsYI5-00084f-4s; Tue, 17 Feb 2026 22:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vsYI2-00084F-Hq
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 22:31:50 -0500
Received: from p-east2-cluster1-host3-snip4-10.eps.apple.com ([57.103.76.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vsYI1-0005Ou-1S
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 22:31:50 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 5BF02180009A; Wed, 18 Feb 2026 03:31:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771385508; x=1773977508;
 bh=9eIki2jdTlI67LaSEqdH3Ogz9CEP5EaBbksZCxlOPb8=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=fqaJ8uwCNNzKn9oRCkSRTg7vSB11tb7z96J2sOMnNAd+z+WOE0qpwrPHbeY/wCZx2zI6xuvgKUUBjZwAlvWDfg8rLZniOmnSXG/+k5g653uM+KwXvtumKCdLUgzLe0PuhsUFFVArI9gzKNud07SmXTNCG3MiA86i8bq0eiPk+CVNFkixKI+4Ata1q0lJyvu0sww6LeoPrfcf9dR4HqSaB6MGv2/wGbQ2BvB0PE5Mvc5q9dnUqGKR211FbK1uTs1FEoaNX/63dNh+O021QXgj+3QZZF3kt9mYw7uLhb3FP7aeb7PxFtpZOvF1eegtyiR15r0TAuBEUvPmTtpO75f3rA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 8905118000F1; Wed, 18 Feb 2026 03:31:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <D58BE88F-9629-4886-B0AA-DD833AC88D74@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_65AF2D6E-D2A4-4DA8-92C1-3398673E31E2"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] whpx: fix FP register loop
Date: Wed, 18 Feb 2026 04:31:31 +0100
In-Reply-To: <20260217210805.104427-1-osama.abdelkader@gmail.com>
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
To: Osama Abdelkader <osama.abdelkader@gmail.com>
References: <20260217210805.104427-1-osama.abdelkader@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: gEdh-8hd5rJoa8mlx_-wKHMmSCVdBeTO
X-Proofpoint-ORIG-GUID: gEdh-8hd5rJoa8mlx_-wKHMmSCVdBeTO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDAyOSBTYWx0ZWRfX2+shEDgxsP16
 WGaye0uOLzX+hZHFdmYSLB22io4Xw7kYWca79eSVHfslUomX0iRy1DgLKmGobnpn1nZh5yzlbIu
 IeVchhg2jNzz+UIMOH2YJ4c7eyDgBYujlnaQSqyGsRwRBlTuCd8v0uXZ1DS8bUH4kpuoaS5X4uN
 0Nk/TchsIEqPrh0hYrUYgdvvhSgfICLhuhAXfJ/mxtHdXElrykl9UkEdLvuSIrKFuDhyasi9USn
 zmbtjg6aiFnVFLz/NpQRW5/Mdt8tLjjlBpnuw0g4Fmw0QQ/SfVZ0v3yWQQkKsyOheMgONgBELwR
 DFJPk/lYegn9ZVsscyD/2XG6ss5GJux2XbAOAOvWKqsxUmRuVLLl1XHrf71aeU=
X-Authority-Info-Out: v=2.4 cv=G6IR0tk5 c=1 sm=1 tr=0 ts=699532a2
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=Nm3HiP7PBx0Bg88O27kA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=zX2X_24SlQdIqLFkdPQA:9 a=oIcGjva_s8TGZmfV:21 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=796 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180029
X-JNJ: AAAAAAAB0oJvQyr1OmxHtZ9TauRmttYuNlL3KuGuiUv8yEzOMKhMNgkYSvfYLH1+Wuw/uoQ16QF+9iCi914iF1lKxcnLC3uJ0UvtaYCYqyKVcfRZALNZFMA1USUHSDKXTOGOtqD0FXV+p72L6DhEoJbWM8FVlyO92fQs3BK+4aQrfkFTiFWbZ/TW/6PqNq8aAhwuaGYUbSqNHwbbxLR+H2hRoAm3MTwl+7AuBbjHljzmIRRKoTiQEjhIoWPNP5s+Xvb+0wuf6YYNC+r7j6p0Fq+0K+Vokpp6AzcE5E+Z9ahulkXK8ZImvDfmFkBhFwynSZzW8K+PzHMEN63HPpmpa5VhO8ysKQMuNJ5Qzj9c3WPNOgO25zq8ukc43x4a9jFMo7RPK4mfmUiXxypan5A7fm+BHgeVULdznsvmP6WmZt7gDNAxh2e7L7jsUeAprF28Dd4eHEJtxHPtPrwP2jNuq/IfKY6ibU9M0bgUFD6XQmLtJmNYai9HEd3NKYbhStowmRh0A5zBa0yj3DVG5swcRXfyd+i+nCllKKsJykM4N8MMTs505IPCReq9m0XUNmZ5ioEBQ9YbDBYxXlHWpw80ZSuMuVWjwDOnxSy6UA6NJ/KkQf6dzJTscqzvZzOmOBysy7dVc1boQzqx1iP755k=
Received-SPF: pass client-ip=57.103.76.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_65AF2D6E-D2A4-4DA8-92C1-3398673E31E2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 17. Feb 2026, at 22:08, Osama Abdelkader =
<osama.abdelkader@gmail.com> wrote:
>=20
> In whpx_get_registers and whpx_set_registers the loops over FP =
registers
> were using whpx_reg_match[i].reg instead of whpx_fpreg_match[i].reg
>=20
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr =
<mailto:mohamed@unpredictable.fr>>

Thank you,
> target/arm/whpx/whpx-all.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index b0602266af..40ada2d5b6 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -554,7 +554,7 @@ void whpx_get_registers(CPUState *cpu)
>     }
>=20
>     for (i =3D 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
> -        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
> +        whpx_get_reg(cpu, whpx_fpreg_match[i].reg, &val);
>         memcpy((char *)env + whpx_fpreg_match[i].offset, &val, =
sizeof(val.Reg128));
>     }
>=20
> @@ -605,7 +605,7 @@ void whpx_set_registers(CPUState *cpu, int level)
>=20
>     for (i =3D 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
>         memcpy(&val.Reg128, (char *)env + whpx_fpreg_match[i].offset, =
sizeof(val.Reg128));
> -        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
> +        whpx_set_reg(cpu, whpx_fpreg_match[i].reg, val);
>     }
>=20
>     clean_whv_register_value(&val);
> --=20
> 2.43.0
>=20


--Apple-Mail=_65AF2D6E-D2A4-4DA8-92C1-3398673E31E2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 17. Feb 2026, at 22:08, Osama Abdelkader =
&lt;osama.abdelkader@gmail.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>In whpx_get_registers and =
whpx_set_registers the loops over FP registers<br>were using =
whpx_reg_match[i].reg instead of =
whpx_fpreg_match[i].reg<br><br>Signed-off-by: Osama Abdelkader =
&lt;osama.abdelkader@gmail.com&gt;<br>---<br></div></div></blockquote><div=
><br></div>Reviewed-by: Mohamed Mediouni &lt;<a =
href=3D"mailto:mohamed@unpredictable.fr">mohamed@unpredictable.fr</a>&gt;<=
/div><div><br></div><div>Thank you,</div><div><blockquote =
type=3D"cite"><div><div>target/arm/whpx/whpx-all.c | 4 ++--<br> 1 file =
changed, 2 insertions(+), 2 deletions(-)<br><br>diff --git =
a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c<br>index =
b0602266af..40ada2d5b6 100644<br>--- a/target/arm/whpx/whpx-all.c<br>+++ =
b/target/arm/whpx/whpx-all.c<br>@@ -554,7 +554,7 @@ void =
whpx_get_registers(CPUState *cpu)<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(whpx_fpreg_match); i++) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
whpx_reg_match[i].reg, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
whpx_fpreg_match[i].reg, &amp;val);<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memcpy((char *)env + =
whpx_fpreg_match[i].offset, &amp;val, sizeof(val.Reg128));<br> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>@@ -605,7 +605,7 @@ void =
whpx_set_registers(CPUState *cpu, int level)<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(whpx_fpreg_match); i++) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memcpy(&amp;val.Reg128, =
(char *)env + whpx_fpreg_match[i].offset, sizeof(val.Reg128));<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, =
whpx_reg_match[i].reg, val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, =
whpx_fpreg_match[i].reg, val);<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;clean_whv_register_value(&amp;val);<br>-- =
<br>2.43.0<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_65AF2D6E-D2A4-4DA8-92C1-3398673E31E2--

