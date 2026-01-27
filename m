Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D9DD2F00B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 12:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkidg-0001Cb-Ly; Tue, 27 Jan 2026 07:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkidX-0001Bt-J8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:57:40 -0500
Received: from ci-2005f-snip4-4.eps.apple.com ([57.103.89.185]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkidV-0000fH-9I
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:57:39 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-1 (Postfix) with ESMTPS id
 A5C7118000B9; Tue, 27 Jan 2026 12:57:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769518655; x=1772110655;
 bh=UdJy6eFiFW7clNA6Eu8M0U1Sng1k71ZcFgAk9v0nwV8=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=RAsL7kr+AceQTJ15pZj4xpwMnevzEDLlXMH5Vk6Z4fpZfz7AR+dRfeKA8g51s0FIfLd9ms12e7SlCH6N6qp+sjRXAE6TOVm8KrIqO+bGRRoQ89SvfzW/ZZe0sEqsUsax0VylaUFJS5dUktdRdizY+cpsoS8E4fxRCVbJVitKztw6uE7ft3QdcJu7HqrmVLSSzYR8jWS4kX9tZTdxXxgx6kViOVT/kosPu+WiJ4ZfPNBaHGBis/geKyCxGatfLFBzrXDeBACcjmNhy/1mTovvES8a2xJATT9HOuV2xbf9L2dYL5BaPzU+F7RvMac7cAliob06ipfzvEnw0rD6b8zl3g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-1 (Postfix) with ESMTPSA id
 39D9B1800286; Tue, 27 Jan 2026 12:57:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <F1B352FC-900B-4FE2-A663-FB1236957D4D@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_96FBDC98-6FC2-421E-A3DF-318A31C94ECC"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v17 11/21] whpx: interrupt controller support
Date: Tue, 27 Jan 2026 13:57:17 +0100
In-Reply-To: <CAFEAcA9P=3izrg-D9gEZ7spj8gJtan-GQzz_mes7P0OhLzekXA@mail.gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-12-mohamed@unpredictable.fr>
 <CAFEAcA9P=3izrg-D9gEZ7spj8gJtan-GQzz_mes7P0OhLzekXA@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: SBT0sevVmmXdI8G1G_tFeVeRUhtPLyBt
X-Proofpoint-GUID: SBT0sevVmmXdI8G1G_tFeVeRUhtPLyBt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwNiBTYWx0ZWRfX8fgMOBCOVlkO
 aLwusnWayfWUvVQq0KsEbR4lGiW63gjSb09bjBgKnPu4DxzpxNyvLgub3YT3caGt433jxYdFh5/
 Kiv10lmtEIBFWU5a0k2n0x8QXnZFoBz3Ht1eoiLVzckBMt08YAHRBjTDE8UsUH4jQc08Xo6sj1F
 QVRE0ubunnFsycH3kBEORzr/D6K0qaZV5TlyuDzU65wypAqF678wTStppOMDJgcjXxLPRJy85pL
 X2JWgwzsGsafp+QTQXnC+K+fGms+Kyfvs41riqYR8vW11WpWa75eoQXszebC3+gw94Yb0RGXwuY
 KInviNVqq3BOApts3gJKjr7Lp40I6yXBHEMJpbboSCTtv+NNFdb2sbN8k2UkDs=
X-Authority-Info-Out: v=2.4 cv=B8C0EetM c=1 sm=1 tr=0 ts=6978b63e
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=3TsX8AtCq35XnXIbGjsA:9 a=QEXdDO2ut3YA:10
 a=VYeHTJg4IFKPxf76SQYA:9 a=4-1Kas2KukgXZ1X7:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1030
 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270106
X-JNJ: AAAAAAABVzlEPrwVkvEihgjYLiT6OJaj5ZGSOo7xYGxP7ZlwYmFh1YVsprZ4onT9pR34e5i8/GK01eHPBLhlVXU7FTDme527NyB3i8M672KR/ec4aHS5ZhDxEF4x3T0R61aMWLi/11T566qBMd7Gk08jiUv5pjUl6Hxn1AhkJ9ZQoVwqQyD9SSxpz0RsULTVGKy47XeRQjPZY6sIwXxYbdTWVrfYpwIdLydD5o0EfAGF8jliq5BUSi+FY0vvspaWE2G5hpkaGOD2d+ZqfSkk2AJQ4UOdakO22O9u7A9NsoCtd8/qTjTwF1cnI0putaRT7Ukt51G3xt6jflY3IHJQIfveFnsOfFXPr9q2cow37nEYwFPuxZBVAC+rJrnVW110r+MSBtX7ntKTYfI+VddCiBod9e+Tks0GOwbXtMigGt388JrklSA5H4HHhkNRezTHhVPBORNJDGVxOSCLJ26raFYufESvdOGB4kyZ8BLz1hgWdKQkXOpSMWZqphTFn33ZlpCysUEksIxCquIUC9y6uYkIb36MctAnW7vqr1SGt12pc+vj5e+jVU8Fi4DplLPj/sASOvtNoC3LomoqFlssJioEjowy2iM/kh+MMtjVSviMA0l3ZHowuiLFIvO/e8WJc9vyQgMc+n1E4qnLM+tkdBOlU38IefjpZnaAOxc1sx9NURw/tz1yiCr501Z3QtbW0yXf+ITCZ8kZdp/uU/oTdXzq3J4n6Vdov9YAosY9U5+wvF4cYfRzL+bcoo6Ks2Yyo8+3KC5mvWBCt21hYfAr9UfIjuSSq/6kV6BWaXMbo9GY0SnYAAjg/DLK+0cxnY4f8Wx8ZvQ7QlBJBCDaNPtgrgZEU4unb3iJzOgPneH8OnQb+O22Ta4fqUGJlhRw/ceutT+58KzRBBQFJGsqCGdiC89rQQhOzwivoXU=
Received-SPF: pass client-ip=57.103.89.185;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--Apple-Mail=_96FBDC98-6FC2-421E-A3DF-318A31C94ECC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 27. Jan 2026, at 12:08, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> MAINTAINERS                        |   1 +
>> hw/arm/virt.c                      |  10 ++
>> hw/intc/arm_gicv3_common.c         |   3 +
>> hw/intc/arm_gicv3_whpx.c           | 238 =
+++++++++++++++++++++++++++++
>> hw/intc/meson.build                |   1 +
>> include/hw/intc/arm_gicv3_common.h |   3 +
>> 6 files changed, 256 insertions(+)
>> create mode 100644 hw/intc/arm_gicv3_whpx.c
>=20
>> +static void whpx_gicv3_icc_reset(CPUARMState *env, const =
ARMCPRegInfo *ri)
>> +{
>> +    GICv3State *s;
>> +    GICv3CPUState *c;
>> +
>> +    c =3D env->gicv3state;
>> +    s =3D c->gic;
>> +
>> +    c->icc_pmr_el1 =3D 0;
>> +    /*
>> +     * Architecturally the reset value of the ICC_BPR registers
>> +     * is UNKNOWN. We set them all to 0 here; when the kernel
>> +     * uses these values to program the ICH_VMCR_EL2 fields that
>> +     * determine the guest-visible ICC_BPR register values, the
>> +     * hardware's "writing a value less than the minimum sets
>> +     * the field to the minimum value" behaviour will result in
>> +     * them effectively resetting to the correct minimum value
>> +     * for the host GIC.
>> +     */
>> +    c->icc_bpr[GICV3_G0] =3D 0;
>> +    c->icc_bpr[GICV3_G1] =3D 0;
>> +    c->icc_bpr[GICV3_G1NS] =3D 0;
>> +
>> +    c->icc_sre_el1 =3D 0x7;
>> +    memset(c->icc_apr, 0, sizeof(c->icc_apr));
>> +    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
>> +
>> +    if (s->migration_blocker) {
>> +        return;
>> +    }
>=20
> Looking a bit more closely at this, this is odd. Why the early
> return? This looks like it was copied from the KVM GICv3
> from prior to commit 59ad421d6. But in the KVM code before
Hello,

Indeed it was, will remove this from the HVF nested virt series too=E2=80=A6=

And update to use s->migration_blocker for "whpx: arm64: gicv3: add =
migration blocker=E2=80=9D
(which I=E2=80=99ll squash into =E2=80=9Cwhpx: interrupt controller =
support=E2=80=9D)

Thank you,
> that commit, the reason for the early return is to avoid
> the "read the ICC_CTLR value from KVM" call that won't work
> (the migration blocker is for the "no KVM API to read/write
> GIC registers" case). And in the KVM code after that commit,
> we restructured the reset to not read the register in the
> reset function, so we don't need to test s->migration_blocker
> at all then.
>=20
> Probably you want to follow the pattern the newer KVM code
> uses, but either way, this early return doesn't make much
> sense for this whpx code as it stands, especially as the
> whpx code isn't currently setting s->migration_blocker...
>=20
>> +
>> +    c->icc_ctlr_el1[GICV3_S] =3D c->icc_ctlr_el1[GICV3_NS];
>> +}
>=20
> thanks
> -- PMM
>=20


--Apple-Mail=_96FBDC98-6FC2-421E-A3DF-318A31C94ECC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 27. Jan 2026, at 12:08, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Wed, 21 Jan 2026 at =
13:41, Mohamed Mediouni &lt;mohamed@unpredictable.fr&gt; =
wrote:<br><blockquote type=3D"cite"><br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br> MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;1 +<br> hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;10 ++<br> =
hw/intc/arm_gicv3_common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 +<br> =
hw/intc/arm_gicv3_whpx.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 238 =
+++++++++++++++++++++++++++++<br> hw/intc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br> include/hw/intc/arm_gicv3_common.h =
| &nbsp;&nbsp;3 +<br> 6 files changed, 256 insertions(+)<br> create mode =
100644 hw/intc/arm_gicv3_whpx.c<br></blockquote><br><blockquote =
type=3D"cite">+static void whpx_gicv3_icc_reset(CPUARMState *env, const =
ARMCPRegInfo *ri)<br>+{<br>+ &nbsp;&nbsp;&nbsp;GICv3State *s;<br>+ =
&nbsp;&nbsp;&nbsp;GICv3CPUState *c;<br>+<br>+ &nbsp;&nbsp;&nbsp;c =3D =
env-&gt;gicv3state;<br>+ &nbsp;&nbsp;&nbsp;s =3D c-&gt;gic;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_pmr_el1 =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;/*<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* Architecturally the =
reset value of the ICC_BPR registers<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* is =
UNKNOWN. We set them all to 0 here; when the kernel<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* uses these values to program the ICH_VMCR_EL2 =
fields that<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* determine the guest-visible =
ICC_BPR register values, the<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* hardware's =
"writing a value less than the minimum sets<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* the field to the minimum value" behaviour will =
result in<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* them effectively resetting to =
the correct minimum value<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* for the host =
GIC.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_bpr[GICV3_G0] =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_bpr[GICV3_G1] =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_bpr[GICV3_G1NS] =3D 0;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_sre_el1 =3D 0x7;<br>+ =
&nbsp;&nbsp;&nbsp;memset(c-&gt;icc_apr, 0, sizeof(c-&gt;icc_apr));<br>+ =
&nbsp;&nbsp;&nbsp;memset(c-&gt;icc_igrpen, 0, =
sizeof(c-&gt;icc_igrpen));<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(s-&gt;migration_blocker) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br></blockquote><br>Looking a bit more closely at =
this, this is odd. Why the early<br>return? This looks like it was =
copied from the KVM GICv3<br>from prior to commit 59ad421d6. But in the =
KVM code =
before<br></div></div></blockquote>Hello,</div><div><br></div><div>Indeed =
it was, will remove this from the HVF nested virt series =
too=E2=80=A6</div><div>And update to use s-&gt;migration_blocker for =
"<span style=3D"color: rgba(0, 0, 0, 0.85); font-family: &quot;Helvetica =
Neue&quot;;">whpx: arm64: gicv3: add migration blocker</span><font =
face=3D"Helvetica Neue"><span style=3D"caret-color: rgba(0, 0, 0, 0.85); =
color: rgba(0, 0, 0, 0.85);">=E2=80=9D</span></font></div><div><font =
face=3D"Helvetica Neue"><span style=3D"caret-color: rgba(0, 0, 0, 0.85); =
color: rgba(0, 0, 0, 0.85);">(which I=E2=80=99ll squash into =E2=80=9Cwhpx=
: interrupt controller support=E2=80=9D)</span></font></div><div><font =
face=3D"Helvetica Neue"><span style=3D"caret-color: rgba(0, 0, 0, 0.85); =
color: rgba(0, 0, 0, 0.85);"><br></span></font></div><div><font =
face=3D"Helvetica Neue"><span style=3D"caret-color: rgba(0, 0, 0, 0.85); =
color: rgba(0, 0, 0, 0.85);">Thank =
you,</span></font></div><div><blockquote type=3D"cite"><div><div>that =
commit, the reason for the early return is to avoid<br>the "read the =
ICC_CTLR value from KVM" call that won't work<br>(the migration blocker =
is for the "no KVM API to read/write<br>GIC registers" case). And in the =
KVM code after that commit,<br>we restructured the reset to not read the =
register in the<br>reset function, so we don't need to test =
s-&gt;migration_blocker<br>at all =
then.</div></div></blockquote><blockquote =
type=3D"cite"><div><div><br>Probably you want to follow the pattern the =
newer KVM code<br>uses, but either way, this early return doesn't make =
much<br>sense for this whpx code as it stands, especially as the<br>whpx =
code isn't currently setting =
s-&gt;migration_blocker...<br><br><blockquote type=3D"cite">+<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_ctlr_el1[GICV3_S] =3D =
c-&gt;icc_ctlr_el1[GICV3_NS];<br>+}<br></blockquote><br>thanks<br>-- =
PMM<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_96FBDC98-6FC2-421E-A3DF-318A31C94ECC--

