Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B713C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 02:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfsM5-0005QC-2E; Sun, 18 Aug 2024 22:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfsM3-0005Pd-Un
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 22:42:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfsM2-000199-Hu
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 22:42:47 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7105043330aso3060404b3a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724035365; x=1724640165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGDckcCJDpjtidOeQWE+ozyyWae23815OPIityBqC9k=;
 b=j5KF/d07s1On9t/FFY/J7ZpyyZ5d4qZqoDLVgGD76bEcyi2LIi2gb7vHEiqhU7SNr7
 7CUQdBjRma3txq++NsHD8T79nnPgyX8deki8Oy2NXeFdfsQUnj5IRrBoIwZ5b853pNMV
 cDTaIai5CDHmCW6qj8LLwV8LtAqQWAfa5poC3Hm4KnpH6+giDedXCD00E3A0mzjomuUA
 1OqL8fsA4riAEbYcjU6WA7pPVxKonR1X68e9WIsx06S3fKCbHusKv3Y2qvCXMpBgU0H1
 cnaHundEjw9QSMOJ7ymu4q3ygoK8oxqffaaf1sHy0l5YVHTilsD4kJbm15oAtWZjH2uF
 XZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724035365; x=1724640165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zGDckcCJDpjtidOeQWE+ozyyWae23815OPIityBqC9k=;
 b=ILUm3rm5hOvPlN/Grmp0vYePB0MWOIaYYPPMZwE+MWW9J80O+KSocAT0hMmV3ovhEn
 AYo/lcO1SGGSAL7C3Dra97bOZc5iHiLZJEqE80nsh3cbWMb4xt/1B+tdG/CYE20CDqmP
 Tt1/fOUTbZYgt1j1HkM7eR/c1PuAPvjAd+QHZreIdNdt7WF1ODxzgxqL8M2TkFMATJA3
 SbBS2F0/mCYEvsXixPeM8z/1Kp0ZB0aYIGVkVDN6pzJ7wkPQmDWiz6UGR4GtURwFsUja
 lZkZZt2VTMM0mSGyvYVqvGc87FAkl188/73AyLzDV4Vc7/BZLGnJclN00AtBMT+/lq2v
 VJSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXURLLVdd5TnHCkLsLYo+I4SZintDnzyAKdhs6Lm5qk91C2rDk6e2esecHnuJoC+OHKwny94gJtw3hH@nongnu.org
X-Gm-Message-State: AOJu0YyAKRzi1+VKSDa9Mi17qJIJgwvx1JMtVpRvmyFpZxhnQWjCk5Wo
 b/NksAXAp6hkbwCECeIZ5N/nHoQA7T7gbvijt6V27OhufNGxxaoFIUKGh9HH1Zl3ISTFk+JZJ63
 KxQe75Q==
X-Google-Smtp-Source: AGHT+IEKfVrZ/dfvDu1DsaYR7wxqq9toGQj2x/ywuD0lpec6DAoxq5XrtXAfHGFb3UD2cFhOBjjK3Q==
X-Received: by 2002:a05:6a21:390:b0:1c4:9e5f:c645 with SMTP id
 adf61e73a8af0-1c90502ae24mr9982861637.40.1724035364581; 
 Sun, 18 Aug 2024 19:42:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af3d945sm5756268b3a.189.2024.08.18.19.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 19:42:44 -0700 (PDT)
Message-ID: <6d973ff1-10af-4f1a-be07-501199216b50@linaro.org>
Date: Mon, 19 Aug 2024 12:42:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps -- CORRECTION
To: Carl Hauser <chauser@pullman.com>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
 <aa172755-faf8-4587-a4e8-d1cbfdc139b1@pullman.com>
 <e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org>
 <275021f0-887c-4de8-a86d-ad9abc83df95@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <275021f0-887c-4de8-a86d-ad9abc83df95@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/18/24 10:03, Carl Hauser wrote:
> I changed translate.c:4597 from return true; to return advance_pc(dc); and it worked.

Whoops, yes indeed.  Thanks for the catch.


r~

