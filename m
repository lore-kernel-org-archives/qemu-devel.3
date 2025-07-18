Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD35C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgjF-00079j-90; Fri, 18 Jul 2025 04:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucgj5-00070b-7X
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucgj2-000582-SJ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rIemI2KVaNURwfWRd9/jEnvo0MJBmEvJjQvDPv0Yglo=;
 b=Z4JnhQYbrGmS3gLMw9h2UTLihSTx15vSsAL3J06wxTrhFUlyU4a7dTJf8KdIVb7gakP+2/
 fwd8NOrSHt5M/jsnYBxU4/f0mZeFOwc0rz6SW48LtYqWUtDn14WW5+WXZvQP5IFlTC0XOt
 2s88Q9+NoUC3qi2muflRSd1Ei6ftWdo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-QIND2cwsNTeGLF-4jyt3vw-1; Fri,
 18 Jul 2025 04:45:46 -0400
X-MC-Unique: QIND2cwsNTeGLF-4jyt3vw-1
X-Mimecast-MFC-AGG-ID: QIND2cwsNTeGLF-4jyt3vw_1752828345
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFA261956046; Fri, 18 Jul 2025 08:45:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFAC7195609D; Fri, 18 Jul 2025 08:45:41 +0000 (UTC)
Date: Fri, 18 Jul 2025 09:45:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Adam Williamson <awilliam@redhat.com>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH] xen/passthrough: add missing error-report include
Message-ID: <aHoJsmB6BT86sdv3@redhat.com>
References: <20250717220207.171040-1-awilliam@redhat.com>
 <87v7nqgk21.fsf@pond.sub.org> <87ikjqght5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikjqght5.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Jul 18, 2025 at 07:59:50AM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Adam Williamson <awilliam@redhat.com> writes:
> >
> >> In cfcacba an `error_report` was added to this file, but the
> >> corresponding include of `qemu/error-report.h` was missed. This
> >> only becomes apparent when building against Xen 4.20+.
> >>
> >> Signed-off-by: Adam Williamson <awilliam@redhat.com>
> >> ---
> >>  hw/xen/xen_pt.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> >> index 9d16644d82..006b5b55f2 100644
> >> --- a/hw/xen/xen_pt.c
> >> +++ b/hw/xen/xen_pt.c
> >> @@ -54,6 +54,7 @@
> >>  
> >>  #include "qemu/osdep.h"
> >>  #include "qapi/error.h"
> >> +#include "qemu/error-report.h"
> >>  #include <sys/ioctl.h>
> >>  
> >>  #include "hw/pci/pci.h"
> >
> > Uh, error-report.h is included without this for me.  To see, build with
> > -H:
> >
> > . /work/armbru/qemu/hw/xen/xen_pt.h
> > .. /work/armbru/qemu/include/hw/xen/xen_native.h
> > ... /work/armbru/qemu/hw/xen/trace.h
> > .... ./trace/trace-hw_xen.h
> > ..... /work/armbru/qemu/include/qemu/error-report.h
> 
> Just remembered: the generated trace header includes error-report.h only
> when trace's log backend is enabled.

Hmm, that's rather an unfortunate trap-door :-( Given that 'log' is enabled
by default when building from git we'll never see missing error-report.h
problems in daily work.

Looking at the log backend it appears that originally it would
unconditionally include the timestamp when calling qemu_log, but
then changed that to opt-in with

  commit 418ed14268f797a5142b60cd557cd598eb548c66
  Author: Stefan Hajnoczi <stefanha@redhat.com>
  Date:   Mon Jan 25 11:35:07 2021 +0000

    trace: make the 'log' backend timestamp configurable

requiring -msg timestamp=on, which was a pre-existing flag that already
did a similar toggle for the 'error_report' function. The goal makes
sense, but it introduced the error-report.h trap door

When I see that I also question why the 'log' backend should be a
special case user of qemu_log() ?  Why shouldn't we emit timestamps
for all usage of qemu_log() ?

If we changed the qemu_log impl to honour the timestamp toggle, then
all users of qemu_log benefit. We then eliminate error-report.h usage
in trace.h headers, and also cut the code size for trace points
significantly


static inline void _nocheck__trace_object_dynamic_cast_assert(const char * type, const char * target, const char * file, int line, const char * func)
{
    if (trace_event_get_state(TRACE_OBJECT_DYNAMIC_CAST_ASSERT) && qemu_loglevel_mask(LOG_TRACE)) {
        if (message_with_timestamp) {
            struct timeval _now;
            gettimeofday(&_now, NULL);
            qemu_log("%d@%zu.%06zu:object_dynamic_cast_assert " "%s->%s (%s:%d:%s)" "\n",
                     qemu_get_thread_id(),
                     (size_t)_now.tv_sec, (size_t)_now.tv_usec
                     , type, target, file, line, func);
        } else {
            qemu_log("object_dynamic_cast_assert " "%s->%s (%s:%d:%s)" "\n", type, target, file, line, func);
        }
    }
}

down to


static inline void _nocheck__trace_object_dynamic_cast_assert(const char * type, const char * target, const char * file, int line, const char * func)
{
    if (trace_event_get_state(TRACE_OBJECT_DYNAMIC_CAST_ASSERT) && qemu_loglevel_mask(LOG_TRACE)) {
            qemu_log("object_dynamic_cast_assert " "%s->%s (%s:%d:%s)" "\n", type, target, file, line, func);
    }
}

which feels more in keeping with the kind of level of complexity you should
want to be inlined in trace callers.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


