Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06439C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 20:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujNzJ-0005s1-HZ; Tue, 05 Aug 2025 16:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujNzF-0005qM-FJ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujNzC-0004ui-4N
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754424612;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EH60BCSGC9dIGMq8o40zZ/MXSCljHF3tRBppo8nQK04=;
 b=YGA2z9/Up7zWHewFGHItIlFgCsEzezTbx2JwjjrB+gRvqF6Auxe+yqlCVK0ErJwiAJ3pns
 n2RS6c8iT2X0VwpxEkE8v2bAQUGvZYFjjCNgs4SorBUHxEgZuMufgwvVdWChzEaZpF8KFs
 n+pdmpQugjdoNIWaGEApqxqvMXnadiw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-3D059NQYPJOd1cGaMPcCqA-1; Tue,
 05 Aug 2025 16:10:07 -0400
X-MC-Unique: 3D059NQYPJOd1cGaMPcCqA-1
X-Mimecast-MFC-AGG-ID: 3D059NQYPJOd1cGaMPcCqA_1754424606
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 814AB1800446; Tue,  5 Aug 2025 20:10:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BBD11955E88; Tue,  5 Aug 2025 20:10:03 +0000 (UTC)
Date: Tue, 5 Aug 2025 21:10:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/2] tracetool/format: remove redundent trace-event checks
Message-ID: <aJJlGOA_jibz5hKZ@redhat.com>
References: <20250804112039.16377-1-tanishdesai37@gmail.com>
 <20250804112039.16377-3-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804112039.16377-3-tanishdesai37@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 04, 2025 at 11:20:39AM +0000, Tanish Desai wrote:
> Remove redundent if(check_trace_event) check
> from individual backends.
> Adding CHECK_TRACE_EVENT_GET_STATE in log,syslog,
> dtrace and simple backend.
> 
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/ftrace.py | 4 +---
>  scripts/tracetool/backend/log.py    | 6 ++----
>  scripts/tracetool/backend/simple.py | 9 ++-------
>  scripts/tracetool/backend/syslog.py | 8 ++------
>  4 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index 5fa30ccc08..b38f527461 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -16,6 +16,7 @@
>  
>  
>  PUBLIC = True
> +CHECK_TRACE_EVENT_GET_STATE = True
>  
>  
>  def generate_h_begin(events, group):
> @@ -32,18 +33,15 @@ def generate_h(event, group):
>          '        char ftrace_buf[MAX_TRACE_STRLEN];',
>          '        int unused __attribute__ ((unused));',
>          '        int trlen;',
> -        '        if (trace_event_get_state(%(event_id)s)) {',
>          '#line %(event_lineno)d "%(event_filename)s"',
>          '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
>          '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
>          '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
>          '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
> -        '        }',
>          '    }',
>          name=event.name,
>          args=event.args,
> -        event_id="TRACE_" + event.name.upper(),
>          event_lineno=event.lineno,
>          event_filename=event.filename,
>          fmt=event.fmt.rstrip("\n"),
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index eb50ceea34..d8406d226b 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -16,6 +16,7 @@
>  
>  
>  PUBLIC = True
> +CHECK_TRACE_EVENT_GET_STATE = True
>  
>  
>  def generate_h_begin(events, group):
> @@ -28,14 +29,11 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames = ", " + argnames
>  
> -    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
> -
> -    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> +    out('    if (qemu_loglevel_mask(LOG_TRACE)) {',
>          '#line %(event_lineno)d "%(event_filename)s"',
>          '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
>          '    }',
> -        cond=cond,
>          event_lineno=event.lineno,
>          event_filename=event.filename,
>          name=event.name,

This change results in bad indentation of the generated inline function
nested if conditions. e.g. the result looks like this:

static inline void trace_test_blah(void *context, const char *filename)
{
    if (trace_event_get_state(TRACE_TEST_BLAH)) {
    if (qemu_loglevel_mask(LOG_TRACE)) {
#line 4 "trace-events"
        qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
#line 29 "../../../../../../../../dev/stdout"
    }
    }
}


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


