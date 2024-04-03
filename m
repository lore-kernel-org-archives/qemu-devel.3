Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8FBCD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrx2V-00013C-W3; Wed, 03 Apr 2024 05:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrx2S-00011q-Lc
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:36:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrx2P-0006Jy-N1
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:36:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-415584360c0so26227985e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712136967; x=1712741767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJKj9pAKPBnuw4iAyWN9H+Fht8YkLvA8jT9WZ2lUXLA=;
 b=teo3Y6GOFVPd2IF5x4ocClwRWgnB1gmR/oFs12zz+SEpq/ShmSYjG/ZXW2LpGzT9ka
 gsIAGXy/9byREXLEbURh4mj57p+g/6EC8EwGmIQR1CIPxQCcghihdSDHN9t3s9PCwiz+
 CpPdCtVJe4uFnNkj6DFcJO6bLEXf8Bme9sspHFKLjNJSuYTh+c+4ZUniK9d8nUpMVZfN
 BbY/qoqdmyu2YaYQqiQM391+/BpgBjGeviaLC72q+q4SmEKejukHeg5e/NkFdb/Mnb9J
 FTjLGCF95zB8fJnE/13EDIj8aQ5cPgzhYHbsUJ+tjNJ/QDSrPEce5G0Jpb5wfOmcx9/D
 oLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712136967; x=1712741767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJKj9pAKPBnuw4iAyWN9H+Fht8YkLvA8jT9WZ2lUXLA=;
 b=rGj02iyhM/DC47lxnVyTqnkE77No67TZ2ijd7wl9xB1c2OfL4lLkDttVwidMmzO0Rt
 lYmFWC/uksVXVKkQgyQ3s7lsQjYH3I1SraxDvkdf1XaJJ5Vf/PX2i5OZvsdmetO1USDi
 0WnL351lQxzipDOandgPY8h7fyhAauL2JQp9mD9Kv5k7ItUUwjZmJOhr4q5SKW9MyAXg
 2B/ztR6Rz4nkB78LqbJLXv0rNZzpOnK1+5NC6TWSevf9m8bM266ZYx7WHB6+XY0as1Fj
 tCSsng5uaRXWt5Bt8GohDWws0sRzmwM2Wiam2lylKwhSFkiOeN+F/Q/c3SVr4yLw6vL5
 yRrA==
X-Gm-Message-State: AOJu0YycByY64SIVdNcF1EdN+WGzvOqOm9dSNC9PfBZ9fMd+vS1k1wy/
 WPbonFZoat7nTCtOtU6BgjLtCRqZ7DMomOLbFMbk/PGlpo6Ievg3DoOC+H5Q9zkmAjg7/F5qUIl
 N
X-Google-Smtp-Source: AGHT+IEbmTKhvKyTcGNnaZ3fg2UKBKvsF4QNOu79seDSSDYNckcIscFPhPRdMIAT0q4fsYk6uy+Nbw==
X-Received: by 2002:a05:600c:3587:b0:414:ae9b:7d71 with SMTP id
 p7-20020a05600c358700b00414ae9b7d71mr11474969wmq.27.1712136967219; 
 Wed, 03 Apr 2024 02:36:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.223.215])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004161b59e230sm5023967wmo.41.2024.04.03.02.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 02:36:06 -0700 (PDT)
Message-ID: <dc1985aa-ecfd-473b-8601-befee9f492c5@linaro.org>
Date: Wed, 3 Apr 2024 11:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/3] target/nios2: Remove the deprecated Nios
 II target
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, Laurent Vivier <laurent@vivier.eu>,
 Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240327144806.11319-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327144806.11319-1-philmd@linaro.org>
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

On 27/3/24 15:48, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Remove user emulation too
> - Remove ALTERA_TIMER
> 
> Philippe Mathieu-Daudé (3):
>    fpu/softfloat: Remove mention of TILE-Gx target
>    target/nios2: Remove the deprecated Nios II target
>    hw/timer: Remove the ALTERA_TIMER model

Patch 1 merged as commit 9988c7b50e, queuing patches
2 and 3 for 9.1, thanks.

