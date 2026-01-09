Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3028AD167F3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 10:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve9P9-0006xk-Vd; Fri, 09 Jan 2026 05:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ve9P8-0006xb-Eg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 05:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ve9P6-0003Oy-L1
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 05:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767953255;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kqXqa/z20xXzqGwszoGQHOQvZhM3/sF3LS96EOsBmE=;
 b=BtXTlgSFZapE0b9kDzUNindjonWPLyMQnyUNL0/IAsGBAGJKggeL5s6J2TZphf+j8TXUyN
 r50DKmF1kgwwuiZNm09mPlt25CncRUHu0/TTjT1P7GljXy2EvX5Pelcqsa9+oFknbzcuDC
 CuZH8WBPQRXaFY/nDWIzEKjm/TgQjtM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-T-U1g9hDNSSq0BRCIqAthg-1; Fri,
 09 Jan 2026 05:07:32 -0500
X-MC-Unique: T-U1g9hDNSSq0BRCIqAthg-1
X-Mimecast-MFC-AGG-ID: T-U1g9hDNSSq0BRCIqAthg_1767953251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5914419560B2; Fri,  9 Jan 2026 10:07:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437F830002D1; Fri,  9 Jan 2026 10:07:29 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:07:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] Add query-tdx-capabilities
Message-ID: <aWDTXvXxPRj2fs2b@redhat.com>
References: <20260106183620.2144309-1-marcandre.lureau@redhat.com>
 <aV41CQP0JODTdRqy@redhat.com> <87qzrzku9z.fsf@pond.sub.org>
 <aWDMU7WOlGIdNush@redhat.com> <87jyxrksug.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyxrksug.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jan 09, 2026 at 11:01:27AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Jan 09, 2026 at 10:30:32AM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Tue, Jan 06, 2026 at 10:36:20PM +0400, marcandre.lureau@redhat.com wrote:
> >> >> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> >> 
> >> >> Return an empty TdxCapability struct, for extensibility and matching
> >> >> query-sev-capabilities return type.
> >> >> 
> >> >> Fixes: https://issues.redhat.com/browse/RHEL-129674
> >> >> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> [...]
> 
> >> > This matches the conceptual design used with query-sev-capabilities,
> >> > where the lack of SEV support has to be inferred from the command
> >> > returning "GenericError".
> >> 
> >> Such guesswork is brittle.  An interface requiring it is flawed, and
> >> should be improved.
> >> 
> >> Our SEV interface doesn't actually require it: query-sev tells you
> >> whether we have SEV.  Just run that first.
> >
> > Actually these commands are intended for different use cases.
> >
> > "query-sev" only returns info if you have launched qemu with
> >
> >   $QEMU -object sev-guest,id=cgs0  -machine confidential-guest-support=cgs0
> >
> > The goal of "query-sev-capabilities" is to allow you to determine
> > if the combination of host+kvm+qemu are capable of running a guest
> > with "sev-guest".
> >
> > IOW, query-sev-capabilities alone is what you want/need in order
> > to probe host features.
> >
> > query-sev is for examining running guest configuration
> 
> The doc comments fail to explain this.  Needs fixing.
> 
> Do management applications need to know more than "this combination of
> host + KVM + QEMU can do SEV, yes / no?
> 
> If yes, what do they need?  "No" split up into serval "No, because X"?

When libvirt runs  query-sev-capabilities it does not care about the
reason for it being unsupported.   Any "GenericError" is considered
to mark the lack of host support, and no fine grained checks are
performed on the err msg.

If query-sev-capabilities succeeds (indicating SEV is supported), then
all the returned info is exposed to mgmt apps in the libvirt domain
capabilities XML document.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


