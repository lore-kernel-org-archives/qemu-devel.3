Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A90CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENkc-0001Jp-Fm; Wed, 07 Oct 2026 05:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xELtS-00005n-JK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xELtP-0007Z3-1S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791357403;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+59H1acN0PHgUcGLHfpWLwOXLXsXzvIDUNX4rGNgPM=;
 b=KDx8GSZq5djD8iLwoNgZYlWlHXtMpQ5el5s+L9g4FIaDMSt/F02z+dcV5vjdZH4Bd2QsJG
 LGCa74Tj0TBFAUv6uA0YwUEFbkm8xYgXMhvdIb6FS6khsqhs1NjPW4x1zllYAjPvardD6/
 u52mE/sWg1yBEcIuwaGgmgHmHi4u77c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-94DEfPhUPK2MnJjRjhNJsA-1; Wed,
 7 Oct 2026 07:16:40 +0000
X-MC-Unique: 94DEfPhUPK2MnJjRjhNJsA-1
X-Mimecast-MFC-AGG-ID: 94DEfPhUPK2MnJjRjhNJsA_1791357399
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 319731977402; Wed,  7 Oct 2026 07:16:39 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC9C1956087; Wed,  7 Oct 2026 07:16:37 +0000 (UTC)
Date: Wed, 7 Oct 2026 08:16:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hector Cao <hector.cao@canonical.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PATCH] util/coroutine: trim sysctl's max_map_count newline
 before parsing
Message-ID: <asXx0kf7O0nOsBCX@redhat.com>
References: <20261006232018.211749-1-hector.cao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006232018.211749-1-hector.cao@canonical.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 07, 2026 at 01:20:18AM +0200, Hector Cao wrote:
> Strip trailing whitespace from max_map_count before passing it to
> qemu_strtoi(), allowing the strict full-string parse to succeed.
> Otherwise, qemu_strtoi() fails to parse the string and returns -22,
> making the global cache pool cap size set to UINT_MAX.
> 
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Signed-off-by: Hector Cao <hector.cao@canonical.com>
> ---
>  util/qemu-coroutine.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index d17135f585a..5af61995437 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
>       * VMAs.
>       */
>      if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> -                            NULL) &&
> -        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> +                            NULL)) {
> +        /* contents has trailing newline, remove it before conversion */
> +        g_strchomp(contents);
> +        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
> +            return UINT_MAX;
> +        }
>          /*
>           * This is an upper bound that avoids exceeding max_map_count. Leave a
>           * fixed amount for non-coroutine users like library dependencies,

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


