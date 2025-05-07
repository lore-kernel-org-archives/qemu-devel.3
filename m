Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EA4C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 08:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCaPn-0007qZ-3d; Wed, 07 May 2025 04:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCaPf-0007qR-JC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 04:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCaPb-0000Nw-5q
 for qemu-devel@nongnu.org; Wed, 07 May 2025 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746607552;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VX04qeOyFgEd1uyFBFdIgzO06tKo8ZQcWBRhUp8irkY=;
 b=S5eXi9MHcJiv87TCYF7G/+sIHAneeFvFJqdKGIAcq7/oRQcVZEfGPwNHnmH1beLWGftd2w
 141/xhaIenlRmiG0JhFzBs1ZSKevPynPr/AgcXwy5+KRWdaii4u/IYcPGihtZV+5p/iIKs
 5qsw+c4rCXjQe4ygB6PSlekJlbSa9Yc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-rytgggROO4aKQJRC12XMcA-1; Wed,
 07 May 2025 04:45:50 -0400
X-MC-Unique: rytgggROO4aKQJRC12XMcA-1
X-Mimecast-MFC-AGG-ID: rytgggROO4aKQJRC12XMcA_1746607549
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10E0519560AD; Wed,  7 May 2025 08:45:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8F0E19560AF; Wed,  7 May 2025 08:45:47 +0000 (UTC)
Date: Wed, 7 May 2025 09:45:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/usb/network: Remove hardcoded 0x40 prefix
Message-ID: <aBsduLe2QDbr4Ol1@redhat.com>
References: <20250506164602.3897164-1-stgraber@stgraber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506164602.3897164-1-stgraber@stgraber.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 12:45:53PM -0400, Stéphane Graber via wrote:
> USB NICs have a "40:" prefix hardcoded for all MAC addresses.
> 
> This overrides user-provided configuration and leads to an inconsistent
> experience.
> 
> I couldn't find any documented reason (comment or git commits) for this
> behavior. It seems like everyone is just expecting the MAC address to be
> fully passed through to the guest, but it isn't.
> 
> This is also particularly problematic as the "40:" prefix isn't a
> reserved prefix for MAC addresses (IEEE OUI). There are a number of
> valid allocations out there which use this prefix, meaning that QEMU may
> be causing MAC address conflicts.
> 
> Signed-off-by: Stéphane Graber <stgraber@stgraber.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
> ---
>  hw/usb/dev-network.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
> index 81cc09dcac..1df2454181 100644
> --- a/hw/usb/dev-network.c
> +++ b/hw/usb/dev-network.c
> @@ -1383,7 +1383,7 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>      snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
>               "%02x%02x%02x%02x%02x%02x",
> -             0x40,
> +             s->conf.macaddr.a[0],
>               s->conf.macaddr.a[1],
>               s->conf.macaddr.a[2],
>               s->conf.macaddr.a[3],

To repeat what I said in the ticket, the 0x40 byte originates from when
this was first committed to QEMU. We can see the finall accepted patch

  https://lists.nongnu.org/archive/html/qemu-devel/2008-07/msg00385.html

but tracing the history back further, this was *not* in the version of
the patches submitted by the original author 2 years earlier:

 https://lists.nongnu.org/archive/html/qemu-devel/2006-10/msg00339.html
 
There's no explanation of this difference. Could easily be a left-over
hack from some debugging attempt that no one noticed until now.

It can't have been forcing a specific vendor's prefix, since prefixes
are more than 1 byte long. To me, it smells like a debugging hack
where someone wanted to see this fixed byte appear, though even that
is a bit wierd as you could just set the desired mac as a cli arg.

Anyway I can't come up with a justification for keeping this, so

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

..unless someone believes we need to tie this change to a machine type
version ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


