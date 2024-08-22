Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E15C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shA5I-00046A-QW; Thu, 22 Aug 2024 11:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shA5E-00044Q-5h
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shA5B-0002Uv-Re
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724341840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUDfxI1yA73uywHxKdLRwgYfR/mo3Nvoc8DDpoo2L14=;
 b=Bkkd6uC7iEprzvGN6+q7cde7Weer5BpSxFgHHx7kNHxIF9w6WWBugk1Ax0TucG7mgHsD75
 I3Ut7oHt3bjuwFEabaUwa1dngdS0qKEatHEkl5D6y1F8isKeMHydlsoSBWovvtiNLynf/t
 g9+Zxwy4185TAcSHvsKLtEYu4n8HMpQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-4VLeF_peN2aL_WNYkcun7g-1; Thu, 22 Aug 2024 11:50:38 -0400
X-MC-Unique: 4VLeF_peN2aL_WNYkcun7g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4500d2fe009so16984751cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724341837; x=1724946637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUDfxI1yA73uywHxKdLRwgYfR/mo3Nvoc8DDpoo2L14=;
 b=CgQ3dVTQuJdV1A/OPO2Jj4GwcFsI15mnRMbkunI1RM6DQ912dJtkog+iQkkRvj2pBv
 GCSHHSJhIX/0RkUOk1DAHxP/3MTJc1hRhzsb0xNG0eG0yxxcq0zESK+/ozxUXkIsnZ8x
 GylYumNHYhwYo2oQCF4FuK/vW/CxclNYBapjcPKTPb3UHpjHUP6s6rMDP2zfILf2WNGd
 L6en2raRLEVq+32eT21KWqb6AETW4XS1ajbMLEU1LDsM+NXyfjsMH7KXC2SDQPpz5YlF
 u+HfhDaodZMQ0ygEL4CeM3t2syneYvuVg3jRnkvSpUN4mPYqePCiMeTEKJTv0qgnp225
 AMmg==
X-Gm-Message-State: AOJu0Yxs1AwzjMP0i02Cvcq7hCC4R4vHkES2q4kDo/jW/lAFNwcieCYh
 B8EhR/KgjM/X55ifyi3SdY53p4+RwbmY0tbnuBvXJwKU890QguTMdmS2x9r/H+jDN7IWkttt5Uj
 Dzk/0Jiu652NY4W033R0M9qwz2bxl/ipTj6z1UBwYYkHaGUdMBur+
X-Received: by 2002:a05:622a:1115:b0:447:f8b1:aeb9 with SMTP id
 d75a77b69052e-454fae6d551mr60594201cf.16.1724341837363; 
 Thu, 22 Aug 2024 08:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQnXCf1geMeBiPpy0CYrSizPMAnkDsHAaRxajA6HQOJxmd7yZYqnOykzwrryf3o6/l4gPdDg==
X-Received: by 2002:a05:622a:1115:b0:447:f8b1:aeb9 with SMTP id
 d75a77b69052e-454fae6d551mr60593931cf.16.1724341836907; 
 Thu, 22 Aug 2024 08:50:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm7852271cf.89.2024.08.22.08.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:50:36 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:50:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 10/14] migration/multifd: Don't send ram data during
 SYNC
Message-ID: <ZsdeSP4eyimnlMyS@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 01, 2024 at 09:35:12AM -0300, Fabiano Rosas wrote:
> Skip saving and loading any ram data in the packet in the case of a
> SYNC. This fixes a shortcoming of the current code which requires a
> reset of the MultiFDPages_t fields right after the previous
> pending_job finishes, otherwise the very next job might be a SYNC and
> multifd_send_fill_packet() will put the stale values in the packet.
> 
> By not calling multifd_ram_fill_packet(), we can stop resetting
> MultiFDPages_t in the multifd core and leave that to the client code.
> 
> Actually moving the reset function is not yet done because
> pages->num==0 is used by the client code to determine whether the
> MultiFDPages_t needs to be flushed. The subsequent patches will
> replace that with a generic flag that is not dependent on
> MultiFDPages_t.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


