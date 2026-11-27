Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9E606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E+oSaCHZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWsoM-0004hV-Nw; Fri, 27 Nov 2026 05:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWsoD-0004hC-9d
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:04:01 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWsoA-0001eH-DF
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:04:00 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67c246c0c60so6453054d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 02:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795773836; cv=none;
 d=google.com; s=arc-20260327;
 b=nItGpj1QfCu3UvYGIg/o9AjaeJAHU7IXEDqZ4SI7UPxXRKF3x8TwhLYdyuvibmKAo9
 MJoKHoHDSbrBYgi5hbnMouFpCZrIUhzscuyF66efOEYhH8UBhux2srjEwSp0TjJAroXq
 qWU5+NCxBzzE+x4sPgGZAjNTFvPiAnj9JJmOIEXiedAlzjRwcLwFU5tGxpZkBo1b6RmT
 nEJr1NTXunOWp8VrlGc8DqHzOKvI27xZzJTS5a9/8a5eeN+LoamcnRb+58iZpY/CsVpx
 FZg3p7t08jNjHcoVTDyBIMJUxgkdXFz6zHvQidPZF4Eq1Pe6j7dvqvS3/4iAO6+Nv8r2
 /xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kbxysfJErPwZqFD8M/2bTYTLXYR4kDuglX2PAXfeuN0=;
 fh=6CE8jxAqEF526HSqlaLPR86Lv+HXvioeH5JzMC05K3U=;
 b=qXb3W4nxqDdw85EoTIxuiNVypIZUjekb5axkdG1gmpfNnHWA6RJaJ903/BBNb4lHrM
 0L5ysTAAQ38Y1zWWYHNKDEcHitWGmarEy8BkVYFShhvv+rps9j6oyutvkecA0P/cbRNx
 Wejy9swEIEAKVuVMdWvXbQKWztcXyrJYuBndwaNE8Axu6sMGZdB2a3/NratCYNsiLnbw
 46cvcocXaMUfTcfAP4+Ds6K70t4wMkXEWacEoD7F/bHbMl0I7KNkdqes7h4HC3s0OYlE
 4DO+NZt1xlHTnEmaLvxExp9bY4jeHZmaBcDfQKLdnz4KSICXRtOTL8K6OAjwwi/yhs0w
 uO2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795773836; x=1796378636; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kbxysfJErPwZqFD8M/2bTYTLXYR4kDuglX2PAXfeuN0=;
 b=E+oSaCHZiZqf4he4haF0wc9UiSRjZxoaiuMWXGYL4nhl0RRL6fCztaRIpj/s0rtwDc
 XBCnzMAxWNifbatlESyAfhyobjlDD9+ZUpRtF4MmjZSwdGNBfPkaPF+n0xcisRu0vDpe
 KHw4H8Fx987/6C1sdJNG8cdeGqVTQdVirSwR3W0qdztQ+L00L/wh4F42wd3IhN5qQSl3
 h8gZenqDunqSCrM6CaLaMsghzYnnL9V+OFqosPBjHDiF6QbXwMzVVc1AMYgE2q8MSZId
 QwV2EmlzSMPgDRhiulPU5M1N/sMFHD9pixx4Hce3GPAs2t2dtlGc1K2i5e+19rYwOtES
 w21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773836; x=1796378636;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kbxysfJErPwZqFD8M/2bTYTLXYR4kDuglX2PAXfeuN0=;
 b=fePVWlUeYM67zmYxsCHcmUKMQxmiGcvsEqU/vgBrTqU5uiEbte0r63hLZkhPQ0OGZo
 NgdxF1jYxmeujZ252nJdVfLzXcfQz6zhofwUXBs5ksIf210NNq0nn5JFuM4dM5SPI6eT
 SMwPsBVkFCPqLnR2lTLX+E2w8hW12AIrmFnbZJWrMmei/RfsIuxcdhhGjvyDLlby7uOi
 kHEPb+Hgkyw+d9TIomeUhYV9JIhyrtfeTgYC12COfYOv2ravtBxk8Iysm9IF3HDzFoCP
 WM7Otp7V5NPaI0va2sFezRBNQczCuKyo8cZYK1lHzUi/ePLF4kN/ktbSJ8m1aTFMhAbK
 dtdw==
X-Gm-Message-State: APuU4Z+gJhEtqp3AyN87vJJEF+NXzz9iHu0HxWosGk6DSW6oynnkXU5E
 k6sDvbaqcTVcOnO6BTLk5+10hn5YdbPptYPscvaLKm5TYyjEK6/39gW6EycgQoAZGd0JsCGunfv
 RS4+A9jdEeYPFeXY9Nwhuy83X3Z4BB6F5+jNTbzlQOw==
X-Gm-Gg: AZFdTZfH1qY9VbV0Y2ELLFDeOSVU3JYVYAM1Az3KUARg4geI8oyVJY/XdGwwpo+Disw
 TWyXDm9BruR0PNdg40BLtARc5aQgkxR6LB9AzuKX9ZySljEfPvb+mjbFOVOQK/rnqmMUEpZCUKM
 seA3gB20q9ZF15fr2BvAJ59QqNhxKZpM9xetaZpl4Ky132Z/hvIQ0ZcX6bQ15ifvQIgqZE/DONH
 KHTcK9uSPA3b/SA9i5siLCyuc+FgwDVZjdM1R/09MOjtKaRVMB4VfHnxlez1Ys66p+vLLgznLTw
 K283mx2RKjONXKmy7+p1kPXpJMg6H3qqxagih9f+Tv11zCIcD88WzS8uzuIsaOpEJXMzTkYb2wF
 LPPC/Zv4pfOSe5N6jfTEuXFYP2ZuvbqgQ4Ned2D2EXQLCF9CuRruY9PMhhJCJjMy60vl3XTVH7X
 MyU5YVOM1ARiLoffhv9Y5t82aBosA=
X-Received: by 2002:a05:690e:450e:10b0:67c:744:f66e with SMTP id
 956f58d0204a3-67df44077acmr5355447d50.9.1795773836468; Fri, 27 Nov 2026
 02:03:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125-4729-out-of-bounds-rx-interrupt-idx-v3-1-18d377f43be0@gmail.com>
In-Reply-To: <20261125-4729-out-of-bounds-rx-interrupt-idx-v3-1-18d377f43be0@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 10:03:44 +0000
X-Gm-Features: Aa3M54oB3MYSlysyxtcTNNPTRt1bRhyiuxp3mutwljJvxyJYlBghbRK5vabOwYk
Message-ID: <CAFEAcA-E_s3vQjSW29SLTtC7epBC4koa80P-F6wqkM1+vci5nw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: at least one TX queue and RX queue
To: Andrew Nguyen <xmphyr@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 at 04:03, Andrew Nguyen <xmphyr@gmail.com> wrote:
>
> Require a VMXNET3 configuration to have at least one TX queue and one RX
> queue.

The commit message should have more in it than this, which only
states what the change does.

A good commit message should explain the "why" of the change
(e.g. what problem the old code is causing and why the
new code is the correct thing to do). In this case for instance
we could mention that although there's no specification for this
device that defines what happens here, having zero queues doesn't
make sense, guest software never tries to configure the device
that way, and other parts of the code implicitly assume that there's
a non-zero number of queues, and we could say what the specific
case reported in the bug is.

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>

The code changes look good to me.

thanks
-- PMM

