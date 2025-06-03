Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67CCC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMT7p-00089n-4o; Tue, 03 Jun 2025 11:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMT7l-00089T-4z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMT7h-0004Zv-3R
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g+dIIIYyxHS9v9K4PBJF74g0AZoB1AyRX95eDD+xEyg=;
 b=CN1zrsnQtKkJFcF6taApGd2o179tEOaD0+lr3hHx71ZbXQYxotx1f/PgWkP3YCDDpDGb3X
 wgh6l6COYEGjsCvpyjFwK4pNDanLn3QV8bi+TGQJnDuHksB39jHvpyTLoQXJTOvSXq9vdA
 cx8Oe/N2/0+hcaHURKEpdlhLgO9g9rc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-TlkZJMXxObyvKLFWqE3fbA-1; Tue, 03 Jun 2025 11:00:11 -0400
X-MC-Unique: TlkZJMXxObyvKLFWqE3fbA-1
X-Mimecast-MFC-AGG-ID: TlkZJMXxObyvKLFWqE3fbA_1748962811
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so1583237f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962810; x=1749567610;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g+dIIIYyxHS9v9K4PBJF74g0AZoB1AyRX95eDD+xEyg=;
 b=GQ5E4Dr27zw2qsyq7FcQVlPuV0wvq2rmW9uHVZJtqzu+fE8NHc3jDjNF+geUQmGyRW
 IPZ/+yzQfPIgC+TYwsTBa5qU1iM2/izpiGltBPa6e7hMsxNJh/VGRLsda36PE/gXVsDW
 tqe3hv735+HYaW5zOB60O1gJ+LoEMbFc+Nw0y2r43l5OWQe8VoN1ex6YykEQS2TzkjT5
 hpd5/4UoppMcIFdJb8ViXVmPFoO8OxF2OPHclly8gcYX1guO5k18rJTjM7sTtfCUNsA0
 FMQvyg+j2DYpArVlnrHi8uSiMZPhMBDbU1kKBFwoqPeaaOn2gGmhqOmpG9v22eUs5ryl
 Mn2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaS+/p02HFryp9qOZQ4wFYsLI8G7GMoeyq7CBn1tn9EGMZBmV6VT/GtGM7vZLiVPelwD3gXp4locXn@nongnu.org
X-Gm-Message-State: AOJu0YxKaFW6lPyVsW49rgcG2gSkiFjU/S4Qz5iuDkE2JobuTFhdCB8x
 XdX76IDOahmPfOOmuc9kbxG3CcFpqTOsalxh6c2VjwTG1cj78Anssyns6OGv2tobs84hs48PhKJ
 mS+8eqjrEXszcFhSnoq5G0tgos0BfOsM6TGQlrBFjMoFzJBSG7e1BrtRI
X-Gm-Gg: ASbGncsn/TjZXKLRQ9P6ffufzirpURQoeXfv2en6JKaM2hsQua86LbnTrE0rcDzUBoU
 PragsuMyM4hC4/5Ak4CILvrVMwOGVQYePWZ6r9jl66Pm6jiG4S5H85byUwYzOOGJV/PTId3N9Vn
 r94j+2J/hTl9HS62A3fbnWEe3h/pxweBbVoWtjY8DJN3VAShXGSf+0PCT2BX4lrw9sdVGnpWIod
 2jkaejJS9YsireaCvcd7OTC8GycxJGZotJdJNg+rbyjMv8bhG3HOx0f9CiSKOrFcpd9s7Rm7U1a
 HPGmUHk9KtDsGJM7nePRHejq
X-Received: by 2002:a5d:5f8b:0:b0:3a4:e61e:dc93 with SMTP id
 ffacd0b85a97d-3a514168df6mr2905656f8f.1.1748962810466; 
 Tue, 03 Jun 2025 08:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERxE6vjPv3Alya/l3ZEG+0zNp6BtrLK0c6PZq+9U/5Tde4ILNEcZxIBkCuMYqeuJyMe6KRzg==
X-Received: by 2002:a5d:5f8b:0:b0:3a4:e61e:dc93 with SMTP id
 ffacd0b85a97d-3a514168df6mr2905615f8f.1.1748962810036; 
 Tue, 03 Jun 2025 08:00:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c4f2sm18313949f8f.22.2025.06.03.08.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 08:00:09 -0700 (PDT)
