Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E4AE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 09:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Acf-0008HE-1e; Sat, 02 Nov 2024 05:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7Acc-0008Gz-Uc
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:40:42 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7Acb-0004BP-2V
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:40:42 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so23270375e9.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 02:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730540439; x=1731145239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uny0zmvhQLnoaaCgrfBn20aSdxoylgO53i+KqHywVJM=;
 b=aypLZdTvX6Ah0PvO9Qa/c7YuIfZHIzLxV+vhRgIwSUV6sGFQ7WnXzWDNDYbh9Hc6Gs
 5WxPJypEkMsRx09L2DtSMpm7zR5YUlZ3s6gOKyrwELQhg4uq1J2N49XAxVYQcvjEbdFB
 ArJXnsa/VJlekIA0cj+E/aJ04f1a+OyHwWmd7+mGUDuXAm3IJhaPJCJneI5tiI3U6hx3
 9XJWbE/ZU/fvGH3X0BdK67sy3bjbh+cTk+Y0O+E6OK3qWYGtM3rKQFBgHB+pT4F52o/G
 0lZK98zEEwgkFENiJUZvykfKDo6Jezi9KXvnqcyIs6gU0qyOPddUX4+Fg8gw+qkylGVL
 tD5Q==
X-Gm-Message-State: AOJu0YwaYqwpVoEWzZmXvgPzj0YkZgUZPKfksxTsXkTb+fvkImd/PfWf
 DTZdPMRvp5xiUhb+3lnesCE+KS/i+wG1IFF6FGBzHwgRZDCm1L28Yk5oJQ==
X-Google-Smtp-Source: AGHT+IH0QIDEGZjAkKc00P7s+7lRoSxA2VKfXKhJyj+xAzw6c3ZxrB8rorqDzDZPIZ9TP3o/TBXLEg==
X-Received: by 2002:a05:600c:1d28:b0:431:6060:8b16 with SMTP id
 5b1f17b1804b1-4327b80055dmr85366995e9.30.1730540438766; 
 Sat, 02 Nov 2024 02:40:38 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7449sm7574463f8f.49.2024.11.02.02.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 02:40:38 -0700 (PDT)
Date: Sat, 2 Nov 2024 10:40:37 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 17/36] next-cube: remove unused next.scr memory region
Message-ID: <20241102104037.365bc8a6@tpx1>
In-Reply-To: <20241023085852.1061031-18-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.46; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f46.google.com
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

Am Wed, 23 Oct 2024 09:58:33 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Now that the next.scr memory region is unused it can be removed and the next-pc
> devices mapped directly within the machine init function. This is the last
> remaining overlapping memory region within the NeXTCube machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 73 +++++++++++----------------------------------
>  1 file changed, 18 insertions(+), 55 deletions(-)

Nice!
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

