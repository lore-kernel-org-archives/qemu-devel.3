Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1F2C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMj19-0005HF-BA; Wed, 04 Jun 2025 03:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uMj16-0005Gl-MT
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uMj14-0003fP-Sv
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749023908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lTzLWXIfqV86XZ/87bl0beswsxrJbx48oVzIwWvp+w0=;
 b=Js5bpQMR1rkvGFBC04HdVDTa/CJdVPJ1zvG3lJb154lKSN57/pVa3OPxRGodFZnoAQJHZV
 +RcRAFwrrEfsgd38bbdtXv6i9rKuS80dnVpjEe9x6MkHn967xsBX52Cze3k49PwClagmTV
 ObHe1pK1dh5p3FyL60qfxPLTqnYHs0U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-n8rjfB36P4iVAZCn8Q8jpQ-1; Wed,
 04 Jun 2025 03:58:25 -0400
X-MC-Unique: n8rjfB36P4iVAZCn8Q8jpQ-1
X-Mimecast-MFC-AGG-ID: n8rjfB36P4iVAZCn8Q8jpQ_1749023904
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4EFC195608E; Wed,  4 Jun 2025 07:58:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B0818002B2; Wed,  4 Jun 2025 07:58:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3795418000A4; Wed, 04 Jun 2025 09:58:20 +0200 (CEST)
Date: Wed, 4 Jun 2025 09:58:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
Message-ID: <k6dlhmhmwbot7mqqlelfqj6ru4oha2hu4cf2ahjjmt6qj2kxio@4sv56qibk6z4>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
 <87a56o3gxc.fsf@draig.linaro.org> <87r000ypi0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r000ypi0.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> > If we do want to mention the editors we should probably also mention b4.
> 
> Can do if somebody contributes a suitable configuration snippet.

Nothing to configure ;)

Simplest usage is 'b4 shazam $msgid' and b4 will go fetch the complete
thread from lore.kernel.org, collect all the review tags from the
replies, add them to the patches and apply the whole series to the
current branch.

You can also ask b4 to generate a mbox file you can feed to 'git am'
yourself (this is 'b4 am $msgid'), which can be useful if you want build
your maintainer scripting workflow around it.

take care,
  Gerd


