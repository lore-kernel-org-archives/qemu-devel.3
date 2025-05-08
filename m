Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C903C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 17:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD4pk-0007ET-2B; Thu, 08 May 2025 13:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD4pg-0007E1-E8
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD4pe-0005ig-FH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746724487;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWIHfTcLjcIVt7v5zyNWu9nIkSiypL/0G0qbY8bnJ3k=;
 b=M/ws49jDTKF/rZ5GSzSkAc8iaG7otHtYbwilfd50bRoO+hntaKDorL6vqdQ1IwwBuGrRlw
 l5yKA8tS5uIp1XjrY66bFmzXsnTfhLrbDXRN95qAFtE00IdmHOGvTG6uJyJEzFlcSqPbwF
 uKUnhGILvD4CwX867G1HZAGjqcxj5j8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-G6isdmPBPweSqqm6yO2mqQ-1; Thu,
 08 May 2025 13:14:43 -0400
X-MC-Unique: G6isdmPBPweSqqm6yO2mqQ-1
X-Mimecast-MFC-AGG-ID: G6isdmPBPweSqqm6yO2mqQ_1746724482
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6111119560AE; Thu,  8 May 2025 17:14:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B6CE1955F24; Thu,  8 May 2025 17:14:39 +0000 (UTC)
Date: Thu, 8 May 2025 18:14:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
Message-ID: <aBzmfKzxIfdtzdGI@redhat.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-3-shentey@gmail.com>
 <Z-pdzUBa4CrBourR@redhat.com>
 <318E2A13-A163-434B-B18A-8A260CD3BC27@gmail.com>
 <Z-07WTw4PHHKhfxU@redhat.com>
 <CAFEAcA-_eaPF16f5rBhPar_kHpW49JZ4fQNPGUtd3qbNs+ktJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-_eaPF16f5rBhPar_kHpW49JZ4fQNPGUtd3qbNs+ktJA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, May 02, 2025 at 05:48:02PM +0100, Peter Maydell wrote:
> On Wed, 2 Apr 2025 at 14:28, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Wed, Apr 02, 2025 at 09:33:16AM +0000, Bernhard Beschow wrote:
> > > Am 31. März 2025 09:18:05 UTC schrieb "Daniel P. Berrangé" <berrange@redhat.com>:
> > > >General conceptual question .....  I've never understood what the dividing
> > > >line is between use of 'qemu_log_mask' and trace points.
> > >
> > > I *think* it's the perspective: If you want to see any issues, regardless
> > > of which device, use the -l option, i.e. qemu_log_mask(). If, however,
> > > you want to see what a particular device does, use tracepoints.
> >
> > I guess I'd say that the latter ought to be capable of satisfying the
> > former use case too, given a suitable trace point selection. If it
> > can't, then perhaps that's telling us the way we select trace points
> > is insufficiently expressive ?
> 
> Yeah; you can turn on and off a tracepoint, and you can select
> them by wildcard, but there's no categorization of them
> (into eg "this is basically the equivalent of a debug printf"
> vs "this is something that is a guest error you probably
> want to know about").

I wonder if there's any value in enhancing the trace support to
let us tag certain probes with some kind of "severity"/"level"
concept, such that when the 'log' trace backend is enabled we
can wire them through to the logging backend with useful
categorization ?

>                        There's also no way to say "turn on
> this logging with one switch, and it will print multiple lines
> or more than one thing" (at least not in the spirit of what
> the tracepoint API expects; you could have a trace_in_asm
> tracepoint that took a "%s" and output whatever you liked as
> the string, of course). And debug-logging is more documented:
> '-d help' shows what you can turn on and off and has at least
> a brief description of what it is you're getting.

IMHO the documentation benefit of '-d help' is somewhat
inconsistent.

I tried a crude grep for different usage of logging

      2 CPU_LOG_EXEC
    122 CPU_LOG_INT
    103 CPU_LOG_MMU
      6 CPU_LOG_PAGE
      1 CPU_LOG_PLUGIN
      8 CPU_LOG_RESET
     10 CPU_LOG_TB_IN_ASM
      4 CPU_LOG_TB_OP
   1715 LOG_GUEST_ERROR
      4 LOG_INVALID_MEM
    753 LOG_UNIMP

So the overwhealming majority of usage is accumulated under
two "catch all" categories - "guest error" and "unimplemented"
with no ability to filter - its all or nothing.

We ought to be able to do a better job at documentation the
trace events than we do today, given we have them in an
easily extractable format and can associate them with
particular files easily.

The 'qemu-trace-stap list' command can list all available
probes in a binary, but it only works for the systemtap
backend. We ought to do better with other backends.

>                                                   For tracepoints
> you're hoping that the name is vaguely descriptive and also
> hoping that the device/subsystem/etc named its tracepoints in
> a way that lets you usefully wildcard them.

Yep, we're somewhat inconsistent in our prefix naming
conventions. It would be nice to try to enforce some
greater standard there, but its hard to do programmatically.

> Also, the qemu_log() logging assumes "we're sending text to
> a logfile, we can format e.g. register dumps and disassembly
> as arbitrary laid out plaintext". That's fine if your tracepoint
> backend is also "we just send the text to a logfile/etc", but
> I don't know if all of the tracepoint backends would be so happy
> with that.

I think emitting multi-line blocks of text probably ought to be
considered out of scope for tracing. The 'log' backend is the
only one where that would be a reasonable semantic match.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


