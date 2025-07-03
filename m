Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFACC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMYx-0001CH-A0; Thu, 03 Jul 2025 12:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMYq-0001B5-4N
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:13:21 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMYo-0000OK-JK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:13:19 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so5792029276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559195; x=1752163995; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bmU+xr1OiBLzHw0SxKXjXI5qLbifrHXtHC6ptVV0wYU=;
 b=dPxucalwx8DIVnhLT0MFAxO1CuHS1yMQdKb0Fy3ndTYr64anoscyCOT0BXy3XtVvIz
 AY8katani+VePviOQUD2ztzn5MeVAjpiljxucDEXGUHwq4Epxzwzc8hzbNbvyKkw08Cj
 tTOkwKLWqNoUK3AwmxKgUVKvbqO4hbDNurf5JVvGkPFylPFXHlJdH1wzcjoH7aUi1kDc
 DA/zvV5k9XJlwKILnQAfnQrgvGAbJddret5Z3FOP4GkFMxaS6KyvN7Ipl9uM10EtC7dN
 2KZl2pyqjGhv+z2hCK0xfPm65RADzEy1icm4FFPwjQVjjFMt2kk12uz10YsVFIOvyhg8
 24hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559195; x=1752163995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bmU+xr1OiBLzHw0SxKXjXI5qLbifrHXtHC6ptVV0wYU=;
 b=GIWQMMAtBUAnwpWqawsa0JRYLPY+Cq5JBgzLi4aUl0Ja3Gox7Xhajnz9xIEZ7pvNAj
 QKPGcpzejVBYwYoaQESQ5+tK1IaHF/a1hiFlBBnQByEwDYzjileVBAfgjgxC2sqsChxz
 zRs7eMHmEzUYFuWIXm9eFW/4Oynwj90JMhr1dISg2K3FFKF6u5j24YX4TBCdAGx5DP8o
 387MCkdntIexvhD1R8N5zLlWC+UcTpK7pINUT6X5JM/OueIeNG0DB+OELHYYRwu7cO/2
 yTgOEfNyP0s+jGS5ibARN7pQAr+zb5g1dWN9sE2YjS9wmHuo7OQDaOcRPiuwcLGeHfBC
 WMCA==
X-Gm-Message-State: AOJu0Yw2+4pqpYc4xHPwsK0S/lSrm8TrG4KlaPVK1rlrhGJC6Vsp9x6/
 mmXBP8EtfQUHjsDww7qXmY2u1Vtv7cdVP94PVBwsyXQttWUoAx+jbMJq7n0KuN3pxukP3+dLnQ1
 QUu64DQqDuCUOKDzrBI7ud4RohUqRI42MS9NvdGPMhw==
X-Gm-Gg: ASbGncvfmQoDMBKaKU+xOP8pymmrTh+Pm8mxTRn8UMXbnm/WxNNqdJKbmvd6mMW3ZVz
 x4q41yMp1tCy8VU05LWH4uee7SWTJQOh4DL87DnpxJ6Kp4jltK+jUSuGyDllvIhW005evBLEArX
 4vhHP7K9UWgQxslS/VITcW4jb3myMktv8/b5BHPN7dwCax
X-Google-Smtp-Source: AGHT+IFC7lJ53nKBZxCacvFYQ/YSl+EfwtUpaT9Nhke5xGhedXl1NoPpRzA9m83S3Fdn2+atyUuGxbOZ98AgX6sQXmM=
X-Received: by 2002:a05:690c:b96:b0:70d:f892:2dca with SMTP id
 00721157ae682-716590e9c87mr56209187b3.32.1751559194798; Thu, 03 Jul 2025
 09:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-5-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-5-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:13:03 +0100
X-Gm-Features: Ac12FXxtkgxM8KukjhVlYYSPaMfigSFUMqKzC40qNLhM4yJO66DDUgaYA_RrroQ
Message-ID: <CAFEAcA9N6zstuiQJVAExjr57K-+F5qRZnCMfrOT3FqughJjAcg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] MAX78000: UART Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements UART support for the MAX78000
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

