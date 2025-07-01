Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0EBC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXRn-00048B-UY; Tue, 01 Jul 2025 05:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWXRl-00047X-Al
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWXRg-0003Rh-He
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751362709;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kuzdZmSCbqt1FEXK6fnL06S9XI+rWz9PWext7uu1g6I=;
 b=dutwvhTwzu7zFUql/1ffgdNt+NYgzyEHHqnoS8/SsV0m7bV+tTYrWbcEmnTJqbtzPsZeNF
 qN2RKmhcm8GlwXiLPJ3Mu2bFals1WitJCbl9Jsd8irLTngbnzkjWqKrXPXEXG3ib91e9+N
 ykyJXtzGnDTxcVTbltaUn6ffIKuURE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-uX00KfVrMHyrlDwkgXBk9w-1; Tue,
 01 Jul 2025 05:38:25 -0400
X-MC-Unique: uX00KfVrMHyrlDwkgXBk9w-1
X-Mimecast-MFC-AGG-ID: uX00KfVrMHyrlDwkgXBk9w_1751362704
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24893183E3F9; Tue,  1 Jul 2025 09:38:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.157])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C9B819560B4; Tue,  1 Jul 2025 09:38:05 +0000 (UTC)
Date: Tue, 1 Jul 2025 10:38:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] Socket activation: enable spice listener.
Message-ID: <aGOsek0xeyXk3G6y@redhat.com>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250627180331.1370235-3-dkg@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627180331.1370235-3-dkg@fifthhorseman.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jun 27, 2025 at 02:03:31PM -0400, Daniel Kahn Gillmor wrote:
> Enable qemu to be socket-activated based on a spice connection.
> 
> Note that this depends on un-deprecating
> spice_server_set_listen_socket_fd, see
> https://gitlab.freedesktop.org/spice/spice/-/merge_requests/240
> 
> This partially addresses
> https://gitlab.com/qemu-project/qemu/-/issues/3011

I don't think this is showing the right approach for systemd socket
activation. Spice is rather an odd-ball part of QEMU today that isn't
using modern best practice config design, so what looks simple from a
Spice POV is not aligned with what we need for QEMU.

Historically we've long supported passing pre-opened FDs of any kind
into QEMU at launch time, but we didn't rely on systemd socket
activation. We just passed the FDs in and referenced them numerically
in the config.

At runtime we then also had the ability to pass in pre-opend FDs over
QMP, which we referenced by name.

IMHO for systemd socket activation, we want to introduce the ability
to reference sockets by name at startup, so it is aligned with what
we can do at runtime.

Primarily this comes down to having logic present in the socket_get_fd
method, such that when there is no current monitor, we use the systemd
named sockets.

We should also have logic to validate that we have consumed all
systemd sockets, before we move out of startup phase, in order to
detect config errors. This indicates should we proactively parse
the socket activation env at starutp and record all FDs, and keep
track of which are consumed by the config.

Meanwhile both -vnc and -spice need updating to have their CLI
modelled in QAPI, and use the SocketAdddress struct config, which
would unlock FD passing both with & without systemd socket activation.

And then there are some hard questions about how we integrate this with
the various helper programs like qemu-nbd, and friends, which all
already support systemd socket activation but fail to validate the
names, making it hard to add propert support while retaining back compat.

This is all a major amount of work, which is partly why we've not addressed
this yet, despite it being on the wishlist for years already


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


