Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A075EC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEC8-0006ea-1Q; Thu, 20 Jun 2024 05:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEC7-0006e0-3M
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:35:03 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEC5-0001g2-Ar
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:35:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57c83100cb4so635676a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718876099; x=1719480899; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbBsbkBy2PdD0EA2Zs5jFS/sdRgXA2mOSZ7j4O4WgI8=;
 b=jzbQHIwdk8j85FPFAf1TNxoGofyzcS7n7mY7clxKEKMTGLgiUHYg472OOhdOTtyywe
 +uurQvAO2cC49e6hbygx6Ks6XBSowFK0SDr8Lr2okPHNsTfd0enPvoFH46GkcjnJcctK
 Yq/RR7ZLUJAVhzbeB9Si0OVtP5kn2LMEenT9XOBr95T6WSf8wTlp6QhrIMDF0Nlan6CC
 mmf4kOeGP5rNk/QkiVGMJCYxW9dnjBUIJG/3QHt+5uMVNfLCGt9w48bJDf88XEVPRkeo
 CcfOuKHZiKuT3Ggd8wQqLr8V2Dxr4QZLAaKwJ6EbR4LRlSH4RokwyN1CeBGEzS8uE7D2
 +DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718876099; x=1719480899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbBsbkBy2PdD0EA2Zs5jFS/sdRgXA2mOSZ7j4O4WgI8=;
 b=bDmgKkR9BHSSXFYS19cfaobFSIIx4DoIf6aEXe0xIXsWFHxV91xIjoltBN5RS2Ptou
 9SdtsQN0trXpKX0l0MMx8Sd+ZTdW6kNs2qJas6z4j/Tv4D2Essv68nGB4CuXSevSolXI
 R1BLaZS+GdhjdYfBwkxP0DrxEoAqveePwFbAjkGGLQNdKV/WT6LCWFS03014WJ3WRvF6
 KN32K6Gbk/KXthDzoSoSnIz7/IcINRcHcpeQuxsxUfAzxp7exPa5FxBzyPT/3FtBe+Y9
 +qIFHNrmC0DIek1vqOAa4V4nLvAdgI0Nu/DJORdluA1A7K1ge1iLVxdWGQZURl5gKXMM
 2X9Q==
X-Gm-Message-State: AOJu0Yz5KSOM/m+W20Ek1kaEbjawSxWP+8tb3yYfBR2mS8pHuOYB/s9c
 1GHGFXkpk5p4gCfMPfDRVtpawjTBpnCbNwpU1JZInyvWcgoW0QubYeqPH0n95d2D247pvX8FrrG
 ZnsaQWIzuBStPujbc1GqRMFA4gLD0YqzUbxYY7w==
X-Google-Smtp-Source: AGHT+IE35phRN2nwNf/Wsr76VOa3V9yap7XS7TajtluoMJs7DG5UtI04mDRzznLLHn/VorJM9H6UOnGlVYxXB73SEns=
X-Received: by 2002:a05:6402:3414:b0:57c:a7dc:b0de with SMTP id
 4fb4d7f45d1cf-57d07ee7906mr3004193a12.39.1718876099202; Thu, 20 Jun 2024
 02:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240620060014.605563-1-marcin.juszkiewicz@linaro.org>
 <20240620060014.605563-2-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240620060014.605563-2-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 10:34:48 +0100
Message-ID: <CAFEAcA9XbYr9jzYm908_stCUrZCqixB+cysFTRCe2MnAFW1FVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tests/avocado: use default amount of cores on
 sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 20 Jun 2024 at 07:00, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> I was wondering why avocado tests passed with firmware which crashes
> when anyone else is using it.
>
> Turned out that amount of cores matters. Have to find out why still.

This commit message confuses me. It reads like "running with
two cores will make the guest crash", i.e. "apply this patch
and the test suite will stop passing". I assume that's not
the case, but what's actually going on here?

thanks
-- PMM

