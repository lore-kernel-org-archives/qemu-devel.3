Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B567C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7XOt-0001ug-84; Thu, 16 May 2024 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7XOk-0001uD-Og
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:27:38 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7XOj-0002kl-5P
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:27:38 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so3204440a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715851655; x=1716456455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n9JpdsCIy6Zjhi1N48wQD00rN34fzG7HE4fp9skXsY4=;
 b=gO3i0WZ1CZ5wlJzHsXb3J9217zLi3JIvp6wyhiMXSFlTWD91NoZu6hIPA2fsVuCr95
 +0ARCuouPwEf0r1TUCa2kvBasSCy3YXfkpzCowAh7vUWEzz7dKv6ds61bjWHfkz2guCG
 HSPkgWlMv2h76gJiUe4Tch8pO/VEUzdrQxBmCc8NIS+qB1TbJNciJ1jsN2O9jWVn40mf
 RC9xcHFQxutKXMYquatajk9s+c2RAE0OHP1RKfJkjf8OoObT+lkX3uhmdN83GJ34Fflg
 H8xcDzxQIxzopmdsmmok9DwKE4Ynrd7Behg48YurszXZC7uyjaohlaTmqCkUauDg4vX8
 D48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715851655; x=1716456455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n9JpdsCIy6Zjhi1N48wQD00rN34fzG7HE4fp9skXsY4=;
 b=k8vc96ZoMa5hvHRQ9JT0U9boVJvRE9LzlNFeD+QLHsXrMlLH+7nvLxGqofsI9jfxKs
 qUCRpGuMainOBJR9VM0AGFb7MNItJnrCPGPu95PMzYuGt002w/CSQBTHx6bb7Be/KD1I
 L1S7YZEu+JyLj+Hksb4/RQCJzJxctbX4Lzw6hjYLy4nkX3L/Yu+uLN/oaO+td15CwS4T
 DVVRIg66+UerCHvwTsKjkXTIf1rxYE0t3pXKvYl7yu4Z/6bBQDa5azJV7ogYNojjop1t
 WLoTAp18zh9yBlvhF0cW83usJalHRLwbvjO7yIoADXoX+HY8539WvIsAi3eWNL81SUKa
 c6iQ==
X-Gm-Message-State: AOJu0Yzgse9xJLCBjy/2v7UKlJIYXZGEFJpDprbtJ15XlrzNGJ7/QVD1
 fbfebJAtpbParvqFfbCUm0qSjTJTfUQcSg5/n3utEkX+i9lZKn77CE4azZ/QJFu3XhjjJDyv1em
 5EfMrdxVxjrUQVIXmLQHA7dZymhvpBI1uZImKyQ==
X-Google-Smtp-Source: AGHT+IGuWyfp7K6z9uHnAdfxpC7O0qBRXgWk0Y1sCb1eoSUBm/chQx1YrvKaf8096LLd+PjJ/IcFS4rYqW2boLTO5Ik=
X-Received: by 2002:a50:b410:0:b0:574:f657:e0e with SMTP id
 4fb4d7f45d1cf-574f657198bmr2969266a12.25.1715851654741; Thu, 16 May 2024
 02:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240516091120.1021435-1-gaosong@loongson.cn>
 <20240516091120.1021435-2-gaosong@loongson.cn>
In-Reply-To: <20240516091120.1021435-2-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2024 10:27:20 +0100
Message-ID: <CAFEAcA-JULLebQ+FddRUKNhsA=UBS9DWjn_01+K4r9FBf+7wdQ@mail.gmail.com>
Subject: Re: [PULL 1/5] hw/loongarch: Add compat machine for 9.1
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 16 May 2024 at 10:12, Song Gao <gaosong@loongson.cn> wrote:
>
> From: Bibo Mao <maobibo@loongson.cn>
>
> Since migration test case requires compat machine type support,
> compat machine is added for qemu 9.1 here.

This is not a good justification for adding versioned machine types.
Adding versioned machine types is putting a massive maintenance
burden on yourself from now onward:
 * every release needs a new machine type adding
 * every change to the board model or to any devices it uses needs
   to be assessed for cross-version compatibility issues, and
   if necessary extra properties must be added so old versions
   of the board model keep the legacy backwards-compatible behaviour
 * migration compatibility must be maintained

You really do not want to do this until you decide that your
architecture and machine type are at a level where this is a
support guarantee you want to provide to users. "It lets us
run a test case" is not a good reason to do it, and I strongly
recommend you do not add versioned machine types just for that.

thanks
-- PMM

