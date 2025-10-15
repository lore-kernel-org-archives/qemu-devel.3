Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5E7CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92OG-0001yA-CB; Wed, 15 Oct 2025 10:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v92O6-0001xU-8j
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:21:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v92Nv-0003D7-NQ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:21:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so53735985e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538098; x=1761142898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1PZLtIJoeD14AAn0MhPZQrGx8WOMeY2wxBqneKwWH9Q=;
 b=FgVPz3/uyUqOsag1L+N8QNx19uz7owLQiTX7mp3JDCCHB7tbMyqs9vIKsp4lNE0uU4
 fs5+sOCcJAeRlGC2yNwDuayZ7V0GdRkTgMgeDucEFp7dxjeueu7gtRgNwlK7i1YiWLWe
 dp3pSVk5TELoF5p4QTJsg360tWMoOfRAICNfhfsKcTrQFVI5s9oNYkbMD90fKZLfu6Gp
 tGdxR5K6rsmrH65zE7PPCRkui90ORW5Rr8ApK7NxOV8dIMOhCUY8cvDtrv0E2QSo4Dvx
 JK9NYgasY7icq1/7EJbVd0LmxXZTeuOjD8WLrZwtRXfzWyf9b9xCUEvWrnMjKmE4DcYH
 vIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538098; x=1761142898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1PZLtIJoeD14AAn0MhPZQrGx8WOMeY2wxBqneKwWH9Q=;
 b=NzRKpgtgSVKLx/ib2oIGyuD+kvjmvzxkyov47SSY784/g9PC6UM4jxSaGccFPwfl07
 oAUYiazZ1MgFK+CwchmPe7on9BHOKSSSpxO9FRFLkEpHpJzIQs4ks3k65pPvbekq3T5j
 VufJYSqFLmE20SqjCtMKnpSXiQtusJfgwdjs910++L8sVBfORwKH91qi/IHMuE0NRkpO
 j83Rq/IZB3b58AWCarr2t/qmOYT54RxIrU+CQZSo6vjW0XOh9hbgyWsu+Ksb8gDJvkdy
 cVQBC+ZWOU7FsO9e33j1Zdhmk0H6dmUBrHx55wxBRItlae6fWWDvmCJwV/+slyslh1ue
 hcfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDOYYef4gU+r15dTNl8ttfcUZIvNK2P3PPxkkSvameLZP2YZhQ+KzVfkk8lmVKSd6sVz7qjAVDnlFi@nongnu.org
X-Gm-Message-State: AOJu0YwtlZWg3pr8FbI9iY+hPcCou8TnGmbG8GiqeFvujruHNyYIZ1QF
 tucAH1mjiN//6SxNqqmFBSwQ/1dUJD3GelX0uPpL7iOZDwzEdY8ZVo6mnxVhsrJievU=
X-Gm-Gg: ASbGnct/tn0DesyrsBTEbCx/yCiL8HhEZi0bYAt8fL7zWNhiTf+Lj+4NzwlMxBdRm5s
 5YF9vJIz3uk0uavwzqBxDb78VMCIxpmYSB4NutssQdgrIIBidrwR7hZlfkXjb+XaBJDW2lln1bV
 pjWV3kXBv5i9Nl84rGBGzTngfYZQ8H+3hg2RKwoj/C0twCxfX2MLy1xDhxy7zltRdyzwO8LnZlE
 GHD9sSEDNcYODzRR/cSMxgeToeuBj33Z1w6kt+U6/zC02jNqRSvQEkiQIcQAIuYeBPTV4nvtlHV
 XfkVTPDzQTL7ngwu042MwYDtVl0Dq3uitPtjIKqprCtUsebFYtaWiprINaUEX1iZ3m5iaeCrcJS
 aUYMC8qHzYYZtow3A+Nd8luEURhHSWeVfI5fkvDXdvRtg4yJylumt4t0uaXFKCdf45ZS7jAzYLN
 BPt9oK4jnVETaBE/01ZrpQ4q0=
X-Google-Smtp-Source: AGHT+IFbkP0/ADjhwk1Bcv71pnSDWQNl0e8hHph0PsM/LLRWD/yYxWDHaJK96t+C3TVKxm1AkKEDXw==
X-Received: by 2002:a05:600c:8719:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-46fa9b06cfbmr230163755e9.31.1760538097763; 
 Wed, 15 Oct 2025 07:21:37 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101be0caasm32393525e9.3.2025.10.15.07.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 07:21:37 -0700 (PDT)
Message-ID: <1f8876eb-9e57-4102-8d04-3de29c4832f9@linaro.org>
Date: Wed, 15 Oct 2025 16:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/riscv: Use generic hwaddr for firmware addressses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-1-8b416eda42cf@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-1-8b416eda42cf@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 15/10/25 15:27, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/boot.h    | 20 ++++++++++----------
>   hw/riscv/boot.c            | 22 +++++++++++-----------
>   hw/riscv/microchip_pfsoc.c |  2 +-
>   hw/riscv/sifive_u.c        |  2 +-
>   hw/riscv/spike.c           |  4 ++--
>   hw/riscv/virt.c            |  2 +-
>   6 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 7d59b2e6c6..d835594baa 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -43,21 +43,21 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
>   char *riscv_plic_hart_config_string(int hart_count);
>   
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
> -target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> -                                          target_ulong firmware_end_addr);
> -target_ulong riscv_find_and_load_firmware(MachineState *machine,
> -                                          const char *default_machine_firmware,
> -                                          hwaddr *firmware_load_addr,
> -                                          symbol_fn_t sym_cb);
> +hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> +                                    hwaddr firmware_end_addr);
> +hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    const char *default_machine_firmware,
> +                                    hwaddr *firmware_load_addr,
> +                                    symbol_fn_t sym_cb);
>   const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>   char *riscv_find_firmware(const char *firmware_filename,
>                             const char *default_machine_firmware);
> -target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr *firmware_load_addr,
> -                                 symbol_fn_t sym_cb);
> +hwaddr riscv_load_firmware(const char *firmware_filename,
> +                           hwaddr *firmware_load_addr,
> +                           symbol_fn_t sym_cb);
>   void riscv_load_kernel(MachineState *machine,
>                          RISCVBootInfo *info,
> -                       target_ulong kernel_start_addr,
> +                       hwaddr kernel_start_addr,

vaddr?

>                          bool load_initrd,
>                          symbol_fn_t sym_cb);

