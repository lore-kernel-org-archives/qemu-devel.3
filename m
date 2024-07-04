Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5B2C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOAg-0000oI-Sl; Thu, 04 Jul 2024 11:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPOAe-0000lX-QQ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:14:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPOAd-0003qP-BJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:14:52 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58be2b8b6b2so1054363a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720106087; x=1720710887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TnybP8MOaskl5toG+ba21y1kIgGyAjS0s8TVYYu0N2E=;
 b=keND24X48oorYEhb/4uYe3N31nGxlsT2CUIDpM2gMafcUJLroBpxFI+frbfUayTzb9
 ANfZhURsZvwJxCy8/xO4PtwqhgLth3Kvuriw0y3Ffj0M1YJBNcP3sG1Z6BfQD76YmF7m
 ey0GE2AgOE+JHhAhY4UiidrMDFNVgwGNB5PCIW0Y8Vp25/7C1eSMjsj+Kbo4W6rq9bfz
 HKLW4sAICVgHP6dpvSIpdHlJ0mjkd/TqR6XQdAWRQjv8fuafQP8gud8D4IiAG+E1Yd1C
 BKnlhXsm2qeVwjgCRMuQ5IoVk6klK48yzUQNGXJOkzLuGpqsExzxd+i7ZHzs+lNCXhR3
 qeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720106087; x=1720710887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TnybP8MOaskl5toG+ba21y1kIgGyAjS0s8TVYYu0N2E=;
 b=p/zlX87Peaa1X70Jy39RhqDFcrs8D+AOpKbkCxFeqpzJ2b+U7o3n+gM1xNSgi7eUGl
 i0hg7W9sxKcQfoioQH+JTZ6i5m+WgE0BblPYWnQbqWS0um6MHpAowasn+CH+0f35Dnv8
 aSC6LXUF5IQWHJM/v9dD3VTmea0/HryZcsKWFOjtlqicW31LTj7woeuT4tX4tKjgS05q
 V6h6ugesK93zRAS2ZJdLMUTmtJeuZm5vRkw5PICiek2Le6CTc3yaJ7/9xQUCkkV0EMhK
 8CruHEpFj+a5b/tbSKSBxrAiLpCpDODLYHz7tHq4ry1xaN2NJ5LODq3ITJB0w5TpvVAX
 E5Ww==
X-Gm-Message-State: AOJu0YxPyAtQKuetGREJYCc2Eh+wVhOUPQfpE7BbAMNKJOLGGReORedh
 jJ+xHln+2Ytw9BQKgvtA2bRE7Nzgy7BZApveyQBnYn6uHpYyC3MSoabGEZoPzAgUC/aWUgtrvCh
 TDINbi0oHeBTwam6sv8EpuYhVHayJxy9s5h0JMSOmeTMhmocV
X-Google-Smtp-Source: AGHT+IHXv86zt52LCYOr1rMsGsqfimDS9tbGG3QlxcIMfojv5QbUll7OmEtHGBWCUZGKG2OV3FFrkbpPzTmqx5oiwrM=
X-Received: by 2002:a05:6402:2353:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-58e59b42805mr1683680a12.19.1720106087611; Thu, 04 Jul 2024
 08:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240702154911.1667418-1-richard.henderson@linaro.org>
In-Reply-To: <20240702154911.1667418-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 16:14:36 +0100
Message-ID: <CAFEAcA9jVe8Fa4=TSHqfbmV54ECUJdpB_-hBsE_0-vYZBDtKow@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use cpu_env in cpu_untagged_addr
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 2 Jul 2024 at 16:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In a completely artifical memset benchmark object_dynamic_cast_assert
> dominates the profile, even above guest address resolution and
> the underlying host memset.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

