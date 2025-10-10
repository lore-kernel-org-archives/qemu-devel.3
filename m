Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF49CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 04:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v74ly-0006bO-Ry; Fri, 10 Oct 2025 00:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v74lv-0006b0-C9
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:30:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v74ls-0002N8-Hi
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:30:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1251700b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 21:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760070619; x=1760675419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmozZEGptHRsQa8ds21XewPhn/t9fs+AXq8RwJPGAmg=;
 b=xbYm343qZkYH/5aK9BaaJx1JdPhYlymQ+NhRPExyCc5YTOseOg7SzEyZm4Pi4Pytvt
 2VRjlYHsMbKEcSUx8Wsr7hQXpGj84BGrYxs8lt+rDCzzfizgmo1xSSGhiqS8OHoF2luS
 cmeXDU+EOI4upkwWJTFNWMo7HI4Vi1gFTQjBhdEKpBAHNMzvmyQR6IINNseUnWu+g7YH
 uF0ymt/hYpnLVjzkKxXJPEteI925Y7b2GREIgADLc+CapcitLUVVD9Sr2a8MKmAr6hsq
 t2bxym1JZc5Bt/SBiznk8fBTfIr2fmpT6H+uljBzMgIEjHLE9r5OxTHep5ywEDH1/aDv
 fqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760070619; x=1760675419;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmozZEGptHRsQa8ds21XewPhn/t9fs+AXq8RwJPGAmg=;
 b=QPcZGgzBJqI69wJJLfdr1on27QLL8tg871+/N042gD2D/ttAxXbzV872BfRR3c3JJJ
 Sx1k/026K/Ks9VYtSBu1AdY4Fg5tXp8Kdzo8h7tVP0AobwODJmbReRsMG040YfoS+4J4
 cczV6KQ2tgqHf9Byb71CTWpBdhOl8I5tnCt8w2Q4dHz7t7VZV4UI5hYw+J5Vm8vX+IsN
 VyjsaYz8FZkzmbjHKgu4snimoSFdwjjl+lQnTX6xzCfsdfQV4EUjGEVvJ5DIYLesuccG
 /dVgxL+vJ1ugU44kgEFmjbMj3uKClZ1+y7Aok3MMdnbSV5JY4Ta6Ib/gyhDInxTqO73m
 j/Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzloepYC8HN/RLu4DDwWyIAdYa5iaPcCFi43iqElT67DHtqmMCQRGYnzh1W0py8q535WnEdY1h0koM@nongnu.org
X-Gm-Message-State: AOJu0Yy+4fLovNQa+aimLzLzXeP7Ma0C4FK+J1VxwK0/wwuDA/nKIIeP
 MP/O5EkyOS1ystyOzAgXLLgMxlh4/nhhKfg+TQpNdYWO+MzokffgywOXCI9SizeGVumSXIk0m7a
 bRy6QQfU=
X-Gm-Gg: ASbGncu6el7j7kGNpzrzqyS5A1H8Z9lM1BS18plDmiBIIgGhM4zZy8Fo3auRdPjcEVi
 tLyjhGCTUZ8KaZDgrUE3JxMjK748/rmUO7WrdQZtDkckg75Mujon3RU2UXNNqwsuMs/o0OSVAcA
 osyEHJODAgViUeLw5rdeFsbPpTA17x9GN9XJCeQL4Ncu6/KrKDmGsCQQOWb/BAKV1FnWnO6N2bC
 Ae+sNI4nh8zS58ehe8p2qqsXyXxaKNETxY6zmafn/tSxPsjG/XJ4cXvXBkmJ5EIDOfVinX2q1wB
 Y7V0QfChJbk5FPIjlEKUU/5reJSs5FcE/x23mDV20fgsFyw0jexTIABN1gtErfcYABbg/0DxCkh
 Igqj3P6Mrz7BUDuZdmLegt3yhVzMcZnN/ZdJ+w2ltd9VG+4M0WcjZIvf7U1U=
X-Google-Smtp-Source: AGHT+IHsASzHMpUDLK1J08Nv6MO9DEfyv9Fz/kbj/gLREaZCGsZBfrqqoen+aGpJ4Ljdc0Cv9k26kA==
X-Received: by 2002:a05:6a20:9183:b0:32b:83af:11ff with SMTP id
 adf61e73a8af0-32da8139347mr13075466637.2.1760070619361; 
 Thu, 09 Oct 2025 21:30:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678d821159sm1191059a12.0.2025.10.09.21.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 21:30:18 -0700 (PDT)
Message-ID: <b2d08405-876a-4d33-a05a-4aa3d5fca6c4@linaro.org>
Date: Thu, 9 Oct 2025 21:30:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/avr: Use vaddr type for $PC jumps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251009200525.33987-1-philmd@linaro.org>
 <3460610b-5c1a-4189-8f0a-fd04897effb5@linaro.org>
 <78a13e96-1404-484d-a985-6b403fd1462c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <78a13e96-1404-484d-a985-6b403fd1462c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/9/25 19:56, Philippe Mathieu-Daudé wrote:
> Oh I see. Then avr_tr_insn_start() is also buggy?

Good question.  It depends on how we view things.

At least once upon a time, the values in insn_start were all private to the target.  They 
were only consumed by restore_state_to_opc.

Over time there has been creep, where the first argument might be assumed to be the 
virtual address.  E.g. plugins?  But beyond that?


r~

