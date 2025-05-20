Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADF6C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHTra-0005QI-V6; Tue, 20 May 2025 16:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uHTrX-0005Pz-Vx
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:47:00 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uHTrU-0008EK-W1
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1747774003; x=1748033203;
 bh=+kzL2rQW3r66qxuTmahnyHXawnDmkKopDlVXiMN+QAE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Y9R+fIeupvBTDy0AGTlgju1d69+mQjeSP67nZwqfGVZpSgzdrgtNmXXA7U7IIkmk/
 FWKInATlaULA9PCoaXlz1vD7TJKFVfLEIV9m3qFd60RNwhebTjWAM6mGt9iSmXx9xD
 o8fQVVCSMvdB6gPk5HtlMubF9JbKxbUVvRePVWDjqsLCjf3JtcLn9FQ8DA8axLDFmN
 +JlD+e79pTwrFaus+TvE7vmqN+UMqFTGJjTIAtkHwmex5hNYeDL3FRdpqkDGqQg7zx
 J4IDU7sB60PEEDlWLlTMAd1rz/C1QXuaRMrbfZ+/0Luq89sYeOv4uF3gqkrk9xL7wG
 yvbPflVYPODPA==
Date: Tue, 20 May 2025 20:46:38 +0000
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] vfio/igd: Respect x-igd-opregion=off in IGD quirk
 handling
Message-ID: <p2Y0fDoEs3EoN6ugt0QeR2rm6jSPUADZwOuLL94q6eomD6Kp7lZgyf1p95E8khWZ1bwEIROkstnt67oVYM5uRj2ECi-_B9SmHu5q93Hr9uE=@proton.me>
In-Reply-To: <9fc2ce95-0846-48ab-aecb-d79c9c1a01b2@gmail.com>
References: <tgKYxqCs9bUrxIZV2h4pSnR4gEjle4oq8tKs65J8lM70PMsBpuxOPKbv0cUJLfLQdks2C-PUIBJx3kqMQ78ufP2EMEBwwjzT6FxfsZlBfcs=@protonmail.com>
 <9fc2ce95-0846-48ab-aecb-d79c9c1a01b2@gmail.com>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 9faca46e5b899243dcbc3e4a69cf1c8361c898ee
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158; envelope-from=edmund.raile@proton.me;
 helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "edmund.raile" <edmund.raile@proton.me>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Moeko,
>On 5/19/25 16:03, edmund.raile wrote:
>> Restore SR-IOV Intel iGPU VF passthrough capability:
>> Check x-igd-opregion=3Doff parameter in vfio_pci_igd_config_quirk and
>> vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=3Doff is
>> respected despite subsequent attempt of automatic
>> IGD opregion detection.
>>
>> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
>> Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
>> ---
>> This patch fixes a regression in QEMU=E2=80=99s VFIO IGD quirk handling =
that
>> established automatic IGD opregion detection which ignores
>> x-igd-opregion=3Doff necessary for SR-IOV VF passthrough of
>> Intel iGPUs using i915-sriov-dkms.
>>
>> Please review and provide feedback.
>> Let me know if additional testing or changes are needed.
>>
>> Kind regards,
>> Edmund Raile.
>
>Hi, Edmund
>
>I did a quick test with x-igd-opregion=3Doff with c0273e77f2d7 included on
>SRIOV PF, setting x-igd-opregion=3Doff works as expected on my linux
>guest. Per my understanding, SRIOV PF should not have OpRegion address
>in its config space 0xfc, kernel returns -ENODEV when accessing, and
>QEMU continues after vfio_pci_igd_opregion_detect() fails by returing
>true. Could you please share more details about this issue?

This is with the i915-sriov-dkms module creating a virtual function
from my iGPU:
00:02.0 VGA compatible controller: Intel Corporation AlderLake-S GT1 (rev 0=
c)
00:02.1 VGA compatible controller: Intel Corporation AlderLake-S GT1 (rev 0=
c)
Which I pass through to the VM, allowing both the host and the guest
to use the same iGPU.

>
>[    0.655035] i915 0000:00:02.0: [drm:intel_opregion_setup [i915]] graphi=
c opregion physical addr: 0x0
>[    0.655490] i915 0000:00:02.0: [drm:intel_opregion_setup [i915]] ACPI O=
pRegion not supported!
>[    0.656088] i915 0000:00:02.0: Invalid PCI ROM header signature: expect=
ing 0xaa55, got 0x0000
>[    0.656462] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)

Where are you getting these logs from?
These aren't kernel messages, are they?

>If you are mentioning the log "Device does not supports IGD OpRegion
>feature", it is a false error and can be ignored I think. Maybe we can
>improve this, making it more clear?

The exact error I am getting without my patch is this:
qemu-system-x86_64: -device vfio-pci,host=3D0000:00:02.1,romfile=3D/path/to=
/intelgopdriver_desktop.bin,x-vga=3Don,x-igd-opregion=3Doff: Device does no=
t supports IGD OpRegion feature: No such device
after which QEMU immediately exits.
Maybe the issue is that the parrent device (the iGPU) DOES support
OpRegion but the virtual function child does not.
The intent is to give the option of disabling it back to the user.

>>  hw/vfio/igd.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index e7952d15a0..e54a2a2f00 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -523,6 +523,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice=
 *vdev, Error **errp)
>>          return true;
>>      }
>>
>> +    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
>> +    if (!vdev->igd_opregion) {
>> +        return true;
>> +    }
>> +
>
>Here (vdev->igd_opregion =3D=3D NULL) is always true, the pointer is zero-
>initialized and only get assigned in vfio_pci_igd_opregion_init().
>Enabling OpRegion or not is by VFIO_FEATURE_ENABLE_IGD_OPREGION bit.
>

I thought `vdev->igd_opregion` would already contain the
`x-igd-opregion=3D` option state of the `-device vfio-pci`
parameter but you're right, it's not assigned here yet,
so is this the correct way to access the state of the
parameter option:
(vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)
Which would then make it
+    if (!(vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
+        return true;
+    }

>>      /* IGD device always comes with OpRegion */
>>      if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
>>          return true;
>> @@ -689,6 +694,11 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevi=
ce *vdev, Error **errp)
>>          return true;
>>      }
>>
>> +    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
>> +    if (!vdev->igd_opregion) {
>> +        return true;
>> +    }
>> +
>
>As I mentioned in a comment below, GVT-g vGPU always emulate OpRegion,
>so let QEMU fail immediately if OpRegion is not avaliable here.

Agreed, you are right, it shouldn't be necessary here,
I'll remove it in v3.

>
>Thanks,
>Moeko

Thank you for taking the time to review (and contribute in the
first place).

Kind regards,
Edmund.


