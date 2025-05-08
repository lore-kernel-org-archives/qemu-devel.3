Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC14C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 17:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD5RW-0006ty-Dw; Thu, 08 May 2025 13:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD5RV-0006rX-Bi
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD5RT-0002Fn-HK
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746726829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYhLIsJYvyxyYo4WpCD3f0D8LuCsGTpwRYjqCPhguVU=;
 b=dSSx3I4NOviGp1qzHCsCTU55gun8ewQGSBSiJbhjk1gMIuOeNaw+9OY/dGL4j+bZa8BHD4
 yKR514aD/Jy1wBk84DkgpMxI4P7q0Rdz+9Q4Ohrj9xeLHacsw9yqanfZSLwL98pQH6H9iA
 9eAtq57NqT2CNZmGIMb3O4/eituzaWY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284--J4y5xpnNh2hZAlYM98cuQ-1; Thu,
 08 May 2025 13:53:46 -0400
X-MC-Unique: -J4y5xpnNh2hZAlYM98cuQ-1
X-Mimecast-MFC-AGG-ID: -J4y5xpnNh2hZAlYM98cuQ_1746726825
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA44518004A7; Thu,  8 May 2025 17:53:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54BC118003FC; Thu,  8 May 2025 17:53:41 +0000 (UTC)
Date: Thu, 8 May 2025 18:53:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 06/10] qapi: make Xen event commands unconditionally
 available
Message-ID: <aBzvojVlYZbhgFH5@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-7-berrange@redhat.com>
 <053d4bb5-a532-4133-9459-cb05a46a43db@linaro.org>
 <4534c279c6ffdefd7449f7ca114cf11d5c904c32.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4534c279c6ffdefd7449f7ca114cf11d5c904c32.camel@infradead.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, May 08, 2025 at 10:48:22AM -0700, David Woodhouse wrote:
> On Thu, 2025-05-08 at 17:01 +0200, Philippe Mathieu-Daudé wrote:
> > Cc'ing Zhao
> > 
> > On 8/5/25 15:58, Daniel P. Berrangé wrote:
> 
> Hm, what mailer does that? Does it mean August 5th or May 8th? Even in
> the original definition of RFC821 they knew not to use dates in those
> forms :)
> 
> > > This removes the TARGET_I386 condition from the Xen event channel
> > > commands, moving them to the recently introduced misc-i386.json
> > > QAPI file, given they are inherantly i386 specific commands.
> 
> 'inherently'
> 
> > 
> > > ---
> > > -##
> > > -# @EvtchnPortType:
> > > -#
> > > -# An enumeration of Xen event channel port types.
> > > -#
> > > -# @closed: The port is unused.
> > > -#
> > > -# @unbound: The port is allocated and ready to be bound.
> > > -#
> > > -# @interdomain: The port is connected as an interdomain interrupt.
> > > -#
> > > -# @pirq: The port is bound to a physical IRQ (PIRQ).
> > > -#
> > > -# @virq: The port is bound to a virtual IRQ (VIRQ).
> > > -#
> > > -# @ipi: The post is an inter-processor interrupt (IPI).
> > > -#
> > > -# Since: 8.0
> > > -##
> > > -{ 'enum': 'EvtchnPortType',
> > > -  'data': ['closed', 'unbound', 'interdomain', 'pirq', 'virq', 'ipi'],
> > > -  'if': 'TARGET_I386' }
> > 
> > Interesting, this ought to be "all {TARGET_I386, CONFIG_KVM}".
> 
> Isn't it CONFIG_XEN_EMU? But ISTR it wasn't possible to depend on those
> target-specific options in generic code? I forget the precise details.
> 
> So we ended up just ensuring the stubs were provided in the right
> cases.
> 
> This patch moves those stubs from hw/i386/kvm/xen-stubs.c which was
> built if !CONFIG_XEN_EMU, and moves them elsewhere if !CONFIG_KVM? So
> at first glance I think it might fail for KVM && !XEN_EMU builds... ?

The files in the top level 'stubs/' directory get built into
libqemuutil.a, and thus those stubs are available to every
system binary, in every configuration scenario.

If the real impl of these methods is present in any binary, the stubs
file impl should get discarded by the linker automatically, avoiding
a duplicate symbols problem.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


