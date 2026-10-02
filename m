Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEADACA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCXRv-0006Pi-Bf; Fri, 02 Oct 2026 03:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCXRn-0006PS-Mx
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCXRh-00008U-Db
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790925159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXPcxF34iydpxhga/k7M6/PZAuaxm9PIB36XqH/1a+c=;
 b=NB6APLr3I9dsJjF9s5KScNtkq9vpOPxZ3unwR+SEUw7gL6un6xhoi8zQOzjbMwRFX9H/RW
 /f9WLAVA9ZCbjxSK8+17cDwgRIoUgCu6mF6ahi4pRk/mnM/qhdb7qwcju8BXVN4kY54Hfr
 ECMUE7XU6F4BPWvt1SyQSbDIDpoYM7U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-OhPJcY4gPAmeQWSZN2U-9g-1; Fri,
 02 Oct 2026 03:12:35 -0400
X-MC-Unique: OhPJcY4gPAmeQWSZN2U-9g-1
X-Mimecast-MFC-AGG-ID: OhPJcY4gPAmeQWSZN2U-9g_1790925154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C4F21955EAE
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2026 07:12:34 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D5B019560AB; Fri,  2 Oct 2026 07:12:32 +0000 (UTC)
Date: Fri, 2 Oct 2026 08:12:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 14/20] audio: remove mistaken use of
 trace_event_get_state()
Message-ID: <ar9ZXhIXn3SoNywN@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-15-berrange@redhat.com>
 <179088207684.2348671.16379393864005992729.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179088207684.2348671.16379393864005992729.b4-review@b4>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 01, 2026 at 11:14:36PM +0400, marcandre.lureau@redhat.com wrote:
> > Conditional checks must call trace_event_get_state_dynamic()
> 
> get_state_backends()?

Opps, yes.

> > which checks the state of all backends, while trace_event_get_state()
> > only validates state for backends using QEMU's internal state
> > tracking.
> 
> I don't understand, tbh, but the doc & tracing.rst agree so,

We have a "uint16_t _TRACE....DSTATE"  variable for each probe that
tracks whether QEMU has marked it enabled or not. This is used
to control the ftrace, syslog, log and simple trace backends, and
what the -trace command line arg sets. This is what the
trace_event_get_state() macro checks.

For the systemtap and ust backends, however, that variable is not
used, as they use USDT which are dynamically enabled by the external
tracing application. They proide a semaphore which can be checked
to see if the USDT has been enabled.

The "TRACE...DSTATE()" macro (no leading underscore) expands to
code that checks the systemtap/ust USDT semaphores *and* the
QEMU  "_TRACE...DSTATE" variable. This is what the correct
trace_event_get_state_backends() macro checks, and thus what
needs to be used to ensure things work with dtrace/ust backends,
as well as the QEMU internal backends.

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


