Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByoh-0004LX-6x; Tue, 28 May 2024 11:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sByoe-0004L3-Ub
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sByoc-0003WO-Vi
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716910360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQRYFz+BQhOQx9nfKkXXxwn9aJEix4WoIDrkPBIZIns=;
 b=BiEwePe/dJC8pmeN110bX3DxNCaD23ka8yzEx+/NZObt2tB/750Tg9a4FD4zOjlaEjA4hD
 i+aO32B/PW5q13OdxO/jwBxMwWvRb6oN1cM0lm7+jZPc5l26b+BFGsGNj8vm9DNRU+04vu
 85xUORj/UDW0LK8669VhIc5uhVxk73w=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-JjANmeydNT6xQnyay-E-xQ-1; Tue, 28 May 2024 11:32:35 -0400
X-MC-Unique: JjANmeydNT6xQnyay-E-xQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b96a8c5352so376521eaf.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910354; x=1717515154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQRYFz+BQhOQx9nfKkXXxwn9aJEix4WoIDrkPBIZIns=;
 b=ZXj7BhR6eEwW5ggI8niIL6w02dADheoQrhknCP+vhcsclTh0XQ1rb+Lt8qtNm8sepb
 dUglhzeWcNSY9rceHHZrWTYfU0tILeX0+vqsHspWd94DPwM76ZCs3INU3i838GoErXrf
 dTcm1auzhmR01mwGMDa31f7sPkYM0uZJxHt0azb9Mm/G4bG91yWSTYuoF28j1coG04qc
 JHzrsyOjmxU4ZTY9y0FkVYLvrvCypY/xnpVttV8P6jm/LuCY0s+dmDj4I19lm2WF/0Dc
 h6EW46sLGJMDjccBzSLzaxwtPBqAGKmp8yJ5YPx/6KjWuSI5uKfflinye9nddsW0pQGw
 zkDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4bPrJqinwtjfCIQ5vR0WP6LSykrIYCniNIgKpLGmpeqwqy6J1C5pArahrT14lBiVRRZpyAdgErdOEtE0RNpgyN0siXTo=
X-Gm-Message-State: AOJu0YwrKqTcJUZHUoSImYQcdL/dkMNVDBeTFFryn4HdwetY+5X9fpJ8
 pmGMvtUQ+cNoM4XmtqEpnBK/VnEao1Ao/9uDLYU9PzuuoiNuqVotHwS/nt9Obx/MsvUpaJTN/Kn
 iGjWsNaaLH57tF45XwhtDHyCVyldsBWtUExB6hwrRiGsgvyHJDsjn
X-Received: by 2002:a05:6359:458a:b0:192:2980:ddf1 with SMTP id
 e5c5f4694b2df-197e50c84d1mr1357250655d.1.1716910353478; 
 Tue, 28 May 2024 08:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9KiigBg2ZUes7BVR2zzKHPydEFbHImp6JTtklfWSgCg6BNU/yKyDzhl2HQta4tSWE4isNw==
X-Received: by 2002:a05:6359:458a:b0:192:2980:ddf1 with SMTP id
 e5c5f4694b2df-197e50c84d1mr1357244255d.1.1716910352582; 
 Tue, 28 May 2024 08:32:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac070dc53bsm45502126d6.41.2024.05.28.08.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:32:32 -0700 (PDT)
Date: Tue, 28 May 2024 11:32:30 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v6 2/7] migration/multifd: put IOV initialization into
 compression method
Message-ID: <ZlX5DrANcMhYUFrW@x1n>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-3-yuan1.liu@intel.com>
 <ZlTyLrRrSYkHjutG@x1n>
 <PH7PR11MB5941D090A40858C20DF9AED2A3F12@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5941D090A40858C20DF9AED2A3F12@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 28, 2024 at 01:36:38PM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Tuesday, May 28, 2024 4:51 AM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: farosas@suse.de; qemu-devel@nongnu.org; Zou, Nanhai
