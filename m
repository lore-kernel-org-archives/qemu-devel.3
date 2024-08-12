Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DF3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 16:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdXp4-0002Fk-1Z; Mon, 12 Aug 2024 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdXp2-0002EZ-UB
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 12:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdXp0-0008WU-J4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 12:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723479780;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iL77nnSBH9gZ96JVImMJmmmZbAJ/u3cCB2omLv9Yg/4=;
 b=e6XB/juyj/7T4Hbvx+0Kqnlr1BMRzu4mN1NyxJrEqC3HCaIBzeyraND/JGLSKG3NSudTxK
 DuaB5a5ZaGv0ehX/4itp4i2FyjjNei+PTTHZFy+c1t96jzKbrLkwFhCO8sqJlgdJ6FeSP9
 U4pzimhxCxTQrdc3bCsarSQ11UJplAc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-R34gMxh1MI-CvurNTT2kOQ-1; Mon,
 12 Aug 2024 12:22:54 -0400
X-MC-Unique: R34gMxh1MI-CvurNTT2kOQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0B9019776C9; Mon, 12 Aug 2024 16:22:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.211])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40F7E19373D7; Mon, 12 Aug 2024 16:22:47 +0000 (UTC)
Date: Mon, 12 Aug 2024 17:22:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, thuth@redhat.com,
 marcandre.lureau@redhat.com, alistair@alistair23.me,
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Subject: Re: [RFC PATCH 00/23] NXP i.MX RT595, ARM SVD and device model unit
 tests
Message-ID: <Zro207XTHFILvRoe@redhat.com>
References: <20240805201719.2345596-1-tavip@google.com>
 <CAFEAcA9tUW0DHHOuGJ4sUxu12JMLUMxqW=_9oUHKiiRTenZwKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9tUW0DHHOuGJ4sUxu12JMLUMxqW=_9oUHKiiRTenZwKw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 05:10:52PM +0100, Peter Maydell wrote:
> On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
> > It also introduces unit tests for device models. To allow accessing
> > registers from unit tests a system bus mock is created. The main
> > advantage of unit tests for device models over QTest is that device
> > models can be tested in isolation and do not require a full qemu
> > machine.
> 
> On the other hand the disadvantage is that you need to add a
> bunch of extra code to mock the interfaces that the device
> connects to, and then you compile into the test binary a
> subset of C files which weren't written with the expectation
> that they got compiled into tests like that, so it feels a
> bit brittle. The nice thing about qtest is that it doesn't
> need you to do any of that -- you just run the QEMU machine
> model and prod the devices it already has.

Yep, mocking often ends up being rather a double-edged sword.
You can do some really powerful things with it, and in particular
it can enable you test scenarios / code paths that are hard or
impractical to exercise with regular functional tests where fault
injection is difficult/impossible.

The cost of this though is that the mocks can pose a significant
ongoing maint burden on anyone who refactors code in future, as
the mocks need to evolve in lockstep with the code refactoring.

12 months down the line, it can be hard for another maintainer
to understand the full purpose of the mocks & thus even harder
to know what todo as they refactor the code. The future burden
of mocks rarely falls on the person who creates them in the
first place.

> Do you have examples in this series of tests which you
> were able to write with this unit test setup that you
> wouldn't have been able to write equivalents of with the
> qtest framework ?



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


