Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF237C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLsA-0007Z0-2d; Tue, 05 Aug 2025 13:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujLs5-0007Ya-TK
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujLs1-0001To-Kp
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754416480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBUla4FtE8OEc0GtbOyf35rxSkqz9JF9iqCRb6awNH4=;
 b=K8+oxJBfkVKAvVqvI9c5YPtPKlvDj3lpyzva1ZNgZ/iwHUbvhLcoMhcB2lyZmDcpJhAY9X
 NdsWHhPKIM+XozozbPLpAUv733lbNr53+8mCNn4NcqNOx7UFFo/UAwrCG5/knCMTUgmMmP
 wNyx0Img37hmdi7nNsm8NlEzkFm5014=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-QWuaPYsJOaWiwpbIJWL11Q-1; Tue,
 05 Aug 2025 13:54:37 -0400
X-MC-Unique: QWuaPYsJOaWiwpbIJWL11Q-1
X-Mimecast-MFC-AGG-ID: QWuaPYsJOaWiwpbIJWL11Q_1754416476
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 417DE18001D5; Tue,  5 Aug 2025 17:54:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 146C71800D82; Tue,  5 Aug 2025 17:54:33 +0000 (UTC)
Date: Tue, 5 Aug 2025 18:54:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
Message-ID: <aJJFVgkt7R49ZwIF@redhat.com>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
 <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 05, 2025 at 07:47:39PM +0300, Manos Pitsidianakis wrote:
> On Tue, Aug 5, 2025 at 7:43 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Aug 05, 2025 at 07:25:39PM +0300, Manos Pitsidianakis wrote:
> > > On Tue, Aug 5, 2025 at 7:05 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 04, 2025 at 04:47:13PM +0300, Manos Pitsidianakis wrote:
> > > > > This RFC series contains some simple patches I've been sitting on for
> > > > > some months to allow tracing in rust devices in a similar matter to C,
> > > > > only it's done via a proc-macro codegen instead of using tracetool
> > > > > script or equivalent.
> > > >
> > > > IIUC, this series is only emitting the traces events via the
> > > > qemu_log function, and so feels like it is missing the benefit
> > > > of tracing, vs the traditional logging framework.
> > > >
> > > > In our RHEL & Fedora distro builds we disable the log backend
> > > > and enable dtrace, so that we have fully dynamic tracing and
> > > > observability across the kernel, qemu, libvirt and other
> > > > components with dtrace integration.
> > >
> > > Hi Daniel,
> > >
> > > Thanks for the insight! Do you have any points where I should look at
> > > the trace implementation for how the different backends are supported?
> > >
> > > So I think there's already work in progress to support proper tracing
> > > for Rust, I only sent this as a temporary fixup to provide some kind
> > > of parity between C and Rust implementations until a proper, better
> > > solution is available that can replace it.
> >
> > Can the rust code not easily consume the existing functions in the
> > trace.h files generated for the C code as a short-term solution ?
> >
> > It would not benefit from the code inlining in the same way as C
> > would, but it would at least give feature parity for tracing with
> > all the trace backends are available.
> >
> > Then, we can look at optimizing with a pure rust impl of some
> > backends at a later date, to regain what we lost from lack of
> > inlining ?
> 
> It can, but we'd need to add extra intermediate steps to convert the
> trace headers into Rust equivalent code, so it's not ideal.
> 
> I tried to generate code exactly like the generated trace headers
> though, so I'm not sure what is missing to be honest (hence my
> previous email question). The generated code generates TraceEvents and
> registers them with trace_event_register_group. What else is missing
> to support e.g. dtrace?

'trace_event_register_group' is essentially irrelevant for the
fully dynamic trace backends like dtrace - that's only used for
the backends whose output is controlled by QEMU monitor commands
/ command line arguments.

In the dtrace case the binary gets instructions which are a squence
of nops normally, and dtrace tool gets the kernel to live patch the
binary at runtime to put in a jump for any probes that are being
watched.

Take a look at the generated files <build-dir>/trace/trace-*.h when
using the different '--enable-trace-backends=...' options.

eg taking the trace-crypto.h header, with 'log' backend we see it
emits

   if (trace_event_get_state(TRACE_QCRYPTO_TLS_SESSION_CHECK_CREDS) && qemu_loglevel_mask(LOG_TRACE)) {
#line 23 "../crypto/trace-events"
        qemu_log("qcrypto_tls_session_check_creds " "TLS session check creds session=%p status=%s" "\n", session, status);
#line 372 "trace/trace-crypto.h"
    }

but with dtrace it emits

    QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS(session, status);

which is a referencing a macro created by the external 'dtrace' binary,
which in the Linux case ends up looking like

  #if defined STAP_SDT_V1
  #define QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS_ENABLED() __builtin_expect (qcrypto_tls_session_check_creds_semaphore, 0)
  #define qemu_qcrypto_tls_session_check_creds_semaphore qcrypto_tls_session_check_creds_semaphore
  #else
  #define QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS_ENABLED() __builtin_expect (qemu_qcrypto_tls_session_check_creds_semaphore, 0)
  #endif
  __extension__ extern unsigned short qemu_qcrypto_tls_session_check_creds_semaphore __attribute__ ((unused)) __attribute__ ((section (".probes")));
  #define QEMU_QCRYPTO_TLS_SESSION_CHECK_CREDS(arg1, arg2) \
  DTRACE_PROBE2 (qemu, qcrypto_tls_session_check_creds, arg1, arg2)

you can end up enabling multiple trace backends concurrently too.

If you're thinking this is all rather complicated, you'd be right,
which is why for initial feature parity I figured the simplest is
likely to just wrap the existing QEMU inline probe function, so
Rust doesn't need to know about the different backends... yet...

FWIW, the original DTrace authors created a Rust crate with native
rust integration of dynamic probes.

  https://github.com/oxidecomputer/usdt

I think that (somehow) we probably want to integrate that with QEMU
and its tracetool.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


