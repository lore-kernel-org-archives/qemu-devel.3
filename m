Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62510E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIYo-0005sd-35; Thu, 05 Dec 2024 15:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIYm-0005rp-Pq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:34:52 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIYl-0004ZT-0q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:34:52 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d12709e1c1so1683180a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733430889; x=1734035689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ngFJNXWrJdFmHNW7rsyqfGqxlCebgMUTUKhB9LU40S4=;
 b=RNkInXyQNp6PZD4LFPeC/r5TR3dif10E0K8RuW4CXet7e/HaVKGybkchcprQbDtKUA
 z4sb5319wa6G7xhf9AvfQASMNMGdxYKY7bBGJkIl02o8FmtSTABdYxH/nOJQGPzCgrfi
 bx1kQrpEqOfxQSmrGocmhT4PVFOUHZrVRft34ieq8zjYLawnFf4ia4xDNZBOL92TzWNp
 BXDptHRaHSHLlw0U7zV9Wq6UZ7ikQBMZdfpbjzSN8eEDJxv5Vnw1xeNgqXSMgsghck3g
 0hLDDLfI8OetYXcfNdf9EQ7wE845bgKH0b/JiA6URc05wg1XIQT20pjV46hHyznM3kEy
 FlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430889; x=1734035689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ngFJNXWrJdFmHNW7rsyqfGqxlCebgMUTUKhB9LU40S4=;
 b=uDzri+CX01TB+zSzLfzlkNEroyzIrLvEbGfzCYcRk6PmAqS6S2CfmVmjieIB0T3ry7
 40UV1Pyi/DjDIZ8TxR2XP9lmNGxFlQNusEn2YX00wJAXla+Dc83h885QnFl14C42htio
 nx1ZPSVdpugh9q6MSpk1YT62XlGQj1bkxPjIStn4QqX+m2smsS8J2+TTESKVHTVjmII4
 Ya3Amj3RlC8vF+Ebcr+T9bJm/3ofoXMq1pqW6IaJ0ov3ZYtSGrFMnEPrxzcarw8d+Q3d
 ZBJs9ZbcC6/ehdHqeVaoG1m2XnRojIEc5mct6gHpz2MfzazlrlK/ak8GEohi/Bejl4cR
 1KQA==
X-Gm-Message-State: AOJu0YytbyjIiaTTOjQk3lw3j/168HpKbp1F3T6vn5V1bAtGHiA8BYrY
 2TvqV4zh1kHMbcI/aUx8WkgmBo19341qIskIxQ7ol74uXq4OXfl3LWOwmKw+WjRaW0Px0Ncwpw7
 885167qfhdxiJJkexpsO31ShA1faOJw7S9V+iCt4wlQg1Y/lK
X-Gm-Gg: ASbGncvWYeli6sd+5nxHGUQylAGVhnWYUXUVoMEx/i0tbbq6VhYrUE9+RitIr4vjNVg
 KmhtS/VStuf+9ngdUt3MjfoVHCARppysE
X-Google-Smtp-Source: AGHT+IHphPAnID8+cQ4lfBbqEIlcbsxDCTlD25kX8svFneH/mMDVXPYMktg3WJoDctVAla0dPoHhDQPAyb1LcEa6Wmg=
X-Received: by 2002:a05:6402:51cb:b0:5d0:b60a:2ff6 with SMTP id
 4fb4d7f45d1cf-5d3be71f26emr433489a12.22.1733430889173; Thu, 05 Dec 2024
 12:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-20-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 20:34:38 +0000
Message-ID: <CAFEAcA_GoZpDOc8TgaGDTLmiTUOGXWPor=qzNkn+eRavarBgWw@mail.gmail.com>
Subject: Re: [PATCH 19/67] target/arm: Convert disas_cond_select to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sun, 1 Dec 2024 at 15:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes CSEL, CSINC, CSINV, CSNEG.  Remove disas_data_proc_reg,
> as these were the last insns decoded by that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

