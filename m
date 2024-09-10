Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A341FECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so294-0008GO-DP; Tue, 10 Sep 2024 10:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so292-00083M-G8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:47:04 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so28z-00031T-Mr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:47:04 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f75de9a503so37621821fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979620; x=1726584420; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mGgfz7SgZl0OiN5yRLapfIycVw+3cQtXMuaS6guF1U0=;
 b=QNzSLmbtQ9JCmmRkCwk7JlmMIvJgu8ugthXw9iY39lkKHxbAW1M5kzt4hw112EWsTA
 xx76H0PvmVhOY6dUAAvFUa1R+V344d8GZtZqxZxGjlInhy+LT7MldEfl/z/nJ1fhL0Il
 3HFMutAOQY3iqbiu1Ern05rdkKif4dYTTZYdVaN7L+0QEb0gvL7u8allzgYdY25z8sQA
 f3WIW+bhDMryoRNX7z4QlUEHshv1b0xMWOdMiEK5LkoyEIOPMVlr4Nbpcwj/xIvP83e3
 GJedj/Cy5LC6uOQrweYliKv9SV6ehhD38YSc3EVEI769YoCtn43Ivf9u36F7IGwQ1Xna
 kfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979620; x=1726584420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGgfz7SgZl0OiN5yRLapfIycVw+3cQtXMuaS6guF1U0=;
 b=fl9RJ30q14j7tlCLws/6+vFqz2IWtpO9SsAB3+jIlPb7XWabXmehx+wGQqLoM4bqPH
 F+FyU60VtmqMq1+H6T4nlC6v90anmpZDMjR2QGt9b5XqamGej6t8QNhctQNNjHcar5xY
 UMGbIzjTyewPZjukccpriIj/Sv96QUlyTbL9bFtfzQDx3z1njhF4SiVBWo05zX85J0S5
 omhzh+IQl4ccKhEjf2phOWdG4R76/q4IUTdLVH55JwWTJ3Tulq9Xcz1o5LO3bvrf0AQm
 sZlYelpFFb/AOF9O+P89qUiTjWPEKBM7lO1g/31NPVcgJqTmxqzd1p9bm6xByMvcSskA
 DykQ==
X-Gm-Message-State: AOJu0YxxUo4T03uAJaRZHJjkyVWSHehZQvzGckky/rrMdUHYgzM8km2B
 3LjvFxsTnqApnu3mBImFClZiRBPa/+3bQywjZMOJoZ4F40nwf4D9Zo/pHZE7jlyf+8THdK6fro7
 F74Ijcm9nYX/F/kytj7OdMCjxtonUVHHQvKCtJg==
X-Google-Smtp-Source: AGHT+IE2PdyiJbIx6cupcNaqcBLkl8Mg0w8hf9O+Pk2I8wdEuP/Ehg+OL1vKFe/ZYw9J/pkfJZ7rAE70EYyde9v5HoI=
X-Received: by 2002:a2e:801:0:b0:2ec:637a:c212 with SMTP id
 38308e7fff4ca-2f751f854bamr84862911fa.39.1725979619664; Tue, 10 Sep 2024
 07:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 15:46:48 +0100
Message-ID: <CAFEAcA_O1bCphkc-wRfux5y+icVwH7oP-6ESkyXgoviXb=dDQg@mail.gmail.com>
Subject: Re: [PULL 0/9] Migration 20240909 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Mon, 9 Sept 2024 at 21:11, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit f2aee60305a1e40374b2fc1093e4d04404e780ee:
>
>   Merge tag 'pull-request-2024-09-08' of https://gitlab.com/huth/qemu into staging (2024-09-09 10:47:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240909-pull-request
>
> for you to fetch changes up to 89bccecdda253c9a1a38921cf9266a4f9655c88c:
>
>   system: improve migration debug (2024-09-09 10:55:40 -0400)
>
> ----------------------------------------------------------------
> Migration pull request for 9.2
>
> - Mattias's patch to support concurrent bounce buffers for PCI devices
> - David's memory leak fix in dirty_memory_extend()
> - Fabiano's CI fix to disable vmstate-static-checker test in compat tests
> - Denis's patch that adds one more trace point for cpu throttle changes
> - Yichen's multifd qatzip compressor support
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

