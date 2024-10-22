Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAA1CDD0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MZv-0000s3-Ji; Tue, 22 Oct 2024 17:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3MZn-0000mU-ED
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:38:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3MZk-0006qk-Mx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:38:02 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so1780855ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729633079; x=1730237879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VUKVknCSlFqFsBqoQ9goFiTR4ArnZOnvNU99XEHFp3w=;
 b=P0QNVUhf0PFCt8jEEek52mSK3dzn4SX2ZhU+SOHBfLeswiL+Ll0zhv6fh0ktYGkRry
 gtGYj0oYkexQxsEpHc/Vh9CufPjsiZfGVIz3FWzbk17jvsf1Rm4pnDQjig+3WQRycBG9
 rLnumcLdhWJcWcVea2pGlFzQV6v9g9ZY3xRVcYkMdACvGrOQnUCXvGtTt1NR/wVNLaE6
 ktA+Rf5J1JmX90REXj8H/FaGHT8sQSCfNTloh5FuMjCH0uNPuGpwfqFR4YucpVrOgXRQ
 yatHi6vFsRg/94NeDAd+uL6HQE9QhGxRrpcmRgsX4hIpOElEFjCg0dZ6qj6C+s12GSFv
 klng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633079; x=1730237879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VUKVknCSlFqFsBqoQ9goFiTR4ArnZOnvNU99XEHFp3w=;
 b=EkSIDdF8TsF9+BOqinXvBBM6u7iZ3YuyY00uU8TFhnG0beTOWNc1a9HhlJK4q2Urw8
 4mIy3LOKOvpdjGylxECwAPWTvL9snd+9/BZ7KioI7a1flKT0FD8dApVtwygOQKH7I6R7
 VyelqpLlMh3MFiR3rK7+UxBngsdrfZLpzE9OM/nGQQbYdKy/xyNIGaCnYEq8D0EwYBLJ
 e8127g8iNX5l9lqO+sOvhyof7WU7OGDyVyT9x1/gQ+mzDYjv4cSzUlO7hr+rF1EYg3Ry
 AG/QT4Q7wWrm46S+R5PnYJG60JqaPEEGbmhSLvLFb5nbCyDBCrRgHwSIs1XEYXlMY6ta
 vIiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVskjiPhgSF0sPTCNtXO0HWLYTD4ZEHSY1Vl9EcQtsr1qlYaV1rxy4Bqa5vIvI5zHFLa3UXRM6RBVS+@nongnu.org
X-Gm-Message-State: AOJu0Yz7Puop2UXzVykEJlWu/4WuhpD1DRhm5TGHFr6XxVhQNRvIdlBN
 tl3qAZ9NayApHTzeNWKZo4/aYGM/Fy1BG94Bi1Vr61+tb4JE43A/29QZNtZ9mPE=
X-Google-Smtp-Source: AGHT+IHlm9BqHLU0sWEdynV1vM6Mhq6aFCZddq4VYJowPs+Wt47y1RjJ8GqOZOi7QgCpTbYANdT30w==
X-Received: by 2002:a17:903:40c8:b0:20c:62af:a0f0 with SMTP id
 d9443c01a7336-20e96ebc90emr70643225ad.7.1729633079139; 
 Tue, 22 Oct 2024 14:37:59 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef152d3sm46951595ad.117.2024.10.22.14.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 14:37:58 -0700 (PDT)
Message-ID: <79577df9-fe51-46e6-9b70-01ae03ef4dae@linaro.org>
Date: Tue, 22 Oct 2024 18:37:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] tests/tcg: enable basic testing for
 aarch64_be-linux-user
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-14-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241022105614.839199-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
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

On 22/10/24 07:56, Alex Bennée wrote:
> We didn't notice breakage of aarch64_be because we don't have any TCG
> tests for it. However while the existing aarch64 compiler can target
> big-endian builds no one packages a BE libc. Instead we bang some
> rocks together to do the most basic of hello world with a nostdlib
> syscall test.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - fix checkpatch complaints
> ---
>   configure                            |  5 ++++
>   tests/tcg/aarch64_be/hello.c         | 35 ++++++++++++++++++++++++++++
>   tests/tcg/Makefile.target            |  7 +++++-
>   tests/tcg/aarch64_be/Makefile.target | 17 ++++++++++++++
>   4 files changed, 63 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64_be/hello.c
>   create mode 100644 tests/tcg/aarch64_be/Makefile.target


> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 2da70b2fcf..9722145b97 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -103,9 +103,14 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
>   # then the target. If there are common tests shared between
>   # sub-targets (e.g. ARM & AArch64) then it is up to
>   # $(TARGET_NAME)/Makefile.target to include the common parent
> -# architecture in its VPATH.
> +# architecture in its VPATH. However some targets are so minimal we
> +# can't even build the multiarch tests.
> +ifneq ($(filter $(TARGET_NAME),aarch64_be),)
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target

ifeq and include once? Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +else
>   -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
>   -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
> +endif


