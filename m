Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95314CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBNV-0001cC-2g; Wed, 12 Nov 2025 08:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJBNS-0001aG-OF
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:59:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJBNP-000458-HX
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762955949;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhhxbzefCBFKZEWYZUYFwHIjSoVhIMCNu5aEwTx0EB4=;
 b=cpn6oU5NxTBZaTMCx0x2vQ7T7BtduKBAtBg48DoApaJYFw2KfXv5TPP1Wiu6vl7W/G0Q8B
 5mZ8zcY8bOmjUVkjMQVfA97yR5sqvWPrl6wq3EkgCkWCcE49E4+0J9wotfZAEMb4slEVAK
 zADPApNhiG7Bl3HuSNMchIEJArEPD6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-REgiiMrmPzSsbMkp7A2JyA-1; Wed,
 12 Nov 2025 08:59:05 -0500
X-MC-Unique: REgiiMrmPzSsbMkp7A2JyA-1
X-Mimecast-MFC-AGG-ID: REgiiMrmPzSsbMkp7A2JyA_1762955944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C4D180009D; Wed, 12 Nov 2025 13:59:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 587D019560BC; Wed, 12 Nov 2025 13:59:02 +0000 (UTC)
Date: Wed, 12 Nov 2025 13:58:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 01/10] chardev/char-fe: Improve @docstrings
Message-ID: <aRSSo9Pxe7c9-ZAh@redhat.com>
References: <20251112134143.27194-1-philmd@linaro.org>
 <20251112134143.27194-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112134143.27194-2-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 12, 2025 at 02:41:34PM +0100, Philippe Mathieu-Daudé wrote:
> Describe the @c (this is the *frontend*) and @s (the *backend*)
> parameters. Fill qemu_chr_fe_[gs]et_msgfds() method docstrings.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/chardev/char-fe.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 5f8a6df17dc..36bcf1f88a6 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h

>  
>  /**
>   * qemu_chr_fe_get_msgfd:
> + * @c: the character frontend to access
>   *
>   * For backends capable of fd passing, return the latest file descriptor passed
>   * by a client.
> @@ -286,9 +302,12 @@ int qemu_chr_fe_get_msgfd(CharFrontend *c);

We should note here that if there is more than 1 pending FD,
all except the first pending FD will be closed

>  
>  /**
>   * qemu_chr_fe_get_msgfds:
> + * @c: the character frontend
> + * @fds: an array of ancillary file descriptors to get
> + * @num: the maximum number of ancillary file descriptors to get in @fds
>   *
>   * For backends capable of fd passing, return the number of file received
> - * descriptors and fills the fds array up to num elements
> + * descriptors and fills the fds array up to @num elements

Here we should note that if there are more pending FDs than @num,
then all further FDs will be closed.

>   *
>   * Returns: -1 if fd passing isn't supported or there are no pending file
>   *          descriptors.  If file descriptors are returned, subsequent calls to

Those are minor changes, so consider this tohave

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


