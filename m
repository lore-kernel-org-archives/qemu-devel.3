Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B1C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7NT-0003PS-Ae; Thu, 23 May 2024 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7N9-0003G1-9p
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:16:40 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7N5-0005Fv-Qe
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:16:39 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so11443748a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716466593; x=1717071393; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DgmwViRWhStQlewph0KxsbbtXSLnBVz28LhZ+zdHzR4=;
 b=E/WjRMsZ4KBYOCUNYL1V3JRA7h7j6+oIQaKNRp4xbgm8DpecFNUHl/P0rM4T78mtfh
 XBWpvzat5jgGc/UObbN57Z8rv3G0urfgPbqv0CVG8drNnqyeMFxyXP76VVpXn55BWkQY
 yx6zaIYlza9Ek5v5dmmEf4qHkr/2/NTkOL/trzZC8O6Qikx1ke825d3aBInjtDUjE3yH
 1KxR/jlrHTKcV6q7jfgCSSKujTmCWTITcqy17Eo1KPcbM9Ag/Lva0PWPakSUZuXzVgOb
 Blt9z5iOj9paJEJZTanWeUDPdocKRXkMDinlVhdvs9aJr6IrLIc7A82bFaaK8osQb2SP
 2oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716466593; x=1717071393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DgmwViRWhStQlewph0KxsbbtXSLnBVz28LhZ+zdHzR4=;
 b=XY6FavV4gSX657w59tgL4fiIeaRPZ9D+CtYk8/MLqVGr/rZibki+71ObqtvZ7VEkap
 9LKdrW7Ca/iJFjDvvo4o/8nMzzLJj+1YSxeK3Yyp3ietvTgE9WuO5bewCiY/na4pftUK
 ZqpPVguI7cTqWs1Rbe3WUWrFC/C/PGnBcA770oOeT4qKQ/XilS4IuQarhd5990RDegth
 HXrjGrmpbKJdmjFEIaWTQHU6deQZ3Cf+J5EBJ2WVD+NHi+tb6WzfhEjhPUo98I0fwPPm
 pu7OGgcDoal4fMWtVYT+2d7QBnv+b7EF7FbmoGiSa9ezLZ/EGl/+Da0clFXf8mj7aqCU
 X5Fg==
X-Gm-Message-State: AOJu0Yygpuqy7cwLt9srPMgxmMotoxrotESByQcy2E0Ns5Nuzt3SZBet
 iRirzMg19LJ6Fb/27E5UkAYqpI/MqWD8tGUepUz5388iu7ID+TuwLu+vYKVWY0qMkyYjjpHkNB+
 8CXsF89rvNnPK3bEKfXM65j5+oxo5cOLSQ6aW3KYxMbQINyBI
X-Google-Smtp-Source: AGHT+IGSw3LDHC65terBcaQxG1Mdz9RqPOnxQVS8dk5sHSQgTGpFkKLUDUdIymGu95gFf2myEzt2X6WHGQTRBjJBef8=
X-Received: by 2002:a50:a6dc:0:b0:573:5c18:c2d5 with SMTP id
 4fb4d7f45d1cf-57832a07eb6mr3212784a12.3.1716466592637; Thu, 23 May 2024
 05:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-20-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 13:16:21 +0100
Message-ID: <CAFEAcA8ythNU_AXZyL2D+rXhEz0uk9c8QhdAnMmf=yz1G8-=FA@mail.gmail.com>
Subject: Re: [PATCH 19/57] target/arm: Convert FABD to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 6 May 2024 at 02:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  1 +
>  target/arm/tcg/a64.decode      |  6 ++++
>  target/arm/tcg/translate-a64.c | 60 ++++++++++++++++++++++------------
>  target/arm/tcg/vec_helper.c    |  6 ++++
>  4 files changed, 53 insertions(+), 20 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

