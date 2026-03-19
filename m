Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5E41075273
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w388r-0003at-EZ; Thu, 19 Mar 2026 03:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w388p-0003Ws-OQ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:50:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w388n-0006eR-UJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:50:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so2462155e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773906600; x=1774511400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4r7KQvopxr74JXCx2B8+fGdt5XT++QHTkRe+1h/lfk=;
 b=IGHKIZFk2bnH5BPwRsTe5xQw7kn/Yz/Yi3A7RiTmijCC0ZTW7XoCjdtRuTmyBlbhFG
 TnCc4OpAQjCqHE9I+QnePmphzvzu9jx4Kl8HEtzMSF8FPUlPdJsvyQxy8wDzIkxSuymZ
 EEPYbzupsqrkU679KDi3jxetnckvwzV+NETRMFDGNhGcj/gjl8VRrIzqkqp15Fg7VFlc
 BUZW4RCgWV5oykEUlTEqBm6OLoEcwfhWT1rXQ3xneksL2VA9ky/oO9g2Rai8Er06aP73
 mnG6WEnK2AjDSY0YdSXkpYPcv9HXZ4G3ReANjmb4tuUIGA/m/lxGljpVLJOHa0l1LzAR
 Liyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773906600; x=1774511400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4r7KQvopxr74JXCx2B8+fGdt5XT++QHTkRe+1h/lfk=;
 b=Fu4r4Ci+C6nwTq5j5W9lKpuRv68FYVOGpLrz8wEeZK7OaxyEzBl48mZRDbf8egLvZq
 P0cIfPDmOkjV3oltMOU+LxFedZpLh8/zfryF9iu507drhUj6lppEtD5LqqfrIG6ghWAb
 JUwvCil8/RTiPSylWFXnwGuHGY3xGdk9B5r6OZRppR6ToT6n4/u0esPs08bV6ORNDLtm
 1NHO3XKvVgQNuOggY8uk+l4TDF/qE6jtp8/GO460RUllpPQOcy1efTOhZEk4DB1S38jp
 Z3Rt3Euh/Z4QjGwmIma85SEPXtCKepK2EsRDzq1fWM4HxK6Biv+QiQCoxZoQ1Liwgl+b
 8Ugw==
X-Gm-Message-State: AOJu0Yxh6kQVPBvQrokjtO9NzzRK6oOXVs1q90q6M754pyNYJYIWKhPg
 gCaqdHT90NY1ZOFaZk3+vTpROhefiktP36ON4P9BPCNxeJI+dSl0+yHOCwgFG5X18Zs=
X-Gm-Gg: ATEYQzx8IuRveRNrG/zivlx8vz1OTZkvgJdc1+ZInAYHwCwGKGkRuRYyg9mdSWD6F0t
 hC1GirEHr1151KAwHk3ygFicUUaWwBz876Tftl++zIqfDgkj17NetNw8YDRtZ6ELd3M/ds8KAq5
 Ov9+AvDgO4uQF+e/zVunMnRMx65s6SL3FOg3PgWq4ZwlrlPG2VLok0fMCqDVYjCeJrrkigjzd6x
 a/P3UYAq/MsN6ba9ZjKpafuOTQkcuPDzqswQIvCEJenonuM9BMCgiRgPMDz7upvt38Wz2C5E0Pz
 elfcEj2GiJzlUird4C1KJNHqVFba+P1tAYDw7KsQTi9B4VZxQyb2XQ2jDgHIYBn2FVsxNv2ja/p
 uHoaCu1WzCftmqzr5jIns9XcM7Y6NgldCi9R6cRCvJj9NBn6q1VjUDlSlT7tZQ3TmP01LwboQ4X
 at2LHtDDwqiIvhOvf23yw1DRS8YJKE9An0Xvk=
X-Received: by 2002:a05:600c:46c5:b0:485:419c:4eba with SMTP id
 5b1f17b1804b1-486f441fbfcmr105570695e9.1.1773906599783; 
 Thu, 19 Mar 2026 00:49:59 -0700 (PDT)
Received: from [192.168.69.206] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8c292e2sm46334885e9.2.2026.03.19.00.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 00:49:59 -0700 (PDT)
Message-ID: <5851dbb7-ee54-4ee4-bb7d-4af59c1b0ff3@linaro.org>
Date: Thu, 19 Mar 2026 08:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] QEMU 11.0.0-rc0 is now available
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <mqiddietxtens5beqoev3dekswknitwtrsggyb6jj4a7h6qzkk@kpbhzzl2mq6b>
 <a45225b9-4116-70cc-b08a-adc60d6f9ce1@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a45225b9-4116-70cc-b08a-adc60d6f9ce1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/3/26 00:18, BALATON Zoltan wrote:
> On Wed, 18 Mar 2026, Michael Roth wrote:
>> Please add entries to the ChangeLog for the 11.0 release below:
>>
>>  http://wiki.qemu.org/ChangeLog/11.0
> 
> I don't know if this was updated already but it says:
> 
> "The pc-i440fx-2.6, pc-q35-2.6, pc-i440fx-2.7 and pc-q35-2.7 machines 
> have been removed."

Indeed, we removed from 2.6 to 2.12, 3.0, 4.0 and 4.1.

