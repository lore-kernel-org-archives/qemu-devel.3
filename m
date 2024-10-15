Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB95D216BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ih7-0006pa-OJ; Tue, 15 Oct 2024 10:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ih3-0006pL-5K
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:38:37 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ih1-0005qJ-JE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:38:36 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so2362610a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003113; x=1729607913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6kix5UXfeEn6d5nosqaibaMgM7lIgHMVFGZaJAEoDak=;
 b=y2o42IebvqGQZMoSrKVPHDxC06/YxLZ2iZC+kQmtpGqV4oQBpgPakHhp4r1iKHmoAa
 cF7cHKtD0nTC7PHsZewaeb/beAWLM92ZtWtxAgBjmPz2Hh/W+xQEd4Q0jDyZy8OJQQgX
 KAF85q12anALpV6Bxt2aox9xs+DjvyNiz6OYC+qI+XFrL/xUnBgQooxmZ8OiH8fXzO3U
 RjndB5zo4/Tr7pz6HP4yhGN+nG4nB3Pxwsosi8W6y9BEVs1HOM+EW0J8t/Wd6MCD+1J9
 t+B6vAMCom3Nad8EV9lm7Vt7e7ucELu8pNjy8ikWHkP/4JkLtmsb++EBaJBvJ0il30ef
 pc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003113; x=1729607913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6kix5UXfeEn6d5nosqaibaMgM7lIgHMVFGZaJAEoDak=;
 b=uyqWdmXA8cFaO/kNoG1n/kMndH7wm+Eir8DZHKvkg8UbjVcUKrfsP9isz8u6WlRcVB
 gFvYnNtCTRt+TSc3U3B/EiRTwD1DsLrFSIxvpeS9NQ96JULwCsUkjqbh2G/ZDpuIaKHg
 /9nFBpvax/A16YC26wlP/mIvCc69ZsgN2KbaYCjwMiTDvIVcUI6XrqXswVDjWALDDg6w
 OwbTy09KB8ZyowKWySa6/RIVN0ioykMWQi7UMoDUJzXie9MZT2nl6fcrncXOAyHFAR1R
 U1hLJyvTTzvgDZ3pjSvuwXiBZBSLxNt/Xp+LvYIuSQlPI+cwkndfwhu61Dd/kH1cGdgv
 7USw==
X-Gm-Message-State: AOJu0YwV6FeXIYe74C+d7ljapgFcKDZM67XD73OWCtVQALUMBXWWqauF
 wSKKMGm83v6l/tw6kY+X0fxi8XMTbhRJ3bRbAMtt481bRJ8wHg2r/fSEDJ9Z1iibrvC4JklIi85
 n
X-Google-Smtp-Source: AGHT+IG5BImROydpCwe2ay0knOkTSHD0QYB90hI1sO9l3//d2SpNN+nRZlm8wwTLWWMrx8Hpa3qhtQ==
X-Received: by 2002:a05:6a21:2d89:b0:1d8:abf3:58cc with SMTP id
 adf61e73a8af0-1d8bcfa53c7mr24733521637.35.1729003113463; 
 Tue, 15 Oct 2024 07:38:33 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e773b11fesm1331064b3a.64.2024.10.15.07.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:38:32 -0700 (PDT)
Message-ID: <4482e6c1-6e31-433f-9c3a-f9ba8db2aec7@linaro.org>
Date: Tue, 15 Oct 2024 11:38:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] gdbstub: Introduce ldtul_$endian_p() helpers
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20241010175246.15779-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010175246.15779-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 14:52, Philippe Mathieu-Daudé wrote:
> Only unreviewed patches from v2:
> https://lore.kernel.org/qemu-devel/20241004163042.85922-1-philmd@linaro.org/
> 
> Philippe Mathieu-Daudé (2):
>    exec/tswap: Massage target_needs_bswap() definition
>    gdbstub/helpers: Introduce ldtul_$endian_p() helpers

Series queued.


