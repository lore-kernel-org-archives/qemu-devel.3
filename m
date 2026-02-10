Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31133EB271F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 22:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpwJ4-0000oN-ES; Tue, 10 Feb 2026 17:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vpwJ1-0000ny-Cv
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:34:03 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vpwIz-0004B4-E3
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:34:03 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ED63714001EB;
 Tue, 10 Feb 2026 17:33:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 17:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1770762838;
 x=1770849238; bh=cYpHJudm79NGQ5a5wZTV6sctterPC7rsVi/ZLGiMzYA=; b=
 G/tYpDUIVx5NRXMxOja05YFU3uhIz1SaOrXFeA3OPae/c1Dv1Icinau7o4M461iV
 je8QLKygsMU+eb8zxBU2l5iCPuRqJHWDRRCqHb9VJG56ypGsHAQNA+Qb+wkfosG5
 Tvq/QSEBtwK3Nn5tXVkjC4c98EsgwalPEwwhD6XZDRv7m+Mrwvjlt5Hg8zc8H6Hf
 E6jNpo1rrE9lEJggMGhP+apsfH5J5AYjkdJ1YWViS0wWyXc3XRumPiwWyc1uIixV
 ovuILNFpO0HsEf2T8zZNL3gvZoV7qcSkFNXGSqMGufj0uf71QAI8zg/B2ef5m7uV
 VM/sAER0Odkjm4HuVpCuGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770762838; x=
 1770849238; bh=cYpHJudm79NGQ5a5wZTV6sctterPC7rsVi/ZLGiMzYA=; b=T
 i0qfeDYxMoLgGq+AuaaypsWOEcooag1a4WCKR0JDH5gLK3TK54k0eEK8C6MqdS2a
 AGnTiZtoOPvIQyAUltY9YvXWyHVjWSp395QdDg+YWKf7peevyl/k2ExAEp9cpKMs
 otpVla+cMRerEl7ydU0v2Ejlil/tu7ZvIJPOc2zg6M0q360eVrG2PSAkC8sPMVdE
 afRe2eBtCg3r7vgGotGGWNC2iMTxQpz/8qtrS8jXBwbQLMdPQhneSy57rvbXDwFC
 ByOu+q93JBSTHLBFnpi8qlKse1JkntB6DmJojzNOWGuF4RL4O5Q2r79yaEi9CLmK
 YipCvMRpqFoJgvdBzvRgw==
X-ME-Sender: <xms:VrKLabBwo2rv_hJnezkidUMuQdOUD-u723KpMH0i9533y9gnTmCM0w>
 <xme:VrKLaad0EcU9S7V9ACGuHHIKhU8pW-E0zWRteGplLQ-JdjvmBehL87CpkHnpOhzuj
 XgycjfstJYy9bE4F_jPnKK_WvBVFuvJJJvIiY1FB00kylGlZvnvsA>
X-ME-Received: <xmr:VrKLaSL9aUkiS45oGEtWnIRWMinbOhFIH_0IjN9BVvRr4H5i_KazLJMklrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthhqre
 dtredtjeenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
 rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepgeduvefhjeeufeevudeiueeuie
 eftedtkeevkefhgfdvteefleeuhefgtdehfffhnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
 gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnnhhmlhhi
 nhhugieslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegtlhhgsehrvgguhhgrth
 drtghomhdprhgtphhtthhopehvrghisghhrghvsehlihhnuhigrdhisghmrdgtohhmpdhr
 tghpthhtohephhgrrhhshhhpsgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:VrKLad2UVkqO-iweyA_X6Jc-KSq8TTfwxbmH6gu7A5M4EEOgMOVicg>
 <xmx:VrKLachKG5v6RwNkDTRqWOnComljIOg0qJTH4Tr0QQIijzDit1ORXw>
 <xmx:VrKLaeX2G9Q2pbh9kzxYHBrnJTI6FNGg2k8FxXtcZ0vg5lh2yqGdZQ>
 <xmx:VrKLabWsSweW8LR3bsmIAzaXxuZTJBi4nfMLZT4_SC0CbGLX8G8VaQ>
 <xmx:VrKLaUmyI-ppu3Cj95LB8V1uf1SE2tX6ujhbhRQjdsRSIPwO4N0cUREQ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 17:33:58 -0500 (EST)
