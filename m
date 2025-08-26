Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C14CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquC0-000490-27; Tue, 26 Aug 2025 09:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uquBr-00045x-Ns
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uquBl-0005tE-6I
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756216692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTGPWkhF8Mniu/NkwS35dSPxeOC+qJIwNleqCNKhjP4=;
 b=Jo8NYPuwWQ8Uu+w9fQGjx3QacduU1lSwkZIEo4yRDMdEEKNeTrwKR+N4cXflCkmgUrhP0P
 tjlX8B+gqLRCG+xKe833CxKfot0IhiuouEZRFeJP75ON07UnxZ0Xn1n39EU0nwdTQE3pNI
 BLf44KWFbr9tOyLwExK6Ge40LLx9k6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-LnLy3rQyP3i_IIGTmSEIIg-1; Tue,
 26 Aug 2025 09:58:09 -0400
X-MC-Unique: LnLy3rQyP3i_IIGTmSEIIg-1
X-Mimecast-MFC-AGG-ID: LnLy3rQyP3i_IIGTmSEIIg_1756216688
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E42B19541AA; Tue, 26 Aug 2025 13:58:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8C2919560AB; Tue, 26 Aug 2025 13:58:05 +0000 (UTC)
Date: Tue, 26 Aug 2025 14:58:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org, 1844144@gmail.com,
 Jan Richter <jarichte@redhat.com>
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Message-ID: <aK29ams5RwkQJcfJ@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 25, 2025 at 11:04:58AM -0300, Gustavo Romero wrote:
> Hello, Thomas!
> 
> On 8/25/25 07:29, Thomas Huth wrote:
> > On 19/08/2025 16.39, Gustavo Romero wrote:
> > > The goal of this series is to remove Avocado as a dependency for running
> > > the reverse_debugging functional test.
> > > 
> > > This test, the last one I’m aware of that relies on Avocado, requires it
> > > because of the need for GDB to test reverse stepping and continue.
> > 
> >   Hi!
> > 
> > Please note that there are currently also some efforts going on to extract the GDB part from avocado into a more self-contained python module called aautils, which might help here, too:
> > 
> >   https://github.com/avocado-framework/aautils/issues/82
> 
> Thanks, I was not aware of it. But note that the Avocado GDB API requires one
> to deal with GDB packets directly, which is unnecessary for tests like reverse
> debug. I think that in general, in QEMU, we should try to avoid using it as
> much as possible because the tests became annoying to read without any strong
> need for it.
> 
> In the commit message for 4/4 I mention that benefit of using the GDB Python
> API instead.
> 
> I think we should aim to make the tests in QEMU _extremely_ easy to list, run,
> and read.

Yes, I really like how your patch improves readability of the test
by using GDB commands rather than raw packets.




> > Anyway, shifting to a different test harness here makes me wonder whether the whole reverse_debug test should maybe be rather moved to tests/tcg instead, where we already have the basic support for the stuff from tests/guest-debug/ ?
> > The aarch64 would require a different guest payload, of course, in that case, so not sure whether it's feasible?
> 
> I think reverse_debugging is really a functional test. It requires GDB, yes,
> but also QMP and booting a whole kernel and the feature itself makes me think
> it's a functional test. I wouldn't move it to tcg-check just for the sake of
> no adding a new way to run test in meson.build in functional tests.

Agreed, this conceptually feels like it belongs as a functional test.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


