Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA53D65C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXR0-00085G-Cz; Thu, 14 Nov 2024 05:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tBXQz-00084y-6C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tBXQx-0003b8-MC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731581442;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type; bh=Qjshv8JYgC35bor1ikd262hoIVwyU0XkoMNTSlDvDe8=;
 b=DTbSM5jFPptlcmhCgiX5WMv5GfbD7HqDVicSVo0otMeMq+l83elFjawAEJJPiBnMOZ7mYN
 ciUXPmyvHgtXETCgmDw/JqgvUBwlJF+mTD265/K3bx+pRoeW8eJInlRuYlaIizRPS/mtOn
 Iqh/0lOf2G+9DoucHkQZZVygbTeyNhE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-lFlzfjL4NOWRVAKBi0pg1w-1; Thu,
 14 Nov 2024 05:50:39 -0500
X-MC-Unique: lFlzfjL4NOWRVAKBi0pg1w-1
X-Mimecast-MFC-AGG-ID: lFlzfjL4NOWRVAKBi0pg1w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5DB91955F42
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:50:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.209])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAC433003B71; Thu, 14 Nov 2024 10:50:36 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:50:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: QEMU wiki theme table of contents changes
Message-ID: <ZzXV-KyYLa-7yNdV@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

Looking at

  https://wiki.qemu.org/ChangeLog/9.2

I'm thinking that I'm sure there used to be a table of contents present
at the top of pages, but none is to be seen..... until I eventually
discover that there's a bare noticable, fully collapsed ToC in the left
hand nav panel below all the general wiki nav links, partially off the
bottom of the page :-(

If going to https://wiki.qemu.org/Special:Preferences, "Appearance" and
selecting "Vector legacy (2010)" as the "Skin" instad of "Vector (2022)"
then the full ToC re-appears at the top of page in the main body content.

I'm presuming this style change was triggered by a software upgrade that
was done on the wiki at some point.

IMHO this is quite a significant visual/usability regression.

On wikipedia, they do have the same theme, with ToC in the left hand
panel, but their ToC is expanded by default, and there's no other general
navigation in the left hand panel that's displacing the ToC off the bottom
of the page. That is fairly effective as a layout.

We can do something to the QEMU skin to improve this ? Swapping order
of the ToC & general nav blocks in the left hand panel would be a
improvement, as well making it expand at least 1 further level by
default.

If we're going to have background colour set for the general nav block,
we should also probably do similar for the ToC nav block to make it
visually stand out to the same degree.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


