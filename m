Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDADC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PiB-00076I-Sl; Mon, 29 Apr 2024 08:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Pi9-00075a-O6
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:02:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Pi6-0004tk-Ty
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:02:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so30639285e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714392136; x=1714996936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8SaRvyKtjy300TWBNQSammNkKfuq8Y+bP5C2x6p8uzY=;
 b=lvKOUhh7hXK7YFCh2NO+zbpbgyUScMFJRCxrE9Z+TnzO2Z9MlWC91r68/Cs1I5SGbC
 mnPzFs7TfOEOvcWlAa6X/flh/1bHI8Prcn4ySMF7g/DPdWOta/gUgSauLBbZaNbAUMtG
 /116FYaU/Fz6LnDRghrpPGe4lRzXwIgg9Vu6JfjuEvGibQoxDkCnEdGyhVXcvT6HukcB
 poGTrBVeZNtnB/T5RVJks86O6KCzeCa+ZzpAs4qQNzFfqOWr74bsCqHtyMcdp2AmEWa0
 Lz4hvFuaRTm5ln6H23mysxcmG0FkOrfwvEayaHoQVJ/vxQ3z4XznJYWkIfbgJNvKIRhj
 t52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714392136; x=1714996936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SaRvyKtjy300TWBNQSammNkKfuq8Y+bP5C2x6p8uzY=;
 b=exJB+yIu1zgeBFSVht61n/IA5zODDHL0VuKPP+jKNxMDFH0holwrXlFX2SiTjLSbvA
 CVE6HfnpfK9Mqgq0cGF+bthbvGe2TxSAY6oSFbhk0PuGSp2Dsw1eqr3CqKh/sJ9TVYt3
 b0LNa/jQU0GelbF5wxgTP1tMe2CyWj+47OtKp1MzQesEl/IYbJ8bwLs2lKsXSBu6msOt
 +Fa+/rKs/v6QHGoiNYEfQR1NyyINuuRQeweARW5o/xhgquFBQXMztixVh6u6TtMjHqFj
 o5kt9ws6NVb7MZ8haIwJqDeBikRYfexwteR09WaQPjF0GMXekG3Dy85eFLPek1sDLATU
 u8Sg==
X-Gm-Message-State: AOJu0YxfelqIpM4MlX5lut2p43MgfbVIq31lxunpfYq9uE3+IuXXrT7+
 Ab4DItIPQsCxa5Dzmpa0PwvByWiXpvsZU87fi1w9qjOXgepzD/MDur85x/ryo0FCO/J8Imhf/fZ
 GV7A=
X-Google-Smtp-Source: AGHT+IGNGCcJU90ACsLPvJfI8bbmsQGUZkT2bRo3mXIjmmMBcpl1oLZkSTbVXUJvHrs6yr5ng9k08Q==
X-Received: by 2002:a05:600c:1ca2:b0:418:17e9:c23f with SMTP id
 k34-20020a05600c1ca200b0041817e9c23fmr8106826wms.31.1714392136557; 
 Mon, 29 Apr 2024 05:02:16 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c445100b0041c130520fbsm5818822wmn.46.2024.04.29.05.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:02:16 -0700 (PDT)
Message-ID: <0231a2db-8e99-47bb-bc06-586d94242a6d@linaro.org>
Date: Mon, 29 Apr 2024 14:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] exec: Rework around CPUState user fields
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/4/24 23:49, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (12):
>    plugins: Update stale comment
>    plugins/api: Only include 'exec/ram_addr.h' with system emulation
>    exec: Include missing license in 'exec/cpu-common.h'
>    exec/cpu: Indent TARGET_PAGE_foo definitions
>    exec/cpu: Remove obsolete PAGE_RESERVED definition
>    exec/cpu: Remove duplicated PAGE_PASSTHROUGH definition
>    exec/cpu: Extract page-protection definitions to page-protection.h
>    accel/tcg: Use cpu_loop_exit_requested() in cpu_loop_exec_tb()
>    accel/tcg: Restrict cpu_loop_exit_requested() to TCG
>    accel/tcg: Remove pointless initialization of cflags_next_tb
>    accel/tcg: Reset TCG specific fields in tcg_cpu_reset_hold()
>    accel/tcg: Access tcg_cflags with getter / setter

Thanks, series queued.

