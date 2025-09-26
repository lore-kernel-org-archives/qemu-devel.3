Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA58CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29V6-0004xT-Rs; Fri, 26 Sep 2025 10:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v29Us-0004be-SV
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v29Ui-0002QK-Ni
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758897123;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNIvkVrgM0TVVV63iU3kPWEizXQotiLmKmXLBOTlga4=;
 b=WIaUi3VVv9jXaJcLZWLgUSE1Gp3lR3ii0B3wx1+HVxaF2DLfwJS+ft/pTBEoJj8hL+XBrE
 /QtJOScs31C9yOuCdQqwTWWNRIANnP3tHLnZLnk+dTIUK1rZxwjAZW0jhY9p75I/ugfZSo
 1xeDM9k6uXPCeGGZRMkr3MUWj9IR0Wo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-o-x5T9xwO22Fa0W-DfVuIQ-1; Fri,
 26 Sep 2025 10:32:01 -0400
X-MC-Unique: o-x5T9xwO22Fa0W-DfVuIQ-1
X-Mimecast-MFC-AGG-ID: o-x5T9xwO22Fa0W-DfVuIQ_1758897120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA3D5185FC7B; Fri, 26 Sep 2025 14:31:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F18F18002B1; Fri, 26 Sep 2025 14:31:40 +0000 (UTC)
Date: Fri, 26 Sep 2025 15:31:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/23] util: introduce some API docs for logging APIs
Message-ID: <aNajyYZ0A33OgjFD@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-10-berrange@redhat.com>
 <a27a8ca5-ad86-44a5-8849-e28e1e3271c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a27a8ca5-ad86-44a5-8849-e28e1e3271c0@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 25, 2025 at 05:02:37PM -0700, Richard Henderson wrote:
> On 9/25/25 02:44, Daniel P. Berrangé wrote:
> > This addresses two key gotchas with the logging APIs:
> > 
> >   * Safely outputting a single line of text using
> >     multiple qemu_log() calls requires use of the
> >     qemu_log_trylock/unlock functions to avoid
> >     interleaving between threads
> > 
> >   * Directly outputting to the FILE object returned
> >     by qemu_log_trylock() must be discouraged because
> >     it prevents the inclusion of configured log message
> >     prefixes.
> 
> I disagree with this point.
> 
> > 
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/qemu/log-for-trace.h | 35 ++++++++++++++++++++++++++++++++++-
> >   include/qemu/log.h           | 26 ++++++++++++++++++++++++++
> >   rust/util/src/log.rs         |  7 +++++++
> >   3 files changed, 67 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> > index d47c9cd446..4e05b2e26f 100644
> > --- a/include/qemu/log-for-trace.h
> > +++ b/include/qemu/log-for-trace.h
> > @@ -29,7 +29,40 @@ static inline bool qemu_loglevel_mask(int mask)
> >       return (qemu_loglevel & mask) != 0;
> >   }
> > -/* main logging function */
> > +/**
> > + * qemu_log: report a log message
> > + * @fmt: the format string for the message
> > + * @...: the format string arguments
> > + *
> > + * This will emit a log message to the current output stream.
> > + *
> > + * The @fmt string should normally represent a complete line
> > + * of text, ending with a newline character.
> > + *
> > + * If intending to call this function multiple times to
> > + * incrementally construct a line of text, locking must
> > + * be used to ensure that output from different threads
> > + * is not interleaved.
> > + *
> > + * This is achieved by calling qemu_log_trylock() before
> > + * starting the log line; calling qemu_log() multiple
> > + * times with the last call having a newline at the end
> > + * of @fmt; finishing with a call to qemu_log_unlock().
> > + *
> > + * The FILE object returned by qemu_log_trylock() does
> > + * not need to be used for outputting text directly,
> > + * it is merely used to associate the lock.
> > + *
> > + *    FILE *f = qemu_log_trylock()
> > + *
> > + *    qemu_log("Something");
> > + *    qemu_log("Something");
> > + *    qemu_log("Something");
> > + *    qemu_log("The end\n");
> > + *
> > + *    qemu_log_unlock(f);
> > + *
> 
> And I really don't like documenting this as the "right way".
> 
> I believe that qemu_log *should* be used only for single-line output, all in
> one piece. Larger blocks *should* always use qemu_log_trylock and fprintf.
> The compiler has optimizations transforming fprintf to fputs and fputc as
> appropriate.

Ok, bearing in mind your suggestion below, I'll flip this around.
The above  doc would instruct people to NOT use qemu_log for
incomplete lines (though it would still be accepted), and then
qemu_log_trylock() docs can recommend the best practice for
incremental line output.

> If we can manage to transform all existing usage of multiple qemu_log, then
> we can remove the '\n' detection added in patch 8.

The challenge with that is that we have no easy way to identify all
such usage other than incredibly tedious auditing of every single
file with more than one qemu_log call. And then we also can't easil
prevent it being re-introduced as a problem.

> 
> As far as adding the new prefixes... perhaps we should have something like
> 
> FILE *qemu_log_trylock_and_context(bool suppress_context)
> {
>     FILE *f = qemu_log_trylock();
>     if (f && !suppress_context) {
>         qmessage_context_print(f);
>     }
>     return f;
> }
> 
> where qemu_log would do
> 
>     f = qemu_log_trylock_and_context(incomplete);

That's a nice idea, as it brings the prefixes into the codepaths which
avoid qemu_log(). I'll try that out.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


