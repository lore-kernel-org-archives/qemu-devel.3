Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970BDC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMJd-0000FH-Bk; Tue, 04 Feb 2025 12:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMJD-0008Ml-Uj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMJB-0004YF-KI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738688514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmpuwmtNIyVuancbMXxzBE7rmXZl8E7krQ5h0kLqhxc=;
 b=KOg71zuEBcVbJhkV4d0VOIrEzSrLeBCsSD1zBy6zYDcPOIDefpzrXz1Hg/PBk1DNT0Kmp5
 UX4ioReYiPTQV+HkfgDfAwz5a4SOw8hHFSRXg8srCNJq7IkGh08cO8ASViPg1r1EZ7/8Z7
 76w+JjB32MMvdj/uJyVpHFvW3Mtsvh8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-jRETuyOEOECWtzF-DkQ_zg-1; Tue, 04 Feb 2025 12:01:53 -0500
X-MC-Unique: jRETuyOEOECWtzF-DkQ_zg-1
X-Mimecast-MFC-AGG-ID: jRETuyOEOECWtzF-DkQ_zg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467be89d064so63219781cf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738688513; x=1739293313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmpuwmtNIyVuancbMXxzBE7rmXZl8E7krQ5h0kLqhxc=;
 b=ts+jYBsETEJo5duiR/+MxHQf1LdO96guSPlgdXqU0ZBovvKzAKBGI7UoVA+51yn3Jo
 gsDk5DVUzTu8XY7JfyFKMxGBZ+cNwRcny/9BgDc79YrB7bvEq9MGmNoev9EwGKx/jPkm
 d5+A3ThU+Zpp2xmHx9qM9itDXE/G8plxRh/FTHLaZ+MMRC49r05a7t2+mtdncPxZtkEF
 BbErJJY8IP4D0+i0m9xkG/ZsFygoHEpPDpdUahKwBtShzSvn0+4EDr/Rw1NLAt2+8ayD
 oTBGFMTtj9/JikUCz2iRAAVLj8znevum5XEfCtSfYHBpKaFhE3OrGNkNib2Rlcu9pS7O
 mICQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbhtyB30JfMB30Jh5m7IdbrPmeguDaa0TFisJlo7VJpPtyLkU1nqGSuIsNTilGzxLRsrWpIKmfN1kV@nongnu.org
X-Gm-Message-State: AOJu0YwrQclRjknap/gJcpaAG3ErSNVVhoMgTqdxyZ65NeH5Xc9SWFuj
 NzRjZHW8R13u02bFTU4Qmsu9cM5mQlHf/gF9GXAc4X5ya49DN/jo99u3F6OpZfUKyDxEyfg1yhG
 MB1BbQDJOd2TPFCXMzbL8cv2kUfFdqRvEAhbYKCCTEqMhWIRUss4a
X-Gm-Gg: ASbGncs2V51xsfnfvzHR2vZ/CM0QYXVQE+6kP+hwQCObIJ7Srl1bYStwU0rPG2k2bCj
 QAhhXHsngPX38lMEncYrmGTpBkZrtdl2vOuUANwuXIEfJsHlUQnJIpfV9FxkclpOVxZFNr0JBy3
 MAZW6iUb+AH5874UOp1FukQT4kzl8dkyx8NAvlXMEyXOZErewmjMWtwmNke7bm+m6NELkFhFfYZ
 iZwSA4tEXulE31CFHLFVVBM1fsCdJttfgNa2cLkLGBMRlHccr8pZnU7NqzGFISZ4ECARv+H2D6N
 x0oamLt02fqUYT3/JNTartteP3Ht6zOuHoqmgn8wJPW91Abi
X-Received: by 2002:ac8:5745:0:b0:467:75fa:8c8 with SMTP id
 d75a77b69052e-46fd0ad89femr403610111cf.31.1738688512150; 
 Tue, 04 Feb 2025 09:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmiCvI702XSjcGZ8IPiSidjwXwYfVjctXrd6dOhCMaN+Q6fbpH5jw2AZ0XrnixI4d7e81EDw==
X-Received: by 2002:ac8:5745:0:b0:467:75fa:8c8 with SMTP id
 d75a77b69052e-46fd0ad89femr403606451cf.31.1738688511250; 
 Tue, 04 Feb 2025 09:01:51 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf172372sm60828601cf.60.2025.02.04.09.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:01:50 -0800 (PST)
