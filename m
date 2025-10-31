Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0B9CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElNu-0008Nk-UY; Fri, 31 Oct 2025 05:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElNs-0008NL-76
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:25:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElNn-0002xo-CZ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:25:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso428919266b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761902713; x=1762507513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFmSRldaRTZiq00A7g++ng5h8/5HD7lZJSv0aGme9is=;
 b=jPpmQ55pwGy0ekjq1EZNQqN20GNkreEDKke41upLh9each9RtFsX5zStbA4bMqQZh7
 N7xDAHiAZrg5pxuW6+bM9jc3AUK+yJvFxscC65CbookRW2vr0x/7ZhEi0WUKCGj6H3D/
 q6CKD6xlCkFicFep32nL9qF0PgefuVK37jgSCBHOSYCaNxaBqQbBFW5GLf+2k4d2n1lv
 E7rcZEl9LcFv2mruPWAcM6AZlUt+2Zr2E368FLry82HdeKJ9cQ+IKc+ze1AOv8UnwuKc
 BlRNNNn3twIb7XupNgqzjC1gin1A6Ps5kiQKE0ho2V9guQcjhoDiYbsmvpamgewLIhEF
 Ygqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902713; x=1762507513;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFmSRldaRTZiq00A7g++ng5h8/5HD7lZJSv0aGme9is=;
 b=RNlolD+GkuFsPswOdqRIa+xrGkj2dxpnn7mnF7HZMy6RRKG4APA1XN5vU2f2mE4Dqa
 AjQLbEyhriW820+6gM8Lr7egbcgmHuPZh3cAj8Uo9Mh+qbsRFioOtFsUa/t5WuAF4B5a
 xMVM/GQkbWd3/ElYWKV/Z0SbZw5qAdwiuZIlwmBc/uCOVt/DpQe+BTZCJX+9AuZD1GnK
 jjCMClkjO/idgrQlSsLMjG1xqiMwPQLWL0JKzs/kD7M7AYCnmA/L9LXv/KIU1MC80l5K
 U673rYCHTtgBwdhnPPPnlhtRWSrdBzwlSGngw6cR2eUrESSehzyj2HWws1XXxhqcurQG
 ke7A==
X-Gm-Message-State: AOJu0YzKqink2RoM5yfFN2IoYb7DeYsAgiqOa/2n6MEIVC4c5YIckoKF
 kRCuZDXfzUCh230kgjk+6dcWpdfGw7fHNP3koKamF14IPvDOk9ajrffpzkAiNkJd+6a2IHQ6elS
 fGo5veygozg==
X-Gm-Gg: ASbGncsUutlkxKJ5olAXGn0onulRY6uXF0ZWhG00FfTJ/haM9HEs7gHwUPiX2ao+bi9
 88HMdkPPV7eDmkv2FTeBi1NwKiwJ3Yxve4G2fv8u57y47psTDNohfp2f8NHn78NKJm+4Tz2UY5k
 a6jh7kwz3cgL4xN2cU0eJvlHm79FWDcr6htstx1mvUqJc0OGjROyq2Ovgwb4tLXUoMvlnF+/7NU
 LtfWcwJl1CzhpX/LPI8pBukIZcK1foX6Eke0A+rQJ5UjiaMhvrXmX63cAGK+yNygqFkDdVd/wtB
 c96/QxxdEhfnqAqc06jvGTNYNHxrlCW4OWQhUygMZK/zSBxLQ+9wzJKb0kfC7v+EPfe+xk5Lgmw
 8V71jSdbHczrluIAHGvbun/bpwGO8yum4UQNjjVnzQ50ZqLVAhajEuKGTmHAjPL2T5MNJ56Aovo
 nKqQm2eEwExxcJ/jGeSA8jlZxQQG3HNGmsq8agJ9GmXDzcx5FrOZElEQyjE101Yw==
X-Google-Smtp-Source: AGHT+IFxZBGOS/nAWKDpJfUuDqmtFzbK9L9m0lAJeyPujFC0HOmDuznjbDrYsPIWpzcAMZZyUTWrgw==
X-Received: by 2002:a17:907:94c9:b0:b2d:a873:38d with SMTP id
 a640c23a62f3a-b7070626882mr304127966b.43.1761902712568; 
 Fri, 31 Oct 2025 02:25:12 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779762f8sm129269466b.5.2025.10.31.02.25.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:25:12 -0700 (PDT)
Message-ID: <45b46deb-f2b3-42bf-8a43-78735f46ee29@linaro.org>
Date: Fri, 31 Oct 2025 10:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/18] Block layer patches
To: qemu-devel@nongnu.org
References: <20251029120634.288467-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 10/29/25 13:06, Kevin Wolf wrote:
> The following changes since commit bc831f37398b51dfe65d99a67bcff9352f84a9d2:
> 
>    Merge tag 'hw-misc-20251028' ofhttps://github.com/philmd/qemu into staging (2025-10-28 11:48:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 911992fd6ec7a84c7cc82831b4bcd8a2ca5ccc76:
> 
>    qemu-img info: Add cache mode option (2025-10-29 12:10:10 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Expose block limits in monitor and qemu-img info
> - Resize: Refresh filter node size when its child was resized
> - Support configuring stats-intervals in -device (instead of only -drive)
> - luks: Fix QMP x-blockdev-amend crash and image creation with detached-header
> - iotests: Several test case fixes
> - Code cleanups

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

