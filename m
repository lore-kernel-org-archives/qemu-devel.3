Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0B3CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrGTv-0001xw-Ld; Mon, 01 Apr 2024 08:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrGTu-0001xe-Oj
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 08:09:42 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrGTt-0003pt-6C
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 08:09:42 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso4418461a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711973379; x=1712578179; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fHaOjMpLVLU4NQizzkEQS34+RNCTThnP9KUqozNByGY=;
 b=CVlB5IJa+m++BkoYBykLZyh330GdN29YJvxtrERYnSi6YqBUzI6aSLADl9doWNNh1k
 7riNPHEahDJmdAU2kBY3i2iI6HtxG3ca/VKEGHu1pofz4r8pfPu7xvXdQiVoOFu7d6hX
 TLhjwI1ymsarOkGy7dYZNHB4j5qiisgQnyVh7yxtZqE0+gOJhq0uqJLp+qFW/0DbwNYs
 k8rtTZ+4qo//92dbhmzuCgRO08dLTHRroblKc0FKxlGpDjp37Bttr63dYoLrxH8wWtyB
 izLkVD8Qr/I+njADPHSKroyYksB7Lmje9YdBxwyOPRaaECpSNOnW4gHU7jDyFfztMtU9
 iQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711973379; x=1712578179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fHaOjMpLVLU4NQizzkEQS34+RNCTThnP9KUqozNByGY=;
 b=pbPe4ceRssOi9Bcq7hBVYbtrySDtfj23aHL+EPfQeIo05Hmt9vx3ceB5PKHQ1uVbxF
 9ECZL9xih/MEbY3w8gbM94LosGdI+2KxWbXf0f9jaAkpqRsCPEgzZIEfnpduJJgB6n/4
 vdDvCBmSgrbyNfcGvJq2Q1uz7UlDRUcW9LKvCi1SEHR+R6wRBGPFcwszywe254emGiOr
 gaaY163+vmm2qG0dM3lgZ1RJ96YJdUa9oAI4cUAJACnU/AVW6xNRm7NQXjJVjMr3/fRS
 647bDH22ROKwbV6UgJ+KNAj+PwzGP/w572+VybmDRUdsX7UAsLkPyjSYxMoQwofympsx
 46tw==
X-Gm-Message-State: AOJu0YwZZoXGWHhNje57eN5yvy2+Z1mdBvpM/L8/gyO7fBON8QM/zq8g
 Vh4SxGKW5QMWEF8/jucGdgUY1kOi7X2P27Kj9brXajh61uuOhhB+gDMsoZYlEUHmTUKZzMG5YIo
 QJr8cs127mJHmBt0KMcTFO0/jYeoiBHWKmd30JQ==
X-Google-Smtp-Source: AGHT+IHs4gGPaamj87RmSHjFxc1/E2bAw/5b3lH9IoowTFvipXfZBju0B7J7+s1wxjv2Y1IF7boDVbs6+Dps0AFWZCQ=
X-Received: by 2002:a05:6402:50ca:b0:56c:3644:9945 with SMTP id
 h10-20020a05640250ca00b0056c36449945mr8486257edb.7.1711973379241; Mon, 01 Apr
 2024 05:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1711702001.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1711702001.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2024 13:09:28 +0100
Message-ID: <CAFEAcA-NDp=Zm84i4SVj91XmkSBTXo279dQj6+OmqeCifTLw+w@mail.gmail.com>
Subject: Re: [PULL for-9.0 0/2] 9p queue 2024-03-29
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 30 Mar 2024 at 13:39, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:
>
>   Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20240329
>
> for you to fetch changes up to dcae75fba1084823d0fc87caa13f0ba6f32155f3:
>
>   qtest/virtio-9p-test.c: remove g_test_slow() gate (2024-03-28 09:54:47 +0100)
>
> ----------------------------------------------------------------
> Changes for 9p tests only:
>
> * Fix 9p tests for riscv.
>
> * Re-enable 9p 'local' tests for running in CI pipelines.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

