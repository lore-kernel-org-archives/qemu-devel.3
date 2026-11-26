Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6778606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAS/TeV4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWcXJ-0004BG-GH; Thu, 26 Nov 2026 11:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWcXH-0004Ao-D7
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWcXF-0003NJ-Ng
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795711285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=na30Moix/1CH11SXgve6TVO635BATByUhtC+tE6lf3M=;
 b=dAS/TeV4Co8aXFKZztBYKyRlJzhpBLijrCZkYsx6Y0JvzrAgiWwM4yr6SaFlAUdcfivw1g
 ZbO2cSzKkUfNahSJXbeOTZbeU7Ya4GDq6mSZl7L3nYPu+Uh28V5Qu+ZuP+o0dd7uGRpTDG
 +ySaf3Hj3d0odOP0l0d5jEOWdZxXHyY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-_rY5NlvZPsueJ8BVTxRozg-1; Thu,
 26 Nov 2026 16:41:23 +0000
X-MC-Unique: _rY5NlvZPsueJ8BVTxRozg-1
X-Mimecast-MFC-AGG-ID: _rY5NlvZPsueJ8BVTxRozg_1795711282
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B081800358; Thu, 26 Nov 2026 16:41:22 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06E511800550; Thu, 26 Nov 2026 16:41:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org, berrange@redhat.com,
 eblake@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
Date: Thu, 26 Nov 2026 17:41:15 +0100
Message-ID: <20261126164117.2316305-1-pbonzini@redhat.com>
In-Reply-To: <awgxegpODDyRxN2r@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
 <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87tsl3yeln.fsf@pond.sub.org>
 <awgxegpODDyRxN2r@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 08:17:46 -0500, Peter Xu wrote:
> The other side I didn't mention is, it'll just still block some very good
> patch proposers, who work with AI, update based on AI's commit log, do N
> rounds of review and tests before sending, then when sending it proactively
> state the AI usage.  In that case to follow this rule we must reject it, or
> forcing them to rewrite commit log, which is awkward.

Yes, this is what I meant when I wrote this in the cover letter for v5:

  Trying to split out large contributions made me realize how hard it is
  for such a policy to be balanced.  In my opinion, the version that
  does *not* allow large contributions makes the job harder for
  maintainers, because it does not provide a sanctioned way to grow
  a steady stream of small but useful contributions into something more
  structured.

See laso https://lore.kernel.org/qemu-devel/20261118104150.599535-5-pbonzini@redhat.com/.

Nevertheless, I am okay with including this first step and figuring out
separately what the next step could or should be.

Paolo


