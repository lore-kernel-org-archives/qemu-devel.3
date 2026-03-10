Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF097EB1060
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzz2h-0001QV-55; Tue, 10 Mar 2026 11:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzz2Y-0001Pn-R4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzz2T-00058J-Hr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773156625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMU8A5qNXdcWg0iopZTOvjbSW3UHXcA3TSRJJsnCYTo=;
 b=GiwyCd/Y+klsp/1k51KbPdJ7M3dYHYgCZm2f8tOYfV46EmGMMiEs9h1EP1p0UcJygYIlWn
 6UgIjuuhAGGK5yBRwJ+QEf1e0iD9CkFmbOZqVf3W6dSlVBz5e4hqEllMrPKkvc0RrExXae
 JpFyFjntUnrj+6ILj5gFUaExHDunKNc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-XYD-si45PWiwtAhLolNksw-1; Tue,
 10 Mar 2026 11:30:21 -0400
X-MC-Unique: XYD-si45PWiwtAhLolNksw-1
X-Mimecast-MFC-AGG-ID: XYD-si45PWiwtAhLolNksw_1773156619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C84B18002D1; Tue, 10 Mar 2026 15:30:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.213])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8E2130002D2; Tue, 10 Mar 2026 15:30:16 +0000 (UTC)
Date: Tue, 10 Mar 2026 15:30:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nia Alarie <nia@netbsd.org>
Subject: Re: Minimal GCC version for QEMU (was: Re: [PULL 27/49] meson: Add
 -Wformat-overflow=2)
Message-ID: <abA5BBSQ0cHstmqM@redhat.com>
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
 <87h5qn23v5.fsf@suse.de>
 <CAFEAcA-vsS0Q9kGVbmwEyLQcoANaHg5S754DNvqXOOnqoY-LMg@mail.gmail.com>
 <eb7c065a-ff9f-41d9-a80f-51123af20603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb7c065a-ff9f-41d9-a80f-51123af20603@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Tue, Mar 10, 2026 at 04:17:47PM +0100, Thomas Huth wrote:
> On 10/03/2026 15.51, Peter Maydell wrote:
> > On Tue, 10 Mar 2026 at 13:47, Fabiano Rosas <farosas@suse.de> wrote:
> > > This gives me:
> > > 
> > > ../tests/qtest/ast2700-sgpio-test.c: In function ‘test_output_pins’:
> > > ../tests/qtest/ast2700-sgpio-test.c:27:33: error: ‘sprintf’ may write a
> > > terminating nul past the end of the destination
> > > [-Werror=format-overflow=]
> > > 
> > > ../tests/qtest/ast2700-sgpio-test.c: In function ‘test_irq_level_high’:
> > > ../tests/qtest/ast2700-sgpio-test.c:85:33: error: ‘sprintf’ may write a
> > > terminating nul past the end of the destination
> > > [-Werror=format-overflow=]
> > > 
> > > ../tests/qtest/arm-cpu-features.c: In function ‘test_query_cpu_model_expansion_kvm’:
> > > ../tests/qtest/arm-cpu-features.c:578:35: error: ‘%u’ directive writing
> > > between 1 and 10 bytes into a region of size 5
> > > [-Werror=format-overflow=]
> > > 
> > > ../configure
> > > --target-list=x86_64-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu,ppc64-softmmu,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,loongarch64-softmmu
> > > --disable-plugins --enable-modules --enable-werror
> > > --enable-trace-backends=log,dtrace --enable-debug --enable-docs
> > > --enable-rust --enable-strict-rust-lints
> > > 
> > > gcc version 7.5.0 (SUSE Linux)
> > 
> > This is quite an old GCC, so it's probably less good at noticing
> > when there might be an overflow and when not (or it has bugs
> > that have been fixed in subsequent versions).
> 
> By the way, I think we likely could bump the minimum GCC version to a newer
> level nowadays. GCC 7.4 was chosen for NetBSD 9 at that point in time:
> 
>  https://gitlab.com/qemu-project/qemu/-/issues/614
>  https://gitlab.com/qemu-project/qemu/-/commit/3830df5f83b9b52d949676
> 
> ... but since NetBSD 10 has been released since a while, we could likely
> bump the minimum GCC version to 10.4 now, see:
> 
>  https://cvsweb.netbsd.org/bsdweb.cgi/src/doc/3RDPARTY?rev=1.1905.2.14;content-type=text%2Fplain;only_with_tag=netbsd-10-0-RELEASE
> 
> WDYT?

Yep, if any distro needing 7.4 is out of our support matrix we can
bump it. Likewise clang can probably be bumped too.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


