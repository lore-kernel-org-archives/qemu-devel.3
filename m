Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708D5CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 07:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyGI-00059i-Ae; Thu, 21 May 2026 03:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPyGF-00057m-Qh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPyGD-0003Xo-T9
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTP8YkXW6/YFtjOTHMjwIRYsACC87G3jA8vzSWt7gSw=;
 b=XDJYO2zLUxDzhnuBFtGHY/A2T+bNCvBTrG18tlJgB61JsEuzItk+j5+0VDPO2EYq4gNKSw
 l/nc+y6WJCV5LIwg1lGjN/ekMgN3Ju1gmgpk+qX1EU20fwpa+qMbNiKXLxSmjxfWGOGSWN
 r2IE40lHNFInVjXNctfb7YB8e0VcuLs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-vlGMadM9P6S5D4EdM2rIyQ-1; Thu,
 21 May 2026 03:56:00 -0400
X-MC-Unique: vlGMadM9P6S5D4EdM2rIyQ-1
X-Mimecast-MFC-AGG-ID: vlGMadM9P6S5D4EdM2rIyQ_1779350159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5CB218005BB
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:55:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E0AF300019F; Thu, 21 May 2026 07:55:58 +0000 (UTC)
Date: Thu, 21 May 2026 08:55:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/40] Make HMP optional (and later standalone)
Message-ID: <ag66inUz7qe7YwrS@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 01:49:01AM +0400, Marc-André Lureau wrote:
> Hi,
> 
> This series makes HMP compile-time optional via --disable-hmp. The
> resulting binary speaks only QMP - reducing the attack surface, binary
> size and enforcing a separation between machine-readable interface and
> interactive debugging console.
> 
> QMP offers almost all the functionality HMP could provide, so a separate
> standalone "HMP-like" console could be implemented on top of it. The
> rough list of missing commands (+complexity estimation) after this
> series:

When you say "complexity estimation" is that an estimate for doing
a well designed QMP implementation ?

My view is that for anything still HMP-only, we should do a quick
& dirty hack, where we just expose the existing functionality
directly as QMP without any modelling, but mark it unstable. That
would make everything be largely easy.

If we expect proper QMP design, then the job will never get finished.


> Debugging / introspection:
> - info registers (medium) - plus $reg expression handling
> - x/xp read memory (medium)
> - gpa2hpa/gpa2hva/gva2gpa address translation (medium)
> - info lapic (high) - deep x86 APIC state, lots of registers
> - info mem (high) - virtual memory mappings, different per arch
> - info tlb (high) - virt-to-phys mappings, also per arch
> - info mtree (high) - memory region tree, multiple view modes
> - info skeys (medium) - s390x storage keys
> - info cmma (medium) - s390x CMMA values
> - info qdm (easy) - could probably be folded into QOM introspection
> - info qtree (medium) - same, maybe QOM introspection is enough
> - info snapshots (medium)
> - info usbhost (medium)
> - info via (medium) -- VIA south bridge state
> 
> Simple actions / settings:
> - gdbserver (trivial)
> - boot_set (easy)
> - mce (easy) - x86 MCE injection
> - sum (easy) - memory checksum
> - sync-profile (easy) - enable/disable/reset
> - info sync-profile (medium)
> - one-insn-per-tb (easy) - could be a QOM property on the accelerator
> - pcie_aer_inject_error (easy)
> - migration_mode (medium?)
> - i/o ioport read/write (easy)
> - hostfwd-add/hostfwd-remove (medium) - slirp port forwarding
> - log/logfile (medium)
> - trace-file (medium)
> 
> Also, to let clients do disassembly on their side, it'd be useful to
> have something like "query-disassemble-info" that gives the client what
> architecture and endianness is used etc.
> 
> In the meantime, being able to build without HMP is valuable and helps
> identifying the missing pieces. The series does so by steps:
> 
> - preparatory cleanups and bug fixes
> - add commands without QMP equivalent and needed for tests
> - convert most iotests and qtests from HMP to QMP
> - guard HMP-only code paths
> - make HMP source files conditional in the build system
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


