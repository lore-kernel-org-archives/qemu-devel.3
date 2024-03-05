Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37A0C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRSA-0007Xs-Ks; Tue, 05 Mar 2024 04:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRS3-0007TX-S9
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:51:15 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRS2-0004rX-4w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:51:11 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d28e465655so80890081fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709632268; x=1710237068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6yszCMBnv6yrW4v75vQbGMUQ+SwUrE/AX6IsgS7+B5A=;
 b=T85ckAXUIZYBo9n1VNaUA/87czYXhgjsTjRkLIBTQSpc6kb/s8ZEq6G3+8CxleBirH
 Hap6LAgkNq2UyPF4UkKgLIMhLmawFISXAfbZ/bBLfNoXSF6nObYdismg8wQwaRhCXdfg
 jbqilCcCn2DEyKqzpPNWDU0f05e7KdQ/oSM5QftyHLe3HnPrpoZ8Aj3LF0elm4j+XQ6z
 hnmLQ4Wzv+wF5cOOp/G1YXc3mJCmcuQxsp1xdVsZmjxm5Y0/QdxXHo+Wokkludr73i82
 FMjp5iFBriLOLSpDYGVWhBBKN/T67IfaqdAEZyGceTW4QZ4iXBGT02n5j7dAeY74JKi9
 +yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709632268; x=1710237068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6yszCMBnv6yrW4v75vQbGMUQ+SwUrE/AX6IsgS7+B5A=;
 b=wU8vq/cg1LV6HEVLqHQQqvHlkiKHecfXH+bTMkl3KUFInGdEzshOafi13N5dgik6xQ
 z0cQgcjQ6Vt0rgBezVofgav1aI6KCimby9COTRXwWaPOvwvoO7+H1tinfeSLWsZsRGTv
 ELTm37Y2hWVM+VipukYwcvCckomAs1ybu0YKEMAFGytBI8TFc0YHJMO87PrR0uXwJypu
 0029w8WY1noKjOMeo73aonhTLJNYH3jSbBapiHBJ50hJDbisND4O2gc0ks1PD2ogxgXX
 9Oc7g9tLrxCRHrk3uD235e/qcmyeWXXAYj8Wo4NOTlN+gQx6Wt3fiHbDgb7mnWjfNZ+O
 Umtw==
X-Gm-Message-State: AOJu0YySazrn6QymEVXK11oZY4sU2Ku9e8a/gQI8p2n1ksqY6HKMwwxT
 3hzKJReBizhap/QCvXhxFSsHXli4t3FWwru7Bnx7D7cvRemJkvb9DQM6uru9dIU8lcGjmH1ShZg
 Nt1yvAV9hy7PM8S+qcQsYUfMNjajCAXaGtQBB5w==
X-Google-Smtp-Source: AGHT+IE2rf6fHqPPK1unennceWJxafif5pzFsdwxAIDtpCuNqy3WTfVfljsXqHr2OyYBzNmimCC1gVt2gbJ4O/yHB74=
X-Received: by 2002:a2e:8e98:0:b0:2d2:5f8b:1382 with SMTP id
 z24-20020a2e8e98000000b002d25f8b1382mr998518ljk.2.1709632268143; Tue, 05 Mar
 2024 01:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20240304185149.1475336-1-mjt@tls.msk.ru>
In-Reply-To: <20240304185149.1475336-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 09:50:57 +0000
Message-ID: <CAFEAcA92XprxAegJMj=iTsJNmmWY4RG89M48C9EOARgGHJxcyA@mail.gmail.com>
Subject: Re: [PATCH] make-release: switch to .xz format by default
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Roth <Michael.Roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 18:52, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> For a long time, we provide two compression formats in the
> download area, .bz2 and .xz.  There's absolutely no reason
> to provide two in parallel, .xz compresses better, and all
> the links we use points to .xz.  Downstream distributions
> mostly use .xz too.

Seems reasonable. Out of curiosity, do we have the
download stats on how many .xz vs .bz2 downloads we get?
Stefan or Paolo, do you have the webserver info?
(Probably not worth bothering if it's a big pain to
get the data.)

thanks
-- PMM

