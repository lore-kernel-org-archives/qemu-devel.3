Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2DCFEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxas-00081y-JV; Fri, 27 Feb 2026 08:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvxaq-000819-LH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:09:20 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvxao-0004pH-3U
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:09:20 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso21534185e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772197756; x=1772802556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QnA1dtsYm09c7k2K5qTF6yo2m4/YXUDluRufyWk2hkU=;
 b=tT4C0UfQVjp8lvgaDVdaY4qMt9w9MGRzLv7BLWEwEm5oH6hsBosiALrUSMM2y5G+Fh
 VThymmyTKUKNBw/l6VZFwRz9BZ0HVw2vlWW0bgRCe45kWJu2POtk1uDA1EMgmpR2IVOM
 IOE2J60NQkVVkENJdPbIAwkBxIPHFl4sabLjTSUZTRUMwLJCCLt1A05ZPT3QVn7rKT27
 oYjPIBvN5n9FhaGcRm7uA5ovaJmMhraFDCWr8NwZFCXWl6v1kpWGgXbPE62nOj6f2oBe
 IZhl0zmHtqPAz6ecYyRTAZr/4C9aAJxO4/tG9WkxAkDlmsH6REsmFjPumAx+ArVf+FXM
 WtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772197756; x=1772802556;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnA1dtsYm09c7k2K5qTF6yo2m4/YXUDluRufyWk2hkU=;
 b=ihGw7opBdNkP2aWuWWdNhu8/6m/mqahxgoU5opAMUgTrgChrRpYj23kbWbiETJw+15
 v8mn+rI36HDB/ERk6rBcsoKtXz0NMe5hdGwlXoluOjPKVO2hswUE9q/dpRA6KiVigSg1
 29TPSla4edCJwXXdJWNcHKM2/GetufqMMCs1GdWeDAYBrtDP89GhHhAcAKGeybXPqUqP
 Rwk08OuDvpJD9RH0YUCFRwcw+CC6cFycGStlSqTH264d+c7H+quE0ZFdpnLK6zlBgwcI
 7XJpSVh4+9Ab/fc7iO6i6RBlV4niKB9ej3aULzeRm5PZKMp6VmcHnU+s7lORv8tZx2Jm
 V/SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMO7pchAj66vBg91/Auzqdoz8jjssvlEkrqpUDEe0EWYxJBlbLXK+7XUJAaOaB7y3FYb5nqWVzB/ci@nongnu.org
X-Gm-Message-State: AOJu0YwX4hgsxn3dOpo0+iN5Am9lJh9uu0KR2v38oXdps36+iFHjZobx
 QXPsd+EFX+Es24ENQFPMEsU89k6GDrYz3usCQ0HyxzlpltbntX2VFkbYIXzP9HhZ9QQ=
X-Gm-Gg: ATEYQzxvC5Xs5uzwoMVEth1cNhbfpVb8duyyWch11Kd0nCJU/+D0XH3uAZw1FyhK74c
 +pVnZIPv9YR/IXUNS6zpFg5/C0fZSyjXSftBaTQ0tqC7nYOJJlEEhShY8T754Es07livudDCLis
 j6/+iMhMzUXi9TNhUT9tKUvxd3uxUdW7DDnWShhCc0eHbLaThUQ1wrNuhyktDZQ7fFS8GK6pS09
 o73Qb1Ho27ZM4d83w7BEz/TVw+nax6hqee1fUQ3y7fAiatBMn6WE0tUfP/90plSxOSBkWWgcMId
 2jZjtofOxxqRO0SfC9faS+ZYIfBKC1QotXt5WZ5OXw7/7hZCvwPujbb3B1D/fTJGWHxWQTkF+xm
 KiW0aYos0ki/dy9O4fLfmuJr9vvINlIaUqdKOO47ZtlxPcSLT/cbP1v5VtGo02WqYpWG3+9AuwY
 3v7NR+wXDrTx8fxrm6/8T/s/IENB6dqgwashsQzB9Tj4xrARkDu2bnmHeI4V1/nh9PTw==
X-Received: by 2002:a05:600c:1e89:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-483c9ba37b1mr43228685e9.15.1772197756273; 
 Fri, 27 Feb 2026 05:09:16 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm216106625e9.10.2026.02.27.05.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 05:09:15 -0800 (PST)
Message-ID: <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org>
Date: Fri, 27 Feb 2026 14:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc-linux-user GDB stub broken
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/2/26 10:58, Philippe Mathieu-Daudé wrote:
> Hi Florian,


>> on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
>> gdb stub test fails for ppc-linux-user when running "make check-tcg".


>> I've debugged around a bit but I don't know my way around the gdbstub
>> internals enough to propose a patch right away, so I'll just summarize
>> what I figured out so far.
>> 1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
>>     set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
>>     function, cpu->gdb_num_regs gets set to 70.
>> 2. When the test tries to read a register in gdbstub/gdbstub.c:gdb_read_register(),
>>     the first condition of "reg < cc->gdb_num_core_regs" is always false.
>>     Also, the register number for fpscr passed to the function is is 103,
>>     and cpu->gdb_num_regs is also 103. If the register number is supposed
>>     to be an index (as I understand it), this would indicate an
>>     off-by-one error somewhere.
>>
>> If you have some pointers on where to look / what to check out for
>> fixing this, I'll happily try to work on a patch. But I suppose that
>> somebody more experienced with this could probably fix this much faster
>> than I can.
> 
> I'll have a look.

Short term, this seems to fix it:

-- >8 --
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 90f4b95135b..0b0a5d1e044 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -610,6 +610,10 @@ void gdb_register_coprocessor(CPUState *cpu,
      guint i;
      int base_reg = cpu->gdb_num_regs;

+    if (g_pos && g_pos != base_reg) {
+        base_reg = g_pos;
+    }
+
      for (i = 0; i < cpu->gdb_regs->len; i++) {
          /* Check for duplicates.  */
          s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
@@ -622,14 +626,7 @@ void gdb_register_coprocessor(CPUState *cpu,

      /* Add to end of list.  */
      cpu->gdb_num_regs += feature->num_regs;
-    if (g_pos) {
-        if (g_pos != base_reg) {
-            error_report("Error: Bad gdb register numbering for '%s', "
-                         "expected %d got %d", feature->xml, g_pos, 
base_reg);
-        } else {
-            cpu->gdb_num_g_regs = cpu->gdb_num_regs;
-        }
-    }
+    cpu->gdb_num_g_regs = cpu->gdb_num_regs;
  }

  void gdb_unregister_coprocessor_all(CPUState *cpu)
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index e0aae9c9eaf..51b14b95b9f 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -502,7 +502,7 @@ void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *pcc)
  {
      if (pcc->insns_flags & PPC_FLOAT) {
          gdb_register_coprocessor(cs, gdb_get_float_reg, gdb_set_float_reg,
- 
gdb_find_static_feature("power-fpu.xml"), 0);
+ 
gdb_find_static_feature("power-fpu.xml"), 71);
      }
      if (pcc->insns_flags & PPC_ALTIVEC) {
          gdb_register_coprocessor(cs, gdb_get_avr_reg, gdb_set_avr_reg,

---

