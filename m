Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 14:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNZEc-0002Hp-Gp; Sat, 29 Jun 2024 10:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNZEa-0002HV-Bt
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 10:39:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNZEY-0003C1-Am
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 10:39:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7066c9741fbso1268775b3a.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719671960; x=1720276760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QWabUY8VhyOoONUBSATqdepR3722gNW8/ri6Rioeo4=;
 b=y0lY1ITNse2B1mTxA6vyL4SxImcBzYz2vQCYCUILHnP7lmA22Dvgnb+m7Vv2XDKGWY
 xDHiAUgAzPCCOgXoKD/bYj2Ys9bDkHvceSkO0Vy1c2UFTz1YuO1Kz0ZBDbqV0Ul3e3VX
 wiUaUzFkNfATIejFl1IzuIz8+v8btR84/hr97FGh9znmWmzcSdbI+ouYUqmvOqo7STDa
 BGuWJ83bmdHRsa63LCXwCyTD1PGZPmDXIYcr1Nb67NbI9f8uU+t37RWOqZwMTwmBuh3V
 QkYAsGvSnC7CnBgYPnQgE+XhGiO8uTNwKqu1tt3jYTP8D0aGwFjncfXyPkEUCmbzWAhW
 7q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719671960; x=1720276760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1QWabUY8VhyOoONUBSATqdepR3722gNW8/ri6Rioeo4=;
 b=a0+ilEsq4g+a5Jz7m2iluTYWu6sg9FJxSQJrKiayT7Tn1JIEYIG2BPRd6Vl9yC6gxA
 UDVOr8MqkZUAhF8M/13DxtRuzuf0wVpnBCGrs9w4+vJ3dLwBEp0jsqjDI1FnO1VP563T
 BsinS+Y7LKmX2YhCHQ2Cv/aPPRjTipCcToWzhzcj8tSjORfwmzDM08QfpBmytXl5VNNP
 U73dwN8tb4Dv68wRm/VH7Tz35+BnXdLQtHwtrchaPiOR/8pflYYhZgFfHfQqDp643BFN
 UJzp0MJnd+xkydhq6iNQ78GJYsHUeE/OS6uqIQS7Fb5TmSdEBGKx/0m6mTAPSzrGRPiZ
 0inw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuQDIGNEW9nG0cwQUed8x32K/+maeJbFeG8p3zvLOceLbwIpZkFEmRLaoy+fXoKREcbwhUUvX8jl8hBezMy9B/uynJGOE=
X-Gm-Message-State: AOJu0Ywjh1/UeHp+wetlT0MP9awIxcIRMZmtGCZV2mtj0X18ZNNeYsy/
 T4AJBjYFw5sr7CF2n0jrM3de0X0nU9JN73NoCSmkKR56AznVw+QiSUPzRlhuci6rEl0b9D3KPmB
 V
X-Google-Smtp-Source: AGHT+IFcZeIBgjD6gJE/qR8jEaxaQeObUAYG9t7xEqAbcl4R4v4wQGpAES4SXjv8IJg3dUlmU9+/tg==
X-Received: by 2002:a05:6a20:a988:b0:1bd:27fd:ff56 with SMTP id
 adf61e73a8af0-1bef6243146mr1330246637.58.1719671960429; 
 Sat, 29 Jun 2024 07:39:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c69b51d3asm2633417a12.14.2024.06.29.07.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 07:39:20 -0700 (PDT)
Message-ID: <2c4f7e9d-0ecd-4bfd-b5b7-b771d0f5c2dc@linaro.org>
Date: Sat, 29 Jun 2024 07:39:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/23] Misc changes for 2024-06-28
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240628172855.1147598-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/28/24 10:28, Paolo Bonzini wrote:
> The following changes since commit 28b8a57ad63670aa0ce90334523dc552b13b4336:
> 
>    Merge tag 'pull-riscv-to-apply-20240627-1' ofhttps://github.com/alistair23/qemu  into staging (2024-06-27 07:36:16 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to b31d386781cf85c193f3b1355dd0604cd6a59943:
> 
>    target/i386/sev: Fix printf formats (2024-06-28 19:26:54 +0200)
> 
> I dropped the bit test instructions and the rest of the decoder updates,
> because they were buggy and I didn't like any of the fixes I could come
> up with.
> 
> Supersedes:<20240624135939.632257-1-pbonzini@redhat.com>
> 
> ----------------------------------------------------------------
> * configure: detect --cpu=mipsisa64r6
> * target/i386: decode address before going back to translate.c
> * meson: allow configuring the x86-64 baseline
> * meson: remove dead optimization option
> * exec: small changes to allow compilation with C++ in Android emulator
> * fix SEV compilation on 32-bit systems

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


