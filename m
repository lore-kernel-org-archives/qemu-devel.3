Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8055C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlqu-0004WU-17; Thu, 13 Jun 2024 10:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHlqj-0004Tl-By
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHlqg-000246-82
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718290476;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJFGVpauEUC7aWOyT+tk2DAUOZNN0ZL0c+nEaK6E6ko=;
 b=TZkXHhuA7d63cTu3YlkpvGwX7ed3RVAMRaEwPzHJq3AAsyR6Ch20ouB7F0Zs7hZP7TclSb
 Qw+8T/6uffPPE1LrnXvmz46Pte/EyIrdH0C/YueUVLAmKvOfcdLPzbBrQFvUNI6+tRQnX5
 JttNVoTE8eC1hfXJSEnGPd2ujAkosTU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-b1igJXsfNU6m6ZpRfcpUZQ-1; Thu,
 13 Jun 2024 10:54:34 -0400
X-MC-Unique: b1igJXsfNU6m6ZpRfcpUZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AB97195608D
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 14:54:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34C8E19560AD; Thu, 13 Jun 2024 14:54:31 +0000 (UTC)
Date: Thu, 13 Jun 2024 15:54:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Sample 'qapi-schema-diff' output for v9.0.0 vs origin/master
Message-ID: <ZmsIJPlnGcXD_p_R@redhat.com>
References: <CAFn=p-a4MOZGDd7nj_gEf0fT7nvwa40pLJ1GiGOTj3uNhSq1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-a4MOZGDd7nj_gEf0fT7nvwa40pLJ1GiGOTj3uNhSq1tg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 02:40:40PM -0400, John Snow wrote:
> Hiya, here's some draft output of a script I'm working on to summarize QMP
> wire format differences between QEMU versions.
> 
> This script works in terms of the QMP *wire format*, not the QAPI
> *specification*. As a consequence, *almost* all type names are stripped
> from this output and all nested structures are fully inlined - so changes
> to shared data structures, enums, etc will manifest as many independent
> changes. Similarly, changes to type names and type factorings that do not
> change the wire format will not appear in this report at all.
> 
> This is still a WIP: if conditionals and features may not be fully
> represented in this summary report.
> 
> Here's today's diff output, see if you think this format is "intuitive" or
> makes sense to some extent; or, if you're feeling bored, if you believe
> it's fully accurate:
> 
> jsnow@scv ~/s/qemu (master)> qapi-schema-diff qapi-compiled-v9.0.0.json
> qapi-compiled-v9.0.0-1388-g80e8f060216.json
> ###################################
> v9.0.0 ==> v9.0.0-1388-g80e8f060216
> ###################################
> 
> ********
> commands
> ********
> 
> Removed
> =======
> x-query-rdma

I'd probably suggest that added/removed commands and
events liste the full set of properties too, as you
could conceptually say we're adding/removing each
property, plus the command itself.


> 
> Modified
> ========
> blockdev-backup (arguments)
>     ++ arguments.discard-source: Optional<boolean>
> drive-backup (arguments)
>     ++ arguments.discard-source: Optional<boolean>
> migrate (arguments)
>     -- arguments.blk: Optional<boolean>
>     -- arguments.inc: Optional<boolean>

With the headings groupings and indentation this feels like
we're targetting humans with this file, but at the same time
it is also kind of a raw machine feeling. The '(arguments)'
suffix feels redundant given the lines that follow.

I'm inclined to say this is mostly considered machine
and/or patch reviewer, targetted plain text. Consumer
human targetted would be something added to the QMP
ref, as an appendix with more structured RST format.

Does it make sense to group into added/removed/modified
for commands, if we then just mix added/removed properties
in the same place ?

We could just show it all together, by prefixing '+' or '-'
or '.' on the command names too. eg.

 - x-query-rdma
 -     returns.human-readable-text: str
 . blockdev-backup
 +     arguments.discard-source: Optional<boolean>
 . migrate
 -    arguments.blk: Optional<boolean>
 -    arguments.inc: Optional<boolean>
 . object-add
 .    arguments.qom-type: enum
 +        'sev-snp-guest'
 +    arguments[sev-guest].legacy-vm-type: Optional<boolean>
 +    arguments[sev-snp-guest].author-key-enabled: Optional<boolean>
 +    arguments[sev-snp-guest].cbitpos: Optional<integer>

