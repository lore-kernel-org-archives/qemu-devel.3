Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A58C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXb6N-00019Z-Sa; Wed, 07 Feb 2024 01:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXb6M-00018I-Ff
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXb6J-0005yu-GK
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707286081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvMk/nR076oYUpJt3eveUCLpEqmFcLjetPknaalpizg=;
 b=MFS7M0pmwmoGqhkYjJ6kaIQUt3kxzXCf+InFYBp+09gfgwPUQawg6FgrJSaTdXGEqfasSL
 Olxs6B+CeJ/udXOZ1RQ+TtltWmENr3WXDjDYFdowismH+mc6Z3t1vQOryUDuz0XVDSM5j3
 gEtxQXIjBDVgzs3XhtADNjZL8v/Xhk8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399--SlGUxYtMg2gPcd2bILfvw-1; Wed,
 07 Feb 2024 01:08:00 -0500
X-MC-Unique: -SlGUxYtMg2gPcd2bILfvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2534D2812FE3;
 Wed,  7 Feb 2024 06:08:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B760CC07F51;
 Wed,  7 Feb 2024 06:07:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C116921E66D0; Wed,  7 Feb 2024 07:07:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi/migration: Add missing tls-authz documentation
In-Reply-To: <20240207032836.268183-1-peterx@redhat.com> (peterx@redhat.com's
 message of "Wed, 7 Feb 2024 11:28:36 +0800")
References: <20240207032836.268183-1-peterx@redhat.com>
Date: Wed, 07 Feb 2024 07:07:58 +0100
Message-ID: <877cjgx0w1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> As reported in Markus's recent enforcement series on qapi doc [1], we
> accidentally miss one entry for tls-authz.  Add it.  Then we can drop
> @MigrateSetParameters from documentation-exceptions safely later.
>
> [1] https://lore.kernel.org/r/20240205074709.3613229-1-armbru@redhat.com
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 819708321d..f4c5f59e01 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -980,6 +980,10 @@
>  #     2.9) Previously (since 2.7), this was reported by omitting
>  #     tls-hostname instead.
>  #
> +# @tls-authz: ID of the 'authz' object subclass that provides access
> +#     control checking of the TLS x509 certificate distinguished name.
> +#     (Since 4.0)
> +#
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
>  #

Reviewed-by: Markus Armbruster <armbru@redhat.com>

I propose I queue this right after [1] with the update to pragma.json
squashed in (appended), and the sentence "Then we can drop ... later"
dropped.

Thanks for your help!


diff --git a/qapi/pragma.json b/qapi/pragma.json
index 7ac05ccc26..6929ab776e 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -69,7 +69,6 @@
         'JSONType',
         'KeyValueKind',
         'MemoryDeviceInfoKind',
-        'MigrateSetParameters',
         'NetClientDriver',
         'ObjectType',
         'PciMemoryRegion',


