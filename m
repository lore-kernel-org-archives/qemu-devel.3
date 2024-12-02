Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED2FD10DDD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2na-0003Pu-OZ; Mon, 02 Dec 2024 04:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2nZ-0003Pk-Ko
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2nX-0003dW-Od
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733131974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AIe4RP5UkBFU4RsofwTi7BsrdY9vZeVw78P8xyUUiOw=;
 b=VXwnbudh8CjLLKa6OrHVkCtkn+S5k4kmI0c44TzJkpFNIIFApaHYUDR/cgJ/JCY3rswt2T
 EyCm+rF4FMXtfvZkTkAlb6wxkNgFQwONTjRGsJn4B3g4JbPv84Q5Vk2OzfIFlE/M4mGKci
 8UMv70Q94oqhLWuT5sS9ndgUYZ0aQKg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-gFySRTCvMhC_q1yvSP5kEg-1; Mon, 02 Dec 2024 04:32:53 -0500
X-MC-Unique: gFySRTCvMhC_q1yvSP5kEg-1
X-Mimecast-MFC-AGG-ID: gFySRTCvMhC_q1yvSP5kEg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434a90febb8so21722335e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733131972; x=1733736772;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AIe4RP5UkBFU4RsofwTi7BsrdY9vZeVw78P8xyUUiOw=;
 b=U0JzkifrgPN+Tm0FIjHvz729Xwl9bqeZfgwi869uMEy0rKZD6+66HhiMmptBUoRYFU
 ccCZCxALHI56Jdceoy8D/dbB47DEvghsPosdtQU3lgsIxov/SHcPHLDAUqrM0nzbGD1C
 jrVr7eShj7iRPR/hwnA1+L6GTV3QOWFMCQ9ERb83q9iFpBs6wATzsPh4awgGa5ZrPbcq
 2DDw+vvix3YpxQt5qw54c/uwf/JwNMJZDJTv+lL+D9zxCtgsGy1DfK38nbztGQusq2dm
 /iIXpvi5v16Q+TyBUuhZdt9UvJQAiMMz90QCcR62XLZvoBoPM2rmj/uhOqG9Vydvja+3
 X1LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULoedsiyNUaIIHiuOh1kPyLbY3nYqsiJEV6DxCeZJLOPpExCmIQ+s6YnWSPhEypERD34eMvUmRcniC@nongnu.org
X-Gm-Message-State: AOJu0YzN+E/iBbXvp5yvFRvohGUxct81uz8R0xcfUp2bQ5eFuR/lyJ4i
 zzMYPfsZEWxK7JxCkWu3FMWUFMppOUgLNLXLkeCih9PoRmEdDcgRGN6G8Cw6GC2DdnZ0SJQ3rZy
 jq9O0VdshTiespdBXKkJ+s4MOQp4WozcWh74saF+m8yriamaBJc9F
X-Gm-Gg: ASbGncv2qVXu3ceX6Pdc5aRmXYdBBgQpW6l6xYP8cPZ82l/HBvOvQIeEt5X64+h+5CK
 4qgBG35558Z7n3IHrTzwOYKZgle8V+gMG+8/nC6RJq+OwN9ly47RKeV/Tn/a3VthQII2rKdR/nk
 67woR8theFTIc4Ys9Sdbfjr/yZ9N+xQ2D8TMYh+EwnCIC1dASrv/IDHHsIVmOZIx2GoQdiZwMrq
 x/hP0pb3/2sKKzpkrSW7Nl2C7A98zCyL9UwkA7UPmq6pmRGksE6GkWl3RBxD8Sm/kw1Wnow8AU=
X-Received: by 2002:a05:600c:1c98:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-434a9df7882mr228194945e9.30.1733131972149; 
 Mon, 02 Dec 2024 01:32:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5aV23EOMZHTHHEokOzRgMT1SxhYJ1Glzt9h1dIhgXW4rsvhNyUS695gT/57WHlHNd0RYCGg==
X-Received: by 2002:a05:600c:1c98:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-434a9df7882mr228194555e9.30.1733131971708; 
 Mon, 02 Dec 2024 01:32:51 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e4fe1sm176296135e9.38.2024.12.02.01.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 01:32:50 -0800 (PST)
Message-ID: <544db3ce-f37b-4c09-85f5-b6ad96708292@redhat.com>
Date: Mon, 2 Dec 2024 10:32:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] tests/functional: switch over to using
 self.data_file(...)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anirban Sinha <anisinha@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-12-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> This removes direct path manipulation to figure out the source dir
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_acpi_bits.py | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
> index 4de5fae37e..948b134b16 100755
> --- a/tests/functional/test_acpi_bits.py
> +++ b/tests/functional/test_acpi_bits.py
> @@ -41,7 +41,6 @@
>   import tempfile
>   import zipfile
>   
> -from pathlib import Path
>   from typing import (
>       List,
>       Optional,
> @@ -122,7 +121,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
>       def __init__(self, *args, **kwargs):
>           super().__init__(*args, **kwargs)
>           self._vm = None
> -        self._baseDir = None
>   
>           self._debugcon_addr = '0x403'
>           self._debugcon_log = 'debugcon-log.txt'
> @@ -137,26 +135,22 @@ def _print_log(self, log):
>       def copy_bits_config(self):
>           """ copies the bios bits config file into bits.
>           """
> -        config_file = 'bits-cfg.txt'
> -        bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
> -                                       'bits-config')
> +        bits_config_file = self.data_file('acpi-bits',
> +                                          'bits-config',
> +                                          'bits-cfg.txt')
>           target_config_dir = os.path.join(self.workdir,
>                                            'bits-%d' %self.BITS_INTERNAL_VER,
>                                            'boot')
> -        self.assertTrue(os.path.exists(bits_config_dir))
> +        self.assertTrue(os.path.exists(bits_config_file))
>           self.assertTrue(os.path.exists(target_config_dir))
> -        self.assertTrue(os.access(os.path.join(bits_config_dir,
> -                                               config_file), os.R_OK))
> -        shutil.copy2(os.path.join(bits_config_dir, config_file),
> -                     target_config_dir)
> +        shutil.copy2(bits_config_file, target_config_dir)
>           self.logger.info('copied config file %s to %s',
> -                         config_file, target_config_dir)
> +                         bits_config_file, target_config_dir)
>   
>       def copy_test_scripts(self):
>           """copies the python test scripts into bits. """
>   
> -        bits_test_dir = os.path.join(self._baseDir, 'acpi-bits',
> -                                     'bits-tests')
> +        bits_test_dir = self.data_file('acpi-bits', 'bits-tests')
>           target_test_dir = os.path.join(self.workdir,
>                                          'bits-%d' %self.BITS_INTERNAL_VER,
>                                          'boot', 'python')
> @@ -259,8 +253,6 @@ def setUp(self): # pylint: disable=arguments-differ
>           super().setUp('qemu-system-')
>           self.logger = self.log
>   
> -        self._baseDir = Path(__file__).parent
> -
>           prebuiltDir = os.path.join(self.workdir, 'prebuilt')
>           if not os.path.isdir(prebuiltDir):
>               os.mkdir(prebuiltDir, mode=0o775)

Reviewed-by: Thomas Huth <thuth@redhat.com>


