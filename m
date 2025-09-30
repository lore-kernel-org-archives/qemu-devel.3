Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89147CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ujp-0001eF-3Q; Tue, 30 Sep 2025 03:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ujn-0001dC-Ur
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:25:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ujf-0007OC-Px
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:25:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso16258305e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759217117; x=1759821917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KXfoHJKzAEoZlm7EIBN8HZ0wCcnvYyoGTCHOMSnDlqg=;
 b=ywMBZ8Kj40WpeMoSQZ/EuCt2tlQL3qRYh1IVbqWTYHKKbIvnMD9X9R5NKL4OOWisvV
 FATt+HVvCcSbCbzJUTwlOQrhwVFqYW7mnSjoqPN1tv0F+DCOpBwF+mdq1YIPpqrfNS9S
 whsf/m4eBZwYHWp/pZv2quax0f7XHIIr0+1V5Eia2MKBc2B2Mr0XZOht9oJiem8ZnJZl
 gNFORnT3pBlMCAyt59zCKQUoBiCJJ95E/9Zn07ReBZpLHwFNiM1ieKeSa9T6KhGr05E3
 N7RQooA6Mo8JO/oFEiOIAjvQHOa6YdM/gwSgJgs9+7mPh+u5emBA9u3mFZhfKLJ8wCUm
 QoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759217117; x=1759821917;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KXfoHJKzAEoZlm7EIBN8HZ0wCcnvYyoGTCHOMSnDlqg=;
 b=P6BZOVkOnsumZ5a3rC1Fn/D6sXalEA5EqjyMT5gFok0IJmflsQw4YzDv2YVHGf1XCx
 w/hHgcYaP2IaQrelDCDg92ypzPzImLCABqM5wqRmOjZ7h24aNPZCfNXrJ15No0JemTfg
 cTprA/XTIQ4ektW4fb0LUcEKgMlfc6Yv/h2ZSSKXHatw2CXqtYjBUxVXYHfJRRHj3UR1
 RtNflmimhBWfJZ5kIMy8DpDY18J8/aVlQ7VQTUFkR4B+bNZUSsvJXBuojGPo9Z41GfSD
 7RWsp24FOHw0mbb3YlE8a5FOu7eoWTul2MSrUgYJxzZlwjgXA59ob0RrM6QyYv3tFee8
 pEqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTTV8u3AXaapsnQaDiEFnFRqPwzpV4d5sJpzDv4JW8OM8zdtfI11ZHFTmxoVvC/T98zoRhjUWJk3Ni@nongnu.org
X-Gm-Message-State: AOJu0Yy53sWouboCMZfkUY60cRSm9uHK8rclWEl31nWjRrZNfVY6so4J
 H7E8Hsd3bWN4dntXS9ryzOZ5XrZWxcEU9gSfr/6IbPRAGIzxLGU+sOeXo3TTn3Kfm6Y=
X-Gm-Gg: ASbGncvm4vyDFWicDFo9KVeJS1QMw4562CIrQTltlptLkuHWPPpdozIy8RLuE46KdQU
 zJF50I3mKk7q+nfZtfyt18OUHH6HOU/yYpNpiWgn/4Te+whxFVSjEFc1O4APNJ4l4Huldr4xnXi
 zmwPp/S4dOH0OEDVAAz80WmhyafXzJV0g9sP8ZxHzzPswuosqeVJHdELh/3DMKegia/xrI0mA9s
 Nsrbmg9f1l29pdnB6wEaE0lMujxoOVbxUUrGxJGcPexaNhiL+34X3NjJiRHg79X+t8/h/wWyN83
 UbLk/K9VUfNqi3ARw0ZXKlMdIeb/x095ZNDMvyuYe3z25Y9ZI62fREzk4spMGuEkPTCbcS+TFsu
 z0cIZFcaNU5MRhzt4jyklSiI9mE5i2XgQ2g6DVkRCBHPCdO2bfLBQK+Xs6R38EBPW3NROxvqs88
 9xAIqxazNF5iOsQ6LsKg4uTAd+
X-Google-Smtp-Source: AGHT+IEGShYXZImSoJS6MrCCwqqS6lghItgATnZgdwGJCwRUeVTX2I6q+QeiUjF2A7MJ30GqrUAwEw==
X-Received: by 2002:adf:e646:0:b0:415:b650:a775 with SMTP id
 ffacd0b85a97d-415b650aca7mr8753025f8f.0.1759217116998; 
 Tue, 30 Sep 2025 00:25:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602f15sm21415396f8f.39.2025.09.30.00.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 00:25:16 -0700 (PDT)
Message-ID: <04098b7f-c9bd-4531-87f1-2ea26d4a2a53@linaro.org>
Date: Tue, 30 Sep 2025 09:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] system/physmem: Un-inline
 cpu_physical_memory_read/write()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-s390x@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20250930041326.6448-1-philmd@linaro.org>
 <20250930041326.6448-15-philmd@linaro.org>
 <193cd8a8-2c4c-4c2c-af22-622b74c332ee@redhat.com>
 <61c31076-5330-426a-9c28-b2400bec44f6@linaro.org>
In-Reply-To: <61c31076-5330-426a-9c28-b2400bec44f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/9/25 09:23, Philippe Mathieu-Daudé wrote:
> On 30/9/25 07:02, Thomas Huth wrote:
>> On 30/09/2025 06.13, Philippe Mathieu-Daudé wrote:
>>> Un-inline cpu_physical_memory_read() and cpu_physical_memory_write().
>>
>> What's the reasoning for this patch?
> 
> Remove cpu_physical_memory_rw() in the next patch without having
> to inline the address_space_read/address_space_write() calls in
> "exec/cpu-common.h".
> 
> Maybe better squashing both together?

That would be:

-- >8 --
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6c7d84aacb4..910e1c2afb9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -131,18 +131,8 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
   */
  void cpu_address_space_destroy(CPUState *cpu, int asidx);

-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
-static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, buf, len, false);
-}
-static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
-}
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
  void *cpu_physical_memory_map(hwaddr addr,
                                hwaddr *plen,
                                bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index 70b02675b93..a654b2af2a3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3181,11 +3181,16 @@ MemTxResult address_space_set(AddressSpace *as, 
hwaddr addr,
      return error;
  }

-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
  {
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
+    address_space_read(&address_space_memory, addr,
+                       MEMTXATTRS_UNSPECIFIED, buf, len);
+}
+
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
+{
+    address_space_write(&address_space_memory, addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, len);
  }

  /* used for ROM loading : can write in RAM and ROM */
---

