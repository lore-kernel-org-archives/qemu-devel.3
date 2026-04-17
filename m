Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186C4F8E4AB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcTS-0004Pp-8e; Fri, 17 Apr 2026 02:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcTQ-0004Od-1b
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:14:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcTO-0004Oz-Fp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:14:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b150559bso2378575e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776406477; x=1777011277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ewTG4PtM2cdjHGXZfHm//ggROs3DZ3LP1qNXA0Mzgb4=;
 b=XvduoXwHiKTmS1mgF+hdIvSqMamLSn6NyGh2rlfjwY5kETni4ZXUmDJZwK9rhVLq1a
 3NcyiQpgzQCKrKj7kK09rWpZ/Pg3rl2Zu6P4ecvDtWmIge0zm7lCCwAT6lawRrQbUwO5
 F2GVH65CU42VUw30YrlPlm8BMUTLTxkrkEEdNVRLRzcZQWY/v3Q58oH9vpPsNfTq5XLa
 A4+/MCDDYC5XOLJmMpk7jyk/AgJ/AQ68sSOz/h79Dcq3j39KbFI6sgDNRvHR1RmHWDyU
 T4a67l/O+p6gB7Q2RzcYAoDJ1aeRMRNfSYlX96coWvv9Lzg5CZiIYy/kK82hOsnrXiMt
 Bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406477; x=1777011277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewTG4PtM2cdjHGXZfHm//ggROs3DZ3LP1qNXA0Mzgb4=;
 b=MlTT5isDpLlojSXEjuzP2qV+tO+irWJwXiRDxX/xCJvDRqUcGpSOvDS9TTT32Y7ZoU
 YNoCpPitbGR0DmqwXyez/Q4vbwmtTWcX5aFbCmXU9Ch387Lzi4ai37cMJFx2BRT3Fq7o
 FPR7G4LFCWO7PYW81iRiZqDfgt1JttFrAjJEU8SBAQauFipt6E8y7/Ux4PGRf7VKaVIc
 j5uEWEqjhiHERlZX+YSIrXQKPehNwX4Fnlc+XXTUOcDpPownu+ZfOM3LVBiqWY9mrQzS
 i+11XLXWut3B80+tbSSYGwe3FoRg1lT9vGGtN4b34Yg1/rpArChG4WlXtY08f9ai8AQo
 eusg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ahCdvlfdKDn5N/k8EiBROXJbURTSgwRzvnppSRCTe85qLBGi43U+XlqRPMo+jA9Qz9268GvNz/gk/@nongnu.org
X-Gm-Message-State: AOJu0YxR78gZj6sirMASN8C+0Dkbiu6Y+LNKA4uW5VdCH+G96L1MfSQY
 A2MK5Q/63AI5+RfKeGEkK+5ZZcRvkHMVmdW8BWaLRUOEchTvdrM6I++iQw91sbwgyPk=
X-Gm-Gg: AeBDiet7eGKc/7BdsbElPY7HhFsgbqBfa8V/P/+SQPKk0FegPksooYn6nFafucM29O0
 f72FOuE+3rA7d4qXxjlZmbxUPnG7w1hdoxKHB7u98DlL1oTNTt7JzHrq9/VYAzI/oK7NS0IepKn
 AQdFN6JE2b2VxLXEsBzf/qjwpLhHNQ/F9u2kBcg5mq79PLhiW7R+vT4CQNMRS+05Heajra8D8OP
 DitS0tF0IMwh4I4OuQs9eqzoMxy7nv8W7GdHoiJzYUqKg+AAOpW74DopS7XNnsKuvxK1x+YgnKv
 YlXIUDgp05eQD0BE9tiYzWr1uWElbc2QgPHfWiPtEXagVyEuQ4+BSU0Jg9oJiifvdJBubNanW5f
 8UNopF9PGy9jNNyMJ5f4ZXhIf4j1emITF6IWsSEHQu2jNn6KDuzv0HRc/AUHKSQnRrs/S0g0WBc
 IcGCcRwe31DFJBPZJdbcUgsr1HVxWPCspZb6XuR1pymBk8v3wWqdiXFKbcQzr/TOlN/CRqm2B2R
 X5xvBnVJXDH4Js=
X-Received: by 2002:adf:f8ca:0:b0:43f:e41d:85f2 with SMTP id
 ffacd0b85a97d-43fe41d8657mr1277830f8f.2.1776406476730; 
 Thu, 16 Apr 2026 23:14:36 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm1990950f8f.10.2026.04.16.23.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:14:36 -0700 (PDT)
Message-ID: <9a2468f0-f734-4dca-8fda-56d173da0db3@linaro.org>
Date: Fri, 17 Apr 2026 08:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-11-jamin_lin@aspeedtech.com>
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

On 16/4/26 03:49, Jamin Lin wrote:
> EHCI supports 64-bit addressing when the 64-bit Addressing Capability
> bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register
> provides the upper 32 bits that are concatenated with 32-bit link
> pointer values to form 64-bit control data structure addresses
> (EHCI 1.0, section 2.3.5 and Appendix B).
> 
> qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)
> are stored as 32-bit values in the data structures and must be
> expanded to full 64-bit descriptor addresses when 64-bit mode is
> enabled. Update the qTD traversal paths to use ehci_get_desc_addr()
> when following link pointers.
> 
> Appendix B also defines high dword fields for qTD buffer pointers.
> Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay
> handling to load and propagate the high buffer pointer fields.
> 
> When 64-bit capability is disabled, descriptor and buffer addresses
> remain 32-bit and existing behaviour is unchanged.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h |  1 +
>   hw/usb/hcd-ehci.c | 19 ++++++++++++-------
>   2 files changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