> migrate-incoming (arguments)
>     ++ arguments.exit-on-error: Optional<boolean>
> migrate-set-capabilities (arguments)
>     ·· arguments.capabilities[].capability: enum
>     --     'block'
>     --     'compress'
> migrate-set-parameters (arguments)
>     -- arguments.block-incremental: Optional<boolean>
>     -- arguments.compress-level: Optional<integer>
>     -- arguments.compress-threads: Optional<integer>
>     -- arguments.compress-wait-thread: Optional<boolean>
>     -- arguments.decompress-threads: Optional<integer>
> object-add (arguments)
>     ·· arguments.qom-type: enum
>     ++     'sev-snp-guest'
>     ++ arguments<qom-type=sev-guest>.legacy-vm-type: Optional<boolean>
>     ++ arguments<qom-type=sev-snp-guest>.author-key-enabled: Optional<boolean>
>     ++ arguments<qom-type=sev-snp-guest>.cbitpos: Optional<integer>
>     ++ arguments<qom-type=sev-snp-guest>.guest-visible-workarounds: Optional<string>
>     ++ arguments<qom-type=sev-snp-guest>.host-data: Optional<string>
>     ++ arguments<qom-type=sev-snp-guest>.id-auth: Optional<string>
>     ++ arguments<qom-type=sev-snp-guest>.id-block: Optional<string>
>     ++ arguments<qom-type=sev-snp-guest>.kernel-hashes: Optional<boolean>
>     ++ arguments<qom-type=sev-snp-guest>.policy: Optional<integer>
>     ++ arguments<qom-type=sev-snp-guest>.reduced-phys-bits: integer
>     ++ arguments<qom-type=sev-snp-guest>.sev-device: Optional<string>
>     ++ arguments<qom-type=sev-snp-guest>.vcek-disabled: Optional<boolean>
> query-cpu-model-baseline (returns, arguments)
>     ++ arguments.modela.deprecated-props: Optional<array>
>     ++ arguments.modela.deprecated-props[]: string
>     ++ arguments.modelb.deprecated-props: Optional<array>
>     ++ arguments.modelb.deprecated-props[]: string
>     ++ returns.model.deprecated-props: Optional<array>
>     ++ returns.model.deprecated-props[]: string
> query-cpu-model-comparison (arguments)
>     ++ arguments.modela.deprecated-props: Optional<array>
>     ++ arguments.modela.deprecated-props[]: string
>     ++ arguments.modelb.deprecated-props: Optional<array>
>     ++ arguments.modelb.deprecated-props[]: string
> query-cpu-model-expansion (returns, arguments)
>     ++ arguments.model.deprecated-props: Optional<array>
>     ++ arguments.model.deprecated-props[]: string
>     ++ returns.model.deprecated-props: Optional<array>
>     ++ returns.model.deprecated-props[]: string
> query-cpus-fast (returns)
>     ++ returns[].props.module-id: Optional<integer>
>     ·· returns[].target: enum
>     --     'nios2'
> query-hotpluggable-cpus (returns)
>     ++ returns[].props.module-id: Optional<integer>
> query-machines (returns, arguments)
>     ++ arguments.compat-props: Optional<boolean>
>     ++ returns[].compat-props: Optional<array>
>     ++ returns[].compat-props[]: object
>     ++ returns[].compat-props[].property: string
>     ++ returns[].compat-props[].qom-type: string
>     ++ returns[].compat-props[].value: string
> query-migrate (returns)
>     -- returns.compression: Optional<object>
>     -- returns.compression.busy: integer
>     -- returns.compression.busy-rate: number
>     -- returns.compression.compressed-size: integer
>     -- returns.compression.compression-rate: number
>     -- returns.compression.pages: integer
>     -- returns.disk: Optional<object>
>     -- returns.disk.dirty-pages-rate: integer
>     -- returns.disk.dirty-sync-count: integer
>     -- returns.disk.dirty-sync-missed-zero-copy: integer
>     -- returns.disk.downtime-bytes: integer
>     -- returns.disk.duplicate: integer
>     -- returns.disk.mbps: number
>     -- returns.disk.multifd-bytes: integer
>     -- returns.disk.normal: integer
>     -- returns.disk.normal-bytes: integer
>     -- returns.disk.page-size: integer
>     -- returns.disk.pages-per-second: integer
>     -- returns.disk.postcopy-bytes: integer
>     -- returns.disk.postcopy-requests: integer
>     -- returns.disk.precopy-bytes: integer
>     -- returns.disk.remaining: integer
>     -- returns.disk.skipped: integer
>     -- returns.disk.total: integer
>     -- returns.disk.transferred: integer
>     -- returns.ram.skipped: integer
> query-migrate-capabilities (returns)
>     ·· returns[].capability: enum
>     --     'block'
>     --     'compress'
> query-migrate-parameters (returns)
>     -- returns.block-incremental: Optional<boolean>
>     -- returns.compress-level: Optional<integer>
>     -- returns.compress-threads: Optional<integer>
>     -- returns.compress-wait-thread: Optional<boolean>
>     -- returns.decompress-threads: Optional<integer>
> query-sev (returns)
>     -- returns.handle: integer
>     -- returns.policy: integer
>     ++ returns.sev-type: enum
>     ++ returns<sev-type=sev-snp>.snp-policy: integer
>     ++ returns<sev-type=sev>.handle: integer
>     ++ returns<sev-type=sev>.policy: integer
> query-target (returns)
>     ·· returns.arch: enum
>     --     'nios2'
> set-numa-node (arguments)
>     ++ arguments<type=cpu>.module-id: Optional<integer>
> trace-event-get-state (returns, arguments)
>     -- arguments.vcpu: Optional<integer>
>     -- returns[].vcpu: boolean
> trace-event-set-state (arguments)
>     -- arguments.vcpu: Optional<integer>
> transaction (arguments)
>     ++ arguments.actions[]<type=blockdev-backup>.data.discard-source:
> Optional<boolean>
>     ++ arguments.actions[]<type=drive-backup>.data.discard-source:
> Optional<boolean>
> 
> ******
> events
> ******
> 
> Added
> =====
> VFIO_MIGRATION
> 
> Removed
> =======
> MEM_UNPLUG_ERROR
> RDMA_GID_STATUS_CHANGED



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


