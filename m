Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21483C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8RS-0006jk-Et; Tue, 09 Apr 2024 06:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru8RO-0006iv-Kh
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:10:59 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru8RM-0003UY-VE
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:10:58 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516d6898bebso4263127e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712657454; x=1713262254; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MZY3ZEuilX0QDXeTDjeid/Ta1KPwWAfxpfF4EPNuP2c=;
 b=OT08uEJPjAoP3UUbQ5YFxzCbeYklX3tuyHS9zgiXVlihJW1Q5jZArt/If107qptYd5
 2vNuUTnXlf7rXsYOCvetegYZBeSko7PJ3Qo/yE3X57ma/nz9wdBlXmljXqztAio36QRM
 +PJx53N2V3rMNqJlW+AQF10QR+itUyMZWKUSQe19p+5Jv6cFN+ohhp+j3O7HrOmmGQDB
 eNC/oF3ZYWjzdzYfsZ6NxWEQiq2Ppz4W2XVkaSNMl9yczA5g3vnAcGlmDeAyWVvmBXQr
 oIKd1xGUzc62GR3T7xfTdQ8gPoGpFsSyt/yeK66LOVExTU50USjaV4mgjrhj9f6gxUum
 Io/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712657454; x=1713262254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MZY3ZEuilX0QDXeTDjeid/Ta1KPwWAfxpfF4EPNuP2c=;
 b=Qyh9zdeAbngxO5CiUTgTZMLoFnmut2Km3QDZNc/7PeUsjFrtLIGWcCPJMbiAJe9p4c
 dTCbdKfO/+mv3HumlTdh5AXbD+jV99ROKk4jL7VxQ5i5HmAnPPb0k4/iNxVQVvnpsfTP
 RDv0zMo58S0owjBxjwSEG8B51oYU6TZJXy5qQC9pl+Z+MTiGT85Ks7SuYNVMjuwMK105
 SV6ds9XUJd8Y2XqWD5n3bJHBkPtwiACiKHdAsTnPLO4flb9Ib+sZ4gO+9hKu7pBiKuLO
 GiB6Q4slMqUrDZl87jWEIMh2YfuoEBoTsweQBBlTNMpmiU3mu85hgLPks64Sd4pVqH8r
 Mu1g==
X-Gm-Message-State: AOJu0YyIquVhKaHm2N6iaoneQB8MO4BirDk/pe8xpSZA0/cGhziHwO/E
 fSq2J8WeRswASnLkLjg1+DAqUo4BWnZ4pLxs3VQcEnhFcXk+wq6ValF3+WrZ3lPAoi8AZ6QYL9C
 xxHGWc2OsxvwCawD2TkLz0V15Z8cdwFQgA5KnSA==
X-Google-Smtp-Source: AGHT+IFW7+0HmCCkR9LiRBoApsqHFLlUvt3na5d50evl9xZs4iZWp1KDdBTA1PA6ISSkHH5Jb6dqabnfsDtDKon6a7o=
X-Received: by 2002:a19:2d0e:0:b0:516:d4c2:5412 with SMTP id
 k14-20020a192d0e000000b00516d4c25412mr7376164lfj.32.1712657454320; Tue, 09
 Apr 2024 03:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <2484ebc6.e9b9.18ec24a8e9e.Coremail.13824125580@163.com>
In-Reply-To: <2484ebc6.e9b9.18ec24a8e9e.Coremail.13824125580@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 11:10:42 +0100
Message-ID: <CAFEAcA_KES78EcDe6G8hmOAGksxVnJS3K6CtnFzjQ05fPtqc_Q@mail.gmail.com>
Subject: Re: how does the qemu emulate the "atomic" semantics on host that
 DOES NOT support atomic instructions?
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Tue, 9 Apr 2024 at 10:58, tugouxp <13824125580@163.com> wrote:
>    How does the qemu emulate the target that support "atomic" ISA, such as riscv "amo" instruction on host machine that does NOT support atomic  instructions ?
> is this scenario happends?

All hosts that can run QEMU support at least some atomic instructions.
Where possible we use the host atomic operations to provide the
necessary atomicity guarantees that a guest instruction must have.
For cases where we can't do that (eg where the guest needs an atomic
16-byte store but the host doesn't have one), we arrange to pause
execution of all the other guest vCPU threads, do the thing that must
be atomic, and then let everything resume.

thanks
-- PMM

