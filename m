Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E35C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 06:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDeMp-00041S-OF; Sun, 02 Jun 2024 02:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDeMn-00040W-Cf
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 02:06:53 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDeMl-0006gZ-L0
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 02:06:53 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f12ed79fdfso1988798a34.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717308410; x=1717913210;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cF7VGwzZSATJd42Bnpu8IHS9TDK3nVYlsIF3O02zmLs=;
 b=bSU7Ev22vG0fTgpVh8Z4hLtM58d0RSqerJjvNWYAvQ1j6U7Obf4078BqXZ0S5mRyho
 bwbF5LIeL0wxZ1y0zyLi+9PMXgWELWcnDmWgV8yWWLGTyRx7PLA/gRdJoZJXx/qlQSQv
 Ef2Y9XX40zc2tZNoxY4XVRsu+Ooh/AXRXBr1WaC4ykCbjYtybEy8wBAHig/H/amPUcDy
 iBYTN+6A2UzeHLsBdXiNcOQ1v7ZR4XF9BitE/zZZB+/upU9LAItxxJpz8VJUfESgV4hq
 Xc0fTMhB5fipyYhhu3lkmkIQtHS8AIGekBf/aL4fDEOchYFC0gVnigr/N08g98aY5DhA
 BFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717308410; x=1717913210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cF7VGwzZSATJd42Bnpu8IHS9TDK3nVYlsIF3O02zmLs=;
 b=usdyWJERi3I0fs6wMxct+LgajwNXNe+Wj25/pFvFdGCI055x54WAsfx5c3JXOaaHTP
 jgB1DFA/Tjs6k3EgXOzWOJ/Uf5LZiThOWl2kSmlzWJQHMwjRsU61jnqyBEp7+YedOsgU
 sk3jlv4oZkYtu+XBUBoscaqIMAb2sFopxkWNeMgM/I6rfBmbqpSDjUZbSS0zRx2mjKqs
 w96XIIWKRGmMZKtMj8SPA2E26jEiL0Bfy6P7+WulxZ688iNGiXpTijX4bDBCKFtyCN7n
 6lL8CMiyFtt41xi6Jql/+Sc3y9zNw6XQvzei46x9mfOj9CuNwKbOMQ5LwM/WfmtBQc8q
 RyMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5cztzqWTh1UomQjG+ZlvTy4narNQvIR9iyOlnzjn4QuSjXHNXGwhPxmv2ebh0A+YcbFnVsocVObr2KeNW8rWi+zSQrxQ=
X-Gm-Message-State: AOJu0YyhOdeffwIQWEYoVuK5jMrYUaErrgFHoSEAnogX51cuwyJo5xpK
 KEnlBCoWW5ib15D8rTbDOR54I13bEpf7KwRuZieDhxguanz4bhfAx8VycaYGQEo=
X-Google-Smtp-Source: AGHT+IE0s5CDnzGuWOXxShnw5Jw3G+pEM9TELOZfsBDSwFin2zzweAHLnYbsRXyTn6YaxdjziZ8IjA==
X-Received: by 2002:a9d:6f8a:0:b0:6f0:616f:f186 with SMTP id
 46e09a7af769-6f911fa4adfmr7211201a34.29.1717308409847; 
 Sat, 01 Jun 2024 23:06:49 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c3540f55fcsm3466214a12.12.2024.06.01.23.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 23:06:49 -0700 (PDT)
Message-ID: <37ab9076-e555-4693-9e86-e3ac86dfae5e@daynix.com>
Date: Sun, 2 Jun 2024 15:06:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] meson: move shared_module() calls where
 modules are already walked
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240527104937.30443-1-pbonzini@redhat.com>
 <20240527104937.30443-2-pbonzini@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240527104937.30443-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/05/27 19:49, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

