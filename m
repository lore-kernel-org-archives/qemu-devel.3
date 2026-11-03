Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B70606A331
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aYqEvHQK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALl-0007Ym-3h; Tue, 03 Nov 2026 03:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALU-0007Wa-MW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALS-0006OA-Vf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEzSOPkYDxcHWVaklDwGgJBnTocjTF9spJeTenKdawI=;
 b=aYqEvHQKdNITEOiJQx42tzoky+5kgCmIKM/dpgkska6+3hHwjKUYUPxfXl9jnJ0U5XHk2e
 wgcANmtkkb/DMk4vE0R5GKgN802qR4RZ8TPLT4ll523bYYMIP1uVkVBGI1fN7hwSNTX78W
 eIQoJsgHbeURwvAW9aVHJgfmIgZqb5o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-tuzTgJNxPB2Dpev5VL_Kpg-1; Tue,
 03 Nov 2026 03:58:16 -0500
X-MC-Unique: tuzTgJNxPB2Dpev5VL_Kpg-1
X-Mimecast-MFC-AGG-ID: tuzTgJNxPB2Dpev5VL_Kpg_1793696295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9B791954236
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 08:58:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7A6F18005AD; Tue,  3 Nov 2026 08:58:14 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 23/25] trace: stop tracking static disabled state
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20261102142844.3464712-24-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-24-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:47 +0400
Message-Id: <179369626700.418241.7605700816789969255.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3247;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bEw/rnNpuKS7FvkhoMfP3SQiUG8TDqj5ffDJSGcbXQ4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aIObB6mpeA74Hqw8PELh2KFARl5ozU3WjeR/
 7UFXYocNbeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDgAKCRDa6OEJdZac
 5XEQD/9Zukg3O7dQw/cW26ZBajteXgpkNZNCWb7jA1Tz++Q+FffzyvtWyChETRaFMuMyMsJYzYE
 RxMpPhcQkUwMV8GgpS7Y9ml43ElY+uUdWDaX7AZ5It4ytNWLgr7eDdlT/BlN6mKWqkVGJws1hIq
 f443pgAFuhzDYJNtWYpc+E5/U+s4laKtLTO5oRBbKA+LEgG7ji1Pz7SBDGmQiZGObmHegXSElUi
 kWk8Nuc87EJRf5T0ifuR45H90z8A/7CTWvXku+IJMSaqqLpQ2PFapahBz+SqEiQ+MYUJgAtf4AX
 TOZaCa7FxloBlMMlfcGYBBAY0CLDyWyJbmHS6fCdmFvUH1BkWF8pYhF2pGIzs+GHg5hS8smvsxo
 O97BRJ6JCWyNrhOpGtYR/tV6b+HEue2YswH2zT85bya/jvdXxzYWhHcHnjnqUQNluqlZmeLf4UU
 GrcTiwAjp/g33VdSPKw93TtjN1fP7UDfbG/J+yvgCXToARNcAMJ3rDX4dhNcvdsaSxWJDmyq+kR
 n3Io9tHqCL6s5ROu6Fogt9p7W9pueyS+pRcIBoWlF6zgCsk6UsjJscYRtYUZEEzbywkuiOHsbyO
 xBF5ux2crVDpv+aMp6kOyrB8+PIOEdiA1kgUY08A6TSMmcaiB8prXgw4gpS9HHzM8qDKgqL7Emr
 RTyc7/138czNXig==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The TraceEvent struct contains a "bool sstate" field which track whether
> a trace event was disabled statically. i.e. at build time via the
> "disable" property annotation in trace-events.
> 
> The only runtime use of this field is to let "trace-event-get-state"
> report that an event is "unavailable" instead of reporting an error for
> an unknown trace event.
> 
> Trace events are not ABI so their names can change and the event can
> come and go at any time. Thus there is little utility in reporting the
> existence of a disabled event that cannot ever be used at runtime.
> 
> Removing the "bool sstate" field from TraceEvent saves 8 bytes of
> space in the struct, adding up to approx 64 KB across all current
> events.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261102142844.3464712-24-berrange@redhat.com>
> ---
>  qapi/trace.json               |  5 ++--
>  scripts/tracetool/format/c.py |  2 --
>  scripts/tracetool/format/h.py |  8 ------
>  stubs/trace-control.c         |  1 -
>  tests/tracetool/all.c         |  2 --
>  tests/tracetool/all.h         | 14 +++++------
>  tests/tracetool/dtrace.c      |  2 --
>  tests/tracetool/dtrace.h      |  2 --
>  tests/tracetool/ftrace.c      |  2 --
>  tests/tracetool/ftrace.h      |  6 ++---
>  tests/tracetool/log.c         |  2 --
>  tests/tracetool/log.h         |  6 ++---
>  tests/tracetool/nop.h         |  2 --
>  tests/tracetool/simple.c      |  2 --
>  tests/tracetool/simple.h      |  2 --
>  tests/tracetool/syslog.c      |  2 --
>  tests/tracetool/syslog.h      |  6 ++---
>  tests/tracetool/ust.c         |  2 --
>  tests/tracetool/ust.h         |  2 --
>  trace/control-internal.h      |  6 -----
>  trace/control-target.c        |  2 --
>  trace/control.c               |  9 -------
>  trace/control.h               | 27 +++-----------------
>  trace/event-internal.h        |  2 --
>  trace/qmp.c                   | 47 ++++++++++-------------------------
>  25 files changed, 31 insertions(+), 132 deletions(-)
>
> diff --git a/qapi/trace.json b/qapi/trace.json
> index 29c76256055c..8533e3789774 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -16,8 +16,6 @@
>  # @TraceEventState:
>  #     State of a tracing event.
>  #
> -# @unavailable: The event is statically disabled.
> -#
>  # @disabled: The event is dynamically disabled.
>  #
>  # @enabled: The event is dynamically enabled.
> @@ -25,7 +23,7 @@
>  # Since: 2.2
>  ##
>  { 'enum': 'TraceEventState',
> -  'data': ['unavailable', 'disabled', 'enabled'] }
> +  'data': ['disabled', 'enabled'] }

We may want to keep the field with 'features': ['deprecated'] for a while
to avoid downstream schema users breakage.

>  
>  ##
>  # @TraceEventInfo:
> @@ -69,6 +67,7 @@
>  # @enable: Whether to enable tracing.
>  #
>  # @ignore-unavailable: Do not match unavailable events with @name.
> +#      Deprecated: since 11.2

Similarly,

    '*ignore-unavailable': { 'type': 'bool', 'features': [ 'deprecated' ] }

and add the deprecation to docs/about/deprecated.rst.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


