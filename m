Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9C0CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNmW-0007qZ-HY; Mon, 11 May 2026 06:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNmO-0007j7-JT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:22:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNmN-0007wX-2m
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:22:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so3556010f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494945; x=1779099745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yEzqFqGz9+DUHekuN5+5IJroaXlbMa2pZ90ZSJVmTYU=;
 b=anOo97SvppIDyDPfJS3vt5FiVUXnlzmbYzkkbh7pV2Y1G7BhvVDlKq3w8+DcZgV+Bf
 vAi1Mgx/YkB2LfrHFXZtgwhUUHo73H3ch0+JTJ5zCntp1dZPktohnSCqG+pO4fLOHoa+
 bhALwvIsniNuoE7a01dTAIR17PXvAhUIomZ6k5ujSuW/Lylp0lUA9AYVC+dIDlxzKv9/
 dkXwjnNOromHAGK8WSVPeY/6/GmshkAIlUdJc/ey3JRC3A2BqkvAVZhOmfa+iyohMay6
 pKnzmHxapVxZ3XF7NORLcGG5oQq6AyShiw8SKOPeVq2vkMCSXwhPMdDKOHucONDj8H+R
 Dc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494945; x=1779099745;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yEzqFqGz9+DUHekuN5+5IJroaXlbMa2pZ90ZSJVmTYU=;
 b=ISK5P/jkdsTtQP5Td1Q9uy62e58HQkE5T30pjou68nq4Z5cWNOU0m/iChahpUbQuGe
 XRX7VaOhAE+fYKAA+IlLY4zjd/1UqDyTctsQ/utE9/8F5X+syi+sINFfsEQaT/Jh8XUs
 yewXK+PaYB+SRvHTDusieRcd4DbNZxdLzdUMcxxb8L5/1N/cdqLlcoaGzs5AnuSeHRb4
 PvFy8HODVhJi7b81fmRHhRw+2eAzhDw7r3+N9yRlkPxjWJKQSyiL1tvhBMtilAqtcTVw
 cQTLKSfL01nzj2eoQvhqFJu9k9NIlGNLWRCXtwB3X5KQ4g0ZX6vsYJOv6cjvfpWxA1xi
 DApA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+B58NfctrxVtmdlYZqGUjKqmu/hKgceh0n1BjvI4CBEh71Pf1Eag5/PXCltBrBP5d9nI8uRbe9cui@nongnu.org
X-Gm-Message-State: AOJu0Yw3L44fdt6RMLcEQZ0BtK+m2aPNrmORkU53vWvkTY1inzJq0bGY
 K85bY3I8laVMfJEpqgVn/RJ2SzMWqlZGbq/6kKCBLxsSDus5/NPXDG7g+Uh6UvbJM3g=
X-Gm-Gg: Acq92OH/Efz/R8fc/UCvc/K16k2efemCVrHMSJs1SR1SjOCfdd/ijvR7uES9/xUMp5G
 rqlcKq4R7rvpKF7R2ViIagBc9HSlTcPFI/5Vm9UrHvMhtP0LE00sALYuUOvklKrvee1tpL0DTVl
 bf+3Avk+9DmCMVe9G9nZ7KmyqZbyjS8J//oLrmrsJLQlGWi8UOp7NPb+IyQwvGPdGRwhKHaKesz
 CtldSdKD3/FMkp68QopP1gRAPDPbnLKIn6yDg6LmwlfIgms1Ne7CXtz19w2ebGb0jcmaIYd/n5B
 DN1n++Ocb2ZhVPVCtuXXl0xZFL4tAm8EmjsPtCGVYCIg8LjE5L4VCKQMHlx+1WNbp+ATYAnRsbo
 tLWEt/qTwk/jqVv0YFT2PbXVq04a0QIMF0mq53lhludkobMAt3Ri5dT+qpy8/0Iqy7N5RfPtX21
 QLf/ngntnKSi/7ZMFqUV4DGdJ4lsqFLctiF8/cpxjHP/aVfC5hyU5wXFMK8cNOtihnqAQt61AJd
 A0T
X-Received: by 2002:a05:6000:1a8d:b0:449:c5e2:a8ad with SMTP id
 ffacd0b85a97d-45696ea700amr13892329f8f.11.1778494945321; 
 Mon, 11 May 2026 03:22:25 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-458b3664e3esm8977775f8f.3.2026.05.11.03.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:22:24 -0700 (PDT)
Message-ID: <d569568a-8831-48f3-b8e6-665efce8650e@linaro.org>
Date: Mon, 11 May 2026 12:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
 peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org
References: <20260114013257.3500578-1-ruanjinjie@huawei.com>
 <92cecc93-1f68-44f2-8d0b-934e868d3e2c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <92cecc93-1f68-44f2-8d0b-934e868d3e2c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 11/5/26 09:06, Paolo Bonzini wrote:

> I have also considered changing the function to return a struct 
> timespec.  I didn't like it too much because struct timespec uses a 
> time_t which is possibly 32-bit.  Now, QEMU is probably broken for Y2038 
> anyway, but having time_t dependencies in device emulation code is not 
> great; at least mktimegm and gmtime_r could be rewritten easily.

Worth tracking in GitLab issues?

