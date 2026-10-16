Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDECCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlVp-0005Qb-7V; Fri, 16 Oct 2026 13:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xHlVi-0005QC-VM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:14:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xHlVg-0007Od-W1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:14:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8874539bccbso120152b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792170863; x=1792775663; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5HJrOnAZYpIuuAfp/L5yO221qV9COB5ByPC6P2WDsDo=;
 b=sVuWKMnqG0y61Kg+D9BnAcxBFTqC8xC7+P9Pxf0Ksfl39HGxt2u1ktltucpXzEDkL0
 0eLWfjvJwTpRfu7aLt85hJy8g9x/e8dZH/P7HoBt/Q8wDj7l46aG/VGfTxN0/P//eQuj
 kMyHQknOxBGd0LH9v0zUjSMs7PAXZcNFHDOuSGTnQsA/Z+NYNCBEcXkL0k76M+Ou5ghu
 y15SZEJWsaj7r4AlxlYXL/OtLjntDLRBcedZFOSvLAyLXBh4pgnL4q61NeaoLMUx/5wt
 nmxQbG3hqXET+2ZhkDXg+RzvYu6LR8x0pqlvJNahikEl70U122RVmWz93cD2ersU8dmv
 KTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792170863; x=1792775663;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5HJrOnAZYpIuuAfp/L5yO221qV9COB5ByPC6P2WDsDo=;
 b=nkcsUPvmezelynry+7aIJFmE/AwjbVMk2u4EGcHYEnh+YtwheFmHIP/6+vSJxt49Pq
 31FDRVkVyRWVLBC5UR5hvakMzh0ezENct7g/g4WP3nT6mja3Zsh5urTMYdxdOZa1Fe7s
 PgEBkALqxDs5C1ZwcIg54TbTsO+FvCV/fQC8dZ8SCO5OVyz3PXkSQXef6Qa3vtF6s3ro
 XXs2n1IOEl6c5jgh5jvOR1jXa3ORICyzWaEm7T/9TPXEQzSioaShZWcwY8rTi+gdUbYU
 227odGOLQw8PZ1K81YTeu2NMd7PVoIekWuZy8QgS/KCFpohMHdqXMqqYvrRjTh3iCuo9
 VBeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5ttOcZxVdgrVI2svu7OTK8CaRNOn9M4YU3nsOLto8+gCinQfZ7ZUSoC5L4hVwLJOWo3OLXiBDSjSo@nongnu.org
X-Gm-Message-State: AFq9FYKH2/flGFpdEBk7rO1qxjOMU7XTBGauYPXaV7cmS4AImv973e6p
 Lbk5TMONZ5+9EjnWGhPyEnDYnkBqNvrtc3Lu2j4Xn7lhognDR8SR52q2TpA3TwjnUzI=
X-Gm-Gg: AYBFou1w1yKYrsvnlOEYpoE3cusLhRvaTh6gu0phdz2d7MOmOvFhallv26QCqf3i0W4
 ORK2xHmmiiOXepIudcdaqT2CytWel7TGhI679p+LW9URo8g5+cVjF4ye6mGh6lF44ON2l8Ns9WT
 XCJ07I97hFJj7o1Pjxf4uezxhP6Jx33NNfDoTPoh9v6ezAKZR2/GweERfYazi4KdiaP6fz8JMFV
 5kc61tABo8NbFqraKH8W94lRbdWvgQnMQcF60p1A8QlBts5HKdiUfd3d6+/Uzyxsvxd0OyS0IjX
 Zge5tzTAqrrdC+onYabOzk3R6g8zUj/LScfj0abw4euqW8xJYnynJiLM0C/YNv1Idn2xXdcaoAC
 vuDxICMeQck9kPInTUuHm6qlNufvcjrG/0MJXBRLMfeVovHkmq5LMNoWTdbJWbh4AgarSriA3+s
 0dBXSs5cY2sEh8OTWLL7UAM+lqU0nTmxlNfCuQmY/C67JqaWaRliFdXP2Jj3o5pBCujpE+KAo+u
 A==
X-Received: by 2002:a05:6a00:4404:b0:89e:df2e:cebb with SMTP id
 d2e1a72fcca58-8a04d33cba9mr189265b3a.59.1792170862923; 
 Fri, 16 Oct 2026 10:14:22 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff2f:8a9c:5623:f753])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f579464besm1491750b3a.34.2026.10.16.10.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:14:22 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:14:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded
 in Realm memory
Message-ID: <atJbayxYy4qePc_2@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
 <062da66b-73fa-40e5-94cc-80b1ca760687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062da66b-73fa-40e5-94cc-80b1ca760687@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Oct 02, 2026 at 11:23:58AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> > That way we can deterministically calculate the Realm Initial Measurement (RIM).
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index f7c2cc786e2c..9985f5daba89 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -10,6 +10,7 @@
> >   #include "hw/core/boards.h"
> >   #include "hw/core/cpu.h"
> > +#include "hw/core/loader.h"
> >   #include "kvm_arm.h"
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> > @@ -22,8 +23,18 @@
> >   #define TYPE_RME_GUEST "rme-guest"
> >   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > +#define RME_PAGE_SIZE qemu_real_host_page_size()
> > +
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +    uint8_t *data;
> > +} RmeRamRegion;
> > +
> 
> This is the equivalent to 'RomLoaderNotifyData' defined in PATCH[09/24]. We may
> use 'RomLoaderNotifyData' if it can be renamed to reflect its purpose, no need
> to define an identical structure.
>

I ended up using 'RomLoaderNotifyData' in kvm-rme.c instead of 'RmeRamRegion'.
 
> >   struct RmeGuest {
> >       ConfidentialGuestSupport parent_obj;
> > +    Notifier rom_load_notifier;
> > +    GSList *ram_regions;
> >   };
> >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
> >       kvm_mark_guest_state_protected();
> >   }
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
> >   static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >   {
> >       KVMState *s = KVM_STATE(current_accel());
> > @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >       error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> >       migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> > +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> > +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> > +
> >       /*
> >        * The realm activation is done last, when the VM starts, after all images
> >        * have been loaded and all vcpus finalized.
> 
> Thanks,
> Gavin
> 

