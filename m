Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBDC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzE2h-0004fW-BS; Mon, 31 Mar 2025 08:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzE2f-0004eT-Ai
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzE2d-0004LJ-6y
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743423297;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BZnJodQ4iylMtvUVARqUhp5TmLqcIgOuov4/XoEQoQ=;
 b=Lz7QB4An4cpjXmYWUb1u77MeMz5GRo2bcDCGxpgemfzXtZ19xvc4UfhQ9NC1/qd8TcLKMt
 OYkvkWMi5VyUx4/u9n4rR4y5pyGinICOQi++qmGnR0ixkLeIfw8MrPMbCXlf/z+ln4Nvf8
 vrPmzRvjZ4ptQ/O99otmavzTslbAOms=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-DrElGAEUMnWrDjQ1Wbi-vg-1; Mon,
 31 Mar 2025 08:14:51 -0400
X-MC-Unique: DrElGAEUMnWrDjQ1Wbi-vg-1
X-Mimecast-MFC-AGG-ID: DrElGAEUMnWrDjQ1Wbi-vg_1743423290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC32B180025E; Mon, 31 Mar 2025 12:14:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA51C1801747; Mon, 31 Mar 2025 12:14:37 +0000 (UTC)
Date: Mon, 31 Mar 2025 13:14:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rust VMM <rust-vmm@lists.opendev.org>,
 QEMU Devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 VirtIO Dev List <virtio-dev@lists.linux.dev>,
 Bill Mills <bill.mills@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matias Vara Larsen <mvaralar@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: Re: Central repo for VirtIO conformance tests?
Message-ID: <Z-qHKUveoHc85koj@redhat.com>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAJSP0QXX-hpOJ_E1oaR6NcyvBnC2mVAwfd8NYUWTDqPrtctAuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXX-hpOJ_E1oaR6NcyvBnC2mVAwfd8NYUWTDqPrtctAuQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 31, 2025 at 07:52:33AM -0400, Stefan Hajnoczi wrote:
> On Mon, Mar 31, 2025 at 6:39 AM Alex Bennée <alex.bennee@linaro.org> wrote:
> > So what do people think? Where would be a good place for common test
> > repository to live?
> 
> Maintaining the tests alongside the VIRTIO spec seems like a good fit
> to me. Here is information on how to create a GitHub repo under the
> OASIS VIRTIO Technical Committee:
> https://www.oasis-open.org/open-repositories/
> 
> I don't see a reason to maintain the tests under QEMU or rust-vmm
> unless they provide some unique project infrastructure that an
> independent project would lack or need to reinvent.

IMHO opening that very link above illustrates the reason why *NOT* to
host this under OASIS. Any potential contributor is faced with a 4 page
long blurb of all sorts of rules & legal requirements, including

  "Each TC Open Repository shall be subject to a Contributor
   License Agreement (“CLA”) by which all persons making repo
   contributions into it are bound."

Hosting anywhere else would be better from the POV of removing barriers
to potential contribution.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


