Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E350BCF6AB9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmg3-0005wK-Kh; Thu, 08 Jan 2026 04:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdmg1-0005w0-F0
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdmfz-0003F3-EZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865890;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=epUK6rKogff0CJ0KDa5nVAuLMXpMGI6vQ95mYkM2B7c=;
 b=Y0ti/iM5bpl7AVIbwwjc7wqu4ui2VOKqCTTdd/RVbd5VOWto/OwJRBniAfezH+c6g2bpyw
 /Yx+mmi0Kge9mj7g6gr7yU2uaP/OREmFTf+Elul1zmrq5sQHg6H45lsEvKmjqGMkgtrh2O
 rSysMroQGBvdYcR5qSn6HhTCDN1bm3w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-_K9e8cQQOTe1fSBKYqUDIw-1; Thu,
 08 Jan 2026 04:51:26 -0500
X-MC-Unique: _K9e8cQQOTe1fSBKYqUDIw-1
X-Mimecast-MFC-AGG-ID: _K9e8cQQOTe1fSBKYqUDIw_1767865885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02A43180062E; Thu,  8 Jan 2026 09:51:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E99521956048; Thu,  8 Jan 2026 09:51:23 +0000 (UTC)
Date: Thu, 8 Jan 2026 09:51:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/50] *: Remove __i386__ tests
Message-ID: <aV9-GH5KUAOhJ9Od@redhat.com>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-6-richard.henderson@linaro.org>
 <d59e4ffe-87e5-42fd-b803-7c0092b062ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d59e4ffe-87e5-42fd-b803-7c0092b062ce@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 08, 2026 at 10:47:09AM +0100, Thomas Huth wrote:
> On 08/01/2026 06.29, Richard Henderson wrote:
> > Remove instances of __i386__, except from tests and imported headers.
> > 
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> ...
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 2060e561a2..63713f1992 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -7449,15 +7449,6 @@ void syscall_init(void)
> >                                 ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
> >                   (size << TARGET_IOC_SIZESHIFT);
> >           }
> > -
> > -        /* automatic consistency check if same arch */
> > -#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
> > -    (defined(__x86_64__) && defined(TARGET_X86_64))
> 
> This looks like we should keep the x86_64 part?
> 
> > -        if (unlikely(ie->target_cmd != ie->host_cmd)) {
> > -            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
> > -                    ie->name, ie->target_cmd, ie->host_cmd);
> > -        }
> > -#endif
> >           ie++;
> >       }
> >   }
> ...
> > diff --git a/configure b/configure
> > index 2016062492..00e455be57 100755
> > --- a/configure
> > +++ b/configure
> > @@ -377,8 +377,6 @@ fi
> >   if test ! -z "$cpu" ; then
> >     # command line argument
> >     :
> > -elif check_define __i386__ ; then
> > -  cpu="i386"
> >   elif check_define __x86_64__ ; then
> >     if check_define __ILP32__ ; then
> >       cpu="x32"
> 
> Aren't there some more spots in configure that could be removed now?
> e.g.:
> 
>   i386|i486|i586|i686)
>     cpu="i386"
>     host_arch=i386
>     linux_arch=x86
>     CPU_CFLAGS="-m32"
>     ;;
> 
> Or is this removed in a later patch?

Patch 8 does that.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


