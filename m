Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1A7C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKl9-0001kc-1I; Tue, 05 Aug 2025 12:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujKkz-0001i5-BQ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujKkw-0000M1-CW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754412196;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7JJzhseou2jwbKcnse4HM7n6Knnag3S9DORmIsA2yk=;
 b=YoXMVwNt3TCQO62aXXNhDWHzkdxbbTVAG/awTI2QLtPhURjDLGwUP5nwDCEBdJ7IQ/mvLp
 MK+HoGS5dUoUuT+CS6T3HeqWJIFaLac7x94ut4fivFxmGTe8q7HoTgHy54UcJnyYpbe+Y6
 ONH9jV8MXxalk7iI3HQIRKXEuCeby84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-ppWLBKDFPdeea9mEvW7szQ-1; Tue,
 05 Aug 2025 12:43:13 -0400
X-MC-Unique: ppWLBKDFPdeea9mEvW7szQ-1
X-Mimecast-MFC-AGG-ID: ppWLBKDFPdeea9mEvW7szQ_1754412192
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25A08195606D; Tue,  5 Aug 2025 16:43:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12E4C3000199; Tue,  5 Aug 2025 16:43:09 +0000 (UTC)
Date: Tue, 5 Aug 2025 17:43:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
Message-ID: <aJI0mr5HDgtE9HIc@redhat.com>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Aug 05, 2025 at 07:25:39PM +0300, Manos Pitsidianakis wrote:
> On Tue, Aug 5, 2025 at 7:05 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Aug 04, 2025 at 04:47:13PM +0300, Manos Pitsidianakis wrote:
> > > This RFC series contains some simple patches I've been sitting on for
> > > some months to allow tracing in rust devices in a similar matter to C,
> > > only it's done via a proc-macro codegen instead of using tracetool
> > > script or equivalent.
> >
> > IIUC, this series is only emitting the traces events via the
> > qemu_log function, and so feels like it is missing the benefit
> > of tracing, vs the traditional logging framework.
> >
> > In our RHEL & Fedora distro builds we disable the log backend
> > and enable dtrace, so that we have fully dynamic tracing and
> > observability across the kernel, qemu, libvirt and other
> > components with dtrace integration.
> 
> Hi Daniel,
> 
> Thanks for the insight! Do you have any points where I should look at
> the trace implementation for how the different backends are supported?
> 
> So I think there's already work in progress to support proper tracing
> for Rust, I only sent this as a temporary fixup to provide some kind
> of parity between C and Rust implementations until a proper, better
> solution is available that can replace it.

Can the rust code not easily consume the existing functions in the
trace.h files generated for the C code as a short-term solution ?

It would not benefit from the code inlining in the same way as C
would, but it would at least give feature parity for tracing with
all the trace backends are available.

Then, we can look at optimizing with a pure rust impl of some
backends at a later date, to regain what we lost from lack of
inlining ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


