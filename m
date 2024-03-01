Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A619DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg71n-0006FJ-M6; Fri, 01 Mar 2024 12:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg71m-0006Ev-3o
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg71k-0001C1-7U
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709315431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/Y465+ptn/nUZiasWZbpBFilVca+31DZltQTGQGGTIg=;
 b=AHVFrFFeqqZrjqMLDXoqdh12XmZHrDlbzyJFBqrWwS1GRZljiBP9ZaPVb3XCGLiUvNf+v4
 80RAdkKKxcVmdi2s3Y7KJFyDQQQThSjOW6wDk7T+nUFVcihP/reQ2zmSIA2Kc1BZLn9tRk
 8saefQ1J1h9dqGufiYOuS/wSYidIxEs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-MN7yrHZBMb-do9TWrzdD_w-1; Fri, 01 Mar 2024 12:50:28 -0500
X-MC-Unique: MN7yrHZBMb-do9TWrzdD_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1F77185A784;
 Fri,  1 Mar 2024 17:50:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17DB739D6D;
 Fri,  1 Mar 2024 17:50:25 +0000 (UTC)
Date: Fri, 1 Mar 2024 17:50:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration/multifd: Document two places for mapped-ram
Message-ID: <ZeIVYDnAkPTpKHsP@redhat.com>
References: <20240301091524.39900-1-peterx@redhat.com>
 <CAE8KmOz_5-DtSO2BHpBXgD2kJUjwsLaqKguOcWgfXC2efB2rWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOz_5-DtSO2BHpBXgD2kJUjwsLaqKguOcWgfXC2efB2rWA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 01, 2024 at 11:17:10PM +0530, Prasad Pandit wrote:
> Hello Petr,
> 
> On Fri, 1 Mar 2024 at 14:46, <peterx@redhat.com> wrote:
> > +         * An explicitly close() on the channel here is normally not
> 
> explicitly -> explicit
> 
> > +         * required, but can be helpful for "file:" iochannels, where it
> > +         * will include an fdatasync() to make sure the data is flushed to
> > +         * the disk backend.
> 
> * an fdatasync() -> fdatasync()
> 
> * qio_channel_close
>     -> ioc_klass->io_close = qio_channel_file_close;
>      -> qemu_close(fioc->fd)
>       -> close(fd);
> 
> It does not seem to call fdatasync() before close(fd);
> 
>     - qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC, ...)

The documented behaviour reliant on another pending patch:

https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg07046.html

> 
> Maybe the qio_channel..() calls above should include the 'O_DSYNC'
> flag as well? But that will do fdatasync() work at each write(2) call
> I think, not sure if that is okay.



> 
> > +         *
> > +         * The object_unref() cannot guarantee that because: (1) finalize()
> > +         * of the iochannel is only triggered on the last reference, and
> > +         * it's not guaranteed that we always hold the last refcount when
> > +         * reaching here, and, (2) even if finalize() is invoked, it only
> > +         * does a close(fd) without data flush.
> > +         */
> 
> * object_unref
>     -> object_finalize
>       -> object_deinit
>         -> type->instance_finalize
>          -> qio_channel_file_finalize
>           -> qemu_close(ioc->fd);
> 
> * I hope I'm looking at the right code here. (Sorry if I'm not)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


