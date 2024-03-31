Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FD6CD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 15:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqxKM-0000GY-Ib; Sun, 31 Mar 2024 11:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqxKK-0000Dt-7c
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 11:42:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqxKI-0003AF-52
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 11:42:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56c197d042fso4012796a12.0
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711899748; x=1712504548; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jBSfoJgjUf1Vv0Pqinnb7SKY134AmnCk/qfPcavaNNM=;
 b=RSe1oUyQf2Op9mM4nmge/Zmy3bqM6COfIUFTl6RNPU9tR6oIe5ooYEpsSU3Psy5g0i
 X8F8Sp92v0WR1mOOncuR7jpLn10X6Wp3dj1RmecjnfHVxZdX8TM+XcA2N6bTqWm0fFe4
 BGgQ/mbMkhLt9hDWmtfY5TeskH6cCS9VtKRzxCVqTxMfw1uLyC7LxI99EspPonjH7ZGT
 3x+z1u/5ka6MrynrG4REXFgxw/5VE/MoK6u6lroYli8luzWe3Ciz9+7jYrI4IzXchuU9
 2m2tD1X88zHrFc8rkZesiBVi9AAzrhi6a68saiRlCWIFlRVq0q2VOFF2V+XDnh4d+HHU
 l3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711899748; x=1712504548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBSfoJgjUf1Vv0Pqinnb7SKY134AmnCk/qfPcavaNNM=;
 b=XbHEBMFFdqnx29RtIzjAOcAj85TZbc91zyhfmn2Qs76+TWc4+lud5uVqr7JT+bKPyo
 regxfx+N7KDqbtJXS5u4sNJrNMj/C9Uc/qV7sRq6c6AsIiaSWLd760Pux5vlYkUvgk2N
 +OAKCemwke69tuKpbx1BvRHAIRB4M4Iw42x2rQXkJswG6eWIL7x2A5MLYGY/4F+pWcJ2
 xRPNK93eaEBoHZQC14pWDZIZ950GNkvLlfrjVuwNHLLGThFkBVvQ88n60mJI1ODvzhYx
 bpajQWhCleCpT5ssQ/TTiKyOpXYOwPsEfLoVmO2WcKNIAxn+Y6oQ437pvRQEpQS+w2uq
 e7wQ==
X-Gm-Message-State: AOJu0Ywpw5+HFqwC3xoxDbrzbWGRekW+9rxhYiR+2JV2GHeC+fqTzqZu
 rtRL4K+k7HMpMHmjg5rUm+jzXf9/wSy04lunwTNa0apsEWtD773g4Y/Y3qBY1qxfgNzgZ7BMCPi
 9635MbrY6nfTzBUd1pXtd5dj2JcWPyN5iOiEfHQ==
X-Google-Smtp-Source: AGHT+IHqRRePpKqC4+QByc/o7dQDH8KATEmyMSDvVK2Z1sSd3XhTdhH4SWkTNvHLybPKhvGWas7hB25MQyj350Z6wtU=
X-Received: by 2002:a05:6402:2695:b0:56c:5a49:736 with SMTP id
 w21-20020a056402269500b0056c5a490736mr6095526edd.9.1711899747794; Sun, 31 Mar
 2024 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 Mar 2024 16:42:16 +0100
Message-ID: <CAFEAcA8Z=_BfKgdvvk2xoicSt8jGBTp+hParNyqaa4UGbM1zfg@mail.gmail.com>
Subject: Re: [PULL 0/7] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 29 Mar 2024 at 22:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:
>
>   Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240329
>
> for you to fetch changes up to dafa0ecc97850c325fe85cd87dc0b536858d171a:
>
>   accel/tcg: Use CPUState.get_pc in cpu_io_recompile (2024-03-29 12:16:00 -1000)
>
> ----------------------------------------------------------------
> linux-user: Fix shmat(NULL) for host != guest page size
> tcg/optimize: Fix sign_mask for logical right-shift
> accel/tcg: Use CPUState.get_pc in cpu_io_recompile
> disas: Show opcodes for target_disas and monitor_disas
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

