Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33658CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KHh-0003Vo-57; Wed, 24 Sep 2025 03:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1KHf-0003VS-2S
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1KHW-00089a-MU
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758700274;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=73d/wZ7xEWGgnx4kVzas8SReppHLDlBhfyt7wa+SIQk=;
 b=N7zWvoh0tN5OO+A4W4Hslv7WgjNW3WXvRM2mni9Hz7O5rcB/5U9plAD9NskcAJDXywu5XY
 dBTLjLCgz07UD3AAlzDEqRpGvaqhsf33Rq3pMrUxjBHmoC45WDPM5zQjRM4/atuT2M+CI6
 9V9Z2NdIob5C7SOZ+4FOYzmnckNsM1g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-b-6Ip7kPPcCC2zBKh5t_Ew-1; Wed,
 24 Sep 2025 03:51:08 -0400
X-MC-Unique: b-6Ip7kPPcCC2zBKh5t_Ew-1
X-Mimecast-MFC-AGG-ID: b-6Ip7kPPcCC2zBKh5t_Ew_1758700267
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D94219560B4; Wed, 24 Sep 2025 07:51:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CB141955F19; Wed, 24 Sep 2025 07:51:03 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:50:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
Message-ID: <aNOi40MRaGEL0df3@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 24, 2025 at 09:13:15AM +0200, Paolo Bonzini wrote:
> On 9/23/25 21:23, Stefan Hajnoczi wrote:
> > > +    out('// SPDX-License-Identifier: GPL-2.0-or-later',
> > > +        '// This file is @generated by tracetool, do not edit.',
> > > +        '',
> > > +        '#[allow(unused_imports)]',
> > > +        'use std::ffi::c_char;',
> > > +        '#[allow(unused_imports)]',
> > > +        'use util::bindings;',
> > > +        '',
> > > +        '#[inline(always)]',
> > > +        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {',
> > > +        '    unsafe { (trace_events_enabled_count != 0) && (_id != 0) }',
> > > +        '}',
> > 
> > This was translated to Rust from:
> > 
> >    /* it's on fast path, avoid consistency checks (asserts) */
> >    #define trace_event_get_state_dynamic_by_id(id) \
> >        (unlikely(trace_events_enabled_count) && _ ## id ## _DSTATE)
> > 
> > The _id != 0 expression is incorrect. The purpose was to check whether
> > the trace event is currently enabled (i.e. dynamically at runtime).
> 
> The expression is correct, but the function and argument names are not. It
> should be
> 
> fn trace_event_state_is_enabled(dstate: u16) -> bool {
>      unsafe { trace_events_enabled_count } != 0 && dstate != 0
> }
> 
> > > +    # static state
> > > +    for e in events:
> > > +        if 'disable' in e.properties:
> > > +            enabled = "false"
> > > +        else:
> > > +            enabled = "true"
> > 
> > What is the purpose of this loop? The variable enabled is unused so I
> > think it can be deleted.
> 
> The Rust code generator is not emitting any code for disabled tracepoints.
> Unlike C, where the disabled tracepoints can produce e.g. -Wformat warnings,
> there's no real benefit here.
> 
> In the RFC the "enabled" variable was used to produce a const for the static
> state; it had no user so I removed it, but I left behind this dead Python
> code.  Sorry about that!

Is the concept of build time 'disabled' tracepoints actually useful to
still support ? AFAICT we use it in only places, which doesn't make it
sound too compelling:

$ find -name trace-events | xargs grep '^disable'
./target/hppa/trace-events:disable hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%lx"
./target/hppa/trace-events:disable hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%lx"
./target/hppa/trace-events:disable hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
...snip...
./target/hppa/trace-events:disable hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
./target/hppa/trace-events:disable hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
./target/hppa/trace-events:disable hppa_tlb_probe(uint64_t addr, int level, int want) "addr=0x%lx level=%d want=%d"
./hw/display/trace-events:disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


