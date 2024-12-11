Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B53E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPCQ-0000AE-3T; Wed, 11 Dec 2024 11:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPCN-00009p-Nv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:04:28 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPCM-0004zn-Ai
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:04:27 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e3c8ef95ae5so749827276.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933065; x=1734537865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s28HjklTku0+qW43q86Q8JNUrwsIpdFn49TYjY3ye6Q=;
 b=iYTvtF7ZMPi3WsS4xeZNPI+KCBQ1V4NCi9foFE49NwKIy8T4rDINgywAS+sQpmrNHB
 gTBZHhYmfEghufbBUCkfRhuzZtX+RqrCIF5O3ilUH33Jp37A4WN656WldnTWEwOG8OXu
 M6lZZWQeXKrqJt362WX32HKdPgEXx5WZYSFDh3wZgP+ujFjTBqNvg8PcfaxyhIDAUOk7
 Xw6mLzpF7Jbxt+OsOOIkjt4U9ZX+CFKaFFxf6lEUR4cZ+Z6wYL3setqJMTSNXBkFLKVc
 4nzqJ4vksMbO/IOkxeuPu1DDbAdQg5nUh6ih4C+DWLDmDiyCZbj2uiJmyIkZnHviN4KD
 VdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933065; x=1734537865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s28HjklTku0+qW43q86Q8JNUrwsIpdFn49TYjY3ye6Q=;
 b=Yc6Agyk8A4kpxEF149S7tBGcuw7YGw2zs1PUqmCFAw0sPO8OKcsTo9SSJh2qtgEnaz
 wkrkA6pagS0oel8HYmoaId05UojFqJxM3HdTiYp6TspvnH+meOCB7/x7wYn1gmz0Wxfb
 SwSYIq6qq+qjU3d109scS2or+OUxz2IqqGEiV+JEYkwnQsNn0Ik2EphgRAqGO27Z3iit
 bXSv54YD2Yvj6LNWBkE+IDV/6B/EZ457GbEhWNVhfCxNzPY1tMZLL5aS4sQiq/Wub0hq
 iyAnZOKZsJQHCIOLE/nOV40buhTPL5JC2GYVFug52kvvh7fowTOFqz1OwFofTzXHK3Pa
 GKWA==
X-Gm-Message-State: AOJu0YxZVTP+9i5PtXMhYUYxfBlbAD2xwUjte5Ouk/MEKc/prio1he5L
 C01qvTGhR1L90xykCdzOtZW21MEz4VxSdUNHUlk+hyh2rlynS+eyquOggxeniG44moK0FNvfsp/
 pa1TqNOBsHUy/7tA22AICQppbLYec+CgrDO+iaFs9aUu36ZKJ
X-Gm-Gg: ASbGnctZrBfbVShxCbHKys+DbgtPszfPVzXFSvnhEShd3KvpJFFZZ8bbQQmxHEq93hG
 BqFjhBUTs2cBqRZwNA/+gGnq79vutVjNzfreH
X-Google-Smtp-Source: AGHT+IG6W90d2cglAhGhSj2tVCdBNVZx0ihZciS5duRp8qREzBhlLCDmllgKbulp5ti2EiHCuyjdPRhibqoPXzZqECk=
X-Received: by 2002:a05:6902:990:b0:e39:83a4:dce6 with SMTP id
 3f1490d57ef6-e3ca04ed70dmr457638276.25.1733933064959; Wed, 11 Dec 2024
 08:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-58-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-58-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:04:13 +0000
Message-ID: <CAFEAcA-KRQWTSsdHUAgfetbXexF7pGV+pOwb8V0Z4ub31FbUOw@mail.gmail.com>
Subject: Re: [PATCH v2 57/69] target/arm: Convert FCVT* (vector, integer)
 scalar to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Tue, 10 Dec 2024 at 16:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Arm silliness with naming, the scalar insns described
> as part of the vector instructions, as separate from
> the "regular" scalar insns which output to general registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

