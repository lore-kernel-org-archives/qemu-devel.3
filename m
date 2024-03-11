Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604C7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkyh-0006Jg-UC; Mon, 11 Mar 2024 15:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjkyb-0006Il-UL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjkyZ-0007ZC-96
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710183977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BIKvu3ksgAr7Ew6XiMy6KBPhNXS4mfK2bzvOL0IRCeE=;
 b=BqlF17ZqJPq7YsHpSaqijJy/ImepQv513RYPILxiLSWEY1Wt9rk+GduhoGxRjbAI4Ig4Id
 wa/NEsDRK4ca6/dab5yz4HQuDj0AZpPHb4Wbna8IlPQfITZ3pH3sumH+qxRiQmYvIxssQe
 0tAMQTGFbU4IoJVfs2WysDsKXkY1yiw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-eXFmP7pHM9iFqQBp3wB54w-1; Mon, 11 Mar 2024 15:06:16 -0400
X-MC-Unique: eXFmP7pHM9iFqQBp3wB54w-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-221994722b9so1072400fac.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183975; x=1710788775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIKvu3ksgAr7Ew6XiMy6KBPhNXS4mfK2bzvOL0IRCeE=;
 b=Ds4rrq3nfJBmXusGXXC3swEkLv7qY+H4BLGvXi4BN5klsKtk19Q6CfbsleWSzIZucU
 VahOUP1A4wyq+XMHxrhnCZWva0qimdpjnBqlmBzbSaphXUSulUx+ut4My5lmGP/dq4M6
 8wU3GEgMlN+codkP+7/Qb/xYvczdttkCQcY4hBOMfnqZDAokVwbGU8lzSyk93iAkai2a
 AyvtUCX/FfjBuUGfiwZR6J0KiQ6wTyW2yZJ/RozyDMzSfnOucY8esQ9xrzJkpT6L5/1C
 kZXKUQTLBaVT0NbjTgH3OdlbxdgbvjYXT751QZYwx97Rii8z8bZfy7LRGvjw4+mp85nk
 9yhw==
X-Gm-Message-State: AOJu0YwBCo27t6X/QKJiJ+4S4ZPhpFy0+Sxt4xJqn/ZkevGnCH/Ke8gr
 d12SlozawACY36/OaL+mhfZVSeCLxkEyKB7MbIYMTlmRjza4Hk8eCyc24k0xiHPS66t2xaeqUbM
 I4w6FLGY76oKOUhS7oSYaaeMB/iocZWPg8Ybn29Y+dYQh89ITISRT
X-Received: by 2002:a05:6359:4ca4:b0:178:f482:6e59 with SMTP id
 kk36-20020a0563594ca400b00178f4826e59mr8200798rwc.3.1710183975578; 
 Mon, 11 Mar 2024 12:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFA68OtAZgUmkV1WRqCh34a4PkJ+3hfeR4Cr4oQ+k7n2y6CQhOislmOVYusOoIx35WYZap3A==
X-Received: by 2002:a05:6359:4ca4:b0:178:f482:6e59 with SMTP id
 kk36-20020a0563594ca400b00178f4826e59mr8200779rwc.3.1710183975275; 
 Mon, 11 Mar 2024 12:06:15 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 q9-20020a05622a030900b0042ed641c9besm2941467qtw.62.2024.03.11.12.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:06:14 -0700 (PDT)
Date: Mon, 11 Mar 2024 15:06:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3] migration: export fewer options
Message-ID: <Ze9WJMOMlQBGA0Xq@x1n>
References: <1710179319-294320-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1710179319-294320-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Mar 11, 2024 at 10:48:39AM -0700, Steve Sistare wrote:
> A small number of migration options are accessed by migration clients,
> but to see them clients must include all of options.h, which is mostly
> for migration core code.  migrate_mode() in particular will be needed by
> multiple clients.
> 
> Refactor the option declarations so clients can see the necessary few via
> misc.h, which already exports a portion of the client API.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Queued, thanks.

-- 
Peter Xu


