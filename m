Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6940606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f+ZrjuSP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLN7j-0001d2-H8; Mon, 26 Oct 2026 12:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLN7d-0001Ye-0K
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLN7a-0006vW-El
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793030425;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nz7vOCSiT5icgzCNPPu1eeEUooWnF6bf+nt1uOENKjE=;
 b=f+ZrjuSPMQJoHESuQrzkI30uxET4bCIqRwJ6Almzi03mLt2YzzCy74dtbwzX3EfH8DmCiL
 hZOLwMa9Ct7QHK0iASPHYuOoIwKVU4HfZYXnb6iJjRVF+VhkZjEYePSyGf5XSrvXpJni+x
 abiAeTD8REl0I7UD3oZo2nJtcfrnlzU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-vXMQSHDVOMKwaamFRfwitA-1; Mon,
 26 Oct 2026 12:00:23 -0400
X-MC-Unique: vXMQSHDVOMKwaamFRfwitA-1
X-Mimecast-MFC-AGG-ID: vXMQSHDVOMKwaamFRfwitA_1793030422
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DEB8180886C; Mon, 26 Oct 2026 16:00:22 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB5A5BC; Mon, 26 Oct 2026 16:00:20 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:00:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: Increase the timeout of the
 device-introspect-test
Message-ID: <at95EXMAwxM8soAK@redhat.com>
References: <20261026092313.480889-1-thuth@redhat.com>
 <87fqxs67ut.fsf@draig.linaro.org>
 <ffdb16f1-7a5a-487e-a9d6-74767ee399b8@redhat.com>
 <87y0bk4hf5.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0bk4hf5.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 03:20:46PM +0000, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 26/10/2026 12.04, Alex Bennée wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >> 
> >>> I'm occasionally seeing timeouts of the device-introspect-test for
> >>> the aarch64 target when running "make check SPEED=thorough" - looks
> >>> like the 720 seconds aren't enough anymore nowadays. Add 2 more
> >>> minutes to give some more headroom.
> >> What is taking so long, I can run all the introspect builds in under
> >> 10
> >> seconds:
> >>    ➜  time ./run meson test --suite qtest "*device-introspect*"
> >
> > You've got to run the tests in slow/thorough mode:
> >
> > G_TEST_SLOW=1 time ./run meson test --suite qtest "*device-introspect*"
> >
> > otherwise a lot of the tests will be skipped and the tests will finish
> > fast.
> 
>   env G_TEST_SLOW=1 QTEST_QEMU_BINARY=./qemu-system-aarch64 ./run time strace -e trace=read,write,recvfrom,sendto -c /home/alex/lsrc/qemu.git/builds/testing/tests/qtest/device-introspect-test --tap -k
>   ...
>   # slow test /aarch64/device/introspect/concrete/nodefaults/raspi0 executed in 30.19 secs
>   # End of nodefaults tests
>   # End of concrete tests
>   # End of introspect tests
>   # End of device tests
>   # End of aarch64 tests
>   % time     seconds  usecs/call     calls    errors syscall
>   ------ ----------- ----------- --------- --------- ----------------
>    99.61  793.101303           1 420646079           recvfrom
>     0.28    2.229951           3    619529           sendto
>     0.11    0.840259           4    179705           write
>     0.00    0.000000           0        14           read
>   ------ ----------- ----------- --------- --------- ----------------
>   100.00  796.171513           1 421445327           total
>   926.31user 3944.47system 1:28:16elapsed 91%CPU (0avgtext+0avgdata 1132064maxresident)k
>   43824inputs+0outputs (324major+7978563minor)pagefaults 0swaps
> 
> So it looks like the majority of the runtime is just ploughing through
> 420M unix socket calls introspecting the same large set of non user
> creatable devices for every machine type. This will just get bigger and
> bigger every new device or machine we add.

NB, you use G_TEST_SLOW so it iterates over all machines, the
default behaviour is just to test 'none' machine only, but....

...urgh, our JSON client parser reads data off the wire 1 byte
at a time....

recvfrom(6, "{", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, "Q", 1, 0, NULL, NULL)      = 1
recvfrom(6, "M", 1, 0, NULL, NULL)      = 1
recvfrom(6, "P", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, ":", 1, 0, NULL, NULL)      = 1
recvfrom(6, " ", 1, 0, NULL, NULL)      = 1
recvfrom(6, "{", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, "v", 1, 0, NULL, NULL)      = 1
recvfrom(6, "e", 1, 0, NULL, NULL)      = 1
recvfrom(6, "r", 1, 0, NULL, NULL)      = 1
recvfrom(6, "s", 1, 0, NULL, NULL)      = 1
recvfrom(6, "i", 1, 0, NULL, NULL)      = 1
recvfrom(6, "o", 1, 0, NULL, NULL)      = 1
recvfrom(6, "n", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, ":", 1, 0, NULL, NULL)      = 1
recvfrom(6, " ", 1, 0, NULL, NULL)      = 1
recvfrom(6, "{", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, "q", 1, 0, NULL, NULL)      = 1
recvfrom(6, "e", 1, 0, NULL, NULL)      = 1
recvfrom(6, "m", 1, 0, NULL, NULL)      = 1
recvfrom(6, "u", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, ":", 1, 0, NULL, NULL)      = 1
recvfrom(6, " ", 1, 0, NULL, NULL)      = 1
recvfrom(6, "{", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, "m", 1, 0, NULL, NULL)      = 1
recvfrom(6, "i", 1, 0, NULL, NULL)      = 1
recvfrom(6, "c", 1, 0, NULL, NULL)      = 1
recvfrom(6, "r", 1, 0, NULL, NULL)      = 1
recvfrom(6, "o", 1, 0, NULL, NULL)      = 1
recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
recvfrom(6, ":", 1, 0, NULL, NULL)      = 1

> I think we need to reconsider exactly what it is we are trying to test
> here.

I fear this test suite is perhaps just exposing a scalability problem
of our JSON parser. I wonder how much quicker could it be if it read
data in chunks ....

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


