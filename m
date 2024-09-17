Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0313AC021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 11:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqW0J-0000sn-9W; Tue, 17 Sep 2024 07:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqVzE-0000FO-5V
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 07:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqVz7-0003lT-Jv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 07:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726570983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cOCBIn0pEw5CJbS+WYfNI4qTOJ5XncL0gi9oyybkfEs=;
 b=K4Hik4XohfsQ3K5KeOAnOJhq1AxeHwCMqt4YU00gvKQcE73vuvqusqijib96bN8/MkfHku
 FzmhnPBkGIXqiEiDHAm353mKnCkojoPpOxrWulIL14WTmozPwoJtpDrOU1YVOexG36nlgN
 vW5Ei2ILYDR0D6fhqpeDjVIrUlTmwJA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-8UqGZeS6OGO50-dVdD1Inw-1; Tue, 17 Sep 2024 07:03:01 -0400
X-MC-Unique: 8UqGZeS6OGO50-dVdD1Inw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c23fffa44eso2145243a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 04:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726570981; x=1727175781;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cOCBIn0pEw5CJbS+WYfNI4qTOJ5XncL0gi9oyybkfEs=;
 b=v79La8fAX+lF28CN11PWWs+ifBRBqtuGKRHzSUBuldrX0Ec5CIYdsVI9wYcyAJmtWO
 Te5W/5bceIyni3EXH5cupSBxMw6GknNacm38CgYqOjZ0L4mS6J8oV6SQJFDc387khFJY
 Ic1kN7+KVhFl1837diZSYSw8RYJMxMhJCrKpADRpLUP5NwRHHPCS0bpmIzbCGsBGes7V
 j1xhQYxsfpnT39d1a8WzJ1cxRNDPghLB0ToGq3ZTc7XQS1KUpVnwB3oHS889sZNng9kZ
 TdSCYpYWyH4JKC+8zDCtYEMF/qBWqyrE7ea+N5a0sjhDr7k28RlVbv4NDgbNCB76Mq2q
 9YzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJFzAsMmIlEjoxkZ4sOw1xd73jKMb1F/cAILQUwc0s+2qdnr+0hTfQKhpEDXTDX7fX1LJytqD2Vzew@nongnu.org
X-Gm-Message-State: AOJu0Yx8XLmp9WZBQGqO21CcTUm948KiO9V7Y5lUCWbA7DRtFhuzE0Qt
 /wFX01VcVfL8BN0ZW5gK6A/BpUDyt3Gf/k7wacjGdKGdL1nKXHl3VCrAKPnbBn6DETpVoFmdtus
 CYp420DJGvJXuza1Owg/YB/9sgaFF05/t3pNLjWsZd1twN3FlzCvQ
X-Received: by 2002:a17:907:60d1:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a904758f269mr1489212766b.0.1726570980645; 
 Tue, 17 Sep 2024 04:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgxu/s6NGfgP4L2DTnDbl4XTNXCTMXT4d8KD1OuLdcyXFZZdbwDb4kPyKdgZKN2lbHnw88uQ==
X-Received: by 2002:a17:907:60d1:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a904758f269mr1489209466b.0.1726570980074; 
 Tue, 17 Sep 2024 04:03:00 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com.
 [80.187.67.108]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b398csm431187166b.130.2024.09.17.04.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 04:02:59 -0700 (PDT)
Message-ID: <f9353ec2-8589-4889-9a44-bd7cca30036d@redhat.com>
Date: Tue, 17 Sep 2024 13:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/14] s390x/s390-virtio-hcall: prepare for more
 diag500 hypercalls
From: David Hildenbrand <david@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-4-david@redhat.com>
 <98b3faa73073829bbe964bec21803657f7f19846.camel@linux.ibm.com>
 <9a4fedc5-d142-4b3d-90c3-2f03d628003e@redhat.com>
 <32ed2987-6243-4137-9526-d1ce059eb5aa@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <32ed2987-6243-4137-9526-d1ce059eb5aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 17.09.24 12:50, David Hildenbrand wrote:
> On 17.09.24 12:45, David Hildenbrand wrote:
>> On 12.09.24 15:22, Nina Schoetterl-Glausch wrote:
>>> On Tue, 2024-09-10 at 19:57 +0200, David Hildenbrand wrote:
>>>> Let's generalize, abstracting the virtio bits. diag500 is now a generic
>>>> hypercall to handle QEMU/KVM specific things. Explicitly specify all
>>>> already defined subcodes, including legacy ones (so we know what we can
>>>> use for new hypercalls).
>>>>
>>>> We'll rename the files separately, so git properly detects the rename.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>     hw/s390x/s390-virtio-hcall.c   |  8 ++++----
>>>>     hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
>>>>     target/s390x/kvm/kvm.c         | 10 ++--------
>>>>     target/s390x/tcg/misc_helper.c |  4 ++--
>>>>     4 files changed, 14 insertions(+), 19 deletions(-)
>>>>
>>> [...]
>>>>
>>>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>>>> index 94181d9281..ac292b184a 100644
>>>> --- a/target/s390x/kvm/kvm.c
>>>> +++ b/target/s390x/kvm/kvm.c
>>>> @@ -1493,16 +1493,10 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
>>>>     
>>>>     static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
>>>
>>> Might as well make the return type void then.
>>
>> Agreed.
>>
>>> More importantly, are you changing the behavior?
>>> If I'm reading the code right, previously handle_instruction would inject an
>>> additional PGM_OPERATION due to the negative return value, which does seem off to me.
>>> If so, IMO this change should go into a separate patch.
>>
>> You are right, agreed.
> 
> Ah, reading again, we have a "return 0;" after the
> "kvm_s390_program_interrupt", so it should work as expected.
> 

The following in should be what you suggest:

diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index 4cddf69fbb..5fb78a719e 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -57,18 +57,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
      return 0;
  }
  
-int handle_diag_500(CPUS390XState *env)
+void handle_diag_500(S390CPU *cpu, uintptr_t ra)
  {
+    CPUS390XState *env = &cpu->env;
      const uint64_t subcode = env->regs[1];
  
      switch (subcode) {
      case DIAG500_VIRTIO_NOTIFY:
          env->regs[2] = handle_virtio_notify(env->regs[2]);
-        return 0;
+        break;
      case DIAG500_VIRTIO_CCW_NOTIFY:
          env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
-        return 0;
+        break;
      default:
-        return -EINVAL;
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
      }
  }
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index e4f76aca82..dca456b926 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -19,6 +19,6 @@
  #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
  #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
  
-int handle_diag_500(CPUS390XState *env);
+void handle_diag_500(S390CPU *cpu, uintptr_t ra);
  
  #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ac292b184a..2f9a54fe04 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1491,14 +1491,6 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
      return r;
  }
  
-static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
-{
-    if (handle_diag_500(&cpu->env)) {
-        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
-    }
-    return 0;
-}
-
  static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
  {
      uint64_t r1, r3;
@@ -1595,7 +1587,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
          handle_diag_318(cpu, run);
          break;
      case DIAG_KVM_HYPERCALL:
-        r = handle_hypercall(cpu, run);
+        handle_diag_500(cpu, RA_IGNORED)
          break;
      case DIAG_KVM_BREAKPOINT:
          r = handle_sw_breakpoint(cpu, run);
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 58757585a2..170fe00629 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -119,7 +119,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
      case 0x500:
          /* QEMU/KVM hypercall */
          bql_lock();
-        r = handle_diag_500(env);
+        handle_diag_500(env_archcpu(env), GETPC());
          bql_unlock();
          break;
      case 0x44:


-- 
Cheers,

David / dhildenb


