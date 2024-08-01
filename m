Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A3DC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYrI-0004mA-A4; Thu, 01 Aug 2024 12:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYrF-0004hj-84
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:40:53 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYrD-0007WO-NL
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:40:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so9708783a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722530450; x=1723135250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFv8+bFaAX4XJAhR/zrYQwvP5KXnyrUNY4dtNIYiqOU=;
 b=pWxBXef9YX+ZCqN57p1NZxwPh2b8QXdlSJn1py/x3MPRXmsP/yQeY+4BuC3Z8Gk9SR
 y9VdG74Z6lkdeLoa6SpErd/8gv1WvBaXThH3GEPkJvUL36nWyX/YrdUQbtjpvhOpwIW6
 qv/lsiAF6uElYuk9ZFrPOz84SGHZDGnTELl7GUZ7fgvnACfBAyaHZ2tCslckv2l3rSNR
 AJtQXfIOmIG7ev0KwCk0ayqWkY8jnyoRQuIaPoMgc0QkZdQIuDypssh+fDet6DtgCW7M
 FqIj4klK2Z8v6ZEDab/jlhcVD8LXTKhemT05uptxn+2SuyPly3tREjVNBoKRCQZrDdWj
 ADZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722530450; x=1723135250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFv8+bFaAX4XJAhR/zrYQwvP5KXnyrUNY4dtNIYiqOU=;
 b=k6QIqtyF4iJ4CGcUCaolLVfGYDliWcq4yuU6d+YJ1ZwCPMZ8cMNmmNrf4hHpPytDVM
 GZ40b1fZNU/AcVEniHKBAmhCVfcxYx5a9xhTZWgDyMxgmrEEYJdSXe31k04iBzSW0pZP
 uHPBZLzNYLOpWrRBrtkimA8qgIR3vc3H2Ne9nI/z9d6DCArqosjMfiY43pK9xgXcutY2
 rWtnVOumX6ses9qIawBe4R8uTzKsZX+8icP6wJCEfAp6y+p8YChaEVaAl6Pkgkei8Ja6
 cap3/f3Jz6n09JEMk/f5sTIRsL6zHopAaXd+rmDYrT8Eo3FlZDi+HaqdyifMCV4Kr38+
 iu+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULEV1mzJ3Wta0S6RyR7PVTJuABUfrmgpT6IBytZjU2wRnOmpTx/AAJta48Tn5dv9mBrFljmaM5i7XHReeXJkmuN2FDsLk=
X-Gm-Message-State: AOJu0Yx2BFwTs+J2/9QEfODmK0SoyQeqiJ1V1DtzjxIdRC1wUMcTBR0x
 JP43N57XxYAbHMtWdC2Iyq++jJ9MZPYc8zhC6wso4S5kylagyL+dFCAdjPz4hY8=
X-Google-Smtp-Source: AGHT+IHasACKbww1xqE33+RoP9nl56m8M5t+NVrlo3GaX8XGYOAsgbCEoqUUGgeOPYFyJGo81r9Nqg==
X-Received: by 2002:aa7:dcd9:0:b0:5a1:40d9:6a46 with SMTP id
 4fb4d7f45d1cf-5b7f5dc5d68mr638962a12.36.1722530450069; 
 Thu, 01 Aug 2024 09:40:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590e73sm10459950a12.35.2024.08.01.09.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:40:49 -0700 (PDT)
Message-ID: <64746db0-7ae0-40bf-8c0f-9c5a3dacdb1d@linaro.org>
Date: Thu, 1 Aug 2024 18:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] gitlab-ci: Add "check-functional" to the build
 tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-25-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-25-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that we converted many tests from the "check-avocado" test suite
> to the "check-functional" test suite, we should make sure that these
> also get tested in the CI.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml |  3 +-
>   .gitlab-ci.d/buildtest.yml          | 60 ++++++++++++++---------------
>   2 files changed, 32 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


