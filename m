Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60527C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPXv-0005zE-IH; Fri, 07 Feb 2025 09:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgPXu-0005yl-Cz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tgPXs-0005vP-FF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2m65aXf9AE4eQJzeBRPp9Cz2d5IcpYvNMI9HaRTmYw=;
 b=ctRnq8qUUrkJTCRW7ajMn4teDIXtmKdU2HvoBfEIUsC4nb3knYA3MLaTN4cpYKF/MTRkvH
 /XCWl17Q/qFoQAHpvKNlfIB3yDqwtXOsrgKLFcQCqYQynXSxkcNGm74W0YEFrH1TDzkPFL
 5Q4EkDXiJqEKN6N/xAY8OhU4JTcpXzY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-x_QtCheIOPe7iBxiz9z2Ng-1; Fri,
 07 Feb 2025 09:41:25 -0500
X-MC-Unique: x_QtCheIOPe7iBxiz9z2Ng-1
X-Mimecast-MFC-AGG-ID: x_QtCheIOPe7iBxiz9z2Ng
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FB5518009A9; Fri,  7 Feb 2025 14:41:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2F713001D14; Fri,  7 Feb 2025 14:41:21 +0000 (UTC)
Date: Fri, 7 Feb 2025 14:41:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 5/8] crypto: Remove
 qcrypto_tls_session_get_handshake_status
Message-ID: <Z6YbjrOCu3VvfvXp@redhat.com>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207142758.6936-6-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 07, 2025 at 11:27:55AM -0300, Fabiano Rosas wrote:
> The correct way of calling qcrypto_tls_session_handshake() requires
> calling qcrypto_tls_session_get_handshake_status() right after it so
> there's no reason to have a separate method.
> 
> Refactor qcrypto_tls_session_handshake() to inform the status in its
> own return value and alter the callers accordingly.
> 
> No functional change.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  crypto/tlssession.c                 | 64 +++++++++++------------------
>  include/crypto/tlssession.h         | 32 ++++-----------
>  io/channel-tls.c                    |  7 ++--
>  tests/unit/test-crypto-tlssession.c | 12 ++----
>  4 files changed, 39 insertions(+), 76 deletions(-)
> 
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> @@ -720,14 +710,6 @@ qcrypto_tls_session_check_pending(QCryptoTLSSession *session)
>  int
>  qcrypto_tls_session_handshake(QCryptoTLSSession *sess,
>                                Error **errp)
> -{
> -    error_setg(errp, "TLS requires GNUTLS support");
> -    return -1;
> -}
> -

This codepath is the !GNUTLS branch, so we need to continue
reporting an error here, not return QCRYPTO_TLS_HANDSHAKE_COMPLETE.

> -
> -QCryptoTLSSessionHandshakeStatus
> -qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess)
>  {
>      return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
>  }


With that small change made

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


