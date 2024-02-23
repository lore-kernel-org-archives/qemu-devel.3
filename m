Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E31C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 02:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLNq-0002YJ-Go; Thu, 22 Feb 2024 21:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLNn-0002Xr-PB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 21:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLNl-0002vR-KI
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 21:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708655627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWcY7O1Bx15tyWxlfzs3Wih/U6GHt7LEfTxIiZRol5Y=;
 b=enX0NghCFs3joYowyEU/oKh7HygXNA/udqRjxh4vXaw0aWAu0NVYJTaz7Vzdf3OFlCq/Nn
 5VEUhRg05lz0tDmbmHbQjX6GnnYlvRytUDJeunvVSK/4QhOh2mL8hCRA5v4JvA5hVYiqRm
 GtZSxk+aeUmeI3kGNpkb9SywI+PgoI8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-9SvCbZMWNJCYCA-LYdSlrg-1; Thu, 22 Feb 2024 21:33:42 -0500
X-MC-Unique: 9SvCbZMWNJCYCA-LYdSlrg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6e4cc2c9dd7so67096b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 18:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708655621; x=1709260421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWcY7O1Bx15tyWxlfzs3Wih/U6GHt7LEfTxIiZRol5Y=;
 b=FP0G1PyAkGIT69rAh8jd98kijSz7ld8FXXFXbQkDLBQpa4uq9ClwRcU3p5sEWHHcV+
 W4K+y9zY8xtX/jk8a0dryNYxorEA7smZpKt041VVFZ2FQkSHe22OcjYzXyvsYAfh0XsZ
 5TzT2fpV+vPuQU1lKq772up3f1/nGfrK3WzN2zbHnV+OpNIU2P4arzgfX5Gegw1FB0Z4
 FqjacsaP37gChwMWU5qfM8h72f9yPjtTp+ZdaVrCsjoGJmkRBGeND2Kz3yh1nmI53Rn9
 nmdafdXDuBiz03neFMpialgfaPoNww1liIzEwJPp6wtwdlYEdhmvtMJgAz5uqpMzJ92G
 BoXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoq6holFoqkHa/9H2RLG9vXp/oqwFn/z/dcP+vwLS0f1Mq9ztLxc9JKXzcvm/aFcaki91gMLW0hvXBQ2Eb/YfHkC9Zfkg=
X-Gm-Message-State: AOJu0Ywv83ZoYycrj2yi2GXiw/8NGS4uHr51NpIC9vm/3oiYOKleA2WE
 NNNbba0x0NYPUwIMCId7Rh613vmElmfFvhHqa2VLnTTk4aawmQkzDKo8Dsonnnu+GW4a4XBzWN9
 +ZdY4NIsO/x70x04/qT1aJGw4xWEWV7TpIKXws8KFsSZ8Iej5ILuy
X-Received: by 2002:a05:6a00:939f:b0:6e4:cf8e:52e3 with SMTP id
 ka31-20020a056a00939f00b006e4cf8e52e3mr795003pfb.1.1708655621323; 
 Thu, 22 Feb 2024 18:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp0HfQRNHwAeIJFa3TzFxSRLZHsTywqMFyEuixdNLKfzUeRMeBFRGNlRFRmF/X6C7kDWMx/Q==
X-Received: by 2002:a05:6a00:939f:b0:6e4:cf8e:52e3 with SMTP id
 ka31-20020a056a00939f00b006e4cf8e52e3mr794982pfb.1.1708655620934; 
 Thu, 22 Feb 2024 18:33:40 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p14-20020a056a0026ce00b006e4887b13ffsm4897924pfw.1.2024.02.22.18.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 18:33:40 -0800 (PST)
Date: Fri, 23 Feb 2024 10:33:29 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Hao Xiang <hao.xiang@bytedance.com>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org, jdenemar@redhat.com
Subject: Re: [PATCH v2 4/7] migration/multifd: Enable zero page checking from
 multifd threads.
Message-ID: <ZdgD-eqUYxbQMJQN@x1n>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com>
 <875xyhbk8k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xyhbk8k.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 21, 2024 at 06:06:19PM -0300, Fabiano Rosas wrote:
