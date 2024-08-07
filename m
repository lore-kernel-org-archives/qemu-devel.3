Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE46C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbW37-0004mQ-5f; Tue, 06 Aug 2024 22:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbW35-0004hn-7C
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:05:11 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbW31-0007fk-TL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:05:10 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db1270da60so803642b6e.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722996304; x=1723601104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+e+KI8gL84IdpdoGhjHYixYDmaDLmIRXaSXykx7u0Q=;
 b=DnpAl7mlrLF71+0Cpb/890GUiP1ypbqh6dn2en+tzSNLKsnERS+fbRi6GE+Hrm/IT/
 5CJf/DxP2/MMhIy1B051LJ646AyJxlnb7RzMp1QUANSmXBwm6Gf+WjpqUJX40d9gzaNE
 JCcOjsSpFWKVuJpszqW8zjTncHshuvRsY26KMqdqKivxIdhJongOzyUqqFfavEG5nlkA
 PVeasGZM7h7/en+FjTF/s1mWM4kt3QW2oGqmOIm9O9JLUeLY6GKgkyFjcH/waA2wbVUQ
 ouEXxa4vnY7yDonQR5hBbCIRY+IFdOi5ikP/AidbKruWTlEZEag10991YB31aiUZCDdC
 BLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996304; x=1723601104;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+e+KI8gL84IdpdoGhjHYixYDmaDLmIRXaSXykx7u0Q=;
 b=CefIJU2mHznO1z6f1GquUX2RYsjkZg563CGDFGz700dI6noNHDuQ1pKEKVNSi3Xx6r
 j9twopoYrlOoFo3bcgtO57YTs9Nq4SXUUOgdpQ9bZzmfXb5/TnMIhVb+AxeHzEg4owzc
 3xeFW1xAqg6dV+6C2GxhVv4AUu2eMh7BXVpFL+8dnOrvW20EvtHIkAZ1hwDeWBxrErMW
 ZxOpAPJPoOEMnadgY4lVXAhLoXDJO1aZpxRvGJCjXlDm3rmKioblQ28biLk2zZ+v3zIa
 poYbyDWAoYs1gd4AN1GTpnex0+bpN5Y6ybt+Cx5yc1RtiVI7z3CqXE4/uRLE1WqbLT7n
 nG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXESEUNNI8O13EJquejMFA05/rh2ewjgskKxbxW7RLgQK8h6mFJ5BUMtxozQ69R0AjXTcXWi0k+KlYzWRVHROy3sKGhDgM=
X-Gm-Message-State: AOJu0YzTzU9OYNsoLmJ/M4AGWXTycA7n5yVbtlW95i+l6jvbIQ+pTTiB
 G5SQTky9uJDqindrIaKJLFZwYsdCrSzI+5FHXfrhcQTL7vKJYYK4O75peOXCe9U=
X-Google-Smtp-Source: AGHT+IEhhSpdCJDnztDAetioufogMLmegX+2+V9LzSHuu5c+sNwM9462uLMNqRVLQnlSbOhvZHKSOw==
X-Received: by 2002:a05:6808:1495:b0:3d9:2aa5:4077 with SMTP id
 5614622812f47-3db557fc3b1mr23098985b6e.5.1722996303974; 
 Tue, 06 Aug 2024 19:05:03 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b764fb53dasm7351428a12.65.2024.08.06.19.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:05:03 -0700 (PDT)
Message-ID: <1578c6f7-23e5-4077-b4ac-9b3af4b97dcb@linaro.org>
Date: Wed, 7 Aug 2024 12:04:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] target/riscv: zicfilp `lpad` impl and branch
 tracking
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-8-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-8-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/24 10:06, Deepak Gupta wrote:
> +++ b/target/riscv/insn32.decode
> @@ -40,6 +40,7 @@
>   %imm_z6   26:1 15:5
>   %imm_mop5 30:1 26:2 20:2
>   %imm_mop3 30:1 26:2
> +%imm_cfi20 12:20
>   
>   # Argument sets:
>   &empty
> @@ -123,7 +124,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>   
>   # *** RV32I Base Instruction Set ***
>   lui      ....................       ..... 0110111 @u
> -auipc    ....................       ..... 0010111 @u
> +{
> +  lpad     ....................       00000 0010111 %imm_cfi20

IMO, better as

   lpad  imm:20 00000 0010111

without the %imm_cfi20 indirection.


r~

