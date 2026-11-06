Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0448606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VLtfx3w4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQdr-0004uJ-6x; Fri, 06 Nov 2026 15:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPQdp-0004u3-6w
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPQdn-0007zi-Dz
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793997265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Qgza1yT8OTHvMWNs0RNZOXKibAaRfcTHjVitne2t0I=;
 b=VLtfx3w42onor5sG15iphpYuhj+X8/U+NWpUhx88ZsLUURtJRR4XfSPqyAbYiE9rmbHnzT
 trBJZNVy7KpEmB/gntwICleQna6njzBlBZd4QRswK2b7hdDnrtARTBAGJZSKVo8t/3sZrG
 ub/x6wyN/Zb1qC8YGzThkqGx+hsVoUQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-TS4XTkosP-q13ei6GVbtKA-1; Fri,
 06 Nov 2026 15:34:24 -0500
X-MC-Unique: TS4XTkosP-q13ei6GVbtKA-1
X-Mimecast-MFC-AGG-ID: TS4XTkosP-q13ei6GVbtKA_1793997263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 309811955E89; Fri,  6 Nov 2026 20:34:23 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF171195608B; Fri,  6 Nov 2026 20:34:21 +0000 (UTC)
Date: Fri, 6 Nov 2026 14:34:19 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: Mention security considerations for NBD flaws
Message-ID: <au4yC5EuJsIP-Lud@redhat.com>
References: <20261106192751.570328-2-eblake@redhat.com>
 <au4t5zsoxNsi032M@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au4t5zsoxNsi032M@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 07:43:35PM +0000, Daniel P. Berrangé wrote:
> On Fri, Nov 06, 2026 at 01:27:34PM -0600, Eric Blake wrote:
> > Not all NBD protocol violations are equal. If a malicious server or
> > client can trigger a QEMU assertion failure on a plaintext connection,
> > but can be trivially mitigated by enabling TLS to weed out untrusted
> > partners that would violate the protocol in the first place, then the
> > bug does not need to be embargoed.  Spell this out in our policy.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  docs/system/security.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/docs/system/security.rst b/docs/system/security.rst
> > index e211fdd2344..29bb3e9b2a1 100644
> > --- a/docs/system/security.rst
> > +++ b/docs/system/security.rst
> > @@ -143,6 +143,17 @@ an issue as a normal bug.
> >    which case plain manipulation of the stream is not considered as
> >    an attack vector.
> > 
> > +* **network protocols**. In scenarios involving a network connection,
> > +  such as NBD block devices, some bugs might be triggered when a
> > +  malicious server or client on the other side of the connection
> > +  intentionally violates the expected protocol. However, to be
> > +  considered as a security attack vector, the bug must be reproduced
> > +  prior to QEMU completing a TLS handshake with the remote partner. If
> > +  the bug relies on a plaintext connection, or can only be triggered
> > +  after first successfully negotiating TLS to filter out untrusted
> > +  connections, then it will be treated as a hardening bug but not a
> > +  security flaw.
> 
> I don't think we can be so broad in ruling out these flaws
> as security bugs, merely by performing an authorization
> check of the client via a TLS certificate.
> 
> This works in the case of live migration, because both sides
> of the network connection are inherently operating at the same
> privilege level, as they both have full access to the QEMU VM
> workload.
> 
> In the case of NBD, an authorized client can still be considered
> to operate at a lesser privilege level than QEMU. We can have
> exported 1 disk via NBD, but if the authorized client expoits
> a bug in QEMU and thus accesses unrelated data that is still
> a privilege violation.

Makes sense. Even a crash is thus a denial of service - while the
misbehaving client is not accessing data it is not entitled to, it is
taking out the rest of the qemu process which is beyond the bounds of
what remote storage clients should be able to do.

> 
> 
> In the NBD case, an example where we could rule out a security
> issue, is if an NBD protocol exploit leaked a disk sector for
> the dis that was already exported over NBD, as it would not
> be giving info that the NBD client was not already authorized
> to have.
> 
> Many (possibly most) NBD bugs, however, I think will end up
> being security issues. If they have a "low" severity, however,
> we can rule our security handling via our catch all rule.

I was trying to lean more into the aspect that if an NBD bug triggers
a crash, BUT the bug is only reachable from a code path where a
properly-configured QEMU that is enforcing TLS and x509 authentication
can restrict access to non-compliant clients, then it is a low
severity bug.  But given that we already have a paragraph on no
embargo for low severity, I would be fine with v2 leaving out this
proposed paragraph and instead just focusing on documenting the need
to utilize TLS and authorization as a way to reduce bug severity.

> 
> 
> >  * **uninitialized stack variables**. If the bug scenario relies on
> >    undefined behaviour from stack variables that lack explicit
> >    initialization, it will not usually be considered a security flaw.
> > @@ -320,3 +331,16 @@ encryption and authorization control policy on client connections.
> >  In summary, the monitor console is considered a privileged control interface to
> >  QEMU and as such should only be made accessible to a trusted management
> >  application or user.
> > +
> > +Block device network protocols (NBD, NFS, etc.)
> > +'''''''''''''''''''''''''''''''''''''''''''''''
> > +
> > +When using QEMU to access remote storage over a network (such as QEMU
> > +acting as an NBD or NFS client) or to provide remote storage access
> > +(such as QEMU acting as an NBD server), it is important to realize
> > +that an unencrypted connection can allow an external process a
> > +potential attack vector over the network port. The general
> > +recommendation is that if the protocol allows the use of TLS, then the
> > +management application must configure the use of TLS, in order to
> > +limit the impact of unauthorized or man-in-the-middle attacks to the
> > +smaller region of time before the TLS handshake takes place.
> 
> Performing TLS only protects against a MITM attack by default.
> 
> To protect further scenarios we must document that the protocol
> must have x509 client certificates issued to authorized clients
> and the tls-creds-x509 object set 'verify-peer=on' to check
> them, potentially also 'tls-authz' to filter which certificates
> are allowed if the CA issues certs more broadly.

I'll rework this additional information into a v2 patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


