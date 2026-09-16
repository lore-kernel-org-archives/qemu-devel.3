Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1437C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xMW-0004S6-25; Wed, 16 Sep 2026 17:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x6xMU-0004OS-7r
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:40:14 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x6xMS-0008AU-HH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:40:13 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso176769a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789594810; x=1790199610; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MOqIR1QOnXez06E1wQXG6QO22jSC2ZUg23ltXaD7bv8=;
 b=rKVCgXhjxsVE7o3PnxPMKZ8A002RcXtcstrW0494i+fekQUD+rixGsVp2azcbf6Hu5
 iAyTpl1HdQzu8LFloEor5ZqI4aBPSz4TeMST0E8ICA+fl7ueHnRoPVmm1APKSJr23VGJ
 IclfQrLD2vEGD7IkjfqjBSpnLH93rwV2KqcILhR4cHcqgdjWhFw8Ij5P5doZ49fn5ANu
 i5DjTf1OQ9Ay4pR0vL/FdeiTm/ydHgVTOkv4+kXTop3Njl0LabB6XLQAWC+M0AslwcQa
 EHAIHprYDVTNOHudJlhkkf0OctPLFaPz4/wA+CZtOeIG7R11xs5JPi+0LpkbGvw+knjP
 c2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594810; x=1790199610;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOqIR1QOnXez06E1wQXG6QO22jSC2ZUg23ltXaD7bv8=;
 b=sJ0Og02lB3wG6KcQ9cJM8LnGAa7/5PP4kR2NAsiJQ4FZZ4xtzvXSl2MzWYu9KBRc/q
 V29mpKQKf0WYKKOg1F7O3BpRMb7dWsT8U1zp1JPMfvOPv+WNUyFMUxU32AV2MUe0yn9z
 wEPsTJVO9E8bijYIFlMcGON/Nkzi8/og+MAH/kEMLthQz5VfeCiSm6Sjx9slj93Z8nXv
 Vai7aHyRBqMHoGJih8OACEy/7N6JXccL5ZLzPS+X8iFfBCWk1Vp01gjpl7VeFcVZ+6kq
 ejTsIe/0ybwyddezsSc/DQUpFm9Hlh8LCjXQQKU8+8COCxpssyvu4wTUcpkLLATzCZlA
 6/sQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVUe9Bb2/5mP4NgahCE0ssaYh9/eBZnQ29IO6WKFk04ICz1n8ONWvSCfte0bSSse3Svt905pAv8Hqt@nongnu.org
X-Gm-Message-State: AFuF++mp9iG5SSep9H1U6QUW3OWnvbqlphFdh0mQsVp/FDr3BWB7hpWP
 DzZ7vrWIuTFY6TO3d4ijEX5nW/mQrhQu202ZHXLIkcyT3xrkghhiWW7YE4dw0lCW/T4=
X-Gm-Gg: AYBFou3eEc2rFLRjBuMVMi4sNR/2fZVI8Y0+wdyYk6FltQjg2xCaD5VNBIECxEPOLsN
 y+tNyXD3TBO6q02qOaInaN0nTE9/F76US/uT37bhDcucb7yXhBLfKVb9bR4uSOyw1Mx8xUGMZUc
 /fs54GntVdkBv3nYmm/Y0QbkQJxt7ghNxEhaB8W0GxC1W6folCFXkyQaIHF7S9VurxN+FTXVgE9
 eI5VSpoepry/vbdZY6nWb+IMOJoEZsNAMWBXBdmYE93HbTc7dVJat+eptZpnt7DbZXynODcf5uv
 SyxlXTCfIkzPpYNheiV67dILumzkwt/XMUHs6FBDzunJD+qjvJtjrIHv8Wsk/tIU0BVDZM+WzsE
 w0kUkhUdQB9VvTbc+ubsUgsCaQ86oHMq5Y2HEsJhQ/wAqcoSK0OZzNsxozfNFTLxliIjCGnuHjt
 EKaFJ4yTHneHOzVBX1VmHfZDP/yOGoAbGlmITLLLwVeUamkAG28jK2cVaVXmkTnzmA0N+ar42id
 AY=
