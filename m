Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ronT1-00089P-Mn; Mon, 25 Mar 2024 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ronT0-000894-81
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:46:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ronSy-0005M9-KT
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:46:33 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso8128955a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711385190; x=1711989990; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YCKLSLkWgkm5HE13Z5LJ4E4jirIaBuBPSlUVzDT3E7k=;
 b=qwHUY7jyq7wRARjqmiGOD0zmf+Pp2kqssOGUAskwyqLukKd+lp6xkNIk98oXr68/uy
 wKGqSmI5RIKO5fwRix/sfqdYZzHNCOp4kDo+VvAb814orChpbL1vpLxjCwNxUil8bsVN
 Q58GC+fKdOZrAB8P8OhXbwlx4AxTSkZRCTEVMto9nrqlWGI+w0mGEDS+HQTUORCwXXcf
 5VZeAb361ECY6h9IroaX6F2Mn8NO5Eetzzzwn2R5y54o2fTr5mS2fNHebtSNMPUyAmE8
 i8BnF71flDbvBccAe9DoutQLSASEss4OfBuv3AGwGrw74SjNjgvd4OBHF6kiG4mBm9s4
 oZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711385190; x=1711989990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCKLSLkWgkm5HE13Z5LJ4E4jirIaBuBPSlUVzDT3E7k=;
 b=L7giw2Mj+Z+318VmZUeE2N/mVWKmu2fwPit59qC22t+qrdifRYC2ie4uKEaJHACIdV
 fE6wm4amdjnNa8Wx6WHeOzoAJ4VVbYvMx/xbvSNyrse4l3NQI11tD6s7WKgMEmbVm2EZ
 t2qoSfHuk6WrfUNRrz5QSpxMtYD3sHhL+UPPMO32fmpnlSLywJHTrLimWr3SjXRQfK2L
 optSxayQsFPDPpMyixNsbEgU5jNMywBd8XFJbfTwYl8q+ZO41Our5o0aC26iVhDTz4Fj
 umNw2vb7jrzdds35WDLhKvAqKejXl924nRQsQ6URm7tKNk61vlEsua2DDGliFEM54yt4
 SGag==
X-Gm-Message-State: AOJu0YzxzjWxZPIDhSK8f2OUjGaSSquCr4yR2Mgq6aeCKiBsSvUkwOzJ
 6OZYRHcAcJwH76CDe7uX4m7X+f56354TfTCV0Zr18dsoRvs4jv1Do9N/zjNsyzQXmmKcLZngh6C
 qb6XhGWTlASIk90KGBvm1wcWGiRoIbWjy7w909oCy9iwrAGCP
X-Google-Smtp-Source: AGHT+IEVfA2oaLufONTSG7XES1YZjF+JdANQl0eHymo8AKkNnDIbs6xI6/XYlFFR/lT4LIQd7dSz4su4gl5Bf9N4Xpw=
X-Received: by 2002:a50:cd93:0:b0:56b:d013:a67e with SMTP id
 p19-20020a50cd93000000b0056bd013a67emr6062860edi.18.1711385190638; Mon, 25
 Mar 2024 09:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240325141210.788356-1-thuth@redhat.com>
In-Reply-To: <20240325141210.788356-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 16:46:19 +0000
Message-ID: <CAFEAcA8=1sgvg8BN9Len259dS5SOJ5jqcS5hU7yXhW6mvEfXow@mail.gmail.com>
Subject: Re: [PULL 0/9] Patches for QEMU 9.0-rc1
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 25 Mar 2024 at 14:12, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:
>
>   Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-25
>
> for you to fetch changes up to f9b29c636442e917a56a725d774ea99be3b28111:
>
>   tests/tcg/s390x: Test TEST AND SET (2024-03-25 15:05:59 +0100)
>
> ----------------------------------------------------------------
> * Fix timeouts in Travis-CI jobs
> * Mark devices with user_creatable = false that can crash QEMU otherwise
> * Fix s390x TEST-AND-SET TCG instruction emulation
> * Move pc955* devices to hw/gpio/
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

