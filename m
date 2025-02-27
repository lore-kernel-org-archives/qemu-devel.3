Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1487AC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tna4M-0001Y8-NO; Thu, 27 Feb 2025 04:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tna4L-0001U7-1S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tna4J-0006dN-4B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740648034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeU7GD6JsSTzyHzNlfab7XmgLUXdptuI9jkH7nuDxGA=;
 b=OA4UBV6R99zJdkfZ0HeLjODITHLdbDA8ixrDlL/FrIRtVF06roznXZ4zItldduPJ2vqXw/
 zuc/QKIwm5jwkCdD/xtmW1tA9RgdO3b9FaOswL8cplVd4l6UHoC7b1AVFzfaIbWOzHq6yp
 +/XJpP/dI7uHoGf+FxdThXs7XTvKyv0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-mS05kgoMMfS6pde-zsV8Og-1; Thu,
 27 Feb 2025 04:20:30 -0500
X-MC-Unique: mS05kgoMMfS6pde-zsV8Og-1
X-Mimecast-MFC-AGG-ID: mS05kgoMMfS6pde-zsV8Og_1740648029
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 461431954B21; Thu, 27 Feb 2025 09:20:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF762180035F; Thu, 27 Feb 2025 09:20:27 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:20:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 2/6] qdev: Change qdev_prop_pci_devfn member @name
 from "int32" to "str"
Message-ID: <Z8AuWGibUlW4IVw1@redhat.com>
References: <20250227085601.4140852-1-armbru@redhat.com>
 <20250227085601.4140852-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227085601.4140852-3-armbru@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 27, 2025 at 09:55:57AM +0100, Markus Armbruster wrote:
> Properties using qdev_prop_pci_devfn initially accepted a string of
> the form "DEV.FN" or "DEV" where DEV and FN are in hexadecimal.
> Member @name was "pci-devfn" initially.
> 
> Commit b403298adb5 (qdev: make the non-legacy pci address property
> accept an integer) changed them to additionally accept integers: bits
> 3..7 are DEV, and bits 0..2 are FN.  This is inaccessible externally
> in device_add so far.
> 
> The commit also changed @name to "int32", and set member @legacy-name
> to "pci-devfn".  Together, this kept QMP command
> device-list-properties unaffected: it used @name only when
> @legacy_name was null.
> 
> Commit 07d09c58dbb (qmp: Print descriptions of object properties)
> quietly dumbed that down to use @name always, and the next commit
> 18b91a3e082q (qdev: Drop legacy_name from qdev properties) dropped
> member @legacy_name.  This changed the value of @type reported by QMP
> command device-list-properties from "pci-devfn" to "int32".
> 
> But "int32" is misleading: device_add actually wants QAPI type "str".
> So change @name to that.

That history is "fun" :-)

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


