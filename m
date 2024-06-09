Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C589C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 09:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGEVV-0006Pe-2M; Sun, 09 Jun 2024 05:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGEVS-0006PJ-Q1
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 05:06:32 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGEVQ-0001Zt-VP
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 05:06:30 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c2eb5b1917so555297a91.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717923987; x=1718528787;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nS/xyx91Ti2NGlgKmQn7Ab5LWao7+anvDTB6TfeVMcw=;
 b=tA24LL9xr/d+WHIWhydUp1/KiAWuE5VsYkP1n8WmsjLhLn33CT8VXI9rVDA2RBtdBV
 hRzdFjRhuCsst3wyF1xEzq05IpXl6/3brcqqFhMvTh+DjdJw+VoQh8pQYtlEpgHapc1B
 O+QFv+hRSOYYMTXZyC+svCX+Q51TV77nLXbelYDkoIQPw30AxUu7rNfGmtonLayahXW5
 C3ColAoNk0zfUlYmh2g05Okq3nkmgbasIdRmSx59mglv+RR8An7i9AKceacCV9L7Iwug
 kZtUyZJm/5kTYctMt6pjnZLCtClHc9oEMwyzY7HPxzKU2R9qAe2EDA39TU0cLT7fpyCQ
 QFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717923987; x=1718528787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nS/xyx91Ti2NGlgKmQn7Ab5LWao7+anvDTB6TfeVMcw=;
 b=wIDfWZBzf2rz+Cd8Zptpz3mEVSiIgJeUCeZZSEAy05x5ysG4kYcqldTziDVUAyAS6v
 8GZP05CYukFbz+yZ2mig416il4qVFNonXDAwYMnhqsMlJ3cikIWyNaKqHZ/eBMguYhXO
 HMrO8nz96gJbPyFFJZwsxh1of89LJDJoqEiBKiEZqPDz1Ll95B/8qrrN9EvZ3FQGcJW+
 R6oTon8549fKYX/uJ2v9iqX+O47tDMhd8GvMC7iKbH5jZGQlKXPZPKmKyUITQydofQOx
 YiCig/tFeFVr8S+q5kLcl1mMeBsfrU4a9QQRFY7de7081bMZ6zf23y7rE09lpNsBE0g0
 ZiNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnE8/xO3ZwJ0QeZ5aCrIkO0aRh6ecOdTZ8MRkk2fEjkc+tu9zeDSGVGUTpVS/DHiynWzvZ/pEM+ptSv8Cv/+wFa8agJTE=
X-Gm-Message-State: AOJu0YxL6gcXhpKCsFXpELgYRyLX5Tl+do3axEWMcuDtZPNpzQ76Bg15
 GEzuUKuVpoPvssZ7xPrTj04CWi8TtFbTihlkVYzgc1KWpP/Ag+5jEHgYxDIZSHI=
X-Google-Smtp-Source: AGHT+IFmrXA0FDPzYY887nBn9pXuFmqJcDHjk7TBU4kTE0BzCVVrwH2ndyvutKMDI7QghQa/xZ8/gg==
X-Received: by 2002:a17:90a:4494:b0:2c2:fed5:b88c with SMTP id
 98e67ed59e1d1-2c2fed5b979mr467385a91.47.1717923987439; 
 Sun, 09 Jun 2024 02:06:27 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2eceb5b29sm1708501a91.51.2024.06.09.02.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 02:06:27 -0700 (PDT)
Message-ID: <dd047370-f0ed-4b8c-a251-037e82f64986@daynix.com>
Date: Sun, 9 Jun 2024 18:06:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ui/cocoa: Adds support for mouse cursors
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-4-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240608202045.2815-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/09 5:20, Phil Dennis-Jordan wrote:
> This change implements the callbacks dpy_cursor_define and dpy_mouse_set
> for the Cocoa UI. The incoming mouse cursor image is converted into an
> NSCursor object, allowing the guest mouse cursor to be rendered as the
> host's native OS cursor on macOS.
> 
> This is straightforward in absolute pointing mode, but rather trickier
> with a relative pointing device:
> 
>   1. The cursor position in Qemu's coordinate system must be translated
>      and converted into macOS's Core Graphics/Quartz coordinates when
>      positioning the cursor. Additionally, the position already includes
>      the hotspot offset; we'd prefer to use the host OS's hotspot support
>      so we need subtract the hotspot vector off again.
>   2. Setting the cursor position programmatically on macOS biases the
>      next mouse movement event by the amount the cursor was shifted.
>      If we didn't reverse that bias when forwarding the next event
>      back into Qemu's input stack, this would create a feedback loop.
>      (The behaviour of affecting mouse events makes sense for e.g.
>      setting the cursor position in a remote access system.)
> 
> This change slightly improves the user experience when using virtual
> display adapter implementations which check for UI back-end cursor
> support, and fixes the issue of no visible mouse cursor when using one
> which does not. (Such as virtio-vga)

Thanks for working on ui/cocoa, but I already have submitted a patch for 
this particular problem:
https://patchew.org/QEMU/20240318-cursor-v1-0-0bbe6c382217@daynix.com/

The difference between these patches is that my patch does not use 
warping at all. I thought reversing the mouse movement bias is a fragile 
approach that depends on the details of how Quartz works.

