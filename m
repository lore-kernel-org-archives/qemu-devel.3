Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B03CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclgb-0007YI-N1; Thu, 25 Jun 2026 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wclgM-0007XQ-20
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:07:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wclgK-0005GK-FJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:07:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso15297905e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782400074; x=1783004874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccD3CjECNJ4P0H4BwiPG6dGwuaFWZA8In+HFpq91zBA=;
 b=sy6ICFwRlBim+K/Cphc3/2YbKLntoHuBiDyTGRrc0Lfy1j4BDAKWrcbogpp2VElem+
 pSJmyNVtevnugMC8jrTw6cIvsKeFxtpn8GBKXpxaOzkf2HWUfucmfDonio1VZN5VUboK
 ld9f4glqde645DxTorWTvN+Tt8Ctx8EqtjwL9eft9EgtNecz1KFLEQdXlDqWMeFFqVsR
 DpxDye4zz+wustql1mCIWX86A9MtNAwGezcghAo1EuHELfBij+Dg+uswRKsY+cB2Q4aq
 qOndlWIzN3p/WOaOlY1GqRycDAkV9KQbT1mjKUoXsvn59/hXv8Ab5/shSgykPFZ8M5np
 iYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782400074; x=1783004874;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ccD3CjECNJ4P0H4BwiPG6dGwuaFWZA8In+HFpq91zBA=;
 b=YRGF2SwVYFtBLvhVMl+fbU+dMhSMgBhGRFvV+mcWVbF12E70nm3slx0//D01hfXGSU
 sGc7SJ/KRnrLTFGTYr0BV0OBmV7FH9mOocGmQc6TYhD1wx4D8bwD4KViNZs5PlL/66ui
 W8j3i2ZCRM1q8PohyQayN8ZVR9MjEF7fr8w5mUwKi7T8ELMEXszLeGTvOt/93MgibnOu
 dx5C1ycPbm9XKAPAP7FaqDC2ewLcSjakh3XI7TajJERKwHCwEKoAmcEPZ1vCRRJe9IPW
 R199OqnOsI3hFDYgHoDPDCtHLm0fxwieRiG9KCeL+r51U3WIs8iWdGhVoYNc/2HHBMLN
 qIpQ==
X-Gm-Message-State: AOJu0Yx/CHQIrSIjdhjcDrF6Sg/SEzx+A+vmCokdZKavWpiNs1WiobF+
 i6fQ/hOUVLlKQKhv0bVxigBbxkrNSb/cVTyOek+aHbCYG6IzDJ7s+PEkwFgq1F8kuV8=
X-Gm-Gg: AfdE7clx7i+Jy36GoPg+n0Jk1P+SeGk7J77OQdG1PHGpCCJvgUWgrU8F8I3Y0C21awd
 k6RyG35CM0/Luj9UI2+Uj9C38zBb9yXhyGWihhvNzLvAvjhfRtDEMnOM5ufUuQlHrSET0gipA+B
 vK2euH+b5jITUtdGqAXUa3Fb+Jwzpug5KwUHZ4ts5ecYGF/g3IFdtXNsWUGNty11SxEw7MTneqW
 EsE3LB639gbUoBn/B6FE6FmZ8xY8tg/cAeOab7ubRkMo8a22vF1c+D7o41CmiEnQQgmeQTnvuW0
 35Iqf+Vr8lqkXx26bDZPGTMMBEM9h2RzASZd6XJSESU0MwqeNvWXgbusnP5b1msZXrft3OD53z8
 SyOT/Ls2yI4dzuk8Vpm/KVebcZizLAhnGIzptgXafVfy3+twmO6VoCBftSfTcDhx0fbmxKCsEek
 5IOidL7gRkSA7T6Wb4AnVHRk0=
X-Received: by 2002:a05:600c:3b24:b0:492:3fcb:22fe with SMTP id
 5b1f17b1804b1-492668551dbmr44532855e9.1.1782400074010; 
 Thu, 25 Jun 2026 08:07:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269005626sm3267495e9.10.2026.06.25.08.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:07:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E5FD5F8E5;
 Thu, 25 Jun 2026 16:07:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 6/6] tests/tcg/arm: Tests for new FPRCVT instructions
In-Reply-To: <87qzlvhued.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 25 Jun 2026 09:54:50 +0100")
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-6-dc6cf8e512b6@linaro.org>
 <87qzlvhued.fsf@draig.linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 25 Jun 2026 16:07:52 +0100
Message-ID: <87a4siirp3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Jim MacArthur <jim.macarthur@linaro.org> writes:
>
>> We autodetect the presence of FPRCVT in the test cross compiler,
>> which is a recent feature in GCC and not supported by many distros
>> yet. If this is in place, we compile the existing fcvt.c test with
>> an extra compiler flag which uses the new SIMD instructions; the
>> output from the test is unchanged.
>>
>> The existing [US]CVTF instructions do not have a test, so no new
>> tests are added for the SIMD versions. They have been tested manually
>> to check the new SIMD versions produce the same numerical results as
>> the existing versions.
>>
>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>> ---
>>  tests/tcg/aarch64/Makefile.target | 14 +++++++++++++-
>>  tests/tcg/arm/fcvt.c              |  7 +++++++
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makef=
ile.target
>> index 6203ac9b51..32f2689273 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -28,9 +28,21 @@ config-cc.mak: Makefile
>>  	    $(call cc-option,-march=3Darmv8.5-a,              CROSS_CC_HAS_ARM=
V8_5); \
>>  	    $(call cc-option,-mbranch-protection=3Dstandard,  CROSS_CC_HAS_ARM=
V8_BTI); \
>>  	    $(call cc-option,-march=3Darmv8.5-a+memtag,       CROSS_CC_HAS_ARM=
V8_MTE); \
>> -	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme $$fnia, CROSS_AS_=
HAS_ARMV9_SME)) 3> config-cc.mak
>> +	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme $$fnia, CROSS_AS_=
HAS_ARMV9_SME); \
>> +	    $(call cc-option,-march=3Darmv9-a+fprcvt,         CROSS_CC_HAS_ARM=
V9_FPRCVT)) 3> config-cc.mak
>>  -include config-cc.mak
>>=20=20
>> +ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
>> +AARCH64_TESTS +=3D fcvt-fprcvt
>> +fcvt-fprcvt: LDFLAGS +=3D -lm
>> +fcvt-fprcvt: CFLAGS +=3D $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
>
> Do you actually need $(CROSS_CC_HAS_ARMV9_FPRCVT) in the compile?
> -DFPRCVT handles the compilation.

Ignore that - I forgot about the march flags.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

