Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C92C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCmc-0008He-7W; Fri, 28 Jun 2024 10:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCma-0008GX-JW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:41:00 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCmY-0007g9-Tt
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:41:00 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso967766a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719585656; x=1720190456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hf8XLGAZOedh1xLxSTRr3pStr608/5oz5NGhPBnTLHc=;
 b=HjrAlSQuVMiniiFffQuwbkruvZZjQ0zC3kLbBnXqEVkcl3WcFpAElnpDswH1zrhgXB
 8vT/Fx/ktiV95WtdpsYHqhQTwepZJtQDxm7NbiNU4Zj9GaY+tOqdwsw4aGNKYZP10M0S
 o52YVmsVgRfoat3vj3RDpJWysCnhQeyPaTDkSaxjFdnEAbKgD4DnfAsmTBNCTPe1a9I9
 7lK2gJPkxfJPCvUBhMDSp2xkGJnWigfULHd91gIDhEvU4LHNx+2yI8+5kR9wSmr4IpZ4
 Gxee4QL7M2alkfuCBm2WToUQnPxbhHVkfnwXXqGvmTrvmih0d+WfpEYV128ZKjTCmM2g
 gVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719585656; x=1720190456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hf8XLGAZOedh1xLxSTRr3pStr608/5oz5NGhPBnTLHc=;
 b=unogQJobQUyflAUBVTcBNOddEHrg1jIr4HwT5d4VW+ly7X7NwyEpp6ZVMDImldKnpb
 9sduVLrIrOUPF0M00GO59Xni17KVJFrBVj0f/jsYMXn80sZbYym+WixdcHeMXE5TNgcC
 mpCKj0hiIS3rhcccbWlvamzuPifcjZL2KeMOaxkLnsIItcgoHvFHZagzjyQbvEVKSrma
 DMl4Ht+Pr+66pEkqkTEJj3FTY76imXXXFJoZNEz8+yQhQcZG7n0bx6xxcZ+4l7t0ysbp
 j8umgRPkzsrErrtNPldsnA7mtTOot7hR+wtTUIfbz0xQiABylHzlibrU6y0DvIyNeWij
 rUKg==
X-Gm-Message-State: AOJu0Yxg7T6agNTT09SQ/RVZTrIavXTqloYqL6/t5fKEvRbIgrvd/RKz
 n6jsQYI7HuUby8GKaYdPbDHxaZjBXnJxKsbwHRGAImX0vuNtu5+cJTEoQpIdR3luNlWor2x/CXa
 f56NXajlRo3XYlHtnWLm2tozFuq2eEGQVXzbgxA==
X-Google-Smtp-Source: AGHT+IGCzwp6GNCxZBNlGXWAv9b+OLZv6V/lI3qeRXi863RVvKcO1WsMyp6QVH79zP1Y4ITJQHbpPibBPx5d7PitKW0=
X-Received: by 2002:a50:c30f:0:b0:57d:40a:583b with SMTP id
 4fb4d7f45d1cf-57d4bd836abmr11612867a12.20.1719585656102; Fri, 28 Jun 2024
 07:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 15:40:44 +0100
Message-ID: <CAFEAcA9C2cs4QRbyAJEqTU9rhFDbgDwDRw=Z34WP4a8p-voACw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] target/arm: AdvSIMD conversion, part 2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 25 Jun 2024 at 19:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Convert another hand-full of instructions, plus fixes
> for two issues that are related.
>
>



Applied to target-arm.next, thanks.

-- PMM

