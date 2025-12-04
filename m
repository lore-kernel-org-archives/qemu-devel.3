Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA39D29FAB
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDve-00047L-Q1; Thu, 04 Dec 2025 13:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRDvc-00046p-Go
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:19:44 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRDva-00016Q-A9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:19:44 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-343774bd9b4so1014042a91.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764872379; x=1765477179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CYsc787tQo5xf4+vPWXZrVzbUjRunC0ksdnBvtGJAgI=;
 b=qUxvGR/mQe12wsFaA4RXjuYRyIUndiWNkpc3Rnq1VMAhYqUAB8ga2KgT9fHNUo1qcp
 XaSkuYl1SWLUGoEdXb2mNm81dVDs61GcD1qKpCZ2ZeY3Lf5CTiO7xKz7MsyGsbeyl7lq
 RA6QSSw5+FSCak0uuSbQxWndYPzFJ64Smthxp8ADOAxqZY5idiNY2eLhoFiYAxpyS3P4
 v9e8znYdOL9HlmsUFdsVXXWHTZ35vA8deVlRcYjcpDqJlmkbiE7L0k7QCLIDKdzk2MHp
 uPPuZZyAQ0sAB/4jt6+Dfh8IVuo+MO1CKYKQ4zPbUqauGAZQXbCkOQ+hzRor+X2ap5FV
 /i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764872379; x=1765477179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CYsc787tQo5xf4+vPWXZrVzbUjRunC0ksdnBvtGJAgI=;
 b=VZPVHuwKklXbDLjWKK+0dbi3Z/GUJrtKMdshtCKk5AzL3oW1wtMj8gQDTdt5fIGcmc
 E7sop6l4SVXQom3q2x8D54dvKYs3c9RIsIVkmUS202HX26cTUBAILdjSrLzFD1eG2vEM
 z75JLzY9CEhZazuX+Nl/MByCgONdd5QLB4PKIoytVXWGLyvUNgohEogjCgrHqViazzdX
 xKAvLBBoGY+0AZq22VVUH7qBmyEjIC8vVBX6JKN6rOyyldyuFJocAL46qXnju0Gg8SWO
 UmkBKt4KlSfN13msn+inmBj8sK9avNAwfxTLHez0Y8y+jUuZnJSxKa37S0V135nYhGci
 lTQA==
X-Gm-Message-State: AOJu0YwzbJTHRBXvbGdMvJtOppvTkzDVfj2mGBhR7onOOh2KsJn1qLUo
 CsWahSM4obhHglnlL0VYpMa4h0j/XwvOdFhno6VkAxZUFK6hliAKVf+9C0VsvZl9Uu4=
X-Gm-Gg: ASbGncuYdnjDl3/+v9x58Q0CbOTEetoKFFnqrhYt4W7F9svu+uxWSY5rud2xl6qweuB
 STAZ20jetl+5QE+OZ0O31YN+LMBqt5CPs+fce2CUaFbKr1w//oweK4rRyF7aE6nbkZTVV5kScQf
 8pdcs/0zSJuNIald7Z6ZtmNNVjsocGMWAm6z92TMDXiPNaxBONmFKA6klxb/4LeIoupkeicv5jF
 9/sNX5wdgljXLmPTZTfAJ9sIjOGjkAoCCirY3TpHyzC+q0FyiZLCAzLZ5RttZ1MINjk0XB9H8B6
 /tauyEAAucn/PcQDS1lTsBvOeOS4soSWKxdjc4Ah9RRNKxYZ+z/mL5SBw4/QudJKhzStiEvpVkU
 Y7smYXG9qii6RKAO12Ar35E+o8OzwP8e7PA3qsN84qQy98aRzlTX7vsDnN8zd2DlAwmjeRh1gq+
 zHvsiERbDTPnXCIRCo7Sew3whIqE9awFxa9heV9Tp8fYevoj0B9hEIt30=
X-Google-Smtp-Source: AGHT+IFnuzRenuZm745XhXwUqt7evMiM98nS8pYBlCqSfXT5jtvQbyR8QTYxw2y9zeZE5nC3Rpe9qQ==
X-Received: by 2002:a17:90b:548f:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-349125d346amr8970428a91.12.1764872378769; 
 Thu, 04 Dec 2025 10:19:38 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34912a07626sm2484926a91.4.2025.12.04.10.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 10:19:38 -0800 (PST)
Message-ID: <59eb723b-e34f-4a5e-a2c5-2e3242cba8df@linaro.org>
Date: Thu, 4 Dec 2025 10:19:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 1/4] hw/arm/smmuv3: Extract common definitions to
 smmuv3-common.h
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-2-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251126154547.1300748-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 7:45 AM, Tao Tang wrote:
> Move register definitions, command enums, and Stream Table Entry (STE) /
> Context Descriptor (CD) structure definitions from the internal header
> hw/arm/smmuv3-internal.h to a new common header
> include/hw/arm/smmuv3-common.h.
> 
> This allows other components, such as generic SMMUv3 tests or test devices,
> to utilize these definitions without including the specific SMMUv3 device
> internal state.
> 
> In addition, refactor the STE and CD field definitions to consistently use
> the 'hw/registerfields.h' API and introduce corresponding setter macros to
> facilitate structure manipulation.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3-internal.h       | 255 +-----------------
>   include/hw/arm/smmuv3-common.h | 461 +++++++++++++++++++++++++++++++++
>   2 files changed, 462 insertions(+), 254 deletions(-)
>   create mode 100644 include/hw/arm/smmuv3-common.h
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


