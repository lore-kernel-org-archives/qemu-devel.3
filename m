Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD41C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHi0o-0000A6-06; Thu, 13 Jun 2024 06:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHi0l-00009m-FJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHi0j-0004VQ-L9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718275732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYrAQwCLR73d4yNqRq6IopSshhFnMB8xgI+2NAN0pHc=;
 b=GKuve8tRTvhaVmCzqCLlKu6k+65B68UNCVCDXrFjgoI9q1foRXLAxTFiKTT4a4Vv6qRivo
 KVZ5zRUUBzBSTXuZyRNNSJcJZofZE4KjhY/Qki/04Q2E7XJlzCgkvMH0qlnYZTc2x4kXNM
 9OfndYipJP/NAf5Yman3wqG1vb2ka+w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-4ofOfHnnOVCfOKc9NPHt3Q-1; Thu,
 13 Jun 2024 06:48:44 -0400
X-MC-Unique: 4ofOfHnnOVCfOKc9NPHt3Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2925A1955E72; Thu, 13 Jun 2024 10:48:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A21F3000219; Thu, 13 Jun 2024 10:48:39 +0000 (UTC)
Date: Thu, 13 Jun 2024 11:48:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/4] usb/hub: mark as deprecated
Message-ID: <ZmrOgxutj7ETndGM@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-3-kraxel@redhat.com>
 <ZmHKotWS7ywfIvOj@redhat.com> <87r0d2w431.fsf@draig.linaro.org>
 <87o785b5vn.fsf@pond.sub.org> <ZmqvJIekaW9jWP6F@redhat.com>
 <87y1799lg8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1799lg8.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Thu, Jun 13, 2024 at 12:38:31PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jun 13, 2024 at 10:31:56AM +0200, Markus Armbruster wrote:
> >> Alex Bennée <alex.bennee@linaro.org> writes:
> >> 
> >> > Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >
> >> >> On Thu, Jun 06, 2024 at 04:30:08PM +0200, Gerd Hoffmann wrote:
> >> >>> The hub supports only USB 1.1.  When running out of usb ports it is in
> >> >>> almost all cases the much better choice to add another usb host adapter
> >> >>> (or increase the number of root ports when using xhci) instead of using
> >> >>> the usb hub.
> >> >>
> >> >> Is that actually a strong enough reason to delete this device though ?
> >> >> This reads like its merely something we don't expect to be commonly
> >> >> used, rather than something we would actively want to delete.
> >> >
> >> > This does seem quite aggressive because there may be cases when users
> >> > explicitly want to use old devices. Maybe there is need for a third
> >> > state (better_alternatives?) so we can steer users away from old command
> >> > lines they may have picked up from the web to the modern alternative?
> >> 
> >> What exactly do we mean when we call something deprecated?
> >> 
> >> For me, it means "you should not normally use this".
> >> 
> >> Important special case: "because we intend to remove it."
> >
> > That's not the special case, it is the regular case - the documented
> > meaning of 'deprecated' in QEMU. When we deprecate something, it is
> > a warning that we intend to delete it in 2 releases time.
> 
> It's the regular case in QEMU today because we made it so there, by
> electing to limit deprecation to "because we intend to remove it."

Fair point, but assigning additional meanings to the existing 'deprecation'
concept will undermine the value QEMU & its consumers obtain from current
usage.

Consumers know if they see the "deprecated" marker, it has started a clock
ticking and they must immediately plan work to stop using the feature.

QEMU maintainers know if they see the 'deprecated' marker and it has been
2 releases, then we can delete it.

I don't want to loose that clear & easily understood meaning, by overloading
"deprecated" for scenarios like "it is sometimes better to use a different
device instead of this one, depending on factors X, Y & Z".

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


