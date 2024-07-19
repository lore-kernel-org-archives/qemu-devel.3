Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E2AC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUn32-0005NG-K8; Fri, 19 Jul 2024 08:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUn31-0005MH-83
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:49:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUn2z-00044z-OU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:49:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427d2cc1c4eso11660055e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393356; x=1721998156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=12Qp/2ER8EjZr8LOKJi2Vxaijc5jzhaqGy/vUVytwPM=;
 b=vZnfXl7uDbd+7YzDT+jxul/11YHA4V9RpcFRviPwcjlXMGnYjSzl9dXe3nS8Ev3jwv
 +olo7OQAe49nYPXgMxVnuFm3xFk9H1qEMnnXdfaY7U9nBL3WLka08u8/IYuFGdFb/r+E
 j6rnHx4KtUUJIx8WS0Qd+WmubVjqQv6U0EaFLUfeBw3Pg8DZHCbqO7cVyZ//X9jn5Iqk
 1tnZ8ysKn0uQRZaW9veks75Lb+vbd1ke5nqiroOHUPlnXkcKle9ocPCM895aIPbYH0Bi
 q6UCDVyiwm1Vogs+e6kES9SrDzee2x51kwxtFGxPyjHs4CiYOC9XTch242IsrX1wbWVJ
 3cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393356; x=1721998156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=12Qp/2ER8EjZr8LOKJi2Vxaijc5jzhaqGy/vUVytwPM=;
 b=htDm/vIr6jfUPyX+iYI3VSBhZJbSjahP8Qyirae0tF5XuBZjDvlcukyXEANaVUECE1
 AjvY5cw9iTDQq2Af2HJivp2X1gBhxid3Egd0H4KALlqbd8FRj199RTYyco3cbUVoOvnR
 6IvCtoY6Un4KjKDq1r7X5BapIHk3GEnRuspYswqOgiOBso5wBruX/o5+qgvfuU/EnDNw
 sPL5XBTNRt5KuaOklQkBsQCShCtzxWnyfmyCHSDad+VvOVfQdmp/2ro1GOwmA/29RKbg
 /gZMYY9KrcrQFYw5eJ+eyHWYqRzh7+FQqdW6rfb4si/gONghKizgXr83437MWQLpy7C1
 v5Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0pEfbu5c+RQtMd1EBujzl8/hsN5XuAzxH7XP/YhWCbBhXw2Wf6By0kwhIutocFVZ6L3RMBlLtFCuxqOcorOY6ber7I7k=
X-Gm-Message-State: AOJu0Yw+46G40lR6oipjGeiYIuL23soOfye/I2ytOvUcgl1VSFelzpUw
 VRZCzUAm38t8NiynRlV8YbpikbmDxvacja8dVMyAaMErWxR3t7EG1JrqfQ2HgD0=
X-Google-Smtp-Source: AGHT+IFnLoeIyzMoAPcF2B77vJSj5W0M/DgYqezYIzT35AtQ3dOAzQcomY5OfKP/ov81mR4OyCnBMQ==
X-Received: by 2002:a05:600c:45c8:b0:426:6389:94c4 with SMTP id
 5b1f17b1804b1-427c2d0d669mr56330835e9.37.1721393355938; 
 Fri, 19 Jul 2024 05:49:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d693704dsm23542835e9.45.2024.07.19.05.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 05:49:15 -0700 (PDT)
Message-ID: <02b2eb32-abbc-481c-8b5d-e6b835d81005@linaro.org>
Date: Fri, 19 Jul 2024 14:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Move LinuxTest related code into a
 separate file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org
References: <20240719095031.32814-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719095031.32814-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/7/24 11:50, Thomas Huth wrote:
> Only some few tests are using the LinuxTest class. Move the related
> code into a separate file so that this does not pollute the main
> namespace.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/avocado_qemu/__init__.py  | 239 +---------------------
>   tests/avocado/avocado_qemu/linuxtest.py | 253 ++++++++++++++++++++++++
>   tests/avocado/boot_linux.py             |   3 +-
>   tests/avocado/hotplug_blk.py            |   2 +-
>   tests/avocado/hotplug_cpu.py            |   2 +-
>   tests/avocado/intel_iommu.py            |   2 +-
>   tests/avocado/replay_linux.py           |   2 +-
>   tests/avocado/smmu.py                   |   3 +-
>   8 files changed, 262 insertions(+), 244 deletions(-)
>   create mode 100644 tests/avocado/avocado_qemu/linuxtest.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


