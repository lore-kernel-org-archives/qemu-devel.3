Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55503C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDbs-0004KJ-6m; Mon, 02 Jun 2025 18:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMDbc-0004FV-B1
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMDba-0003tN-Gs
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:07 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-606a4af1869so718697a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748903164; x=1749507964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vqA9W7+q7AoIPpvWkNkiM3ROgJ6NFWq8stsfZsfIcCs=;
 b=HPHZeij1apX4aA/Q3RIGIYqJoFitjSIEOzU/xjhcu34hG5i0bnTs9La5bcBWaFArXL
 LeIgHQNfSz7eJybGT7jmXGhFdoXKsLD34WKVLjYP1BWRs/ol6oD2OYv9aF5YW3gB37HW
 o9B/6Af6wDZCJlO7MIo4fnI8QXcxMDX/unJX5cFMXHsdLcdLBhrMj0vQEKF/HfPwFP29
 gJtnoOzv0+KMzED0Vnpb6H/XSOOfFg7a/e7VB6bQXkUh0jJ5K4jysmeLBpJPAKb7KJfC
 sUuEXnMnCzX6k90RVqiM+aNHpRFYraARVhlCbR07Jx+y7ZzVj4HN3R9UKKUV5+rcG+X3
 MOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903164; x=1749507964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vqA9W7+q7AoIPpvWkNkiM3ROgJ6NFWq8stsfZsfIcCs=;
 b=qM2tOWffpGiAyjx+CC7YhFDMPJEwHOX0YDBKru1VrwZwSxsU7pBomRNIFoSm0Xsu+f
 HQQ6qNQQBwlit0asoKUr/r/RdNz+BdDt5NtIwbnkQ9YTyDmookeBndJ6eiF7zI7nxfaj
 l0d8aHclG0fBNc3eu5auVKTh7AekG+yxNiuGjPEeVdyccx5kUfv/JvQ2+gQf631ZwjcO
 4DI8K14zDrroGNUe5wab+0r7z8qUf+jCBCcYiNqpTh3UaqbtXJ5m3512BBU5TayCZZ5h
 depE5NnaOh9bKQhyZbwv4M7mLtTPMy8ypTlmWXcMwk5ClwZoxTw7K93wcff4PCxa46zw
 VYdw==
X-Gm-Message-State: AOJu0YzvvXHbNvk5hf7N3BF0phd1OcZyxqgcLkWSdO7X+MJ5G35Rx2De
 OaDAYajqDhmSJP50zwULuw1XxfKnpSjdsLV2OEfkq2j1HqfzUhS3fQc+xaZddmIn5gAV357mwn3
 oxJ1cvRNMrzQarYEPcPOdeT4fgiwmsE+TJ52s7Zg=
X-Gm-Gg: ASbGncvVzmL3FUCDmaLf0t0DVfPeQU0cVchWxkNppldpQyu7CJs8EtPdjQmqk0ahCKb
 m3WqPpMRNA1w2LbaaHd1lxdWVaVdH+d5M9G2ZBZbdqsGO0A6XQ6grBVITeKBX2FHHD9a9e0SP4f
 XgVsYAz6k59xIHObCGLhnd5sITlpuTxG4=
X-Google-Smtp-Source: AGHT+IGMwkXvp65s+s3xDL/dknA5Skgg0rrJ3UTJ7sbHPANqqNKn16eNHN+pbKQl9hdGZd1g4ttGH6fwKef53uv5SXc=
X-Received: by 2002:a17:907:3fa1:b0:ad8:8efe:3205 with SMTP id
 a640c23a62f3a-adb36c28fccmr1348890066b.55.1748903163574; Mon, 02 Jun 2025
 15:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250528192528.3968-1-tanishdesai37@gmail.com>
In-Reply-To: <20250528192528.3968-1-tanishdesai37@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Jun 2025 18:25:51 -0400
X-Gm-Features: AX0GCFvr7_C2NTzv0IYWxDt1obcsTCycDt35LYN2piWBGCwIroYyrPCQOLU1P98
Message-ID: <CAJSP0QU-0f8Rbuk4Z6S6T_DSH1xq63Ai5gQKGzSadT08MhGQyQ@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Applied to my tracing tree, thanks!

https://gitlab.com/stefanha/qemu/-/commit/ffcfb0faaa95fc6ca007f7dd989e390dacf936ca

Stefan

