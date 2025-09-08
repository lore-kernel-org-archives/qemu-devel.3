Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B00ACAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbhg-00087q-CU; Mon, 08 Sep 2025 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvbhd-00086J-IC
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:14:37 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvbhR-0008Vp-Dd
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:14:35 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e931c71a1baso6092352276.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757337246; x=1757942046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9A/fWThKVR5buu9aunQ/bEewp35eOnEQ4EF3Rn1FUHc=;
 b=xMZjJwKZNF0QscQx1h0SGLfbHT8kjW2xCQxH4buPZVPgwPnhRrBKIaJ6cDX8iJj2W8
 oIZ7jWXBjU3KZu6d2N1U1T49/cACoL6FMh5pBKKnlnsqYMj4uR2T1WbUVFfFhtCN75sm
 sQqtBw+H1Mi4Q0sAgYvnUft+1N32cxNFDtFM8E+aLzoFAeTpW1aDC+spQu6CNH7t+EQk
 vxq2F7nZ0f2eB9njRvSM6yuCQMtOYvT5JRz2YaGMrUXH/e67EgJWYBExuOCAN7Tucjft
 LtTLcDXaRkJh8SO0OaFLLPrDx00DII388SR2SM2KJuKHaNH4a0xYkUAjNj3+nhcCmLEE
 w+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757337246; x=1757942046;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9A/fWThKVR5buu9aunQ/bEewp35eOnEQ4EF3Rn1FUHc=;
 b=dXbzkursJsaIwHmvLWHDmQ8NkuS7AHINtLNPXeM9637dSTBjwVyG/B9MnB8dPQHhkU
 0XpSlnH+IqrMFoC2P4SMmSzg0PuU6cycapLnx2ADZnYTLmmw3hhL504z3rRS5QxyQI3X
 a/pbkXKOAKgg7iuyCLlNXoxz15QJ2Dzf6Cw6Q9Ay36dft3olkFfPWoWOHDjbYQX27IUD
 zKIWhL1pVMCQZTO6R2Wjb3LfD/6AR6rn3p8Z2ZtPNkupTeUbe7Ih8O6g/eaCw3uzNtKy
 z0duSmANyohRJtCJyKKc02zKo6ib9viWz4fxcY3HaPIVJ7jnd9BNwn9XRgP8j8Wjejmh
 OYmw==
X-Gm-Message-State: AOJu0YxSbl4H7UbjJWtA6yJNvr1zJzwZTDlmKPhMHwhv2sVbek/MpQaX
 BR6dqqTSM6HbLbD6/nkIwjtf8pGyIn0tPmEDvOAwn9o9QMFPT1Fsl0kFyejAsmjTwHl+CeJubf/
 3lSpCp/QRJxNi1bZ9s1a6fw36EbukFXBepuOd5oEr9OAE219GG/WB
X-Gm-Gg: ASbGncun6HjHN6c3c6R/WTF/Bz7YRjiVQHmBRqCAnD3vXq7xJuagM21/4yPAmhNkPW7
 D7JwQ0y/EqV0W5NuAqXEX4mNApBTWylF3hju7GZnjCZRoqVyh6duMkpkfN4ssxBp+dI5+J+qvkk
 PgiVtOWGXn67hR/C1/YqK+k+9JRz43imgqD/ht0w5Iu38rthdCa+h9aLLPw2t4UydeBGLXjPu70
 hRXFkQ0I6mbuK6C7H8=
X-Google-Smtp-Source: AGHT+IFVez2FHQ6jYlGAIkWICzOZ2cMHhCYtk830tF0OLPRhvpBdowaspDJLQ8ecK4HzvhsjsXDUSphqbe2zba/dDtc=
X-Received: by 2002:a05:690c:9502:b0:729:afb7:2a0d with SMTP id
 00721157ae682-729afb7467emr33597687b3.1.1757337246273; Mon, 08 Sep 2025
 06:14:06 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 14:13:54 +0100
X-Gm-Features: Ac12FXxGZ5bsDyt888grX_J-H_zyMOrjN0TEDBOne1zL6p1JCbazhOHGUwLbFrM
Message-ID: <CAFEAcA9kGOre7sWjjEi1jAGkkNB4EVQnvq3u5fY79HZjSzSZHQ@mail.gmail.com>
Subject: should the functional-testing scratch_file() utility guarantee that
 the path it returns doesn't exist?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

The functional testing framework includes a utility function
scratch_file() which you can use to get a path for a scratch
file to use in the test. However, it doesn't do anything to
ensure that the path it returns doesn't already exist.
Should it?

I ran into this with the aarch64/test_rme_sbsaref.py test:
this does:
        rme_stack = self.scratch_file('.')
to get a scratch path, and then uses it both to place
specific files:
        pflash0 = join(rme_stack, 'out', 'SBSA_FLASH0.fd')
and to place subdirectories:
        efi = join(rme_stack, 'out', 'EFI')
        os.makedirs(efi, exist_ok=True)

In the original version of this test we used os.mkdir(efi),
but this fails sometimes because the directory already exists
(typically if the test was interrupted during a previous run);
see this email for the error log:
https://lore.kernel.org/qemu-devel/CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com/

But this seems a bit of a hacky workaround to me -- shouldn't the
test framework guarantee to the test that it's returning a
path that doesn't already have something there?

Secondary question: is it OK to pass '.' to this function
and then construct filenames based on the return value,
or would it be better to call scratch_file('out', 'SBSA_FLASH0.fd')
etc and have the utility function construct the whole path?

thanks
-- PMM

