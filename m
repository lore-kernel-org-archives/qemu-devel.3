Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EA0D0C84D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfc19-0002cf-GA; Tue, 13 Jan 2026 05:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfc17-0002cB-Uo
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfc16-0005LM-90
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768301571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfChtaqWTEn7gx0gUDG+VZ6HC8P/+wqEXQbwQivPOyU=;
 b=VmG+/3B6du2iuald6Ywhs9L+6UzPF2GAJ2DYeGXo/6eiMkSbY3F4oKy4WFHCTy7hY8x0pY
 dWmhoMJ048v8qa9TXGFufSM0pJHgiwAXZeYyaDHK2XuBAVnJ4N2mRH7eT77ZpH2covmQXT
 k6chxzg4N8B3b3Rtd3oQzdShdkLIH6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-C2vFDq7mOjSaxPoEhN-ITg-1; Tue,
 13 Jan 2026 05:52:48 -0500
X-MC-Unique: C2vFDq7mOjSaxPoEhN-ITg-1
X-Mimecast-MFC-AGG-ID: C2vFDq7mOjSaxPoEhN-ITg_1768301566
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 791271800365; Tue, 13 Jan 2026 10:52:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 307F330001A8; Tue, 13 Jan 2026 10:52:36 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:52:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 09/24] util: introduce some API docs for logging APIs
Message-ID: <aWYj7-ByD4eyclhG@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-10-berrange@redhat.com>
 <87ms2hal4a.fsf@pond.sub.org> <aWYjHQYYeEqpnnQh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWYjHQYYeEqpnnQh@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 13, 2026 at 10:49:01AM +0000, Daniel P. Berrangé via Devel wrote:
> On Tue, Jan 13, 2026 at 10:59:49AM +0100, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > There is a gotcha with qemu_log() usage in a threaded process.
> > > If fragments of a log message are output via qemu_log() it is
> > > possible for messages from two threads to get mixed up. To
> > > prevent this qemu_log_trylock() should be used, along with
> > > fprintf(f) calls.
> > >
> > > This is a subtle problem that needs to be explained in the
> > > API docs to ensure correct usage.
> > >
> > > Reported-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >  include/qemu/log-for-trace.h | 17 ++++++++++++++++-
> > >  include/qemu/log.h           | 31 +++++++++++++++++++++++++++++++
> > >  rust/util/src/log.rs         |  6 ++++++
> > >  3 files changed, 53 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> > > index f3a8791f1d..6861a1a4b7 100644
> > > --- a/include/qemu/log-for-trace.h
> > > +++ b/include/qemu/log-for-trace.h
> > > @@ -29,7 +29,22 @@ static inline bool qemu_loglevel_mask(int mask)
> > >      return (qemu_loglevel & mask) != 0;
> > >  }
> > >  
> > > -/* main logging function */
> > > +/**
> > > + * qemu_log: report a log message
> > > + * @fmt: the format string for the message
> > > + * @...: the format string arguments
> > > + *
> > > + * This will emit a log message to the current output stream.
> > > + *
> > > + * The @fmt string should normally represent a complete line
> > > + * of text, and thus end with a newline character.
> > 
> > Note for later: "should normally".
> > 
> > > + *
> > > + * While it is possible to incrementally output fragments of
> > > + * a complete line using qemu_log, this is inefficient and
> > > + * races with other threads. For outputting fragments it is
> > > + * strongly preferred to use the qemu_log_trylock() method
> > > + * combined with fprintf().
> > > + */
> > >  void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
> > >  
> > >  #endif
> > > diff --git a/include/qemu/log.h b/include/qemu/log.h
> > > index 7effba4da4..e9d3c6806b 100644
> > > --- a/include/qemu/log.h
> > > +++ b/include/qemu/log.h
> > > @@ -41,7 +41,38 @@ bool qemu_log_separate(void);
> > >  
> > >  /* Lock/unlock output. */
> > >  
> > > +/**
> > > + * Acquires a lock on the current log output stream.
> > > + * The returned FILE object should be used with the
> > > + * fprintf() function to output the log message, and
> > > + * then qemu_log_unlock() called to release the lock.
> > > + *
> > > + * The primary use case is to be able to incrementally
> > > + * output fragments of a complete log message in an
> > > + * efficient and race free manner.
> > > + *
> > > + * The simpler qemu_log() method must only be used
> > > + * to output complete log messages.
> > 
> > "must".
> > 
> > > + *
> > > + * A typical usage pattern would be
> > > + *
> > > + *    FILE *f = qemu_log_trylock()
> > > + *
> > > + *    fprintf(f, "Something ");
> > > + *    fprintf(f, "Something ");
> > > + *    fprintf(f, "Something ");
> > > + *    fprintf(f, "The end\n");
> > > + *
> > > + *    qemu_log_unlock(f);
> > > + *
> > > + * Returns: the current FILE if available, NULL on error
> > > + */
> > >  FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
> > > +
> > > +/**
> > > + * Releases the lock on the log output, previously
> > > + * acquired by qemu_log_trylock().
> > > + */
> > >  void qemu_log_unlock(FILE *fd);
> > >  
> > >  /* Logging functions: */
> > > diff --git a/rust/util/src/log.rs b/rust/util/src/log.rs
> > > index 0a4bc4249a..6a3a30d8d8 100644
> > > --- a/rust/util/src/log.rs
> > > +++ b/rust/util/src/log.rs
> > > @@ -134,6 +134,12 @@ fn drop(&mut self) {
> > >  ///     "Address 0x{:x} out of range",
> > >  ///     error_address,
> > >  /// );
> > > +///
> > > +/// The `log_mask_ln` macro should only be used for emitting complete
> > 
> > "should only".
> > 
> > > +/// log messages. Where it is required to incrementally output string
> > > +/// fragments to construct a complete message, `LogGuard::new()` should
> > > +/// be directly used in combination with `writeln()` to avoid output
> > > +/// races with other QEMU threads.
> > >  /// ```
> > >  #[macro_export]
> > >  macro_rules! log_mask_ln {
> > 
> > "Should normally" suggests there are exceptions.
> > 
> > "Should only" does not.
> > 
> > "Must" is a bit stronger still.
> > 
> > Which of the three do we want?
> 
> The "Should" usage was reflecting the reality that we have quite alot
> of code using qemu_log_trylock + qemu_log, instead of qemu_log_trylock
> + fprintf.
> 
> I didn't feel it appropriate to use 'must' unless we explicitly make
> qemu_log() fail when used inside the scope of a qemu_log_trylock().
> 
> So "Should normally" is the best fit

Actually specifically in the log.rs case, we have a greater constraint.
The rust code for log_mask_ln will unconditionally add a newline to
all messages. So this Rust method *must* only be usd for complete
messages, regardless of what policy we have on the C qemu_log() call.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


