Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C642606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qTgIzU0m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLymk-0005Ob-M8; Wed, 28 Oct 2026 04:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLyme-0005OA-VW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:13:21 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLymd-0006fb-Au
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:13:20 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6d68de53053so395156eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793175197; x=1793779997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wjbt9jPYdv0P8sNEBRkDoElUuCtmdG9u4NPq7SXa/gU=;
 b=qTgIzU0mO5oFI0uR7gJFUs3gv9RVuHVYGYvqzv/Z8P4trp0uwHX2KLXEKpY1D5cQGY
 CfY55lM3PwhoN/0DzybSzqCaSJ5LxH4Rt8GBTftxCkm+bJzcsqg+axMp6MZ/btuf7pcv
 4vmzn31j7F2Y4+mvDQgHdd522xIT/ar16MuZ6KiLVcdI+jpdvPOl1KZ01oTxrEVEDb1P
 m4/vIevdO9Zkf9ZZoJh4VB1adeBJtIvcJgRTY5oOqo8964qvENG1dMAJ+2SyW1wLzPal
 4jhSAAkixoR2GjdRs0oJl3pPgPtkC0Pb2oZXh9DKYnMtfUMvVHtzVjySc1A31NEMEVyd
 EfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793175197; x=1793779997;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wjbt9jPYdv0P8sNEBRkDoElUuCtmdG9u4NPq7SXa/gU=;
 b=PiqyeBBOwzYMWZQuld3Yl6xePf4gexIf/t9xgci7UTBdqogyIru9eihBJQLiMC3Kbj
 kXcDpgKZXIHYZxsBYyBJxJziZLh1TzCbpfRZwxYFIDo/HHiY16SwrvAACYgSBrjsz4tv
 U6DzocXEQXcev8oB6+LtCfyF4yHTYtQeXJoBsSPoS8SKrPighRtk4AL1jogIRmVkoEeN
 eXjCUZUTuu72f6dW6aZ0n4V4/0X7Rp7jot/zV0U/uVryVgy6Z3zxwaGQYaywDUgbfGdd
 0mJ5BgWCahlbSz2huIj6nwPg39SljlzYaFATQQmYX2Pbbn8xzxCbzDU72fS2N2+7hHFQ
 07sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXQVIB0agNH25+747DFZj4b5LcR2ykVk7bku9d/58boBRn4yx/a7KEqhXkRCCnkXshV814B6U0US1k@nongnu.org
X-Gm-Message-State: AFq9FYJkPW9GI40mMIcxxAYFQyUsse6FnQir8p8TVR9ESBm985DcU7ZX
 aV3ohpGzgPdzkIuWCzc8HWgjbWm+voPQzniY8nat88S9gnLc074txAQsH9Izh24VQ+c=
X-Gm-Gg: AYBFou0q+jYC+WJHEYkbA8wJXk1KDC+mq334GETD8oVSxQxyK4Wayxa4X/y4FbFYc5+
 UtXQuHyRi1UADLcW6HnjQRuzsYUj29irVGLRn66eFQXmw70dewvHxaJYEa0qjoZFm9DfssDfaIu
 WwkRfJjJmhMV8AtnU/eBs0qNyI1I0RZWxjACoyuooXLf+Ls4HR/jfo25WKHyN3w6kSsHIjDfRuI
 jpXP10Yy6oqSJlJjZfvhERDG6/bPHuMyZKUkc1GP2YEYSK+HyFjsq25X7+9vNg6Vg7Z+7SfqXr2
 01iuT0WRlJSWw35LEWfru1ei2vtArJu9QJ3QG7qlHmbcp85gXb9pur7wUEcFdQZOhz/+mF8szYo
 wtyUrPRXAUfaPsKMYGJnH6NXeKCYbllALoBxQ2orEb76ZrMC+oslXtfvmtdpUw02jREWFpdGfY1
 28LQyLDTIExOPBZQ9jv+xz37DJZwS5KC5zh4NEiI2tQc0g+g8WAfv8WanKT8GbDd8A84QAeL30R
 cFEnslp3juS9fDJ1z8FLdvLyIU2QbYWBaVras6kGJTl82MfFM5sghrUSGtTIqn4SDMy34vniFdj
 uID70dDaql0b9LAYx8wIisAzNlzY0O2fNYvLwjAlb89c
X-Received: by 2002:a05:6820:1c85:b0:6f5:cd6d:2b12 with SMTP id
 006d021491bc7-713ee85d18emr840928eaf.21.1793175197398; 
 Wed, 28 Oct 2026 01:13:17 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b785d108sm1903574fac.9.2026.10.28.01.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 01:13:16 -0700 (PDT)
Message-ID: <14ba31af-202e-4833-94eb-dea542adc861@linaro.org>
Date: Wed, 28 Oct 2026 03:13:14 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 51/59] system: Remove deprecated 'debug-threads' option for
 -name
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
 <20261027192341.9197-52-philmd@oss.qualcomm.com>
 <0dab848f-426e-49af-a28e-8165591b9d03@linaro.org>
 <e84af371-8fce-466c-9df6-c74863c127a4@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e84af371-8fce-466c-9df6-c74863c127a4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 02:32, Philippe Mathieu-Daudé wrote:
> (Cc'ing migration compat and libvirt teams)
> 
> On 28/10/26 02:01, Richard Henderson wrote:
>> On 10/27/26 14:23, Philippe Mathieu-Daudé wrote:
>>> 'debug-threads' option for -name was deprecated in v11.0
>>> (commit 1b65aeed2a0 "system: unconditionally enable thread
>>> naming") thus can now be removed.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
>>> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>>> Reviewed-by: Ján Tomko<jtomko@redhat.com>
>>> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
>>> Message-Id:<20261018232917.7716-1-philmd@oss.qualcomm.com>
>>> ---
>>>   docs/about/deprecated.rst             |  7 -------
>>>   docs/about/removed-features.rst       |  9 +++++++--
>>>   system/vl.c                           | 11 -----------
>>>   tests/qtest/migration/framework.c     |  4 ++--
>>>   tests/qtest/migration/precopy-tests.c |  2 +-
>>>   qemu-options.hx                       |  7 +++----
>>>   6 files changed, 13 insertions(+), 27 deletions(-)
>>
>> You need to remove this from the testsuite as well:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/17523155796#L58
> 
> Hmm I was surprised because the pipeline in my fork passed, but then
> looking clearer this job is marked as "allow_failure: true" for me,
> why is it blocking on the mainstream repo?

allow_failure is for unstable things, not things that will reliably fail 
until they're addressed.  The macos job is allow_failure; should we 
knowingly allow a commit that leaves that broken?


r~

