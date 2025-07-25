Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D13FC83F27
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 04:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufAGa-0003bL-Cg; Fri, 25 Jul 2025 00:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufAGH-0003Q4-DF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufAGF-0003TQ-ML
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753418541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sj0HMzqkFVF8317cnNxzIFEyp+WFosPbIUhXd2nOJKc=;
 b=cscfiBNLDOyiLD3HOs5WNDKGQZJArb0U2xQjdGxnoJ8ohUbzMJpYBeM1jPyggVqkbJ3A0c
 iREYj7fvMFdOy6J0zMYYAE2RYjBJASI4IOzmbPzEGhhwtz+N61E16BTL80fxVtEUAkFPJu
 doJ8aOouK/AQ+jEuryCNzT76LzZZ/6w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Oqe1Cs58OZCrQAh6mEWf4A-1; Fri, 25 Jul 2025 00:42:17 -0400
X-MC-Unique: Oqe1Cs58OZCrQAh6mEWf4A-1
X-Mimecast-MFC-AGG-ID: Oqe1Cs58OZCrQAh6mEWf4A_1753418537
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so8526575e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 21:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753418536; x=1754023336;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sj0HMzqkFVF8317cnNxzIFEyp+WFosPbIUhXd2nOJKc=;
 b=CeHFxtomZwe8DQQUZSoB2n31TgTKvmKoWQyoEUT5rVMJmREz5jCN8UxPvJxM/oLwI3
 barJK79nX4O+d8KnT8RtRr5xLb/V4xw8QhQR10ZFofRlbyGHcmlWO/hBmQbo8D8dftCf
 ZxgDi3285oUJdMjr6L3L52xMIEk8VEWAGjwOlRh9fnYHhY6OmER+em5d5tjFQpwBF6gO
 wpYlCnjRlybFETnaELoDnkHs+iY651q8/mUqTVF/0ciJ4HUxBd/MFr1kHLtwlDtG3fQN
 /zzEIruB++YnY6Ic9ks7HoiPa8rLFEMadMbVfDMOG54WF8f6PqobBra8fDi1yVDcPIL2
 ntOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuLoFiq4szEfSBhu0o6aOgbvZ6NXBj6jrQy/sTqDNYfAl7L1Mh69f66Szy5YogSe0yq0XQeg4tAMI/@nongnu.org
X-Gm-Message-State: AOJu0YzhQkqP+SHp0Bilwpz1BMTotV9904z9GJU88XTaVCu/al8xBUB1
 DR5M/mZu/Ey5p7gmnMtY7LEaogFzu1vLZwPXH6eoqZwtbQnnHXWjr1fFtC3qdIqKvXPt5qafDNl
 42LuVDgmyxhLurFjE69//XC6P5DGhXmxVTEswghVZTdLdioGxZcu8I4kG
X-Gm-Gg: ASbGncuIoEWDk4lteWj4eiFPJgu+xiUlZbv/rmD1msA6zBxxooCn37xs642b8eRhc8F
 NYxM+IY3W/ZGrWtRL4TeBbfVE4UbUkpl5CtX1wCaAuZPfcCDI0yCQr8juIYnyeHcA1OjGTeIQGw
 6L1EDlOyecy1YtxvyUMN5DaSjC2F/7ra8rmT2n6Im+2oEWEIA55CnYjncnAParupUas7SjFUOHP
 2uPBgM2JcabkG3AvCGY0FFcPxJrEi3467uxAdeMYiqUbWwMdEoR+aXvRbLexeglvnVVtVpWuEpQ
 fVfF5b6JM1QcSMEiHE1elfi1v3VaV1vNmupyTBWxJJuHbvaFpkd4SOkuwjq+C0yC8uxsszkf5z7
 4lNQ=
X-Received: by 2002:a05:600c:6217:b0:456:1b8b:b8ab with SMTP id
 5b1f17b1804b1-45876662f8emr2748025e9.30.1753418536506; 
 Thu, 24 Jul 2025 21:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFppTDsaJ7XI7T+ZRW4wSsXoa53rDN4MK+QPN7u5cKxeYDrH3Jnrn4ZOogcSS5w+ZoKzyTQTQ==
X-Received: by 2002:a05:600c:6217:b0:456:1b8b:b8ab with SMTP id
 5b1f17b1804b1-45876662f8emr2747885e9.30.1753418536124; 
 Thu, 24 Jul 2025 21:42:16 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcad2b4sm3925506f8f.47.2025.07.24.21.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 21:42:15 -0700 (PDT)
Message-ID: <53477554-e665-4402-87b8-4e07cd3f45b9@redhat.com>
Date: Fri, 25 Jul 2025 06:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional: add -k TEST_NAME_PATTERN CLI arg
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
 <20250718-functional_tests_args-v2-3-cde6e08bf98e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250718-functional_tests_args-v2-3-cde6e08bf98e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/07/2025 13.04, Manos Pitsidianakis wrote:
> Add a CLI argument that takes fnmatch(3)-style patterns as value and can
> be specified many times. Only tests that match the pattern will be
> executed. This argument is passed to unittest.main which takes the same
> argument.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   tests/functional/qemu_test/testcase.py | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index bfee6638edf6f9853ead1e3809ae3c9152089406..e137c05baf91f6f88d6228d86d98aa9498797382 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -16,6 +16,7 @@
>   import os
>   from pathlib import Path
>   import pycotap
> +import itertools
>   import shutil
>   from subprocess import run
>   import sys
> @@ -55,6 +56,14 @@ def parse_args(test_name: str) -> argparse.Namespace:
>           action="store_true",
>           help="List all tests that would be executed and exit.",
>       )
> +    parser.add_argument(
> +        "-k",
> +        dest="test_name_patterns",
> +        action="append",
> +        type=str,
> +        help="Only run tests which match the given substring. "
> +        "This argument is passed to unittest.main verbatim.",
> +    )
>       return parser.parse_args()
>   
>   
> @@ -300,8 +309,16 @@ def main():
>   
>           tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                      test_output_log = pycotap.LogMode.LogToError)
> -        res = unittest.main(module = None, testRunner = tr, exit = False,
> -                            argv=["__dummy__", path])
> +        argv = ["__dummy__", path] + (
> +            list(
> +                itertools.chain.from_iterable(
> +                    ["-k", x] for x in args.test_name_patterns
> +                )
> +            )
> +            if args.test_name_patterns
> +            else []
> +        )
> +        res = unittest.main(module=None, testRunner=tr, exit=False, argv=argv)
>           for (test, message) in res.result.errors + res.result.failures:
>   
>               if hasattr(test, "log_filename"):
> 

Good idea!

Acked-by: Thomas Huth <thuth@redhat.com>


