Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D39D12662
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 07:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ERp-00024A-5E; Tue, 05 Nov 2024 02:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycoekjan@gmail.com>)
 id 1t8ERo-00023p-AB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:57:56 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ycoekjan@gmail.com>)
 id 1t8ERm-0002Jl-LL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:57:56 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7f3f184985bso130228a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 23:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730793469; x=1731398269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hxnoxu1hCHNGYQ7Q58oSV8iTkMvxqDh9LiagzeO4T2g=;
 b=UycD9OSSE1ysJ9DSpk4EMOiuzFN9q2og4PmKP8RT5zZ3oucwl2AmQBh3LQ3t7zVYgw
 aP+VZoUviefaaC6Tfmpw0pkQA9K4tL+v3uOU9rtO51msuDBg+5TThmTOF5wQK1MUj8oY
 cFK+nJr32Cpitgn8vvuNS+DcHz5MM1RmfnHGDzKKUrtJHSTG4asSW1oULlMYuqbN5APN
 zElMkVF5Et8ULLrADiHrKIm8xbgZfQmIAN6XRf4jAu3LzWJazCnS9w7clA9j20gCTQwk
 G9EvN1yqmNY+J+WRqgduZRVizcX/MSsunvsVwLkmUUsrNFIZFK3muxH5uhkEBbQfdRQ3
 xm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730793469; x=1731398269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hxnoxu1hCHNGYQ7Q58oSV8iTkMvxqDh9LiagzeO4T2g=;
 b=CDW7orTPwcKn7wf++2R+BA8UuyQpRrQzUinmqnRJeQyQwrsNuToKfAfFJP3AkRYORu
 hoS5tmXdXLiAn0lcpv3eNs5UQFCHRb+/Qqr2TDLMKRBFvI3A2mLfAYA6R8KiuOOz1RIK
 Q80oh0xfk0XstDCnofTd4ue7Xs4TZYKsNfYREhrl88EOAkS0v7GLTfsSJx9hu7F8pfuX
 pZkbiWXqQ9jiJEvdCackaNZwyKNr96M4D2NLEAEKt+U/VX7LGkh18Ewhs0rj7FvHQ3RF
 qAG6vRb4PkRixRWrAmJPFmdLcuSGTYL6c5mN6T8OtBQo1NtgESZ/uXfuL//osO4VNuvl
 skzw==
X-Gm-Message-State: AOJu0YwvxtqsMtwL+3jxNrx4NgkksBD84BmwYdYhPzEz7uaxZGMz1Ci5
 BK780TTjeLBw0J5m5Ve/mfzE5qgnghlCFi0zgEgwrXtlJS2ibdQGXmqVCMDVQQs=
X-Google-Smtp-Source: AGHT+IFPJncbUtZfQrvdqGSC+mvkE5tN9nCwWy5rKoO043PDUYFLGX5YyNjjBR0bHj7bbmitG8wepg==
X-Received: by 2002:a05:6a21:78a1:b0:1db:f05f:55c1 with SMTP id
 adf61e73a8af0-1dbf05f57ffmr2838704637.30.1730793468899; 
 Mon, 04 Nov 2024 23:57:48 -0800 (PST)
Received: from inspiron-manjaro.localnet ([106.39.42.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa57ccesm11147193a91.29.2024.11.04.23.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 23:57:48 -0800 (PST)
From: Yip Coekjan <ycoekjan@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Inquiry About PC-Relative Code Generation in QEMU
Date: Tue, 05 Nov 2024 15:57:35 +0800
Message-ID: <1901752.tdWV9SEqCh@inspiron-manjaro>
In-Reply-To: <91fbafbd-ba52-4315-b696-9f2c4bcea534@linaro.org>
References: <CA+Oymobc=DOOuy431LJHTq4sOPiLRjpxyTzFp-zRE+NXOCim2g@mail.gmail.com>
 <91fbafbd-ba52-4315-b696-9f2c4bcea534@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ycoekjan@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Thank you for your response.

On 11/4/24 20:51:40, Richard Henderson wrote:

> User emulation does not have multiple mappings of the same physical page
> like system mode does.  This is because in user emulation we have only one
> process to emulate.

To clarify, is the reason QEMU does not use `CF_PCREL` for user emulation 
because it could potentially generate more opcodes, thus impacting 
performance?

> No.  Treating the guest code as PC as a variable instead of a constant is
> different from generating position independent host code.

I briefly went through `target/i386/tcg/translate.c` and noticed that when 
`CF_PCREL` is enabled, the generated opcodes seem to resemble PIC (Position-
Independent Code). My understanding is that `CF_PCREL` was not originally 
intended for generating PIC, but the host code generated does appear to be 
PIC. As I'm not very familiar with QEMU, please correct me if I'm mistaken.

Best regards,
Yip Coekjan



