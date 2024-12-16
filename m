Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D90E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAaf-0005vf-RS; Mon, 16 Dec 2024 07:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNAaV-0005uu-Nm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:52:44 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNAaU-0004gF-3w
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:52:39 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ef7640e484so46164507b3.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 04:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734353555; x=1734958355; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=63E/i74m1LxbnTcLTan5oHOLhsg/qfnYdIxa1kSoZM4=;
 b=yGMZgEfOID2cOzuTud3wBodIeUIPJMT2wbgSQ/IOuLYdBnT9LLF24/96KIpAi2dbXS
 9vAaJ7XEj/oEKbFXx2a0g0kJGZBDHI4AMhHF3ktcjti5mUrUybkHM2R/IBff0FeFZNcV
 9HOmSvvGV/CbOpvRNGuSQPwjcMIaflsBmqvTkZrtAze7wMkov4MOx6/SSCWbnucEObKv
 xfwqgAG4yF3ZFFxUE0Z+clHNHgyIY2DFY2EN22DF/9BhEeddtdQmZeRlDokjccDaVSyN
 DwA9ACgF+rrnLetVnpotr++acWo7VWIb8yOsb4T58Gw62APt3mdWrfIoqgeoCdCXFl2D
 v9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734353555; x=1734958355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63E/i74m1LxbnTcLTan5oHOLhsg/qfnYdIxa1kSoZM4=;
 b=dCK/hCCsa0KkjlQO0qVblGzUlYFS7Fk2ki33Q75r467WiTlIozAMYNs4wVuf+PsHin
 2ULUccElBlkn8VSTrVOKOxcYVu4glflZNzfSFlIQfqRLkpV5c5yKokEIEKof7OdWdLTC
 zVZGPpCTZOdaeIwA7FJDmCZutKZ+d44dAVBLfb1HYrM/ay4EjE/QfjCgEBUxyOJI1v6i
 dJqJv6dN5K/MCj5vTz3Sid8z9X9CsBd6tr4yuQzu6X7SabyKcDNBkrCvC819HL9PdARO
 f8O5gaHc9iygTfKdzfEbbuINRyo97AJzTrwQaW+d+VH+o0rnUt1C9yryqEA2VdGC+Iwk
 ZYsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzEB3vxfAbNGmY44iey6t6BkKXaICmTQC7ZVbb9ol1u14xE3xCw2qCefKEN6KsZbCe/vIH5aN60pT@nongnu.org
X-Gm-Message-State: AOJu0YyNdCKGw9+lOmmeLwuSBFeuXNqO2azOfkVwdbohi2gcYrTFs8/W
 HEaqP4gFzCwPBejjaKyDtSWBb3e0fNVSmvbQQcQT24n1xnIfU3M5fS121LnRRmmHqllake81clq
 YyfccDjrKTo1ZkHFoqtrbBwfJ8i7Qc03N4Ec/rA==
X-Gm-Gg: ASbGncuKvyezjgMM4MPmJNmJ4qZFQtPzRJJr+TGwbHiDLOdQQ0dvCcB9zZZ6sWr73s9
 /+1J8vrBi3BLgxJqg0cNJVjuCGFaEUT3hKImM6cI=
X-Google-Smtp-Source: AGHT+IF7G600RJSTTmVyr4ucbG2LmOf6aHIVFrsIhJmZwSO0ohUQxcKw4k1wQdBgIfaji/c30xhNDfP2+8sxT5wucqM=
X-Received: by 2002:a05:690c:3343:b0:6ea:6e41:1a9a with SMTP id
 00721157ae682-6f279b39a52mr78605887b3.25.1734353555302; Mon, 16 Dec 2024
 04:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20241212120618.518369-1-gerben@altlinux.org>
In-Reply-To: <20241212120618.518369-1-gerben@altlinux.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 12:52:23 +0000
Message-ID: <CAFEAcA8q=SgHcU=Te2iiDJSNtq8ETqN0QeDf_cygJ=KJ8Oq0+A@mail.gmail.com>
Subject: Re: [PATCH] target/arm: remove redundant code
To: gerben@altlinux.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 12 Dec 2024 at 12:06, <gerben@altlinux.org> wrote:
>
> From: Denis Rastyogin <gerben@altlinux.org>
>
> This call is redundant as it only retrieves a value that is not used further.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>



Applied to target-arm.next, thanks.

-- PMM

