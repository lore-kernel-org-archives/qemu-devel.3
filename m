Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DADC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mpJ-0001K5-HF; Wed, 02 Sep 2026 11:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1x1mpG-0001JI-UL; Wed, 02 Sep 2026 11:24:34 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1x1mpE-00013a-Hp; Wed, 02 Sep 2026 11:24:34 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id E5F45EC02C9;
 Wed,  2 Sep 2026 11:24:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 11:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1788362669;
 x=1788449069; bh=pOF7By6Jtf5xxFwebcfc/v6z9ZMi4P133UbldY7hk4A=; b=
 VyQFJ3c/kUad69zQpCiQnWwntgxVMy9lUnQftLq1a82WkfeM4xX5XGB5kRi24KF3
 UnoJCpZNHoShQslWkY4mWwzxoKoiVxMbWK37OfHiZ701txDCTSlpC4etxKP0ipvI
 8l9iNM/0koNhLE53WcqF73SkFolqx9tEwCkrc8JE9kU1r8wN5TOzaBVGjcOibXX6
 vYAP57Sw0MYodLQivqmbHKuWdyVLOcjZBtvtYIq47s42pVLMkMVzUXqaPDAZj50/
 zSEA8kLoW6hRAaw/HYnO2EUqOE3e762bgK9oOQpoWH4rOcXOVyGbe9ZSlZk/Vcq+
 T6O/oOPkfSR8lSQyFq8lYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788362669; x=
 1788449069; bh=pOF7By6Jtf5xxFwebcfc/v6z9ZMi4P133UbldY7hk4A=; b=m
 VoREWqNt3VjasfaGFD65RATTENe9FzMV710gAqS3qM2wlsYf5F88igTZXRc5Sa49
 IsnKOTk5Cs1fdwnGCqYoW2DdniE+Dx/upWQokHt8CkGlHslk8xWeUQEttOpeC/C8
 w6cGpUPcqt0OB0SiADoYXQWIpGsKkdLe5T2Hm/xV9ch/K83sBw8KjszThiYjKe2M
 1RDqcFGgkp/PaZuz3GQI8Iyx2s2ICsj8yR00BAmLu3EUEeqbYg93Xm6KvPXCqaA9
 jIGwDyJVBlFwudl1AdcDRmw1hkzdUBsIB2GsCXUSsDYiIQzBr+uU7TxXM0SDTytM
 b8Tor75HrhTUjfqiRb1tA==
X-ME-Sender: <xms:rT-Yat8pllA0UGtjwuuL_M9vyVLfVBSIWKfrhsuMzLS2imR_K7S1fA>
 <xme:rT-Yap4-lPe_dRmWZGXUqv1dWUqvwd5sWlTAvnz-S6YIR64AD9hbz-fwg_u1kXkSG
 w3WmOmw8IJsnyQ2hcwg5fmfWdSxRch6HBpk8AdFN16aFCazVXdtjZk>
X-ME-Received: <xmr:rT-Yamlfg-G1UwPyNm5EJSpn7u4O2f_LASfEJWrWoYILbKV0p93pmLHkoMvFPQ>
X-ME-Proxy-Cause: dmFkZTEGOhgmT7SJwQaF/o+CvFB1U/h5qurccHuuSra7TDPBLAR/vHeY5hfoTIszsEqmjJ
 jpeSpi7ws99uNBtcAUolQbrZDf/RdFmFeO2eonFt/hTRpTV4B5Nyzi+g1cDNL4c/k20FAS
 y0TmXu+NWdhFoS1jwNvGLEOgjrKO4YBMLNXjzwVNjIASlBOX0xb3QzkM6BMs1QW8oim4wv
 ja1CVECkP2gTIdCKVSethjN+3QnaxWW9+vsSebdyi0/diGCTUXf8RJnGOYwAGHNLCDXjZ1
 o4aWJGC768SRZsGkxS3y+byYTIhwBfND9mxuuF+zRKMgni4TNIKuLbRY5I1DGP4qFXJ9WI
 QRfxPrLPC9hfDYoEhVUnxtP/XFHdibOgeQYlee2tQideSb3n8M0JOilq6aKfzwY8bLnbq4
 Ed2P3J3SikEUw58qtFqBWnguPRsCJIL49yGU+d7Je2IUaH+axicf/5SZneR+UV0O2QTXFh
 3aVyUirYvFbef2931HJ2riWn8f8J/w8wqJrBarBC/WjWpIZ/XLDUJu5LpQl07xc6kSgPyc
 dU1mVnkTMGPy51QCfulrM5L9v6DwtoywptKrSK+EbPNH+L9xGDsrcxjwMsXknMNr7oBKna
 lzqYyvzXBKuogSNrlEXbY6+aTYtDcoWd0yFDlTZfMqGkFAk2dhlyVurMz1QA
X-ME-Proxy: <xmx:rT-YasF77HEB-XiSjfCinNGJ17lMJSnFtXD0C9SE-r3tvwD8l2OlfA>
 <xmx:rT-Yat9aGmT9whrNsYVSfwxT4wa1Z7RLk0nwI0yz5CMrALbSOskrrA>
 <xmx:rT-YatndVWvVe-0SRoKWgTVFbLQbGpcO0lMYmPkAjK1YuQsWWIjNIg>
 <xmx:rT-YaoCGt1o33EU1Z7ypZK9puvYYGg9SrccmJsXZ-Ge0bkOC8K112A>
 <xmx:rT-YagiNg3RNEnYwbmsAHF4ktpTifyWH6ncYV9eEW5rwOjs2MgS82DkP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 11:24:28 -0400 (EDT)
