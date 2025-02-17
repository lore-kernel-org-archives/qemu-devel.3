Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E14C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2Zx-0001SW-82; Mon, 17 Feb 2025 09:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tk2Zu-0001S4-N0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:58:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tk2Zs-0006Ve-Cp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739804310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OA7DltHqI14IuLpK6i36CFDU2j26iWGZRN7zI4pQxUs=;
 b=eLKmqYj1kipFpXzTxQlAi8Bx4WrHeAuepHrEIcaaWutlCFA/Q+oWUgPsEhG/VLE8TiznN8
 A7tp5QEHQrmwzh2lyZWcs1FQyv272TLcfokPrHPeHHTu0YO6+6YneDRr+iHJypbS/83mzQ
 FWpCHtFAKGgAwSumt3lzCOM+QX1yG2o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-bFSeKE_SNMGTTkFhP7OmqA-1; Mon,
 17 Feb 2025 09:58:28 -0500
X-MC-Unique: bFSeKE_SNMGTTkFhP7OmqA-1
X-Mimecast-MFC-AGG-ID: bFSeKE_SNMGTTkFhP7OmqA_1739804308
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA67D19783B5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 14:58:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 194A11955BD4; Mon, 17 Feb 2025 14:58:25 +0000 (UTC)
Date: Mon, 17 Feb 2025 14:58:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v4 00/11]
Message-ID: <Z7NOjiz20gzBQhX5@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Feb 14, 2025 at 09:29:33PM +0100, Victor Toso wrote:
> Hi again,
> 
> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.
> 
> Previous version (10 Jan 2025)
>     https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg01530.html
> 
> The generated code was mostly tested using existing examples in the QAPI
> documentation, 192 instances that might have multiple QMP messages each.
> 
> You can find the the tests and the generated code in my personal repo,
> main branch:
> 
>     https://gitlab.com/victortoso/qapi-go
> 
> If you want to see the generated code from QEMU's master but per patch:
> 
>     https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v4-by-patch

In terms of generated code, my only real feedback is that the
re-wrapping of docs comments is having undesirable effets
on formatting

##
# @add_client:
#
# Allow client connections for VNC, Spice and socket based character
# devices to be passed in to QEMU via SCM_RIGHTS.
#
# If the FD associated with @fdname is not a socket, the command will
# fail and the FD will be closed.
#
# @protocol: protocol name.  Valid names are "vnc", "spice",
#     "@dbus-display" or the name of a character device (e.g. from
#     -chardev id=XXXX)
#
# @fdname: file descriptor name previously passed via 'getfd' command
#
# @skipauth: whether to skip authentication.  Only applies to "vnc"
#     and "spice" protocols
#
# @tls: whether to perform TLS.  Only applies to the "spice" protocol
#
# Since: 0.14
#
# .. qmp-example::
#
#     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
#                                                  "fdname": "myclient" } }
#     <- { "return": {} }
##


is getting turned into


// Allow client connections for VNC, Spice and socket based character
// devices to be passed in to QEMU via SCM_RIGHTS.  If the FD
// associated with @fdname is not a socket, the command will fail and
// the FD will be closed.
//
// Since: 0.14
//
// .. qmp-example::    -> { "execute": "add_client", "arguments": {
// "protocol": "vnc",                          "fdname": "myclient" }
// }   <- { "return": {} }


the '.. qmp-example' bit is what's particularly badly affected.

If we assume that the input QAPI schemas are nicely lined wrapped,
we could probably just preserve the docs lines as-is with no change
in wrapping.

That said I'm not sure if we'll need some docs syntax changes to
make it render nicely - hard to say until the code appears up on
pkg.go.dev, so can probably worry about that aspect later.


> ################
> # Expectations #
> ################
> 
> As is, this still is a PoC that works. I'd like to have the generated
> code included in QEMU's gitlab [0] in order to write library and tools
> on top. Initial version should be considered alpha. Moving to
> beta/stable would require functional libraries and tools, but this work
> needs to be merged before one commit to that.

We don't need to overthink this. I don't think we're best served by
continuing to post many more rounds of this series. Better to just
get it into a dedicated git repo and iterate via pull requests IMHO.

Golang uses semver, so we could start publishing the generated code in
a Go module as it is today, as long as we pick a v0.XXX.0 version number.
'XXX' would be a packing of QEMU's 3 digit version into the semver 2nd
digit. This lets us indicate this is not considered a stable API, letting
us iterate on further imlp details, while also getting us in the habit of
publishing releases to track schema updates for each new QEMU.

We just need the patch for qapi-gen.py to support plugins for code
generation to make this happen, so we can decouple ongoing development
from QEMU's main git repo & release cycle.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


