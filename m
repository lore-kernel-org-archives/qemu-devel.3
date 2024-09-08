Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD52ECD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 21:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snP1O-0004gt-Ip; Sun, 08 Sep 2024 17:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snP1H-0004gA-Sg
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 17:00:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snP1G-0006uy-Dl
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 17:00:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7178cab62e6so3267902b3a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725829225; x=1726434025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYcXw7KAFe701pdxJkA3FIMYRwY2CTccFo9bn1ngbYY=;
 b=jtUDsgIWgBahaSYEc6CrrERTnWZpKoUFETVDd4NthE5OsJCI9QnG2J1qLLEa/X84FZ
 Ra3ECkOjBrOpkOOTg5DvIH4wWBOlUW4tHkp+InEM5zaLtS5ETxPMlL9TPNjG/vmpt3vu
 N0yDoJlOQ5+Yj2EmBIO3p6jy6MGo37Xq7P/CjXdV/6PLcUcCUzo+fpNWSY3XLWP+n8wy
 NKmPwath2V542m5+fJ5L3tVtF9Wg2Nxc3JIk83zhggtxOwHjc4YV8m+Qf0U0/w89btUQ
 KKEVLR3vBAA81E5AB4JNBQ13OjudPWkeZUBCg4sKhGOWmsitMsaPyVp5R3kBPPhT4fi9
 psrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725829225; x=1726434025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYcXw7KAFe701pdxJkA3FIMYRwY2CTccFo9bn1ngbYY=;
 b=asLO04pmS5CAVDsDLa1kepjEX8IApy7BAYC8U6NtItEEyqpBiYe7PE0iAfTyKAcC97
 9ZRUCf4grbPi1S+Du6o1+wepP5j5l9v5QVQsrD+o0XqeNVa9/9EriALWzqg+HigHZd9I
 d+FnhQk61Esi44nqa6zPyJ1wUDu1UgljTwUxscAr02tfeElZUo212bQ1+bTKwgF/0ig3
 ds6M4gOpsw0MxWUqEike0FwWc4NQy0TP/WBxJ/8ZTXzLdskEvBSgzN9v3upxnhx3A5Nr
 LMqndG4IL2GF9SOHAMqOh9a2Pd7CEpXBT5x/6en3AP/JnSCK9bWrbIjxpK9LRgi9pDlW
 oDbg==
X-Gm-Message-State: AOJu0YwZI3+zDxLDpyqhpUNl3RWUyU2/uWfnddSPI++Qvicsv3HwZkXR
 HES6iflBm5eAgDvoYAv5js1yP8DFeRkBb0m7Ln8VF1M9Ku4iuDUp+2GwDgegFUk=
X-Google-Smtp-Source: AGHT+IHG/T66D/FCup5Ahf/BJXpUM6uIkYt/g+Zy4LLHYUuJyE5c60FEzvNUKJyjV99wsr2T2XauiA==
X-Received: by 2002:a05:6a00:244e:b0:70d:2b95:d9c0 with SMTP id
 d2e1a72fcca58-718d5e55d73mr13914923b3a.14.1725829224814; 
 Sun, 08 Sep 2024 14:00:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58c68dfsm2372925b3a.81.2024.09.08.14.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 14:00:24 -0700 (PDT)
Message-ID: <d1798b81-d288-4345-a8d9-639db461c8aa@linaro.org>
Date: Sun, 8 Sep 2024 14:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/i386/gdbstub: Expose orig_ax
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240802095942.34565-1-iii@linux.ibm.com>
 <20240802095942.34565-5-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802095942.34565-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/2/24 02:59, Ilya Leoshkevich wrote:
> Copy XML files describing orig_ax from GDB and glue them with
> CPUX86State.orig_ax.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   configs/targets/i386-linux-user.mak   |  2 +-
>   configs/targets/x86_64-linux-user.mak |  2 +-
>   gdb-xml/i386-32bit-linux.xml          | 11 ++++++
>   gdb-xml/i386-64bit-linux.xml          | 11 ++++++
>   target/i386/cpu.c                     |  1 +
>   target/i386/cpu.h                     |  1 +
>   target/i386/gdbstub.c                 | 51 +++++++++++++++++++++++++++
>   7 files changed, 77 insertions(+), 2 deletions(-)
>   create mode 100644 gdb-xml/i386-32bit-linux.xml
>   create mode 100644 gdb-xml/i386-64bit-linux.xml

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

