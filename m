Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B090C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufM7T-0005qQ-KM; Fri, 25 Jul 2025 13:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufM67-0004Hs-6t
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufM5r-0007BE-4s
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753464023;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsLiLHkwsz8g8spD/DLi4l90qtXVsyiESamOaqGPyyw=;
 b=G4UOm6QxPMpj9CJG/wKNYzj4x2Hv/3Y3447Uor1jfP1tV3UZ/y/A1g/01x4/dho8SlkoRl
 V2j9g9k05TupZv03G1e5LMfFe/+jEl83EVAiyqTccQAi+gaZJ+XlRDQ+hVZCpytGu0QyfC
 BnSQb5v/UJlJAXffOKXSTRo9dtTtu3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-922f_2qaM5ihOWlQx_up-A-1; Fri,
 25 Jul 2025 13:20:19 -0400
X-MC-Unique: 922f_2qaM5ihOWlQx_up-A-1
X-Mimecast-MFC-AGG-ID: 922f_2qaM5ihOWlQx_up-A_1753464018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8366019560AD; Fri, 25 Jul 2025 17:20:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59A1B1800242; Fri, 25 Jul 2025 17:20:14 +0000 (UTC)
Date: Fri, 25 Jul 2025 18:20:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexandre Iooss <erdnaxe@crans.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL 1/1] log: make '-msg timestamp=on' apply to all qemu_log
 usage
Message-ID: <aIO8y1bFeYRmUeOa@redhat.com>
References: <20250724144636.107828-1-stefanha@redhat.com>
 <20250724144636.107828-2-stefanha@redhat.com>
 <d0e8ec94-1430-4db3-8c77-9dcdec3e67dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0e8ec94-1430-4db3-8c77-9dcdec3e67dc@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 25, 2025 at 10:04:50AM -0700, Pierrick Bouvier wrote:
> On 7/24/25 7:46 AM, Stefan Hajnoczi wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Currently the tracing 'log' back emits special code to add timestamps
> > to trace points sent via qemu_log(). This current impl is a bad design
> > for a number of reasons.
> > 
> >   * It changes the QEMU headers, such that 'error-report.h' content
> >     is visible to all files using tracing, but only when the 'log'
> >     backend is enabled. This has led to build failure bugs as devs
> >     rarely test without the (default) 'log' backend enabled, and
> >     CI can't cover every scenario for every trace backend.
> > 
> >   * It bloats the trace points definitions which are inlined into
> >     every probe location due to repeated inlining of timestamp
> >     formatting code, adding MBs of overhead to QEMU.
> > 
> >   * The tracing subsystem should not be treated any differently
> >     from other users of qemu_log. They all would benefit from
> >     having timestamps present.
> > 
> >   * The timestamp emitted with the tracepoints is in a needlessly
> >     different format to that used by error_report() in response
> >     to '-msg timestamp=on'.
> > 
> > This fixes all these issues simply by moving timestamp formatting
> > into qemu_log, using the same approach as for error_report.
> > 
> > The code before:
> > 
> >    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
> >    {
> >        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
> >            if (message_with_timestamp) {
> >                struct timeval _now;
> >                gettimeofday(&_now, NULL);
> >                qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n",
> >                         qemu_get_thread_id(),
> >                         (size_t)_now.tv_sec, (size_t)_now.tv_usec
> >                         , creds, filename, path);
> >            } else {
> >                qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
> >            }
> >        }
> >    }
> > 
> > and after:
> > 
> >    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
> >    {
> >        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
> >            qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
> >        }
> >    }
> > 
> > The log and error messages before:
> > 
> >    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
> >    2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55d925bd9490 dir=/var/home/berrange/tls
> >    2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path creds=0x55d925bd9490 filename=ca-cert.pem path=<none>
> >    2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory
> > 
> > and after:
> > 
> >    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
> >    2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55bf5bf12380 dir=/var/home/berrange/tls
> >    2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path creds=0x55bf5bf12380 filename=ca-cert.pem path=<none>
> >    2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory
> > 
> > The binary size before:
> > 
> >    $ ls -alh qemu-system-x86_64
> >    -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
> >    $ strip qemu-system-x86_64
> >    $ ls -alh qemu-system-x86_64
> >    -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
> > 
> > and after:
> > 
> >    $ ls -alh qemu-system-x86_64
> >    -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
> >    $ strip qemu-system-x86_64
> >    $ ls -alh qemu-system-x86_64
> >    -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Message-id: 20250721185452.3016488-1-berrange@redhat.com
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   util/log.c                       | 20 +++++++++++++++++++-
> >   scripts/tracetool/backend/log.py | 14 +-------------
> >   2 files changed, 20 insertions(+), 14 deletions(-)
> > 
> > diff --git a/util/log.c b/util/log.c
> > index 58d24de48a..abdcb6b311 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
> >   void qemu_log(const char *fmt, ...)
> >   {
> > -    FILE *f = qemu_log_trylock();
> > +    FILE *f;
> > +    g_autofree const char *timestr = NULL;
> > +
> > +    /*
> > +     * Prepare the timestamp *outside* the logging
> > +     * lock so it better reflects when the message
> > +     * was emitted if we are delayed acquiring the
> > +     * mutex
> > +     */
> > +    if (message_with_timestamp) {
> > +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> > +        timestr = g_date_time_format_iso8601(dt);
> > +    }
> > +
> > +    f = qemu_log_trylock();
> >       if (f) {
> >           va_list ap;
> > +        if (timestr) {
> > +            fprintf(f, "%s ", timestr);
> > +        }
> > +
> >           va_start(ap, fmt);
> >           vfprintf(f, fmt, ap);
> >           va_end(ap);
> > diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> > index 5c9d09dd11..eb50ceea34 100644
> > --- a/scripts/tracetool/backend/log.py
> > +++ b/scripts/tracetool/backend/log.py
> > @@ -20,7 +20,6 @@
> >   def generate_h_begin(events, group):
> >       out('#include "qemu/log-for-trace.h"',
> > -        '#include "qemu/error-report.h"',
> >           '')
> > @@ -32,20 +31,9 @@ def generate_h(event, group):
> >       cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
> >       out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> > -        '        if (message_with_timestamp) {',
> > -        '            struct timeval _now;',
> > -        '            gettimeofday(&_now, NULL);',
> >           '#line %(event_lineno)d "%(event_filename)s"',
> > -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
> > -        '                     qemu_get_thread_id(),',
> > -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> > -        '                     %(argnames)s);',
> > +        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> >           '#line %(out_next_lineno)d "%(out_filename)s"',
> > -        '        } else {',
> > -        '#line %(event_lineno)d "%(event_filename)s"',
> > -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> > -        '#line %(out_next_lineno)d "%(out_filename)s"',
> > -        '        }',
> >           '    }',
> >           cond=cond,
> >           event_lineno=event.lineno,
> 
> This broke compilation in debug on linux with all targets due to missing
> include. Not a big deal, but it's a bit surprising it passed our CI. Do we
> sometimes skip it for "simple" patches?

Actually this patch did not break this. Xen was already broken for any
scenario which turned off the 'log' trace backend, which is what prompted
creation of this patch. See the thread here:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04831.html

WRT CI, the Xen issue only exists if building against fairly new Xen
versions, and have turned off the log trace backend. Given limited
resources we can't test every possible build scenario in our CI, and
this is unfortunately an example of this limitation.

This patch will avoid such bugs recurring in future by ensuring that
configure arg choices won't affect whether error-report.h is included
by default or not.

> Fix: https://lore.kernel.org/qemu-devel/20250725165749.3893240-1-pierrick.bouvier@linaro.org/T/#u


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


