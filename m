Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F336ECD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 12:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXXK-0004Jv-DS; Wed, 10 Apr 2024 08:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruXXJ-0004Jd-4j
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:58:45 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruXXH-00037S-JS
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:58:44 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516d1ecaf25so7168429e87.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712753921; x=1713358721; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKvCrGvZ1LWDGk0Quz6PXclIVO3Vu5uBo+WMkiNlaMw=;
 b=Y51zMkGLxkqGLriO2PR0A0NHQk5YJdncWINKVt4hgAEoNRm8lWy5bjvAC0Q/g/Off2
 Rzw3Nlc4AV3QXn3RqPKAKbgj7fNr8NtK65i53W00t9pnmx01/UdNT6n0A1wzLfT8mn4x
 2a28sptEOgpbVtaKWhcHIfCrseIxP8aGzHGKwRCh6L08crAHK1IIrE12++n2XldmW3/c
 fp6gP9EHGVRPhGblyB63P9UBcLctSC42rkMMnsuVn4js0tw0YAgz+CVFcvDl4hrxiRPd
 cA60tJZVUIihaxa6udKH9sxk4OCo7PxwSvlDOczdk5xaivl+7l6/QfNk3TokTdyFNNyB
 FNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712753921; x=1713358721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKvCrGvZ1LWDGk0Quz6PXclIVO3Vu5uBo+WMkiNlaMw=;
 b=lIQdWznwxdgda+X6CMgJXm3nt9TbiA9Sf58r7nkrE5yfwJxxEaRxiYW/wt67IGJUwV
 YumgvSkOB3eOjcdf1r/ElGkl6xmX5A5sgNp0BGeU3OSGMatlAaTXWNQGa3oFoRuP7Tcm
 louUOlpdQM9J1Y2uhCvp5zdQ9hrkgBn7U8cghEpQT5bbpJAIGsxWTDgBqK5y2w2ZnVmw
 lYembTnlBR7uMnagfuXwKgKJ5H4o6gfiV59VniAQT003IIKk1zGbX885cXSRT4GBornI
 /nW022QVhA1W4KCB/XUftX2DQ3+vhw2A0LnVWSPh7tkQ4Wt+YFVuvTD2hToo+FfKfLdI
 TgLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPZdgpJUhkaI9VWshQMDARFHB8ineAguhBFxr3TbQNvVilKPzcrbdxLg528bCvnu1rJRtkew0FKAKfSuc3BFmLx3uer9k=
X-Gm-Message-State: AOJu0YwSgpRb3tk6C0jWIka5nR0o4xjSwFNrjtVy7PIi4luGBPTjJY5a
 zA3XKa76uEVDGL06R2WdrWVdEuGqRqeFn7CBreLIs9qOobP1iKImEoEFOp0ntYHv44zhiYiFyZX
 0OQGbt2P/z/69yl9BnHUVNaxaUPA73CKcYtT0Zw==
X-Google-Smtp-Source: AGHT+IGY3qxYAPQnZHedlS5ZvJPVGgMfJXGJpMhF819uJ7f7v+OFs62oF528wIFE+LEwBr9AN22tYAx085Y9jAVx4bM=
X-Received: by 2002:a19:6445:0:b0:516:a04f:d545 with SMTP id
 b5-20020a196445000000b00516a04fd545mr1527255lfj.27.1712753920972; Wed, 10 Apr
 2024 05:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240407081733.3231820-1-ruanjinjie@huawei.com>
 <5afa6458-808a-df3d-a734-53dedb0f5aff@huawei.com>
In-Reply-To: <5afa6458-808a-df3d-a734-53dedb0f5aff@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2024 13:58:29 +0100
Message-ID: <CAFEAcA-TQxXR08YkijF-WW8mP1LcTfyRy64Rhdh971OnVrAmJw@mail.gmail.com>
Subject: Re: [PATCH v13 00/24] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Wed, 10 Apr 2024 at 07:19, Jinjie Ruan via <qemu-arm@nongnu.org> wrote:
>
> Ping.

As I said in my reply on the previous version, we're in
freeze at the moment, so this patchset is not going anywhere
until 9.0 releases. I think it's in shape to apply after that.

thanks
-- PMM

