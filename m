Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D5606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDV/1+Sv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhWk-00058D-E4; Tue, 10 Nov 2026 03:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQhWi-000574-KY
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQhWg-0004rU-Ml
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794300500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wH4HZ+sFQx8fVjQPcJHZG8QfJcJA6lTfGkLxrhz3au4=;
 b=SDV/1+Sviz/wy2O8+npj0DugrVu++nwGM6FosFsDkTltyhD8jODlRIGpXuPTTEuEgRx5WM
 +f7rjiPRIJ9oSwVC5iSTo3WD/xrH6EctjkjH7iVIf1JF3k4oPe/YhZjxUrv5veLQmaAyVj
 B2QaKkhAi/U+d6egP11gWv8v3ekW/24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-sXVUT9QgOw2k9Io3U10BLQ-1; Tue,
 10 Nov 2026 03:48:18 -0500
X-MC-Unique: sXVUT9QgOw2k9Io3U10BLQ-1
X-Mimecast-MFC-AGG-ID: sXVUT9QgOw2k9Io3U10BLQ_1794300497
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7A8A180055B; Tue, 10 Nov 2026 08:48:16 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 998771961755; Tue, 10 Nov 2026 08:48:14 +0000 (UTC)
Date: Tue, 10 Nov 2026 08:48:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] docs: Mention security considerations for NBD
Message-ID: <avLaS_B5NTp7gUDj@redhat.com>
References: <20261107225834.778738-5-eblake@redhat.com>
 <20261107225834.778738-6-eblake@redhat.com>
 <20261109155847.GD429574@shajnocz.csb>
 <avItiIWM__3NL1VS@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avItiIWM__3NL1VS@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MARKETING_PARTNERS=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MARKETING_PARTNERS,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 02:48:18PM -0600, Eric Blake wrote:
> On Mon, Nov 09, 2026 at 08:58:47AM -0700, Stefan Hajnoczi wrote:
> > On Sat, Nov 07, 2026 at 04:54:36PM -0600, Eric Blake wrote:
> > > +Proper hardening of network connections can prevent the use of
> > > +untrusted clients, and is therefore a factor when considering whether
> > > +a malicious network partner that intentionally violates the
> > > +communication protocol to trigger a QEMU bug can be treated as a lower
> > > +priority bug.
> > 
> > IMO there is no such thing as a trusted client - QEMU needs to validate
> > all inputs. When a client is authorized to use a resource (e.g. an NBD
> > export) it can still be rogue and trigger a Denial of Service that
> > affects the guest or other clients.
> 
> > 
> > Did you add this because there was no CVE assigned yet? Maybe you can
> > remove this since a CVE has been assigned?
> 
> I've got at least one other bug pending that I'm about to lift
> confidentiality on, in the same boat where TLS prevents untrusted
> client behavior, but where I don't have a CVE number yet. But I agree
> that since we don't fully control even a trusted client process, ANY
> flaw in the client that allows the client to start sending
> non-compliant data over the wire can then be escalated further into an
> attack on QEMU, despite QEMU minimizing the risk of such attacks by
> first filtering out obvious untrusted clients.
> 
> I'm trying to figure out the best balance of wording for that. In the
> CVSS scoring system [1], you are arguing (and I agree) that the CVSS-B
> base score is unchanged by whether or not TLS was in use (we don't
> control the remote client; if the remote client can send non-compliant
> bytes over the wire, QEMU will assert). However, the environmental
> metrics of CVSS-BE cover Attack Complexity (AC) and Attack
> Requirements (AR) that consider how hard it is to get the client to be
> non-compliant in the first place.  Once attack chaining is involved,
> the risk to QEMU is less than if the attacker does not first have to
> compromise a trusted client into sending non-compliant bytes.
> 
> [1] https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
> 
> Maybe the solution is as simple as rewording "trusted client" into
> "authenticated client", to emphasize that while any client misbehavior
> that can crash QEMU is still likely to be a CVE, the authentication
> aspect affects the Environmental analysis which in turn reduces the
> overall CVSS-BE rating of the attack.

Yes, using 'authenticated client' is a better term, as that is more
of a clear "fact", where as "trusted client" can mean many different
things in different people & scenarios

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


