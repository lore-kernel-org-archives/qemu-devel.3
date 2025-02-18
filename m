Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31AEC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkK23-0007oZ-N4; Tue, 18 Feb 2025 04:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkK22-0007oL-Ni
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:36:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkK1z-00018f-2z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739871401;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=W2VT9kUzCxqEOgCUZnEeypekGBvWjYMXvMPin/ptnAk=;
 b=AjZJk/QulAKSrDIETb2pjrP8WnjKVtU0ac7MemM967cS6VpZdrLuUbhftrjCETV18USegh
 a2pV11CQeHDWvqJ0sPKo27rgxg+4Y8jSXDiVygCZ8xZH0AW3I9qr4/FOt0Z89pIRYta5iY
 QO2rqHdtySkK684sWoO/+M8SULOFAYg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-seSaaMvPOPqXFMOp_c4Wkw-1; Tue,
 18 Feb 2025 04:36:36 -0500
X-MC-Unique: seSaaMvPOPqXFMOp_c4Wkw-1
X-Mimecast-MFC-AGG-ID: seSaaMvPOPqXFMOp_c4Wkw_1739871393
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7525F190308C; Tue, 18 Feb 2025 09:36:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A0501800362; Tue, 18 Feb 2025 09:36:29 +0000 (UTC)
Date: Tue, 18 Feb 2025 09:36:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: qemu 10.0 release and the next debian stable release (trixie)
Message-ID: <Z7RUmX-_Lqy6_CGw@redhat.com>
References: <138bb61b-d7a4-47e0-b746-f1d3a14c6dc8@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <138bb61b-d7a4-47e0-b746-f1d3a14c6dc8@tls.msk.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Tue, Feb 18, 2025 at 11:50:57AM +0300, Michael Tokarev wrote:
> Hi!
> 
> It so happened that current schedule for debian and qemu clashes with
> each other in a fun way.  2025-04-15 is the date planned for qemu 10.0
> release (if no rc4 is needed), and is it the date of debian 13.0 trixe
> freeze.
> 
> Can we move the qemu release date a little bit earlier, so I'll have
> a chance to upload qemu 10.0 to debian trixie?

That's just the Debian soft freeze date IIUC[1], so isn't it possible to
ship the -rc3 release at the the time of soft freeze and then do an update
to the final release which would arrive before hard freeze a month later ? 


With regards,
Daniel

[1] https://release.debian.org/
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