> Hao Xiang <hao.xiang@bytedance.com> writes:
> 
> > This change adds a dedicated handler for MigrationOps::ram_save_target_page in
> 
> nit: Add a dedicated handler...
> 
> Usually "this patch/change" is used only when necessary to avoid
> ambiguity.
> 
> > multifd live migration. Now zero page checking can be done in the multifd threads
> > and this becomes the default configuration. We still provide backward compatibility
> > where zero page checking is done from the migration main thread.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  migration/multifd.c |  1 +
> >  migration/options.c |  2 +-
> >  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
> >  3 files changed, 42 insertions(+), 14 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index fbb40ea10b..ef5dad1019 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
> 
> This include...
> 
> >  #include "qemu/rcu.h"
> > +#include "qemu/cutils.h"
> 
> is there already.
> 
> >  #include "exec/target_page.h"
> >  #include "sysemu/sysemu.h"
> >  #include "exec/ramblock.h"
> > diff --git a/migration/options.c b/migration/options.c
> > index 3c603391b0..3c79b6ccd4 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -181,7 +181,7 @@ Property migration_properties[] = {
> >                        MIG_MODE_NORMAL),
> >      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
> >                         parameters.zero_page_detection,
> > -                       ZERO_PAGE_DETECTION_LEGACY),
> > +                       ZERO_PAGE_DETECTION_MULTIFD),
> 
> I think we'll need something to avoid a 9.0 -> 8.2 migration with this
> enabled. Otherwise it will go along happily until we get data corruption
> because the new QEMU didn't send any zero pages on the migration thread
> and the old QEMU did not look for them in the multifd packet.

It could be even worse, as the new QEMU will only attach "normal" pages
after the multifd packet, the old QEMU could read more than it could,
expecting all pages..

> 
> Perhaps bumping the MULTIFD_VERSION when ZERO_PAGE_DETECTION_MULTIFD is
> in use. We'd just need to fix the test in the new QEMU to check
> (msg.version > MULTIFD_VERSION) instead of (msg.version != MULTIFD_VERSION).

IMHO we don't need yet to change MULTIFD_VERSION, what we need is perhaps a
compat entry in hw_compat_8_2 setting "zero-page-detection" to "legacy".
We should make sure when "legacy" is set, multifd ran the old protocol
(zero_num will always be 0, and will be ignored by old QEMUs, IIUC).

One more comment is, when repost please consider split this patch into two;
The new ram_save_target_page_multifd() hook can be done in another patch,
AFAIU.

> 
> >  
> >      /* Migration capabilities */
> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 5ece9f042e..b088c5a98c 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
> >      QEMUFile *file = pss->pss_channel;
> >      int len = 0;
> >  
> > -    if (migrate_zero_page_detection() != ZERO_PAGE_DETECTION_LEGACY) {
> > -        return 0;
> > -    }
> 
> How does 'none' work now?
> 
> > -
> >      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> >          return 0;
> >      }
> > @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
> >  
> >  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
> >  {
> > +    assert(migrate_multifd());
> > +    assert(!migrate_compress());
> > +    assert(!migration_in_postcopy());
> 
> Drop these, please. Keep only the asserts that are likely to trigger
> during development, such as the existing ones at multifd_send_pages.
> 
> > +
> >      if (!multifd_queue_page(block, offset)) {
> >          return -1;
> >      }
> > @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
> >   */
> >  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
> >  {
> > -    RAMBlock *block = pss->block;
> >      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> >      int res;
> >  
> > @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
> >          return 1;
> >      }
> >  
> > +    return ram_save_page(rs, pss);
> 
> Look at where git put this! Are you using the default diff algorithm? If
> not try using --patience to see if it improves the diff.
> 
> > +}
> > +
> > +/**
> > + * ram_save_target_page_multifd: save one target page
> > + *
> > + * Returns the number of pages written
> 
> We could be more precise here:
> 
>  ram_save_target_page_multifd: send one target page to multifd workers
>  
>  Returns 1 if the page was queued, -1 otherwise.
> 
> > + *
> > + * @rs: current RAM state
> > + * @pss: data about the page we want to send
> > + */
> > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
> > +{
> > +    RAMBlock *block = pss->block;
> > +    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> > +
> > +    /* Multifd is not compatible with old compression. */
> > +    assert(!migrate_compress());
> 
> This should already be enforced at options.c.
> 
> > +
> > +    /* Multifd is not compabible with postcopy. */
> > +    assert(!migration_in_postcopy());
> 
> Same here.
> 
> > +
> >      /*
> > -     * Do not use multifd in postcopy as one whole host page should be
> > -     * placed.  Meanwhile postcopy requires atomic update of pages, so even
> > -     * if host page size == guest page size the dest guest during run may
> > -     * still see partially copied pages which is data corruption.
> > +     * Backward compatibility support. While using multifd live
> > +     * migration, we still need to handle zero page checking on the
> > +     * migration main thread.
> >       */
> > -    if (migrate_multifd() && !migration_in_postcopy()) {
> > -        return ram_save_multifd_page(block, offset);
> > +    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> > +        if (save_zero_page(rs, pss, offset)) {
> > +            return 1;
> > +        }
> >      }
> >  
> > -    return ram_save_page(rs, pss);
> > +    return ram_save_multifd_page(block, offset);
> >  }
> >  
> >  /* Should be called before sending a host page */
> > @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >      }
> >  
> >      migration_ops = g_malloc0(sizeof(MigrationOps));
> > -    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> > +
> > +    if (migrate_multifd()) {
> > +        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
> > +    } else {
> > +        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> > +    }
> >  
> >      bql_unlock();
> >      ret = multifd_send_sync_main();
> 

-- 
Peter Xu


