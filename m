Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BC4C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFy-0003Ma-S9; Thu, 28 Aug 2025 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdSM-0000Hs-4X
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:18:26 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdSD-0005er-E2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:18:24 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71fd1f94ad9so8968027b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390695; x=1756995495; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3PQypQubzoeSH49bP3qdyufYp5cN8PxoFI/rhUOZ3lY=;
 b=HkQnKjVB25PIHaul5YlapQMZ3p00NZubgRjcbBbLBT/hycclWgyYNKz46ffMpTC+9G
 U/QY23+rWCwF4QLQs8na9lfDaCWkccBo9mwxzbRmZG9rxp27tsUe8RgRCs8MN6DT0AcR
 6zBZ6TcxL6jJr2gvvRTZX8a9kOebF9sRNqGUWpzgN/XlrGVlc2CWqjEyz9YQbzWx82PI
 C3aPRRQFv/Y3Om78qhvXXSfKHSQirwfvzbRcQPLvrMpInzQs5uQWqGDkbrZ3sq1EBePc
 esqgdRM7vUYyezqreQmIGDJNWPhtpmt1zee23wj610ErVzj5rM2wmqwZ468cakr//VXu
 vQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390695; x=1756995495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3PQypQubzoeSH49bP3qdyufYp5cN8PxoFI/rhUOZ3lY=;
 b=XrXxZKGw4gMMJig0mAl2w6MXBlcNzRPBOJWzzd45Jk3Yrik9/3GkYDtLhlEPyDxFRF
 orEFqUn1hwtUjAiJAFcegU5mI+q6rbnUQM0bK79gm7kzp2xz9K0Fo9Faz6efsjHIvgTG
 NzdkMKbfWEeLVmGTElmpldL0WmL3JheSly1mtdLP5qv7SM4aHQzjQZMXvB3T6OhBmbNB
 Uk4ysRyQp0aguhOmw+mXumLygfsft8mAlrimzZh+rVXEg8ChMIl63ramZeroGGlMN12U
 oWvvHW5Tar1vxOXgcO3iL4r0cuD8HriyaQxsGVvrpwbcVdM6gn1ZQmMhy8ycEvonPY6o
 p7cg==
X-Gm-Message-State: AOJu0YwABgDcCg3wKdyAIGgossDJET0mWXF8f+KayybQ/O922UJzOA+L
 kUn/ulU350calQLyV6EiNB7Rv/Cu6MLdqTa4yB4H+DmOlQkDYqAE12ap278N3u0kgtPytK2D6pE
 13bUmljrkAWiCE8RJk2tyxY1y3FUkzCapUnn2j/jnMQ==
X-Gm-Gg: ASbGnct+I0xl0HKvd4toUzZ3oxI2ceoisgk4RmqkxYqKe1VRXfJhTzFVOdObTZz7Hi3
 yGlD+ba1O9uInCecJnypucn+iX4OTXC4hU1cLzdTb9h40EvOMlQfJp0+wIElNYXyjU2P1vfEr/5
 O89NDCjLJ0J6F8D8kPZZwhRqJx8pMn15ADDukstJNEIWnt08ABZemjX9BzptLpAtzjj75pgu5I6
 GNmroURd2EZUpRdl9A=
X-Google-Smtp-Source: AGHT+IGgUMeraNuCJq7/7KEA6SUqsuJPxY2TXexbA6uqBwQEOzLL2jeSNu3N1zin8xOV7F9/oQO3jKyvqvAqjsg3L0s=
X-Received: by 2002:a05:690c:fc8:b0:721:3efa:6d05 with SMTP id
 00721157ae682-7213efa72demr99398847b3.26.1756390695542; Thu, 28 Aug 2025
 07:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-4-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:18:04 +0100
X-Gm-Features: Ac12FXyFCac9JU0pBYCJYX-b9sCx5sID5gJtdZH29mmKdpEMjnxgs-JuIuOtfmM
Message-ID: <CAFEAcA_aGLNeZyA-W9guecNdCNEvjEaoXUbFjqQWoKy9a6ovcA@mail.gmail.com>
Subject: Re: [PATCH v3 03/87] linux-user/arm: Convert target_elf_gregset_t to
 a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While we're at it, loop over the general registers
> rather than open-code them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

