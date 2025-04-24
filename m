Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0821C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sQ0-00061d-OJ; Thu, 24 Apr 2025 04:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7sPv-0005wf-D3
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7sPt-0005cm-Lb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745485123;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ldQRhDxnWk5seYrHpE4QZiH6+iyhG2Stljk4i0QBpMQ=;
 b=HOdnSlNfHcAR52AYI0XGGJ+D/wY7GFvLwXIstLp4BNnrntTgKeVoaKmm2YtSPYJbedrWJb
 rAfzCNQHsDOsn/kFUy7VDDHk9Uqm3c/gaizfCjxlStC27IeqFjPgUieKDF+hlIfchbJe2x
 V+3y/sQWSEaCz/dw2fUTkVpdEqOrtvY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-nj2boJHiMFGaPd8vL7JzcA-1; Thu,
 24 Apr 2025 04:58:37 -0400
X-MC-Unique: nj2boJHiMFGaPd8vL7JzcA-1
X-Mimecast-MFC-AGG-ID: nj2boJHiMFGaPd8vL7JzcA_1745485116
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8ADF19560AE; Thu, 24 Apr 2025 08:58:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C65CC195608D; Thu, 24 Apr 2025 08:58:34 +0000 (UTC)
Date: Thu, 24 Apr 2025 09:58:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
Message-ID: <aAn9Ng-KWglvTYiD@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <aAjcSnT_zYnuOG2W@redhat.com>
 <767155443.4848.1745479933168@webmail.proxmox.com>
 <743571755.4920.1745484201214@webmail.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <743571755.4920.1745484201214@webmail.proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 24, 2025 at 10:43:21AM +0200, Dietmar Maurer wrote:
> 
> > On 24.4.2025 09:32 CEST Dietmar Maurer <dietmar@proxmox.com> wrote:
> > 
> >  
> > > > +    gst_object_ref(vs->h264->source);
> > > > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> > > > +        gst_object_unref(vs->h264->source);
> > > > +        VNC_DEBUG("Could not add source to gst pipeline\n");
> > > > +        goto error;
> > > > +    }
> > > 
> > > If you put the gst_object_ref call after sucessfully calling
> > > gst_bin_add, then it wouldn't need the gst_object_unref call
> > > on failure. Repeated many times below.
> > 
> > Gstreamer docs claims that gst_bin_add() takes ownership of the element. So I assumed that it unref the element in case of error.
> > If I do not ref the object before, this would free the object too early.
> > 
> > But a look at the source code of gstbin.c reveals that it does
> > not unref the element in case of errors, so your suggestion works.
> > I will change that in the next version...
> 
> From the gstreamer docs about refcounting and gst_bin_add:
> 
> https://gstreamer.freedesktop.org/documentation/additional/design/MT-refcounting.html?gi-language=c#refcounting1
> 
> > As soon as this function is called in a Bin, the element passed as an argument is owned by the bin and you are not allowed to access it anymore without taking a _ref() before adding it to the bin. 
> 
> This clearly states we should taking a _ref() before adding it to the bin?

Yes, you are correct, ignore my suggestion.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


