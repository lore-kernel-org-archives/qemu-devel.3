Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE29D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0yK-00039H-Ak; Wed, 14 Jan 2026 08:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg0yA-00037b-Vn
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:31:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg0y8-0008UK-2A
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768397486;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCxX7A2olBTxr5muMVj3R1I9DXqoiz6hJYGPso0sLWQ=;
 b=DdrKaunlW0KQljXICnZsYag/PUrsLpLXAx+8TyycLBpRVVIvrxJQxcFvtOmqSdzjN4yWt7
 caWMGejaVMA11H1Jl1o35R42vACT4XJLlFsG8NzB9u2i/nD6mXAyEA4uuxeP48fUVU8YKU
 V4DHVxY1AUQyvKG2leOcDpNxbq8YgzE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-HoMbf6grOwWnwFUcXeudoQ-1; Wed,
 14 Jan 2026 08:31:25 -0500
X-MC-Unique: HoMbf6grOwWnwFUcXeudoQ-1
X-Mimecast-MFC-AGG-ID: HoMbf6grOwWnwFUcXeudoQ_1768397484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D29195608F; Wed, 14 Jan 2026 13:31:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8688018007D2; Wed, 14 Jan 2026 13:31:22 +0000 (UTC)
Date: Wed, 14 Jan 2026 13:31:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org
Subject: Re: [PATCH 3/3] qemu-print: Document qemu_fprintf(), qemu_vfprintf()
 failure
Message-ID: <aWeapyd1vGXBEQvM@redhat.com>
References: <20260114124713.3308719-1-armbru@redhat.com>
 <20260114124713.3308719-4-armbru@redhat.com>
 <aWeS5wvUBU5FCKSI@redhat.com> <aWeU3soopEhPEQxN@redhat.com>
 <87o6mw1g86.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6mw1g86.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 14, 2026 at 02:22:33PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jan 14, 2026 at 12:58:15PM +0000, Daniel P. Berrangé wrote:
> >> On Wed, Jan 14, 2026 at 01:47:13PM +0100, Markus Armbruster wrote:
> >> > These functions fail when @stream is null and the current monitor
> >> > isn't HMP.
> >> > 
> >> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> > ---
> >> >  util/qemu-print.c | 2 ++
> >> >  1 file changed, 2 insertions(+)
> >> > 
> >> > diff --git a/util/qemu-print.c b/util/qemu-print.c
> >> > index 4a30cd1a8e..bbf8c1823e 100644
> >> > --- a/util/qemu-print.c
> >> > +++ b/util/qemu-print.c
> >> > @@ -45,6 +45,7 @@ int qemu_printf(const char *fmt, ...)
> >> >  /*
> >> >   * Print like vfprintf()
> >> >   * Print to @stream if non-null, else to current monitor.
> >> > + * Beware: the latter fails unless we have one and it is HMP.
> >> 
> >> This leaves me curious what 'fails' means. In this case no
> >> output is printed and the func returns -1.
> >> 
> >> How about we rephrase to match the other method docs better
> >> 
> >>  * Print to current HMP monitor if we have one, else to @stream
> >>    if non-null, else returns -1
> >
> > Opps, no, wrong semantics.
> >
> >   * Print to @stream if non-null, else to current HMP monitor if
> >     we have one, else returns -1
> 
> Yes, that's better.  What about:
> 
>     * Print to @stream if non-null, else to current HMP monitor if we
>     * have one, else fail without printing anything.
>     * Return number of characters printed on success, negative value on
>     * error.

Works for me, I'll incorporate it when adding these patches to my series.

> 
> >> >   */
> >> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >> >  {
> >> > @@ -57,6 +58,7 @@ int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >> >  /*
> >> >   * Print like fprintf().
> >> >   * Print to @stream if non-null, else to current monitor.
> >> > + * Beware: the latter fails unless we have one and it is HMP.
> >> >   */
> >> >  int qemu_fprintf(FILE *stream, const char *fmt, ...)
> >> >  {
> >> > -- 
> >> > 2.52.0

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


