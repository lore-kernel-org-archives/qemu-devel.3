Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F57D3EE89
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwxg-0005U0-Jw; Thu, 22 Jan 2026 10:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viwxa-0005R1-1U
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:51:02 -0500
Received: from p-east2-cluster4-host4-snip4-10.eps.apple.com ([57.103.78.151]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viwxX-0006sa-4E
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:51:01 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPS id
 521B918000AE; Thu, 22 Jan 2026 15:50:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769097057; x=1771689057;
 bh=/YYlK83B2a5Y5dWj//edHaHiElaR4KTXjqiTf0YRo5k=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=DuJvGuSZWuMaUb24aNClUSPcq4jQpfj/XderfPMwqOzJb3urz+yVh3W24MUzvr7Q1tvbOJ4IsldwQdPrKEXpMrHZRJSZETd3Ub0KGRN3WiHYM8uyeomDeXoGDnGoNPZQmbhQQIRPPmClLIeQ5tEjh6QzMBpLxKGbumhcn5lsLQljUMbOQsKnHSZyRn0RUX4msuvbwuVowXH7qIl0IPGR0mEocD7fo5uYNOMBPVH3+gdk8nk12vypztmuYttwTF6+92PH8RkjIZwoSEbreBNYli7+HEjE8vFlJ7KdlvZ+yqcrwMkPEpCHDJiy3uYxJNTk/6Meg3rlcznDj5J1L4FtcA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPSA id
 1B4831800552; Thu, 22 Jan 2026 15:50:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <E5004617-75B2-44E6-BB28-C2FD530395AB@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C3E2335A-4B40-45EB-AF6E-6CDCC3F951BB"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [RFC PATCH 1/4] hw/arm/virt: Clean up MSI controller selection
 logic
Date: Thu, 22 Jan 2026 16:50:40 +0100
In-Reply-To: <20260120180339.1416328-2-peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <20260120180339.1416328-2-peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: CIH9Y3TgV7kh5AnACrjWgmg2R5gxwUQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMSBTYWx0ZWRfX7s7QrML2j4hp
 zQ5Q6wjzSpQij6JGO6sC2NlfpLR1E/P7zzABph0nM2PwbDSQ2x4xV0qrQ2yBMY3eiJsbqNo9dxF
 FjKxEsO2467WkTWEM1kFfueCU4PfWwCJL8x+/bSmwwkG4DuJjEMx3BSnPOSbVevhGjekdz2amgG
 sQ9TR/pBvyUGNg1duQWPSQa+rBSttMOMcTrLuB9Z+7Oj5RVl/MIKbRYlOdMWG5GsRAIZD3O1d2a
 k7q+39je+Dcro9rl9sdqx+FcADtrJ6Wn3L5bIVs9G+FXYVRUSIDpYynnaP1dbWzm6K0QqhXrn9E
 /JOii9K0DgeFHwrinbH
X-Proofpoint-GUID: CIH9Y3TgV7kh5AnACrjWgmg2R5gxwUQt
X-Authority-Info-Out: v=2.4 cv=R5QO2NRX c=1 sm=1 tr=0 ts=69724760
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GaQpPoNlAAAA:8 a=KKAkSRfTAAAA:8 a=LRXGz7Tvt5eVrWHidiIA:9 a=CjuIK1q_8ugA:10
 a=p6CN9gModW6Y-JCh0AQA:9 a=RxrMMwE0p55oQWA8:21 a=_W_S_7VecoQA:10
 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601220121
X-JNJ: AAAAAAABj+mz/fHdoPgU8AeolSBKmWYXFfRDq8gAC04EH8tJ1lJeZ6CIrtt1HLfWz2VKjJEEqMNXWHhxfKlAL70yHAxWVTHthUCwKtgMRiuwl8GrTNE0J1OQLcUkFX3QRzb2HoiwWzKPJB7YLiKkoh4PIVETiNZXjqpVOuS+QVqa7jA8GI6R5HIhpvAj1Dqkqhz0rD/ByWTFic7SDDCz9u6eQWgmbPViLVk0x5gNhU+lEMmWeUL+Nk30LDLh2VZcaodGtJQJKG+1QtLIOxSOvDiryKN0qhn0x52kWKJGUc2Yxg9X1ypNRcQvUnht/NGkSa+U7KuWKl5G5U/BHsIbQCMPBvB04vAlyjQ5TfeCE5qTTxoIxtOmNBaIHMqeck39bZkgT56xFIwNOc+jC1RGy9pBX0hDtt/Zhhrysq9xcJs4C3ZOjV2deMxAMJL8o+/N0L1meyzPbl0BwaN92MJjHe9acgcwjtqWASivEdyaBf4fvmJKZe+6ohH7oNxeCEamN4SbnGW6Pct14Tei6KqRaFHyqTUYbA7CzU3OUSou3nG8l1C8lR7tIF1r+YlyVdzkEVHB/MGoQzayylav0jy3bDTZbS5Wyh0OmjvjFWJibOMCPZjPiuJjDPTHD3s8rICC5HkHF1Zs+qa1CY+R+xYLGqbM4aAiak2IdgHNmOMVWg1TAvKWYcvVyOqPqgN2S5anU+jP807cEePb
Received-SPF: pass client-ip=57.103.78.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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


--Apple-Mail=_C3E2335A-4B40-45EB-AF6E-6CDCC3F951BB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 20. Jan 2026, at 19:03, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> The virt board might have multiple different ways to handle MSI
> interrupts: via an ITS, via the GICv2M device, or not at all.  The
> logic to select which of these we use is confusing because it is
> controlled by a mix of versioned-board compatibility flags, board
> option flags, and open-coded logic inside the create_gic() and
> create_its() functions.
>=20
> Currently we set VirtMachineState::msi_controller as the very last
> part of this, inside create_its() or create_gicv2m().  This field is
> then used only in the hotplug pre-plug callback function.
>=20
> As a first step in making this clearer to understand, move the logic
> into a single finalize_msi_controller() function, which sets
> VirtMachineState::msi_controller.  The actual machine creation code
> can then look only at that field.  (This is a parallel to what we do
> with the GIC, where finalize_gic_version() sets the
> VirtMachineState::gic_version field.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hello,

Did put a separate implementation of a chunk of this patch as part of =
https://patchew.org/QEMU/20260121134114.9781-1-mohamed@unpredictable.fr/20=
260121134114.9781-4-mohamed@unpredictable.fr/

Thank you,

> ---
> hw/arm/virt.c | 38 +++++++++++++++++++++++++++-----------
> 1 file changed, 27 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4badc1a734..b55297455f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -738,13 +738,6 @@ static void create_its(VirtMachineState *vms)
>     DeviceState *dev;
>=20
>     assert(vms->its);
> -    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
> -        /*
> -         * Do nothing if ITS is neither supported by the host nor =
emulated by
> -         * the machine.
> -         */
> -        return;
> -    }
>     dev =3D qdev_new(its_class_name());
>=20
> @@ -754,7 +747,6 @@ static void create_its(VirtMachineState *vms)
>     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, =
vms->memmap[VIRT_GIC_ITS].base);
>=20
>     fdt_add_its_gic_node(vms);
> -    vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
> }
>=20
> static void create_v2m(VirtMachineState *vms)
> @@ -775,7 +767,6 @@ static void create_v2m(VirtMachineState *vms)
>     }
>=20
>     fdt_add_v2m_gic_node(vms);
> -    vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
> }
>=20

