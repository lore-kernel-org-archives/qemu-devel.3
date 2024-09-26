Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67791CCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 10:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stleQ-0001PH-9A; Thu, 26 Sep 2024 06:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1stleO-0001Ii-KP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1stle9-0000Vx-A7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727346170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ph2qzefjTZU7uNIWAoWnJ3sjLhAyuIcsDVy70DdEUo0=;
 b=GaThqw8jSX+DKKbjKUvCXKqpd7AvhV9fYsQ9i6ddSwge+24oaSNPEX6qKoTWNreK8qbdAT
 7IFCUdjAgHsubqvF+fTyUQ7ySeKrEseerYqMB813Q2R9lJyTQJbaojo183X8cNio3b8lSq
 zPMQeqBGA7j/Ge4RkLvtuUyf/MDprE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-_jWfvCgsP1-6qxw8wEOCtA-1; Thu, 26 Sep 2024 06:22:49 -0400
X-MC-Unique: _jWfvCgsP1-6qxw8wEOCtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cd08d3678so250467f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 03:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727346168; x=1727950968;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph2qzefjTZU7uNIWAoWnJ3sjLhAyuIcsDVy70DdEUo0=;
 b=tMondjyQ4uB1NUPdzntNaGZWn/9DhZaQgFah4ffSh4O1BGp6uOiRhyankn1yY/t1ns
 1yZMTs45x4yJuKR3pLLqgroT8UprZZ043/42J3m9XLKghFW8Svxe5aozSNLoXXLJ2iiO
 GJfp7vNSKjRZPC16r3aLz0XO8YAiCEG38A/GOYgq1lJpYbCCSITLEfJsVL14gut/QzyZ
 7MbaxVPZA2ZAQNAHg00r7zIDu4fRl3R9//RuvpVngKD3Uf13lLYcoMoN95A+Yxle+joN
 JFgiPhEAQbi34NKRpcKImcEhFhMWicnvavejzeSj9Of/jT8o3pI+nAodSA9Lc0taRAI4
 hmeA==
X-Gm-Message-State: AOJu0Yzjvdc/sMz06x6sNh7WFX94GeDbLgSqXBSpLhEmLVX3n80HYwig
 vgJHoOhVciIbiPGrfHkWCJGAwvZH/N+X+ATykSy9MpW+0M++hLTQ42fj0bJ5Vfc45ec1iPOzXun
 c78OLUsX/OsPbQOw2cQk7Qg37qoUGXQ1rCezRv5yVfvUOhNfRIGOZjEpPwu63XojfPStQY6X5bf
 gdZCQQlvQ+eLkQER5cuu+uWyP4gp5PUDHq
X-Received: by 2002:adf:efca:0:b0:374:bf6b:1021 with SMTP id
 ffacd0b85a97d-37ccdb687afmr1386222f8f.27.1727346168161; 
 Thu, 26 Sep 2024 03:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbY2MqwA3iyJgiiFx7JSohaaUUwa3we3aLasJ6B+xAK/Nx530LGk6MJ0mMZsMPtEEasBhZQ==
X-Received: by 2002:adf:efca:0:b0:374:bf6b:1021 with SMTP id
 ffacd0b85a97d-37ccdb687afmr1386196f8f.27.1727346167595; 
 Thu, 26 Sep 2024 03:22:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a?
 (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de.
 [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f90absm43294395e9.12.2024.09.26.03.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 03:22:47 -0700 (PDT)
Message-ID: <45e5e931-49d7-4c7e-a440-ec737927fc17@redhat.com>
Date: Thu, 26 Sep 2024 12:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/14] s390x: introduce s390_get_max_pagesize()
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-13-david@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240910175809.2135596-13-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10.09.24 19:58, David Hildenbrand wrote:
> Let's add a way to return the value (successfully) set via
> s390_set_max_pagesize() previously. This will be helpful to reject
> hotplugged memory devices that would exceed this initially set page size.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

I'll send a v2 shortly, this patch will become:

 From 687f72e488ebed59e57793699d26feb4eebdc9e3 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sun, 8 Sep 2024 23:25:27 +0200
Subject: [PATCH] s390x: remember the maximum page size

Let's remember the value (successfully) set via s390_set_max_pagesize().
This will be helpful to reject hotplugged memory devices that would exceed
this initially set page size.

Handle it just like how we handle s390_get_memory_limit(), storing it in
the machine, and moving the handling to machine code.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  hw/s390x/s390-virtio-ccw.c         | 12 +++++++++++-
  include/hw/s390x/s390-virtio-ccw.h |  1 +
  target/s390x/cpu-sysemu.c          |  7 -------
  target/s390x/cpu.h                 |  1 -
  4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2031c4cf29..65f266a78f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -150,6 +150,16 @@ uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
      return s390ms->memory_limit;
  }
  
+static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
+                                  uint64_t pagesize)
+{
+    assert(!s390ms->max_pagesize && pagesize);
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, &error_fatal);
+    }
+    s390ms->max_pagesize = pagesize;
+}
+
  static void s390_memory_init(MachineState *machine)
  {
      S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
@@ -198,7 +208,7 @@ static void s390_memory_init(MachineState *machine)
       * Configure the maximum page size. As no memory devices were created
       * yet, this is the page size of initial memory only.
       */
-    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
+    s390_set_max_pagesize(s390ms, qemu_maxrampagesize());
      /* Initialize storage key device */
      s390_skeys_init();
      /* Initialize storage attributes device */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index eb04542979..5a730f5d07 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -30,6 +30,7 @@ struct S390CcwMachineState {
      bool pv;
      uint8_t loadparm[8];
      uint64_t memory_limit;
+    uint64_t max_pagesize;
  
      SCLPDevice *sclp;
  };
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 3118a25fee..706a5c53e2 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,13 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
      return s390_count_running_cpus();
  }
  
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
-{
-    if (kvm_enabled()) {
-        kvm_s390_set_max_pagesize(pagesize, errp);
-    }
-}
-
  void s390_cmma_reset(void)
  {
      if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4506539f0..5b7992deda 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
  
  /* cpu.c */
  void s390_crypto_reset(void);
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
  void s390_cmma_reset(void);
  void s390_enable_css_support(S390CPU *cpu);
  void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
-- 
2.46.1



-- 
Cheers,

David / dhildenb


