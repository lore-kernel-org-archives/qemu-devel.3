Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC52E677F8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 09:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7AdW-00008d-KM; Sat, 02 Nov 2024 05:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7AdU-00006z-2G
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:41:36 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7AdQ-0004EK-Ta
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:41:35 -0400
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so21448755e9.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 02:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730540491; x=1731145291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcsT311YUE/9GF98zdDuQHt2tEzi07fejWINdfWgLak=;
 b=orVXPu3RC1Du2warFfs4KpCrpDIfydNAOjxwkpwIDL+Y6EuWp3wGhGNI1NjGaBBpc6
 B8F1LOaJuGtZhIMs1GwxpncR32YnVZ8BQztYJ7I8BisIBnLiEmmuIJRfD4GuZolLuLb+
 3cHd2SFNpPzmJbEo7TcXh/m2WHfXIF0M7VRgL5YHUy04kE8ulrKOFzFjbuAVTEnnQb8N
 OlWTv555X8Ufdr0viR6kIvUZUqToeT97HHAwvsybUd8BmMohvPypPVKk2W29q8OZSzkw
 dX9ZX2P9IhYcemOeZFrvra6Ag8+yVUvKjOLHnS5uE2El5wehkC09xffMaGyhEXBpwwAp
 aIyQ==
X-Gm-Message-State: AOJu0YySiWBHRXiTLPPuUesIX7OVuIOw/8jOfLZVANaCXps+gv74pbV8
 ILaM+so7/k+pwF2a/bSSFNCLp7IK3YkcMk87aH+JxHTYkOM3lfk6
X-Google-Smtp-Source: AGHT+IGsRfRBac0TaQQXQjiDjRiK0MxEe9p6l/rHtXZVixB2o40shXfndguBl+EFJyTxQZlqqywvug==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-4319acb17a9mr240959695e9.16.1730540491053; 
 Sat, 02 Nov 2024 02:41:31 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7280sm7588436f8f.59.2024.11.02.02.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 02:41:30 -0700 (PDT)
Date: Sat, 2 Nov 2024 10:41:29 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 18/36] next-cube: rearrange NeXTState declarations to
 improve readability
Message-ID: <20241102104129.67ba5ff7@tpx1>
In-Reply-To: <20241023085852.1061031-19-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.54; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:34 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move the NeXTState, next_dma and TYPE_NEXT_MACHINE definition to the same area
> at the top of next-cube.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 64 ++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


