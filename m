Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F55C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZlR-0003UP-P3; Thu, 01 Aug 2024 13:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZZlP-0003Pe-Ak
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZZlL-0006Qy-V4
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722533930;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0c2hJaqBrg8gvwcscqodyDP58+zufPv/LmjPoSE3Z0w=;
 b=TKZ261rPGuyedy9c2xTxHYhgEbC8xaBqjGLgH+09vwVRYuQ1+1NM0v+zs6EetoMYgHmntg
 Jh5zly1jUReAVfKnIHUBT0Dp4u1IXkH4QVlSvGZSlcnnJpnEIcLIGlitVWd9Qkg6mQ3Bnh
 kv60SDSYAmCC0q9d6vTXkagXLDPtUIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-g42Fiw4rNe6XcAwzy5Vqtg-1; Thu,
 01 Aug 2024 13:38:47 -0400
X-MC-Unique: g42Fiw4rNe6XcAwzy5Vqtg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 966651955D55; Thu,  1 Aug 2024 17:38:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F358195605A; Thu,  1 Aug 2024 17:38:40 +0000 (UTC)
Date: Thu, 1 Aug 2024 18:38:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 13/24] tests/functional: Convert the s390x avocado
 tests into standalone tests
Message-ID: <ZqvIHb15uzWZw6Qt@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-14-berrange@redhat.com>
 <0f30e83a-2048-4dcb-ba41-47920c62e1e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f30e83a-2048-4dcb-ba41-47920c62e1e1@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 01, 2024 at 07:11:01PM +0200, Philippe Mathieu-Daudé wrote:
> On 30/7/24 19:03, Daniel P. Berrangé wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > These tests use archive.lzma_uncompress() from the Avocado utils,
> > so provide a small helper function for this, based on the
> > standard lzma module from Python instead.
> > 
> > And while we're at it, replace the MD5 hashes in the topology test
> > with proper SHA256 hashes, since MD5 should not be used anymore
> > nowadays.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   MAINTAINERS                                   |  4 +-
> >   tests/functional/meson.build                  |  6 ++
> >   tests/functional/qemu_test/utils.py           | 14 +++
> >   .../test_s390x_ccw_virtio.py}                 | 79 ++++++++---------
> >   .../test_s390x_topology.py}                   | 86 ++++++++-----------
> >   5 files changed, 94 insertions(+), 95 deletions(-)
> >   rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (85%)
> >   mode change 100644 => 100755
> >   rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (88%)
> >   mode change 100644 => 100755
> 
> Conversion LGTM, so:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Now while testing I'm getting errors, but maybe pre-existing...

What host arch / OS are you running tests from ?

I got through the full set of testing on Fedora x86_64, so
wondering if something differs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


