Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B1ED10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 07:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bhj-000310-H0; Sat, 26 Oct 2024 03:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4bhi-00030q-Ei
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:59:22 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4bhh-0000He-7M
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:59:22 -0400
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso313963466b.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 00:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729929560; x=1730534360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKN1Wl3QDtFGorESZA1Pr+OsMhR3bRrXiqVEnNvEiJs=;
 b=VYyDW5DV36zPyxb9v7BP1YWLH15z87hSVjriZ0gMj2bO5yzAVq6a8rLG6FB2nVoZlf
 ZRbeLLbrqDLjqzh/dM9GcP8z3F40HhCE5euba4HGyyVf0Ki/+goV1s0bsIiZlR47Dols
 l5bC4ySf2WdLJGEvyL48KwZBppxqCiS2b1p5IXU6a1nLCZUJ4Q/BJzW1DWz4Nj9oCeJP
 Sf67GtltLj1DBKsvyGoEyZtw7Nco3DAqp2xesZR8oU5q92ie02762Df4OD8Nj/mmmNqR
 37UlC82TwbyVISzLpUUoroggmXeASuT+cORMFgnpxlkKcs++AlTyNV3xBuGN+XylEwRo
 yXVQ==
X-Gm-Message-State: AOJu0YxAY2N7nGaj3OBV0br7cCrHJt34FhlUCuVnfi+XlUyrfguDzOsr
 9LEPwbI1CNUJud+5MB6X/AJKXzHntUMRYXB1sLQ3mvOVmJtSn4AO
X-Google-Smtp-Source: AGHT+IHZZnH76JPpWpjRaunT8z7fX9JE0lgc4BC3mw90sF4S/NNUOtfVzY4fpAfDmWWHvVJ2PQvJ3w==
X-Received: by 2002:a17:906:794b:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a9de61d4377mr132888966b.49.1729929559322; 
 Sat, 26 Oct 2024 00:59:19 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f0298e7sm149883166b.75.2024.10.26.00.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:59:19 -0700 (PDT)
Date: Sat, 26 Oct 2024 09:59:17 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/36] next-cube: remove cpu parameter from
 next_scsi_init()
Message-ID: <20241026095917.4b704393@tpx1>
In-Reply-To: <20241023085852.1061031-5-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.50; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f50.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:20 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The parameter is not used.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