Parts above still apply even after that patch.

> /*
> @@ -957,10 +948,15 @@ static void create_gic(VirtMachineState *vms, =
MemoryRegion *mem)
>=20
>     fdt_add_gic_node(vms);
>=20
> -    if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && vms->its) {
> +    switch (vms->msi_controller) {
> +    case VIRT_MSI_CTRL_NONE:
> +        break;
> +    case VIRT_MSI_CTRL_ITS:
>         create_its(vms);
> -    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
> +        break;
> +    case VIRT_MSI_CTRL_GICV2M:
>         create_v2m(vms);
> +        break;
>     }
> }
>=20
> @@ -2079,6 +2075,24 @@ static VirtGICType =
finalize_gic_version_do(const char *accel_name,
>     return gic_version;
> }
>=20
> +static void finalize_msi_controller(VirtMachineState *vms)
> +{
> +    /*
> +     * Determine the final msi_controller according to
> +     * the relevant user settings and compat data. Called
> +     * after finalizing the GIC version.
> +     */
> +    if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && vms->its) {
> +        if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
> +            vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
> +        } else {
> +            vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
> +        }
> +    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
> +        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
> +    }
> +}
> +
> /*
>  * finalize_gic_version - Determines the final gic_version
>  * according to the gic-version property
> @@ -2251,6 +2265,8 @@ static void machvirt_init(MachineState *machine)
>      * KVM is not available yet
>      */
>     finalize_gic_version(vms);
> +    /* MSI controller type depends on GIC version */
> +    finalize_msi_controller(vms);
>=20
>     if (vms->secure) {
>         /*
> --=20
> 2.47.3
>=20
>=20


--Apple-Mail=_C3E2335A-4B40-45EB-AF6E-6CDCC3F951BB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 20. Jan 2026, at 19:03, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>The virt board might have =
multiple different ways to handle MSI<br>interrupts: via an ITS, via the =
GICv2M device, or not at all. &nbsp;The<br>logic to select which of =
these we use is confusing because it is<br>controlled by a mix of =
versioned-board compatibility flags, board<br>option flags, and =
open-coded logic inside the create_gic() and<br>create_its() =
functions.<br><br>Currently we set VirtMachineState::msi_controller as =
the very last<br>part of this, inside create_its() or create_gicv2m(). =
&nbsp;This field is<br>then used only in the hotplug pre-plug callback =
function.<br><br>As a first step in making this clearer to understand, =
move the logic<br>into a single finalize_msi_controller() function, =
which sets<br>VirtMachineState::msi_controller. &nbsp;The actual machine =
creation code<br>can then look only at that field. &nbsp;(This is a =
parallel to what we do<br>with the GIC, where finalize_gic_version() =
sets the<br>VirtMachineState::gic_version field.)<br><br>Signed-off-by: =
Peter Maydell =
&lt;peter.maydell@linaro.org&gt;<br></div></div></blockquote><div><br></di=
v><div>Hello,</div><div><br></div><div>Did put a separate implementation =
of a chunk of this patch as part of&nbsp;<a =
href=3D"https://patchew.org/QEMU/20260121134114.9781-1-mohamed@unpredictab=
le.fr/20260121134114.9781-4-mohamed@unpredictable.fr/">https://patchew.org=
/QEMU/20260121134114.9781-1-mohamed@unpredictable.fr/20260121134114.9781-4=
-mohamed@unpredictable.fr/</a></div><div><br></div><div>Thank =
you,</div><div><br></div><blockquote type=3D"cite"><div><div>---<br> =
hw/arm/virt.c | 38 +++++++++++++++++++++++++++-----------<br> 1 file =
changed, 27 insertions(+), 11 deletions(-)<br><br>diff --git =
a/hw/arm/virt.c b/hw/arm/virt.c<br>index 4badc1a734..b55297455f =
100644<br>--- a/hw/arm/virt.c<br>+++ b/hw/arm/virt.c<br>@@ -738,13 =
+738,6 @@ static void create_its(VirtMachineState *vms)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;DeviceState *dev;<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;assert(vms-&gt;its);<br>- &nbsp;&nbsp;&nbsp;if =
(!kvm_irqchip_in_kernel() &amp;&amp; !vms-&gt;tcg_its) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Do nothing if ITS is =
neither supported by the host nor emulated by<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* the machine.<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>- =
&nbsp;&nbsp;&nbsp;}<br> &nbsp;&nbsp;&nbsp;&nbsp;dev =3D =
qdev_new(its_class_name());<br><br>@@ -754,7 +747,6 @@ static void =
create_its(VirtMachineState *vms)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, =
vms-&gt;memmap[VIRT_GIC_ITS].base);<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;fdt_add_its_gic_node(vms);<br>- =
&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D VIRT_MSI_CTRL_ITS;<br> =
}<br><br> static void create_v2m(VirtMachineState *vms)<br>@@ -775,7 =
+767,6 @@ static void create_v2m(VirtMachineState *vms)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;fdt_add_v2m_gic_node(vms);<br>- =
&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D VIRT_MSI_CTRL_GICV2M;<br> =
}<br><br></div></div></blockquote><div><br></div>Parts above still apply =
even after that patch.</div><div><br></div><div><blockquote =
type=3D"cite"><div><div> /*<br>@@ -957,10 +948,15 @@ static void =
create_gic(VirtMachineState *vms, MemoryRegion *mem)<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;fdt_add_gic_node(vms);<br><br>- =
&nbsp;&nbsp;&nbsp;if (vms-&gt;gic_version !=3D VIRT_GIC_VERSION_2 =
&amp;&amp; vms-&gt;its) {<br>+ &nbsp;&nbsp;&nbsp;switch =
(vms-&gt;msi_controller) {<br>+ &nbsp;&nbsp;&nbsp;case =
VIRT_MSI_CTRL_NONE:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_ITS:<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_its(vms);<br>- =
&nbsp;&nbsp;&nbsp;} else if (vms-&gt;gic_version =3D=3D =
VIRT_GIC_VERSION_2) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_GICV2M:<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_v2m(vms);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br> }<br><br>@@ -2079,6 +2075,24 @@ static =
VirtGICType finalize_gic_version_do(const char *accel_name,<br> =
&nbsp;&nbsp;&nbsp;&nbsp;return gic_version;<br> }<br><br>+static void =
finalize_msi_controller(VirtMachineState *vms)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;/*<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* Determine the final =
msi_controller according to<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* the relevant =
user settings and compat data. Called<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* =
after finalizing the GIC version.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;if (vms-&gt;gic_version !=3D VIRT_GIC_VERSION_2 =
&amp;&amp; vms-&gt;its) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!kvm_irqchip_in_kernel() =
&amp;&amp; !vms-&gt;tcg_its) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;=
msi_controller =3D VIRT_MSI_CTRL_NONE;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;=
msi_controller =3D VIRT_MSI_CTRL_ITS;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;} =
else if (vms-&gt;gic_version =3D=3D VIRT_GIC_VERSION_2) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_GICV2M;<br>+ &nbsp;&nbsp;&nbsp;}<br>+}<br>+<br> /*<br> =
&nbsp;* finalize_gic_version - Determines the final gic_version<br> =
&nbsp;* according to the gic-version property<br>@@ -2251,6 +2265,8 @@ =
static void machvirt_init(MachineState *machine)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* KVM is not available yet<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br> =
&nbsp;&nbsp;&nbsp;&nbsp;finalize_gic_version(vms);<br>+ =
&nbsp;&nbsp;&nbsp;/* MSI controller type depends on GIC version */<br>+ =
&nbsp;&nbsp;&nbsp;finalize_msi_controller(vms);<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;if (vms-&gt;secure) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>-- =
<br>2.47.3<br><br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_C3E2335A-4B40-45EB-AF6E-6CDCC3F951BB--

