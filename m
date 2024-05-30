Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08AFC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgWp-0001s7-NA; Thu, 30 May 2024 10:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgWo-0001r4-Rr
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:13:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgWm-00021a-7D
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:13:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42120e3911eso9765865e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078390; x=1717683190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NBF/ZzD2mBBt5E4hV3YGQ8ZwzIuykJuZ8dgGkE0ISxw=;
 b=oPI9AHHanuS3soX5UUwDgR+XV0rJOqOSFAnXqop2RhDnYhzkK+LC+hYcTRtKrjE2sQ
 v5ZM3RSLnx5i+5p4+uHDOyl2gowu54Bl1+alN42JnFopjUvt0J8JnHzKXJwyAn18RBDl
 76e30j8gKg1jc0ZrkY6i5X9Vj48/+3NzorNa0Ag4/NVHqzSZMJ6haYXEqUKH6w/Ue1MK
 MHAm4OdKQ3iBjTjibFrli9y/C8UAHrsoUxjJmoYalAZsEcK8BBX/FtBr1kxg5uidDRsz
 fHF6yUfdwXQE0D/1F9phEhWczPPcIvmuV2uGdaY+3cXJM5B44zntw2v5IC+RSlIwS3bE
 08og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078390; x=1717683190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBF/ZzD2mBBt5E4hV3YGQ8ZwzIuykJuZ8dgGkE0ISxw=;
 b=ak6gNSs4wTWtQ71ycixdkkqovYoqn4gAIbiid4uYaLHk219PGw+USb14Pjl81l3gCR
 96L7tExrVbeVirgG5v1Uo5uh49JVTVzB7HrsnrGywPNLWgcN3RneObnfbMIqc8jizygx
 J8pJQPByx5kZ0LZ7u1GcMGNEBh0KtJtncwc5fLCNmkd4OFF4/cEv5N3VgObs3I/a1i5I
 pY7OOx+Gp5eClgPTqW/J1L5Hpx/OpUOFGQ596S7KKqWnLzXtfoLZIc+r+niTev7tvaex
 AEpwBxTvCPtPqSWc36egcVsnApPlJODRdQJtNYXCKPMa4yYx50QAAIqH/OfzOPYduNR6
 Q00A==
X-Gm-Message-State: AOJu0Yy5+6uyTi/pGmcNRnEq6H6uV0IfI9eSuhhOfjozvOHFEXSA5W83
 H3Bu/XDl1agjG1GVjpzhMqv8L+EDXjp+6m2XoFYhZZ1ZQ8iaSkGeFrbWKJd0TUoNVnIQ0bLUojL
 x9MQ1uJdTr7Lmf3j20nh37qZ4nuae8gOUCDYtEw==
X-Google-Smtp-Source: AGHT+IH3y3MYkV5hHGb0QNfAQ/8FKHO//wr+7OcCe00tyPxBc62ABfJuvNZl9obMOdot6odn4Xz15+x9r1SNpUaXoK0=
X-Received: by 2002:a05:600c:424c:b0:420:2986:ccee with SMTP id
 5b1f17b1804b1-42127925d0emr23008605e9.30.1717078390634; Thu, 30 May 2024
 07:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
 <20240528203044.612851-13-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:12:59 +0100
Message-ID: <CAFEAcA8eXwASsakLXGbg50YvdgTR9n_2H+BFONF3LUz4gAGmhA@mail.gmail.com>
Subject: Re: [PATCH v3 12/33] target/arm: Convert SQSHL and UQSHL (register)
 to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

On Tue, 28 May 2024 at 21:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

