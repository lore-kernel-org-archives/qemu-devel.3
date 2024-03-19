Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52CEC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaPT-0007Wy-5a; Tue, 19 Mar 2024 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaPL-0007LQ-DB
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:25:39 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaPH-0006KK-8s
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:25:36 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d49f7e5c2cso38045941fa.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710858334; x=1711463134; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OvIVuYEc42sbI7db0SJG6CEZxtBUTb1N01BNbC0VBG8=;
 b=UCbCK5+dVeEC1PrYAybeFE5NzZ1YmVH+jOrd6XrG7DlyNanLXPhoQ1wAkbdhzQFQ2t
 0eVh278TLd4Pwy+uDM0SdTQwJPs4uX5Mz+yE37y1nN73DivQh4aKHHpX2IgIQEfsAG1N
 jJj3bqpiDsovaQEAdJR5GGVSZtKVR/nHScq19JMIgvRDFpRTrxGOj7XMGS+uWzyTrrhs
 /X7nCGY9CcUTEDmYrBb3nGs/sypRml+ehKVOUVzzSHKNFCwzIwMnEdTnA16kAdZrPuex
 rrI3R6fypwLuOZbxeeE3d1qHSSJQO/Dgzq9C4R/tR4emJwwz6ZBW4TojtqD5BEzKOMBU
 4LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858334; x=1711463134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvIVuYEc42sbI7db0SJG6CEZxtBUTb1N01BNbC0VBG8=;
 b=KI56Qd9QZJIF8x56w97kD3YWuDBpLjfH7he4F4EZX5DpyGxK+C1PB3BABktGwlx1DJ
 d9e6aiTrulrkvolvWRjm7Hrofu6ga1nyF+S01aODSlvbz9qHAHG8r3H5JVnOh8DhR897
 GFEHpjWCt/uYy/2JGuQOS8cvX/fyd8lXSOvTAfWpLc6i8FR86dhsoHm0fU0tRllQVC3n
 08dzg/mxHMz22Rm1swx6y5bM+aEMlo9+OdatjJuo7pnsemOpUj7i447rPVDf8Ec+sxWK
 kYdKYzfE2cskSLIY7hM6LrOcBvlHeXPImjtiFrq6BL/1D6mZK2alrfOysNAdYRWx7mP9
 mGmQ==
X-Gm-Message-State: AOJu0YyU+eBhNDfnn/NK8Yyb/AqJ8LVewqO2bxuBguiK/8BlxK7yViyY
 vkmWa7zFHQllC8Ju6/3b5CARNDCh9XkK11cib7GtHVj9oJrZVEWsWQKZSiWEDFLqakNMUx6kxFb
 7l3BngzknQKGUsyhPApKHH4grWJTWA2GOtg6skg==
X-Google-Smtp-Source: AGHT+IG6TU2Qs8M+3x+KDZUr+JmNKGF4tcwSNI4TylnNXDRteFD3ov3L5lGVwIdhSmKioAN6Y7cL/pliMpXh/MqEPXI=
X-Received: by 2002:a2e:8605:0:b0:2d3:ca91:c357 with SMTP id
 a5-20020a2e8605000000b002d3ca91c357mr9205621lji.15.1710858333550; Tue, 19 Mar
 2024 07:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240318175655.756084-1-thuth@redhat.com>
In-Reply-To: <20240318175655.756084-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 14:25:22 +0000
Message-ID: <CAFEAcA84sfJZ_5bfewHkE1mMCwPT-WS0hCNJm5o4CQu0GZp_CQ@mail.gmail.com>
Subject: Re: [PULL 0/4] s390x and misc patches for 9.0-rc0
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Mon, 18 Mar 2024 at 17:57, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>
>   Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-18
>
> for you to fetch changes up to aebe0a8552e8d419c8103e60e593f2778eab41c4:
>
>   travis-ci: Rename SOFTMMU -> SYSTEM (2024-03-18 17:18:05 +0100)
>
> ----------------------------------------------------------------
> * Clarify s390x CPU topology docs and CPU compatibility error messages
> * Improve the Sparc CPU help text
> * Rename SOFTMMU to SYSTEM in the travis.yml file
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

