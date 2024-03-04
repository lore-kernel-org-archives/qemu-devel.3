Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80213C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCPw-0001CG-Tk; Mon, 04 Mar 2024 12:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCPu-0001BK-PL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:47:58 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCPt-0003vC-8o
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:47:58 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so6502377a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709574475; x=1710179275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nu2SWMTXLds/FoeeiPqfZgX6rIayMC3k3ugVhqfKTy0=;
 b=mS+Nf+6winGG0y9uV8J6HqgGxjrS3lrFEG3VWyPTObhGxP5rAiqpQuaAerZK0QrjhV
 +LtoVfwFUlym4vGNwu15iEydyoO9GaFiA+z9BT5lG8iNkxmQTSntzIfsRuxdzLAXQJlL
 KvxpFrT5VLXYB8BxgRByyD9byOBUEFkI81senWd9tdHVm+tK0FX0nS+Hcnu3iRBCfirx
 w3CpE3Rkufl3oLi0itBb5eoWpPWTmb0hiqK/MG4kEf4mZ30lJYKxVAMYFWo5AvR6G/b+
 C3j2n+DPNaw4fEwgmwq7ShS1e1sesqWPSqx1JiAGk1flug/qVBcFKnkfJWVImtHkwAmb
 fnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574475; x=1710179275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nu2SWMTXLds/FoeeiPqfZgX6rIayMC3k3ugVhqfKTy0=;
 b=LvJKxGhoIZkRM6Yx5q0FEroj/Vlnfs/0gr8QyTb22X6DGXsAtxzI4ueF73jWom8r1v
 wg3TgPNEx5ed+kdDSi2GG4OzOb3Hnqc0p27T+j9+xaKJGuhfqzDT5/LOPIRweTQJeVGI
 VczzqAyMsVnuDo6ySrp+YpvH94TRUm0hLnpu5dAJgyEcB6xfFE6Kc0eRld8Uu97AXyU6
 cLNkOVW+obA/cKER94fEy6FGEAsmIFyKqaiz4b5dec0/PH2sFRBQW1ItQQp8kHkjfBjZ
 LrbDn5eTA2nI0aU0xfqi7ZVIKzw0/iKzK+NSU+lACJQ/Z4z37wWqn4z8OzTp3lChDXI3
 kTdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkq6SOXC8skHaNeD1pzvwvnv9iF6nCSGk7zb+5BkOAW3VLXMU6CU5OoDGTrCbEU2JmsX6aNTZVv9GRLwdNLu9XclJLrcA=
X-Gm-Message-State: AOJu0YwtcbJfR8+n2Lxa8NaiQ15YF8SunGP97w8YOT9TSoxorG2kpdQ1
 RKOnZ4QeF6C1KrWaxUAGmpmt38ri4AFZYbnPNKtOKvExrLW5d7rr11eUEVTeklpWzApwbuX18Bp
 goHOG8uTQyhry8Or/LWp8mk8bn7X9dlaY5qxfmg==
X-Google-Smtp-Source: AGHT+IGBfhirCDBKeI/qy+6YA54e76VqZn0ZoQU6ifbKxEWxdnKpQkdLpToEBV9r2NXRr/jOM2aMiCHOm2brPqtv6yo=
X-Received: by 2002:a05:6402:1e87:b0:566:4047:7106 with SMTP id
 f7-20020a0564021e8700b0056640477106mr7112223edf.25.1709574474933; Mon, 04 Mar
 2024 09:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-2-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-2-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:47:44 +0000
Message-ID: <CAFEAcA_C9sryL0_2ePF8AZRrJrBTE_X1K_HMRW-miLa7xVXTYw@mail.gmail.com>
Subject: Re: [PATCH 2/7] contrib/elf2dmp: Always destroy PA space
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, 3 Mar 2024 at 10:52, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Destroy PA space even if paging base couldn't be found, fixing memory
> leak.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

