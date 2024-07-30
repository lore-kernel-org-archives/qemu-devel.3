Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAC6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 12:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYliB-0005RB-8u; Tue, 30 Jul 2024 08:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYlhv-0005Nv-Iz
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:12:07 -0400
Received: from [170.10.133.124] (helo=us-smtp-delivery-124.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYlhM-0002UH-R0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722341401;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lEWZXIbOPxifRh0tCzGglZf0QAJzKMvIhLQ4RwqE1wU=;
 b=boxJsq6eOKrOAlSYup21GSQjlUXrpxopYmTdcbXgUUfzDRoiQAc4xep+iICR49uH0zu4b4
 ttJ8ZZx+wfst1qnZ3rLgLkvdBVqWo04bJVTdGF+xsIqjLXnqaq9xMS4w9OUx10l8gvuZy8
 0fIfZyk6kp8MrWH1C2btm89YxifQprw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-gBuobwmsNuq-ys-xk9V9Vg-1; Tue,
 30 Jul 2024 08:01:51 -0400
X-MC-Unique: gBuobwmsNuq-ys-xk9V9Vg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D8ED1955D47; Tue, 30 Jul 2024 12:01:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1B5300018D; Tue, 30 Jul 2024 12:01:48 +0000 (UTC)
Date: Tue, 30 Jul 2024 13:01:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: luzhipeng <luzhipeng@cestc.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] sm4:Adjust the naming of SM4 encryption method
Message-ID: <ZqjWKbiGcIM96DdO@redhat.com>
References: <20240730113850.30-1-luzhipeng@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730113850.30-1-luzhipeng@cestc.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Host-Lookup-Failed: Reverse DNS lookup failed for 170.10.133.124 (deferred)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jul 30, 2024 at 07:38:50PM +0800, luzhipeng wrote:
> With reference to the naming conventions of other encryption algorithms,
> the name of SM4 is modified.So libvirt and qemu are compatible.
> 
> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
> ---
>  crypto/block-luks.c             | 2 +-
>  crypto/cipher-gcrypt.c.inc      | 4 ++--
>  crypto/cipher-nettle.c.inc      | 4 ++--
>  crypto/cipher.c                 | 4 ++--
>  qapi/crypto.json                | 4 ++--
>  tests/unit/test-crypto-cipher.c | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index e102be337b..1a28e312d8 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -94,7 +94,7 @@
>  #
>  # @twofish-256: Twofish with 256 bit / 32 byte keys
>  #
> -# @sm4: SM4 with 128 bit / 16 byte keys (since 9.0)
> +# @sm4-128: SM4 with 128 bit / 16 byte keys (since 9.0)
>  #
>  # Since: 2.6
>  ##
> @@ -105,7 +105,7 @@
>             'cast5-128',
>             'serpent-128', 'serpent-192', 'serpent-256',
>             'twofish-128', 'twofish-192', 'twofish-256',
> -           'sm4']}
> +           'sm4-128']}

This rename isn't permitted, as 'sm4' was already exposed as public API
in the 9.0 release and thus this would break backwards compatibility.

I agree it would have been nice to call it 'sm4-128' and I dropped the
ball by not suggesting a rename when this was first proposed. At this
point though, I don't think  we need to go through the many release
dance of deprecating the old name & introducing a new name & finally
removing the old name, since IIUC, SM4 is always 128 bits in size.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


