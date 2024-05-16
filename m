Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A59C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 19:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7gz1-0005az-76; Thu, 16 May 2024 15:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7gz0-0005aj-2C
 for qemu-devel@nongnu.org; Thu, 16 May 2024 15:41:42 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7gyy-0000Wq-5s
 for qemu-devel@nongnu.org; Thu, 16 May 2024 15:41:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so67600795ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715888499; x=1716493299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OpVnZghvEMg16HGeb87tte2ko84HFFTN6RDFupw79iQ=;
 b=oJbNFzwAaXQacs0fzcmMvVv9bmKNyRLZCDjJJrPVq5xm5WT+S8tNACQ1jLOYak+B+g
 epg780u/eybKOCN17wniC9IFfZ0Dp9RASYCL7PBuNrxKmAixHDAODDBfLhWct+KZxaoE
 AE1znnKG2Jj3S11QxIv5X3l/ZvW6h/u3hTBDWCAcQqT+odt7RenoHy7yWdg9ftqnbV5/
 ECeGEWl7HP04mmLm5o0rSsbqLwbe9MaN7yxh4AREkoMdhPW9wHMKREBZZYZwQpnyJwAX
 tvdmWQBl3N+f4dbljLnQi2kpSb6baYgPzYJZ+esDJr/uu5/EV8sys7f7X74XaKfPePPD
 2WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715888499; x=1716493299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OpVnZghvEMg16HGeb87tte2ko84HFFTN6RDFupw79iQ=;
 b=jER1V/VipV6FY7K4NQSnQxclHSY7wHh0XMrTou4IrP5cYXIRtk1W3Hw0ixchV6omAe
 Ix2HY/cBgBgw4aZXoAgiac6vsmT0UZfFPLyGhvPh4uZHYSIRQ0spk6elp88aQCuEloK1
 77rl1YGLlnR4Jt5uWkvas1/pzY7QW/UR+9kyoLFtLMd7N5jojd0EfAHmwCEtEsE2a2/Z
 EoqeKNOUmVyDfbzqSCtkZW7BI5Udo0dG7HwYBhFnaxQkJVakgv/xLxiRDf8NkofJ21bu
 HsN3y2RwmGU8oh67whi71AwqnwRZeIsUS46z2oh6XY2nsNshgqHAa3DoKGzEsg6DT7BR
 jJfw==
X-Gm-Message-State: AOJu0YzXNKYkm+5cY7N/KnA1ZjmSnTVPGghPlZMvhh116esDNH+um+dD
 FN/C+KgU/UKTY3FuvvfRyARvpTBolP0uI9JldHwJ7TAOQuwtQ5KnaouaaWeqBXU=
X-Google-Smtp-Source: AGHT+IGeEEUjAEmHjDQdxnAnzURqtdJoyS9AjnhjpX6DC/2pNPqFyyMqc2N/RcJXiW+Qf9ed07b71w==
X-Received: by 2002:a17:903:2452:b0:1ec:2274:8205 with SMTP id
 d9443c01a7336-1ef4404a23emr209395095ad.48.1715888498568; 
 Thu, 16 May 2024 12:41:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bada3efsm143436795ad.114.2024.05.16.12.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 12:41:38 -0700 (PDT)
Message-ID: <f8860f42-cf5d-4afa-aa38-964434238844@ventanamicro.com>
Date: Thu, 16 May 2024 16:41:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] hw/riscv/riscv-iommu: add s-stage and g-stage
 support
To: Andrew Jones <ajones@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-10-dbarboza@ventanamicro.com>
 <CANzO1D1Rk6S9RKqVkuFoHrK4tswvr61z0584s+unokcmRdmiog@mail.gmail.com>
 <20240510-dbedfaea5903daa73f461e2b@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240510-dbedfaea5903daa73f461e2b@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 5/10/24 08:14, Andrew Jones wrote:
> On Fri, May 10, 2024 at 06:36:51PM GMT, Frank Chang wrote:
> ...
>>>   static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>>> -    IOMMUTLBEntry *iotlb)
>>> +    IOMMUTLBEntry *iotlb, bool gpa)
>>>   {
>>> +    dma_addr_t addr, base;
>>> +    uint64_t satp, gatp, pte;
>>> +    bool en_s, en_g;
>>> +    struct {
>>> +        unsigned char step;
>>> +        unsigned char levels;
>>> +        unsigned char ptidxbits;
>>> +        unsigned char ptesize;
>>> +    } sc[2];
>>> +    /* Translation stage phase */
>>> +    enum {
>>> +        S_STAGE = 0,
>>> +        G_STAGE = 1,
>>> +    } pass;
>>> +
>>> +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>>> +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
>>> +
>>> +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE && !gpa;
>>> +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
>>> +
>>>       /* Early check for MSI address match when IOVA == GPA */
>>> -    if (iotlb->perm & IOMMU_WO &&
>>> +    if (!en_s && (iotlb->perm & IOMMU_WO) &&
>>
>> I'm wondering do we need to check "en_s" for MSI writes?
>>
>> IOMMU spec Section 2.3.3. Process to translate addresses of MSIs says:
>> "Determine if the address A is an access to a virtual interrupt file
>> as specified in Section 2.1.3.6."
>>
>> and Section 2.1.3.6 says:
>>
>> "An incoming memory access made by a device is recognized as
>> an access to a virtual interrupt file if the destination guest physical page
>> matches the supplied address pattern in all bit positions that are zeros
>> in the supplied address mask. In detail, a memory access to
>> guest physical address A is recognized as an access to a virtual
>> interrupt file’s
>> memory-mapped page if:
>> (A >> 12) & ~msi_addr_mask = (msi_addr_pattern & ~msi_addr_mask)"
>>
>> Is checking the address pattern sufficient enough to determine
>> the address is an MSI to a virtual interrupt file?
>>
> 
> I think so. In fact, I've removed that en_s check on our internal build in
> order to get things working for my irqbypass work, as we can do device
> assignment with VFIO with only S-stage enabled.

The following code will be fixed up here:

  static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb, bool gpa)
+    IOMMUTLBEntry *iotlb)
  {
      dma_addr_t addr, base;
      uint64_t satp, gatp, pte;
@@ -238,11 +237,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
      gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
  
-    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE && !gpa;
+    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
      en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
  
      /* Early check for MSI address match when IOVA == GPA */
-    if (!en_s && (iotlb->perm & IOMMU_WO) &&
+    if ((iotlb->perm & IOMMU_WO) &&
          riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
          iotlb->target_as = &s->trap_as;
          iotlb->translated_addr = iotlb->iova;
@@ -1203,7 +1202,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      }
  
      /* Translate using device directory / page table information. */
-    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, false);
+    fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
  
      if (!fault && iotlb->target_as == &s->trap_as) {
          /* Do not cache trapped MSI translations */

'gpa' is eliminated since it was only being used as 'false' by the only
caller of riscv_iommu_spa_fetch(). The boolean was used only to calculate
en_s as "&& !gpa", so it's always 'true' and had no impact in en_s. My
understand here is that 'gpa' was a prototype of the first implementation
that got left behind and ended up not being used.

As for the MSI check, we won't skip translation if satp is bare (!en_s) because
we might be using just stage2 for a guest, thus en_s is removed from the
conditional. As Frank said, this change also complies with the spec since we don't
need to check satp to determine if the address is an MSI to a virtual interrupt
file.

And, last but not the least, this change doesn't break my KVM VFIO passthrough
test case :) I'll document more about the test case I'm using in the v3 cover
letter.


Thanks,

Daniel


> 
> Thanks,
> drew

