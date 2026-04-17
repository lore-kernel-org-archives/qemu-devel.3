Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05727F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZuI-0003Hw-Ed; Thu, 16 Apr 2026 23:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDZuG-0003GV-TZ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:30:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDZuC-00067Z-Oc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:30:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfd96354aso83425f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776396601; x=1777001401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHHN4R44lbj4G+eGpVZxZz3ewlVyDXQs1uR0v0FYY9g=;
 b=ZbsZVYML+mBGMJ4ncMh55jtIFMcumoPxYokPSJ099ZqlSQAzhnQWVtuLlyXZuU1NeD
 X6dseti8Dr/oQS/05SRxIFekBY8G8SXuiFxfJM3TrzCaXdkoZVfwpebxGhTEr4TD0e5R
 HFHYzzV1VsRJdjWNr3l5gPsqd/1r5NacX/lW1rjxX+iyT3YaLl87fgqy2G9RVvrYz/dn
 cdDy8NoFZ9rK/R5WC/geK2Yooh5/EQOZf206ClYp/qR7RwcrYpXIbb4+d1qngj5UmhSJ
 cvcC6cMEvpsGnlyITIHJTLELjx4prDeEqG4LsCrme4RJSbPGND2H8/bbgoznPT03EW2b
 1/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776396601; x=1777001401;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHHN4R44lbj4G+eGpVZxZz3ewlVyDXQs1uR0v0FYY9g=;
 b=fV4gsybvQa1VLjhIOVCxLYNr5kjZmrM7rNqACiP6/zeW2HwodZdJzLPeaqAVfp96OO
 Ur+i5AbiAuey+x+LjAuhxU01wrvdQj1jNSFgU9/TZddRu+uU5PeQyZALk6qUFkGWqvAt
 X65pxLEZkTnV3wtx2g/eomoiXoW/VmUiCBeuoMqE1TT0SnOvwmdgoaVmfjPFUxyhfUue
 XvPFkz5iAqnp4Nh98PyctZBCYqlYVu/Bxpq6431MkSwABmFifxmc7i5VL6dIw55G4/zR
 3Uls4RCmAViC3WgJyLV03AQSdWWLYY2a2/ArMa3G8CxZDr+uTa/XueOjAim5H10kTtbg
 Rv1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IHJJ+1Di8x1zZqjDRXNDV0e/cFVtaSWPC6I+X0hq8NmNH6OUSFjlEpJBS2W2IlWVJZXVaPXg/ii5M@nongnu.org
X-Gm-Message-State: AOJu0YzvygZans0GLkOPIQGw2gPetBfrhy8hCgrddv44Tmm+2RI6RKwv
 ppPwWmpATAl7ibsOZsfm53PYIpvE+QNiDiBl+zUG/O4iZ4nW2cXuK6/JVL67xox8ftk=
X-Gm-Gg: AeBDieuSsvThn5gdyxX+7tcFaKj69kprht+eggNvEkIjG5+3AAvcIcnYUreK587PSsO
 YjAjhTBviOA0S5rCZfhmq3kIJ4SOHNAftnnkVI99pwi5ni+hVAPHwTskHJrEQHxN9+lthqU1dBB
 LCknNliL8fafbtGLxF6WWsA3QT1WCdhPiqRyvSbrMi2JseyiTqvI8gy/tJELZichD1XAU4atEMa
 0av0lU8TZ1vIKbhlpccSbAVscL89um3iha/ANeWh55ooNoNxTwBAXfIrh17NanpnZq9gaJ4Ea71
 WKn+uNwPfcqTVoeXYxTMJwY0REaZDWl/SzAdc9NDJRXRJrbtVdJvPZdRlsXQp/4aaC9sfcHOsx7
 3vIELP9v5QFPcxA3lwAFHq0/LGDFbG6yyGm5qqey1XFEqMmtQBf1t+tl7YbWayoRtTMW4bPuvfY
 zJXteVpC6TczGWkTaZywVqkFXMBLyAReCFSUVuJX0nNuVg+DT2t6z9xSHJuc7tvFu6zk5IMo4cG
 ME7
X-Received: by 2002:a5d:64e3:0:b0:439:bcc2:bf0a with SMTP id
 ffacd0b85a97d-43fe3dfd560mr1287848f8f.23.1776396600971; 
 Thu, 16 Apr 2026 20:30:00 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm1038677f8f.24.2026.04.16.20.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:30:00 -0700 (PDT)
Message-ID: <4aa2a069-a7c3-48cd-b8ca-4b03adaa1227@linaro.org>
Date: Fri, 17 Apr 2026 05:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-5-philmd@linaro.org>
 <bcbfb47e-022b-4db5-90d9-a91599ed227f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <bcbfb47e-022b-4db5-90d9-a91599ed227f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/4/26 01:07, Richard Henderson wrote:
> On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
>> Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
>> Pass the MemOp alignment as argument to gen_ldst_multiple(). Keep
>> using MO_UNALN for REL6 decoder but use MO_ALIGN for the pre-REL6
>> part.
>>
>> Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
>> Reported-by: Richard Henderson<richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   target/mips/tcg/micromips_translate.c.inc | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'm not sure about our testing coverage here; I think I should
use default_tcg_memop_mask in a previous patch, see
mips_tr_init_disas_context():

    ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
                                   INSN_LOONGSON3A))) ? MO_UNALN
                                                      : MO_ALIGN;