Date: Tue, 4 Feb 2025 12:01:48 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 3/6] accel/kvm: Report the loss of a large memory page
Message-ID: <Z6JH_OyppIA7WFjk@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-4-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201095726.3768796-4-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Feb 01, 2025 at 09:57:23AM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> In case of a large page impacted by a memory error, provide an
> information about the impacted large page before the memory
> error injection message.
> 
> This message would also appear on ras enabled ARM platforms, with
> the introduction of an x86 similar error injection message.
> 
> In the case of a large page impacted, we now report:
> Memory Error on large page from <backend>:<address>+<fd_offset> +<page_size>
> 
> The +<fd_offset> information is only provided with a file backend.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>

This is still pretty kvm / arch relevant patch that needs some reviews.

I wonder do we really need this - we could fetch ramblock mapping
(e.g. hwaddr -> HVA) via HMP "info ramblock", and also dmesg shows process
ID + VA.  IIUC we have all below info already as long as we do some math
based on above.  Would that work too?

> ---
>  accel/kvm/kvm-all.c       | 18 ++++++++++++++++++
>  include/exec/cpu-common.h | 10 ++++++++++
>  system/physmem.c          | 22 ++++++++++++++++++++++
>  target/arm/kvm.c          |  3 +++
>  4 files changed, 53 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f89568bfa3..9a0d970ce1 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1296,6 +1296,24 @@ static void kvm_unpoison_all(void *param)
>  void kvm_hwpoison_page_add(ram_addr_t ram_addr)
>  {
>      HWPoisonPage *page;
> +    struct RAMBlockInfo rb_info;
> +
> +    if (qemu_ram_block_info_from_addr(ram_addr, &rb_info)) {
> +        size_t ps = rb_info.page_size;
> +
> +        if (ps > TARGET_PAGE_SIZE) {
> +            uint64_t offset = QEMU_ALIGN_DOWN(ram_addr - rb_info.offset, ps);
> +
> +            if (rb_info.fd >= 0) {
> +                error_report("Memory Error on large page from %s:%" PRIx64
> +                             "+%" PRIx64 " +%zx", rb_info.idstr, offset,
> +                             rb_info.fd_offset, ps);
> +            } else {
> +                error_report("Memory Error on large page from %s:%" PRIx64
> +                            " +%zx", rb_info.idstr, offset, ps);
> +            }
> +        }
> +    }
>  
>      QLIST_FOREACH(page, &hwpoison_page_list, list) {
>          if (page->ram_addr == ram_addr) {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 3771b2130c..190bd4f34a 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -110,6 +110,16 @@ int qemu_ram_get_fd(RAMBlock *rb);
>  size_t qemu_ram_pagesize(RAMBlock *block);
>  size_t qemu_ram_pagesize_largest(void);
>  
> +struct RAMBlockInfo {
> +    char idstr[256];
> +    ram_addr_t offset;
> +    int fd;
> +    uint64_t fd_offset;
> +    size_t page_size;
> +};
> +bool qemu_ram_block_info_from_addr(ram_addr_t ram_addr,
> +                                   struct RAMBlockInfo *block);
> +
>  /**
>   * cpu_address_space_init:
>   * @cpu: CPU to add this address space to
> diff --git a/system/physmem.c b/system/physmem.c
> index e8ff930bc9..686f569270 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1678,6 +1678,28 @@ size_t qemu_ram_pagesize_largest(void)
>      return largest;
>  }
>  
> +/* Copy RAMBlock information associated to the given ram_addr location */
> +bool qemu_ram_block_info_from_addr(ram_addr_t ram_addr,
> +                                   struct RAMBlockInfo *b_info)
> +{
> +    RAMBlock *rb;
> +
> +    assert(b_info);
> +
> +    RCU_READ_LOCK_GUARD();
> +    rb =  qemu_get_ram_block(ram_addr);
> +    if (!rb) {
> +        return false;
> +    }
> +
> +    pstrcat(b_info->idstr, sizeof(b_info->idstr), rb->idstr);
> +    b_info->offset = rb->offset;
> +    b_info->fd = rb->fd;
> +    b_info->fd_offset = rb->fd_offset;
> +    b_info->page_size = rb->page_size;
> +    return true;
> +}
> +
>  static int memory_try_enable_merging(void *addr, size_t len)
>  {
>      if (!machine_mem_merge(current_machine)) {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb23..d9dedc6d74 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2389,6 +2389,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>                  kvm_cpu_synchronize_state(c);
>                  if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
>                      kvm_inject_arm_sea(c);
> +                    error_report("Guest Memory Error at QEMU addr %p and "
> +                        "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
> +                        addr, paddr, "BUS_MCEERR_AR");
>                  } else {
>                      error_report("failed to record the error");
>                      abort();
> -- 
> 2.43.5
> 

-- 
Peter Xu


