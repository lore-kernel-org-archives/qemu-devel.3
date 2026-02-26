Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B26FD8FCF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiP-0005Lw-Hl; Thu, 26 Feb 2026 10:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiM-0005KS-FO
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiK-0003ka-QW
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4398d9a12c6so817026f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121343; x=1772726143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+mciQe/DhwRxuQ2Cs7czBlK9up7Asg6C0YBSv/Jhi1o=;
 b=mJchv5gtYustaPH4otI6X77pOn+tmPkYFNUCctRoEj7fovNacU/v0w2IbKOiY4C0bm
 japM8rwGFeCxQj56ZMN5YyJFPWS7N8Rdgim4p4nVTy9VBCY4qUasbYiEG0dk/Ghethtf
 OmtltGe4u7fyVM8ZW/miNq5R2mMjP6Dmc31p9MKEguo972AkFLg+adC46VmL9d9aRfg7
 487NfDVbwMBiE4hY04VqsdigxI6dnWpYoao30BRBuyFnhQdSDx2XpcRzrErIv0fMUWZh
 MTZTFdgoMlYwoTCUyJU3EEbT+pmJXtmZZvzYwQ6iISaSVOjXCEnzjzh7d3NLtgn7U1+k
 fI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121343; x=1772726143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+mciQe/DhwRxuQ2Cs7czBlK9up7Asg6C0YBSv/Jhi1o=;
 b=AdPvOteegsCMeWZn+QUGN2uHFy9/ccYZHFi8Hn9YXt5W2q/bXz0+/0MfaorhmocBqM
 lTM950jUs1KtRo8D6c9aODFUZcMn/neeZuqu7+FRiyja93BPRfJWj9aKkCccM1visPiK
 /76BrHUm2r0RXXTCpnUMgRSca/ytg0N0LsJXbtu/2etEaO33XQqCS/dUmOXPxPqvtZ3Q
 AlmLbv4WPElHHK3Tvcjdz29b6nXlqA48vuEDi4FpX891jez2o2I1GyHqzzs8O+2DOXYy
 91dpCX2wf9nGck8H7tcaXv/xcvlHLzF7mtjK27Xa59L7lexQdWiNsQHOOkvuqSP69v4f
 f/3w==
X-Gm-Message-State: AOJu0YxYSINVUZEbmB1A4hx7A9OuomBOHb/FbuG6EebOS7uPsQ3ojYOp
 U0UvW330Zr3JoHvdL5o19a1HkfqHSt9ftdQTni7vUgLgvtFMr1fiIu8iEl2xX43dxBRhlGrpsQD
 WgvQo
X-Gm-Gg: ATEYQzwwjgsIY83GZScON8OKwH/7D2LpaOZ3Lz5QdqVoO1I430gkT9P8BJdkZXRnv4Y
 jd6oSgnVr8GuFZgJZhPUqr4/VgWNV7HKotK1QtjHek3mENXWx7G2RzxYpOBLzMTG7uE9V7Jb5kU
 V3ONKIt9UdVc1w7ztP8Fzy++nFVYdTIh/THyiZSx7mhrWKA7wJstBGepaAT3HdhyCajMcTcJe+V
 4aLXyNS33hv1ftkuBovSzFJ8LHdQYNKM+fnfAiviEPYyKJFOyKrujtWGw3XhI5Zu1BdE8l/8nws
 QrW3bxf+jiyEgX8vxVeRum74wzNZ5DgGNbb4rpslupEnrbug4Yfd5iJVQojXejFSx08RPajP6YL
 m4VR8GlwmlK+hz9dnvDnTDRO0otiA5s/B34eHn3ZjYoUgxKP+qOlgvo2lg6+h+MC91tBt9aFSe4
 0KDZ0c0RjkJ6MNb73nEdBkwtpSPBalw/2N6ois62OoYmjbZc8OezNZM9WjKUVanQhW34E7ryUCW
 C5ARERW6ZZiuwgARj4pVyivkPzzJEo=
X-Received: by 2002:a05:6000:2584:b0:439:8d48:544c with SMTP id
 ffacd0b85a97d-4398d485515mr15202578f8f.19.1772121343295; 
 Thu, 26 Feb 2026 07:55:43 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] tests/functional: Make sure test case .py files are
 executable
Date: Thu, 26 Feb 2026 15:55:20 +0000
Message-ID: <20260226155535.1171290-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The top-level test python scripts in tests/functional are supposed to
be marked executable; "make check-functional" doesn't care about
this, but it allows them to be run as standalone executables to
exercise a single test, as docs/devel/testing/functional.rst
describes.

A couple of files have got into the tree without the executable
bit set: fix them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20260212151258.1750268-1-peter.maydell@linaro.org
---
 tests/functional/ppc/test_ppe42.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/functional/ppc/test_ppe42.py

diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
old mode 100644
new mode 100755
-- 
2.43.0


