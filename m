Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5621FE5205
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDqS-0008E1-EB; Fri, 24 Apr 2026 06:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wGDqR-0008DX-1J
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wGDqP-0008QD-Er
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777026788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/23mnfMfqzJeZ8cWu76P0yAPF56uKl4A/ka3wR5nlzc=;
 b=Lqa5IEgxovcMfbHkg/lpaBZ1vBjuGWoVF1eWrMWSuu2uZyB4TdLofT7XjKCK7py6BlaO0A
 QNulCnRNQBdckmfWqZ/4eaJXNh6GZsxjT8vsBthPLpADSbuh6zOtPHJUmZylcLkyclf480
 zouxb9kZ+jap9cRBWl60LuuZpizFiak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-MY8MJ2LxM9KRIk2ISJ0BFQ-1; Fri, 24 Apr 2026 06:33:06 -0400
X-MC-Unique: MY8MJ2LxM9KRIk2ISJ0BFQ-1
X-Mimecast-MFC-AGG-ID: MY8MJ2LxM9KRIk2ISJ0BFQ_1777026786
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4891f97aef0so31038275e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777026785; x=1777631585; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/23mnfMfqzJeZ8cWu76P0yAPF56uKl4A/ka3wR5nlzc=;
 b=OPPCYIlAdQgBipypgkw9831PI/YNhwh6SdYpLByKfrlz/bwn3AX4Xeu+fYZWXv4pm2
 S1uVUmuIYUrkQ5kPGF50lGF7NWEDcgoeLHfjvi1vuTd9oVe6yxfmYLw4cJKjnTVtxDRo
 X52jX3ACOoKD0+94LLLndynRR4e80QKk8wDiDtApJY23zX5YajL9SV67u0ugnWWAf3T9
 hGQ5B7DdAn6O+4pz3+TFDVLltoDua3GiIFN4nRPg3AgPf6WpMJ7Dai62DRJWoOgxozmC
 R3kGwpgj8yDyEZG2vXKW2DkqouiAZEaXNwbnBHOBxGk1pxjBQJo6T2tbyOqA7rDc7LLl
 dt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026785; x=1777631585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/23mnfMfqzJeZ8cWu76P0yAPF56uKl4A/ka3wR5nlzc=;
 b=ggjRuJrb6wMbLUnxHrk3ET4uKSoWTMv3HFJAJtxj6mK5QPtStl0xqiROBWP27G1QUs
 XLikjmDRY5DSB0uFq9o7ZybvCHwgMr38FmHDQmUIhBORA9nHqycpxm+8BPS7UV3or4Dd
 TXEpVJIYNMTeFDeZJJKVuOmE9fPxoDBCi0zvuabAdG3AUUpSnDRfMoNpNxjqDYTqESrY
 GEPqgpJ7O9h+unqmpLi9CfI5pfTlPMwQqlk1vx2wpvNEGnqVo4mmPg6OA35UQQp7rs63
 EQMCBFjD1/aE42D2nQHkBZWRJ3MdZiuANH6i/4UxajEKYRJvvwNtmZ/b8M83Zb7lELGt
 jmGw==
X-Gm-Message-State: AOJu0YzLzG7cb9IDdPbr2CWgIEkZYbtQWHN6q2RXTBhc3vnPVYrSjkuv
 lIaGTzUiqJ39eRHXA+UQE3/melqCCP19nN3NXc0CZwuyKEJisyHawFdJordYrCMZ6z8TbaWEbiv
 A7qpwvvcF6RVeXMzFUxujb/NCOvXYfADR0BN9M/axeiyEwTIsSZ01Bja/
X-Gm-Gg: AeBDiesn1oA0a1NOVz3cMM/aJ8VJ1cBSMSrDvmI+MxFLXoLFX8o8P/bRZTroTXtzsJa
 z4VXL8CAgDUN1JVaeuronFOga3M68FRg9QTc6f2WC88S+EUPJxOiVbYGjcKZqCEctcsf8adl1jl
 CajZqrSZxGZ8i2/sqTLPmAXz++DbJ8Qw5n4UjM21TgRpOpkePnVKlOVpLO7uDWFR8QgtdNfzs64
 co6aPb75oVIFW9hLf2m1rLKtBWi53bCJe+43SQ3P6KspX/y7xDWElQHDbHkOD1d9LLmYP74Q/Gk
 uaBMPa9HFhjZzpqgKsV1ZcYeAV0U+ppVYK724ACCxOjwal2lhi4xvTesZU/v2pJhMqT57dJ3gpO
 roPJqeE0GB26L
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-4891ff176bamr318167615e9.1.1777026785494; 
 Fri, 24 Apr 2026 03:33:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-4891ff176bamr318167155e9.1.1777026785085; 
 Fri, 24 Apr 2026 03:33:05 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7bf7besm207800005e9.34.2026.04.24.03.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:33:04 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:33:02 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Pranav Tyagi <prtyagi@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
Message-ID: <aetGyqrqEdz2dLnc@fedora>
References: <20260423094438.43556-1-prtyagi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423094438.43556-1-prtyagi@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-04-23 15:14, Pranav Tyagi wrote:
> The package_loaded event is not set in case MIG_RP_MSG_PONG does not
> arrive on the source from the destination in the return path thread. The
> migration thread would then be blocked waiting for package_loaded event
> indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition the
> source VM can safely resume as the destination has not yet started. The
> pong message can get lost in case of a network failure or destination
> crash before sending the pong.
> 
> This patch removes the package_loaded event and uses rp_sem, instead of
> kicking multiple events. The error is detected in case of network
> failure or destination crash and rp_sem is set in the out path of the
> return path thread. This will kick the migration thread out from a
> condition of indefinitely waiting for rp_sem. The migration thread then
> fails early and breaks from the migration loop to resume the vm on the
> source side.
> 
> Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
> Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>
> ---
> V1: https://lore.kernel.org/all/20260421052227.8278-1-prtyagi@redhat.com/
> 
> changed in v2:
> - removed postcopy_package_loaded_event and using rp_sem to kick the
>   migration thread
> - using migration_rp_wait() in place of qemu_event_wait() in the
>   migration thread
> 
>  migration/migration.c | 48 ++++++++++++++++++++++++++++---------------
>  migration/migration.h |  1 -
>  2 files changed, 31 insertions(+), 18 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


