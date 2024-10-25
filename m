Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C540D0C611
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Kie-0003zK-G6; Fri, 25 Oct 2024 09:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4Kic-0003yu-3D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:51:10 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4KiW-0004b6-Rz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:51:09 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb56cb61baso16761541fa.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729864262; x=1730469062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GdAxVDgvJkxWWe3dRkCAhalh4HkMx3KYkW/pl0Ou6xY=;
 b=P8vxNZpHv8A+Lxnw95JwSV6y4m4JvGPAjGTekdtoeKXnf4fUP120CVBpvKQTeJPs+P
 McDlv6EFMlBFthP23zAXtlSofEt9GX608Tt5F+mWnn7f/YpUtYfSmnGYXogbIivWelpX
 MXXfcWNI+aJA688CsbjCm3iVBXYyrZ+mw6FG5L8s+E5htWmGaXK6Af6QfQA+ME3Ri2Lr
 9LbBQjNSKAgi6xuBQ6wlM8vhCC/Z5x/rnl/Ja0dD/1rJHHgEjILBSJvx67wIOgiA7w5i
 exodRUk407v6dUskAfUaF90nnv0SsMyq0E9spKAw+UVoi0xi7mmWW9VCNi82WWwShi/w
 hPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729864262; x=1730469062;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GdAxVDgvJkxWWe3dRkCAhalh4HkMx3KYkW/pl0Ou6xY=;
 b=egetvyTjaA+6rB9xBunzWcidcouLJPTnY7Q3zIV+4f/wYctbLx26Ijv9vFEgEmJCq4
 +z641xyuAzvVn1NQnvOfGBDn6kKQpexd+ysuxcM8M+iUUhDwbleSx132N00ZyMNQ0B3+
 VEtx8UOGtqpu1Ma7KnL6dVeflH84MFxvqXR06XYw/dAsdS6jjffkJvBRk4XweXc/LdZl
 HYVS0wfoP8m+S4vaWs+kDNNn91+JQwdjj39nKP0SszZKhla0dDu8n86wsjv2v0c1+Dre
 pGw3J+k6ufhELsHIK2hCqEU18TAnKqraZN+FpC1kYUHk+UJ9p7J5Oq0pn8kQXr1dDQZ1
 D2oQ==
X-Gm-Message-State: AOJu0YxM3AbjdUdfXp3PkaZqnDt/mAsnhQLma9fk98RO+bAoplDBQrCL
 RCeHaYAk3V1QqSRbAO37JEqkTagIMmlJFH5loOxukHyjvRU4aaMFSmLdJma/nwR+pL6Q7eePZYT
 PxCdWLc6VBlnFq/BealZ7tNaF2ReV4MEoW+TMMX+O7Ypp0i9D
X-Google-Smtp-Source: AGHT+IFnhEebnkWP7FzfwSSsXILUBh32Rec+fZAnBfSFy5hnOfemE/vIMAy9o7yvYbCQGupVcf5Uydd+P9EeA0xvi/I=
X-Received: by 2002:a05:651c:507:b0:2fc:a026:bb41 with SMTP id
 38308e7fff4ca-2fca026bb99mr55248081fa.15.1729864262063; Fri, 25 Oct 2024
 06:51:02 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 14:50:50 +0100
Message-ID: <CAFEAcA8DE=i5X_=GxqrupOMqrQ6-BoL2HWo_GPe1pNhL15QU5g@mail.gmail.com>
Subject: 'make check-functional' uses lots of disk space in build tree
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

I notice that with the recent migration to check-functional we
seem to be using a lot of disk space in the build tree: for
one of my build trees
 du -h build/arm-clang/tests/functional/
returns a total of 4.5GB used, for instance, most of which seems
to be guest binary files.

Shouldn't something be cleaning these up after a test run?

thanks
-- PMM

