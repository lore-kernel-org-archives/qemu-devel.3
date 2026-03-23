Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18BEC01B6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4c1B-0002xj-Fj; Mon, 23 Mar 2026 05:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4c18-0002xS-6M
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:56:14 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4c16-0002dj-2k
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:56:13 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cd7c372929so350025285a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774259770; x=1774864570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GoXQh1XHY/BT/dkaML1UfiEECOiB9hUsbcRBCvsOi9A=;
 b=pWhz5+F2GheGr2SGz4ongLbYeFgdy6gGZcyFRE9/Ro6Vxy1gjrDh9obVLQmeFOIH42
 uGw/ok475+ICXeQOlvRuDCaU2cV3SSCL3al3RMWhwO7mkh9e9uhq3ez4S172UCZNvTHq
 i5bhKq1P0kKv6ogUAmNMotZOp4EaGR/ee3rf1qSsPLu7XrPW+D4d60Txa75Z1h1rUBbB
 T6a7CfAS6hoSoSscsuGK55qLegUwfaP0pE3gfa6OeSytP4WmU9QLfvs1+jBGp1NKbGYK
 CkYk0EKQTIXEkE+cCIB2O6zZTfo6JixKAFI0yetkqo/gG9SXGVkX3BFldz4OT+8WQkJo
 M8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774259770; x=1774864570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GoXQh1XHY/BT/dkaML1UfiEECOiB9hUsbcRBCvsOi9A=;
 b=bDbrx5cucB2bSC7bMTYfzISqpH49rX9g80RB7zhQSNYUHkEl6YQTrgBnC8pCCxle3k
 P2gH1NFm6+rcegHW5bf3WpCt6MTf6t4mMcabznu96UutUsobPvi3y36jYipm7J/sfl9I
 SYe4iZIkJaJjBUrz7cY2GaRZsvCs9tOGVRyxcoCQEdmUI9EnbWSNF7NCfmbh0/GkRKkr
 L+PJTTWnB4PiRug93bAa/MlDtMOMtJwqU/QF7pYGu6JjlqfZfRYnuEXQ2j9TVNzMxXw2
 IVwB+WfM1/muAsNtJnyi24DbbLcWtHpwYJZZQG20sosFzIGjJ7C00Z3I1XUqTEJTuvbU
 jpIQ==
X-Gm-Message-State: AOJu0YyqJcKTTy0sfo16foJzvC6dQwTUhpUcwiP5yHL6B4tJhLHxujtr
 SXEapdjqj7SvFe9TccV6+rHdQFBs9CWYeReNuMKI7zCsOstuFo96jjPAATAXEf4IVAGatchsphh
 FZ3KWcai11Q==
X-Gm-Gg: ATEYQzz1r+yl6E803jA9sR540mWk3AzwMeVtAqL0OuA0fu4kpoGdDIImr3f3+qLcNsU
 KSFeo7COGp6AHMoSyq4QgYlSB9fE00JIcPNtcOwqsNK6Ix3AATx+zOFUhZfbm1uopFvitONPxXL
 TdTNbdiQw1YhWqNRNoTgz4DdRb7EWj7JAxxa0iTeoOEl3qi5TDMARtHo3LacF2WMbUzdB129Wga
 fO7S3Z+VRlEHfu0wzJmrVkT4HUAOe6TKRaTOBj5lBpklYJcJ9IGMh/ybm2yuoN7pxu7ncGECdyH
 cRO5CPA9XpA31NR2irVHrwHab/gzsM+Gc3UQAZmQYlDQnwWITsLhZnc+L7JckmrDV7gzxLPMAcB
 40Cnb/D/H3qEKGPpFbROui21a6038QWCN9CKbsSuQi34dTXQwHlkB6WzukDCLnta1Hy97WiS7Ig
 Vm+jUaEr8vIt9x+ayv4YcD06GdIaK1Hi+J6GfvuOInAR/c/nI7HB1S04+HMgEEBxmbNg==
X-Received: by 2002:a05:620a:3182:b0:8cd:b33f:1492 with SMTP id
 af79cd13be357-8cfc7f4d8a7mr1594731485a.39.1774259769817; 
 Mon, 23 Mar 2026 02:56:09 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc8fa74c1sm746639285a.18.2026.03.23.02.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:56:08 -0700 (PDT)
Message-ID: <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
Date: Mon, 23 Mar 2026 10:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317120241.16320-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x734.google.com
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

On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    hw/tpm: Factor tpm_ppi_enabled() out
>    hw/tpm: Add TPMIfClass::ppi_enabled field
>    hw/tpm: Remove CRBState::ppi_enabled field
>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>      TPMState
>    hw/tpm: Simplify tpm_ppi_enabled()

Series queued for 11.1 (typo fixed), thanks.

