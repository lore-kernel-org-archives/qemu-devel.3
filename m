Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B1EEEE26C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 11:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp4uy-0001SX-GR; Fri, 13 Sep 2024 07:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sp4um-0001RQ-By
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sp4uk-0007Ke-Ni
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 07:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726228596;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zk3KygWe3zaIT/wour0OZb1pKEiqIYTtcmI9GvIm9k=;
 b=SXic+6wL7Z3Z0afiGSie3N7M0zaMYP35u7fnUtbM/tKAjRokQgQot0qXP9so4ZAc3h3wqQ
 JC8lndB+YAtJ/wiK5DruytDpFVcSB3OgLr9WJlub9bQ4gruo+IibRAST3YUAe4WKr5knNE
 GDaO53UQ2tbKs0H7knG8pGt9r+zXSZs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-s-RLjPcOPbqDMJ1maNXCvg-1; Fri,
 13 Sep 2024 07:56:33 -0400
X-MC-Unique: s-RLjPcOPbqDMJ1maNXCvg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DF21955DA6; Fri, 13 Sep 2024 11:56:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A04A11956086; Fri, 13 Sep 2024 11:56:29 +0000 (UTC)
Date: Fri, 13 Sep 2024 12:56:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
Message-ID: <ZuQoauSdVNaG3F6m@redhat.com>
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 06, 2024 at 10:52:53AM +0100, Peter Maydell wrote:
> On Fri, 6 Sept 2024 at 09:14, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Sep 06, 2024 at 08:16:31AM +0200, Thomas Huth wrote:
> > > On 05/09/2024 23.03, Fabiano Rosas wrote:
> > > > Hi,
> > > >
> > > > This series silences QEMU stderr unless the QTEST_LOG variable is set
> > > > and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
> > > > flag is passed.
> > > >
> > > > This was motivated by Peter Maydell's ask to suppress deprecation
> > > > warn_report messages from the migration-tests and by my own
> > > > frustration over noisy output from qtest.
> 
> This isn't what I want, though -- what I want is that a
> qtest run should not print "warning:" messages for things
> that we expect to happen when we run that test. I *do* want
> warnings for things that we do not expect to happen when
> we run the test.

Currently we just allow the child QEMU process stdout/err
to inherit to the qtest program's stdout/err. With that
approach we have to do filtering at soruce (ie in QEMU
itself). I feel that in general it is a bad idea for the
program being tested to alter itself to suit the test
suite, not least because two different parts of the test
suite may have differing views about what messages they
want to ignore vs display.

We could address this be switching to the model used
with IO tests.  Always capture the child QEMU process
stdout/err to a pipe. The test program can apply regex
filters to cull output that is expected & irrelevant,
and then print out whatever is left over on its own
stderr.

That way all the filtering of undesirable messages would
be exclusively in the test suite, not QEMU itself.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


