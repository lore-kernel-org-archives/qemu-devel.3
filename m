Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEADC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRWy-0005nc-Jv; Mon, 29 Jul 2024 10:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYRWw-0005mI-5k
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:39:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYRWu-0007bH-6h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:39:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so10800155e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722263954; x=1722868754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qEnyOvA1X8TKi0lsodpQGCil95YO2hb3XDAGCjbudWY=;
 b=iXonCNgmBPImVG0FiVp0sSdjg+njcJ75tCZfdqt2S24a79C8Gl55o/F4us3QSPEnHO
 h8V1gvj0syTvzBWPMojzVxaHTGQ6dryU8VmX/1f0OlhmsT0jv+pdrBmKWuRTipvvX6gj
 hcrASS7RX6IPkcjB3yJ0DIMpqeYcywTGY0tYCe3TaG3b0hpj9DgGdTQASV3QU4T69KFz
 HMFBlSR70H1kHKu+SHAYdXIyuuaSJDeU8+3MdWB7y/g7ypiVrsLMrAHUJNR9ySyehCec
 AcVnfGfrQ/OQ/5UPNdk0pFi/FV4eeZwig3/VaGDACEmKoQoq7onH+60RXGWv8qKJnTmM
 9nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722263954; x=1722868754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qEnyOvA1X8TKi0lsodpQGCil95YO2hb3XDAGCjbudWY=;
 b=YBv5jC6TQfXlRC0xTvW0RRscX3KVQhWtG7qeaM/NcUEOZv6+uHBDc93Z7b59OY9X8p
 jlRTr93bx/ygjIwX20C2smjQVxKkwn8cnkuoVXrI0tXZnVRzlg2Le3yo1gIn/QQp8CqH
 IfVx8sXYw1YhxRyDS36libmizKeVShMsF/QJFQLqm3omP3Yx7okGeKnTJ0iPoLuD8n0m
 hPmYdKSYwVpwRPrW7VtZnAS9XE/UTrnc2x0rM+gdx0UCbif/szTV6GMsQ8PSkgjn0jQF
 NJxPaNd1WarGeoZOguBWIRdvg5zZJMlgcz4iMqkJAPxqwU1oxiGi1dicjqcplvTCqiLk
 6kvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXIyib5JhSiK9lP22P1J+kWHAuHCROO/10lW9O18mlaTkzQlornl16xig8WNEwfUv8onwoIJDkeKU3wJ7679NN2/vPn5k=
X-Gm-Message-State: AOJu0YwfDtNuLEuXIMqDlUsqkK9vGuMmk4DUESX9irKPKb30SxV93bpx
 CaDDBqxUoVjVHe1VpuvAz5+wr7NetNZbTwAu/fIDftgTi5OK3azpYozKnRHer14=
X-Google-Smtp-Source: AGHT+IGhrXmQOvCwdmc/mrVWsNfUM8NWLaSEVksL1o/NLVYFClufq9VU4ziPQrR4Ung5I6UYQQ0o4Q==
X-Received: by 2002:a5d:55d1:0:b0:363:ac4d:c44f with SMTP id
 ffacd0b85a97d-36b5d7cf02bmr4471297f8f.17.1722263954418; 
 Mon, 29 Jul 2024 07:39:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857eb7sm12396324f8f.66.2024.07.29.07.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:39:13 -0700 (PDT)
Message-ID: <a7f2d78a-4de6-4bc6-9d54-ee646a9001fe@linaro.org>
Date: Mon, 29 Jul 2024 16:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] tests/avocado/tuxrun_baselines.py: use Avocado's
 zstd support
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-11-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240726134438.14720-11-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 26/7/24 15:44, Cleber Rosa wrote:
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

_probe_zstd_cmd() isn't public AFAICT, but more importantly
this doesn't work because this method has been added in v101.0.

> +                'Could not find "zstd", or it is not able to properly '
> +                'decompress decompress the rootfs')
>       def setUp(self):
>           super().setUp()
>   
> -        # We need zstd for all the tuxrun tests
> -        # See https://github.com/avocado-framework/avocado/issues/5609
> -        zstd = find_command('zstd', False)
> -        if zstd is False:
> -            self.cancel('Could not find "zstd", which is required to '
> -                        'decompress rootfs')
> -        self.zstd = zstd
> -
>           # Process the TuxRun specific tags, most machines work with
>           # reasonable defaults but we sometimes need to tweak the
>           # config. To avoid open coding everything we store all these
> @@ -99,8 +95,8 @@ def fetch_tuxrun_assets(self, csums=None, dt=None):
>                                            asset_hash = isum,
>                                            algorithm = "sha256")
>   
> -        cmd = f"{self.zstd} -d {disk_image_zst} -o {self.workdir}/rootfs.ext4"
> -        process.run(cmd)
> +        archive.extract(disk_image_zst, os.path.join(self.workdir,
> +                                                     "rootfs.ext4"))
>   
>           if dt:
>               dsum = csums.get(dt, None)