> > <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v6 2/7] migration/multifd: put IOV initialization into
> > compression method
> > 
> > On Mon, May 06, 2024 at 12:57:46AM +0800, Yuan Liu wrote:
> > > Different compression methods may require different numbers of IOVs.
> > > Based on streaming compression of zlib and zstd, all pages will be
> > > compressed to a data block, so two IOVs are needed for packet header
> > > and compressed data block.
> > >
> > > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > > ---
> > >  migration/multifd-zlib.c |  7 +++++++
> > >  migration/multifd-zstd.c |  8 +++++++-
> > >  migration/multifd.c      | 22 ++++++++++++----------
> > >  3 files changed, 26 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> > > index 737a9645d2..2ced69487e 100644
> > > --- a/migration/multifd-zlib.c
> > > +++ b/migration/multifd-zlib.c
> > > @@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p,
> > Error **errp)
> > >          goto err_free_zbuff;
> > >      }
> > >      p->compress_data = z;
> > > +
> > > +    /* Needs 2 IOVs, one for packet header and one for compressed data
> > */
> > > +    p->iov = g_new0(struct iovec, 2);
> > > +
> > >      return 0;
> > >
> > >  err_free_zbuff:
> > > @@ -101,6 +105,9 @@ static void zlib_send_cleanup(MultiFDSendParams *p,
> > Error **errp)
> > >      z->buf = NULL;
> > >      g_free(p->compress_data);
> > >      p->compress_data = NULL;
> > > +
> > > +    g_free(p->iov);
> > > +    p->iov = NULL;
> > >  }
> > >
> > >  /**
> > > diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> > > index 256858df0a..ca17b7e310 100644
> > > --- a/migration/multifd-zstd.c
> > > +++ b/migration/multifd-zstd.c
> > > @@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Error
> > **errp)
> > >      struct zstd_data *z = g_new0(struct zstd_data, 1);
> > >      int res;
> > >
> > > -    p->compress_data = z;
> > >      z->zcs = ZSTD_createCStream();
> > >      if (!z->zcs) {
> > >          g_free(z);
> > > @@ -77,6 +76,10 @@ static int zstd_send_setup(MultiFDSendParams *p,
> > Error **errp)
> > >          error_setg(errp, "multifd %u: out of memory for zbuff", p->id);
> > >          return -1;
> > >      }
> > > +    p->compress_data = z;
> > > +
> > > +    /* Needs 2 IOVs, one for packet header and one for compressed data
> > */
> > > +    p->iov = g_new0(struct iovec, 2);
> > >      return 0;
> > >  }
> > >
> > > @@ -98,6 +101,9 @@ static void zstd_send_cleanup(MultiFDSendParams *p,
> > Error **errp)
> > >      z->zbuff = NULL;
> > >      g_free(p->compress_data);
> > >      p->compress_data = NULL;
> > > +
> > > +    g_free(p->iov);
> > > +    p->iov = NULL;
> > >  }
> > >
> > >  /**
> > > diff --git a/migration/multifd.c b/migration/multifd.c
> > > index f317bff077..d82885fdbb 100644
> > > --- a/migration/multifd.c
> > > +++ b/migration/multifd.c
> > > @@ -137,6 +137,13 @@ static int nocomp_send_setup(MultiFDSendParams *p,
> > Error **errp)
> > >          p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
> > >      }
> > >
> > > +    if (multifd_use_packets()) {
> > > +        /* We need one extra place for the packet header */
> > > +        p->iov = g_new0(struct iovec, p->page_count + 1);
> > > +    } else {
> > > +        p->iov = g_new0(struct iovec, p->page_count);
> > > +    }
> > > +
> > >      return 0;
> > >  }
> > >
> > > @@ -150,6 +157,8 @@ static int nocomp_send_setup(MultiFDSendParams *p,
> > Error **errp)
> > >   */
> > >  static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
> > >  {
> > > +    g_free(p->iov);
> > > +    p->iov = NULL;
> > >      return;
> > >  }
> > >
> > > @@ -228,6 +237,7 @@ static int nocomp_send_prepare(MultiFDSendParams *p,
> > Error **errp)
> > >   */
> > >  static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
> > >  {
> > > +    p->iov = g_new0(struct iovec, p->page_count);
> > >      return 0;
> > >  }
> > >
> > > @@ -240,6 +250,8 @@ static int nocomp_recv_setup(MultiFDRecvParams *p,
> > Error **errp)
> > >   */
> > >  static void nocomp_recv_cleanup(MultiFDRecvParams *p)
> > >  {
> > > +    g_free(p->iov);
> > > +    p->iov = NULL;
> > >  }
> > 
> > Are recv_setup()/recv_cleanup() for zstd/zlib missing?
> 
> Zstd/zlib does not request the IOVs on the receiving side.
> The zstd/zlib reads the compressed data into the buffer directly
> 
> qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);

