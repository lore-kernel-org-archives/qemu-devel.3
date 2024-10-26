Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C460D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 07:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bTd-0008NL-Uy; Sat, 26 Oct 2024 03:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4bTb-0008N1-KL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:44:47 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t4bTZ-0006Xl-Jo
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:44:47 -0400
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so3486136a12.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 00:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729928684; x=1730533484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F08ess9L7A0sExEqd9lHkgbswHDa/HqV+/WlJVWtYJY=;
 b=f1VJcb9VBCxAJ3EOOnMxDyqiNp7rnqdrI3E9XBZYr3d8S/aEmC8jGuM2RAyU0qRSuk
 kKXq/FGK7CVgxeao0+HBJZOY3TAo3r3aGIMZsxM+yLGiJ8azEYbdPSdlyHnVgbZdo0d6
 Pa3qTgr65nqgHFvTq1GwD7JdxQqhtCNZEldpzZo6I3egN+NkFxZQevARXmsgQcq4QAGk
 qkqK4DyjJ4YuBatzHV8T0iXrdQMsnwIyQQAC83NVm4O7TTDjWdY+5hi8O2VkAa/7Rmx6
 IqgPpOY5gZOF0LVES9NXO79SM1JokbQ6zbf0vBL3dXFMlPpXPG17kDk5kTY+oYJweD4C
 EVqA==
X-Gm-Message-State: AOJu0Ywl9YwxRkl4XNARpAVIZa0NRfQAILbQCEgdUDZ7m0JbwdW5WOUo
 7c6wgfGO7d8ruTgM5c5lTvU3bdVLyrbct6/KMEfuC19sbf3/UXfT
X-Google-Smtp-Source: AGHT+IGIw5OyMi0Fuczrq7RxSGBpoVPP1PHm0FWPZwtf0zpd9He/5BNQYKbVEN8TN9tPpbhr0GsGXg==
X-Received: by 2002:a05:6402:2344:b0:5ca:d532:f3a7 with SMTP id
 4fb4d7f45d1cf-5cbbf88a36cmr1565449a12.2.1729928683569; 
 Sat, 26 Oct 2024 00:44:43 -0700 (PDT)
Received: from tpx1 (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb613c3e9sm1325547a12.0.2024.10.26.00.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:44:42 -0700 (PDT)
Date: Sat, 26 Oct 2024 09:44:40 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/36] next-cube: remove 0x14020 dummy value from
 next_mmio_read()
Message-ID: <20241026094440.535154cd@tpx1>
In-Reply-To: <20241023085852.1061031-3-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.44; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f44.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1.697, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:18 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This is a dummy value for the SCSI CSR which appears to have no effect when
> removed. Eventually the reads/writes to this register will be directed
> towards the WIP implementations in next_scr_readfn() and next_scr_writefn().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

