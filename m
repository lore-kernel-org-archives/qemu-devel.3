Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7239EC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 15:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdWx7-0007bW-7O; Mon, 12 Aug 2024 11:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdWx5-0007ab-Qu
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:27:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdWx4-0000OZ-0G
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:27:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so5567958a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723476436; x=1724081236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rXybKHARfQDWEWFNdraxZRcs71tPfZSQTZtSXdxb60Y=;
 b=gFugrjX4RpWwSv275/graoTzpPnIgpj6NG0T+Lxrvh/OZA2j6hQlxPbTWmGsfifmhB
 pVhtnQlxP/s05Y4c+x0Jcz8BmB1OIZr9lw3MsC4/55rs5VGqJdAR2Ty/HerjwVbL4h3+
 eBKLHZ+Lfby/lz8ecb3mS/5LQWlpQ9bPqmGmZ/kqw1Ys7n+PRq1nkbqMmJ5qdYpfwWDx
 kRU00OBVSGDBX75ax/gEjtX9+gCg7860Xx6gpRiOu893yIelY2i40GENdnOoCfToPqf6
 BGIjrSJtdtkuTFJVk0ex2sT+T8imMs/hVqNEFhyCR6P7j6Na01HSOvT10jaxrEqDPktH
 2JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723476436; x=1724081236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXybKHARfQDWEWFNdraxZRcs71tPfZSQTZtSXdxb60Y=;
 b=sQ2ETJGVzocPpA9o7sUBzMH/B/1SW+KpNr8l2KrdsPBUOX9i6oR8rkrvVmzIlrjft/
 AVhpMm7hFlYu/VPfJNqLxgDGmQOHgek6WUqW8zQHL8KimZTIN6JtfTEPHbBpxbp53f/Q
 LNtA6T7Pc/M41Q7LdrCLF/xS33t3nuLynQBsPUptSGfwRaUQi3uGJ/SGDsnfbprGLr8f
 bSPUghCrne++1P1YKwAcC9HOsRwV6yp2ZjnGVeN5iqYIRSf+sP2FXqDTwxS1xqMrxFcN
 P+LiHj4RDxlwuEnkxtVv87CdjfS45YncFFFFWWFi9nvOayRPh59SEehUmcgCEUquKPI1
 WSbQ==
X-Gm-Message-State: AOJu0YwXGZlaRHbxBbDEHOwdi9GLyzuWj6sW0FRFCGd6cjuVI4o7ou0K
 bwjQKJbLbAXN3VB+xlPC1pot4NrTrp76vSbIne1U20xgBkCIeDSi7lNlx6Eb41W6FcjU0vUQ4RY
 ibkJ2PEjkZxLGEZTFF0PDYU1LJOR8AbGSXxHP4g==
X-Google-Smtp-Source: AGHT+IEeVe5yhkoJJz3nU3VAeKWOdOhMHqBxuZRyy5yobEKnlXsreTjzSBYW80uQd548cXGqNogyUAGIe3FuaGJTldg=
X-Received: by 2002:a05:6402:26c7:b0:5a3:3062:36c7 with SMTP id
 4fb4d7f45d1cf-5bd44c0e442mr559593a12.7.1723476435835; Mon, 12 Aug 2024
 08:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
In-Reply-To: <20240805201719.2345596-4-tavip@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 16:27:04 +0100
Message-ID: <CAFEAcA82c_RZ6512dB1OxpAtinRctkZK7ZyjpxX16Wk7DYZDPg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
>
> From: Stefan Stanacar <stefanst@google.com>
>
> From: Stefan Stanacar <stefanst@google.com>
>
> The CMSIS System View Description format(CMSIS-SVD) is an XML based
> description of Arm Cortex-M microcontrollers provided and maintained
> by sillicon vendors. It includes details such as peripherals registers
> (down to bitfields), peripheral register block addresses, reset
> values, etc.
>
> This script uses this information to create header files that makes it
> easier to emulate peripherals.
>
> The script can be used to create either peripheral specific headers or
> board / system specific information. The script generated headers are
> similar to the SVDConv utility.
>
> Peripheral specific headers contains information such as register
> layout, register names and reset values for registers:
>
>   typedef struct {
>     ...
>     union {
>       uint32_t PSELID;              /* 0x00000FF8 Peripheral Select and
>                                      * Flexcomm module ID */
>       struct {
>         uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
>         uint32_t LOCK : 1;          /* [3..3] Lock the peripheral select */
>         uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicator */
>         uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator */
>         uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator */
>         uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
>         uint32_t : 4;
>         uint32_t ID : 20;           /* [31..12] Flexcomm ID */
>       } PSELID_b;
>     };

Bitfield layout in C isn't portable, so don't generate this kind
of union-of-a-integer-and-some-bitfields, please. You can
generate FIELD() macro invocations (see include/hw/registerfields.h)
which define shift/mask/length macros that can be used with
FIELD_EX*/FIELD_DP* to do extract/deposit operations.

>     ...
>   } FLEXCOMM_Type;                  /* Size = 4096 (0x1000) */
>
>   #define FLEXCOMM_PSELID_PERSEL_Pos (0UL)
>   #define FLEXCOMM_PSELID_PERSEL_Msk (0x7UL)
>   #define FLEXCOMM_PSELID_LOCK_Pos (3UL)
>   #define FLEXCOMM_PSELID_LOCK_Msk (0x8UL)
>   ...
>
>   typedef enum {                /* FLEXCOMM_PSELID_LOCK */
>     /* Peripheral select can be changed by software. */
>     FLEXCOMM_PSELID_LOCK_UNLOCKED = 0,
>     /* Peripheral select is locked and cannot be changed until this
>      * Flexcomm module or the entire device is reset. */
>     FLEXCOMM_PSELID_LOCK_LOCKED = 1,
>   } FLEXCOMM_PSELID_LOCK_Enum;
>   ...
>
>   #define FLEXCOMM_REGISTER_NAMES_ARRAY(_name) \
>     const char *_name[sizeof(FLEXCOMM_Type)] = { \
>         [4088 ... 4091] = "PSELID", \
>         [4092 ... 4095] = "PID", \
>     }
>
> Board specific headers contains information about peripheral base
> register addresses.

thanks
-- PMM

