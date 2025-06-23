Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5509FC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeMp-0005Jn-QI; Mon, 23 Jun 2025 06:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeMi-0005JM-Oz
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:25:28 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeMe-0000bR-Ev
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:25:25 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-711756ae8c9so33272997b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674322; x=1751279122; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c4p68yUXHUV6q3ynAfdP9ChhiVAk6Fx7+/gL0My8iCs=;
 b=zmyiBVDz8kGwahiTk7JCNtzGGArINFUI1sun08FFdZLorzdhfCvee4fzWXJSt98FRM
 LQOhyBXDHs26w1YSURMmI0jUAaWO9WI0xW4MLUwrs6iEl7I6ykfrOmE1bn/xulNRZf4a
 ulTN3FSUF+JCIRAT/0tQzpQAw01tparRw4xtlKAE0fEcGCc+OXeqjyIL1qFj1z5+Jo3E
 91yuXK15rb7RPXVtANijIlLvy89UUMg1WhAG93E9+Y/c3h7NtIkbxm0wi6zXdCm0Xivk
 Aq+uqHMYyF5B/4062G6oDZKwfuGybwHG4A7LFwxBFRFvoRsVBs7feQX0qrwRDlzA5rqo
 mhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674322; x=1751279122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c4p68yUXHUV6q3ynAfdP9ChhiVAk6Fx7+/gL0My8iCs=;
 b=V2Xi9rgqvi7x9xBg/LTXaugikq110dZu2qiWXZTS2NMTfmXoki4q8t05Q0W358hg8T
 x/iDhdXQA0F5k0iNNjr52Fo2MuHpbPmGKz2Up0CYBtorsR+DQYc4OqD9g7LklKBjtc0X
 wIehOYB63C2Q/hO7+o65CJTSVmce9kvU1cDcc5l4jXWkTG+akgGmzAzZX0z4cTGyNfTA
 PgMTXxsukC20qq1uSHfBEkF19PmovoCVi3YcdPaqxb697xEHCywfQY2cl6xcZyAJIjKP
 1XLWhKFtcTMNLOAhpuPZdrusXWiynUXLmLDVt3Qcjheyh3HqezPwii4jY8+iaGcFzsLO
 4t5Q==
X-Gm-Message-State: AOJu0Yz/Ee9XebNUwvI8IpHyQMptbHWKX889sjsF+x1ISO5r57Db6aBV
 AfnZbADdPZ0hlGBXK17psBsIYoxZyhfAQsjAuDblrJEoVqCUY+rQw7rVafX4dXgGc5SC1unuQB6
 EnY96HNsePkidaaVAGiihHh6vv3ccnkttiqylJALzMfnVbc3E6v+T
X-Gm-Gg: ASbGncvgMI1OjtRkx2Ll1Uq+aD3uCi5yY5HNDeirV7gajsKlYVwQ2SqakbPLTUsVDue
 gM/zVfJiThAK8P45OaEgknDg01e8U8S4PzI0/XWodiakorv0YjrEoTYa1LYn/Hxq8V6lPgkMhCv
 rO/Xcq3T8yEjfDhy/iGe1S2pg767F+URpTqSPdgz4TnVJLfTAwVIe0t5E=
X-Google-Smtp-Source: AGHT+IHc108Uqd2fAlyL6czd/chUVlvvL/phrcXGXrVaR1NjQitZXyZHP2tRLSl3kEgWAJdKlKU2yleRoFkC8Fb20QM=
X-Received: by 2002:a05:690c:c14:b0:70f:8835:b767 with SMTP id
 00721157ae682-712c6396483mr143590397b3.5.1750674322339; Mon, 23 Jun 2025
 03:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-11-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:25:10 +0100
X-Gm-Features: AX0GCFvJUIPHInaNyv4g3yJ9UO88d4VX2KbaD1R1T3SBGDVPRv0fwBfCwCbiDNs
Message-ID: <CAFEAcA81TRhMpWox239T9Jqe5JoQLZ9otJ459xUUmduPg6b64A@mail.gmail.com>
Subject: Re: [PATCH v2 010/101] linux-user/aarch64: Update hwcap bits from 6.14
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 22 Jun 2025 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

