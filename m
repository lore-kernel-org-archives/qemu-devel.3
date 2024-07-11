Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9BBC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqxk-00014d-I9; Thu, 11 Jul 2024 06:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRqxj-00011X-KE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:23:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRqxi-0007oZ-1Y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:23:43 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d05e0017aso967500a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720693420; x=1721298220; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qeur1SiUTUmlVXF0OWXzPxcPkpSMGVq6Ew1jDOhrOrM=;
 b=zmd2MszpTv8fIzZ4XcgZniXj6wImmbK3DDuCJLBiPXArSbqRzvZfi3bXeRAPPokRB+
 c7w7cj7+0gsEtYgxSbLG3+7SSH0k/53dIryfDM/5cEmRRd0EAhn7m+UwAUlUI4hQelhk
 CuR6elFKm66rTB8xpEmDkDqGhWWF+IXQ0MnFgazt3N6ALBeoDl6+GPWlBUWKKp5FNvGL
 2tEgE1u0nI6wA+K08PW9QJ+ggvIBUwyu68m7Ka3hpDrfjs35hBfAORyA2OrfcfLdRHPC
 nqW18hwrsLK9E+e1BSlgaPbt5j3LWUHLVmWEkZv+cOCWI58ZKhZvtSCdH9AoaESrnzCI
 jXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720693420; x=1721298220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qeur1SiUTUmlVXF0OWXzPxcPkpSMGVq6Ew1jDOhrOrM=;
 b=BmqHLB8wXMrcr+k7eE6PhVpxk6r6JVZF5GlRYzijeD8C2wZ8IEKnX1DkUwGK30JNsk
 prlQ8wRB/jJwUB+rv+fuGkXKGfbQYVs2L6xKXuEdriHSLl1Jak5o190vWppjJEvq3Vox
 UNw+m5UZDRkXW8o64e0B1jCYCD/1t+BBe9rO3baIHZsudlkj+y31/r5DlgpOFubUMBep
 muLAvPVbAT8RTbeQ/vG3jP1bjfx/IGhUB7MuysJ/wWROrjVIDrDkopbPYpDGyIxLUPyP
 d7zEQyHZ7Ble7tERDU/p10u5pp1os7z0swhvAHzJIKIyBpIl83StyJzH2VSCcDnPDOin
 Ag7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7wY2hx901SFdAD6/topFR6spBpEuaOdeAs9mPIt5bSJWMsDAbaeR7Tv9H9Q79+UDeczeHJjZ0M+Fib+/MQeJ7Xw6p+0=
X-Gm-Message-State: AOJu0YxvDfpe4QpTvBshDaEjczYO1NnfmPutbgDbWqMfcWZIDs9QNNf2
 voPKWHVvXzwLKDux94y1gElautN91YBNjPvvpUOF1+IOy9tHRLAtWYKcAIHt7sWQuVp3jM6Yh41
 frEIr4XKsgu39+bfO7jwrODLPPpuwODUXeGrTSA==
X-Google-Smtp-Source: AGHT+IGZx4o/5GMGEJPXrNpMpfMIzJHG9q4mXimvESRuukg50CMTgGs43CBHEKzt27kgABcSkdfZTaLei/6aSpVlBQM=
X-Received: by 2002:a05:6402:2071:b0:58b:565d:ac92 with SMTP id
 4fb4d7f45d1cf-594ba6953c2mr4850201a12.22.1720693419653; Thu, 11 Jul 2024
 03:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240711072448.32673-1-anisinha@redhat.com>
In-Reply-To: <20240711072448.32673-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2024 11:23:28 +0100
Message-ID: <CAFEAcA8uOWZnZFnTKPxBxvKtOnSNhp0Ou-BCHwe_mLqS_V0Hkw@mail.gmail.com>
Subject: Re: [PATCH] loader: remove load_image_gzipped function as its not
 used anywhere
To: Ani Sinha <anisinha@redhat.com>
Cc: philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 11 Jul 2024 at 08:25, Ani Sinha <anisinha@redhat.com> wrote:
>
> load_image_gzipped() does not seem to be used anywhere. Remove it.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

