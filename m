Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF5AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9iw-00073y-CG; Tue, 12 Mar 2024 17:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk9it-00073n-AS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:31:47 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk9iq-00028S-9h
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:31:47 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5684073ab38so474613a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710279101; x=1710883901; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nBGIxGZozN2jOMcn9yMxjJO8Vemj+hmUE7ibwK8C38A=;
 b=ro8wx6C5GZC67fBh+cPy64YSqBmRq1t3LTZM4w6EUOzQId5WWopoRmWa69uFNpSx1n
 GR1+ITMh5uYW0Rxz3sEXkGxXmGjTGexjNBDwPXD0011zbwhD/NkU06/Rp2ecDidRa9In
 Of6z/t3e0LlkZ9uJmWA+/oHQYYww0Kwn99VlpoLyUAimyMqaoGHBcmYFOIYo1lTKOUOw
 RxxDkDNCTnf5LC9s/8qF4ypXSmP43rAjhXeD5uwTd/Ahj9Y01KdeTpCHkBUdacUdrvHB
 1kCIuPjL+VNdyMQ9dTpqAeAF77BqOWTXF1m9AZMGqn/0z57ooE631OIQg/jx/rTlPDFk
 r8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710279101; x=1710883901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nBGIxGZozN2jOMcn9yMxjJO8Vemj+hmUE7ibwK8C38A=;
 b=r6u4CHkusdti77X0XgGct2cQuvQnLXTgy3KTYS2ZHitOUPDzNHddcWQthuQjD4dc0o
 df0iUWrilnrt9G2xf/zi91aC0FdZ1IzXh0KECMF1Jm5O0fugmC+8FEI9BjJc3CAmL+Q0
 qT2XQxLMU1qswnRJ78ny7d9WsooIZ9Kti3CYmar/gdCYNQ324EVQGMtQBjDZoUyyzkag
 3AenuNkAybjjx5aQo5UkYf4pHzU1n/BvE5OIUuWc8XGAVzuGsf7RMeeQMEtbi0M/jv5b
 jkgWTVRRqlOXG8CdYb22ajvwkGgNYWIsvkd6LW7sn2cMnpk2lQeg2ZCWIWvV8ctptvk8
 ncGg==
X-Gm-Message-State: AOJu0Yz1SLy1Vs32YgebYU0pQendUyHrlTP0wBQQLBa6Vl0WkLIve/jq
 Wu+IPLx8FlzoB4vUBaSM8UnIs/5f6di4NMwum1LZtS4j2U5pxuj29Iq5gzhry5VxLOweY/3xGzt
 ROEax9Ci4NTXLBvC7HLG2mgXtCVJDq5ioAZ/hjZxC3Js/Ad+K
X-Google-Smtp-Source: AGHT+IFp+gwLvF3terttK3oYszaLIaNZJcL+/AHg/Qkfhu1z0Z2zNhxVgEvnjseF/DtVwg/j1bB0nBd1JFiiPYeIXf0=
X-Received: by 2002:a50:d5de:0:b0:565:4b37:4578 with SMTP id
 g30-20020a50d5de000000b005654b374578mr761871edj.14.1710279101636; Tue, 12 Mar
 2024 14:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240312124339.761630-1-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 21:31:30 +0000
Message-ID: <CAFEAcA8tH0ZmN_5it6tuaMCsksdJ1vrgHVmXmK4qr97NwsJVuQ@mail.gmail.com>
Subject: Re: [PULL 00/55] Misc ERRP_GUARD() and cpu_env() patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 12 Mar 2024 at 12:43, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-12
>
> for you to fetch changes up to 42e62aadfdcc44215482a85da55dc4758775d790:
>
>   user: Prefer fast cpu_env() over slower CPU QOM cast macro (2024-03-12 12:04:25 +0100)
>
> ----------------------------------------------------------------
> * Add missing ERRP_GUARD() statements in functions that need it
> * Prefer fast cpu_env() over slower CPU QOM cast macro
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

