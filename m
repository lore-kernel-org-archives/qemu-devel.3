Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309F3C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 09:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1set76-0004gg-Sx; Fri, 16 Aug 2024 05:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1set73-0004eJ-1A
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 05:19:13 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1set6w-0003RC-GW
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 05:19:09 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso25085091fa.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723799938; x=1724404738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+6q90f+Bxv9eyWqMeEAynySV6PRqJeAyEpIbAk5224=;
 b=j67Ipw/+CPxJ8FvdhPr8dNm0f9kt72TYfEEtVp3RQYIWUWNjL8YjoKSyWPB4vp/P21
 qf8xvtr8GkAPr7VuAgWCjNk9HVIdkhAFeJ2r3B/Kd6608blZUKl/Qn5IxmeaVaZafTAI
 KsdMXSTPOf8EU/vRvzvX9zcoZs3FbL0m7kG37EvEgibCkluwQ9z20M2PbQQ/phov5Xoi
 MzzGOzdwIZu4YkYuyGlpMfpB6Ln0d443IykR02cjQzcqggNT8EuDjX5N+wSIoPL7u9jD
 hRAixYzWMpbtnvWdUiT7LRNeg4bXCUB/Ne3RUM7eoDx5zrfp414Tjm2JWW++WjJbMB9X
 zDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723799938; x=1724404738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+6q90f+Bxv9eyWqMeEAynySV6PRqJeAyEpIbAk5224=;
 b=retIYOSvCFOPeuUXDN+Slg/MP/efwUElVDJ5nynJ/l5JTMXHnjldZ7QFHn28RXb5dI
 +gLop31+tZ8HAdXvJgO8nh7xsjSM5RELlHQ5LZch4Yq4bzzqwRAMmT4dVjq5ol3jBn5v
 U87M9znxbUZrn7kje7KARwjS1jkTwW3DNt+bJPaoNBGaocpEIT26C/Rm6NSdv1Enb8v0
 f67fYV+PO7/deD0Gc2eNzAoKh3j1OTry4WR1YYYaBtNSbqn/faxSCn7pkQtmZt1JPnXc
 tqfMyJzNj7XkkwuhYrVRIuYTrMjQzOo7YHLFxpjzb1TfcnViYTfngzf5R8OysE5FVRbl
 2ZNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6AM/hSlzFe3YL0zucqhz/zqxSYTuKvylOSLIi78xaQEvaiB06mty8Nyr5A1EPOJ8vgDKxoKYyQjtRQqHJSTfWSfDaivc=
X-Gm-Message-State: AOJu0Yw4wT8JUjuVDmUQU68z7DS8i0hOibdzQSFrXvkpNITk/OjB7qrk
 8BhSj9hEGzdUuCtHyO4piYGYc9g94vvzQSOY8gqTlwgUN2KpU23PZsO+mnF3Qk0=
X-Google-Smtp-Source: AGHT+IH9gpSQ2G8/ktzuWrcYaojw7YuloBrQrznBu/0wsO00hhXzlh+4QjJ20OBp9+LvUl+U1Lz0aA==
X-Received: by 2002:a05:651c:198e:b0:2ef:2525:be90 with SMTP id
 38308e7fff4ca-2f3be5f7818mr18181421fa.31.1723799937707; 
 Fri, 16 Aug 2024 02:18:57 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aabdesm3190305f8f.99.2024.08.16.02.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 02:18:56 -0700 (PDT)
Message-ID: <2455bf3b-aa93-4505-aa5d-eab42d4620e4@linaro.org>
Date: Fri, 16 Aug 2024 11:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/ppc/Kconfig: Add missing SERIAL_ISA dependency to
 POWERNV machine
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jan Kiszka <jan.kiszka@web.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Jia Liu <proljc@gmail.com>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, Subbaraya Sundeep
 <sundeep.lkml@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>
References: <20240814181534.218964-1-shentey@gmail.com>
 <20240814181534.218964-4-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240814181534.218964-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 14/8/24 20:15, Bernhard Beschow wrote:
> The machine calls serial_hds_isa_init() which is provided by serial-isa.c,
> guarded by SERIAL_ISA.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ppc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