X-Received: by 2002:a17:90b:1fce:b0:39e:2faa:2e83 with SMTP id
 98e67ed59e1d1-39e2faa31f1mr4703559a91.10.1789594810007; 
 Wed, 16 Sep 2026 14:40:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5703:e05c:9814:52a1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e36115cc8sm1206938a91.3.2026.09.16.14.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:40:09 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:40:07 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Michael Roth <michael.roth@amd.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded
 in Realm memory
Message-ID: <aqsMt8etnjhTgfK9@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
 <e3cpd54xpkgonmn4rziolhqvdkge5ke5mhi3cx57j3cfcc7qwd@eq7btw5en54c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3cpd54xpkgonmn4rziolhqvdkge5ke5mhi3cx57j3cfcc7qwd@eq7btw5en54c>
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Michael - thanks for taking the time to review this work.

On Tue, Sep 15, 2026 at 05:50:37PM -0500, Michael Roth wrote:
> On Thu, Sep 03, 2026 at 01:35:57PM -0600, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> > That way we can deterministically calculate the Realm Initial Measurement (RIM).
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index f7c2cc786e2c..9985f5daba89 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include "hw/core/boards.h"
> >  #include "hw/core/cpu.h"
> > +#include "hw/core/loader.h"
> >  #include "kvm_arm.h"
> >  #include "migration/blocker.h"
> >  #include "qapi/error.h"
> > @@ -22,8 +23,18 @@
> >  #define TYPE_RME_GUEST "rme-guest"
> >  OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> >  
> > +#define RME_PAGE_SIZE qemu_real_host_page_size()
> > +
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +    uint8_t *data;
> > +} RmeRamRegion;
> > +
> >  struct RmeGuest {
> >      ConfidentialGuestSupport parent_obj;
> > +    Notifier rom_load_notifier;
> > +    GSList *ram_regions;
> >  };
> >  
> >  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
> >      kvm_mark_guest_state_protected();
> >  }
> >  
> > +static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
> > +{
> > +    const RmeRamRegion *ra = a;
> > +    const RmeRamRegion *rb = b;
> > +
> > +    g_assert(ra->base != rb->base);
> > +    return ra->base < rb->base ? -1 : 1;
> > +}
> > +
> > +static void rme_rom_load_notify(Notifier *notifier, void *data)
> > +{
> > +    RmeRamRegion *region;
> > +    RomLoaderNotifyData *rom = data;
> > +
> > +    if (rom->addr == -1) {
> 
> Are these entries also added via the rom_reset() path in the previous
> patch? If so, wouldn't it be better to filter them out there?

Duly noted.  I will also wrap the previous patch into this one.

> 
> Also, if that's where these entries are added, then it looks like we
> might call address_space_flush_icache_range() with this -1 addr before
> adding it to the notifier list. Is that expected?

Function address_space_flush_icache_range() is indeed called with @rom->addr set
to -1 (0xffffffffffffffff).  Since this address is not accessible, the inner
loop of the function skips over the entire Rom area without ever calling
flush_idcache_range().

Regards,
Mathieu

> 
> -Mike
> 
> > +        /*
> > +         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
> > +         * Instead the firmware will load them via fw_cfg and measure them
> > +         * itself.
> > +         */
> > +        return;
> > +    }
> > +
> > +    region = g_new0(RmeRamRegion, 1);
> > +    region->base = rom->addr;
> > +    region->size = rom->len;
> > +    region->data = rom->data;
> > +
> > +    /*
> > +     * The Realm Initial Measurement (RIM) depends on the order in which we
> > +     * initialize and populate the RAM regions. To help a verifier
> > +     * independently calculate the RIM, sort regions by GPA.
> > +     */
> > +    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
> > +                                                   region,
> > +                                                   rme_compare_ram_regions);
> > +}
> > +
> >  static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >  {
> >      KVMState *s = KVM_STATE(current_accel());
> > @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >      error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> >      migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> >  
> > +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> > +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> > +
> >      /*
> >       * The realm activation is done last, when the VM starts, after all images
> >       * have been loaded and all vcpus finalized.
> > -- 
> > 2.43.0
> > 
> > 

