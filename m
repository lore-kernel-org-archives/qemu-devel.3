Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74956D3B992
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3fJ-0004EP-8V; Tue, 09 Dec 2025 14:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vT3fH-0004EF-7P
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:46:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vT3fF-0005Uj-Jo
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765309584;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66YCypeNfPU0hBp+mPZboFZqVvdqiLyNPEK2Oj67RXo=;
 b=QmsqBNeni5+5SJBttGur5h2QrdJpNKcfU106pk8Pdq19fEw2w/5ZdhxCzadqbUcRuMKPVl
 j3C65bKdq6ZiKMIB2+sCer2fyvvN7uCw7d1vfR2GenYbqvkuKZldrAwV5KHf+mnaeC94F9
 wcq2RrATi7uUntUpo8vn7JZrBLpneIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-IjQxm82BPVmbrDlhdkvDBA-1; Tue,
 09 Dec 2025 14:46:21 -0500
X-MC-Unique: IjQxm82BPVmbrDlhdkvDBA-1
X-Mimecast-MFC-AGG-ID: IjQxm82BPVmbrDlhdkvDBA_1765309580
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D4381956094; Tue,  9 Dec 2025 19:46:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 420C91800451; Tue,  9 Dec 2025 19:46:15 +0000 (UTC)
Date: Tue, 9 Dec 2025 19:46:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
Message-ID: <aTh8cnASuApmT9Xx@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <aThVvP5vwfjVa-ka@redhat.com>
 <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Dec 09, 2025 at 12:23:21PM -0500, John Snow wrote:
> On Tue, Dec 9, 2025, 12:00 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:
> > > Hello!
> > >
> > > This series drops the in-tree version of our python-qemu-qmp package
> > > ("qemu.qmp") in favor of the version hosted on PyPI, whose repository is
> > > located at https://gitlab.com/qemu-project/python-qemu-qmp.
> > >
> > > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
> > >        (FreeBSD isn't my fault...!)
> > >
> > > The major effects of this patch series are:
> > >
> > > 1. qemu.qmp will be installed from PyPI or vendored packages instead of
> > >    being utilized directly from the qemu.git tree.
> >
> > This is not getting installed in enough scenarios IMHO.
> >
> 
> It's hard to trigger an install when you don't use the build system,

Well I am using the build system in the same way that I've always
used it with QEMU. IOW, the benchmark for this is the current way
things work with the python stuff in tree. The ideal would be to
match that behaviour with no workflow changes needed, if it is
practical to achieve that without major downsides. 

> though... If you bypass make/meson/ninja entirely I'm not really sure what
> I can do to bootstrap the test deps.

Can we just do it unconditionally in configure / meson ? These aren't
big files to download, and we're already dealing other python stuff
for the build, and git submodules, and rust crates. Pulling in qemu.qmp
doesn't feel like it is a burden to do by default ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


