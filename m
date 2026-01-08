Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF65D14889
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 01:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdeyH-0002Dv-Cw; Wed, 07 Jan 2026 20:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdexe-00028t-8M
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 20:37:14 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdexb-0001pI-4F
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 20:37:12 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c525de78ebaso315369a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 17:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767836229; x=1768441029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ctPtHCUfr7ejr9LuUeg60zSFoehX2SMpY4hOWQd0nCI=;
 b=RgPpJw625Jufi27YnN7Lh2GszV+LWf5xyMdghYAueiEz6yX0LXKC7yLMufn4Cjmw0K
 oQGwZmuWcSYEM7ecGTTKL7qizax5mVhz8A2Jn2OXA7oIBVda5jXnHpTkw17PdjuukOo0
 WKm1sdc20ocbMFRrGk777RJBKtm0fD8D6bLdBhjAE5UZkoKkyFvSlpEW7OCH/3SoMFQ6
 gDLXO6UunacXMnPnDECjzXmBbmqZ2G9V7w50fXFR84QpqzgALJHDfvBM1S7hH0ngUpiO
 LI5gTQJIEpFXFeXqLMvqfh3ut5vidWYpMyE/PgZAP8S/4BZoqJw+lx2AnLPiKYky4xRu
 HkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767836229; x=1768441029;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctPtHCUfr7ejr9LuUeg60zSFoehX2SMpY4hOWQd0nCI=;
 b=ihlUJWErgdTvwrTHsuA8295iTIge2HGQCvHmt65HbVMMt8VkncBXaF2tdn41GBY55w
 UrMbpz0NxjA9Qk6/kLPe+vM6hoNs3GIGoccTpJ0Hckqi5l//RtHnb343P26R4Zk4/lrs
 mofSusqT9DpKPFYmthZ9MJqGCjUZ9qPvAUHFfSYryO/tXgr9JzzD2sM44PkTWv7Y1jlC
 hCeMomaEYfwDgVCIdFdr3o+0SMaysI2ayN9t4RWXYiJeycnFeasp1b/yNpH1r2hOrUVM
 a8+EKWg/36fuL4uoU6K85mCbJaqWrckY9vml24v5cbOBrCZLnQjwheG0NR1FdL0DAh3N
 +GmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSW4kHz9doALFZLVSZRrIB3u2Vcbh4qi6UR2YEH24TRgfr2CD9fUAbMkkFADoZK1Vj2vhagTVEWAyN@nongnu.org
X-Gm-Message-State: AOJu0Yz+dPxzr/DlM/Zl/8l7mOtlgyrf5mYX/pL3oDcLUPpZng/5TSvk
 jJqB0ia6I//N6lva4cSFQkK1rGc0h76mEuD4iDVdovUIyC4qC/1gFAakKEQbrJfbs6eOVoSMhLA
 NQpMjLIw=
X-Gm-Gg: AY/fxX7ANmOq0g8FxXzYS928Gd6akE6uErVe+FwXNDUDKSZXG8vj56tCAXMsZHjaXP/
 EcTx1qN6yMP04pHnmdeM3nPKhHxRRYXQbpNCh5KzvhZYfU5lw9hQSUzoPRIxIpKWjJAMXZhIATG
 UgiqDBFpwMVtuSx+lofy7Xqi8qwOaPS0bA/gHsiyq0S0jslOhSjEw6a0/NWDOpvXMeLmOIAK8kr
 jPpLwYBFTXb88dZgZKHkINW/RVQtdMDWtKnFHXQ33lzz2sTSythtUFLDjYAjrnF3oiDCq47Ofg5
 RgCJoiDkayKa5rqY6rtgCzdfSWTyzAuzvRE79Grr9JijiutdiXybFx3Hs0mFhJBy8w5hTz7PX/s
 sXtyWm0LV8Zs2jSbqVoUAQG3wFz6N2IdYiKA5BuGYiawE7lMHSMoW0gAQ3tNZOOfhvTAmWaD4lo
 /gG4TxFTR0db/XO8RU88j0+rRXunFDWw==
X-Google-Smtp-Source: AGHT+IG5enFZjKXT1PhlarAHtsbSFYLd3TrthdEGxEXz5T3ZONEMDwXUZrUKPWl6CWbnILWFb7tQ9g==
X-Received: by 2002:a05:6a21:3286:b0:35d:53dc:cb57 with SMTP id
 adf61e73a8af0-3898f99efd3mr4545591637.49.1767836229024; 
 Wed, 07 Jan 2026 17:37:09 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cca06b2edsm6252800a12.32.2026.01.07.17.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 17:37:08 -0800 (PST)
Message-ID: <6879f8ef-06ce-4ed0-b094-c63f5e273dfe@linaro.org>
Date: Thu, 8 Jan 2026 12:37:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] First set of s390x and functional test patches in
 2026
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260107120638.56735-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 1/7/26 23:06, Thomas Huth wrote:
>   Happy new year!
> 
> The following changes since commit 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0:
> 
>    Merge tag 'pull-aspeed-20260105' ofhttps://github.com/legoater/qemu into staging (2026-01-06 06:52:47 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-01-07
> 
> for you to fetch changes up to 80802278817770783a07eebc06adc157df89d827:
> 
>    tests/functional/qemu_test/testcase: Fix mismatched quotations (2026-01-07 10:41:40 +0100)
> 
> ----------------------------------------------------------------
> * Compat machines for 11.0
> * Add some more files to the MAINTAINERS file
> * Use explicit big-endian API calls in the s390x code
> * Add the possibility to run sub-tests manually in the functional test suite

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

