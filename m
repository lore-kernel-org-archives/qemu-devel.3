Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F52BC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUkJ-0007d9-Hb; Tue, 05 Mar 2024 08:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUkF-0007ax-IR
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:22:12 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUkE-0008Al-3q
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:22:11 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56647babfe6so8289386a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709644927; x=1710249727; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=guxUlDWqzb4lkXIhpafKSXkFiU9Da23V+a6YnevCJ68=;
 b=ra9/URbwSMS0coC4g4/cAgSR4QxG8kbPQHvy9vIbeeReRrOK4wWMXXGE5z0XQaN0np
 kMJ5A43xryRpqDgPc9L6vPeldPetvgW4yy+WaYEj+KgVzkpZ2NVKs7vnyD6+yoPCncHE
 kpTvyUqpUdMXs+HRH/WJ8xI9vER2aW8zZWqtY8zKnqikGbi6fIJpk6dx5fymFxsWUTyF
 UKwQ03zn8cRTOJ7amP+te/KoKmKMMsxXdAAdq2GQZx6Yfj9DJxpgqehK9bQjUGXElIN+
 hNTuzt1cNNvgH7FsG0XpB1jlPUlYct+Q6kw4K3kSmBHre3i5xXs1Jtf3RWaVIBXMVbuW
 SY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709644927; x=1710249727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=guxUlDWqzb4lkXIhpafKSXkFiU9Da23V+a6YnevCJ68=;
 b=laAxr6X/0HIlsx/qiNdjd6Srar+3S1Mo2ka6jijpHeHvguEKZNomwfiO5FrJVExHKl
 ye8CjxDNVK44oeoZ4tPtedIz/ca6iYf+Yaytfa19MEGhNZzW7oXc50bv2w/U/5hK3YpM
 M26oFG4zBe1FdFE1neA4CZqCGmXp+sZ3QY1U6KTPb/pLVi2eMYcGNzC9S7bwIvHz+RPY
 zqaeuWGj7R0NwvBHzXew4L4DAGWfWt46kG1lPiEILVYTWdYDEbwxMEVLDgGAc4FiSgMf
 BqrCVGfAZmbOW5zVob13ztnZx2PegQ9sAaJBBAdgLeHSGnw66Ekup0/6gNjNrzBDam/n
 Y+Cg==
X-Gm-Message-State: AOJu0YyQEmEapQplurcMSSTp46cbbZRlFhZ9KznZWZfnthhKJHdQHx9a
 yD5lICEhcZBauBQDfLbEtovQL2zRGV+SeK4p82KA9dSWUOllmtUn0DE2xoh0dzfQR4ruYj6da0c
 bJT+M0gHfU9r0avWC1uCw5DIfo9VfN8Zs0Xs64UvIssIesqR4
X-Google-Smtp-Source: AGHT+IHzvB4nTjho/F3Usz1hDmTXIrm8uscwFRhgvx3y8nBTLR8TaTjDnYUukLvrlV1iKwJ8KPIqOJ5wV7HVclQ/XIo=
X-Received: by 2002:a05:6402:34c6:b0:567:3ed0:47ec with SMTP id
 w6-20020a05640234c600b005673ed047ecmr5291132edc.23.1709644927425; Tue, 05 Mar
 2024 05:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20240305013016.2268-1-steven.shen@jaguarmicro.com>
In-Reply-To: <20240305013016.2268-1-steven.shen@jaguarmicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:21:56 +0000
Message-ID: <CAFEAcA_BOgDPAmb1ksSWOLtEaHQozze1C2hiu4BS7k8CHsKz_Q@mail.gmail.com>
Subject: Re: [PATCH] qemu-options.hx: Fix uncorrect description of "-serial"
To: "steven.shen@jaguarmicro.com" <steven.shen@jaguarmicro.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 5 Mar 2024 at 01:31, steven.shen@jaguarmicro.com
<steven.shen@jaguarmicro.com> wrote:
>
> Before v2.12, serial_hds used MAX_SERIAL_PORTS(4) for
> resources of serials.The limitaion description of "-serial"
> option: "This option can be used several times to simulate
> up to 4 serial ports."
> In latest qemu, serial_hds have been replaced by "Chardev **"
> and now is dynamically allocated through "g_renew".
> So the limitation description is not suitable now.
> Update to "This option can be used several times to simulate
> multiple serial ports." to avoid misleading.
>
> Signed-off-by: Steven Shen <steven.shen@jaguarmicro.com>

Thanks for this documentation fix! I've applied it to target-arm.next
(with some tweaks to the commit message), so it should appear in
upstream git within a week or so.

-- PMM

