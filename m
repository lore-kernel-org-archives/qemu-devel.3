Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0751EC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 18:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbOnC-0001VR-PO; Tue, 06 Aug 2024 14:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sbOn6-0001T3-85
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:20:13 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sbOn1-0005I7-11
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:20:09 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7ac449a0e6so81187966b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722968404; x=1723573204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UZxCd+zIg8/fTwlkeH78ozUnzNFrJo/odIzAXVX7Upw=;
 b=DGmtXiEcp/gqc4Vmwu8v5h2k4hynxr1AmevtBheJiHhRjVxml51W0mkKnXcqP9l/qD
 KqTsasU2hz5VySg3rFYP6VCD6FDk/6uKmQI8DpX+9ZSHyC07pDFJmkxphuBpNmT1INyA
 uUrHqSt4nZ1aSWOppW580tnDP5M1j4OF7vb8q5dV6JruqZaCvjdEqWlAyVUGRiLxmCx/
 /NcSbNWmEAXh93aoYe9XxNW1d45ww9hUxMHigdiFS/Fj1Kt+LBF4xUetBPRdGxhBUQgN
 z8LpQyr+wJpEb34KOvXdnZhsevDDMHlXtdR1T3DWfBSwE/vB10EVMHexqt2Tvg1byMCS
 q9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722968404; x=1723573204;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZxCd+zIg8/fTwlkeH78ozUnzNFrJo/odIzAXVX7Upw=;
 b=UiAtD5K1vQ+JY4Eoym55uZ79LeEe8QNhsBBQ2TFYmIK4qJLptVfJL4rls56LpH+cKA
 7HxOHi3uYLAAK8Uqkz6ZJK4NoAaz7AjYtj9bqJiqbBfCmqGIzuNbl6A4wHcpNtVo5e8h
 UIObvoLs6Lhdh+KMApgmLzjvVTa+ADJmoOFGpF7VNdaOir+UgC8gCWfIA45GE89/6re0
 uYnwzQcKXJWDTJSc076xVGU2czumiHl8PiiV+MHRkDwPVHYdLTrtlfYHN4gSiUSd+sZN
 imruba0EYLnS33/6M6LwuWWPo1O19LN0sddoTH3w+DkDkOvFIyxQNkeoIK5CiPk+vYEi
 fNJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOJScwsg4GP8+f4C+iHRvPsrzLTfRYMHJjD9gHlav0BvcXSoZZM8rXvJ+CSK5O1uLEZrwLnClva0omcuXXMQesfYQm3j8=
X-Gm-Message-State: AOJu0YwteLEnteH7J7KoeE+9Fl5JoTSJMJ10y4osriNDZANmyt8p/PKu
 hkKOTAith2uYseaMrdC9WHA2iDJBe43MrD523Xo+bHQdMYmDI4elk5x20T11G1s=
X-Google-Smtp-Source: AGHT+IE8dgDyUbnsAjnj8P7IFi+pXso4GIXfTKr8ZQP6PSSV6i5OvK9bz5C2uRKcB1d1teqJ/9q12A==
X-Received: by 2002:a17:907:846:b0:a7d:340e:43a4 with SMTP id
 a640c23a62f3a-a7dc4fae19bmr1087323266b.31.1722968403412; 
 Tue, 06 Aug 2024 11:20:03 -0700 (PDT)
Received: from [192.168.200.25] (83.8.56.232.ipv4.supernova.orange.pl.
 [83.8.56.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d89a9fsm563924066b.156.2024.08.06.11.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 11:20:03 -0700 (PDT)
Message-ID: <540fafc7-9044-4e9a-b2c8-2f2f04412b88@linaro.org>
Date: Tue, 6 Aug 2024 20:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] tests/avocado/tuxrun_baselines.py: use Avocado's
 zstd support
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant
 <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-8-crosa@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240806173119.582857-8-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x630.google.com
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

On 6.08.2024 19:31, Cleber Rosa wrote:
> This makes use of the avocado.utils.archive support for zstd.
> 
> In order to not duplicate code, the skip condition uses a private
> utility from the module which is going to become public in Avocado
> versions 103.1 LTS (and also in versions >= 107.0).
> 
> Reference: https://github.com/avocado-framework/avocado/pull/5996
> Reference: https://github.com/avocado-framework/avocado/pull/5953
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/tuxrun_baselines.py | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
> index 736e4aa289..bd02e88ed6 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -17,6 +17,7 @@
>   from avocado_qemu import QemuSystemTest
>   from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
>   from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import archive
>   from avocado.utils import process
>   from avocado.utils.path import find_command
>   
> @@ -40,17 +41,12 @@ def get_tag(self, tagname, default=None):
>   
>           return default
>   
> +    @skipUnless(archive._probe_zstd_cmd(),
> +                'Could not find "zstd", or it is not able to properly '
> +                'decompress decompress the rootfs')

One "decompress" would be enough.

