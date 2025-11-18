Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B696ECEDDB0
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNTi-0007II-WC; Tue, 18 Nov 2025 10:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLNTB-0007Fe-SR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:18:29 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLNT2-00060Q-AV
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:18:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so31594135e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763479082; x=1764083882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YunEwXh1/2JBQkuUQejJJuFKanqtl33gQ9SI4tKqYCM=;
 b=h706DT9BL9sYMWdEgHZYvem75kcml49Xqb1dYiDnulS1NnFIaY3tu6HTr9CFzstEGF
 cP8AhvTNeeud/3lOrI//QgaqBbAhWSkcnTEDxucdbzM/EJsJg93vz4RXb9Di/0OyRa3u
 c/6t1hZ/if/td8BJCrDljy3+19KveQTmxftSc0Ov6glKBwMEu7obQcQHGCmx0S5CB6he
 5+FEtE687suut8nwFlaWa93Ix/EznXlqUaQb62jsBBl55HBIT4waqT8WeAfiwONcAC/y
 huegmcnDFlEUqdtgcAt85d3DBn7nurg+lv1ILQI2Kyzgc3vTA2psQfTfXiLxVHwDjsqb
 RbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763479082; x=1764083882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YunEwXh1/2JBQkuUQejJJuFKanqtl33gQ9SI4tKqYCM=;
 b=dbQMxU7z9CCQnWZusA/fA5MPvyZUAC8RdOjM63Mhx2Z1Yx7O8XPsY82Ad2fBZPG73h
 YsH/Nd6Wqlg9Bh2/mR5lM7QlgiS/AXoZDJeGWaJ6+BJQcNAn5MVBxlqgRKiqVP6cUKpw
 ALkG19gD5nIfTirPiU7KK9dhU+oUfFWXwDBmmjtsZUXrKoGCcrDoIjftKpxcFKOV4KPC
 91zg6l0rIjDLkpR14dI3wWCY8pFQaKH/HEwRzSqCmA1PrbuUzJ+1CwysFcBLPMmBNPNB
 SVUKoYx7Upzqe2RATt4C44mdPHoeyOHdYVmtgUZD3ON05/VsUDJ9pEPgLCF2R/T9mDT6
 1q9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlDJGUVBwuOopmFQ8YrGdvll2J7VltzLx63lid3PbyQDl0oKH1bEmDOwBrDi+coHQdFWgOGHUhKeX/@nongnu.org
X-Gm-Message-State: AOJu0YzFIF582GjEKedIjXog3pzqHVagK+ZK7dnoMaesAbEBGs8OMe4b
 7mdhsv/2BykHDWIL+lzzF0ZuETgf2kOtZj9zQI7FhQCcl9B6n+HKvE94rewg3QlyYPE=
X-Gm-Gg: ASbGnctubchcWtPe7pxFKahM60fCJPN3fG5P/qibrBf/kWnFmgkWU/Jk+PNp5cf1HaP
 A+XLQaDE0SgPvanKkoYFcCoQZ9BaoqehFphcAFhKFVNqY1rl7kem84tJWl5CNoFT5u31EwF+HCj
 IIRuO4uIIpw13ouBNpGtfi5KbxxY5tS6PSYkpVbGPdJ35lLiI+wuvKtzhkLLxHkB11Ww/0HgXRY
 JGLQw76PVTT98bcOOFdz2U8uqv/nj5Rn+kK+uKPihXhD8nz2b8zDovYwUk1Vnagg3Yoi2q6C9yL
 eTqQA1AlUs5x6FtydqqVbNy4y7tPUGN2BwN5+L/WB/WjRy5C0r3HC6hGG/Lg44khy60wAMZ4c1b
 TUHcN/48hSpcCzLW5mfXcSwAOoZii6Jedk/7tlp0gzHXqkrqTXoIndJ24SDHg5vK5yE9ASi8qkO
 rEEYMPagdMbvpjlFoy0lAsdCLeRvOBfGBZkhzRbr3ig+Qc+vC8+aC1Bg==
X-Google-Smtp-Source: AGHT+IFKEgIVIXYkBidq8osIZOqxoR7SX7bdegFrieDa3FjldXqsvvjTBTwPpEQ/jTwx2UFsnU3mpg==
X-Received: by 2002:a05:600c:3112:b0:477:9650:3184 with SMTP id
 5b1f17b1804b1-47796503351mr125659975e9.2.1763479081974; 
 Tue, 18 Nov 2025 07:18:01 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779a684202sm191019115e9.10.2025.11.18.07.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 07:18:01 -0800 (PST)
Message-ID: <4c7c7be5-b1d1-49a8-9a46-89084adefbc2@linaro.org>
Date: Tue, 18 Nov 2025 16:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio-user: recycle msg on failure
Content-Language: en-US
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-6-john.levon@nutanix.com> <aRtGN_Ji-HJDcXAC@lent>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aRtGN_Ji-HJDcXAC@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Hi John,

On 17/11/25 16:58, John Levon wrote:
> On Mon, Nov 17, 2025 at 09:26:56PM +0530, John Levon wrote:
> 
>> If we fail to read an incoming request, recycle the message.
>>
>> Resolves: Coverity CID 1611807
>> Resolves: Coverity CID 1611808
>> Signed-off-by: John Levon <john.levon@nutanix.com>
> 
> Peter, I did not hear back about a coverity account so was unable to directly
> test this; could you please help out?

IIRC you just need to https://scan.coverity.com/users/sign_up then
add the https://scan.coverity.com/projects/qemu project.

Regards,

Phil.

