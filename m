Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FDFCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgHG-0003Ry-WD; Wed, 03 Sep 2025 01:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgH4-0003NQ-O9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgH2-0001IS-TM
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756878192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgqsI75Hl0hW/NIjUWACLG264Jdi2gE2F1X4FOrybOY=;
 b=SP2OwKhXAvLZsUqLq+Z1ER/Fv5BoIbX8KeDt68L5xht9xfTNzVsJPm/eBJu7Hs5Xl6YjFE
 PgTGybdrU7i5sxEi8hFOPWEg4bGLKeWlTQMg8eL0eBWf+Rxtdbw4dnHdhf+jnlsGOdYOa8
 3EUZt0qwecE4AzYVNCPQmlTjpYr6jGk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-gxSIDFKwOhWL9bH40sZieQ-1; Wed, 03 Sep 2025 01:43:10 -0400
X-MC-Unique: gxSIDFKwOhWL9bH40sZieQ-1
X-Mimecast-MFC-AGG-ID: gxSIDFKwOhWL9bH40sZieQ_1756878189
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24b2336e513so17813015ad.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756878189; x=1757482989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgqsI75Hl0hW/NIjUWACLG264Jdi2gE2F1X4FOrybOY=;
 b=A9xrFV6iE4uFDEHz3nxYU+QfX2+88gzhqCK25eDnK7TWgn+CbE4N8ItLKEz52UeKcy
 UycbuDNZpaW9cpnrxBFKlawjQOiOlLb4T10jC+NjXOKxAWTYz+lb8QwGrtb8huRfUTVj
 LBoi843ufA7RJ1aeKtx8wM7KK/RODzJqHcOwcp1uU4w4tOxq7FAJ5mtKw73QFiWTlsPP
 R9rNuteqssqHAihFG3k//aOndbjokJssDa606DiMdWCLpBDtloJrrEXYC8NYEx3llIda
 5x93PDglb9FqKvKjVCzcDagovlUOdGGUaRSeI2Nx5QdXaoi1rmKiag2btA+uOrQvl6b5
 w/6A==
X-Gm-Message-State: AOJu0Yz+6X+3Hp10zlRDb76QBQSri4ZnFoj7sWmwASytLXlA/uyEIi6D
 zxgxuBS99hXO7OPtg2g455H034+MR/hbbPlhPz6yyBY/9+JgDYGlhXTGPKEwDfUzasnWXOB2+Ih
 YBpcY5/PncMXFkqhwPMvAvBeH/B6XhNj0CIcvg1vof4wHM1OvlJlqM+k1tqa9r6+L26B+ue1+2B
 Q00owbUF3t6mj/57w+NN+qvrQGe99G/cw=
X-Gm-Gg: ASbGncs8KjGIiKEps8ffY9p6jiGjVAA4EoX+dtA8QbgnWTd9KLa8ZHxfAoQ0j1PClqV
 MzBcjvSbyAj6nPBBp+CuUki7haMF+RNMZwnbRdFBdQW3p0puI/nFKXoqkyL7An4WtjVxjuYT26A
 j+Xd//JWomxU2YfNKLp6Gc6w==
X-Received: by 2002:a17:903:4b46:b0:240:48f4:40f7 with SMTP id
 d9443c01a7336-24944b29c03mr201973085ad.39.1756878189326; 
 Tue, 02 Sep 2025 22:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNPl9pHtGuHQ9xK7Yl3mwjeG04mEaBQ1oiEZ0io34um5H3KOC9wiOfJ5Ro+WPh+00QnSU2oL6h8gGULQa61us=
X-Received: by 2002:a17:903:4b46:b0:240:48f4:40f7 with SMTP id
 d9443c01a7336-24944b29c03mr201972915ad.39.1756878188917; Tue, 02 Sep 2025
 22:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250821142641.359132-1-jonah.palmer@oracle.com>
In-Reply-To: <20250821142641.359132-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 13:42:57 +0800
X-Gm-Features: Ac12FXygeeP4TIPmr5l8dS18luaHNxNZyTMEGIxEFY9DdLkEwShIhR5SF2q3hi8
Message-ID: <CACGkMEtT-28W3Q1fgK0+n+r_9=s3MuteJHzSNC1pib6wnbVudQ@mail.gmail.com>
Subject: Re: [PATCH] net/hub: make net_hub_port_cleanup idempotent
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, leiyang@redhat.com, 
 dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 21, 2025 at 10:28=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
> Makes the net_hub_port_cleanup function idempotent to avoid double
> removals by guarding its QLIST_REMOVE with a flag.
>
> When using a Xen networking device with hubport backends, e.g.:
>
> -accel kvm,xen-version=3D0x40011
> -netdev hubport,...
> -device xen-net-device,...
>
> the shutdown order starts with net_cleanup, which walks the list and
> deletes netdevs (including hubports). Then Xen's xen_device_unrealize is
> called, which eventually leads to a second net_hub_port_cleanup call,
> resulting in a segfault.
>
> Fixes: e7891c57 ("net: move backend cleanup to NIC cleanup")
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Queued.

Thanks


