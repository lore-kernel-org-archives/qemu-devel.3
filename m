Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B5CC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn8J-0002jC-99; Tue, 16 Jul 2024 14:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8I-0002ba-Aa
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8G-0007OC-T4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso41072225e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155354; x=1721760154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fkHzRfvkPsxY7okL0Vc1d9yrOsZZB5iq1UTFzhzR4ME=;
 b=bmS6iTlu/ZDVGD7sS39R0OjPvAsvdnrQWmLxgAUU0h9z9thAzEe/eLaJ963Zkt/W1S
 KdOuns1TE6d1XA8KLTxcXDSLlasJZftzPv1eo03lFPujaBUa98WtHI3YWvEe94f7vy5J
 ADmAXU0AsOgCS/vzYehmOHqAIwI5BhjVqHTP+L4Ssqr+YkOXSz55CZEobzhUGBx4j4hc
 sihhq0VoJfCZM80uIC23oKxm4fex8c/Wft4iuqHTA1c6HKV3zxQO5+0SBRPRt5rZH+pI
 Zz9H9ICMytmpIq6u3LxD0Dj0/YFzOoUSpyG5/Akem1hr5lAJRQnl2SRwnrCvWQ6j2x33
 4rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155354; x=1721760154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkHzRfvkPsxY7okL0Vc1d9yrOsZZB5iq1UTFzhzR4ME=;
 b=hgydX3Di2njXRqGAvNS33o36mSDIz7zH+LSZZ1V98xHpcpjkH9MpORxjfrxBLAf9TI
 CeI6pSPDvtSyjlNBP/AnEQ0QMuscVAaUJcLYO2R/vsVs/NQ5dHiLuVaDPkyj4+wPxyL+
 8LwBQLBbVBBbLIC8f982IWX52+TvgGzL2eyku13D3pLqxH7337rso8qkbUiYAY6FDDq4
 Fy1FNDDZqqjAIDhfD2CS+8lKz3yEZyrlS6BtBpZ9wecJ78JpiV1i2OozKBTbTIP8J6cn
 QMPtPPOpqXLvP6i3kV3rjETTCJYU8+0htdL5QZFjXynupYjfZqrtnDio1VlufCC6a/4R
 tgZA==
X-Gm-Message-State: AOJu0YzL2tvTLIvmhD9ushaGUN0wNCO/RisWL4Xi3UMrEpvghQTHcI1Q
 VFVa22mmAD9eb6WEeBKHK+eU/2iZooidTDx5KZHItXfxKRJ+DbOMI/l88PVdT02eDfJMl2LXm0+
 xofdm1Q==
X-Google-Smtp-Source: AGHT+IGpUn3CjrfbvOnVZ5/p1lT3XjGuC+CSYdbg6loQaHrnVmbakvn+Us9P4bpTp9Lnc6vXBHIgeg==
X-Received: by 2002:a05:600c:350f:b0:426:5dde:627a with SMTP id
 5b1f17b1804b1-427ba67db02mr24281515e9.23.1721155354178; 
 Tue, 16 Jul 2024 11:42:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f276a62sm174818725e9.24.2024.07.16.11.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 11:42:33 -0700 (PDT)
Message-ID: <86aaa949-8046-47c8-aed7-7840eb889b97@linaro.org>
Date: Tue, 16 Jul 2024 20:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v49 00/11] hw/sd/sdcard: Add eMMC support
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240712162719.88165-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Series queued, thanks.

