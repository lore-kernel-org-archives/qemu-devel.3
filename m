Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482C606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5ADfDQG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdnV-0004Oi-J8; Wed, 21 Oct 2026 17:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xJdnO-0004ON-1j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xJdnL-0002Ma-JZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792617861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUb02Z2NBUxpKMKJUXU4FIXxAdoJgO9oyRJRXB+kNb0=;
 b=f5ADfDQG+yCM6vC9EHrrbUDHis+FxODnkiLH9EktFQ4Rk3fxJ15Cve4uKopNBWO9DaG7df
 Etx3OA8aVOm8L+d5gaKgWHxF+WkVuAWSXBIceOaPWaAaJuI+66gJDpYNFIrePjNsC9EfZk
 zyHK/mQSm5pvg6y3g225dLwnwvVJAEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-pjiRiZTjOj6nbDjG7Mmnig-1; Wed,
 21 Oct 2026 21:24:19 +0000
X-MC-Unique: pjiRiZTjOj6nbDjG7Mmnig-1
X-Mimecast-MFC-AGG-ID: pjiRiZTjOj6nbDjG7Mmnig_1792617858
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9389018001F3; Wed, 21 Oct 2026 21:24:18 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 283DA30000E3; Wed, 21 Oct 2026 21:24:16 +0000 (UTC)
Date: Wed, 21 Oct 2026 16:24:13 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 01/24] osdep: add 'ignore_value(x)' macro
Message-ID: <atksbyXRvfjoJ8SL@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
 <20261005120855.421973-2-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005120855.421973-2-berrange@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 01:08:32PM +0100, Daniel P. Berrangé wrote:
> Functions annotated with 'warn_unused_result' cannot be cast
> to (void) to silence the compiler. Add the ignore_value()
> macro which tricks the compiler into thinking the result is
> genuinely used, avoiding the need for manual workarounds where
> the return value is intentionally ignored.
> 
> This clever macro is derived from one originating with the
> GNULIB project:
> 
>   https://gitweb.git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob;f=lib/ignore-value.h;hb=HEAD

Hey, I recognize that :) (See gnulib commit 939dedd9a2 where I
switched from an inline static function to use of __typeof__ 15 years
ago)

> 
> but simplified since we don't need compat with old GCC and
> optimizing on clang is overkill.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
>  include/qemu/osdep.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1ec5b42230b..c1ca2c127b6 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -251,6 +251,14 @@ extern "C" {
>  #endif
>  
>  
> +/*
> + * Merely casting to (void) is not sufficient for functions
> + * annotated with the "warn_unused_result" attribute
> + */
> +#define ignore_value(x) \
> +    (__extension__ ({ __typeof__(x) __x = (x); (void) __x; }))
> +
> +
>  /*
>   * For mingw, as of v6.0.0, the function implementing the assert macro is
>   * not marked as noreturn, so the compiler cannot delete code following an
> -- 
> 2.55.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


