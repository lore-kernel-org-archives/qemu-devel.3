Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7C0F9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdyf-0008GA-VN; Tue, 14 Apr 2026 09:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdyd-0008Ar-FP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:38:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdyb-0006vG-VY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:38:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so3341695f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776173927; x=1776778727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whDB8VhwGqbTEyY3Qa+uEJyCMg/7E8YmI9DuRxzW/zo=;
 b=PRj1KDV+Hi2sgQEHUEV4ekbxxM0DjR2MceE3yiqThi83TG/ooDPEIDE6YDKDuyrMkx
 qAeKjdysapkMfgz8qXwwp6lKLC8MYBmO//bE2ONLqto6yw96PEmpO+/ZvNOUOZaLOTVS
 +6NtHOGw8/0XdKzJm00HtUiAVq8f9g2g1c1eJdanDLbdwXKV0K7+aCQHKbpWRp2n6cqy
 /6JzAG6+eqgWKmis/MY/bidJakVeQOMK8aKQqavVsZ0CEezjSB3rbdtLgHKx7CCyWsUX
 S6qNiSalUinWHIneiru4CBu7neA3yBShCHYJ1dnCa7K+WVUxeqP5QIJXYXqPo5rMpjin
 WG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776173927; x=1776778727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=whDB8VhwGqbTEyY3Qa+uEJyCMg/7E8YmI9DuRxzW/zo=;
 b=UpH8x9STYGTZQzuWCADnYRjIB7vWb0dXcU0zxNB0CX6ncGBLPlPX58TH8n3a8lGB9F
 jiQTNLdl4Hj7gFRHNR7Eg2uTvW2LKho+oJRIuL5w/b5lC2IOJ6q6T8gyvWan5AlLYT4Y
 1mPkBSoflFSO/ao8F+7qtgm+JM8UrZeuKkTnOhL9Ap5opJyIFzqXTPCe0hYQfOxgSDBP
 3NYStwtut4CVsdiTKV9lMIbry9XzLnlN+IkdVc9p5MnJkGd9y94TBa41cP5xYkVXuXQx
 0sx5G0SrNJ+NbNmwcxULoFgbxFM1btHhZ3fRFdQYSMXb0dO+VIBamoVodZT27YSojEut
 AMOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hZyhCb9NXzt76aE7Eqa3uOfK5zxvyrfx3JvhX47Pg4SqWQq0kvX4tNchgKKMkwEPI36qtE30JRfI7@nongnu.org
X-Gm-Message-State: AOJu0YyugdZ0wQPaT2PPAJX2q1kP8FKYdhe6FeFw/28eaSLaE39+bfbS
 ZVZMIdHRZp51F2xThj70Y1CRx08Pr5O1B6CbIG9dlMZVrzt6AnKQuBWXPqGOGGJUYd0=
X-Gm-Gg: AeBDietXyLvljqyKikIZhVvUCUGAxDb3I+q56PJIzzbGrHH9wZ2ABOVVOEqwToq3Yfz
 Qh72HkcwoAVhMANBhbOgtyOv9bNOJpBPRgWQJcsTyxpDweDfsZ/SBAzaZorrze6DPFuKQM3g0EM
 9HMXJRI9nbjShhwAIm99DTeMz2j+Twg9AdrTLJKjjE+CNCnsnV8s8HoqOVfd6CDRN0n8teICgx4
 LOsqzcOOu7gbPtX+ifdzu1S/2NovK+IMwlmQJGyHLEKmqj7SSNfrJXtKl3JvV005IDCgIn48sVT
 BKEQixsG/wE44oyFb8/SRvSg8MC/ofXyDiEFMXUGuDlAYKEX/wkiTWs86URD6UF1ukIVc2izDX0
 M6Ou0hAxnfoGxv+U6SAsWC7CQnLqjwNWIFyzjVzDvgTJqItQH/uifXEbuOOgTcinFyKvF1BV86m
 xwDxy9Zr8FjEkMu2lkOgxCIFYuAXUD8iteTrJHDA8Sciz/EQIM4wlEFgBTS62lYa0+lA==
X-Received: by 2002:a05:6000:2411:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-43d642c0e02mr27022557f8f.33.1776173927342; 
 Tue, 14 Apr 2026 06:38:47 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7c135fd6sm22453329f8f.28.2026.04.14.06.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:38:46 -0700 (PDT)
Message-ID: <437b2fc7-123d-4a94-9f60-033998b6ecdd@linaro.org>
Date: Tue, 14 Apr 2026 15:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/sd/sd: Allow multi-byte read/write for generic
 paths
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-2-dc1cf172ee57@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204-sdcard-performance-b4-v3-2-dc1cf172ee57@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 4/2/26 14:22, Christian Speich wrote:
> Paths that use sd_generic_write/read_data can now write/read multiple
> bytes with one call.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sd.c | 62 +++++++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 35 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

