Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1C606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qs7zuFjr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoZD-0004p9-De; Tue, 10 Nov 2026 11:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQoZ3-0004mi-6Z
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQoZ0-0003h5-9P
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794327553;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ks7Zr45C+Pr3EMP0H9RmrbK3FsBG++sErcDSOcyIEgU=;
 b=Qs7zuFjryWQMe4CsoGAB6QSmf1SXK/fkhc6CTlu36J3VqtTpspD8WSXRtkpGU+MR4mLY0V
 B+RrhQaIrT0FR9aZrUm+ANIZaifoqJ4avU4/IRQC06EzLlMpHtP2s7Sxt37VqzJ9DZjKo+
 ZiS7nD9VZpk9HnSy9ceguDGeSNJuMqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-8B0qAS3uP2KRF8mviIWq1A-1; Tue,
 10 Nov 2026 11:19:09 -0500
X-MC-Unique: 8B0qAS3uP2KRF8mviIWq1A-1
X-Mimecast-MFC-AGG-ID: 8B0qAS3uP2KRF8mviIWq1A_1794327548
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3B6718002FB; Tue, 10 Nov 2026 16:19:07 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06BE430000E7; Tue, 10 Nov 2026 16:19:05 +0000 (UTC)
Date: Tue, 10 Nov 2026 16:19:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 stefanha@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 5/6] nbd/server: Reject rather than assert on
 non-compliant NBD_OPT_SET_META_CONTEXT
Message-ID: <avND9_Y5zRVvTWPE@redhat.com>
References: <20261110153121.1516536-8-eblake@redhat.com>
 <20261110155356.1520433-7-eblake@redhat.com>
 <20261110155356.1520433-11-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110155356.1520433-11-eblake@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 09:54:01AM -0600, Eric Blake wrote:
> The NBD protocol says that NBD_OPT_{LIST,SET}_META_CONTEXT sends
> several lengths that must be consistent: an overall option reply
> length, then a series of smaller lengths/data pairs representing the
> export name and zero or more context names. If the smaller lengths
> within the payload do not add up to the larger value, the client has
> sent garbage bytes that will trigger the server's parse of the
> client's next option to be out of sync.  However, QEMU was dying with
> an assertion failure rather than diagnosing the issue, which a
> malicious client can then exploit to mount a denial-of-service attack
> against QEMU as the NBD server.
> 
> As with several other recent NBD protocol violations, the likelihood
> of this attack can be reduced by using TLS and x509 certs to reject
> unwanted clients (a "trusted" client can still trigger the problem,
> but you first have to compromise the trusted client into sending
> arbitrary traffic).
> 
> Fixes: CVE-2026-125683
> Fixes: e7b1948d51 ("nbd: BLOCK_STATUS for standard get_block_status function: server part", v2.12.0)
> Reported-by: TonySD via https://gitlab.com/qemu-project/qemu/-/work_items/4843
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


