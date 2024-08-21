Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0A3C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 09:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sghhN-0005Wc-B1; Wed, 21 Aug 2024 05:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghh7-0005EJ-G8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:32:06 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghh5-0005Vx-O5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:31:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so589947566b.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724232713; x=1724837513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zcbiwu27/1qdjY7vDv6u58Yd8p1CqIBn/WA9mYufB0M=;
 b=wTMfPu8k1emsD20kKvkmWgNQydoz1T5nq0ROTM3FIyC6bAqfI8z661gbkOCpwLwQX2
 2AavaO7HXQfDljgBE5aOOSir9encYgTA13elsSLt+w2430rOwbrPWbiVAtoJLz/IlwhG
 +WvM/gjk6agGvct+uCXTCXFDeI6SOGcQ1nHmkfhHnC3Ks0xcv75JEiKW4jTokKD3oKWv
 tQXZel3RU5M9dNBepD+ohH9XcPlYiBtv7osJ347LTbuDzP2bahQ0s7D3NkxavO5AcpAy
 5admi5mJVq2N56O6hMI1Zpi9gBoUS8fJb/TqWexV+qlTOEbmxb8Bx8FagAh+Eir+W0/y
 4s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724232713; x=1724837513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zcbiwu27/1qdjY7vDv6u58Yd8p1CqIBn/WA9mYufB0M=;
 b=LXjEv3P0WmTEFIxcjpR1n99s4MvkVHlSXx0RDUoVDOjx8S64ehQklrWH/yNSDAOmLi
 3+NyxN0/WERxADf1o6o5KaR04IznGknHMvsg+l7yeEe8/KudckQBiX4XNvUO/oZgODik
 rjH+gmHSCS6xRy7HXZedlnO2ijoBV1w49EC+IMd4WFZbIqyeHysRXSZaNXIkydu223DT
 0otbKwu5d1/Y4vJWDuH+X6+D+cEzGlFfXPmZG0EYZZsYd53nntyoR6et8bWv1UQdIjoM
 IMyl423eW5CnE3HlwdnKOLO1n+R8ngTIFhxhPGfoRKVaqP70YGhnYz5WiBW2COXAZSgj
 OiNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI7+CtllcJlhf9U68ivziAXkj1T/y4VmPjuChJDkqtpIZCnvCc41elWanEaF55uMdWHIu6nrKtV4sO@nongnu.org
X-Gm-Message-State: AOJu0YxHKC3g2BHL85xENsjvZvoCXmhorK6XBIC3L+bupbHVEPAvGVH1
 sMO4bRatHxMP0NbJgCfqCMr0McMLOurZMX+IqgGp3gP6pPHuZSfBF8TLdj0XPXTmK125E06r0+G
 XG04=
X-Google-Smtp-Source: AGHT+IEtH5+SrxTo+oHM7CCROUBhcP7JV46SlqCVO4RV/oU4TXmlwQFTMdCEaOiqkbT/zfdssjSIxw==
X-Received: by 2002:a17:907:2d29:b0:a7a:8876:4427 with SMTP id
 a640c23a62f3a-a866f2b8f5fmr105540366b.25.1724232713066; 
 Wed, 21 Aug 2024 02:31:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839471c0sm875142766b.182.2024.08.21.02.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 02:31:52 -0700 (PDT)
Message-ID: <b5d2ffce-3f78-4e20-98b3-f5017f31e227@linaro.org>
Date: Wed, 21 Aug 2024 11:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/35] tests/avocado/avocado_qemu: Fix the "from"
 statements in linuxtest.py
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-6-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
> Without this change, the new Avocado v103 fails to find the tests
> that are based on the LinuxTest class.

Reorder before previous patch?

> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/avocado_qemu/linuxtest.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/avocado/avocado_qemu/linuxtest.py b/tests/avocado/avocado_qemu/linuxtest.py
> index e1dc838b1c..66fb9f1507 100644
> --- a/tests/avocado/avocado_qemu/linuxtest.py
> +++ b/tests/avocado/avocado_qemu/linuxtest.py
> @@ -13,8 +13,8 @@
>   
>   from avocado.utils import cloudinit, datadrainer, process, vmimage
>   
> -from . import LinuxSSHMixIn
> -from . import QemuSystemTest
> +from avocado_qemu import LinuxSSHMixIn
> +from avocado_qemu import QemuSystemTest
>   
>   if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
>       # The link to the avocado tests dir in the source code directory


