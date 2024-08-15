Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 09:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seWfN-0008Ck-Ct; Thu, 15 Aug 2024 05:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seWfK-0008BE-8E
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:21:06 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seWfI-0004XA-LE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:21:05 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so1126182a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723713663; x=1724318463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X87LaFHExQhFjM1xF7M0w5QsawYhc1RS2bRLNNcA1XA=;
 b=p60fPfo82Fe+cR24DRFTrMbEY7SWurRB08IgJ25lxWtIDoR2EhTL7BopE5uNy5YFWB
 vonY9qUeBYWRXdpoIBWEPnB0tcS6TEPmyAAYpKKU25isznrvpLYNgul9HjeTaF6mB3WH
 fVs2+TzKXPmzyJXofm6L1Pg0oxx8iPvLVXOE5aSytWvP/yvo54jUd6BZkDrHdgZfn5VW
 rbSEWiqkYgLz8Q0vBb5oLgFF9dx6Wf98L2ebnKCZ2Rkzc9o4Y30Q2dvvdfoAgBdGE11T
 8j/CWGTSeT5m1enMEKMguHNBZtd4055n9fykKWWBsoQHnXU2VbOH+CoEL2/x1j6tZxm9
 6wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723713663; x=1724318463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X87LaFHExQhFjM1xF7M0w5QsawYhc1RS2bRLNNcA1XA=;
 b=Wl9Y4/1U2kFGqOvY8HbMySPB4EJd+6HeH7rrf+i9oydo9uUQnpHJfUmnmyivRj/Ih3
 RxYU4z969xIf61HSxycRGLbBWMJ+gzN0Rw21ugCYp5UHdzSSnH4b1fT0OCR8eHaa3Kf8
 xhBwj381tFoPMgGhEEMf3h74mpbfqRnMXEpK05Mx/Otp67DGo4TPwly2GnAvYBTyGyFH
 h6SMWeCsGt16sMkVFS3PCjCrQxNKT9i6YbWq7Qis0O4ZwYdIGaNx+HsrkQ3FxD+94ZFd
 9pWStSSm/zmdAeVwaPiLxYfJZSTl+mV9Cy6Y++I4Hxo7aOvbU44yC3cx6ARa8bEas0fA
 vTpQ==
X-Gm-Message-State: AOJu0YxP13l6g1kRr+j1pT62sdsXtcApRJOMMDlaaURN7sQEPy4IuJdg
 Yj3502FSYt/ceIcrf5Dxi331V/AG1p0h2/8CpT2U4Wuq5GUA9eM40GBuLR07744KQIVcGjTs6gi
 moIUWvm7ddBVmEVyuC1CR7CgH8E/WTXoMjGChEg==
X-Google-Smtp-Source: AGHT+IGtxFSo/+lC6WzFQ2qH+heAtUmphAyv406eMvU2Yude2rIZQcR22h0vVrfhYxZv0xi4QPL6gF3LbyKXtLORyD4=
X-Received: by 2002:a05:6402:2188:b0:5a3:f5c6:7cd5 with SMTP id
 4fb4d7f45d1cf-5bea1cac323mr3874275a12.26.1723713662409; Thu, 15 Aug 2024
 02:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240815010556.535100-1-richard.henderson@linaro.org>
 <20240815010556.535100-2-richard.henderson@linaro.org>
In-Reply-To: <20240815010556.535100-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2024 10:20:51 +0100
Message-ID: <CAFEAcA-bT0i4J1_iMvyhn+e_qRUSz2WQ6y7b6d_Of6FuDna2cw@mail.gmail.com>
Subject: Re: [PATCH 1/1] linux-user: Preserve NULL hit in target_mmap
 subroutines
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 15 Aug 2024 at 02:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not pass guest_base to the host mmap instead of zero hint.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2353
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Typo in subject line: s/hit/hint/.

-- PMM

