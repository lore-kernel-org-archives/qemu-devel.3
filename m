Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D86606D80E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGyyLUuT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AxL335W9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzDN-00025w-9K; Thu, 05 Nov 2026 10:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xOzDL-00021C-LF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xOzDJ-0008ED-CC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793891835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWStlxpRqjRahsWYuORDQCtt6o/ULCst5bg5rrotfio=;
 b=JGyyLUuTpjqLi29huEV0dvvguA5HYBh5S3hq0QVtz6iQq667yt0p/QEqk4IS+U0VfxqOZx
 84d5e8UnAU7+IA0eCOOc60202rflPQTsBUM+EexT7qEoKwE7bPBXpvBRn9+Z4iC5k7mCZK
 stufX99QoYnXt9wsEAun02VDrqwHwvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-cMXyLEyqMpaWc1yx4UKyRA-1; Thu, 05 Nov 2026 10:17:14 -0500
X-MC-Unique: cMXyLEyqMpaWc1yx4UKyRA-1
X-Mimecast-MFC-AGG-ID: cMXyLEyqMpaWc1yx4UKyRA_1793891833
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a70b42bab0so11364405e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793891833; x=1794496633; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PWStlxpRqjRahsWYuORDQCtt6o/ULCst5bg5rrotfio=;
 b=AxL335W9WuvvjgnPT/a0vB21NBam4nTmI/Wc1MPePLuUmm/SW3JiTsrrmarZrw19Qn
 mZOXzy/tZw4fpC2Gw2LtYPU6F3+M3CSX01J6SfGVBcyQnlk5WHhFvkZ0eZ6cf7lc/hX2
 wEOudKQCfe/tIa7g5wyPbdslsT3LLfGBJxLdiQxxI43fSHY/zYY9xqQBkmkH5ZywM33H
 TpNgGkv6d1/10g/ge3Dl9d9FMt+YO4JokWlYbumvk9/1BIUFYfhjd3z71zZdt7oegkGp
 uqc0P9o64GuEeDJIeADnISP+nnXE69VxqE98rLaL1x3Hkla7zZSCcEa4oXsx4aTi5L+6
 rb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793891833; x=1794496633;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PWStlxpRqjRahsWYuORDQCtt6o/ULCst5bg5rrotfio=;
 b=y3zPXWFmFJi8Gw0ffPmw/Xizkom9QSgyKLKxovdXOc9UltlSkxo+AUYLA7G5se1+uU
 1xaFxbUOZwwosA81pVLoVHdu6M3TbmllNaMJHI1M/Ha+dkibiJ/fkD3OkeQ4w7+gBLds
 c156kiWYG1BcFpR25eMb7EgIUL8Ro3bTNzev1Hc9zGfDIIQfVOF4H91F85QqnMcWFYga
 G6cS7QfvmAHEsxHMeIUd6gv9w9QKDrnhyFA2mfQ0vbeK4OmNLZ1kd+UJnDGYbBnyO3JV
 pVLiF5lqoRhdxcKDWy/hM+fcKCi9C4i8A1F8+vBP+pZol1B3XExfgNr3Uls2+MMqifTF
 v0mA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWxP4Eb8TyTGDSnU98X7ioqIkpH8Tyhv5s1KL5Kq+DzOERUqGy2fPDgAyKWl1J+tvdnnfVVXdsbHj8@nongnu.org
X-Gm-Message-State: APuU4Z8HplyRQTV2IWllFfLaO71uXFqGLCZ5V/nwkYbv74piVZn4lEAH
 SEFcDonq0rCk5U6LpHhYN7M8bsDxuyKoc+5DkLbC8+peqZefmSxkTb0Wl+ZPiX8Xub4YI0XZ6R7
 YyvQr+3Xaq2OpVRL1y/P3fB/cd1YDljKM9/nxRGXDtUwbBT8xf0C0oGA5
