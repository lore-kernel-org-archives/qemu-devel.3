Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CB7CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smn5v-0002bD-RM; Sat, 07 Sep 2024 00:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smn5o-0002Zu-Gq
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:30:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smn5l-0003Mr-KL
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:30:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so3108378a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725683431; x=1726288231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H8urHTUDPxg2O+w/UGEXJLBeOIkK22ZkTRM4FrHyVIk=;
 b=jWmmDV5iSA5VT1rqlFYWobHcTSg+iG0BE8DA3laGpBM8Jsi35aEkKVnyvTzwiM17my
 dAXjuQ5hcRCcAAsf5iecr4+n1MwJhAE19wOeP21wMVHWIDUYUZvKKIFeeu+e3Zwdn0ao
 4Q4Iq8ol6vdiL5JfaRbssYULXyt5ODb+caub/3w9i59oYMJpx5LXW2lJ+/SbLcLVZj9U
 2FKiNp624t6bVdY8rh4WMXIOzZh2PIhxhZibXTCGjT3ZRGli+uQ1PsKTGXGSrwtzLxss
 TX+p0cyoGa56E2JOP7VXFDWJeJXOtYSHo8rm0gMC/5CylSNHxSx32rzFgqx6VDM38vRD
 r5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725683431; x=1726288231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8urHTUDPxg2O+w/UGEXJLBeOIkK22ZkTRM4FrHyVIk=;
 b=IsdZEA6ekIfJUAkt14eCN7bhCnhqxf4Gy/dVwCUphknpXOv7WDWBUNUAdObd+Mzl5y
 T3gBtKPrUWVu7xYS4nQbHoPmpmWHwoavOX4nVXTg+VH43V7EQe9j1EHhE/tf9ZHi4+1v
 tvVmDfqQQqB7Qv4Z7bpstJTezqSczceQgyyXgwdi6f9adMB1EQZzK+rWkLGTNkI5XiBL
 qc/cXua1uor7TGiREOLpfL22Hm/qQBd4PDyIfzbOr5bGVjtDJfJ/LddDAONcjKHzWgti
 1aYsL4K68oRN8pTZDGsgDUsav+CBlLfOX/49oe+R4lVoNtc3RDYkhX+hWuwoa4sJClq4
 zoUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvSzB9jH2Vw2LcL8OXovyMaowQlYKmUmiPXN6uIyDPKt23EFwTCjIvpTm4QhVlLYfb3CRyRdY9ri4n@nongnu.org
X-Gm-Message-State: AOJu0YzteYFz+vQnX6A0vEga0jcbYhQRN0qcTTo0xtJLs0sCHBEbpXo2
 vzbG/DNwpNfVtx+1ObQ/7Kbb2U4AJrkcfrPur3mYWkApErFkPVojMFJPiZwLi6Q=
X-Google-Smtp-Source: AGHT+IFMmy/LB9S5B9ZlfwnZrPwp1ww9Y6I++N10tphcOJ5qHcfUvMrrnAPSOaT+9wvSGGxX2p7Quw==
X-Received: by 2002:a05:6402:35c1:b0:5c2:4ad9:6d9f with SMTP id
 4fb4d7f45d1cf-5c3e953355dmr1255013a12.1.1725683431038; 
 Fri, 06 Sep 2024 21:30:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd467a7sm216947a12.28.2024.09.06.21.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:30:30 -0700 (PDT)
Message-ID: <b78183d3-108e-4db7-8738-e952c50b3d80@linaro.org>
Date: Sat, 7 Sep 2024 06:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] tests/functional: Convert the Alpha Clipper Avocado
 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
 <20240906180549.792832-13-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906180549.792832-13-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 20:05, Thomas Huth wrote:
> Straight forward conversion, just switch to SHA256 hashsum now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py    | 21 --------------
>   tests/functional/meson.build           |  4 +++
>   tests/functional/test_alpha_clipper.py | 38 ++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 21 deletions(-)
>   create mode 100755 tests/functional/test_alpha_clipper.py

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


