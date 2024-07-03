Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A892C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvSz-0005pV-51; Wed, 03 Jul 2024 04:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvSx-0005mH-Eu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:35:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvSu-0004An-Rm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:35:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso22779175e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995746; x=1720600546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOprfjwyHeimk8F510Cy31teMsJo8RKKe+vGzZOkp+g=;
 b=r0i+vDTuJz8cOv61XyY1Ti33QnCQvBc6gCWXG/OdfedJ1DexWqwRCu4uqwYnkY4SEl
 OS3iJgdvuaEOpKYujQ97hnmN+xxE4CJxyqJ9evju8FYkRJ6eg1mXc5CwYfUvuSwsqBuE
 IGI9+GCRkTMwcs3F+9y/mnLii5UmMP8RidiN8TmRCarvkV9bQUs8KONqfaYRdioHWTf3
 2/JJL6nsDtSjVe4VsRTks6k95XQqOWa3o0AAKEJSfYgmNgoSq7g325tLe/b/SJOPLhSt
 wAK8sn7j6W/C3RG3S0gY1uo9Pa3zgncUFixObPYYBZOhEqDzavncvSSqqwHGyakSKy8S
 B+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995746; x=1720600546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOprfjwyHeimk8F510Cy31teMsJo8RKKe+vGzZOkp+g=;
 b=MigGI5JXshraHSedeBf4vppxvcWGm30UWhIaFLdDEqbPh6Pkj4eBNkwnR+cOpDoQHN
 S4GN2E6jt2mZxIPJcEBNB9kk47Rw7YiG9QmHwCF6i+X7M1A+9nusQyuJVkPZS20yQkwe
 xogY16hNEnzXfNSFe/o1lsa7OW9/bEFGElt01L8Ew1/zor8DuRToRsvFiK6d2y7auKcB
 DOYnJAK8cLOyTfpC/gvKc2xyN53O9NQlty4lgsW6VmTPIe5gQ+BQ70UFXbfpdYUosBGl
 uqyaXSZGgqBe4iv2Pjrx/QO3yjqKqsKYXxNUbFDX8xA3uC8UHcHn2KB0SviF253efQD8
 1iUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP8Gb0Ro4U0fmrgOAnHhDmH38GxmduTwhWHlWdAEDfEUPo5eKnREew3dJAvu2W1o6As5Y9oTAVEdhKo/h/5R/B42XTmeI=
X-Gm-Message-State: AOJu0Ywig7bzvJOOe3p6PKwyghuQqIr8/fLOsnG1635ZGDMF7zaR42y8
 iqYrkoTVXpfvBK43SU779S0fekQknDsGC7bXwrQ0oBwWjYE0/gUzMTJvFASWUNOtcLEtAHRtVAX
 I
X-Google-Smtp-Source: AGHT+IEkPUJTjZSzLmsU+RVjEtyxA2PgcmXJS9HgjLzySVLg8S2B/wgO2YYeRuazm2o1DpuGniU+pA==
X-Received: by 2002:a05:600c:4b1a:b0:425:618b:3a4a with SMTP id
 5b1f17b1804b1-4257a0642d4mr73372985e9.25.1719995746587; 
 Wed, 03 Jul 2024 01:35:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c19eesm234967785e9.45.2024.07.03.01.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:35:46 -0700 (PDT)
Message-ID: <63049b8e-5639-44cf-b27e-ca9d52ee0462@linaro.org>
Date: Wed, 3 Jul 2024 10:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] qga: conditionalize schema for commands only
 supported on Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-7-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 13/6/24 17:43, Daniel P. Berrangé wrote:
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the commands on non-Windows.
> 
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
> 
>      {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-posix.c |  9 ---------
>   qga/qapi-schema.json | 15 ++++++++++-----
>   2 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


