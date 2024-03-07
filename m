Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4D8C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHtp-0006Co-3x; Thu, 07 Mar 2024 12:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riHta-00069Q-Eh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:51:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riHtY-0006aK-OT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:51:06 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dd6198c4e2so3930465ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709833863; x=1710438663; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Nfbg/JeBwn6byluI8VIH0/u5d2jnUlw+lQwPxpb5ZI=;
 b=mQUqkJeGROrf+bVz+vNuUG8i/0mYByAu/505TrKJ2BeOWIgZJBjn3GKDPrsdfrJ4G5
 0OYkTEZjJ1QR57N/S/hMCoduxDTx4wNv5041AKFzXMKatRB0g5+3lmkUWyHMxvykPFz+
 +kPLVmUXt+ZD4YoIs7HHyMJhpqKVJY8LYvnkWD5yDzdQRKpCMt2Op2OjUFpRljf0+Sms
 KoODY55gg/hVdtlvLkcmN0gJa7/Spw8KK0uyneJV4ufBadrYLDEwKWkWnrkI6y3MaWG/
 Ce06l0fVAA+JYaoJ57yoP255sYf0A/xMW2YFkOaGPhMyuhowqZyRkuD2AtM/r/YyKksn
 uabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709833863; x=1710438663;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Nfbg/JeBwn6byluI8VIH0/u5d2jnUlw+lQwPxpb5ZI=;
 b=BG70VyVoaUtHUrmOrIf7hAjs/GPGExByarOlG0lP6UZIc9/uDVj66OmNmTgK1OVNk0
 4eDdCoauy79j6jPPIYRAvg7pfoiO+mYzcEs7HebMvUQMyxxwVvd3a9clOvz0n3rrFBjJ
 tRd3klEJY1QkfD2f6jc9XXxFO1wcM7aAkaq4Cg3SdmHgQJrMU8uPUZYALGCQ0x76xsZD
 26h6Sz0vKSA/SBmUu2M8eLNPwE05yT/EUjAYrFgTkcNFKjQfaVtcltKSIGl47Ciuc2iO
 sIUig4IwmumjAu+pt5qCNagqCpABTMe+PtWK71ziZE4t8wxvUTBWjMfCoCgy7uPTEHal
 2bQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFvhJBegmT4a/WaXjDdHUiHQx9mvqb4RlP+5NE52A6UdMWXKw3yUhlUclk2OOaS+F6xGix1D/a79jPBWHnyQkPlq9jA9k=
X-Gm-Message-State: AOJu0Yy935yMgJ4E47nP29M1UxcI1CQD/EtHcfvz9531MxQh8VewOgeM
 UKjc6yMWVseJ8XjjjmoNIeSdfH5yLIDxPM9bQlpLipULQDfrd4uEanPtsutHtZE=
X-Google-Smtp-Source: AGHT+IECNACWNARehKK2Qoz0nVNwsDke3sd6+qzfvdaGHI+wEqOTPyVF7vYvJzdctrt5KprYYJeUKg==
X-Received: by 2002:a17:902:e552:b0:1dc:f90e:25f1 with SMTP id
 n18-20020a170902e55200b001dcf90e25f1mr10667995plf.11.1709833863320; 
 Thu, 07 Mar 2024 09:51:03 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:120f:a4b2:91d8:ce8:af88?
 ([2804:7f0:b401:120f:a4b2:91d8:ce8:af88])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a170903234a00b001dc0d1fb3b1sm14865604plh.58.2024.03.07.09.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 09:51:02 -0800 (PST)
Subject: Re: [PATCH 1/2] gdbstub: Add Xfer:siginfo:read stub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
 <aa702db8-9e72-4727-aac3-6824415ef29f@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <6c7a2014-737c-ed15-332b-0e4879ef5eed@linaro.org>
Date: Thu, 7 Mar 2024 14:51:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <aa702db8-9e72-4727-aac3-6824415ef29f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.08,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/4/24 2:18 PM, Richard Henderson wrote:
> On 3/3/24 09:26, Gustavo Romero wrote:
>> +    /* Filter out si_type from si_code. See comment in siginfo_noswap(). */ > +    tmp_siginfo = ts->sync_signal.info;
>> +    tmp_siginfo.si_code = sextract32(tmp_siginfo.si_code, 0, 16);
> 
> 
> This is incorrect, as it only handles synchronous signals.
> 
> In handle_pending_signal(), struct emulated_sigtable is passed, which has the correct siginfo (all of it, so no need for the adjustment).  I think you need to pass that in to gdb_handlesig so that a copy can be made for later xfer.

Thanks, I'm sending v2 that fixes it.


Cheers,
Gustavo

