Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE2C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 06:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8E0y-00062d-3D; Sat, 18 May 2024 02:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s8E0v-00062L-L6
 for qemu-devel@nongnu.org; Sat, 18 May 2024 02:57:53 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s8E0g-0001uP-Dc
 for qemu-devel@nongnu.org; Sat, 18 May 2024 02:57:53 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-24544cb03abso446422fac.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716015456; x=1716620256;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y2qKxTfm34cqcZTDxP9E6kX4uYk5pkYFhnki3f7UR2s=;
 b=JYIlkZQg98ABDfQr/dCv73eqOZY/fiDy2VfJy9pHKCc4UZ61MGuw8Tl/7cflucZ1Rq
 Kj73frNkBJkOFj9WoyliMF9IPrOJCp8SzI1nvjgPHSRL49e4hmYIyTu5Z5aKC0JDHt5X
 zkP1DS0eyrQeHskPF//Ep597mp/WhQbZ0V1kgnZQOpo0Iko2+hCTPeAEwSrXoyUXyDlC
 Tsm0/34OciFJugAFxtKu6TjUKqhUaAHp3SUBvUWgMo0T9aai6FMv0oePeY37YhUpVoaz
 1XXwA3ncPxJBXmPVv2yyv6BBRTKkhf5AtS+m1yy6SLj5KZwVq+0VYaqoNmco53bNjyFD
 JnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716015456; x=1716620256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2qKxTfm34cqcZTDxP9E6kX4uYk5pkYFhnki3f7UR2s=;
 b=lZRNEvyezuzEHCPl92K1aIHvp/E/YNpp7lwP9TMcRm0vUyvU0xIlcRCJXDE7XTbRDR
 1kbTMUXuyL8ST50jZLTe0VwNtsvOqnuCKkusnz6SKTYmik+0ZIUxTpKvxjIQe3TpNANh
 yktoyrObu6oCvqAj74LIZo8z3MYnjcGTAAPE+KE+daE6ssNliOaaTp5T5kDVtkP8NBXw
 nfd76mZ8ykxiwbt9WFZmgVrWjfnVoSOTwDJ2ID/Tp3Q+LuwqNpq6HZqQoqibxLVn/ZYW
 ZgrFGSY4gYujiYIM+Cgo1TIq13VZWjRZ21DEAM7rqRLsVsUV1STCMCd0nnPP7noZLYKe
 KpiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoZyQJSSSvdlGRplU0yKAIx8FeD0RXXCH99SvCeZ5qxTCan51MLRhl1dq8k7iBFIUqzuZ7SXQIGZRXO84ct7E4GC3xGZo=
X-Gm-Message-State: AOJu0Yy8oRArRdoA9Ysvb+LGDJZLV+R3QAv0F867ADuTfcIo2bFl2FaJ
 egdrg7QjRvplDyObnTJh3mUqy0tEN2DrJC2ANJpUpBnpLGFW7SdCt6olqaUjxzM=
X-Google-Smtp-Source: AGHT+IHYf935xXdmvGlqoWSPyE409N7Wvm3VbC9rwIE7LgT/REej/WYs5sa7Msn4qQCaqV7rFvPbtQ==
X-Received: by 2002:a05:6871:7987:b0:22e:7460:d2a8 with SMTP id
 586e51a60fabf-24172be019emr25437190fac.42.1716015456456; 
 Fri, 17 May 2024 23:57:36 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a85f3fsm15708052b3a.82.2024.05.17.23.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 May 2024 23:57:36 -0700 (PDT)
Message-ID: <6ac60e11-2d46-4f82-be3e-ef9ae741ede8@daynix.com>
Date: Sat, 18 May 2024 15:57:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] riscv, gdbstub.c: fix reg_width in
 ricsv_gen_dynamic_vector_feature()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 alex.bennee@linaro.org, Robin Dapp <rdapp.gcc@gmail.com>
References: <20240517203054.880861-1-dbarboza@ventanamicro.com>
 <20240517203054.880861-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240517203054.880861-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/05/18 5:30, Daniel Henrique Barboza wrote:
> Commit 33a24910ae changed 'reg_width' to use 'vlenb', i.e. vector length
> in bytes, when in this context we want 'reg_width' as the length in
> bits.
> 
> Fix 'reg_width' back to the value in bits like 7cb59921c05a
> ("target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'") set
> beforehand.
> 
> While we're at it, rename 'reg_width' to 'bitsize' to provide a bit more
> clarity about what the variable represents. 'bitsize' is also used in
> riscv_gen_dynamic_csr_feature() with the same purpose, i.e. as an input to
> gdb_feature_builder_append_reg().
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Robin Dapp <rdapp.gcc@gmail.com>
> Fixes: 33a24910ae ("target/riscv: Use GDBFeature for dynamic XML")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

