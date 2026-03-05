Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B744F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCof-0002hZ-Hx; Thu, 05 Mar 2026 12:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCoF-00029k-5s
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCoC-00029l-TX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcB2RECjV5134nspDUKH3Y9bwtq8HW7jkKj1IodMdd8=;
 b=DbLzRP9gn7akWT9EnM67Q5x7d4d8n6EoCCWvTXFiD9vEphd+1hu2TozMGsYVQ21+V+muJo
 fDmGpjx2uEh8bSTuSDICBr2JFHyOSX2Do4/wAUZql9Iq5y2AxunLv1PypI4iOk4rNQ0g5v
 0MYAFU4roNIT+pkhJ+wwjrvby3xwsPw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-RuwiN8zcM4OrwGvgzwv6Pw-1; Thu,
 05 Mar 2026 12:48:21 -0500
X-MC-Unique: RuwiN8zcM4OrwGvgzwv6Pw-1
X-Mimecast-MFC-AGG-ID: RuwiN8zcM4OrwGvgzwv6Pw_1772732900
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19E931956052; Thu,  5 Mar 2026 17:48:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D5853003E9F; Thu,  5 Mar 2026 17:48:18 +0000 (UTC)
Date: Thu, 5 Mar 2026 17:48:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/27] Misc patches queue
Message-ID: <aanB31jS1aN-Cbqo@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
 <CAFEAcA8HxfTmY8sSi1hhUE+Hown4RH1guaV5J_QcRsGPWGn2jg@mail.gmail.com>
 <aameG2yyyqhDHE-S@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aameG2yyyqhDHE-S@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Thu, Mar 05, 2026 at 03:15:39PM +0000, Daniel P. Berrangé wrote:
> On Thu, Mar 05, 2026 at 02:47:12PM +0000, Peter Maydell wrote:
> > On Tue, 3 Mar 2026 at 15:07, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > > The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:
> > >
> > >   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/berrange/qemu tags/next-pr-pull-request
> > >
> > > for you to fetch changes up to 192f59773a6a8fd1e0d3c1d9c9c3f5f59a62c087:
> > >
> > >   util/oslib-posix: increase memprealloc thread count to 32 (2026-03-03 15:01:21 +0000)
> > >
> > > ----------------------------------------------------------------
> > > * Increase pre-alloc max thread count to 32
> > > * Fix checkpatch warning for new/removed files with --terse
> > > * Detect more GPL boilerplate in checkpatch
> > > * Fix lean of data in TLS/websock GSource cancellation
> > > * Tweak CPU docs for DiamondRapids
> > > * Unconditionally enable thread naming
> > > * Fix race setting thread naming on Win32
> > > * Add API docs for logging APIs
> > > * Fix interleaved error/trace output
> > > * Fix missing error prefixes with warn_report
> > > * Add detailed error reporting for VNC passworrd changes
> > > * Refactoring of error_vprintf & related funcs
> > >
> > > ----------------------------------------------------------------
> > 
> > Something in this consistently causes the s390x runner
> > to fail the test-migration test:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/13367184083
> > https://gitlab.com/qemu-project/qemu/-/jobs/13366572115
> > https://gitlab.com/qemu-project/qemu/-/jobs/13339069533
> > https://gitlab.com/qemu-project/qemu/-/jobs/13336989367
> > 
> > This was a CI run together with the loongarch pullreq, but
> > that has just passed this job when run in CI on its own:
> >  https://gitlab.com/qemu-project/qemu/-/jobs/13367800326
> > so it seems like this pullreq is the one causing the s390x
> > failures.
> 
> Yep, the migration-test seems to be failing in a TLS related test
> case, which certainly points the finger at the early TLS patch
> in this series.

There was a failure to unref an object which caused the hang. I've
sent a v2 pull request with this fix.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


