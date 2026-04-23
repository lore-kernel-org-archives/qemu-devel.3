Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E1FDEE38
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyOW-0005j5-HO; Thu, 23 Apr 2026 14:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFyOV-0005iY-9B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:03:19 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFyOQ-0005UI-2X
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:03:19 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-12c45281a06so9282840c88.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776967392; x=1777572192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvyuBq4TkDa7R80gun6yvbc/u5136huYQQN5iM/Bl7A=;
 b=Wolvt1SuX9dnozkeWHw6FJZMYaqtZwhWoe5KTMcbwIi8qv/19ooEKdA9QT/zu1wzJc
 j+JPHATu4IpcBwzuU0d60/f9n0RxBJtUQtGqn59jzQyNy/c92n8LXnj5szZQ/JSd/qzC
 5AA0QdJP5+68/JhAUcDAfHnlsPzeg0mRIU/xov51EdQ+HfO002fbo5TURQCCPjZncr6g
 6IWt5xdQrcVcFbHQ64Z3X5VuifTDv5jfBpuzj2wzcC5uuSAexZu5ryhER/0cOTQBaH0N
 NDIXRXHRaRKYGXX0FNZHgaIXrIbdZnaTuMHPm1XaUmhhl2qDu+W2LXESwRKl1p/fkRZL
 dS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776967392; x=1777572192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvyuBq4TkDa7R80gun6yvbc/u5136huYQQN5iM/Bl7A=;
 b=PwUM8UXxMoe18WMsSW65OPSIUQsmGe3vUDkZWPVPbuQZA/pdcNsguE52T235TkqzaF
 PWR9PU49DCfOLs1ODFhRHIqhoSsHynbx0F6SrA51OcQSL8vIAx6LC0pxnmO0n/yJSdF4
 51x4BH1/P6L8QWgnFHL5RNVxhdPJnfwfGMhsPyf5UjjEiNqo5Cyw2shmUskEiIqkWipE
 B/yRUxNuV4byBSo9249AIt5ak6x6mIU0GFRyiTtdx3Lsbn+9I0KwO2JeUGNaXKeoW47a
 1KPNtjc1sVh4J7TQeHlxpAnnWrs6UCylkXCecGRF/M3eu5dwYFzIzmZ88SeBNDgb0DOE
 1/Ng==
X-Gm-Message-State: AOJu0YwImvu6LBKw4l1qS2cd8yuXrWF7zKDzfiTYOX9Piv+dCtdJRyhk
 1HQW873OX+nLtNYtvraq5WhYL7TQZiXCnXVe7kjvcoNfpV74ranqGHaURcVGjkjC
X-Gm-Gg: AeBDietraKmEsuvi+ZC7MKnGbwDbxfqrElNSUw2gSa0PHKASE9+S/Fi9YGfaYoz4M5q
 eUtRtNaBaPLnO8VPKZMSwy3jc6sOdKiJ2ds2kyppnlb3i8O91Q9Hn/b9NlrFZmNoQwuChPeS3UH
 mk7+uxjqmqVK/yxFZQcvjDhGO8ebZyDGXiJy5hbRGUFV1lJImtLZXflg3IAZyQ5zia5jyklOSO8
 kMsUr6fhlWvJAPZ9Fgz2Iy+nLkK+wSwsyJA0uPOZtohMqqT3g8r39zZWzgeyT7bNIpiajuTw3Zr
 3w5LENF/moLX4u3Jd1PHyp3d3mzOPVlxJMvgVqoNT5DiA0bX8reqGTN+Jyf85SAhQB+ydkGJxmk
 tuMlDxN1nfsdk2JSsYqyLq25Jcywq2av8rpyssNf9PUaSOTqcXoIWa2JN8+cDL4GhRmTyyv0G2V
 uACkkNrEGXBV3WPZXzWhJSbEtDdS2J98cQOqFztDpwuuxEzyR1KD0hs5v40GdH8p9h
X-Received: by 2002:a05:7022:397:b0:128:bec5:1b37 with SMTP id
 a92af1059eb24-12c73f994dbmr15070826c88.16.1776967392054; 
 Thu, 23 Apr 2026 11:03:12 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12da8b8fbc4sm21367416c88.4.2026.04.23.11.03.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 11:03:11 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, mohamed@unpredictable.fr, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
Date: Thu, 23 Apr 2026 15:03:04 -0300
Message-ID: <20260423180304.53789-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping. This series has Reviewed-by from Mohamed Mediouni on all 6
patches and addresses all v5 review feedback from Richard Henderson.
Patches still apply cleanly on current master.

https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/

Thanks,
Lucas

