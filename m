Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0010C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZuxD-0004es-OM; Fri, 02 Aug 2024 12:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZuxA-0004aa-PT
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:16:28 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZux8-0003vy-Ri
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:16:28 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef2d582e31so97866761fa.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722615384; x=1723220184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHvtbsP1QBQ8VBwkkDlqlRLce7yHF8Xc9/y40ogOaeY=;
 b=YHbHmgcUGCe5atkcmGsxAVCiAGlffDBWJVMWJY6cuvDvHx2vaD11FHT8a498/f/uGr
 KPRV2tDr6flk/QMqQm+ZEIBIvx+ShYdQlTDJLATe8X/8W5RQ3YqnWOjWg+yl37kJqoPD
 FlGjEE+dAoBiHCh4q0mwfH86AjpcIciFN4JhY1JiJHJQTrGdOjaIeJu5jTReig0w7nbM
 SZWaj44jNToKST8KPIkhmV6jNNDsyoJ//uUGqWjuw/x6VaZNrFFMc+G0SOYeyD0Ylo8H
 qtP3JFV7lKj9l9hZ+8Gotbk4vK6Niql5k3YxXh7236ctjBj3/shENPbwGVaqQnxUZZWF
 aKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722615384; x=1723220184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHvtbsP1QBQ8VBwkkDlqlRLce7yHF8Xc9/y40ogOaeY=;
 b=X88aXGZ5sVk5jxnPpbgO5wMjODVD3nA7AGUw9K4eOY17hQQRoxg+Zcf6WA6O7kVt3r
 xRNRqV61q0y8ytjeVfCbjZGhknVZwApkpI+rk8Jx5ABaVUmUFo5jtN6QBJhh8tgmt/zU
 f0uC1IDBZ/e+jXVLii7yjS8zjCKo9QtvABPKo0UY47GO43D4LASpHDoSE5fTtZc30yU+
 PvxDFu1i8ZfA4t2+xkfs1OZ5XSZGD7a6BOrlI6OXsdIB3W4pdR3boivrkDCe2B3Wr63d
 Tus0nEP1AMcMTHkCmBNSQ7fc98yWL+++0YTeyLiB8UYoT9N8+QCX2E89TVlRYGsuIud4
 u5Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmLH3l2NH1/2E9+E7dw9raiFffBh44Rda7vMmiONhDh9NKgBgDFnsX/P6pSLVhxw3Rvv3G+1t/xIcEmOaJSrjZYrK9sbM=
X-Gm-Message-State: AOJu0YzcW1JelFKCIp35GkqIFFyglya1qVl/XkzmWCDzNCCAW4fX8NOX
 lOyXJC/fobBIMcRH8TFDQ78Nfyb4khIU7ES222Zs3VGZa3X1WpvFP63HGKGQstU=
X-Google-Smtp-Source: AGHT+IHAZKp94kqphrlj6I5JCxnobfkqDYl7K9Hp50tJnzxj9EQVmVzNQzNwYYXAnSmBSPnJPETLVA==
X-Received: by 2002:a2e:9199:0:b0:2ef:1c07:475b with SMTP id
 38308e7fff4ca-2f15aa95c6amr30003491fa.15.1722615384270; 
 Fri, 02 Aug 2024 09:16:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e4073f7bsm60697105e9.18.2024.08.02.09.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:16:23 -0700 (PDT)
Message-ID: <abc56db7-8221-40bc-b3a5-3ca639ba9b31@linaro.org>
Date: Fri, 2 Aug 2024 18:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/24] tests/functional: Convert the microblaze avocado
 tests into standalone tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-16-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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
> The machine_microblaze.py file contained two tests, one for each
> endianess. Since we only support one QEMU target binary per file
> in the new functional test environment, we have to split this file
> up into two files now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  2 +-
>   tests/avocado/machine_microblaze.py           | 61 -------------------
>   tests/functional/meson.build                  |  8 +++
>   .../functional/test_microblaze_s3adsp1800.py  | 39 ++++++++++++
>   .../test_microblazeel_s3adsp1800.py           | 42 +++++++++++++
>   5 files changed, 90 insertions(+), 62 deletions(-)
>   delete mode 100644 tests/avocado/machine_microblaze.py
>   create mode 100755 tests/functional/test_microblaze_s3adsp1800.py
>   create mode 100755 tests/functional/test_microblazeel_s3adsp1800.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


