Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0904606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSvQ4S9e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPqo-0008Mj-Nh; Fri, 06 Nov 2026 14:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPPql-0008MN-Lj
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:43:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPPqj-0002sG-Mv
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793994223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iQPAryTMwWm5VSzpU3ZNCmPNAIJeKeW7X5AJmbP3Ahk=;
 b=dSvQ4S9eZ1ZQaRXa6SACiSWDMAMX3LFgUT++RESelDW1ve348QzyPUCMSY5oCIWzF6qzlT
 u82HfbqkKWvuh1TbQlp3yJ0tu23ZFGAPyj+QDFGvT02EKftGI7XhzkV7O8KyQ/wPRi3For
 Akie6Q7h+nhbLWn89jMEecHhhKYd6QQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-tKee0IRYPkyD4FI4owDEpA-1; Fri,
 06 Nov 2026 14:43:40 -0500
X-MC-Unique: tKee0IRYPkyD4FI4owDEpA-1
X-Mimecast-MFC-AGG-ID: tKee0IRYPkyD4FI4owDEpA_1793994219
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CBC91955E97; Fri,  6 Nov 2026 19:43:39 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B38F187C369; Fri,  6 Nov 2026 19:43:38 +0000 (UTC)
Date: Fri, 6 Nov 2026 19:43:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: Mention security considerations for NBD flaws
Message-ID: <au4t5zsoxNsi032M@redhat.com>
References: <20261106192751.570328-2-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106192751.570328-2-eblake@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Nov 06, 2026 at 01:27:34PM -0600, Eric Blake wrote:
> Not all NBD protocol violations are equal. If a malicious server or
> client can trigger a QEMU assertion failure on a plaintext connection,
> but can be trivially mitigated by enabling TLS to weed out untrusted
> partners that would violate the protocol in the first place, then the
> bug does not need to be embargoed.  Spell this out in our policy.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/system/security.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index e211fdd2344..29bb3e9b2a1 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -143,6 +143,17 @@ an issue as a normal bug.
>    which case plain manipulation of the stream is not considered as
>    an attack vector.
> 
> +* **network protocols**. In scenarios involving a network connection,
> +  such as NBD block devices, some bugs might be triggered when a
> +  malicious server or client on the other side of the connection
> +  intentionally violates the expected protocol. However, to be
> +  considered as a security attack vector, the bug must be reproduced
> +  prior to QEMU completing a TLS handshake with the remote partner. If
> +  the bug relies on a plaintext connection, or can only be triggered
> +  after first successfully negotiating TLS to filter out untrusted
> +  connections, then it will be treated as a hardening bug but not a
> +  security flaw.

I don't think we can be so broad in ruling out these flaws
as security bugs, merely by performing an authorization
check of the client via a TLS certificate.

This works in the case of live migration, because both sides
of the network connection are inherently operating at the same
privilege level, as they both have full access to the QEMU VM
workload.

In the case of NBD, an authorized client can still be considered
to operate at a lesser privilege level than QEMU. We can have
exported 1 disk via NBD, but if the authorized client expoits
a bug in QEMU and thus accesses unrelated data that is still
a privilege violation.


In the NBD case, an example where we could rule out a security
issue, is if an NBD protocol exploit leaked a disk sector for
the dis that was already exported over NBD, as it would not
be giving info that the NBD client was not already authorized
to have.

Many (possibly most) NBD bugs, however, I think will end up
being security issues. If they have a "low" severity, however,
we can rule our security handling via our catch all rule.


>  * **uninitialized stack variables**. If the bug scenario relies on
>    undefined behaviour from stack variables that lack explicit
>    initialization, it will not usually be considered a security flaw.
> @@ -320,3 +331,16 @@ encryption and authorization control policy on client connections.
>  In summary, the monitor console is considered a privileged control interface to
>  QEMU and as such should only be made accessible to a trusted management
>  application or user.
> +
> +Block device network protocols (NBD, NFS, etc.)
> +'''''''''''''''''''''''''''''''''''''''''''''''
> +
> +When using QEMU to access remote storage over a network (such as QEMU
> +acting as an NBD or NFS client) or to provide remote storage access
> +(such as QEMU acting as an NBD server), it is important to realize
> +that an unencrypted connection can allow an external process a
> +potential attack vector over the network port. The general
> +recommendation is that if the protocol allows the use of TLS, then the
> +management application must configure the use of TLS, in order to
> +limit the impact of unauthorized or man-in-the-middle attacks to the
> +smaller region of time before the TLS handshake takes place.

Performing TLS only protects against a MITM attack by default.

To protect further scenarios we must document that the protocol
must have x509 client certificates issued to authorized clients
and the tls-creds-x509 object set 'verify-peer=on' to check
them, potentially also 'tls-authz' to filter which certificates
are allowed if the CA issues certs more broadly.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


