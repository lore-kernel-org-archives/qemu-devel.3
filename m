Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4AAC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkRY-0001Fi-Nh; Mon, 23 Jun 2025 12:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkRT-000174-Jn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:54:47 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkRR-0008Ih-Og
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:54:47 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70e447507a0so33191977b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750697685; x=1751302485; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EJnApwJeyU8WjULXW91COnPvAcKQzP9dOx4NnVDDB/c=;
 b=OIbggy1Ie8egSiMFU1F6HdpiqbI5Dn5hDbvnh/Xu/xx4SQq4DcHXAAsDxSOM1Xi2RW
 qQSLP7e2PIYeEB4PKLytB4vnTSn8PIYQWSui50Vyx7ZJxIGzeep+6BK8vnQCLv+4VWeJ
 i3qVkF1JHXLwb6LjFVy2NH/O4QWhZkusQqptSgwbQQ/aAMse8TtPslwa1XGYG6MBK3RV
 zZKROub6SlZuW976quYH2nch86aJ5ckUGZlm7Dlx49aYnSMy2YGMpw2Sikox47FwPX24
 gbEOhgwQxGLGKVpRNRPeGZBzwz/oAesk3yL28kEvttdPFdBy8XkFk2O8JnmLvN3hrfWU
 J+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697685; x=1751302485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJnApwJeyU8WjULXW91COnPvAcKQzP9dOx4NnVDDB/c=;
 b=U8XWEe7T2gux4Hzk/62LCwJibuOzY+o2YqjZQikHjdrsV3UvhM4sLTPFsAjSStsEZu
 St4p0Ti46yFjT2UA84XqqY6Jl4rXyGHeF386hq14rULrJSJcI7kpXf795tXzNSdz5kW4
 JwQYkdqjf1n67fr54bdMq8d2h0sXUuXqBL8Ok4gXUg5QWDlf9KYp90PtkpUxUILDxU6t
 lr9356irlScsC4f59fxrQUuE6WLI/pVvjo7Z6O0md3FhoeAQRtAmKMfUkyf06AcHkVqC
 PqSMN/PWTdaDBFfLRvIAs+qgUH9Z1hjyiqDzAGjORj6aBirvaeJeVe3M08O68x4Ns0oo
 0TEw==
X-Gm-Message-State: AOJu0YyWyth1Cbcl3wG1/0XplI64v3fvrPZmAFJ3QC/abRdC5m3Y/2d7
 BKhBZDQIq6KRsLAw7jLGLZAsbzF1S5T7jHv0qc7oN9qsZasMuM9GshmMJsxjj3ltPcKpDtEU33L
 lWKb8Klw7uit6mMb4p3RmUgqfN6QJYiixaMkdnc97ilT1lcq/cjub
X-Gm-Gg: ASbGncvdLkswyBcIkQZLPSFih9/l6BerzeAdFe9ZbjYnkV1fg9CoXD5osCowBeG1tdv
 Q45wDyTkqEXkuI9mYb5BUYIf0K7lxNuwKsapHBh8YocNyRcUYab3zlSgjH5t8XvIVPuTTxHfaP+
 rH1NlZFQzFC+Ei4jc2d5/WF9M0+JHSNXyaRlF6EsCopbJk
X-Google-Smtp-Source: AGHT+IHanSQatj6UUWuVO2BF6ZvPVJIIZvpaYmgT7p7Va2el2a9T1XmxljWeorZII5dPUyUvLgYnB42ZdvGbiT/RK0c=
X-Received: by 2002:a05:690c:28f:b0:710:f564:5071 with SMTP id
 00721157ae682-712c63b17e8mr210565587b3.11.1750697684646; Mon, 23 Jun 2025
 09:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-39-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:54:32 +0100
X-Gm-Features: AX0GCFuENpS2pqKrx194LF5iLFberrGMKchEZD8OH-DVLMBgF18P3OMMwPINdPI
Message-ID: <CAFEAcA9izgncq6ofRAnMNLHZM+KLMeYb-prymKMfv4yBK4WArw@mail.gmail.com>
Subject: Re: [PATCH v2 038/101] target/arm: Rename helper_gvec_*dot_[bh] to
 *_4[bh]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 22 Jun 2025 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Emphasize that these are 4-way dot products.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

