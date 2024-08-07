Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DFFC52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 18:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sblfp-0004ju-6G; Wed, 07 Aug 2024 14:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sblfn-0004gs-If
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:46:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sblfk-0008Uj-A2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:46:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so98295a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723056367; x=1723661167;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=veeAhpkiXHbDJbR7MUt6Adrx2FAUlHB3pWMaxf/ta98=;
 b=uzb4Q5sjPRmWo1+tc7zt3HFovp9wn/GvqZh/FLE+rDnRj3udsDhCHr55vXfOUsqAeO
 gWZplsPrATxFcFGcJW9WlVmbBX0FMCYNYjJHXRZ3tq8MQ8/PD9wcNUmqy0u94zPGt/D9
 /7gfyhOddk7eRWdDpo6riMuqxUiAT+W3sI1sJFAbGTDwtawe/qDtahyTb9uKTI/tQar9
 DwpVN8Lb22cWjt6veQSQGZbgy2409nQzA7fvR6XnD0Sp4GTD/OcD0sCfJoPmBxO1L9Gj
 5xWTQkOqFBCwmG7hihUxx8mQkXPQA9DSyGIU5Pfg0FkZfIy5/OXpCiI5DpisuBJk/vHR
 i4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723056367; x=1723661167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veeAhpkiXHbDJbR7MUt6Adrx2FAUlHB3pWMaxf/ta98=;
 b=MyXCQi6HZwMP8wbhibGSUqH8ZZZ/hUwYSVcgjlT8lvQGFXJkgFGo6u/D2GSm21UJ1A
 XMow0rtUr84SXVL6hUveJsIV7cXVj2MIvnHdr3sf7l8MR2nrdM1BMkFYLZbzXYhrLIWP
 i6/FA9izURPoUUZtr95G2Pgq2vmIUFqoHB5GH9M4HLbx7LN+iuLzyuvaSIXISbs9bCDM
 /hD/HGCWExrqUEbVdSuEG2ts1nT3yKsT9LxftHwA1mIxWTN5sFslqxcEd1/ZuJp8R1sI
 //7MQknxhZKsOze+6JlzZSc8/UEM8rv4YZfhyEQ/7N1Zi/m7QV4WQlc2z82Cdg+PT3KX
 VLag==
X-Gm-Message-State: AOJu0YwJID3puQri8K+kgiD+xAYE5d1x8IO/B0nc09DCdh3VxiU2eYlK
 gtegyHneD72nz4O6d5PLHeiulim8DxF/k94pXQW8fPLAypJDo5mo+qUHpRBJJfY=
X-Google-Smtp-Source: AGHT+IG6X+pntY3MMDnQr2s2cprjSL15IGFycdf82EuUa+QLRS5IK8Hmf4suU0LOBYvRHIjAtOKdAg==
X-Received: by 2002:a05:6a20:8727:b0:1c4:8876:2ae with SMTP id
 adf61e73a8af0-1c69966e83bmr14693923637.41.1723056366454; 
 Wed, 07 Aug 2024 11:46:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b764fba58bsm7381953a12.72.2024.08.07.11.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 11:46:06 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:46:04 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>,
 Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 03/20] target/riscv: Introduce elp state and enabling
 controls for zicfilp
Message-ID: <ZrPA7KAQawdqE0mL@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-4-debug@rivosinc.com>
 <bd2f7f31-966e-4bec-a4be-8c030d1ac4a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bd2f7f31-966e-4bec-a4be-8c030d1ac4a7@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 10:56:12AM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>+/* enum for branch tracking state in cpu/hart */
>>+typedef enum {
>>+    NO_LP_EXPECTED = 0,
>>+    LP_EXPECTED = 1,
>>+} cfi_elp;
>
>I know this is language is in the spec, but would it make more sense to use
>
>  bool elp_expected;
>
>?

Sounds reasonable to me. Will take the suggestion.

>
>If not, Coding Style requires CamelCase for typedefs.
>
>
>r~

