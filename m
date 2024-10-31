Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9024ED767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZYU-0004qd-4K; Thu, 31 Oct 2024 14:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6ZYS-0004n4-Fv
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 14:05:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6ZYQ-0000Xn-ST
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 14:05:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cbb1cf324so10074365ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730397953; x=1731002753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9oPZAZniln+PAgrYPVd6iEPVhV25QEZ3fIV7f9+xgk=;
 b=uAdoQ2gNrybaNKMvQaTdIf6xFxqSd4+tA/ksPaMczw4+DklpxtWEe8o1LopdccfXjU
 a2LVCcYcIKzcPUucIhkdKVNzocATkrP0d0I78uJVVe9WfjPllBKYjXxSr8fFsWqoJb+c
 tkg+Nez7ZUnXg6r/Q2mfujfLTK8KOmPQxJg6eGFn2fN6PxsTrPUKXkaIyS4FYkWIjqMj
 aWtP+8JBpZMpjQcSvCmyBVBpZfIvG4T6nLqQA6FZMqgKrC23deAl4jLa4b40aoyRmdUN
 jpNe0zFdUE/sRwMGR3Wrer8E1j9gAuhG8WEk7Z5OTR26eU2EBgSv/yMC64EpT51FUGZO
 ZJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397953; x=1731002753;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9oPZAZniln+PAgrYPVd6iEPVhV25QEZ3fIV7f9+xgk=;
 b=G/ymzr+PKV5p7SsiS5hROIrU4X80WEgHVq4ouF9KS6F5T2iSfHxRex2u/nFTEc4G43
 R2T0929kfff7tN1xSZpK+JGwNfKhfXmNMQrsXcqc+ATMoti8JAZc4SmggJ7kqLS4qCG3
 YGeTPqGOS8J/wQlzsV0GDcL+VH/Roqj8klSetQOm9jAhbMFT6lbNV6nbE8nycd5DkPgT
 F0aXqrLnmhUHsQlHVmux4S4sWcMFeVMeZkwAvQJkst6uci+dPPE/v0130j+SDCqV4FWz
 mjhA8mvJRP+yB+unBRLukjHWAS2L57Po4KmtqnClt4n8Q4zcKVCWmfuMnxpjAcwq16Vi
 zScg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlwlOTHjGnohJ0H8L+eaILDtncLK97Pm6TByZwbJvxG22cskGF//lC4a96lpYHEaRkQqOXIieN9wDr@nongnu.org
X-Gm-Message-State: AOJu0YyHDDi9rt+LFO98w1i4l2V2RiJGMEmczlNgB1ocIpepk2O5bN95
 EJ5vZOugeGfF3XT3DZUeNLY6V9LX9jXP40zapzyxXRzfP87zzx/x/0ZJkHU9Bv8=
X-Google-Smtp-Source: AGHT+IHMuCu577YawCps6GQpHbFIeyy48omL1MO+dx9d+ynldhNb82BmK6IOfouK9f56aQltHlhbZw==
X-Received: by 2002:a17:902:c946:b0:20c:d1ec:aeb with SMTP id
 d9443c01a7336-210c69e33c3mr241878325ad.21.1730397952813; 
 Thu, 31 Oct 2024 11:05:52 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057d469bsm11116095ad.271.2024.10.31.11.05.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 11:05:52 -0700 (PDT)
Message-ID: <ca5cbfa8-f729-41fe-89ec-4b7fa86ff790@linaro.org>
Date: Thu, 31 Oct 2024 11:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: remove erroneous file that breaks git clone on
 Windows
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20241023073914.895438-1-pierrick.bouvier@linaro.org>
 <02bf77ef-9136-4976-b961-ffb889ed1181@linaro.org>
 <9ea39adf-e276-484e-9c92-b7db2019ace8@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9ea39adf-e276-484e-9c92-b7db2019ace8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/31/24 04:01, Michael Tokarev wrote:
> 29.10.2024 21:09, Pierrick Bouvier wrote:
>> On 10/23/24 00:39, Pierrick Bouvier wrote:
>>> This file was created by mistake in recent ed7667188 (9p: remove
>>> 'proxy' filesystem backend driver).
>>>
>>> When cloning the repository using native git for windows, we see this:
>>> Error: error: invalid path 'scripts/meson-buildoptions.'
> 
>> cc qemu-stable
> 
> Yeah, I noticed this patch already.  Thankfully, the mentioned
> commit isn't in any released version yet (it's past 9.1), so
> the wrong file doesn't need to be deleted in any stable series.
> 

Thanks for checking this Michael.

> But thank you for caring for stable series, much appreciated!
> 
> /mjt
> 

Regards,
Pierrick

