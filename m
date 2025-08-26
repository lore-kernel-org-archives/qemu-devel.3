Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B5CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqrec-00040d-Cz; Tue, 26 Aug 2025 07:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqreM-0003xf-TZ
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqreF-0006T7-Rn
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756206925;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uwba2+5GMv4jaznP45ViiEumS+6CqrQDWkAuHavcB4=;
 b=hTDLPB7e4zNL7KIom3wcAj7lh0QkkU1RRPnmLTI4/SZcpDlgH6g4e0elYr6zHKdZspUtiR
 SDvglk5Gt9Jas4IINtgFZoJypx98YQqhn5vVi0HAvpGgJoU9HX9fTACnjln9PaZpP+n6u7
 BDAo+glY1yuAgZrFaKYiyhSEyakXJhc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-QvPIv11VNZiClKl37CBufA-1; Tue,
 26 Aug 2025 07:15:24 -0400
X-MC-Unique: QvPIv11VNZiClKl37CBufA-1
X-Mimecast-MFC-AGG-ID: QvPIv11VNZiClKl37CBufA_1756206923
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1705195609E; Tue, 26 Aug 2025 11:15:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33B6630001A2; Tue, 26 Aug 2025 11:15:19 +0000 (UTC)
Date: Tue, 26 Aug 2025 12:15:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tanishdesai37@gmail.com, stefanha@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 01/14] treewide: write "unsigned long int" instead of
 "long unsigned int"
Message-ID: <aK2XRJgW01rkK9EF@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-2-pbonzini@redhat.com>
 <aKwPkXzi67+UGAnP@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKwPkXzi67+UGAnP@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 25, 2025 at 03:24:01PM +0800, Zhao Liu wrote:
> On Fri, Aug 22, 2025 at 02:26:42PM +0200, Paolo Bonzini wrote:
> > Date: Fri, 22 Aug 2025 14:26:42 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 01/14] treewide: write "unsigned long int" instead of "long
> >  unsigned int"
> > X-Mailer: git-send-email 2.50.1
> > 
> > Putting "unsigned" in anything but the first position is weird.
> 
> I think one reason may be gcc uses something like ‘long unsigned int *‘
> by default?
> 
> ../hw/misc/imx7_src.c: In function ‘imx7_src_write’:
> ../hw/misc/imx7_src.c:218:42: error: passing argument 2 of ‘clear_bit’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   218 |             clear_bit(R_CORE1_RST_SHIFT, &change_mask);
>       |                                          ^~~~~~~~~~~~
>       |                                          |
>       |                                          uint32_t * {aka unsigned int *}
> In file included from /media/liuzhao/data/qemu-cook/include/qemu/bitmap.h:16,
>                  from /media/liuzhao/data/qemu-cook/include/hw/qdev-core.h:6,
>                  from /media/liuzhao/data/qemu-cook/include/hw/sysbus.h:6,
>                  from /media/liuzhao/data/qemu-cook/include/hw/misc/imx7_src.h:13,
>                  from ../hw/misc/imx7_src.c:12:
> /qemu/include/qemu/bitops.h:93:54: note: expected ‘long unsigned int *’ but argument is of type ‘uint32_t *’ {aka ‘unsigned int *’}
>    93 | static inline void clear_bit(long nr, unsigned long *addr)
>       |                                       ~~~~~~~~~~~~~~~^~~~
> cc1: all warnings being treated as errors
> 
> > As such,
> > tracetool's Rust type conversion will not support it.  Remove it from
> > the whole of QEMU's source code, not just trace-events.
> 
> But I also agree it's a good idea to clean this up.
> 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  crypto/pbkdf-gcrypt.c        | 2 +-
> >  crypto/pbkdf-gnutls.c        | 2 +-
> >  crypto/pbkdf-nettle.c        | 2 +-
> >  hw/display/exynos4210_fimd.c | 2 +-
> >  hw/misc/imx7_src.c           | 4 ++--
> >  hw/net/can/can_sja1000.c     | 4 ++--
> >  hw/xen/trace-events          | 4 ++--
> >  7 files changed, 10 insertions(+), 10 deletions(-)
> 
> ...
> 
> > diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
> > index df0b0a69057..817c95bf65b 100644
> > --- a/hw/misc/imx7_src.c
> > +++ b/hw/misc/imx7_src.c
> > @@ -169,7 +169,7 @@ static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
> >  {
> >      IMX7SRCState *s = (IMX7SRCState *)opaque;
> >      uint32_t index = offset >> 2;
> > -    long unsigned int change_mask;
> > +    uint32_t change_mask;
> 
> We needs "unsigned long", otherwise, there'll be the error as I listed
> above.
> 
> >      uint32_t current_value = value;
> >  
> >      if (index >= SRC_MAX) {
> 
> ...
> 
> > diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> > index 5b6ba9df6c4..545c520c3b4 100644
> > --- a/hw/net/can/can_sja1000.c
> > +++ b/hw/net/can/can_sja1000.c
> > @@ -750,8 +750,8 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr addr, unsigned size)
> >              break;
> >          }
> >      }
> > -    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02lx\n",
> > -            (int)addr, size, (long unsigned int)temp);
> 
> tmep is "uint64_t", so there's no need to convert its type?

We can't assume 'uint64_t' is a match for '%lx' - the
format string can be changed to PRIx64 though which
would let us drop the cast.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


