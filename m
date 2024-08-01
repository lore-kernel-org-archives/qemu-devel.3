Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABEBC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYeT-0001fI-Vr; Thu, 01 Aug 2024 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYeJ-0001do-7r
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:27:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYeG-00024S-Rl
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:27:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so3597053f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722529647; x=1723134447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hFCFouMA5clT5H00V8FzmR84UFHbxeF+7o+n5k9DLHg=;
 b=PgPkfJ59p9hUR4qFQb9YFRLsaixPlKbpaRiFojMdeMfKWOkyWs/heRSWNLTFPnXTzv
 qfAQT9GvOy4dJAgtkqQ46qW1utxdH1YW9ORifOh21WWnFW8yx/TvqlE1Cl9g8EIUkBvP
 HcCvqIIlVKpEqDj9gWAFFVmIkpqw4yaD4/tTMfxkKwJhxHc00/bJww0SVLuNeYOYGKHt
 s1peP2YLC7PtsfWleD7oZrIxws6Mdh4jk9ujne12ljx0b+5NGuU3rEosiLrBmkmdysr/
 2u3zaf/XJYa6SO5KU8AEr3ta9N2eAsRZ9BCP6MxPg1i1RVNz+ii20dwJVKp8YThnFW2m
 +V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722529647; x=1723134447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hFCFouMA5clT5H00V8FzmR84UFHbxeF+7o+n5k9DLHg=;
 b=mJVSKqL41bIjIQdiDDu7q2c0EHdJM2qLEZ6/jCNpeu+OvoBfNNIfoTlmEIfi+8+Mqg
 /FWT8bx0ShIz/jlkXQx5wBgP+oGJf8+02DoGLGFoaBGf8hJgBedE1W87XpZG/EOFoJTb
 h//lCekh6IxCKCTuB4dwfSYqXDupS9rGwV2NLbdOvv9ys8YQrde6FJO1gsB9GVJhkSgz
 hY3JTnqLhqKiC8dZPmQrNtMgFPdlyhJSBy2MWlT5aUA6fjYZ/KHh/1/O4u87/KhHyfD9
 ZY9nNzIsfoaxsf2/US0oYZSgzxkpgiFyPP/2MPKy9RKV1d+qtlzwRYQKXt3CJpqbPERD
 WdNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlZ+zm9nvtshMHxDfLB8V24SK1RuUp0GxXsuK2vCaZO6x3v2WrjnofFl28pWVI/rvUnqAPtGRK3eGWgxDuysbNHrC8ZHg=
X-Gm-Message-State: AOJu0YzTlnGNHqPcPmminSXh2HldrTu9KPZtwwkp2viylcyg3ZY28Cxt
 FeYk6nXh/0ljoGOgv6G1o0EIu9o+rINxhCD5vVQ+TXFIbZYW8gyhtF8YQGwACzs=
X-Google-Smtp-Source: AGHT+IH2wGlg21gHxerRd6Xq/WssfX8R2qGwHE0Xc3Ip1UZd/WfB5rqjqqKsMW8tzCDK2+Z0qs6zVg==
X-Received: by 2002:a5d:6903:0:b0:367:9903:a81 with SMTP id
 ffacd0b85a97d-36bbc190fbemr266532f8f.43.1722529646721; 
 Thu, 01 Aug 2024 09:27:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0829sm19771540f8f.17.2024.08.01.09.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:27:26 -0700 (PDT)
Message-ID: <7f5e7145-bb35-4583-98b6-27df460aa347@linaro.org>
Date: Thu, 1 Aug 2024 18:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/24] tests/functional: Convert some avocado tests
 that needed avocado.utils.archive
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-13-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Instead of using the "archive" module from avocado.utils, switch
> these tests to use the new wrapper function that is based on the
> "tarfile" module instead.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  6 +--
>   tests/avocado/machine_sparc64_sun4u.py        | 36 -----------------
>   tests/functional/meson.build                  |  6 +++
>   .../test_arm_canona1100.py}                   | 30 ++++++++------
>   .../test_ppc_bamboo.py}                       | 32 +++++++--------
>   tests/functional/test_sparc64_sun4u.py        | 40 +++++++++++++++++++
>   6 files changed, 82 insertions(+), 68 deletions(-)
>   delete mode 100644 tests/avocado/machine_sparc64_sun4u.py
>   rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (52%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_bamboo.py => functional/test_ppc_bamboo.py} (60%)
>   mode change 100644 => 100755
>   create mode 100755 tests/functional/test_sparc64_sun4u.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


