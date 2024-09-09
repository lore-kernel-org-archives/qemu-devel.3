Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F9FECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sneQM-0003Yh-9T; Mon, 09 Sep 2024 09:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sneQK-0003Y7-KC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:27:20 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sneQJ-0006SW-3H
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:27:20 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso407093166b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725888437; x=1726493237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=COEqWiE7wLDst1//sDDIxrBALfpRrL8SNYdn6ZpQS3c=;
 b=ZrYmCbr/nNgSlGdiLQlxZqULQWq4KkDgnBRRr3KXo1eyrIEdtgME+ZlEYvMFlOOXZi
 cT6O82rEg/QkB2rC/MIcveAOBlMivFYuezP/vmZ6on/2m+O9N+49Fok99Y316+TAPfBI
 F3mXF7Zl7O4Eag260rUUDRH6aEzyiIV4kK5eGx0b2swCNWI+GfgMwCYLDVByomV/++Sh
 GdVZrBuZiBx2E4df74Z5Lu4l3c8nCDsEHSqk33bmUQS9Wf4ffSaSwe1MqVheHIfQQYrB
 PqCK1CvSW8qFPsjbETCFOPFbL06aRKRhfGidclP75nrSluWY2YgsHURHU6udVQnmDdu+
 KCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725888437; x=1726493237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=COEqWiE7wLDst1//sDDIxrBALfpRrL8SNYdn6ZpQS3c=;
 b=b1+IlbqErmGCXPIi1m9DwoinTvmsyeGuY1NiGD7iIcoFB1YIhwDJF5KkAZzzMXPTct
 g+79Z/Fm5IkzuOjuBFmODVMETvThy5/Wo0E/X179Xkx5x33uEFfqUcdYThOo5FI1kJXs
 QNu/A0Wv8ibFpdUq+gkg5l89E/Jnb8jy9/CywMyMz1A0iQOikcLfcdyABZtpqrI4xxuH
 2ztSSz+i2MzxAMmwBut9lQ4pXwQPE7IUd4nUmfczYw4Gr2lxQ6OAf+v5jBgYlZYbx4Np
 O1s52YgcdCg5j8iWeZzQqvMtk3X/S6f3Kb/bVKQe8P20shg7JGqexYIywBdldEewkwiC
 QoMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtQFyzcRzZmsz+n8ClQ56nGv40VV+K97mXEHQ2jlk5Sh7h8+LXzR7WIGvPdpME3CzVSBcq0gKXS2UM@nongnu.org
X-Gm-Message-State: AOJu0YwpAp66cOOur18DlqgXDv4lvzSVgwXOWxyCTk+RXVlrYqTfj0ML
 tLzQHfJ6r4yN/7i53NsjZWgpCLtble1pVuHZotPWQfWjtAokc6HQwt6bflMDaxMbi0Qp+ZYinI5
 Q
X-Google-Smtp-Source: AGHT+IG5zwj/5CZ9MM9OkT4Hn43brJYYf5IK0y06n76yDqckadZg4JMW1F+B8PNKZzKcgoGRstNocA==
X-Received: by 2002:a17:907:801:b0:a83:94bd:d913 with SMTP id
 a640c23a62f3a-a8a885c0116mr925591166b.10.1725888437288; 
 Mon, 09 Sep 2024 06:27:17 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583555csm344845066b.15.2024.09.09.06.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 06:27:16 -0700 (PDT)
Message-ID: <f1049bac-3808-4486-a0ba-700c9d5eddd7@linaro.org>
Date: Mon, 9 Sep 2024 15:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tmp105: Improvements and fixes
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240906154911.86803-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Hi Cédric,

On 6/9/24 17:49, Philippe Mathieu-Daudé wrote:
> Respin of Guenter fixes with:
> - Use registerfields API
> - Clear OS bit in WRITE path

Since our mails crossed (you reviewed v1 while I was
posting v2), do you mind having another look at this
v2? At least patch #4 isn't yet reviewed.

Thanks,

Phil.

> Supersedes: <20240906132912.3826089-1-linux@roeck-us.net>
> 
> Guenter Roeck (2):
>    hw/sensor/tmp105: Coding style fixes
>    hw/sensor/tmp105: Lower 4 bit of limit registers are always 0
> 
> Philippe Mathieu-Daudé (3):
>    hw/sensor/tmp105: Use registerfields API
>    hw/sensor/tmp105: Pass 'oneshot' argument to tmp105_alarm_update()
>    hw/sensor/tmp105: OS (one-shot) bit in config register always returns
>      0
> 
>   hw/sensor/tmp105.c | 66 ++++++++++++++++++++++++++--------------------
>   1 file changed, 37 insertions(+), 29 deletions(-)
> 


