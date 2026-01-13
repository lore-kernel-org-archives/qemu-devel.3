Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1749D2D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfeKm-0000VQ-JU; Tue, 13 Jan 2026 08:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfeKd-0000Ds-Td
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfeKc-0004Eq-Dm
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768310469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLjNaKKA7+K0lppk/tV8SVLakODiZ0fGj1Nb+azvbYw=;
 b=iHkh5Gn47xF/e2ZCmj/euE/YGlzIJWW9IzrB/A02GVlgg8Maa1cDimxp2jabR6h6AnNhHQ
 GSkZbE3sw67eO2FzUOtGFVfqTRjyOH2OjJKAcTFuzuZGFrlp2lzwtI+8KCeU+yFDFJSYZh
 40bCen/Of7M/hj1r1btBq10Vvq/ben8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-uXEN8fTOM_ypXZAN__XDLQ-1; Tue,
 13 Jan 2026 08:21:06 -0500
X-MC-Unique: uXEN8fTOM_ypXZAN__XDLQ-1
X-Mimecast-MFC-AGG-ID: uXEN8fTOM_ypXZAN__XDLQ_1768310464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56C671800371; Tue, 13 Jan 2026 13:21:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01ED519560AB; Tue, 13 Jan 2026 13:20:58 +0000 (UTC)
Date: Tue, 13 Jan 2026 13:20:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/1] Sync kernel-doc.py with Linux upstream
Message-ID: <aWZGq8gmFiHT5mBW@redhat.com>
References: <cover.1767716928.git.mchehab+huawei@kernel.org>
 <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
 <aWY10BYoJjck3xX8@redhat.com>
 <CAFEAcA9wnmZOLnA3zb6FPfjrEs-3PRBmyBs=FfiQW2OY5GJfTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9wnmZOLnA3zb6FPfjrEs-3PRBmyBs=FfiQW2OY5GJfTw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Jan 13, 2026 at 01:04:48PM +0000, Peter Maydell wrote:
> On Tue, 13 Jan 2026 at 12:09, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > TL;DR: I would not want to see a new top level tools/ directory
> > created, and don't think it fits in python/ either; scripts/ is
> > a fine home.
> 
> We do already have a tools/ directory, as it happens.
> It has two things in it...
> 
> Personally I think tools/ ought to be for the set of
> things that we build if you --enable-tools in configure
> and which we document in docs/tools.
> tools/i386/qemu-vmsr-helper.c fits in that idea of
> what the directory is for. tools/ebpf/ does not, but
> I don't know enough about what it's for to suggest
> a better home for it.

It is the source for the pre-generated ebpf/rss.bpf.skeleton.h file.
It should probably just live in epbf/.

Ideally we wwould build it by default, but GCC lacked a eBPF backend
and we didn't want a hard dep on clang for this.

> We might at some point want to tidy up the qemu-io.c,
> qemu-bridge-helper.c, etc that currently live in the
> top level directory so they go in tools/ instead.

Yes, that would be desirable.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


