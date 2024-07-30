Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287E7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 18:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYreF-0000K7-RP; Tue, 30 Jul 2024 14:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYreE-0000Cq-3X
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:32:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYreC-0002CU-Du
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:32:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281abc65daso23560905e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722364351; x=1722969151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ONfisXJNQoe9Z7S6EcbzXFkVUygBUs7h+VpdAEKqDco=;
 b=bOWDHJB39TCguohRsMpuCP6kNp+a6dhhxqee9RXpOIMTfyc69VouAJLBhzf5SwqV3H
 7p1Qjx5F9POLVeU5Ja8BxixWf1+GIm4onL/XmQMIGYilFiZIZ4NDnXutt4W0csRif7HF
 my9k5hWl+sXSlymSszAxPgQQX663BhzjkJ1wKBQ/aNGoUT/s5I/eCxweyehE+uPR8nJ0
 X4IJrhwm3d5UQzmfvTN7IkokKgmXUx92WE+SEo19xnAdLUVeH7jiCbS+V4rq8O3Dz3ia
 XloV6Q3sg/8CPRJOkNPcoBVfKtgJ5EQYYCkN1Mn1v7bPdLpZzQgqz+X3fKRGgkeKplFl
 OqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722364351; x=1722969151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ONfisXJNQoe9Z7S6EcbzXFkVUygBUs7h+VpdAEKqDco=;
 b=Kiq1gZ22LfDMAt2rncHDNpdXnH7JHeF7mpwEpWm8JJ/ShcYHSuSiDxDSO2We/NC8S4
 Bz8/1jRyTrHyD/SjrSW8yvnX+jYKinnAa5LWc49x51rMGv4Lj9lDC6GDjy4Rui78gnMM
 UWuJsC8e/B6SprqV2hMtZn8cZBsm297vu3KBqBCLr6b11ap73OXaI3qlwSC9A8ePqQff
 sKuhyE7huhQFsFAVh3GOnHr9JUzEvu+MFen4FlPMwITGFEL5jUTcR/+CD58hUWCcy/Md
 Fq1rErNlFDciCtPU70r4OhbaMXdhgAIsqT0+MST0PdPeLgzlG8gmBWhuEHz33R8tZoep
 DIkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrWyg+jfAcfHntfLtNhLhin1YKumPU60iwcnqK+SizBeS5D0N5FiVUv9OROKxwQblGncrfOVEcrlL2NUPo60aXD/BSHkg=
X-Gm-Message-State: AOJu0YwPiKs4rmNfXnR8ABbk971FW2ibbjOoq414vgkY2PqA/PN+2Uo+
 99jmugzeMOGgWEap5GH4UXSBbNRH8BSmSUXq7X9z00h1GzIaXgB2l+kCRzGFhW4=
X-Google-Smtp-Source: AGHT+IEheMKJ7H+QUoWPvukOqH45IDE5dC/iYmgIGDdjV0jrubNKK5ak2+nJ/T29a5xOjF8YJ1N8Hg==
X-Received: by 2002:a05:600c:4592:b0:426:5f09:cf57 with SMTP id
 5b1f17b1804b1-42811d9cc4amr77371575e9.19.1722364351052; 
 Tue, 30 Jul 2024 11:32:31 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281a26e1bcsm99323855e9.34.2024.07.30.11.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 11:32:30 -0700 (PDT)
Message-ID: <67087083-20ba-4a71-b547-0273604318ac@linaro.org>
Date: Tue, 30 Jul 2024 20:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] osdep.h: Clean up no-longer-needed back-compat for macOS
 10
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240730095939.2781172-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730095939.2781172-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/7/24 11:59, Peter Maydell wrote:
> Our official support policy only supports the most recent two
> versions of macOS (currently macOS 13 Ventura and macOS 14 Sonoma),
> and we already have code that assumes at least macOS 12 Monterey or
> better.  In commit 2d27c91e2b72ac7 we dropped some of the back-compat
> code for older macOS versions, but missed the guard in osdep.h that
> is providing a fallback for macOS 10 and earlier.
> 
> Simplify the ifdef to the "ifdef __APPLE__" that we use elsewhere for
> "is this macOS?".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/osdep.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks.


