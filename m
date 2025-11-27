Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5851DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOdPT-00088Q-OO; Thu, 27 Nov 2025 09:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOdPQ-00087p-9y
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:55:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOdPN-00071H-M3
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764255341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Y3VUPsrd8LVABeZNJCHPQUMW02EZvEVW0+PiA0e2uM=;
 b=AnLZw08SUxaii9xlu/mENiEaVsepPbgkzwon+nmrrc6LOnRKbGNOFYqTp/0Z23St3LAyHd
 bVBUgemsLXx4Cg3nY9MITGww/+yF4dBQ8rWCI+97XUGQ+14EfIqHcHRmSV03OK02PorIC8
 1sXBHMDrmDELUnrXX1a0SQ6sAf5ioIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-eyye1Am1O-OZ6NrRnGuzoQ-1; Thu,
 27 Nov 2025 09:55:38 -0500
X-MC-Unique: eyye1Am1O-OZ6NrRnGuzoQ-1
X-Mimecast-MFC-AGG-ID: eyye1Am1O-OZ6NrRnGuzoQ_1764255337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0FA71955F13; Thu, 27 Nov 2025 14:55:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DACE1800298; Thu, 27 Nov 2025 14:55:33 +0000 (UTC)
Date: Thu, 27 Nov 2025 14:55:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com,
 stefanha@redhat.com, vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Message-ID: <aShmYaowMbX4BWoC@redhat.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <aSggPDzhqem_jxnR@redhat.com> <aSghvhrBXL0xxL1a@redhat.com>
 <ef51cf63-16b1-48c4-8070-0acaf618ef3c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef51cf63-16b1-48c4-8070-0acaf618ef3c@virtuozzo.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 27, 2025 at 04:31:29PM +0200, Andrey Drobyshev wrote:
> On 11/27/25 12:02 PM, Daniel P. Berrangé wrote:
> > On Thu, Nov 27, 2025 at 10:56:12AM +0100, Kevin Wolf wrote:
> >> Am 25.11.2025 um 15:21 hat andrey.drobyshev@virtuozzo.com geschrieben:
> >>> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>>
> >>> Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
> >>> coredumps") introduced coroutine traces in coredumps using raw stack
> >>> unwinding.  While this works, this approach does not allow to view the
> >>> function arguments in the corresponding stack frames.
> >>>
> >>> As an alternative, we can obtain saved registers from the coroutine's
> >>> jmpbuf, copy the original coredump file into a temporary file, patch the
> >>> saved registers into the tmp coredump's struct elf_prstatus and execute
> >>> another gdb subprocess to get backtrace from the patched temporary coredump.
> >>>
> >>> While providing more detailed info, this alternative approach, however, is
> >>> quite heavyweight as it takes significantly more time and disk space.
> >>> So, instead of making it a new default, let's keep raw unwind the default
> >>> behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
> >>> command which would enforce the new behaviour.
> >>> [...]
> >>

> > Personally I'd be fine with just modifying the core dump in place
> > most of the time. I don't need to keep the current file untouched,
> > as it is is just a temporary download acquired from systemd's
> > coredumpctl, or from a bug tracker. 
> > 
> >
> 
> Hmm, that's an interesting proposal.  But I still see some potential
> pitfalls with it:
> 
> 1. When dealing with the core dump stored by coredumpctl, original file
> is indeed stored compressed and not being modified.  We don't really
> care about the uncompressed temporary dump placed in /var/tmp.  What we
> do care about is that current GDB session keeps working smoothly.  I
> tried patching the dump in place without copying, and it doesn't seem to
> break subsequent commands.  However GDB keeps the temporary dump open
> throughout the whole session, which means it can occasionally read
> modified data from it.  I'm not sure that we have a solid guarantee that
> things will keep working with the patched dump.
> 
> 2. If we're dealing with an external core dump downloaded from a bug
> report, we surely want to be able to create new GDB sessions with it.
> That means we'll want its unmodified version.  Having to re-download it
> again is even slower than plain copying.
> 
> The solution to both problems would be saving original registers and
> patching them back into the core dump once we've obtained our coroutine
> trace.  It's still potentially fragile in 2nd case if GDB process
> abruptly gets killed/dies leaving registers un-restored.  But I guess we
> can live with it?
> 
> What do you think?

I didn't realize at first that we're actually running this every time
a back trace is requested in the session. It feels fragile / risky to
be modifying the file repeatedly while QEMU has the orignal file open
so probably best to disregard that suggestion of mine.

None the less, that makes me even more wary of the full copyfile
approach, as we'd be taking that performance hit potentually many
times over :-(

I don't suppose there's an easy way to make a sparse copy of the
file such that we only include the minimum data needed to produce
the stack trace and omit other parts (leave all-zeros) ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


