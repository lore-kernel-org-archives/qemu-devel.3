Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4C9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA1sl-0007I8-6w; Wed, 30 Apr 2025 03:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA1sj-0007Gm-Mr
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:29:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA1sh-0004WP-SK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:29:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so46349505e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745998162; x=1746602962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fZws1LcBnGTsaUF+ayNr8WPjOqHWvF/wAMYLVSfhT6A=;
 b=SMggdeqs4FpQeAdjti90uGrbckEPrDAZAau4mFiol39abnD7BffD0KCwo8EFZPscMg
 Fho9l/H3OmXArZoAOESEwwPCImZI6wav2afV1mIvLbSTxhr606lYX+QYEOIfNYyPkzpP
 bkdT5R7Q+BTE1p2ymG4ViOfUk9giKyeQB2TOsQL+Es0BhE5W8Mm8Xa55DILfe+0ysqaX
 H+/baOzO/jNLlO3JtvU5t+W9zVIEeETvoZB1EQtCwW3PRTS5GDPcaFw3pu3VPo/ej8YM
 pZyxzcPHbvgWHe+CY9wd33dv75oBIVMMf7SDhqYs+apAORUxJJa1u11powY+aA87fd+R
 RsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745998162; x=1746602962;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZws1LcBnGTsaUF+ayNr8WPjOqHWvF/wAMYLVSfhT6A=;
 b=Q8lSJJu47rwKbSaRWPWgBO+tHtWO3a+1XDrohk9Ei898Tu4dPc2TVbE78caGKo+iW5
 91Fgv+yDh2lQWJ70zRA40iG9q2xBRYG02wKQcglEwQ0BL0Mh3hfIyCro57CeTFhwHbif
 eWpOzPUWIDOR9PnxIl8NfayoYlE6M5+4CKJuUI/mXNFoQuEHMXJah4So3ALOdo98XEdL
 3/atZ9bc5P9K8XqJp1H3NZBV4b29nYKhjJ1f+JemHPqtMjsIcCxFd5fQTQt4OvTyrDJD
 6XE/YWxltLUgxlwgDPx/FU6/T8EqONB/X4pL74eDhTEz4L3Xds4H9GRvHicTdl8yoOkl
 8GZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscVXdm74Lksi2G1r45EqRG14ylYa2RsC9rM70uXcJwoNyhdQJyDP0cw0X6InTvtMBCwJKgduLmtnQ@nongnu.org
X-Gm-Message-State: AOJu0YzGnRt6YeFLUejb0B0ygxmY2cbRFSrH/ABIssDEHTjAKWazqopK
 4ibAO2MMWAqbEbx4pzXXuCQ3o2Q1yfDqWvpa22VS0bgQbW7NWf45zScrfdB7rlQ=
X-Gm-Gg: ASbGncuCyD2IVG9fq+DZj4dkc7P97lA39hOJ6/XJFUJCHZFP5IDBgrShA+gdyZ39sOF
 71RSGMmJeBg8/ydDEk25IkDrDg0KTTJcpqiGp7IJoQavtI4J7EK4OYq1K1AUK7gRVTbYBQUKrvi
 yw59/Uby9C7LTugWNCFi0tyQlE3KcXzIcqO010ZAwlc6+XFI8qa0GM826OHwH23WGQja9Tw4sUX
 rXUKVVrM8y/IOmdQGUtumLhdxyvJUDGaklH2J+bbUsjd4fV+jeAYzgWeSGZGlZwrqFpxhLexq+g
 lARuv909JaAzunWaCJxUt4ROZ5NrGMcXi+qfPIBz9UeddJnJpFS6+GM3MsvbYnOXH687q0Gnw45
 UlxdXepJFtXRdtO8kriZKAVs5
X-Google-Smtp-Source: AGHT+IFP3AmnHE0cFwury1aqGzRMHFomYgVbqLJOSwTN8jscHaW/kAf1ZDOvj6tmeoIBd3ZSD7bNoA==
X-Received: by 2002:a05:600c:4e8e:b0:43d:fa59:cc8f with SMTP id
 5b1f17b1804b1-441b1f61e4bmr12280205e9.33.1745998161820; 
 Wed, 30 Apr 2025 00:29:21 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbec5csm15673355f8f.43.2025.04.30.00.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 00:29:21 -0700 (PDT)
Message-ID: <bbc031c4-c025-460c-b185-5858f5b0d729@linaro.org>
Date: Wed, 30 Apr 2025 09:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Luc Michel <luc.michel@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
 <d57e4f5c-a677-4cba-bbe6-85b997a3b57a@linaro.org>
Content-Language: en-US
In-Reply-To: <d57e4f5c-a677-4cba-bbe6-85b997a3b57a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 30/4/25 08:26, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 13/2/25 13:37, Philippe Mathieu-Daudé wrote:
>> +AMD folks
>>
>> On 12/2/25 23:01, Richard Henderson wrote:
>>> Use out-of-line helpers to implement extended address memory ops.
>>> With this, we can reduce TARGET_LONG_BITS to the more natural 32
>>> for this 32-bit cpu.
>>
>> I thought about something similar 2 months ago, but then realized
>> MicroBlaze cores can be synthetized in 64-bit, and IIRC there is
>> not much missing (I'd say effort would be to add 20% more of what
>> we currently have). Just wanted to mention before taking the
>> decision to restrict to 32-bit. OTOH if there are no plan for
>> adding 64-bit support at AMD, then I'm more than happy to simplify
>> by considering only 32-bit.
> 
> I gave this series another go, and figured the microblaze target
> addition was done way before the 64-bit. C_DATA_SIZE value was fixed
> as 32, and C_ADDR_SIZE was not mentioned. Later C_DATA_SIZE became
> configurable as [32, 64] and C_ADDR_SIZE appeared.

FTR C_ADDR_SIZE starts to be mentioned in Vivado 2016.1 release as

   • Included description of address extension, new in version 9.6.

Commit 72e387548534 (Jun 18 2015) made explicit supported versions
were 5.00.a up to 9.3 (per Vivado 2014.1 release).

Commit d79fcbc298b0 (Jan 11 2017) "Add CPU versions 9.4, 9.5 and 9.6",
and commit feac83af3be6 (Jun 15 2017) "Add CPU version 10.0" (released
in Vivado 2016.3, but MMU Physical Address Extension 'PAE' came in
Vivado 2017.1).

Vivado 2018.3 added MicroBlaze 64-bit implementation "new in version 11.0".

IIUC current implementation is correct w.r.t. v9.5.

I'm not so sure we can announce v9.6 and v10.0 as correctly implemented.

Looking at what our machines uses, latest is v8.40.b:

hw/microblaze/petalogix_ml605_mmu.c:88: 
object_property_set_str(OBJECT(cpu), "version", "8.10.a", &error_abort);
hw/microblaze/petalogix_s3adsp1800_mmu.c:78: 
object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
hw/microblaze/xlnx-zynqmp-pmu.c:95: 
object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",

Maybe we can deprecate / remove v9.6 & v10.0 to better add them with
a proper microblaze64 target implementation?

> Indeed what this series does is correctly implement the current
> target as C_DATA_SIZE=32 (C_ADDR_SIZE=32 implied).
> 
> I had a quick look at what is missing for C_DATA_SIZE > 32 and it
> is more than the 20% I first roughly estimated. So with the current
> implementation, this series is doing the right thing IMHO.
> 
> Regards,
> 
> Phil.


