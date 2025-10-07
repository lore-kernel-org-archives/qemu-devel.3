Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86111CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 06:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v616R-0002BG-5S; Tue, 07 Oct 2025 02:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v616K-0002B1-Js
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v616G-0007eL-N0
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759818179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9gbdFtbPNyhGawrFdBwdJzUIzv9amYSl7fn5OMAVQY=;
 b=hXe5ve9Pwl6Hcoh3sTSghU7yYzYR9GEvAnlJp/r7TKs5o4mUNvkJxTiVQ1PDUkZFCAg/+x
 +vqlIjSjeBmEsv7qNXnRvi54yLBYbKhVnU2me/amir16Gk7T6saf/MLuAyubHXUi2Rkf7w
 sHageITfO6UJ8KvibfYX78B9pdUsDsY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-MrjEK0fqMCecTzuHK8aV4g-1; Tue,
 07 Oct 2025 02:22:57 -0400
X-MC-Unique: MrjEK0fqMCecTzuHK8aV4g-1
X-Mimecast-MFC-AGG-ID: MrjEK0fqMCecTzuHK8aV4g_1759818177
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07EC1800365; Tue,  7 Oct 2025 06:22:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.183])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EE3930002CC; Tue,  7 Oct 2025 06:22:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1C0781800386; Tue, 07 Oct 2025 08:22:54 +0200 (CEST)
Date: Tue, 7 Oct 2025 08:22:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH] RfC: hw/uefi: add "info ovmf-log" monitor command
Message-ID: <u4alqdjlnz3qjhsw3f5qnmwkutgj7m2vy3sukcee5tv7tcuw2s@tmvzm2lsfiun>
References: <20251006140318.578490-1-kraxel@redhat.com>
 <aOPSJ3R0Om2PwQFY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOPSJ3R0Om2PwQFY@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 06, 2025 at 03:28:55PM +0100, Daniel P. Berrangé wrote:
> On Mon, Oct 06, 2025 at 04:03:17PM +0200, Gerd Hoffmann wrote:
> > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> > optional support for logging to a memory buffer.  There is guest side
> > support -- for example in linux kernels v6.17+ -- to read that buffer.
> > But that might not helpful if your guest stops booting early enough that
> > guest tooling can not be used yet.  So host side support to read that
> > log buffer is a useful thing to have.
> 
> I presume this log will contain the same kind of info that we
> currently get when enabling the isa-debugcon device ?

Yes.

> If so,
> it will definitely make debugging easier if that has become
> an 'always on' feature we can query on any guest without needing
> to configure isa-debugcon devices.

It's also much faster than writing to isa-debugcon

> More info in devel/writing-monitor-commands.rst

Thanks for the pointer.

> IIUC, it is circular buffer - what size is the log capped
> at currently ?  

Yes, it's a ring buffer.  Size is configurable, default
is 32 pages aka 128k.

> > +    /*
> > +     * edk2 uses this for locking access.
> > +     */
> > +    uint64_t             MemDebugLogLock;

> Once the buffer is full, presumably head & tail offset will be equal
> as EDK shuffles them along, overwriting oldest data. If so we will
> have a potential race when reading the data, where the offsets
> change between the time we read the header, and access to the log
> buffer. IOW, what we think we've just read as a the oldest output,
> might in fact be the very newest output.

Correct.

> I wonder if there is any practical way to mitigate that problem
> so we don't dump misleadingly ordered logs ?

There is a lock to make sure parallel access (inside edk2, when setting
up SMP) doesn't corrupt the log.  It is probably possible for qemu to
just grab that lock while it reads the buffer.

I'd expect the typical use case would be more like figuring why the
machine doesn't boot in case the firmware ran into some problem early
enough that reporting it to the console is not yet possible but
seriously enough that it can't continue booting.  The firmware
typically sits in a 'hlt' loop then and doesn't write more data to
the log.

> Is there no better way to find the log than to trawl through
> up to 4 GB of memory ?

Requires coding some knowledge about OVMF internals into qemu.

take care,
  Gerd


