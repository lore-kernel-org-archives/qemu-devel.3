Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03F2E9E2FD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9g1-0001zs-6H; Wed, 11 Feb 2026 07:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq9fp-0001tc-GY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:50:35 -0500
Received: from p-west1-cluster2-host12-snip4-2.eps.apple.com ([57.103.64.163]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq9fn-0004hz-3b
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:50:29 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPS id
 D15481800117; Wed, 11 Feb 2026 12:50:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770814225; x=1773406225;
 bh=PkO7QhcIz3BSWEWR/aAKYBlasweO+kXbyg6UbvNuN8Y=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=BM6c7TLYzE+H/D5a0Pczn1IvWUh/p6XJ9GqN/4s+71E9UHcGuF0ExIwuxX8p3PpnnuOItJ66RK9FFfNOazG3H9aYHQE+0buFH4RSORKsX8h/uTlTdZ5a6j07v1t6LoSxx9NdEvK1GsxhrMQ22O5TAerl23zaKcYRQzBiSHdwQHMMfkuYkRgCNTvgNiTfJboGdsFHrxWuZ2Q7/4ytNbz8+MSmCNy46rBdgch/X/ylJqXdr8nLWTzQ50fKibcejX3RPmINUH9wKFskCvVnuoUy606uxAHozI+HofrtZjkKX8QXwHSfihrtwKdw0lMqPyNYM4cBtS5rH6hYjXVi/GE5CQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPSA id
 6840A1800111; Wed, 11 Feb 2026 12:50:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260211122759.125094-1-mbawa@redhat.com>
Date: Wed, 11 Feb 2026 13:50:07 +0100
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, cohuck@redhat.com,
 eric.auger@redhat.com, sebott@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
References: <20260211122759.125094-1-mbawa@redhat.com>
To: Mohammadfaiz Bawa <mbawa@redhat.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA5OSBTYWx0ZWRfX8ZxBsoM2GLVL
 hUcAZ4WN0XJHoQtk27/llfmEChjhEWPakITWDf+mNow29U/UDY52D1yqe4nQ/PmxzsJz3DJn/De
 I+5V2T5gfk1R03B6S5i7AE1Gqvupoq5LeunB4M0R7qzyJH7sIFqzlkeP6GGfokingO6Nt67OMX6
 UJ4sPHTCKa0CtV0GoAfRNd1dtrOA3Q6ecE1d961OVaV3FS3GLxAC7xCzsdeHdgwmX8herUbFLAe
 NprYNTHVdCXAK1KGHYnY3c/+YX+o0wD/OyVODKUtHltcqzhHieYzAhZ0wuezvJ5ytcPcd3JE6Lo
 OngT8BqZQrxISG51mgCc49PlCAG4fVj3HkB8b0ePCXpiM3cXqTEiMaRzRCIKfA=
X-Authority-Info-Out: v=2.4 cv=R9kO2NRX c=1 sm=1 tr=0 ts=698c7b0e
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=LAw_7nYPxDqIoJCGddAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NfBUDsXmwqxCgRDzWERw3bgcUiV0mj_U
X-Proofpoint-ORIG-GUID: NfBUDsXmwqxCgRDzWERw3bgcUiV0mj_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 clxscore=1030 spamscore=0
 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110099
X-JNJ: AAAAAAABDudivjybb55MU2wK97mwMKWxkVTd7UvZnNysnhiEzKAJi+4ZdhsZH0ngP8/SnkPsHc5vIyo0ZeOFHUAny0cxQARYSxN86UwLAIZ6uqbakHz7VrvCJ262SqsMCk1swEZv4oKgvMQm4L7vfUmy6ZE/Wme1lNk58ijQDUClmcY6TMrgW6WvP6501oL953vZqZWXIVAehKnOSbcmJISlrEDr15zETfj8q+NRIyguqeZfl7ASTQ9iCkYaWbFdh0bdXJNckL3GCkIUwyQBi8AKKYKjM0xPLfjfic6cQFwgHTN/ts41gTILN9qy8gtscGjipCppE/fHKBBm5gDMuAy6/n6GPqG2/TRLPtvVbbHRIHOaA+CB4IfQWec/Z8RuUYyFOFuqqz6nJiT3KZ7/ApR/0I13pPFkQm5w0E8Q8DIWesW06yQLicxKsRF0T+akbz/mNBiu1LCZmbPix7T3s+Kgs9I3ZkrTAaol6WxSpugLRk1PUefUPDc9CtojfEaxqAIyLfTZ+1O+MYLaWBSEprjnO3fiSN0C3QWHsSyhquYk3+eqLaokAq7xZkOwW+D+9FuJzzLHSeZoRF8BmrH8dE8ByakjnNaKf7YpxJyWw/ZFndKxDo6fVzcP9YZGxffvRi8A3+51PZf2AThARt7FDYnKN12/Ao0+cOtSAniUZPlK6/F5MWFcC0pxnnYx/HrCYBjOYEZXE5Z+
Received-SPF: pass client-ip=57.103.64.163;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 11. Feb 2026, at 13:27, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>=20
> Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> tables even when no backend is attached. This causes "Unknown
> devices" (ACPI\LNRO0005) to appear in Device Manager.
>=20
> Until Windows fixes that by supporting, adding a new machine
> property 'virtio-transports' to control the number of
> virtio-mmio transports instantiated. The default remains
> NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> Setting it to 0 allows users to disable virtio-mmio entirely.
>=20
> Usage: -machine virt,virtio-transports=3D0

Hello,

With keeping in mind that this was documented in this (closed=E2=80=A6) =
issue
https://github.com/virtio-win/kvm-guest-drivers-windows/issues/595

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

>=20
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
> hw/arm/virt-acpi-build.c |  2 +-
> hw/arm/virt.c            | 43 ++++++++++++++++++++++++++++++++++++++--
> include/hw/arm/virt.h    |  1 +
> 3 files changed, 43 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c145678185..27c007fd62 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1150,7 +1150,7 @@ build_dsdt(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
>     virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base, =
memmap[VIRT_MMIO].size,
>                          (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> -                         0, NUM_VIRTIO_TRANSPORTS);
> +                         0, vms->virtio_transports);
>     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, =
vms);
>     if (vms->acpi_dev) {
>         build_ged_aml(scope, "\\_SB."GED_DEVICE,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 390845c503..0a659ba540 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1206,7 +1206,7 @@ static void create_virtio_devices(const =
VirtMachineState *vms)
>      * between kernel versions). For reliable and stable =
identification
>      * of disks users must use UUIDs or similar mechanisms.
>      */
> -    for (i =3D 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
> +    for (i =3D 0; i < vms->virtio_transports; i++) {
>         int irq =3D vms->irqmap[VIRT_MMIO] + i;
>         hwaddr base =3D vms->memmap[VIRT_MMIO].base + i * size;
>=20
> @@ -1221,7 +1221,7 @@ static void create_virtio_devices(const =
VirtMachineState *vms)
>      * loop influences virtio device to virtio transport assignment, =
whereas
>      * this loop controls how virtio transports are laid out in the =
dtb.
>      */
> -    for (i =3D NUM_VIRTIO_TRANSPORTS - 1; i >=3D 0; i--) {
> +    for (i =3D vms->virtio_transports - 1; i >=3D 0; i--) {
>         char *nodename;
>         int irq =3D vms->irqmap[VIRT_MMIO] + i;
>         hwaddr base =3D vms->memmap[VIRT_MMIO].base + i * size;
> @@ -2705,6 +2705,36 @@ static void virt_set_highmem_mmio_size(Object =
*obj, Visitor *v,
>     extended_memmap[VIRT_HIGH_PCIE_MMIO].size =3D size;
> }
>=20
> +static void virt_get_virtio_transports(Object *obj, Visitor *v,
> +                                       const char *name, void =
*opaque,
> +                                       Error **errp)
> +{
> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> +    uint8_t transports =3D vms->virtio_transports;
> +
> +    visit_type_uint8(v, name, &transports, errp);
> +}
> +
> +static void virt_set_virtio_transports(Object *obj, Visitor *v,
> +                                       const char *name, void =
*opaque,
> +                                       Error **errp)
> +{
> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> +    uint8_t transports;
> +
> +    if (!visit_type_uint8(v, name, &transports, errp)) {
> +        return;
> +    }
> +
> +    if (transports > NUM_VIRTIO_TRANSPORTS) {
> +        error_setg(errp, "virtio-transports must not exceed %d",
> +                   NUM_VIRTIO_TRANSPORTS);
Any particular reason to (keep) capping the maximum to 16?

=46rom a cursory look, base_memmap seems to have room for plenty more.=

