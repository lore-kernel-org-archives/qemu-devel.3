Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B9CC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 19:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf3KE-0008Rn-Pi; Tue, 27 Feb 2024 14:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf3KB-0008RI-OR
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:41:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf3K2-0002aO-V5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:41:10 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a9a61545so12962265e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709062860; x=1709667660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Scz2vpORuLNSCcLlA89er8nXpE5G+w6OMsWbMAQTqEs=;
 b=EmkMrXaBNsBGZkkVTGsJTjonsyY6Qoc7mXKV2sQzMHsAeEj1APlzczKHP/v9FnSRW6
 BvjOFiUZDaJRkwqSNUVxkvR381OOdhAkAQ5HA8r4jGZzPcV0iBb5Vv0IYv2eCSScToHI
 dqJOxOiKCBlNX20SpP6hNu4Ms2l3LTF0aEwrxKPiJuOL6lRMycP8lO6/a27HN85n2+qH
 zSvM4+XRobe7DVnNWv9eyUm1wbU/IipPtYLjlUsjofQP5usjCf03KvlHsJf89W6QHRMZ
 rxfKpB2i8wJ66Iw0Ry8Fh2Dl1Z91oRthwB+MmtAj8xCVxPOcJsslvga3HSCgTROVpcNR
 +LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709062860; x=1709667660;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Scz2vpORuLNSCcLlA89er8nXpE5G+w6OMsWbMAQTqEs=;
 b=j7zLgQwhozOxT65xOu6kCMH8erEmhrn3AWs/yxfork/hAh1rd2oS+pZWfMSdEHa27C
 SdYhM7dGg4Yh48ruzYsLy6yY8U1fmUupJgkPGEJpPvHrkUrs2UQdGDbm7uJTVQ1LwfH4
 GXgBcmr9kzOI83+ay2yRiW5MpDC6ikjVlKzT/pv9a8zygkdUm7mCJ1zoKL9kAi0RmYTl
 eO6gD75GGD5zXJEg5nUtr8nCQHds3wjoNXPxUtDO+tmnqqqCR+6StPVVbIT8cPrCll7e
 DBvfN03v0T4yAMAICIdyxRUTQL+KEBf1P1L2alKTCNjuNdLq0R/6oao2B6wkWnHW7Mdr
 ASbw==
X-Gm-Message-State: AOJu0YyFz2RGI1r5KRTI6f8Cbl1v/eiKP5g89R06mJ0dtS+JbtTvyXz5
 33R2DlidsYhK3lOt6NMq5bP4tTli53bGVTpe590W4QiGfyU+9bTOKrTzDlJWtqOHqiWG+JGwyt3
 Z
X-Google-Smtp-Source: AGHT+IHS8xBInE/mTwTfgTOE2EUGnhA3arBXzjGfdc5b2iwDC/IiJYkbzFv/WG9jAPHHuAjJfAI8AA==
X-Received: by 2002:adf:fd87:0:b0:33d:b2d7:6264 with SMTP id
 d7-20020adffd87000000b0033db2d76264mr7418628wrr.51.1709062860199; 
 Tue, 27 Feb 2024 11:41:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g16-20020adffc90000000b0033d3b8820f8sm12165740wrr.109.2024.02.27.11.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 11:40:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F2DC5F7AE;
 Tue, 27 Feb 2024 19:40:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/14] linux-user/elfload: Disable core dump if
 getrlimit fails
In-Reply-To: <20240227184833.193836-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 27 Feb 2024 08:48:20 -1000")
References: <20240227184833.193836-1-richard.henderson@linaro.org>
 <20240227184833.193836-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 19:40:59 +0000
Message-ID: <87y1b5bsqc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Do not dump core at all if getrlimit fails; this ensures
> that dumpsize is valid throughout the function, not just
> for the initial test vs rlim_cur.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

