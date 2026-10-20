Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACE606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EEqSseAg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJGAC-0003YY-0T; Tue, 20 Oct 2026 16:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xJGA4-0003Y7-Qt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xJGA2-0003RN-8v
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792527011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hhIyaLIcl8Xy745Pnl8egrhPkXAAwrTgXDgkC0t7wo=;
 b=EEqSseAg4iTlNlV4xCUbEYxzvhpW29mVoxtoh8bf+5ByBPPwSJ3004iEf7RNP2Bxe1WgAg
 QJZsBKA8hcReW5fG/AZSdbHzOm4rscWZJNbaM/KWsswzPGtg001t0qH7vOASGheSgqq46s
 3Ivvyj8+20AGQoo2hr/1AyNGmOcbec0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-46fn42MiMouyWqH9dG1GkA-1; Tue,
 20 Oct 2026 20:10:08 +0000
X-MC-Unique: 46fn42MiMouyWqH9dG1GkA-1
X-Mimecast-MFC-AGG-ID: 46fn42MiMouyWqH9dG1GkA_1792527007
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53CE3195605F; Tue, 20 Oct 2026 20:10:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C4121956095; Tue, 20 Oct 2026 20:10:06 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:10:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 23/24] trace: remove parsing of "disable" event property
Message-ID: <20261020201005.GB20810@shajnocz.csb>
References: <20261005120855.421973-1-berrange@redhat.com>
 <20261005120855.421973-24-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005120855.421973-24-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 01:08:54PM +0100, Daniel P. Berrangé wrote:
> diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
> index f4557ee20e4..f94063587fa 100644
> --- a/docs/devel/tracing.rst
> +++ b/docs/devel/tracing.rst
> @@ -366,30 +366,14 @@ To facilitate simple usage of systemtap where there merely needs to be printf
>  logging of certain probes, a helper script "qemu-trace-stap" is provided.
>  Consult its manual page for guidance on its usage.
>  
> -Trace event properties
> +Trace event conditions
>  ======================
>  
> -Each event in the "trace-events-all" file can be prefixed with a space-separated
> -list of zero or more of the following event properties.
> -
> -"disable"
> ----------
> -
> -If a specific trace event is going to be invoked a huge number of times, this
> -might have a noticeable performance impact even when the event is
> -programmatically disabled.
> -
> -In this case you should declare such event with the "disable" property. This
> -will effectively disable the event at compile time (by using the "nop" backend),
> -thus having no performance impact at all on regular builds (i.e., unless you
> -edit the "trace-events-all" file).
> -
> -In addition, there might be cases where relatively complex computations must be
> +There might be cases where relatively complex computations must be
>  performed to generate values that are only used as arguments for a trace
>  function. In these cases you can use 'trace_event_get_state_backends()' to
> -guard such computations, so they are skipped if the event has been either
> -compile-time disabled or run-time disabled. If the event is compile-time
> -disabled, this check will have no performance impact.
> +guard such computations, so they are skipped if the event is not currently
> +enabled:
>  
>  ::
>  

The nop tracer section still mentions the disable property:

  Nop
  ---
  
  The "nop" backend generates empty trace event functions so that the compiler
  can optimize out trace events completely.  This imposes no performance
  penalty.
  
  Note that regardless of the selected trace backend, events with the "disable"
  property will be generated with the "nop" backend.

There are also doc comments in trace/control.h that still mention the
disable property:

  /**
   * trace_event_get_state_backends:
   * @id: Event identifier name.
   *
   * Get the tracing state of an event from all
   * compiled-in backends.
   *
   * If the event has the disabled property, the check will have no performance
   * impact.
   *
   * Returns: true if at least one backend has the event enabled and the event
   * does not have the disabled property.
   */


