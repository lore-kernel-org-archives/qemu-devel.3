Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108F6C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0lM-0000Jw-Dq; Mon, 03 Feb 2025 13:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf0lJ-0000J5-Li
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:01:35 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf0lG-00007q-RK
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:01:32 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21644aca3a0so110811215ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738605688; x=1739210488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=McG6HjAUy8lAtYKTxtpu3r6hB/zczMFHKjbTNSMHuEE=;
 b=sxiQJgq9NNVN84yScbBYFJW+Yshpgtp+yLzI0McYqv8auX9VEVIR2Y+5PgL6FOxIR0
 3cRb6Gs9EG8oDveoScatIbxoBcFdJBIFYO+ffukCrjJz0/qR5WEUF8ndFuxLWDICOJxW
 xtIyzmU3hFqKhexMEkLSTcDdawN+x/WYt4F+VRi98jraaanku+n2JaZ4qD2dCKpUPF3U
 UJAxLFwWTa1HBRjAQKvLFiwLq5uonXsYzYicv1WEAFOal23TpTpcSw33vT7ef4KaI9Fi
 e5IVkI/kqNApwWyHYNl3VeUNqfohirZLGbGq+otrWnXI8uTk1lrt2HhmdWhqi3ZpHBc8
 MLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738605688; x=1739210488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=McG6HjAUy8lAtYKTxtpu3r6hB/zczMFHKjbTNSMHuEE=;
 b=V48peA4qQKmX2HwJzVD12oR6vDCIofkGUJqzMcn15nuM5+UgdSoXSnsJNDO/+nBnKH
 K14/OIBFXyajFvFWlMdegoQFSOXnHOqZgv9KSg859pA7+PwTKB5r88Jg2X93bnyMy8PI
 vaatPyv9961+sKRdYBgZL64OyvBpDHWW2kFRkemykcv53AooCGz6n9/D1Jhv1bY6c1Il
 IMkJnqYvNPCveRGNAjfYcWRbHciQIn8bMWeTe81DaK0rZ+M/37ievVqCCyuQPaXmx67o
 201i+PYGFI5B/oNbofC9tmmHprAkTeFoYMq7bBpq5TGIWu0L5/ICgFVAizc3oufBdyk+
 H/OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo9VGnDROpouUgd2JpbjszqnbRveA0OniUwesvj7risz3OOQKWgfYFXmG2v7TdeWN/peVIOpMNXuI/@nongnu.org
X-Gm-Message-State: AOJu0YxuCtRebKLydHkiJVy60cgGxVDyxifw3JCgmQnyD8CserpHVE0+
 6PzbwP+VaM/dc64Qc/w2SK9fv+2Hs4DwQsTSKtPdbqi6mVN+SML6BJOMa4+YXlk=
X-Gm-Gg: ASbGncukRc0yKEf2hLeK4Y+kEqrG30tZMsSP2CGTZoupWwvK8m6vfIaUkEzMhqxzXh/
 Gr4DNx9hDwBF0/PgrvmDYKiaY21Sf1SkJgLqNMX2Fe91stDRSZuH3hJMj8bpDYRbnYXr/YRITE+
 RryGJZOSrDx1KilL24ER9qrZhYeGyctJ/l10AfSVdVw60iZJfKkz0hDaN3Nod9dA8+zl/6X9T2y
 U3+kW9Xyd4b+mBYj/dDJ/l94JlQlSrcSB5h1MBwbyLsAKtyaZm7g0EOmGaCzButQyik0kyBs8Zn
 4HrSyAfEYb29az+sczQcaTG/2gaCABVo3Mn3sYyKtV3seAdhc3oNUxs=
X-Google-Smtp-Source: AGHT+IE2Kr3ZFCuyNQt+xJAhxdq6SvT+aT1P1w9vNu/PzP3HKYxyJFaTNho3xGJm8MfUNJXwj7AmQQ==
X-Received: by 2002:a05:6a21:178a:b0:1e1:b727:181a with SMTP id
 adf61e73a8af0-1ed7a640db4mr39341726637.24.1738605688634; 
 Mon, 03 Feb 2025 10:01:28 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69cdfecsm8937791b3a.133.2025.02.03.10.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:01:27 -0800 (PST)
Message-ID: <8f128095-121c-463a-8a58-18ffe66dd67f@linaro.org>
Date: Mon, 3 Feb 2025 10:01:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] target/mips: Protect objects with CONFIG_TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-9-richard.henderson@linaro.org>
 <f5f62fd7-0d42-4f0c-b8bf-cbcdd9dc54ab@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f5f62fd7-0d42-4f0c-b8bf-cbcdd9dc54ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/3/25 09:25, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 3/2/25 04:18, Richard Henderson wrote:
>> Hack around mips32 host allowing kvm acceleration
>> of mips64 guest, but tcg is disabled.
> 
> We have in target/mips/meson.build:
> 
> if 'CONFIG_TCG' in config_all_accel
>    subdir('tcg')
> endif
> 
> What is the problem you are trying to address here?

That test is for CONFIG_TCG enabled for *any* target (config_all_accel).

E.g. qemu-system-mips on mipsel host has TCG enabled.

>> +mips_ss.add(when: 'CONFIG_TCG', if_true: files(

This test is for CONFIG_TCG enabled for a specific target (config_target).

E.g. qemu-system-mips64 on mipsel host does not have TCG enabled.
But it does have kvm enabled, so the target isn't entirely disabled.

Paolo's reply to the cover suggests this usage might be killable as well, so that we 
require a mips64el host to spawn mips64el guests, and all of this goes away.


r~

