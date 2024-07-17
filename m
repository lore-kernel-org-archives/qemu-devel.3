Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA1C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU52N-0007vU-1w; Wed, 17 Jul 2024 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU52M-0007tR-FQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:49:42 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU52J-0001Tm-DX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:49:42 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dff1ccdc17bso7004194276.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721224178; x=1721828978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sw7omQ2ctiNpNvargBrwJtkHN7AaLbnQMl4SA52N+40=;
 b=e3/Iy4YZmgDQx9boX66Ojf++9bJcGgvGPVqXoDVUm6xifrldW3tjVR0ZXWWtpfD6T5
 GH/6mvgC42d/HPL0MCY9/cYtmKHpaNEeztB1Vfwnmtkha0ZayagVezFdF6cWoXmV6jfq
 o5U3k1pdcutvtylmRl1XXhtVZyP4BGGUwBV8yckVZs36iyodms+bySOIzhEhNNvJOHY6
 S2jU9U9LCxmXBoByZ1rnD+lUlZoDaZaZGG+g3CeCnXpULRt7JcSipWXXQpKoqTjbHCEq
 H8VhwlbOVzQfrOM/U87fArs5vBkJ7kpMlXHBTh8qA91R6VsrdlvYKzbe2rtVsW5xCBd3
 0hGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721224178; x=1721828978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sw7omQ2ctiNpNvargBrwJtkHN7AaLbnQMl4SA52N+40=;
 b=D+R/tV/zkzxaaLjwgkXvHjmNgnE7vzHerz853i+oETUSNEdLdSq9fvdgA967kMIZXg
 Xyu3xj76nH3UQhYIW4+3niGHCe7En+oG6GIqO2eg+tN4CuDr5066N2Mzyct1DRAxbjaf
 bcFV7WLoAOPAb3TZIehZ/jM4JMRpfhLRKNJun8Efp0n2FLZ6ch1bPtHjs5w1h84zyR3b
 fsDPMlQwz3/biBJjeFTvtrJDJBnSISI3Oollr5Vyf0aSyqMrYJUoOBln9qF31C6sT9Kb
 AT/cYuvb72w+81tcdNpOsLP0DOrO7C1ARUIfdDKUtaosA3WoAoItZZY9u2nl2PpUvsPu
 Yx9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx7ni5JMWuuQQq8Ee31DibppjGMUWjmWfHR3WFwzuuPQH3KjbBGZH7bhkmTF2HTX0xLnemgl1Ybl5pYClveTkZv1hMUu8=
X-Gm-Message-State: AOJu0Yzyikbt2DXd0u3k4YQOBWJJlFRzR3MPlE2ie98ZoDEzYn/R1gg2
 KWh2zjwHeZyFQWzRntQLlcpSxh/xM3VDmf/MnTwudmCq/+HBvq92gczUpc70nMM=
X-Google-Smtp-Source: AGHT+IEjeeDog77rsokL5fFl5LnZJg6IhWcmvhgr0x3IrjhoX3qTwkx43r9axKMA5h1UBy75lE+vPQ==
X-Received: by 2002:a05:6902:120a:b0:e03:6020:4708 with SMTP id
 3f1490d57ef6-e05ed538db4mr1953520276.0.1721224178240; 
 Wed, 17 Jul 2024 06:49:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e05bb2fc696sm1127377276.31.2024.07.17.06.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:49:37 -0700 (PDT)
Message-ID: <e29093fb-d36f-4d77-ba1c-e277f2441d09@linaro.org>
Date: Wed, 17 Jul 2024 15:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/machine_aspeed.py: Add eMMC boot tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240717130657.648701-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717130657.648701-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=philmd@linaro.org; helo=mail-yb1-xb31.google.com
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

On 17/7/24 15:06, Cédric Le Goater wrote:
> The image was built using the process described in commit c8cb19876d3e
> ("hw/sd/sdcard: Support boot area in emmc image") with artefacts from
> the latest successful build of the IBM P10 BMC platform available on:
> 
>    https://jenkins.openbmc.org/job/ci-openbmc/distro=ubuntu,label=docker-builder,target=p10bmc/lastSuccessfulBuild/
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/avocado/machine_aspeed.py | 38 +++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
> index f66ad38d3503..1deb8472818f 100644
> --- a/tests/avocado/machine_aspeed.py
> +++ b/tests/avocado/machine_aspeed.py
> @@ -439,3 +439,41 @@ def test_aarch64_ast2700_evb_sdk_v09_02(self):
>           self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
>           self.ssh_connect('root', '0penBmc', False)
>   
> +class AST2x00MachineMMC(QemuSystemTest):
> +
> +    timeout = 240
> +
> +    def wait_for_console_pattern(self, success_message, vm=None):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message='Kernel panic - not syncing',
> +                                 vm=vm)
> +
> +    def test_arm_aspeed_emmc_boot(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:rainier-bmc

           :avocado: tags=device:emmc

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        """

$ make check-avocado AVOCADO_TAGS=machine:rainier-bmc
Fetching asset from 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_ast2600_debian
Fetching asset from 
tests/avocado/machine_aspeed.py:AST2x00MachineMMC.test_arm_aspeed_emmc_boot
JOB ID     : ed89ecf5e166e7f636cc731c0242ba6e714fea39
JOB LOG    : build/tests/results/job-2024-07-17T14.45-ed89ecf/job.log
  (1/2) 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_ast2600_debian: 
PASS (21.55 s)
  (2/2) 
tests/avocado/machine_aspeed.py:AST2x00MachineMMC.test_arm_aspeed_emmc_boot: 
PASS (43.71 s)
RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | 
CANCEL 0
JOB TIME   : 174.68 s

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