Message-ID: <d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com>
Date: Tue, 3 Jun 2025 17:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Prefault memory on page state change
To: Xiaoyao Li <xiaoyao.li@intel.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
 <4a757796-11c2-47f1-ae0d-335626e818fd@intel.com>
 <cc2dc418-8e33-4c01-9b8a-beca0a376400@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cc2dc418-8e33-4c01-9b8a-beca0a376400@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/3/25 13:47, Xiaoyao Li wrote:
> On 6/3/2025 3:41 PM, Xiaoyao Li wrote:
>> On 3/29/2025 4:30 AM, Tom Lendacky wrote:
>>> A page state change is typically followed by an access of the page(s) 
>>> and
>>> results in another VMEXIT in order to map the page into the nested page
>>> table. Depending on the size of page state change request, this can
>>> generate a number of additional VMEXITs. For example, under SNP, when
>>> Linux is utilizing lazy memory acceptance, memory is typically 
>>> accepted in
>>> 4M chunks. A page state change request is submitted to mark the pages as
>>> private, followed by validation of the memory. Since the guest_memfd
>>> currently only supports 4K pages, each page validation will result in
>>> VMEXIT to map the page, resulting in 1024 additional exits.
>>>
>>> When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for the
>>> size of the page state change in order to pre-map the pages and avoid 
>>> the
>>> additional VMEXITs. This helps speed up boot times.
>>
>> Unfortunately, it breaks TDX guest.
>>
>>    kvm_hc_map_gpa_range gpa 0x80000000 size 0x200000 attributes 0x0 
>> flags 0x1
>>
>> For TDX guest, it uses MAPGPA to maps the range [0x8000 0000, 
>> +0x0x200000] to shared. The call of KVM_PRE_FAULT_MEMORY on such range 
>> leads to the TD being marked as bugged
>>
>> [353467.266761] WARNING: CPU: 109 PID: 295970 at arch/x86/kvm/mmu/ 
>> tdp_mmu.c:674 tdp_mmu_map_handle_target_level+0x301/0x460 [kvm]
> 
> It turns out to be a KVM bug.
> 
> The gpa passed in in KVM_PRE_FAULT_MEMORY, i.e., range->gpa has no 
> indication for share vs. private. KVM directly passes range->gpa to 
> kvm_tdp_map_page() in kvm_arch_vcpu_pre_fault_memory(), which is then 
> assigned to fault.addr
> 
> However, fault.addr is supposed to be a gpa of real access in TDX guest, 
> which means it needs to have shared bit set if the map is for shared 
> access, for TDX case. tdp_mmu_get_root_for_fault() will use it to 
> determine which root to be used.
> 
> For this case, the pre fault is on the shared memory, while the 
> fault.addr leads to mirror_root which is for private memory. Thus it 
> triggers KVM_BUG_ON().
So this would fix it?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7b3f1783ab3c..66f96476fade 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4895,6 +4895,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
  {
  	u64 error_code = PFERR_GUEST_FINAL_MASK;
  	u8 level = PG_LEVEL_4K;
+	u64 direct_bits;
  	u64 end;
  	int r;
  
@@ -4909,15 +4910,18 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
  	if (r)
  		return r;
  
+	direct_bits = 0;
  	if (kvm_arch_has_private_mem(vcpu->kvm) &&
  	    kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(range->gpa)))
  		error_code |= PFERR_PRIVATE_ACCESS;
+	else
+		direct_bits = kvm_gfn_direct_bits(vcpu->kvm);
  
  	/*
  	 * Shadow paging uses GVA for kvm page fault, so restrict to
  	 * two-dimensional paging.
  	 */
-	r = kvm_tdp_map_page(vcpu, range->gpa, error_code, &level);
+	r = kvm_tdp_map_page(vcpu, range->gpa | direct_bits, error_code, &level);
  	if (r < 0)
  		return r;
  


I'm applying Tom's patch to get it out of his queue, but will delay sending
a pull request until the Linux-side fix is accepted.

Paolo