Date: Tue, 10 Feb 2026 15:33:56 -0700
From: Alex Williamson <alex@shazbot.org>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: clg@redhat.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] vfio/pci: Ensure D0 power state before guest access
Message-ID: <20260210153356.01f79f4b@shazbot.org>
In-Reply-To: <20260209162242.11317-1-nnmlinux@linux.ibm.com>
References: <20260209162242.11317-1-nnmlinux@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.159; envelope-from=alex@shazbot.org;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Mon,  9 Feb 2026 21:50:48 +0530
Narayana Murty N <nnmlinux@linux.ibm.com> wrote:

> Add vfio_ensure_d0_state() to safely transition PCI devices from D3hot/D3=
cold
> to D0 before QEMU guest access, preventing config space inaccessibility a=
nd
> tg3 IRQ crashes during VFIO realize.
>=20
> Key changes:
> - D3hot: Direct PMCSR write (offset 0x44) to force PowerState=3D00 (D0)
> - D3cold: pm_runtime_resume() + pm_runtime_get_sync() for full power rest=
ore
> - Polling loop verifies D0 transition completion
> - No-op for already D0 devices
>=20
> Fixes PowerPC EEH races where devices enter low-power states during VFIO
> handover, causing config space access failures.
>=20
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  hw/vfio/pci.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

NAK.  This is very broken.

QEMU cannot write to arbitrary sysfs attributes.  QEMU should not write
power state controls to sysfs nor impose a device power state policy.
vbasedev->fd is more than likely invalid where we're performing an
ioctl test, making the entire premise of the test invalid.

When the device is opened by QEMU, vfio-pci will issues a
pm_runtime_resume_and_get(), incrementing the PM usage counter and
waking the device.  This should properly bring the device to the D0
power state and keep it there regardless of any ill-timed race to low
power state.  If it does not, then fix it in the kernel or block
vfio-pci from using low power states, ie. disable_idle_d3.  Thanks,

Alex

>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c734472721..851cd789aa 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3392,6 +3392,51 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev,=
 Error **errp)
>      return true;
>  }
> =20
> +static int write_sysfs(const char *path, const char *value)
> +{
> +    FILE *f =3D fopen(path, "w");
> +    if (!f) {
> +        return -1;
> +    }
> +    int ret =3D fprintf(f, "%s", value);
> +    fclose(f);
> +    return (ret > 0) ? 0 : -1;
> +}
> +
> +static void vfio_ensure_d0_state(VFIOPCIDevice *vdev)
> +{
> +    VFIODevice *vbasedev =3D &vdev->vbasedev;
> +    char sysfs_power_path[PATH_MAX];
> +
> +    /*
> +     * Test config region accessibility (D3cold-safe, no PCI config
> +     * reads!)
> +     */
> +    struct vfio_region_info reg_info =3D {
> +        .argsz =3D sizeof(reg_info),
> +        .index =3D VFIO_PCI_CONFIG_REGION_INDEX,
> +        .offset =3D 0,
> +        .size =3D 0
> +    };
> +
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info) < 0)=
 {
> +        warn_report("vfio: %s config region probe failed (D3cold): %s",
> +                    vbasedev->name, strerror(errno));
> +
> +        /* D3cold confirmed =E2=86=92 sysfs power control (EEH-safe) */
> +        snprintf(sysfs_power_path, sizeof(sysfs_power_path),
> +                 "/sys/bus/pci/devices/%s/power/control", vbasedev->name;
> +
> +        /* Force runtime resume */
> +        if (write_sysfs(sysfs_power_path, "on") =3D=3D 0) {
> +            g_usleep(10000);  /* 10ms settle */
> +            write_sysfs(sysfs_power_path, "auto");
> +            info_report("vfio: %s D3cold =E2=86=92 D0 via sysfs", vbased=
ev->name);
> +        }
> +    }
> +    return;
> +}
> +
>  static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -3401,6 +3446,13 @@ static void vfio_pci_realize(PCIDevice *pdev, Erro=
r **errp)
>      char uuid[UUID_STR_LEN];
>      g_autofree char *name =3D NULL;
> =20
> +    /*
> +     * ensure the power state of the pci device to D0,
> +     * otherwise it will set to D0, before accessing the
> +     * config space.
> +     */
> +    vfio_ensure_d0_state(vdev);
> +
>      if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
>                ~vdev->host.slot || ~vdev->host.function)) {