Hmm indeed, thanks.

> 
> > If the iov will be managed by the compressors, I'm wondering whether we
> > should start assert(p->iov) after send|recv_setup(), and assert(!p->iov)
> > after send|recv_cleanup().  That'll guard all these.
> 
> Yes, I agree with adding a check of IOV in multifd.c since different compressors 
> may have different requirements for IOV.
> 
> We can add assert(p->iov) after send_setup, not recv_setup. The sending side always
> uses IOV to send pages by qio_channel_writev_full_all in multifd.c, but the receiving
> side may not require the IOV for reading pages.
> 
> It is better to add assert(!p->iov) after send|recv_cleanup()

In that case maybe we should at some time move iov out of MultiFDRecvParams
as that's not a shared object, making MultiFDSendParams.compress_data
points to iov for nocomp case.  But we can leave that for later.

Then I've no question on this patch, feel free to take (with/without the
conditional assertions):

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

> 
> > >
> > >  /**
> > > @@ -783,8 +795,6 @@ static bool
> > multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
> > >      p->packet_len = 0;
> > >      g_free(p->packet);
> > >      p->packet = NULL;
> > > -    g_free(p->iov);
> > > -    p->iov = NULL;
> > >      multifd_send_state->ops->send_cleanup(p, errp);
> > >
> > >      return *errp == NULL;
> > > @@ -1179,11 +1189,6 @@ bool multifd_send_setup(void)
> > >              p->packet = g_malloc0(p->packet_len);
> > >              p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> > >              p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> > > -
> > > -            /* We need one extra place for the packet header */
> > > -            p->iov = g_new0(struct iovec, page_count + 1);
> > > -        } else {
> > > -            p->iov = g_new0(struct iovec, page_count);
> > >          }
> > >          p->name = g_strdup_printf("multifdsend_%d", i);
> > >          p->page_size = qemu_target_page_size();
> > > @@ -1353,8 +1358,6 @@ static void
> > multifd_recv_cleanup_channel(MultiFDRecvParams *p)
> > >      p->packet_len = 0;
> > >      g_free(p->packet);
> > >      p->packet = NULL;
> > > -    g_free(p->iov);
> > > -    p->iov = NULL;
> > >      g_free(p->normal);
> > >      p->normal = NULL;
> > >      g_free(p->zero);
> > > @@ -1602,7 +1605,6 @@ int multifd_recv_setup(Error **errp)
> > >              p->packet = g_malloc0(p->packet_len);
> > >          }
> > >          p->name = g_strdup_printf("multifdrecv_%d", i);
> > > -        p->iov = g_new0(struct iovec, page_count);
> > >          p->normal = g_new0(ram_addr_t, page_count);
> > >          p->zero = g_new0(ram_addr_t, page_count);
> > >          p->page_count = page_count;
> > > --
> > > 2.39.3
> > >
> > 
> > --
> > Peter Xu
> 

-- 
Peter Xu


