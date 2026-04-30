Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91899FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIK8P-0005C1-B0; Thu, 30 Apr 2026 01:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK85-00055A-Iq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:40:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK83-0000th-0H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:40:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-446fea16729so437942f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777527601; x=1778132401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxM3rhlMKrQzyni1Gr5kbEORVUSd1elj9gM7QpjMJ7A=;
 b=SgdfCapQnWOA7Hs5kQpsdZ9Fir7+Bh+Oiy1CwKAtRJGlAgMTBkhiL1bnuy0aiOhBPp
 svEW57UFqUoNQYXINQpaG8xVH1QoLdZlz9WVwDIauFFMUYRosqIQf63PuEM2qBIRGyWU
 f2A4tuAkLcn7EDT/Q2M8Zg4E8UpL6MWB8UBKyKWVJCyZ07OOJBOhYy1ZVIOb94bsLwVo
 4aejwEdM6TSD4Gn8Qye/6smT2yPPYkyoHNtZEZOkCKQLKqGJ29TmUumt9Q2VOq/H94nQ
 fFWqEisoWpAEEquc8VkLni99PfiUU3u/CkuBMsZJR9oQsF75+0aeKuMbXUfbmCCzs7iN
 rfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777527601; x=1778132401;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxM3rhlMKrQzyni1Gr5kbEORVUSd1elj9gM7QpjMJ7A=;
 b=NeWF+xG/HBU/BR9gjrnE/Dpioa3f/IN1DvvjlTUiwtGMCeVNP2dNsz4jQYglFkAGjy
 Wes+rUEf6FYNsSkFqF3YSTwlCEYOX8gEgVOSMlhIUZ907OEPslGCJ4D6ZM0jGNRG9jwT
 WQl03d+463+r4/+3eLYbAXAWyNXelwwM2Q0GnNFAVSmUo+4ITVJMs0luTz258Zk/uiiA
 ZKiCL47wqRlaZVvLjWC5KoKCTAJbC3zkvySVw/sZgL2xLkWAtD+yJ0ihmg/LcBfmjpfH
 6r+mpcLzpnG4w8WcwifUCU9AUPnsB4tOmD2OFK/ID3HdgzW3AKZ3NARz5HS1ItUV4Shq
 KcgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gRqjKCeTF72CM9kKjtdYQ0fEeBqgk8RGZ/ZGAKExXPQeGDJPs0DCwiqRhMvK4I7o7aJpE3MFGjchM@nongnu.org
X-Gm-Message-State: AOJu0YwVYIevJ8s42MppfWhr/HM/t8DyD5FdhAgXZ0C7INe7OGnrBUTw
 wjHD8vV+waHD5GH93vN85xDO+SASOHERQ6oBSNLOBIkabSayLEzI2etMPVM8+TFKPkk=
X-Gm-Gg: AeBDies3wOF0YcigI4Usnm2wTYUyLcuvo7qYcw/BhspQELbAwR9RuoIPV/0VW0ge4P/
 ueDCW3/MLHtljYk1zyitXPfp0MXoKJe+NcL09TJoYzZhBjFDlqq3PoRV8ZIjzLZZRtjkithXO98
 uVl4jc2HTCYZNwQbGc6buzZmoLWpmjdrae3KdlG18QU0SyuW9AZyynASWb5u38MY6wy3D96lGce
 58Ks3jvpWFxtjx/bSeHq6kUk4ucJyVkH9Q3FpnWTi31FRiRgPLvIZbqENanlUYOgZ5pbNu8NZWt
 c+Uq0ppWTEppIxlDx7S+y7nMVENxutb12kINa91klW1Qm9Dg9j8C6zhz0FYFYqEf+uuuTIILdBM
 L2aJHjo+3h5ICF0Wb7ftAx0v3CUDR5fL+VY8+LYT9ySYh/oIUJN3sovq+GkBiKL74EuSJ+xJwtU
 3JUVL/vrpnsU0CQwid6A/Q1mi+4UpYCUCk08+n0CKOIrGlPJK1c4VrD9qaHsOkDM0QF3gkjqvlu
 yNv
X-Received: by 2002:a05:6000:240c:b0:448:64d4:120 with SMTP id
 ffacd0b85a97d-4493c37ef3dmr2022447f8f.1.1777527600626; 
 Wed, 29 Apr 2026 22:40:00 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm9323463f8f.5.2026.04.29.22.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:39:59 -0700 (PDT)
Message-ID: <cc7638a1-4171-46dc-ac56-cb4f099311bf@linaro.org>
Date: Thu, 30 Apr 2026 07:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/40] fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 30/4/26 02:04, Richard Henderson wrote:
> This is almost always used with a constant FloatFmt,
> so inlining pulls the constants into the shifts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

