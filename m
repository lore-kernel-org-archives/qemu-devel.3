Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE59CD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQlAb-0008Id-MU; Sat, 23 May 2026 08:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQlAa-0008IN-QV
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:09:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQlAZ-0003k5-Cr
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:09:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so24303475e9.1
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779538169; x=1780142969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xCFbyHd8StAqTTLnbz2vbET7OBZBXi8j/h2Tb9Ddcrg=;
 b=Ab9OvVLTY1oY5nILP3zaeZWfB/ovhHusAUGL8Ond0DEnjR6zK4lM0xFEE263tHQX7X
 HA0N8/z6tgGf5xENKdrMXaN2O0XmdXPyvefJcUVtFdKbPj+w3sDXg3VHZrin32/+lAfU
 6YqkxWo5eBxNmW9ufeyOqaznY60OIz2XWUHTMQxZo9Wxa1G2sO7Dp7PzN37B048tKtju
 2zMJ0Su/N+y9V1qZJ5HY1+brNeqBTnaw0YpbSsRmHZh+n5FLHU/6TnmuWxB8LikOvS9f
 3n3E0FjIVPdpGM8Gh05IlUE4bFFlUGWlfN7JIaTrwtQ2yIkpAGG0e7sIwqiy4gyx3xgg
 /FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779538169; x=1780142969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCFbyHd8StAqTTLnbz2vbET7OBZBXi8j/h2Tb9Ddcrg=;
 b=Bb7NBFfbmmbbNL71TSL9Fu8lPqKze5GxncxPoQOhxi8bu9zbMxqgCBv4ZLtpPAPe9d
 cKNx838ESQbLyOclwq4/6BkFqJOVysyEnF15Va90hCehXrz1cEEeL9qnkOK9Uoq91kVa
 jMDUYuvX/x+PTIpAoktylrsmq8ToYfYOqQt1jdoXCyNpekOHglU87r//ZWGkJWUm3AXu
 uZ1i61Nn1OC8IQ6FBvdYKC/+1UAjklLpfqLhst0ZtMj4phwwVfAvWRgvNvV6JaQPMT2s
 Re0nYnTtAtlVZ1AiqID8KHyKvq5WaBnigQbXup/IHqr1nFabxRifydgPpke8OlcaYSml
 RHdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dkSJXonjPbwZrg8w4yFjnhQfLPwvBY1qumh63UhJ7RXvHxbGqSbOWlu3pdrWEeMz4CrtWg2xSbD3q@nongnu.org
X-Gm-Message-State: AOJu0YyZe8JMy/cAh3gBvhcd2kMN89MuSLSa8+6MLZFREQmWYOwDlEWY
 hs0f7CNnHpyRevUfua8y51RmVA8bapIajwyHqL8iWu8zZWq35tMHvAjhvqHQeczMonEkVH1IdtJ
 ysYz2yKeSwQ==
X-Gm-Gg: Acq92OHLAykPNdacphGOse7DP1+/TLXZ4sJAoXbKuMMTGVKTHAz/rqPLgBmAe3Yjq/i
 dS0XPXnkFYEVtWYnJXzFGxjEI1PZr9JIoqmhReBeUu7kizNCuWXF+7ZjY18cm5kbf8ZShJlx+Tf
 td8BMPZa8s++vpx6AdgxNKJy6785Ozjw7cLHtKKgcm6rm70ARWtMH+fiU2WDLm15rt94c3Fh8EQ
 4VbFwmR4KR6OVfPSGBPhAzj9AcVMrpzKHbVRExY10buD7AOi9cS6ItkBUpw+hYW8FraVvlrn1g0
 xOYksxHjC8BWQW2ykYixSNDTXxrf/lijQge/ybuQjnH7d8TAk5jM/ADBWvf6uGc/7VQBsvILqgo
 aiK2mOhr6Tw5wmSf5/iBRy/asOSRd4m6hqu18fpu0r6U0rscdohTn/aMdrFfWvKaTwTsZNRe+dm
 mXTt6NeMh2VzP4W7zevUa9QAoYz+vIvaQ6nKMToGf9HYZD1TfpmOI5C/UCxH/u03MxAmabNhTq9
 Gc=
X-Received: by 2002:a05:600c:4589:b0:490:548e:b854 with SMTP id
 5b1f17b1804b1-490548eb9d5mr13261275e9.26.1779538169478; 
 Sat, 23 May 2026 05:09:29 -0700 (PDT)
Received: from [192.168.1.117] (88-180-58-130.subs.proxad.net. [88.180.58.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm170507965e9.7.2026.05.23.05.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 05:09:28 -0700 (PDT)
Message-ID: <f3ff3d37-31b5-457f-942f-ff6efc5ffe23@linaro.org>
Date: Sat, 23 May 2026 14:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/39] MAINTAINERS: Fix F: in "Raspberry Pi"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521080511.999266-14-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 21/5/26 10:04, Markus Armbruster wrote:
> Cover hw/arm/raspi4b.c.  Drop hw/arm/raspi_platform.h, it's in
> include/hw/arm/, and covered there.
> 
> Fixes: 95a5db3ae5 (MAINTAINERS: Add entries for missing ARM boards, 2018-11-19)
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

