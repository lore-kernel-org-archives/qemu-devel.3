Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF2BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 06:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgIiA-0002mZ-Vu; Tue, 20 Aug 2024 02:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgIhu-0002fd-7f
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 02:51:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgIhp-0006fE-CI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 02:51:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fee6435a34so32222355ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724136660; x=1724741460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMWtBHbTEiJhChLHVM90ZBokvVdjr/pZ1q6Im26sCqE=;
 b=r73DhN3SwA+yJ0x/pwsFSCaf/r/CV2yIvUZWbBsFOGpKZQ2lRztkiCMwzeffMT7YQi
 blOunE2OulKCzNwF+PnSPYFtSQ80p5Y6WGRQk3yZWccW2/7EFmTWdBZtDNt18OtDzCTt
 L7pqohnngFUZWs3VtOPz88Zpj8KDv5NpAS8+P/LiquaBh7NzzMiARi9KgsEU9oRskCf4
 GAqtfgB8S3EcNE9IyEJ07wVcTkPwPmDjffwEw1YLdwCL6Zb4IJuJp1J1RSo4oN3giJSB
 PiT/2Gyc89DCIAuoKifFAYTe2n1tydeRh4lwhKz12gBzGeygPVVJI+57j0Cyx48cqmMD
 PkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724136660; x=1724741460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMWtBHbTEiJhChLHVM90ZBokvVdjr/pZ1q6Im26sCqE=;
 b=AFJ4ySrWF3pYxfO1yXj8BeaIFRB9B9TlHRLSlWMw4PH7R7ps2X/JtGxAUa/TtTwRfu
 IOLzxDeqdI+yMF7nfvhLwCTapWTl82JdXHtleEX/Q7i9RTk7ymAfKnQuo3Hn5xp8XyPx
 XgF8Ts5DNCrTNstP71w+m7rQZQeg8MDy0EAJ4+R3QJr5jQcxSNluuY20bZlgWWFEL/8z
 pJpBYFoy29NKfyiwBD+3Nnx9AndO2Vo7yqYO567Axz/KcV9anNpW8a52mKuljmSz2bh1
 sjTSFHP8tFMCxprBh3j157CERW9mxM+coIH7P6Js5b+7DxHApfN+z1InDwn7PalbZVE6
 ilGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeaVNSBhiwbuI826JVeP0BLinDVgLX4+29M1Noy47HwUkb+Fja3YkT3CfxRDievRliMLjpA1QhzcCUwLJYQSltmqh5y6c=
X-Gm-Message-State: AOJu0YyfZaLl8kuJDmJ+ueYPh1mnA8cdo+Y2tVRFzK4ITTLqJ2e8lNcS
 lRWuEVHYl/vsrqwqVgw7/Y1r0bU53phe6LF2cweczjHZXWdIIJDYUmkATAXgnhY=
X-Google-Smtp-Source: AGHT+IFpl8dMaZZNzXzM5Xtm/H938JKAToQuNKSXENsfzs12TC8jFx+ul3P/B7GKczNzi3gpR0YT3Q==
X-Received: by 2002:a17:903:32c8:b0:201:f0c7:6a00 with SMTP id
 d9443c01a7336-20203f4f410mr142456215ad.53.1724136659548; 
 Mon, 19 Aug 2024 23:50:59 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a3f1sm71385675ad.185.2024.08.19.23.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 23:50:59 -0700 (PDT)
Message-ID: <39d31ea6-9cae-43cc-8a34-2785961a3629@linaro.org>
Date: Tue, 20 Aug 2024 16:50:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] Misc fixes for 2024-08-20
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240819225116.17928-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/20/24 08:50, Philippe Mathieu-Daudé wrote:
> The following changes since commit ecdfa31beb1f7616091bedba79dfdf9ee525ed9d:
> 
>    Merge tag 'pull-request-2024-08-16' ofhttps://gitlab.com/thuth/qemu into staging (2024-08-16 18:18:27 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20240820
> 
> for you to fetch changes up to 87e012f29f2e47dcd8c385ff8bb8188f9e06d4ea:
> 
>    crypto/tlscredspsk: Free username on finalize (2024-08-20 00:49:14 +0200)
> 
> Ignored checkpatch warning:
> 
>    WARNING: line over 80 characters
>    #115: FILE: target/mips/tcg/sysemu/tlb_helper.c:713:
>    +    MemOp native_op = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? MO_32 : MO_64;
> 
> ----------------------------------------------------------------
> Various fixes
> 
> - Null pointer dereference in IPI IOCSR (Jiaxun)
> - Correct '-smbios type=4' in man page (Heinrich)
> - Use correct MMU index in MIPS get_pte (Phil)
> - Reset MPQEMU remote message using device_cold_reset (Peter)
> - Update linux-user MIPS CPU list (Phil)
> - Do not let exec_command read console if no pattern to wait for (Nick)
> - Remove shadowed declaration warning (Pierrick)
> - Restrict STQF opcode to SPARC V9 (Richard)
> - Add missing Kconfig dependency for POWERNV ISA serial port (Bernhard)
> - Do not allow vmport device without i8042 PS/2 controller (Kamil)
> - Fix QCryptoTLSCredsPSK leak (Peter)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

