Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8696082BC0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgvqIMwO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNttF-0004zD-V2; Mon, 02 Nov 2026 10:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNttC-0004ys-O1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNttA-0004Ue-Mt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793633039;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SNB3rN82XlNkZ8ZruSt2i5XUfrIRQARsD/gjvb0/RFY=;
 b=AgvqIMwOd3QpAOEun+0gXh8ie16zoxcs7vqoe03ERaDwXlpFXaRB0G1T49Xx4qdBeC21TZ
 6FW3deu4dyZImIek7qqKEfEaOevxD9rTVIm9DmgJE7g76wQv3BJPED1EFccRwB6Cq8IinP
 LagaCrKCgeTOi5uQsLVSopsGR7H3X5A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-t8kPwQJvM5-x8GdIwyDWww-1; Mon,
 02 Nov 2026 10:23:57 -0500
X-MC-Unique: t8kPwQJvM5-x8GdIwyDWww-1
X-Mimecast-MFC-AGG-ID: t8kPwQJvM5-x8GdIwyDWww_1793633037
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D57018007F0
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 15:23:57 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C975F30000E3; Mon,  2 Nov 2026 15:23:55 +0000 (UTC)
Date: Mon, 2 Nov 2026 15:23:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com
Subject: Re: [PATCH] qapi: Consistently use x.y with since
Message-ID: <auirCeOoztlMvglH@redhat.com>
References: <20261102145627.3224952-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102145627.3224952-1-armbru@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 03:56:27PM +0100, Markus Armbruster wrote:
> docs/devel/qapi-code-gen.rst documents "Since: x.y.z" and "(since
> x.y.z)", but we almost always use just x.y.  Adjust the doc and the
> exceptions to the ruling practice.

Shortening to 2 digits is sensible given our current version
numbering scheme. The 3rd digit is exclusively for stable
branches that should not be forking qapi schemas.

This only applies since our switch to this versioning scheme,
which was in 3.0.0, so anything earlier than this should not
be changed IMHO.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst |  4 ++--
>  docs/interop/firmware.json   |  4 ++--
>  qapi/accelerator.json        |  6 +++---
>  qapi/crypto.json             |  2 +-
>  qga/qapi-schema.json         | 38 ++++++++++++++++++------------------
>  5 files changed, 27 insertions(+), 27 deletions(-)
> 

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 7b937713e6..531fb8f8e0 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -110,7 +110,7 @@
>  #
>  # Returns: The unique integer id passed in by the client
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-sync',
>    'data':    { 'id': 'int' },
> @@ -120,7 +120,7 @@
>  # @guest-ping:
>  #     Ping the guest agent, a non-error return implies success
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-ping' }
>  
> @@ -172,7 +172,7 @@
>  # @success-response: whether command returns a response on success
>  #     (since 1.7)
>  #
> -# Since: 1.1.0
> +# Since: 1.1
>  ##
>  { 'struct': 'GuestAgentCommandInfo',
>    'data': { 'name': 'str', 'enabled': 'bool', 'success-response': 'bool' } }
> @@ -185,7 +185,7 @@
>  #
>  # @supported_commands: Information about guest agent commands
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'struct': 'GuestAgentInfo',
>    'data': { 'version': 'str',
> @@ -195,7 +195,7 @@
>  # @guest-info:
>  #     Get some information about the guest agent.
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-info',
>    'returns': 'GuestAgentInfo' }
> @@ -213,7 +213,7 @@
>  # when running with --no-shutdown, by issuing the `query-status` QMP
>  # command to confirm the VM status is "shutdown".
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-shutdown', 'data': { '*mode': 'str' },
>    'success-response': false }
> @@ -228,7 +228,7 @@
>  #
>  # Returns: Guest file handle
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-file-open',
>    'data':    { 'path': 'str', '*mode': 'str' },
> @@ -240,7 +240,7 @@
>  #
>  # @handle: filehandle returned by `guest-file-open`
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-file-close',
>    'data': { 'handle': 'int' } }
> @@ -256,7 +256,7 @@
>  #
>  # @eof: whether EOF was encountered during read operation.
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'struct': 'GuestFileRead',
>    'data': { 'count': 'int', 'buf-b64': 'str', 'eof': 'bool' } }
> @@ -273,7 +273,7 @@
>  # @count: maximum number of bytes to read (default is 4KB, maximum is
>  #     48MB)
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-file-read',
>    'data':    { 'handle': 'int', '*count': 'int' },
> @@ -288,7 +288,7 @@
>  #
>  # @eof: whether EOF was encountered during write operation.
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'struct': 'GuestFileWrite',
>    'data': { 'count': 'int', 'eof': 'bool' } }
> @@ -304,7 +304,7 @@
>  # @count: bytes to write (actual bytes, after base64-decode), default
>  #     is all content in buf-b64 buffer after base64 decoding
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-file-write',
>    'data':    { 'handle': 'int', 'buf-b64': 'str', '*count': 'int' },
> @@ -318,7 +318,7 @@
>  #
>  # @eof: whether EOF was encountered during file seek
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'struct': 'GuestFileSeek',
>    'data': { 'position': 'int', 'eof': 'bool' } }
> @@ -364,7 +364,7 @@
>  #
>  # @whence: Symbolic or numeric code for interpreting offset
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-file-seek',
>    'data':    { 'handle': 'int', 'offset': 'int',
> @@ -377,7 +377,7 @@
>  #
>  # @handle: filehandle returned by `guest-file-open`
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-file-flush',
>    'data': { 'handle': 'int' } }
> @@ -390,7 +390,7 @@
>  #
>  # @frozen: all non-network guest filesystems frozen
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'enum': 'GuestFsfreezeStatus',
>    'data': [ 'thawed', 'frozen' ],
> @@ -404,7 +404,7 @@
>  #    result of some other guest processes having issued an fs
>  #    freeze/thaw.
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-fsfreeze-status',
>    'returns': 'GuestFsfreezeStatus',
> @@ -427,7 +427,7 @@
>  #    Volume Shadow-copy Service DLL helper.  The frozen state is
>  #    limited for up to 10 seconds by VSS.
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-fsfreeze-freeze',
>    'returns': 'int',
> @@ -464,7 +464,7 @@
>  #    filesystems were unfrozen before this call, and that the
>  #    filesystem state may have changed before issuing this command.
>  #
> -# Since: 0.15.0
> +# Since: 0.15
>  ##
>  { 'command': 'guest-fsfreeze-thaw',
>    'returns': 'int',

Don't change any of these, since at that vintage, the 3rd digit
was significant.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


