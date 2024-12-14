Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70792E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 06:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMLQ9-0001cw-LT; Sat, 14 Dec 2024 01:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMLQ8-0001co-Pz
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:14:32 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMLQ3-0000vU-V1
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:14:32 -0500
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso4374922a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 22:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734156866; x=1734761666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4hpbAF6YCK7jTq1JrgbAWgOwdtX4wWjrtTMOvnzZQI=;
 b=HmnIgOtWECpgOvsbIvD5vbYOjPxxhTSlhY9r8OSHNV2UzDrRl05F3zVmZJfkNcd4bY
 PIEn3rRI/KrRQQTF+DdV3geFmmVCMJlafuCJObhKr0ZD0wC4sP8uWRfqtI4GEJ2psul5
 TKbY/aMTz6l2rtx5uiUtR7m/Cn443vedFeBNMBJg6tp+wBcKbLwO55u+KFcAHiAaKlX4
 W8kxKIDKlDDL8okcwjv5M7MOwF8+G8HOyA477uhqBtndsHEK+Zcky7/+6tM+sAxrLQF1
 EuTUJkiBchy8IkDvNajmbciW/EAiuQrfgZ7bLNUu/r8WOyGqNPa/chMhApGNg60EJ5JR
 jjvQ==
X-Gm-Message-State: AOJu0YzGdod5yt9tGDFl0suCcoxvVoXj8j2pmUrgGYk5Ay2Kyi0l7cUP
 QeyMomjcKfBUllFSZhUjPgssbkfJ/0lkRebsSRg8lEUvjN3XHePq
X-Gm-Gg: ASbGncuP+bzJtUk7UDJ4oykOsh8dXDflDPX+sECZ9fmt9rPHDTkhcCZlypMIJc9GLF6
 6Gl2kZndoxn/Bzvf8Hvj2gwMymqO8EjaiVevpSLF8ZBJ6JFjF7cx9UEfcbuVjkwnqQrq2ElKswx
 LR8PSKrR8d5Thu0sZ7puO8ZDLSwo9dRf2RD96tNz+1yoMHO76cPDZbEYHO5ovzIzdu5AkHB7Lor
 t5BQEe3P7m94pRq4kc62TuovBg83XSk5DQhN7tGWAmjoq0j9ENxhW2je8BNHcSm5+U6VNo7pZ9/
X-Google-Smtp-Source: AGHT+IFeN06X8WjD4Fo59KIPKZq6dh7ZSphPYTn/5DUMK9PdaKWomHiklLIrZeK2BCJxDIXtEpxqLw==
X-Received: by 2002:a17:906:2932:b0:aa6:ab70:4a7d with SMTP id
 a640c23a62f3a-aab77ee9adbmr503129966b.58.1734156866143; 
 Fri, 13 Dec 2024 22:14:26 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9639363asm53858066b.169.2024.12.13.22.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 22:14:25 -0800 (PST)
Date: Sat, 14 Dec 2024 07:14:22 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 31/34] next-cube: move next_rtc_cmd_is_write() and
 next_rtc_data_in_irq() functions
Message-ID: <20241214071422.73f243d7@tpx1>
In-Reply-To: <20241212114620.549285-32-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Am Thu, 12 Dec 2024 11:46:17 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move these functions in next-cube.c so that they are with the rest of the
> next-rtc functions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 172 ++++++++++++++++++++++----------------------
>  1 file changed, 86 insertions(+), 86 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

