Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDB5D4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjXn-0001H6-KZ; Fri, 16 Jan 2026 08:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjXm-0001DK-4J
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:07:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjXk-0002oI-GH
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:07:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so13310415e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568830; x=1769173630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aK6F1EgfZptbCPZgXYn8tipK+fFZWaRkgMvTrJ6JaaA=;
 b=CvQVQBucHxy7ZEw8clkGWyWJEsyLCPZrkJdCvgoe3b2TYvNAExSWuILUGA1orMTiz3
 hLsTpy2TMLlBCF6m49YOiswpQ42mRQklEKmck5sB5JGEIkLCk9eWAazLk9/0UyK5IM5c
 8nFJTEf7iswb8KNZEPsytY37k/iXvgCjVRf0kklS/1RNB41yNNy1Qekjnuu04+Iga0oP
 QT0nvNZ0BJZll2KBzmh8Wg/Lwr6iIdROnpk86gKt7+zZD2EEv5QTLTDup5huCXzjgnmv
 EjTaJNxNFZvBV9IcwQACbGa3IXXf38svV14A2XDFNnwhL44gDkikHyPCt+sa7X5jpjWm
 t/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568830; x=1769173630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aK6F1EgfZptbCPZgXYn8tipK+fFZWaRkgMvTrJ6JaaA=;
 b=hhUGOL/54z2GdzHyt+pYeGXOWpyH3e8hokCEwTU8UUlo0QzTtNzOOOSUag4/J9qamP
 P/uVPdlF3RuRdfsTxBo59g0vr8BrgmH0OVbvrxLXDKa5IqxYmsp+tWFrLKCE5AEJXjjx
 1UQnynnoKvyfIAe4X5eZQe+m0Eis2WEXdEh2FFiGEu9LrmzwQctQZ0kt3SPLNh8zyRJt
 MPIFU2MsxKLLOPZXXnw6bT91xs2qqiEwSx/hZsxQxU0tpJnsblvR9XLmN4hW0/FEUgq+
 3tO9GV2sS+Fu/vJtlAPUOAoozcqaoJ/roD9hYgfnEcPYG7FAfNf2gC8HtbcSEIiWu+yM
 PKbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/lnLltfhbE6N0yeSHine4jiV985wthx/ND0cQ2APeQNHtXHEDYugl9ppQKA/FwKO+T6HGy8dFDGEk@nongnu.org
X-Gm-Message-State: AOJu0Ywxfm+hYazG+/Gd78l1DPVhQmnt3Hgu4+U3KWFRLS1t4OkCF/T4
 EC8VbZ+wegiN8QJqNnettn5fq9aoXbYqNw9RJRMqAjKDp9QOXGTsy+gt2M6Eh0Ny3Vk=
X-Gm-Gg: AY/fxX4/2BpIKobZMBP71SbKY5htrVgA+c3pLH67RpjASpT9HRjLG+S/fQbakAf3JTu
 CRjMwxAUBcbrZAFjahu3iOxKMv9iZo4Y8qpZmSXm0EloJ6fAsxcT/7KvOctfX58QaHIkgB1EXlf
 /T5ZS8sKLdvgyLYJs6sfCZ98chW2M6fEAW28GUHWD8a3sHB1tS9ivFS01zFNJt5NZ0hRZg27Qd/
 k6M7fHY2KBfCzEj5jLulDHzPWH3hu/AS6Tv9IOD9FemzeMYwMQWX5qdmo8AgBXp/jhXZuw5mHa4
 JI//FTS7Or9uFYNbG5Ss3gVKw6W62lpzZevO4h0PaV8kniO53WuWay3dCkq+K5qX9ZkJjOLOR3Q
 C5qzMNt03Yx3knfIjkIUmsC2clpc66y1IQnCWU0FfcL7BtzaJ6Ti2By+LXslMaSu+LFEq1CRr8p
 JeXIh40SX23QtB4JJIRSP4TRHyLd6SsmSBgjuXX6XbAp2d8GhsQGyRMQ==
X-Received: by 2002:a05:600c:4f15:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4801e530d15mr37698695e9.3.1768568829900; 
 Fri, 16 Jan 2026 05:07:09 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428ac749sm98825715e9.5.2026.01.16.05.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 05:07:08 -0800 (PST)
Message-ID: <68340e51-1d33-424d-9e07-ac0820a7faac@linaro.org>
Date: Fri, 16 Jan 2026 14:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mshv: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
 <20260116125830.926296-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116125830.926296-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/1/26 13:58, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes '--git' 'mshv' 'accel/mshv' 'target/i386/mshv' 'include/system/mshv.h'
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/mshv/irq.c            | 3 +--
>   accel/mshv/mshv-all.c       | 1 -
>   include/system/mshv.h       | 1 -
>   target/i386/mshv/mshv-cpu.c | 1 -
>   target/i386/mshv/x86.c      | 1 -
>   5 files changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

