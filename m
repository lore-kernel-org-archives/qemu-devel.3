Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A124CEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAqE-0001ve-4S; Tue, 08 Oct 2024 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAqC-0001uM-Qa
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:05:33 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAqB-0005qs-An
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:05:32 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fac60ab585so59724241fa.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396329; x=1729001129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2l3ZDx6KfEzG9FBRNLYNkBYdxJ2VQK7XfM57EJm+wcg=;
 b=v5lSHOR4aPKE6Cb/44ryrXwFVlpqvSsgJ06w4WGJiIhXnNlbN6FbqBsAJW7ngijDVc
 3houyl1p53OqFL2jNJAyGiWVQlz8zZHsgHw3loBnn45fPLE+5P9C//D7W2d2ou7/Blag
 y4SIuc0i0PZ2VIBx3Vdfq1XP7wW/uBTiCiIcubiMQ7P/U0jH1e9ipp/PtXw/enybIAnE
 4ykJJVaOaZy4eTuV5IJv70WmH+lZs7YLCnuULXplw+msHX8mzUTzRepeBcqxKtNqVz9a
 ijNRcIdCDin7oldvB99H+f+g/0fXgLOobnXzMMjtxlUss4xub3A/BFmwqsjx5JOiqAch
 4jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396329; x=1729001129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2l3ZDx6KfEzG9FBRNLYNkBYdxJ2VQK7XfM57EJm+wcg=;
 b=Nm8fGSwqx8fe5bH61bW02LFjJedvyU4vck1rGT1xnv8QCDN3GoIRk53qjdFdPVU8My
 XmKUSJYK7xtkM/66dsxM4/AuGgx5Kd4S/HVgkG5yxWfrH0yzR2BxEcydOyodrbodHXJy
 /25epCPKoNp4dbOY2qGYelHIkV2Q7V/K1GtXlpKR2aWdljsb+um9iw22DSJjRwwCC+UC
 y54yhJ+wUb1dWMp4Lp4c2lU6mot4ZLGVzmHzhmgtyyvaIgyhAOeuUY0M4Alg0+CGCFUl
 jIPEzOXS1m3EO9/5Y9gvGOmWhZ+IaUvVTo7Kgi/m820p62c1M5bpmGxhUYx3av1dtf/8
 x2EQ==
X-Gm-Message-State: AOJu0YyDo3b83X9ozalKIolnJZQuzHD1nHglE70xBHIBOApf3Zt0+JIp
 +tvUNsR22JhBm4xReM6ZbQ6J5U99HsnDFcDr+VMrX5j53DsmiOsJ1DhxfpVw480IvJiU/QrFlb9
 jSLnTiN63gQsv7+z/BIWeJOWjH9PQjCNw9e37AgU5fDL/dkSd
X-Google-Smtp-Source: AGHT+IHBZUuuXGIdrsRP+B4qX5P0Sr0NlGymNkJEVP1ALv2MaP/eBYA9REXK0nzhHDZeS8C0X8vz1WSBjTAJppTqxcI=
X-Received: by 2002:a05:651c:19a0:b0:2fa:c49b:d14f with SMTP id
 38308e7fff4ca-2faf3c509a5mr79361221fa.2.1728396329406; Tue, 08 Oct 2024
 07:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-6-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:05:18 +0100
Message-ID: <CAFEAcA9V5-hbQm6iDP80cH9LQi3zcCp4kHZDp4MG2y25SP_PZw@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] include/exec/memop: Introduce
 memop_atomicity_bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split out of mmu_lookup.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

