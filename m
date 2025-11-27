Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC35CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 10:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOYqH-0007Yo-3q; Thu, 27 Nov 2025 05:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOYqF-0007Y5-PA
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 05:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOYqC-0006iB-Dp
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 05:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764237785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X58T56zqzSFCVMBZOoMMMqErh2u/Sv+7v04OR8+al7s=;
 b=jHDVNWGFDW5znVcJuadki+Pvob5XWziaoMUjTazsdNeVMCQLeozTp8jWkNvAphT2OMZJ2n
 7quVJab1ozzwrlLnt3F/AA4Y7QOv0/6a2u3uN4Eq8g4pzleI1buIZJEY/CHWBLiOiBuKG9
 zkHuxnVxdkWYSfAb3EV4ZZwp0zwuYtM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-iUGfX3anPiKf-nLs93Zeeg-1; Thu,
 27 Nov 2025 05:03:00 -0500
X-MC-Unique: iUGfX3anPiKf-nLs93Zeeg-1
X-Mimecast-MFC-AGG-ID: iUGfX3anPiKf-nLs93Zeeg_1764237779
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B7CD1800358; Thu, 27 Nov 2025 10:02:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8287F195608E; Thu, 27 Nov 2025 10:02:52 +0000 (UTC)
Date: Thu, 27 Nov 2025 10:02:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org,
 peterx@redhat.com, stefanha@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Message-ID: <aSghvhrBXL0xxL1a@redhat.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <aSggPDzhqem_jxnR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSggPDzhqem_jxnR@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

On Thu, Nov 27, 2025 at 10:56:12AM +0100, Kevin Wolf wrote:
> Am 25.11.2025 um 15:21 hat andrey.drobyshev@virtuozzo.com geschrieben:
> > From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > 
> > Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
> > coredumps") introduced coroutine traces in coredumps using raw stack
> > unwinding.  While this works, this approach does not allow to view the
> > function arguments in the corresponding stack frames.
> > 
> > As an alternative, we can obtain saved registers from the coroutine's
> > jmpbuf, copy the original coredump file into a temporary file, patch the
> > saved registers into the tmp coredump's struct elf_prstatus and execute
> > another gdb subprocess to get backtrace from the patched temporary coredump.
> > 
> > While providing more detailed info, this alternative approach, however, is
> > quite heavyweight as it takes significantly more time and disk space.
> > So, instead of making it a new default, let's keep raw unwind the default
> > behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
> > command which would enforce the new behaviour.
> > [...]
> 
> > +def clone_coredump(source, target, set_regs):
> > +    shutil.copyfile(source, target)
> > +    write_regs_to_coredump(target, set_regs)
> > +
> > +def dump_backtrace_patched(regs):
> > +    files = gdb.execute('info files', False, True).split('\n')
> > +    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
> > +    dump = re.search("`(.*)'", files[2]).group(1)
> > +
> > +    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
> > +        tmpcore = f.name
> > +
> > +    clone_coredump(dump, tmpcore, regs)
> 
> I think this is what makes it so heavy, right? Coredumps can be quite
> large and /tmp is probably a different filesystem, so you end up really
> copying the full size of the coredump around.

On my system /tmp is  tmpfs, so this is actually bringing the whole
coredump into RAM which is not a sensible approach.

> Wouldn't it be better in the general case if we could just do a reflink
> copy of the coredump and then do only very few writes for updating the
> register values? Then the overhead should actually be quite negligible
> both in terms of time and disk space.

Personally I'd be fine with just modifying the core dump in place
most of the time. I don't need to keep the current file untouched,
as it is is just a temporary download acquired from systemd's
coredumpctl, or from a bug tracker. 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


