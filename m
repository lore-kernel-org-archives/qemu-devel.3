Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960E8C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhjQ-0005oF-HH; Wed, 06 Aug 2025 13:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujhOW-0003iW-Nk
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujhOU-0002gv-QK
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754499218;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+kyxIoUKimsW8GPxAB6mN7itQuSEXTqlyXFmpOsko2k=;
 b=ffzbxVCLq6ICFtX3ojTgc+fXH8zoL8NreeLMm7w3twLZB2SQJC9qYYlu25AgHRKqLbvJ/7
 SbtIIsbT6Oe9+Rzt7mLAPSYJGhZiG/1l7GnhuPyZ8AQx2HqFWjMIvD+gR5U7BQxM9wVIoV
 h179bsqGb8gkpGlxd938umDrslwVjdQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-W4hghUDiM8CRFo3eOLJPXQ-1; Wed,
 06 Aug 2025 12:53:34 -0400
X-MC-Unique: W4hghUDiM8CRFo3eOLJPXQ-1
X-Mimecast-MFC-AGG-ID: W4hghUDiM8CRFo3eOLJPXQ_1754499213
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A346B19560AA; Wed,  6 Aug 2025 16:53:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.223])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90DBE1956086; Wed,  6 Aug 2025 16:53:31 +0000 (UTC)
Date: Wed, 6 Aug 2025 17:53:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/2] tracetool/format: remove redundent trace-event
 checks
Message-ID: <aJOIhxTD9pxnOBPj@redhat.com>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
 <20250806150539.2871-3-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806150539.2871-3-tanishdesai37@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Aug 06, 2025 at 03:05:39PM +0000, Tanish Desai wrote:
> Remove redundent if(check_trace_event) check
> from individual backends.
> Adding CHECK_TRACE_EVENT_GET_STATE in log,syslog,
> dtrace and simple backend.
> 
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/ftrace.py | 12 +++++-------
>  scripts/tracetool/backend/log.py    | 10 ++++------
>  scripts/tracetool/backend/simple.py |  9 ++-------
>  scripts/tracetool/backend/syslog.py |  8 ++------
>  4 files changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index 5fa30ccc08..c65d3b89b3 100644
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
> @@ -28,11 +29,10 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames = ", " + argnames
>  
> -    out('    {',
> -        '        char ftrace_buf[MAX_TRACE_STRLEN];',
> -        '        int unused __attribute__ ((unused));',
> -        '        int trlen;',
> -        '        if (trace_event_get_state(%(event_id)s)) {',
> +    out('        {',
> +        '            char ftrace_buf[MAX_TRACE_STRLEN];',
> +        '            int unused __attribute__ ((unused));',
> +        '            int trlen;',

This results in unecessary nested code blocks & indent.
For example:

static inline void trace_test_blah(void *context, const char *filename)
{
    if (trace_event_get_state(TRACE_TEST_BLAH)) {
        {
            char ftrace_buf[MAX_TRACE_STRLEN];
            int unused __attribute__ ((unused));
            int trlen;
#line 4 "trace-events"
            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
                             "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
#line 33 "[stdout]"
            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
            unused = write(trace_marker_fd, ftrace_buf, trlen);
        }
    }
}

Instead of


static inline void trace_test_blah(void *context, const char *filename)
{
    if (trace_event_get_state(TRACE_TEST_BLAH)) {
        char ftrace_buf[MAX_TRACE_STRLEN];
        int unused __attribute__ ((unused));
        int trlen;
#line 4 "trace-events"
        trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
                         "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
#line 33 "[stdout]"
        trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
        unused = write(trace_marker_fd, ftrace_buf, trlen);
    }
}



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


