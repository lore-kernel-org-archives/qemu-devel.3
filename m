Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA56AC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 18:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNcyM-0004pU-6N; Sat, 29 Jun 2024 14:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNcyL-0004pD-AC
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 14:38:53 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNcyJ-0007LZ-DB
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 14:38:53 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a725041ad74so61672066b.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719686328; x=1720291128; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PMfWb+SuD8rX+YnsKREBeoqYHOO2JoreXSbotUxxnHM=;
 b=vt++UPrjAeW5z64aHEof3zgnQNWRFrgd0Mh9NyPbs7DqIbOVVaN4oafw6H1XJi5Sif
 XgAiG7yY7lujN9v+wt08C60zHAUimi5lAXOw/TnNgnSVbTxlW8oL+RNdra3Eux7ZeONN
 9zUAQyDFfXx3HXVaI96zeTpppnJ4XrfKXZR9DqqC09I2eRGRFqOy27Pc8ijyj+rNGUEZ
 cLBsdIumf4V97gQe2KN2HsDb4DNaBfS5NXlQRuzcGxW6L5nc/V8MRpJ6rBQlTN6l4zuY
 epBPyUHvje8exxnPCAxTN5YNUPQ/WQnKQj8uzqYyw/fIi5yMZ/IQB1WSIKS0wJbd0KTQ
 ivLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719686328; x=1720291128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMfWb+SuD8rX+YnsKREBeoqYHOO2JoreXSbotUxxnHM=;
 b=hYyfQQu23rRuVJ/+fIo66yhv0E0CLZrUoDxE0YMu3qSFSQ0Igvy/buB5hDJ+TvWBG5
 W0/Fg6tDAKNSPaahkJVKLdLbZV9HiSLP21WUqDPBrZhY0d1EmOm77FQ4UikDCAH8lpBz
 h9n3GayijiG0rL3bDvmfvfW6zt+I2rqFrj+PJ5a3ED08gTceLF8XJY/hUBY2/yJvE4Km
 RdCJvCyatV4zMkdvBLPCfQp7P4sUtkCs9FZ5qq/v0jmXKV3yJURtxQCEQEToJlV8KDPM
 COH80f3nm9Xaogtb0ryzpHiO71L9t7TICXeVzr8N1jYz5UMaC9R2f4tjuojr0n+awXfl
 YCgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVMhKR8GWEYaNv4uPkYAt4T70HFa1SC9nMByc5cNMKw2Q/WX76AJwDIsQt/x/XWxJVoI0QSiYDusL18+Zq0nu6XWD+ttc=
X-Gm-Message-State: AOJu0YyIiETXhjBi/XELXg+zKVbCu4XE96gudeHOzGUxJym472f9bCj+
 1uo7pmiQ5f5eYKOiLYE4MCJteCdi3N9kaaLAO7JlNUW1wQsGcfO3b/E5fcznNl0J7oUFENtbzaf
 sY/iCMw5GAcysYyHHLEeLnAwTbWxeLqACDdX0zGK0EABik+Cf
X-Google-Smtp-Source: AGHT+IGkS0xfXEV6RmY141qa0jIL4DQKRS7ae2eWB/L0SS+VtpTyiRESF1D7FLmlj3DfdKrob69cOaDkReff3tyL5ts=
X-Received: by 2002:a05:6402:358a:b0:582:8746:6534 with SMTP id
 4fb4d7f45d1cf-587a0822baemr1295572a12.28.1719686327959; Sat, 29 Jun 2024
 11:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
 <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
 <ea688598-b4a5-40f4-a749-c155ecc0988c@linaro.org>
 <d9812dd0-6f72-56ef-f52c-2f879bf2bf36@linaro.org>
In-Reply-To: <d9812dd0-6f72-56ef-f52c-2f879bf2bf36@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jun 2024 19:38:36 +0100
Message-ID: <CAFEAcA9FYvPzOfb5VfuERtzirWT478fvGMp75BQg+tdKNHAJ9A@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Fri, 28 Jun 2024 at 19:13, Gustavo Romero <gustavo.romero@linaro.org> wrote:
> Re-reading it after your clarifications makes it clear, but the first time
> Phil pointed it out the phrases:
>
> "[...] since the .c file will have already included it." and
> "Headers should normally include everything they need beyond osdep.h."
>
> weren't enough to me to make it clear that osdep.h must always be included
> (present) in the .c files. "will have already included" sounded ambiguous to
> me, more like, if necessary it would have already be included in .c (but not
> always). But, well, that can be a falt in my interpretation.

Yeah, the rule is simple:
 * .c files always include osdep.h, and it comes first
 * .h files never include osdep.h

but the wording in the developer docs doesn't manage to
state that exactly.

-- PMM

