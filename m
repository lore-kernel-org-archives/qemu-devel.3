Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4D9F364A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAszw-0005mx-B8; Thu, 09 Apr 2026 13:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAszp-0005kz-Ee
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAszn-0001N6-TP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775755006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y75PzzbTHJFBVtv3fVLVClI42CasXwdsX/jKsDCZxaI=;
 b=DHPJGg9s4ACeu7C8sQsSyLHwhVQNNnIz7m8UxW8vyQeIQE6l/boPGDv4oEdSZJPwCmP3ae
 M1RHlcUqpQMR1pGu6VO4KdtfZUGonQZ8VdyZn72e/jsQyEL3QUVCPry8pT28mbUWlWV2vF
 W90uccr7b182EMUjAJjdndDzXtEB6Ec=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mkx3kRyQPqecYTiCx-HIcA-1; Thu, 09 Apr 2026 13:16:45 -0400
X-MC-Unique: mkx3kRyQPqecYTiCx-HIcA-1
X-Mimecast-MFC-AGG-ID: mkx3kRyQPqecYTiCx-HIcA_1775755004
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488be33b7a6so9009605e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775755004; x=1776359804; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y75PzzbTHJFBVtv3fVLVClI42CasXwdsX/jKsDCZxaI=;
 b=ThYUACzPT/boM1qy1KzKXhTGzGe6bRv+E/4urYW/2BcxbwdYLzKJDnm4COs0LM2A1t
 RfCQJF34TbxenDoXhMpAxSy+aAdj+O9HlgIbTxzJ9rtSXXXHZxMkq3jNI862+aDKHc6A
 vYuPPy+IdakV71BjXJEC39e3A0lax8gshHMklmmoXl0vRaa0Y+3Pk0FyZGMGHvWHOwf2
 LeT5POqbixTqGCTbSZE9TfoCiWgeNlcoynme7QEWq+P9bK7z79lx1lHcqptBDmqS+rMA
 gSpeHGNNQrWoTea9Wt40Eus07NchXvRH1B7IwT4U/UGg2qgvwO2p8VNqxuFnaRjTl8Lp
 Z32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755004; x=1776359804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y75PzzbTHJFBVtv3fVLVClI42CasXwdsX/jKsDCZxaI=;
 b=cLtVMOe5qdFzy1GtPyZrAQk0Sl48XPQb/oYB2YmYG8fpicDZDHgcjfO5awdCqOuzyn
 RbNCSmErTc9xyZyFJlyA5On/tGW9+mFu3P6p82fu4tH18T2ecAsJt0eE2pyXdnxrEhlN
 /poSGmddJW4wEKPBrAZKJ+dfU61SjVd8YO1tukCWftfNk4TzMiCDITv0F2iaanFvxNIh
 gDHlPL/zDtHwEQk7cSO+MDCcYHvHhhpXGkiWT4k1lWd8B8UwstTPLaifFNRyBboa4/hV
 F6JUHAos2uOeI0NE1rV4DjzE0DiGllYz1Vv7jccw5o3U8a4IP78em0x7BP4ffoFPWiNg
 m1vA==
X-Gm-Message-State: AOJu0YwR+n0jTU7ivzaqPgy9tgOpA6oZWnz62/NHxsTcBEr+CM/paSzF
 iPJ/ZnAnqiwzTCLxOO9u9ZpKh9qHOXb34wn5yNeRq9GZOYMBUYyDZ/lrwtujLdXhL6YR0VXE24C
 sT3mfQq6YRsCjD+0PP7sMwKmFrSWVqJkiKPkMDKAOguxQPtYvf2Vz4Nxc
X-Gm-Gg: AeBDiesoU/WdoT3lFKzIisJFI4KquyBP8o97Q9aVcY50EW/zbMgkxn6PasR9VdQBo5G
 mtXxLliJ8vsoEhVTk6rBcBM/JnHpsOdQIuG/0juluEC5ZYHkXwJtIKlnohByypKc1eTdaYfDsJ+
 oDyWrzOkrhqyASYhN0TtgLrf4G0gxxCTAlYYF/mmt/VkdIZeT79BJYzh8/jrOoQEHZaiRpUK9l2
 9k/jWet6wXXgUavf6+WPplhNNUpzz/tYOfHFBrhrUqye6ji23uxgZbFfhD/rOcfK+AEqOkNferK
 cAQsUnyebhT6sWS8p0PNczqPIJ+K6B/N2rWu3dIqdnEDBvNDum0Vmu995otx2+zeLjw8JENLJ9a
 eGfxBI/X1d9YOtqCU/9mGdvzZMhE6vcGxOJwYFAA=
X-Received: by 2002:a05:600c:3b1a:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-48899775d8emr333684555e9.14.1775755003890; 
 Thu, 09 Apr 2026 10:16:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1a:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-48899775d8emr333684215e9.14.1775755003376; 
 Thu, 09 Apr 2026 10:16:43 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd19a69esm30129595e9.32.2026.04.09.10.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:16:41 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:16:38 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 11/14] migration: Calculate expected downtime on demand
Message-ID: <adfezzADrj9sAjlQ@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-12-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2026-04-08 12:55, Peter Xu wrote:
> This value does not need to be calculated as frequent.  Only calculate it
> on demand when query-migrate happened.  With that we can remove the
> variable in MigrationState.
> 
> This paves way for fixing this value to include all modules (not only RAM
> but others too).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  2 +-
>  migration/migration.c | 25 ++++++++++++-------------
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


