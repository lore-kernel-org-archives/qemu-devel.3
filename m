Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA860C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpq0K-0007kc-2N; Wed, 05 Mar 2025 09:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpq0H-0007hX-P1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpq0F-0001iM-MO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741185942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WgFmeM1ivupd2UZwWsZSEACurJ8lVuBYz8fgGFQ+7XY=;
 b=ACDCc0naYh/1yu1S/pg78gh4i7vqu8wQnCSCG+/52tsV2AajIoXMa2kPkQf2byUAH4sRjV
 ze+hNHWGMLW1CEGjWBD/zzWoLc2lXoV8hqTrzbJssZtlXaevxX9fKaAVwYdMym92uxec/e
 LvK+nrM7IYtrkA3HpqL0yO7Si4OdCKI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-pOXsXt4TMZKiFjtTKaSYGA-1; Wed,
 05 Mar 2025 09:45:34 -0500
X-MC-Unique: pOXsXt4TMZKiFjtTKaSYGA-1
X-Mimecast-MFC-AGG-ID: pOXsXt4TMZKiFjtTKaSYGA_1741185933
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21C461956060; Wed,  5 Mar 2025 14:45:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 076901954B32; Wed,  5 Mar 2025 14:45:30 +0000 (UTC)
Date: Wed, 5 Mar 2025 14:45:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Benjamin Charlton <Benjamin.Charlton@avanti.space>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: QEMU and ia64
Message-ID: <Z8hjhx1ALEB-f39N@redhat.com>
References: <CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05, 2025 at 08:37:18AM +0000, Benjamin Charlton wrote:
> Hello.
> 
> Sorry to bother you, I am very new to all of this and but I am
> looking for a ia64 emulator, sadly it has to be this to run a
> piece of old software. GPT suggested I clone your project and
> emulate this processor. However I am receiving an error

Sorry, GPT is misdirecting you. QEMU does not support ia64 guest
machine emulation.

At best you might find some ancient fork of QEMU that has it,
though I think even that was just KVM support, not emulation,
and kernel support was deleted anyway.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


