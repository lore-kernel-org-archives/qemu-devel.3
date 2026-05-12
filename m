Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54128CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMt0n-0000li-GC; Tue, 12 May 2026 15:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMt02-0000kA-Lz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:42:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMszy-0003Lt-WF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:42:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so5380381f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778614952; x=1779219752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HkJAp/w94WuVSXKRjtYf+C5uGOl4aG/uMoRBHpIxbds=;
 b=cavu/PKg/CB/r70zrU9xnhv9e1WtkQjEvQ9tAvi/+VgtcNEzmOkBtj0o8SLCKv+Okb
 9JWCVFUxNy/CxcpCqqhzpU5QWRdDNDI0HKGaSvnCd4iOVJqeTetaurOHgAxoiULEqwgV
 TSlMv+v29AY9F+RL+nDpsm4WkVYRAWQUObFdCFt9eoAACYUOVaxRXtoKESkqbs0NrM4D
 vAJhhDFnMir6G0qUGwffhxHBZin14CnhnPLezP9gbAMqVFVEASv0f4lTaGiGjs0DsoJo
 vpje6p4GHlrQd7CMJyOFjbxFd6aFQGXrszo6PWH+TK0kyvH5S7bcd6dF2amofj9Det7N
 wtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614952; x=1779219752;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HkJAp/w94WuVSXKRjtYf+C5uGOl4aG/uMoRBHpIxbds=;
 b=YXpta9uIBX7YraNka1MzbcvVXBqtzHRcgFUcpjUCQI1LQhrhIxAc6nG0PqPngM7F5H
 tMuj+tNuoPKUSbptwYnFVhdfDX2hOizZFBavWXeFwhc3r+yLkhowe3N37nk5j2cbKn0y
 J1xE5sFe4yTqc3B1UrUJyXiDhm2JyGNlcUUHMfioRmJEnWeG65xnvCSiDP1m7Sv3P2kd
 0PCdOwAuPH3iqk87bfvN6MvuIjKn8JCE/DF4kyJ/QfBDw54Y1dTnYQX6/2zraT4ftj21
 m3GRCPjulIUVAx6POOZ8kp3hx7dmfTlDKHXXOYb/8uOFlAyLP9IeXz6aoD67kvwivJJD
 FUpg==
X-Gm-Message-State: AOJu0Ywmm/hYkTUtluLuYXcrdTRlRrm+F4mCYu1gQh6acaQUycu7B/ZU
 II2YBJhHwB8Tl4cInfQq84C4rZfZgEmdSHWzAP9Fdrv5xDOgg9Ek75yC5qo4ThmlFrDJQexOBpU
 yH3cdOTU=
X-Gm-Gg: Acq92OETIn91uUWhwpp2mWczWMtHH1qs3VleZXclYgIox5K48LwulU2qcsvpWgA9F0q
 QB9rXRKHZkzSfR2p1BKaf4hmUu2VcQu+YFkgOpvQDYrkgPx2O+R+kXl5vKvEwsrqKXDT/9d9KC7
 MzE19P2yHYtrtCUfXm9zajd+eL9VI2mWg6uTb0FLgC3ZO/LuI2k7k9doUvLQD+JEXtcaztIJz95
 ggPXPCjTW8BWDfn25cHEve2cKjzvKajOE37msUnRIJsopz9cacYT2Gp5omY0YSLsbGBjAUEKLsY
 vkzq3FQ0l0EVbRSBMo6Tml4ctGdavA9HOKqmzeWAifsfx3VWl38Gc7HYNKMzRnVAN8BDcJatzpc
 3yKNUHxX7JFgKgyJtWki+kRLRP7OoVDRAKOb2m6e6vP+4WHGFOmSWtnNKK/D8736gFNUYixMvvJ
 WiRgA6wQPQGFLJLvljL47uWKctY9f/zU/Fcq7lDuqsRrjPJPjFA8lU7FxsOXGBglTNNg==
X-Received: by 2002:a05:6000:26ce:b0:44b:7ec9:2d76 with SMTP id
 ffacd0b85a97d-45c58f41e40mr235944f8f.7.1778614952015; 
 Tue, 12 May 2026 12:42:32 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eab7sm34138607f8f.23.2026.05.12.12.42.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 12:42:31 -0700 (PDT)
Message-ID: <83d4a57c-8e19-46fc-a011-766e713bbef3@linaro.org>
Date: Tue, 12 May 2026 21:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] Misc HW patches for 2026-05-12
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
References: <20260512062142.67998-1-philmd@linaro.org>
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
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

On 12/5/26 08:21, Philippe Mathieu-Daudé wrote:

> ----------------------------------------------------------------
> Misc HW patches
> 
> - More ATI VGA fixes
> - Add support for pre-setting RPMB authentication key on eMMC cards
> - Fix VDPA on big-endian hosts
> - Handle sub-page granularity in cpu_memory_rw_debug()
> - Fix leak in pca955x_set_led()
> - Mark IPv6 header structure as packed
> - MAINTAINERS updates
> ----------------------------------------------------------------

> Christian Speich (3):
>    hw/sd/sd: Allow multi-byte read/write for generic paths

There is a problem with this patch, a test is timeouting...

