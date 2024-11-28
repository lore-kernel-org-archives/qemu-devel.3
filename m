Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD96D690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc8N-0004z5-Ir; Thu, 28 Nov 2024 05:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGc6G-0005tH-Cq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:50:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGc6B-0004YN-Pc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:50:18 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso1131163a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732791010; x=1733395810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjBpOOdVZJL0iO2KTOgUARxPlu5YcxRage8kv9dpbo0=;
 b=eKEizpXAvjwrX/Sqr8Dx2VeDS5wASZMZZL3i93j/MKPkSyxqp5MyvvUiSYNZ6Mxzob
 zUD71LtFif/6PsPSFfUCyX7hzGB97EJ7t8ZK7zy6O1tbjQz/N9RLsQsguMh8/yUdepGb
 i6XWpPr0yIg8bOZrII3699jduXB/FGFKG7++CxRI+FDOMg+oI3pdbKmtE/ZMSaE1t28o
 nPwkM8QkuzTNARZ7Pjn60IwxPt9T+JXlWd/Y0a7YKsXpkzaDFEzNehhlHckAuKtLr/a/
 P0/6qMX05kht1vv91a+24wIJhsw3VwaadePSNgLpihiXCtmdzw8vH8ZpisiUoeM7rsxB
 B5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732791010; x=1733395810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjBpOOdVZJL0iO2KTOgUARxPlu5YcxRage8kv9dpbo0=;
 b=psAm4w4wTRYcuJR/x3x2XLnWYbo2vUwqFdCTc5Qaj+klprssvZpPC/TJjlc5ADTEnp
 8nXB/kH4TOxI6nlMUC1ooU1AXvCLRAAcKIIwUeF9nKAln2Z1auxwnC3G8tuClcpk7jdl
 OAIkFU8TKJQYnOFD6oCfP03xFmUYcbL/geIui5I8YDC14ghDTe3Nkhod8gxOEbqWpMUw
 b5XfC/tadLmmYN4OtquqURto8T4v5W0lD54rqFj+HA6HGH0LrkBpwriYYzZYT21xLcO9
 +3LDfTwoSNNTTA84GmO7tmIyMVqcH/njRmO8Z66NdD2EzClN0j9HqhghH/G2xVAyfcpD
 AZiA==
X-Gm-Message-State: AOJu0YwD3B9VrOm6N8gTDhRsMYVjnulX1WoOabLsLaaRFZrICjm6r5Lw
 /+KdlX9ewFo49nRJfe6aaJS4Y9vgobDq2yFVW5UTjg/y/PHKyUdQgym5Akpm07xVfj5tUX4dQA9
 iTDxgCanzqD/fOGDU5ee6KlVMNGNSPZsbcOX24Wq8RQGjIbzp
X-Gm-Gg: ASbGncsizogtTxWR5eXc9jH6gmPLsZQcfsRWm5xbhllPdpHUNIgDLG6xaJkCZ3jIVIt
 ivCIeqYq/+jrJc6/iAUFwKDJTJQhAfLS9
X-Google-Smtp-Source: AGHT+IEpyCbwfiIyh/G40RI8wWh+DgsRJI1Y/+3SY1Ku7urTeqwGSUefGfDcb/DqNTum0xv3SstshLR6rBKjtL1AyKo=
X-Received: by 2002:a05:6402:278e:b0:5cf:c18b:b0c0 with SMTP id
 4fb4d7f45d1cf-5d080bd9f5amr7442559a12.19.1732791009929; Thu, 28 Nov 2024
 02:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20241127103425.378289-1-thuth@redhat.com>
In-Reply-To: <20241127103425.378289-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2024 10:49:59 +0000
Message-ID: <CAFEAcA9=P+aYEuKZEDZQPLNKzXNkj_TBYRYhPBGPtSjQwz=Kkg@mail.gmail.com>
Subject: Re: [PULL 0/7] Misc fixes for QEMU 9.2-rc3
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 27 Nov 2024 at 10:34, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 7872e5fdf38ac0d8d0083aabb98d67da1f530e=
f4:
>
>   Update version for v9.2.0-rc2 release (2024-11-26 22:26:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-27
>
> for you to fetch changes up to ef45f46f382a5e2c41c39c71fd3364cff4f41bf5:
>
>   hw/pci: Remove unused pci_irq_pulse() method (2024-11-27 09:34:08 +0100=
)
>
> ----------------------------------------------------------------
> * Two small doc updates
> * Fix the flaky loongarch64 and sh4 functional tests
> * Refuse to compile with old XCode versions that don't work anymore
> * Remove an unused function from PCI code
>
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       docs: Document that hvf on Arm is supported
>
> C=C3=A9dric Le Goater (1):
>       tests/functional: Remove sleep workarounds from sh4 test
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       hw/pci: Remove unused pci_irq_pulse() method
>
> Thomas Huth (3):
>       docs/devel/testing/functional: Clarify that we have to use the buil=
d folder
>       meson.build: Refuse XCode versions < v15.0
>       .gitlab-ci.d/cirrus: Remove the wrong CPU and RAM settings from the=
 macOS job
>
> Xianglai Li (1):
>       tests/functional: Fix the running test case causes loongarch64 to h=
ang



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

