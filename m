Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D496ECA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwM-0005M2-CT; Wed, 07 Oct 2026 04:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEHGl-0002sz-QD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEHGW-0007EM-0L
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791339432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKO7WvBYIQTTrXpNvOjS2AscY2ESebZWGyWvOHVONBg=;
 b=IaUsDoOi9Yzvb9k20T2tC53qbScFxV7WlYBC+Pc6GzQjkyd640J9fr9kDJIaLJdiimg0RG
 ulufsR3X9xBLXvpi/YLEVwCtirrEmvVZ49ZXwgRm8MbjRt/ttA/tNfYfEoukqjpEL9+niU
 NdWdc6lDmVApftP6HOabLMLnUw1lRjY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-9izA0Z77O_-M8IXpmha_1g-1; Tue,
 06 Oct 2026 05:56:42 -0400
X-MC-Unique: 9izA0Z77O_-M8IXpmha_1g-1
X-Mimecast-MFC-AGG-ID: 9izA0Z77O_-M8IXpmha_1g_1791280601
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F335A1955BE0; Tue,  6 Oct 2026 09:56:40 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3D821956042; Tue,  6 Oct 2026 09:56:37 +0000 (UTC)
Date: Tue, 6 Oct 2026 10:56:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <asTF0za8c5njDtrK@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <69164823-7271-4d59-9684-637bec454a1d@redhat.com>
 <293cb972-35e1-1922-0834-601e2491a7a6@eik.bme.hu>
 <asS0HLYRmZhB3Ban@redhat.com> <87mrsrjh8a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mrsrjh8a.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 06, 2026 at 10:44:37AM +0100, Alex Bennée wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 05.10.2026 um 23:09 hat BALATON Zoltan geschrieben:
> >> On Fri, 2 Oct 2026, Paolo Bonzini wrote:
> >> > I agree completely with how you phrased the first and third.  I agree
> >> > that the second bullet is a risk too, but it's mitigated by "LLM-created
> >> > contributions will be held to a higher standard than human-created ones,
> >> > because LLMs make it easier to write tests" (and by maintainers being
> >> > able to
> >> 
> >> Tests need to be reviewed too to be able to trust them so that does not help
> >> against overloading reviewers with generated patches but burdens them even
> >> more: they will also have to review the tests before the code.
> >
> > The required level of trust for tests is comparatively low, so it's much
> > easier to review tests to a sufficient level than say device emulation
> > code.
> >
> > If a new test looks plausible, fails before the fix and passes
> > afterwards, it's more useful that what we had before, even if it's
> > technically buggy in some corner case.
> 
> And also easier to rip out in the unlikely event it infringes anything.
> 
> But broadly having a test* is better than having no test.
> 
> * modulo the effects on our coverage.

The maintability of test code is really important too, just as much
as the code being tested. Every test potentially constrains how we
can change code in future as tests themselves are never perfect or
exhaustive and often take short-cuts in their design to suit the
current testing needs. As we enhance the code under test, the test
suite needs to evolve with it and that requires that we understand
the test code and why it is doing what it is doing.

A test spat out by AI which is a string of 20 undocumented qtest
commands may fail before the fix and pass afterwards, but that
test is not automatically a win if we don't understand why the test
is doing what it is doing - it becomes a burden for long term maint.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


