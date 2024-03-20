Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5733C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyJN-0003CA-Qe; Wed, 20 Mar 2024 11:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmyJM-0003Bu-9t
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmyJ8-0008QC-8q
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710950208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qrzp2WX9G4fGi7FWFHFjHhR3/T8Nfe24Fjm+GgjHxDE=;
 b=NToduvWhHTC+My6rg8xWINop1aB6z3oYCE/p9zhe+GH9M6/RLVoqGQhDzJmjTFc/7pr6Wo
 ZdZ0cXz9EZMMLK05M20cjEIp7bco41Psg70lV14yc7TKUAIQv81omTPjf0lNiZyslwaqUK
 o5PPYn8OQ7OzK3zrz0ElCcBmg0tgedA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-hlzL9zjfO0CE1XT0bZzLuQ-1; Wed, 20 Mar 2024 11:56:46 -0400
X-MC-Unique: hlzL9zjfO0CE1XT0bZzLuQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a466c77307eso100407466b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710950205; x=1711555005;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrzp2WX9G4fGi7FWFHFjHhR3/T8Nfe24Fjm+GgjHxDE=;
 b=SDmTmZDCVudvvfJ7mrDoVmDKVzATm6c1fuklPVq08KDfE61m12mquon2QgpHNTAuzo
 hzIDO5zdymVO2EBSa7Zz7Sg8FZfxzoDPyGXKczRxJHk7h8hs72h2rYltJgCPZVuDK4xW
 LTMDwkIsOayWwXAOw3bonADaE9gLogLCxh84kwzmrlDboOOQY7++aSvRttVDRTUNWwYF
 ZbS6erAllElt2x7Rj33l0Bsowv+9Ojo8joUL3wffdFvgQYp9bj205Idu01DzgCgZLtHh
 L7bkZ3hLIgwmSVXvx8VM584cN3H4q+Be489+UgNMFgL1iJ+M6L6SqS2RMO5YVmGKPA8H
 vZQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn3z4JU/b+CRqHKXPdp7Yx9Dlto1h7LMMXBSJCyq4iIqyNFWCEIF/Rgmy5Ny1vN0a0ieAMJtJhCPehhancNN/1uNsRPNU=
X-Gm-Message-State: AOJu0Yz65ue+Q5sT7DVL2Puo/cDuSc5mr4iqHg9zQlzpIo12qj3cigbF
 qGQ9edfw4jhAnQvhhuZL36km4UE8jgCDwoFvE4XdGLxOKvi28CFDyHwwPQuy3z1N0McjUNvp7rR
 FcvIu1i4dlmgzAu8h9/SIAq5qe2nNaua8xOuHhAkS3g/yTbC+wQp9
X-Received: by 2002:a17:906:fd3:b0:a46:d786:3672 with SMTP id
 c19-20020a1709060fd300b00a46d7863672mr79687ejk.13.1710950205112; 
 Wed, 20 Mar 2024 08:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL9lb9JU6u29HDH1ruhW2E+dvTvzRu/d44yRA/zPFQeK1CKRp96jbDh+2Z61dbYWZINepF3A==
X-Received: by 2002:a17:906:fd3:b0:a46:d786:3672 with SMTP id
 c19-20020a1709060fd300b00a46d7863672mr79667ejk.13.1710950204786; 
 Wed, 20 Mar 2024 08:56:44 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 gf9-20020a170906e20900b00a46a27794f6sm5377774ejb.123.2024.03.20.08.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 08:56:42 -0700 (PDT)
Message-ID: <86baf9cb-ba7b-4701-a96d-b34edfe3d1de@redhat.com>
Date: Wed, 20 Mar 2024 16:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/49] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for
 memslot
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-10-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-10-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/20/24 09:39, Michael Roth wrote:
> +    if (cap_user_memory2 == -1) {
> +        cap_user_memory2 = kvm_check_extension(s, KVM_CAP_USER_MEMORY2);
> +    }
> +
> +    if (!cap_user_memory2 && slot->guest_memfd >= 0) {
> +        error_report("%s, KVM doesn't support KVM_CAP_USER_MEMORY2,"
> +                     " which is required by guest memfd!", __func__);
> +        exit(1);
> +    }

It's easier and more robust (for error reporting purposes) to check both
KVM_CAP_GUEST_MEMFD and KVM_CAP_USER_MEMORY2 at once in the earlier
patches:

-    kvm_guest_memfd_supported = kvm_check_extension(s, KVM_CAP_GUEST_MEMFD);
+    kvm_guest_memfd_supported =
+        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_check_extension(s, KVM_CAP_USER_MEMORY2);

since KVM cannot really support guest_memfd if it cannot then use it
to create private memory slots.

And then, this one can be changed to also use kvm_guest_memfd_supported:

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e83429b31eb..afcf6f87045 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -284,19 +284,8 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
  {
      KVMState *s = kvm_state;
      struct kvm_userspace_memory_region2 mem;
-    static int cap_user_memory2 = -1;
      int ret;

-    if (cap_user_memory2 == -1) {
-        cap_user_memory2 = kvm_check_extension(s, KVM_CAP_USER_MEMORY2);
-    }
-
-    if (!cap_user_memory2 && slot->guest_memfd >= 0) {
-        error_report("%s, KVM doesn't support KVM_CAP_USER_MEMORY2,"
-                     " which is required by guest memfd!", __func__);
-        exit(1);
-    }
-
      mem.slot = slot->slot | (kml->as_id << 16);
      mem.guest_phys_addr = slot->start_addr;
      mem.userspace_addr = (unsigned long)slot->ram;
@@ -309,7 +298,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
           * value. This is needed based on KVM commit 75d61fbc. */
          mem.memory_size = 0;

-        if (cap_user_memory2) {
+        if (kvm_guest_memfd_supported) {
              ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
          } else {
              ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
@@ -319,7 +308,7 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
          }
      }
      mem.memory_size = slot->memory_size;
-    if (cap_user_memory2) {
+    if (kvm_guest_memfd_supported) {
          ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
      } else {
          ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
@@ -331,7 +320,7 @@ err:
                                mem.userspace_addr, mem.guest_memfd,
                                mem.guest_memfd_offset, ret);
      if (ret < 0) {
-        if (cap_user_memory2) {
+        if (kvm_guest_memfd_supported) {
                  error_report("%s: KVM_SET_USER_MEMORY_REGION2 failed, slot=%d,"
                          " start=0x%" PRIx64 ", size=0x%" PRIx64 ","
                          " flags=0x%" PRIx32 ", guest_memfd=%" PRId32 ","
@@ -501,6 +490,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
          flags |= KVM_MEM_READONLY;
      }
      if (memory_region_has_guest_memfd(mr)) {
+        assert(kvm_guest_memfd_supported);
          flags |= KVM_MEM_GUEST_MEMFD;
      }
      return flags;


