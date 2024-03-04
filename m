Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97DCC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBxP-0002Rx-Rd; Mon, 04 Mar 2024 12:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBxO-0002R8-GN
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:18:30 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBxJ-0005vK-7U
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:18:30 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e58a984ea1so3072502b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709572703; x=1710177503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YntQ3ABADeVDqD88zu1QWTkAFLJJB1JzDx+xSJtyAeM=;
 b=qsbgfCaEPOSUWln10+2JYvx2PgdUSsZ/X4LM9JTRS27kO2hMvg4EpBRL3I2Rslel3D
 QZl2CrX0rd82caLYWJZ+Us+y6sAR90PUcTMldlTNQmB0NClw4f5egtkjfYcUYHTGR8JP
 SOzXe29skbkh58pmEkV0SuTTYCHWYOhOWuOAfQzWJOxuJ+K80mNrdqGiNzX9SJURAnl7
 OHqa4/QqwaxboePyxKkPFaxFmCRRUIcLMsoji3QKRVodvoIrBspofTau3Rz1TZVT/JWI
 gndg5bq3U8xAIkW6XC3BG7eBSFbjYbHEGOcT3nz6pC8qLuNN4q81YYfySzVm8thDwoTT
 3arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709572703; x=1710177503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YntQ3ABADeVDqD88zu1QWTkAFLJJB1JzDx+xSJtyAeM=;
 b=pPu5SBoisL4Tah1vVh4cano4LjHLfd/rNfoFakvXlsnM/pIoqTBj76bF6fhqnq5ShR
 7bkyTH8fJDbPsIzFkZWqzJGadUcWZ8bDmG2dSqWO5+5whU6LUE0BMKkKPpH68xHEOQPL
 BYcqBJl0ZnUkHa+Vf7s5FO8wwQCgNqKXF7hevx7mT9hfWnUEJ/uVefZk6dtRKUjkCwJ8
 LtSNvS0KEb97/ORL3MiTUqZ20DcM1Zjz6FyYI8eD4VZJ7SpCQx0xbYRPG1JdQAJVYn2Z
 9e5hPvII6Le1Aeh87ZZlXHkIV+cPruD5k+h73lgVMWDuSQc/cmjpTVhREh1UoLBmMoj3
 2Itg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQluupX153B8LJRugJ4jPyLO1xr6L/5t79iiocb2/NosyM3y3vHlkCFacctAarc/Wm07GbMUa0UtjkNAk8so+uTp+AIhc=
X-Gm-Message-State: AOJu0YycZ2tAXCE8ZU0y68AWljVOS1B1HFJThMQpaxXBmr6ENLFmYvIm
 L1vXX1/GQIvwoPBgNeq7/Atdgcf6HeMinjFdiySAqs25W9VnEUn9J/xqoTAEHEo=
X-Google-Smtp-Source: AGHT+IFOg1+rHCK0xEerRlprq+fcAYsSXaegN4bRkwpC92cOPPrpGt9NwUEx7nDW6RRVEBLZcYXFSA==
X-Received: by 2002:a05:6a00:238f:b0:6e6:27d5:4182 with SMTP id
 f15-20020a056a00238f00b006e627d54182mr2580981pfc.9.1709572703085; 
 Mon, 04 Mar 2024 09:18:23 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 x11-20020aa784cb000000b006e45c5d7720sm7726423pfn.93.2024.03.04.09.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:18:22 -0800 (PST)
Message-ID: <aa702db8-9e72-4727-aac3-6824415ef29f@linaro.org>
Date: Mon, 4 Mar 2024 07:18:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gdbstub: Add Xfer:siginfo:read stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240303192610.498490-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 3/3/24 09:26, Gustavo Romero wrote:
> +    /* Filter out si_type from si_code. See comment in siginfo_noswap(). */ > +    tmp_siginfo = ts->sync_signal.info;
> +    tmp_siginfo.si_code = sextract32(tmp_siginfo.si_code, 0, 16);


This is incorrect, as it only handles synchronous signals.

In handle_pending_signal(), struct emulated_sigtable is passed, which has the correct 
siginfo (all of it, so no need for the adjustment).  I think you need to pass that in to 
gdb_handlesig so that a copy can be made for later xfer.


r~