X-Gm-Gg: AYBFou3NuYLPZAyTv+gtSyL64cHwK3nEK41lgh9I8t/7IFa3fbaivG3YvGu2AEbaISA
 FuDsiSfOpotcKSehmNtLeLKk5HVyaslUvhdUyOzba/XSHZPoIdt8DtP/gObzE1JkY6Vf0eg5RoH
 WHtIGCpgu8/f2OeOxDKBDPEuMP+kGLsNddM7ni655VMEFhGhsQWaXMJSmIukOkNbrR/F+JGPztg
 CnhPprUcK3gKyYdk96TGgpBebEXIlJHXdhMh/Qc45h5aaGdublomYK1DPktMTo65Ie9MEQdH31b
 mmFEhQX7NPWW4TfgmpYnINYzQV7v6yvsdj1vb1l9SJfzboq6ZznKh5YgnRGywMvr/e337wI9jes
 y45whqA1ZyvR7cs7leDr/n2xVWA43Q6lM
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4b55dbb09dfmr55752945e9.13.1793891833023; 
 Thu, 05 Nov 2026 07:17:13 -0800 (PST)
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4b55dbb09dfmr55752465e9.13.1793891832642; 
 Thu, 05 Nov 2026 07:17:12 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f02386bsm68634305e9.7.2026.11.05.07.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:17:11 -0800 (PST)
Date: Thu, 5 Nov 2026 16:17:09 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>, Jagannathan Raman <jag.raman@oracle.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9
 SATA driver
Message-ID: <tngpdnrroq4lregd733ivej2qhsgb2uyaugki5dzpfkj572nso@jsvx3pwxzj6u>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
 <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
 <cd20258b-160d-4913-a67b-ed2b4d351ff8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd20258b-160d-4913-a67b-ed2b4d351ff8@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

