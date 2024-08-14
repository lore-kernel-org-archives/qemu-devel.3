Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E67C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9pf-00010Z-2N; Wed, 14 Aug 2024 04:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9pd-0000yc-AC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:58:13 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9pb-00080D-Jy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:58:13 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f15dd0b489so82948611fa.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723625890; x=1724230690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxhpxIVKoc52ymfHFV+fmAj+WvCVuqmBol66ibL352A=;
 b=UiqPKuF3rRdQ5cCN4ZCmump7UenRODEQM+vQR/FYBQT7hD5qrhhwJXCkNoU76zk0xY
 /D96hX3VoPFOIxV3SA8p7vZtYstXsE7hXp0onD9fBUqG6Dthq2DdWXEcFNcETtxkQgNG
 l3w8Y1tGplywu3zDvrlS6c6Th6VBOF/zOjHNSsQNDak61kIrAQ09pfSHsRCb9kqIUlMn
 O0ogB3oymwx2h2UD8er4E++JDvhtGBxDtjSbIOYhUeN1LVa6A5hIHucdfC3rD/gSmMJP
 mXbHMbK3n1veMDNvKcmcx8A76K4nDkj5qjdEEP5WZBJHs7XDVzmtmnWwRI1iZL0E+ZRP
 Is/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723625890; x=1724230690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxhpxIVKoc52ymfHFV+fmAj+WvCVuqmBol66ibL352A=;
 b=NDNXOmSSWshnz4pS3BPfHHzLxVnRtyou9qNCfoM863psVns2yblkN2RMJUXcVF9LJS
 lIA/cGrUBqwrwa9RhxSjrK79Jff/a0HmAkai6SKy46HC9ui/97ZYeALXls7oYp8GuOL1
 9eWY4RsU7upytLXdZFOhncRsl/HiTN190rSswX6W6xVruveGqk+eC0TuaNl35pm/A1CA
 unA0DC6VfKaXCzsZvxgBgFjRq98Az//OjDowCvxP3Gl7CnKsGwT+dOmLvaua3QuO+j2h
 l3+RcIMEnKj+uepStfVxVs8BKeAgDHvvPPVbwR1h9HZKj7VZawvKYEVDNvk7XjSgoDNw
 3T2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPvbyPThztLF0IB4qat7HbDigeuvSUKx86WaogJJuW9obtHvMqZftxKkanHfkkl6DZ8BUWB6XY8h7apQPGmib8jBzJZV0=
X-Gm-Message-State: AOJu0YxSCdHZnoY13vlNb1juR/zANknq96Vf42l3+GIxWJD7u160XlhV
 G8ip3rY7ze6POL5ipL+y2JL52ka/R78M6CitHuZXj2321GAzmDVqpXhFJhUO5uY=
X-Google-Smtp-Source: AGHT+IE7x7ADt2vN28Rn8u/TTvW5ElvxBggcQO3i/awJDW2zbaWBBgqQK918i3L1nB1nP57f+p5K7g==
X-Received: by 2002:a2e:602:0:b0:2ef:2f60:1950 with SMTP id
 38308e7fff4ca-2f3aa64d93amr10148731fa.30.1723625889449; 
 Wed, 14 Aug 2024 01:58:09 -0700 (PDT)
Received: from [192.168.178.175] (186.170.88.92.rev.sfr.net. [92.88.170.186])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411b552sm145896666b.129.2024.08.14.01.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 01:58:08 -0700 (PDT)
Message-ID: <cb42acd6-4176-401f-b442-432f50ec5e24@linaro.org>
Date: Wed, 14 Aug 2024 10:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v3 1/2] target/mips: Pass page table entry size as
 MemOp to get_pte()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Waldemar Brodkorb
 <wbx@uclibc-ng.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240813135313.96519-1-philmd@linaro.org>
 <20240813135313.96519-2-philmd@linaro.org>
 <2580a087-809e-478a-b1e8-3aae9bf1c488@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2580a087-809e-478a-b1e8-3aae9bf1c488@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 13/8/24 23:44, Richard Henderson wrote:
> On 8/13/24 23:53, Philippe Mathieu-Daudé wrote:
>> @@ -607,11 +607,11 @@ static bool get_pte(CPUMIPSState *env, uint64_t 
>> vaddr, int entry_size,
>>   }
>>   static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
>> -        int entry_size, int ptei)
>> +                                     MemOp op, int ptei)
>>   {
>>       uint64_t result = entry;
>>       uint64_t rixi;
>> -    if (ptei > entry_size) {
>> +    if (ptei > memop_size(op)) {
> 
> entry_size had been 32/64, now you're comparing against 4/8.

Doh good catch, thanks! I'm squashing:

-- >8 --
diff --git a/target/mips/tcg/sysemu/tlb_helper.c 
b/target/mips/tcg/sysemu/tlb_helper.c
index 7050ea78df..3836137750 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -614,9 +614,10 @@ static bool get_pte(CPUMIPSState *env, uint64_t 
vaddr, MemOp op,
  static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
                                       MemOp op, int ptei)
  {
+    unsigned entry_size = memop_size(op) << 3;
      uint64_t result = entry;
      uint64_t rixi;
-    if (ptei > memop_size(op)) {
+    if (ptei > entry_size) {
          ptei -= 32;
      }
      result >>= (ptei - 2);
---

so this hunk becomes:

-- >8 --
@@ -607,8 +607,9 @@ static bool get_pte(CPUMIPSState *env, uint64_t 
vaddr, int entry_size,
  }

  static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
-        int entry_size, int ptei)
+                                     MemOp op, int ptei)
  {
+    unsigned entry_size = memop_size(op) << 3;
      uint64_t result = entry;
      uint64_t rixi;
      if (ptei > entry_size) {
---

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

