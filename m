Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B669C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 08:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJM9-0008Gx-QP; Mon, 28 Jul 2025 04:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugJHX-0004yh-97
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugJHV-0002v8-1y
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753691543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1FFLoGnEa1lZfaD/SWjSxDj9dunKXd9o90QSYEySr0=;
 b=SJBqPUdiEvcoD4ot6bYR2GV23DaK8OG4l67Hiacen3IaOiuGvV10VCWskrmNWGGTqsHqpQ
 pGAm/b4N7EzgLjFNdSSMi6NfQbUMixvbJ12B1o9GgR+KHJNMsrkKrAGt+bQKH+ps9/1ocm
 2hUrMDAFTfvBFFBm84zjGhX22FR5CrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-TZ04oX-ROP6XXOlTSiw_IQ-1; Mon,
 28 Jul 2025 04:32:19 -0400
X-MC-Unique: TZ04oX-ROP6XXOlTSiw_IQ-1
X-Mimecast-MFC-AGG-ID: TZ04oX-ROP6XXOlTSiw_IQ_1753691538
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29CE619560BA; Mon, 28 Jul 2025 08:32:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74D5C1800D86; Mon, 28 Jul 2025 08:32:15 +0000 (UTC)
Date: Mon, 28 Jul 2025 09:32:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] tests/functional: add -k TEST_NAME_PATTERN CLI arg
Message-ID: <aIc1jB_ziOPzpQie@redhat.com>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
 <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
 <aIOF2gPa8nbec2qp@redhat.com> <aIOZQfMHt-jJUTSH@redhat.com>
 <50ef6de5-bef5-4da8-a417-b666b7968f6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50ef6de5-bef5-4da8-a417-b666b7968f6c@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jul 26, 2025 at 08:54:51AM +0200, Thomas Huth wrote:
> On 25/07/2025 16.48, Daniel P. Berrangé wrote:
> > On Fri, Jul 25, 2025 at 02:25:46PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Jul 25, 2025 at 12:41:25PM +0300, Manos Pitsidianakis wrote:
> > > > Add a CLI argument that takes fnmatch(3)-style patterns as value and can
> > > > be specified many times. Only tests that match the pattern will be
> > > > executed. This argument is passed to unittest.main which takes the same
> > > > argument.
> > > > 
> > > > Acked-by: Thomas Huth <thuth@redhat.com>
> > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > > ---
> > > >   tests/functional/qemu_test/testcase.py | 23 +++++++++++++++++++++--
> > > >   1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > 
> > 
> > > One of the goals with the new functional test system was that we stop trying
> > > to (re-)invent a custom test runner harness, as was the case with Avocado,
> > > in favour of relying on the pre-existing python infrastructure to the
> > > greatest extent possible.
> > > 
> > > Seeing this, and all the other CLI arg handling added in this series, makes
> > > me fairly uncomfortable, as it is effectively inventing a custom test runner
> > > once again which is exactly what we wanted to get away from.
> > > 
> > > At the same time, there are some pieces in this series that do things that
> > > unittest.main() can't do on its own.
> > 
> > So considering the broader picture, we already have a load of tunables
> > on the test execution that we control exclusively via envirnoment
> > variables, as that gives us independance of the test runner, which
> > owns sys.argv processing.
> > 
> > So in terms of this series, IMHO, we should just add support for
> > QEMU_TEST_DEBUG=1 and QEMU_TEST_KEEP_SCRATCH=1 as two new tunables,
> > and not touch sys.argv at all.
> 
> I basically agree, but I wonder if we could maybe also have both? First
> parse the sys.argv for our parameters, then pass the unknown ones to
> unittest.main() ?

Any argv that we process are subject to clashing with that defined by
the test harness and it is desirable to avoid making assumptions about
what test harness args exist.

To avoid that they would all have to be long options named with a
fixed prefix --qemu-XXXX. Also that sould be something applied to
all env vars, not just the couple of params in this series.

> > With that, the only thing we're missing is a way to enumerate the
> > test cases, but IMHO that's the job of the test runner and thus
> > out of scope for QEMU to solve.
> 
> With the patch applied that passes the argv to unittest.main(), there also
> seems to be a "discover" mode:
> 
>  ~/devel/qemu/tests/functional/test_vnc.py -h | grep usage:
> usage: test_vnc.py [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b]
> usage: test_vnc.py discover [-h] [-v] [-q] [--locals] [--durations N] [-f]
> 
> ... however, when I try to run it, it does not work as expected (I get a
> "ModuleNotFoundError: No module named 'discover'" error).

Hmm, not sure that the 'discover' option makes sense when we're asking to
run a single test file.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


