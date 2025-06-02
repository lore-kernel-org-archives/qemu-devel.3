Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26B8C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 15:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7Ye-0004xD-IC; Mon, 02 Jun 2025 11:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uM7Yc-0004x0-PD
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:58:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uM7Ya-0005jT-MM
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:58:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so13296815e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748879915; x=1749484715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKzjlRRjdfwTk+3ST0iw9swhI/Ohpa+RiuUs3EmPmK0=;
 b=ygdzEf02JGgdmQObb4tN8u400N/QFjWanTo3f42r3sjUIjDj+16RF/wMlz9G3gvJ0+
 4YZMxsy6RRqJGix0yl65itfTZ3nOShsXdO2LKXHyMno/kKxWP1M4g9kXFhySa4dCNvhd
 4E8DWYpCwD4J33a1+BYmC06VBp1L1B0SH3AuLtMIV+5BFIVPQ+gLYcec6B//eYANu7iS
 vd7Q4Fzcd45ecI0ON2uOxbn8GUqxvs56Gk8Ag1IoNj6ufS3Zm/cGVOKgWO0k6U48VJIy
 nQOpi21H2fjkL26H9OyByVROuomcBXk2mthNbLNYwW1IarTqXg8XmWlrOe7Ajl0drMvf
 gZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748879915; x=1749484715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKzjlRRjdfwTk+3ST0iw9swhI/Ohpa+RiuUs3EmPmK0=;
 b=kr3bDKAE/bEVV2VHgoYNMFJ++2ggTHbpLbKQi4/YaygnnZW2qDprEYsRHfLTeFWZPN
 RTjaAR/EQe9rnV3ghVRqC1XSoBClnRy4jr7Jx7VAef29k1uuN4kH/4Co3YHkbp70T/nJ
 2C9RJGNyzP66I7+rbK02Um+SNDd0Qv1rs3rbMDKwRA1jZE51JnoZbJdcTBdkiy6tfKqS
 wmufXMK6sVTjDT9nOXWSwh5L0QEgirTSer8vfmekmqS1ltOZCXqPmy3bPXoN+BOCCyHi
 txPCg3bIwHbWlAOoOQPYBy1Zs/lI02fFfk80Ok5G2G6Tmo1B5f4s4mjTwp1WjKO/QlqP
 O/uQ==
X-Gm-Message-State: AOJu0Yx1rZWAnSwX6GOILGv5N7zBAb8xM2lCBT6USd0Z9lAouYmiJ5Ra
 V/Mf00vYAgxUr1m05DkUlRhyzO2kID/ymxY93q7q1hsRQOngRedLh7t/kxtWm4MxuiE=
X-Gm-Gg: ASbGnctn5aJiF9vb0PWje6gMVBhTJqTSLLBCEKLLNHfnR6I1m+J7gpSjkxq9NSmqnEd
 BbnIxFwrRzZJtg44xRroP9Gsqw/9twKLD4vvF2XpZdhStwULq7/i8f3jC12GFCRJXLfY1KAkfqo
 3t+iJW5FgBmZlCsG4tUW6FlkIFDN41kx4lEGLMW4iIbyCUSQvTLbfnC2UsXqr4L9r4D+aLtQLa1
 YYPBQ8g+cYiYI6kQYTPnIdw/dEXhJC5U+2wKeF1FOcguR6+vT0kzsWnDcvaMfqBMZ9imNuXv+92
 KyKZMHTM14B8b6/FC1LWOBpuM3MYmJyyQgEwmeshSCr6fxvNeq34HItZ1XMTPCpr6nwXLCI4eb2
 f2t97M8gtU5eCUU7W27AM
X-Google-Smtp-Source: AGHT+IHXG/y1txL4geBbeFb9BdX5sDNwysNX3H70H3aGjFRjtFZC2GhsPEu93dcS9nKWpz+sM8iUTw==
X-Received: by 2002:a05:600c:4e10:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-451191fd314mr80721775e9.4.1748879915027; 
 Mon, 02 Jun 2025 08:58:35 -0700 (PDT)
Received: from [192.168.1.127] (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb8751sm125846745e9.29.2025.06.02.08.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 08:58:34 -0700 (PDT)
Message-ID: <6a89fada-6d79-4848-9d10-2b16e6e56bf0@linaro.org>
Date: Mon, 2 Jun 2025 16:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TCG Address Sanitizer Optimization.
To: Jon Wilson <jonwilson030981@googlemail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
 <87h60y41u1.fsf@draig.linaro.org>
 <CAJHT5-+tAuCoDV2G=-bZfP-j0gvY8Um-8TO8un2uNSGZpA1pcg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJHT5-+tAuCoDV2G=-bZfP-j0gvY8Um-8TO8un2uNSGZpA1pcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/2/25 16:54, Jon Wilson wrote:
> It would be good if we could have QEMU provide clean APIs to allow the sort of additional 
> instrumentation that fuzzing requires. I guess the qemu-libafl-bridge project show the 
> sort of modification which has been required so far...
> https://github.com/AFLplusplus/qemu-libafl-bridge/tree/main/libafl <https://github.com/ 
> AFLplusplus/qemu-libafl-bridge/tree/main/libafl>
> 
> I would like to conditionally call a helper, or even just insert a breakpoint instruction, 
> but like I say I don't seem to be able to make use of any sort of branches. Even if I add 
> a benign instrumentation that simply conditionally branches at a label and nothing else 
> (e.g. no actual functionality), I still have the same problem.
> e.g.
> 
> ////////////////////////////////////////////////////////////////////////////////
> 
> TCGLabel *done = gen_new_label();
> TCGv addr_val = temp_tcgv_tl(addr);
> TCGv zero = tcg_constant_tl(0);
> tcg_gen_brcond_tl(TCG_COND_EQ, addr_val, zero, done);
> gen_set_label(done);
> 
> ////////////////////////////////////////////////////////////////////////////////
> 
> Hence the current implementation is a little clumsy!

This has not been a problem since 438e685b1, in qemu v8.0.

r~

