Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2854DD5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 07:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gLb-0000DE-He; Sat, 09 Nov 2024 02:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gLO-0000CW-Kg
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:57:19 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gLM-0001C7-3w
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:57:17 -0500
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so584503166b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 23:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731139034; x=1731743834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAhYF+UHBr6UMJ2SBe7sTwY+17T8x3GjnqwJ7rB8OP4=;
 b=wZwH39PWLu26Dptk3q8hdOAK6D7zHQkQKYii/l84Qk+E6/Oj0+knayDO7bRajcGVZW
 0E9KZc5I6qZkrIB4OgWMflUa6fqZI1GKVQhp5UglWZrzmtocw8YMnrJWexbrckXx8fJU
 ZmIfV/nLYH/JdAGciKD2rwF8a1q9esuSXaoTl6ji0jDHRUjp0xSS9LA8OX+UAt9WEmHd
 dAsP7iQ46Tq6p93eCQ8iYnzeq1/nFcT9+80KCJVg21W6B6/YLScMPBZqcWf0xvMZV+Nr
 Cl+Muc1Vtjxd53HvCKdeWNEUq4jZzOBT/X7y+A4f6oVs8Jlxj4FuT3sSceaDURPRD45p
 74aQ==
X-Gm-Message-State: AOJu0Yzz5dWaaMLY5fqpIhKQaEzN2IZWSOeOL68Wtg9f09LefkCLMRmT
 vQ0bHUBqO5yNlw0EzQskRr24BFpmgiM0widleQm4UwaFQMU5f+JWaG6h8UUq
X-Google-Smtp-Source: AGHT+IHf+OFnaGMMwOuxemwOX3NZvl4b9NrAtaJlyY6RXJPLGBKUronH93n4yOF+YFuZdAO71nY5cA==
X-Received: by 2002:a17:907:7fa9:b0:a9a:130e:11fd with SMTP id
 a640c23a62f3a-a9eec767f0cmr605681766b.5.1731139033929; 
 Fri, 08 Nov 2024 23:57:13 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc580esm338354766b.106.2024.11.08.23.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 23:57:13 -0800 (PST)
Date: Sat, 9 Nov 2024 08:57:12 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 26/36] next-cube: don't use rtc phase value of -1
Message-ID: <20241109085712.0b062613@tpx1>
In-Reply-To: <20241023085852.1061031-27-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-27-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.43; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f43.google.com
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

Am Wed, 23 Oct 2024 09:58:42 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The rtc phase value of -1 is directly equivalent to using a phase value of 0 so
> simplify the logic to use an initial rtc phase of 0.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

