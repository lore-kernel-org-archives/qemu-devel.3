Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D473CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 09:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl3fv-0005X7-KD; Mon, 02 Sep 2024 05:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl3fs-0005VS-U4
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:48:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl3fl-0002sD-Sf
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:48:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42c2e50ec13so17138945e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725270512; x=1725875312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxdKhfzpG/RHhT8Fr353llPj+ZCjCoilFNudgkHUcRA=;
 b=Nov9nWrqy+BSa4G4/hHVvr1RY/QcGTxHkQ2HrtvTsmt0Ln9oz6d64ZUsVJAIdAN84o
 o+Oyr33YqBIE+G3NKrCzQqhQJWGHXxItLpI3g1pu7hiHeI8tD/9ticipWOyykkQjqnfQ
 ouSE3ofIUPcNFkSuY/ypKlwPi9eFo01DlWxl34wOXMgDDRJMre8obL0e12T0jbyuOIKK
 IiicUlW3Cg4PkRxzAe37+h0IpPqJY2jpLhqn6mcMlULzDL4SaTsSN1x+E41S0Fh+J2MS
 qpAuX5mv7zL6sZ9OeTSnrHrSGMHD0iq9LhJIENALVw+y5nMD7XkbIJEpoZjNdtrD6Pxs
 RCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725270512; x=1725875312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxdKhfzpG/RHhT8Fr353llPj+ZCjCoilFNudgkHUcRA=;
 b=JOAFMilfLF1M/GD7bYsmliE+pOUS/Lwvn1InyAzATkBSGweWY/A7/XdkClibJVnMka
 T8mJWUpoOdnViitYnB807+ZIUuOz/LsN2WSfg9oHJxloqUWotC6VmJbSfQJcL+2xko9e
 c/bK7nOWTi65QMQHYffTyD0UjjG0T5+ylMI9AbZ9aUmObifGc1xS38TI3vbP5BMHv3r3
 +CdQeVUeGXNrSAHy1seZoeDGRl2NKzayZ27y6VQwR+pBE42YH76nrEpYAkTDg8mLCfN+
 YnyvvkISIvKYGct9BTOfpPueGriK4c88RwIKXQXXxCjA8XGeRTwJRVx3vzjnkAcpdkFR
 5cFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrG2p1P0OrM212GaOrKjQoiWqb51Xx6Sia5TxBUVl6kg0mI268h/Vy+AYsEcoBta7hSKNKUw1rAYz3@nongnu.org
X-Gm-Message-State: AOJu0Yyq7taLSyaAKXfy6elOTIjRxX5DvFnGpqt/9a+4pWhpldN+CXc7
 22jyxTqCoJq46lMYDigNhN7bfHLbPqhiakyVo5KxlzbMmFdJZhgSfdlB7ozlmZo=
X-Google-Smtp-Source: AGHT+IHzH/DB6JzoGsag6c0WMR91mfRm7T0f1RLb/XzRyDiBPcuLSvnpDBjPU/zEfPiUmoQkh91eJg==
X-Received: by 2002:a05:600c:1f82:b0:426:8884:2c54 with SMTP id
 5b1f17b1804b1-42bbb444d7amr64840065e9.35.1725270511554; 
 Mon, 02 Sep 2024 02:48:31 -0700 (PDT)
Received: from [192.168.89.175] (104.165.185.81.rev.sfr.net. [81.185.165.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e33d83sm131854385e9.44.2024.09.02.02.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 02:48:31 -0700 (PDT)
Message-ID: <a11813f6-6a11-4467-8f4f-1435f5284f28@linaro.org>
Date: Mon, 2 Sep 2024 11:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/44] tests/functional: Convert the vnc test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-33-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830133841.142644-33-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/8/24 15:38, Thomas Huth wrote:
> Nothing thrilling in here, it's just a straight forward conversion.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                     |  1 +
>   tests/{avocado/vnc.py => functional/test_vnc.py} | 12 +++++++-----
>   2 files changed, 8 insertions(+), 5 deletions(-)
>   rename tests/{avocado/vnc.py => functional/test_vnc.py} (97%)
>   mode change 100644 => 100755
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 34a9b277f8..58f6bcf95d 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -107,6 +107,7 @@ tests_x86_64_system_quick = [
>     'pc_cpu_hotplug_props',
>     'virtio_version',
>     'x86_cpu_model_versions',
> +  'vnc',
>   ]
>   
>   tests_x86_64_system_thorough = [
> diff --git a/tests/avocado/vnc.py b/tests/functional/test_vnc.py
> old mode 100644
> new mode 100755
> similarity index 97%
> rename from tests/avocado/vnc.py
> rename to tests/functional/test_vnc.py
> index 862c8996a8..b769d3b268
> --- a/tests/avocado/vnc.py
> +++ b/tests/functional/test_vnc.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Simple functional tests for VNC functionality
>   #
>   # Copyright (c) 2018 Red Hat, Inc.
> @@ -11,7 +13,7 @@
>   import socket
>   from typing import List
>   
> -from avocado_qemu import QemuSystemTest
> +from qemu_test import QemuSystemTest
>   
>   
>   VNC_ADDR = '127.0.0.1'
> @@ -51,10 +53,7 @@ def find_free_ports(count: int) -> List[int]:
>   
>   
>   class Vnc(QemuSystemTest):
> -    """
> -    :avocado: tags=vnc,quick
> -    :avocado: tags=machine:none
> -    """
> +
>       def test_no_vnc(self):
>           self.vm.add_args('-nodefaults', '-S')
>           self.vm.launch()
> @@ -113,3 +112,6 @@ def test_change_listen(self):
>           self.assertFalse(check_connect(a))
>           self.assertTrue(check_connect(b))
>           self.assertTrue(check_connect(c))
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

For a faithful conversion we need to squash:

-- >8 --
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 6b00d240dd..a590646adc 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -26,6 +26,7 @@ tests_generic_system = [
    'empty_cpu_model',
    'info_usernet',
    'version',
+  'vnc',
  ]

  tests_generic_linuxuser = [
@@ -123,7 +124,6 @@ tests_x86_64_system_quick = [
    'pc_cpu_hotplug_props',
    'virtio_version',
    'x86_cpu_model_versions',
-  'vnc',
  ]

---

(each test is <1s so I'd keep it generic).

Regardless the variant kept:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