On Thu, Nov 05, 2026 at 09:20:43AM +0100, Philippe Mathieu-Daudé wrote:
> On 5/11/26 09:11, Pierrick Bouvier wrote:
> > On 11/4/2026 11:12 PM, Philippe Mathieu-Daudé wrote:
> > > On 4/11/26 17:34, Jim MacArthur wrote:
> > > > From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > 
> > > Rationale?
> > > 
> > > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > > > ---
> > > >    hw/ide/ich.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > ++++++++--
> > > >    1 file changed, 80 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> > > > index b00987f08d..58e2d3b998 100644
> > > > --- a/hw/ide/ich.c
> > > > +++ b/hw/ide/ich.c
> > > > @@ -70,6 +70,7 @@
> > > >    #include "hw/ide/pci.h"
> > > >    #include "hw/ide/ahci-pci.h"
> > > >    #include "ahci-internal.h"
> > > > +#include "system/spdm-socket.h"
> > > >      #define ICH9_MSI_CAP_OFFSET     0x80
> > > >    #define ICH9_SATA_CAP_OFFSET    0xA8
> > > > @@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
> > > >        },
> > > >    };
> > > >    +static const Property ich_props[] = {
> > > > +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> > > > +};
> > > > +
> > > >    static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int
> > > > level)
> > > >    {
> > > >        PCIDevice *pci_dev = opaque;
> > > > @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
> > > >        d->ahci.irq = &d->irq;
> > > >    }
> > > >    +/* Sends an SPDM message and receives the response */
> > > > +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> > > > +{
> > > > +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
> > > > +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
> > > > +    void *rsp = doe_cap->read_mbox;
> > > > +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
> > > > +
> > > > +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
> > > > +                             SPDM_TRANSPORT_TYPE_DOE,
> > > > +                             req, req_len, rsp, rsp_len);
> > > > +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
> > > > +
> > > > +    return recvd != 0;
> > > > +}
> > > > +
> > > > +/* SPDM protocols: plain and secured SPDM messages */
> > > > +static DOEProtocol doe_spdm_prot[] = {
> > > > +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
> > > > +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA,
> > > > pcie_doe_spdm_rsp },
> > > > +    { }
> > > > +};
> > > > +
> > > >    static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
> > > >    {
> > > >        AHCIPCIState *d;
> > > >        int sata_cap_offset;
> > > >        uint8_t *sata_cap;
> > > > -    d = ICH9_AHCI(dev);
> > > >        int ret;
> > > > +    uint16_t cap_offset; /* Next offset for extended capabilities */
> > > > +
> > > > +    cap_offset = PCI_CONFIG_SPACE_SIZE;
> > > > +    d = ICH9_AHCI(dev);
> > > >          d->ahci.ports = 6;
> > > >        ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
> > > > @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev,
> > > > Error **errp)
> > > >        pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
> > > >                         &d->ahci.mem);
> > > >    +    /* Legacy capability for ICH9_SATA_CAP */
> > > >        sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
> > > >                                              ICH9_SATA_CAP_OFFSET,
> > > > SATA_CAP_SIZE,
> > > >                                              errp);
> > > > @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice *dev,
> > > > Error **errp)
> > > >        /* Any error other than -ENOTSUP(board's MSI support is broken)
> > > >         * is a programming error.  Fall back to INTx silently on -
> > > > ENOTSUP */
> > > >        assert(!ret || ret == -ENOTSUP);
> > > > +
> > > > +    /*
> > > > +     * Initialise a capability in the legacy space after the
> > > > ICH9_SATA_CAP.
> > > > +     */
> > > > +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET + SATA_CAP_SIZE);
> > > > +
> > > > +    if (dev->spdm_port) {
> > > > +        /* Set up the DOE extended capability, mailboxes etc */
> > > > +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
> > > > +                      doe_spdm_prot, true, 0);
> > > > +        cap_offset += PCI_DOE_SIZEOF;
> > > > +
> > > > +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
> > > > +                                                            errp);
> > > > +        assert(dev->doe_spdm.spdm_socket > 0);
> > > > +    }
> > > > +
> > > > +    /* IDE extended capability */
> > > > +    pcie_ide_init(dev, cap_offset);
> > > > +    cap_offset += PCI_IDE_SIZEOF;
> > > > +
> > > > +    /* TEE capability bit in legacy space*/
> > > > +    pcie_cap_tee_init(dev);
> > > 
> > > Which section of the ICH9 spec describes that? AFAICT ICH9 predates
> > > DOE / IDE. Is there some amendment? Otherwise this might not be the
> > > correct place to add that capability. Either use a Frankenstein ICH9
> > > with a distinct model name, or add at the SATA layer, possibly like
> > > a class interface (we only need the SATA_CAP_OFFSET IIUC).
> > > 
> > 
> > It's an ad hoc addition, reproducing what Arm has been doing on fvp for
> > device assignment. It does not really model a real device, and nvme was
> > (is?) not supported due to other limitations.
> > 
> > IIRC, we found that in the tf-rmm branch supporting device assignment.
> > 
> > While it does not hurt, that's why I never sent patches before because
> > that's indeed a custom thing, that works for a custom software stack
> > that was (is?) not yet finalized.
> > 
> > That said, it should not hurt to add it, since it's just an extra
> > capability.
> 
> Well I'm maintaining MIPS board that use the ICH9 and am not keen
> on having the model diverge from the spec; we already suffered from
> that in the past with PIIX. That said I'm not against contributing
> and committing experiments as long as they don't clutter / hinder
> our existing specified models.

I totally agree with Phil here. I really think we shouldn't touch the current
ICH9 device (ich.c).

I discussed it with Phil just before he left Linaro and the solution that he
suggested at that time, which I agree, is to add an experimental device derived
from ich.c. He provided me with an example, which I share below with my personal
notes about it:

"Another thing I discussed with Phil that I just recalled was about
 having an ICH controller with DOE. Since DOE is for PCIe and ICH is
 pretty old and PCI-only, he said it's ok to add an experimental ICH
 with DOE for experimental purposes. He gave me this as an example:"

https://gitlab.com/philmd/qemu/-/commit/213ae5c5f71f2aabd0d05d8522fe9f53f5aae060


Cheers,
Gustavo
 
> > @Jim: Feel free to complete my answer with links to the code and a spec,
> > if there is one to share now. I'm sure Mathieu Poirier has all this info
> > also.
> > 
> > > Michael, Tao, what are your view on this?
> > > 
> > 
> > Regards,
> > Pierrick
> > 
> 
> 


