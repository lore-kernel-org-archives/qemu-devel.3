Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF5AC021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkzbc-0004La-To; Thu, 20 Feb 2025 01:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkzbZ-0004KE-0U
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 01:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkzbT-0001g4-DN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 01:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740031204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z7g7G/T7OiyHik0XiUgMvfJ3id133puJnhUq4ddF5lc=;
 b=TRHWDNiRP3ubLQpy7U92m78zD1DW/J30+aqmWNOnVanzc5beF4rH6VDWQ61ODGoBQLKWyd
 wlNKJaUEz8SWdBMelGIHUlNfOYLVpOfKhIzREQ/3BS2zryaSfxnarkJoIBcbo/oBvwx2WB
 6s44ZGt7Ed05mktzpHSHXLqqprQ3dTc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Sn_VkAXzM4uiSWMNoIOLUg-1; Thu, 20 Feb 2025 00:59:52 -0500
X-MC-Unique: Sn_VkAXzM4uiSWMNoIOLUg-1
X-Mimecast-MFC-AGG-ID: Sn_VkAXzM4uiSWMNoIOLUg_1740031191
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so2068395e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 21:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740031191; x=1740635991;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z7g7G/T7OiyHik0XiUgMvfJ3id133puJnhUq4ddF5lc=;
 b=MI2u6C/oygo7klhTGSdrnlTvR7pKIst2a7AqV8UaUXeKtyIwaCUYRrQWZLMgKq4DUW
 tyM8mp8ox1mMAn0uTlPkGOOWxvR11iIFHr8L6SYY7j60mFEKn6BzW3ctfITEVGMeTpXS
 afxmsfbw4dkccXk1xXoPWQyZ7sHab6PC2Xqsl0cvKaJ4NWPE6gkUR9aZVOG+QXqQLeJ6
 AfyfPdHiJnfDvFVEb3hUyG6utesvlgsMYC6JVkdtAzkM1nchlRw4chIMhhGZskTKW8Nq
 L81zpAOzSMk0g32y4re1JO91/gwf/VKP4JpIuXIQJPag7BQJzBl0uX4BAx8m4ijH2BbT
 4GuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlpsvdVl3pxEj3jCQ0S+il6lAIu8xguCL5+0bD7YZahVuqJvRanDAtOLw50VaB9xDqKcyioEcq5P9w@nongnu.org
X-Gm-Message-State: AOJu0YwtKon5+lEcpSzRom+2IqmoLkC7A/O+1/Gsdr/E2QNGNXAZwDUk
 C+j5GjHHhFq69fU8vVZL6kaglHjX8w3EZIhlio3aKM02dNenY0y7fEXtmW6FkRq3GeEgFVfu8Mq
 vuVyE/TcxxMEn3xK3xGZeeFpfz+vc2KSltg3HsSfo/r48DiNWCk4v
X-Gm-Gg: ASbGncvjstvWBEtG93hiKFO7yARCEAUCvV4Fs0RElSC02lK5LxXDi3ldFHHNtPaxt5V
 ESJj5Q+4XaL/4qdcvFNApc7NJ9jT/2Ap2hJkxyOWUW0toYSZdZlu+exu3vWyVRigX+msy2wJXiW
 1ol0foHdQsXB9JyKfZlgl2YYIwDPeVGjMWrkA9Us9mnECvI+n1M1BiDcH64KhKpuSdUpOM+/kGr
 DmmouYrFr1aJ71ROno52+cKE6uVgc3UgJzo1naOdj/ki7fSyJZo239C0IAtUBK5axq+zEO1JqXC
 0utNkDaIoymfoLsdQfyAx5VDifLgWqlAP9TC
X-Received: by 2002:a05:600c:5487:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-439a4bae627mr5434635e9.24.1740031191267; 
 Wed, 19 Feb 2025 21:59:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYyAbzbRVWIlUKvh2RZ9Dhd6TRsozmBfK0yPyHhzZfU4Rdy7IV1tEAuC2qViyUkmeQya3JuA==
X-Received: by 2002:a05:600c:5487:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-439a4bae627mr5434525e9.24.1740031190882; 
 Wed, 19 Feb 2025 21:59:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b410dsm19614475f8f.5.2025.02.19.21.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 21:59:50 -0800 (PST)
Message-ID: <bd763f71-ee8c-466c-950b-248c7dd92e00@redhat.com>
Date: Thu, 20 Feb 2025 06:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Introduce the dso_suffix() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20250219192340.92240-1-philmd@linaro.org>
 <20250219192340.92240-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250219192340.92240-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 19/02/2025 20.23, Philippe Mathieu-Daudé wrote:
> Introduce a helper to get the default shared library
> suffix used on the host.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py | 2 +-
>   tests/functional/qemu_test/cmd.py      | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 5c972843a6d..e253288ee7f 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -8,7 +8,7 @@
>   
>   from .asset import Asset
>   from .config import BUILD_DIR
> -from .cmd import is_readable_executable_file, \
> +from .cmd import is_readable_executable_file, dso_suffix, \
>       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
>       exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
>   from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77d..c4704dfb7bc 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py

Maybe config.py would be a better place?

  Thomas


> @@ -14,6 +14,12 @@
>   import logging
>   import os
>   import os.path
> +import platform
> +
> +def dso_suffix():
> +    '''Return the dynamic libraries suffix for the current platform'''
> +    DSO_SUFFIXES = { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dll' }
> +    return DSO_SUFFIXES[platform.system()]
>   
>   
>   def which(tool):


