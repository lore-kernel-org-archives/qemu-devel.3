Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB86DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXcz5-0004Jx-Pz; Wed, 07 Feb 2024 03:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXcz3-0004JV-S4
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXcz2-00043E-Bl
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707293319;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itazZlbT4t/+5cfUCcolpNRtnLhzVuaU9uEanmqp/T4=;
 b=D47HNIC61SrnCYNYEUdBuY69Vu3S/h/na4hxk1Y2rhYNRPoNo/tEfKaaG+HDu2K3odnThl
 LDpnDSuexHxkAR9PApthU1mJiTkzmQcHBMmccFE7VS+99Ut2EcnwOoJ36wfZ3jQZm6ZZ+w
 +t0BgXtKe2TjzckuIwRjGDKFK1iiRbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-TzX3iSVSMgubAsz8tT8ymw-1; Wed, 07 Feb 2024 03:08:36 -0500
X-MC-Unique: TzX3iSVSMgubAsz8tT8ymw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1950D83FC23;
 Wed,  7 Feb 2024 08:08:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E581A2026D06;
 Wed,  7 Feb 2024 08:08:34 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:08:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] qemu-nbd: mention --tls-hostname option in
 qemu-nbd --help
Message-ID: <ZcM6gBJ4yQhrbMbr@redhat.com>
References: <20240207073231.271198-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207073231.271198-1-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 10:32:31AM +0300, Michael Tokarev wrote:
> This option was not documented.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1240
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index bac0b5e3ec..d7b3ccab21 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -114,6 +114,7 @@ static void usage(const char *name)
>  "  --tls-creds=ID            use id of an earlier --object to provide TLS\n"
>  "  --tls-authz=ID            use id of an earlier --object to provide\n"
>  "                            authorization\n"
> +"  --tls-hostname=HOSTNAME   override hostname used to check x509 certificate\n"
>  "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
>  "                            specify tracing options\n"
>  "  --fork                    fork off the server process and exit the parent\n"

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


