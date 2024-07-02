Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43375C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOggN-0002bJ-Ph; Tue, 02 Jul 2024 12:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOggJ-0002Yi-Ne
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:48:40 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOggI-0002Yu-12
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:48:39 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-726d9b3bcf8so3242292a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719938916; x=1720543716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QoQraaUvksne9lvI2gwP0oQnXURXrScHT/MvNUuRmJo=;
 b=RGbVjLiRVhq5vcuCyZX5TpkcDh5JFXRINfJqOMv45zjhxlS06AR8kQlrbVGztzGjqH
 cCTC+sHWXowo8QcXAUoyJiWBIcSsOQLkIGrCf7P80CiWh97Fl+GUv62YyQy3qbOTgpLE
 2MnUos/+WJje+qpE2KKEMXbdQqkiCWmv0M+pIgvj3S5jVQwQNGZO1O83kepA2J61ELGS
 xnErv9MMkIaCUz8QKWoEhXpPWhTV7BVpBPirnkan1ja+eTAKly/Vri3LeeP9f8l12dyC
 hjsGjQQlWutYovKSd/PD/Q9v7q3Z+5nKPAIGJNvx3TknApHj2+Ac0ab8l20DEyPigfeM
 uCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719938916; x=1720543716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QoQraaUvksne9lvI2gwP0oQnXURXrScHT/MvNUuRmJo=;
 b=qta51caI4nz4WVbOzl9eMgoEXxYq5lRWqRclYDrUMnbyDOqT8KYE03n3b2grMwKrcJ
 ZIKcoSdBnin51nq7BKV+LBfwHWPFiVuszSWch97CrNkpWvGvdnG/8SNgXsFOon+/SIIG
 wJD1k+zawti76QESF0SNVPoWgSHKZ+nbiCR3M5bYBySCeDG0jmDagICBQxFAvVJIB4Zn
 sMKqI9TjTukhWo/zEpi/6Hf6Nyhb3DaydATmN8T3wLRTozLWjwIdk3guy3e7fae6Gn0h
 QKEGLGu3dX7Lt6RDeYGVTr6dkYilm4x+0V3yYooqI1t1hBdTSFWSo8DXC6udCpvex+uy
 Pe4A==
X-Gm-Message-State: AOJu0Yzf3xUg2bjDjcInhMn5gWXUgRxgTXRKnYTrUEZS9vJeoP1iU/6Q
 OUXlLEIwqJWgJNNKP0Wm/otCR7WsVbw4a0UhuMWBa+YXQ3LTCzlncx1S5SsXjTYG8NQXITGdYrx
 y
X-Google-Smtp-Source: AGHT+IFEZF5CzCYXCKeaXCkTF1DpFqvbQQEGPjQeMo8dIfnSxZoBCMKG0dP9zDZ8nVCOi5KbSG/NHw==
X-Received: by 2002:a05:6a20:2d11:b0:1bf:1158:1e5 with SMTP id
 adf61e73a8af0-1bf11580450mr7106106637.49.1719938915475; 
 Tue, 02 Jul 2024 09:48:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70802b495a1sm8964284b3a.92.2024.07.02.09.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:48:34 -0700 (PDT)
Message-ID: <5f52f7a4-1146-42a5-9485-09ad9192df4f@linaro.org>
Date: Tue, 2 Jul 2024 09:48:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Use cpu_env in cpu_untagged_addr
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240702154911.1667418-1-richard.henderson@linaro.org>
 <87ed8brdjo.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87ed8brdjo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 7/2/24 08:58, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> In a completely artifical memset benchmark object_dynamic_cast_assert
>> dominates the profile, even above guest address resolution and
>> the underlying host memset.
> 
> We seem to use ARM_CPU() quite liberally for a number of helpers so I
> wonder if its worth codifying this anywhere? At least all the direct TCG
> op helpers take CPUARMState *env directly.

For things that are akin to virtual method calls, i.e. the function pointer comes from a 
table within the object or class, I think we can trust the lookup.  Therefore no dynamic 
check required on entry to those functions.

That said, cpu_env() is relatively new and we haven't made a concerted effort to use it 
everywhere that it might make sense.


r~