Date: Wed, 2 Sep 2026 09:24:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tushar Dave <tdave@nvidia.com>, qemu-devel@nongnu.org, jgg@nvidia.com,
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com, devel@edk2.groups.io,
 alex@shazbot.org
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <20260902092426.4906e932@shazbot.org>
In-Reply-To: <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
 <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
 <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=alex@shazbot.org;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Wed, 2 Sep 2026 08:15:30 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > > And, yes, the logic to match entries in the fw_cfg file with the correct
> > > device using vendor and device id looks somewhat fragile to me too.
> > > 
> > > Existing code in qemu+firmware (for example bootorder) uses the location
> > > in the physical device tree to identify devices, like this:
> > > 
> > > /pci@i0cf8/pci-bridge@3/*@0/*@0/*@0,0
> > >  ^^^^^^^^^                             pcie root bus
> > >            ^^^^^^^^^^^^                pcie root port @ slot 3
> > >                         ^^^            virtio-scsi-pci @ slot 0
> > >                             ^^^        scsi controller bus #0
> > >                                 ^^^^^  scsi device target 0, lun 0  

Yeah, I wish such path-based device identification where available here.

> > 
> > Good point but the problem is CheckDevice()'s own signature, which is
> > fixed by UEFI PI spec (only passes
> > VendorId/DeviceId/RevisionId/SubsystemVendorId/SubsystemDeviceId). Even
> > though the path exists internally, the standard protocol interface
> > doesn't pass it to the callback.  
> 
> Hmm, yes.  Seems to be designed to apply quirks to device classes, not
> individual devices.
> 
> Also note that OVMF already has an incompatible pci device driver and
> there can be only one instance, so the code must be merged into the
> existing driver instead of adding a second.
> 
> > Therefore, we prepare the blob entries
> > in the same order PciBusDxe discovers devices, so matching by VID:DID
> > inherently works.  
> 
> Question is whenever we want have that edk2 limitation and the knowledge
> about edk2 internals (pci scan order) encoded in the qemu <-> firmware
> protocol.  I think it makes sense to (additionally) pass the complete
> device path even if the current edk2 implementation doesn't use it, so
> we have the option to improve things later on without having to change
> the qemu <-> firmware protocolS for that.
> 
> > > I can see that allowing fixed and non-fixed bars mix is much harder to
> > > handle.  Do we need to ask the user to manually set that though?  I'd
> > > prefer pci devices propagating automatically to the parent bus that they
> > > have fixed bars and additional constrains apply.  
> > 
> > I looked at this again, and technically nothing actually needs the flag
> > to exist. The real reason I kept it is closer to a usability one; it's
> > meant to be a visible signal in the launch script itself, so anyone
> > reading or writing the qemu command line sees up front that every device
> > under that root port is expected to have pci-bars= configured, rather
> > than that requirement only surfacing as a runtime error if something's
> > missing.  
> 
> I'm not sure how much of a usability win that actually is, if you forget
> to set the flag you still get a runtime error.
> 
> In general I like things which can be done automatically actually happen
> automatically as this simplifies things for the user in most cases.
> 
> > > Also: if the main use case for this is to map vfio devices with guest
> > > physical address == host physical address, is there a need to specify
> > > this manually at all?  Shouldn't we have a 'vfio-pci-fixed' device which
> > > handles this automatically?  
> > 
> > VFIO GPA == HPA is the primary motivation, but I don't think fixed-bar
> > should be tied to VFIO or automatically derive guest addresses from the
> > host.  
> 
> Why not?  It is a great usability improvement IMHO.

We thought about whether to make a vfio-pci shortcut to allow the HPA to
be pushed to the fixed BAR address, but decided that it's also easy for
a userspace script to to collect the physical BAR addresses and
construct the QEMU device options, while maintaining compatibility with
emulated devices and therefore enabling more comprehensive testing.  I
don't think we want to be limited by the physical devices available when
we're testing this.

> > For the VFIO use case, the admin can choose to specify the host
> > BAR addresses as the fixed-bar configuration to get GPA == HPA, but the
> > mechanism itself doesn't assume or enforce that -- the desired guest
> > layout isn't always just a copy of the host's, so having fixed-bar
> > auto-derive it on its own would be incorrect in some cases, not just
> > less general.  
> 
> You still can have fixed-bar-<nr>=<addr> properties to override the
> auto-discovered address for some or all pci bars.

If QEMU is willing to accept both a generic PCI mechanism to specify
this, AND a vfio-pci shortcut, sure, we can create the shortcut.  As
above though, it's also something the caller can construct relatively
easily (maybe not by hand, but with a trivial script) and increases the
test surface for QEMU.
 
> > The mechanism remains a generic way to explicitly specify
> > PCI BAR addresses.  
> 
> Yes, the code which creates the fw_cfg files is generic and it makes
> sense to have that in the core pci code, so it can be used for every pci
> device.
> 
> Nevertheless I'd tend to only expose the properties for devices where an
> actual use case exists.  Which is obviously vfio-pci(-fixed).  Also
> pci-testdev for development / testing / CI.  I can't see much beyond
> that though.

I always imagined the properties would live on the core PCI device and
at best vfio-pci would have a shortcut to prefill those properties
based on physical BAR address.  pci-testdev is pretty limited and we
can't fully test arbitrary device functionality with it.  We'd also
lose the ability to diverge from the host programming if we need to
debug a layout generated on another system.

IMO, the artificial restriction isn't worth it, especially in the
proposed environment where we enforce and validate fixed BAR
configurations for an entire PCI sub-tree.  I think that already
eliminates the most common usage failures we'd see otherwise.
Thanks,

Alex

