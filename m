Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABA8C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHg4x-0000o6-1T; Thu, 13 Jun 2024 04:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHg4w-0000nv-3t
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHg4t-0006Lo-6s
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718268301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxqMQGq92Xwwnv3EpYXW5u/8xaVhPtkkusQHbb5hspk=;
 b=SjOB7D5T/iqdW0D8gl2LlXlBYPzdVSP8OgoFQeYepy/wx5BymCW+JHdOtjqwph/1LRWleF
 lPKzt0FhFSvM1jXXTWPgIXhMrgun9jS3jGUfNtl+Qn82PI0W2RlkszEwEJsuc6uH2wciQV
 1rwl8sqjmwx8id4amYppwlbAHk3oYPA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197--VChXxsgOjmYAUK8cS4GAA-1; Thu,
 13 Jun 2024 04:44:56 -0400
X-MC-Unique: -VChXxsgOjmYAUK8cS4GAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7743C19560B2; Thu, 13 Jun 2024 08:44:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C7119560BF; Thu, 13 Jun 2024 08:44:51 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:44:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/4] usb/hub: mark as deprecated
Message-ID: <ZmqxgAh1v6-Y8zjH@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-3-kraxel@redhat.com>
 <ZmHKotWS7ywfIvOj@redhat.com> <87r0d2w431.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0d2w431.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Jun 12, 2024 at 04:52:50PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jun 06, 2024 at 04:30:08PM +0200, Gerd Hoffmann wrote:
> >> The hub supports only USB 1.1.  When running out of usb ports it is in
> >> almost all cases the much better choice to add another usb host adapter
> >> (or increase the number of root ports when using xhci) instead of using
> >> the usb hub.
> >
> > Is that actually a strong enough reason to delete this device though ?
> > This reads like its merely something we don't expect to be commonly
> > used, rather than something we would actively want to delete.
> 
> This does seem quite aggressive because there may be cases when users
> explicitly want to use old devices. Maybe there is need for a third
> state (better_alternatives?) so we can steer users away from old command
> lines they may have picked up from the web to the modern alternative?

We've got 2 flags proposed in patch 1 - "deprecated" and "not_secure" -
which we formally expose to mgmt apps/users. Both of these are actionable
in an unambiguous way. An application can query this info, and can also
tell QEMU to enforce policy on this. Both are good.

The "better alternatives" conceptable, however, is an inherantly fuzzy
concept, because "better" is very much a use-case depedent / eye of the
beholder concept. This would makes it difficult/impractical for an
application to take action based on such a "better-alternatives' schema
marker. It would imply the application has to understands the better
alternatives ahead of time, as well as understanding the end users'
intent and that's not really viable.



This is a long winded way of saying that while "better alternatives"
is certainly a concept that is relevant, I'm not convinced it belongs
in the schema, as opposed to being a documentation task.

We haven't consistently provided documentation in the manual for every
device, so in many cases '-device help' is all that exists, but in the
case of USB we do actually have docs:

  https://www.qemu.org/docs/master/system/devices/usb.html

and those docs give little guidance to users about 'usb-hub', so IMHO
that's where we should be documenting the tradeoffs of the different
USB config scenarios.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


