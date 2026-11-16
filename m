Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F11606A889
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bO9VWOAx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Nt-0000OD-F9; Mon, 16 Nov 2026 16:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4Nr-0000Np-P8
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4Np-0004Ye-TX
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794865020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEeYBVcVgz/Z3j+9q0lX2/pBU8KuIRbEWm4LFyxxImQ=;
 b=bO9VWOAxGTOpGzzdg35+vEjhcZO0Eq5PsjDB1028qUVmwSaQDAbDABpZdZZsiatcHVZgZn
 m9JuLOgCjLDjXqc6EDYnsqlRfRMRF0IvTLFUK4bTzRX7iDEEzNx/LBfwF5dj5o1fsKDunM
 p7ackjg8OEHstztsf2wvUTTPzlsR6QE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-W7C1gn0JMgWdFqF7_4SQZg-1; Mon,
 16 Nov 2026 16:36:56 -0500
X-MC-Unique: W7C1gn0JMgWdFqF7_4SQZg-1
X-Mimecast-MFC-AGG-ID: W7C1gn0JMgWdFqF7_4SQZg_1794865015
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7D01956046; Mon, 16 Nov 2026 21:36:55 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C44FF195B3C2; Mon, 16 Nov 2026 21:36:53 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:36:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 05/48] hw: tweak approach to setting alias in machine
 macros
Message-ID: <avt3ctAhBPoLXj13@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-6-berrange@redhat.com>
 <ca8a6fcb-0b5e-4745-b5c2-99fb6770a62a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca8a6fcb-0b5e-4745-b5c2-99fb6770a62a@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:46:39PM -0800, Pierrick Bouvier wrote:
> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> > Currently the pattern for DEFINE_MACHINE macros is to
> > pass a boolean "latest" flag as a macro parameter, which
> > is then used in a test. For example
> > 
> >         ...
> >         if (latest) {
> >             mc->alias = "s390-ccw-virtio";
> >             mc->is_default = true;
> >         }
> > 
> > On the surface this looks fine, but this is actually taking a
> > build time static characteristic of the machine type and turning
> > it into a runtime tunable that only ever has a single code path.
> > ie the macro code expands to:
> > 
> >         if (true) {
> >             mc->alias = "s390-ccw-virtio";
> >             mc->is_default = true;
> >         }
> > 
> > or
> > 
> >         if (false) {
> >             mc->alias = "s390-ccw-virtio";
> >             mc->is_default = true;
> >         }
> > 
> > The compiler should optimize out the condition, but we can do
> > do this explicitly by passing the desired extra initializers
> > to the macro directly.
> > 
> 
> Has it been measured? It looks like a very premature optimization to
> remove one if that is absolutely not on any hot path.

To be clear, this is not a performance impact. At this point
in the series, it is just a bit of "ugliness" when looking
at the code emitted from the macro.

A few patches further along, however, we need to be able to
set a list of aliases that varies per machine. At that point
we can't be just passing a bool value in, we need to pass a
block of code in.

So this commit is mostly about preparing for that latter
change, the "optimization" mentioned is just incidental.

> 
> > This makes the macro definition a bit more verbose, but it will
> > facilitate forthcoming changes that require more complex
> > initialization to be added to the class initializer methods.
> >
> 
> As mentioned on another thread, the DEFINE_* macros seems to create more
> problems than they solve, and we would gain clarity by simply accepting
> the extra lines of boilerplate.
> 
> We could have exception of course (especially for machines defined in a
> single file), but for global macros available in multiple files, our
> life would be much more easier without all this.
> 
> Just my 2 cents.
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Regards,
> Pierrick
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


