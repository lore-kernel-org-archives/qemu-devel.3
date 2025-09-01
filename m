Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A8ACA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4B5-0000HN-0G; Mon, 01 Sep 2025 09:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4Af-0000AC-J6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4AX-0005p7-Qd
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756731714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLtHtFRO8RNQp1Ityjf6O1pIqu+DTiLuJjBp/OftexM=;
 b=by9FIMLQkl85ylcj1q3gZ0N4hwqwdsZdMJUkEbSY37OdaecYvbtNTRiNV+yWKYLf2IZmBI
 9kcJ5t/uRfUd6RB7sU4Ci4PmiFQaUzeidpjCzIKC2MLZb25+AO45EL65OjUPbaOy7NCJad
 OkCdVmFslaZtDJZk/1/AnGFnSKiOmpo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562--blqly-TPvWwO2_UyupHIw-1; Mon, 01 Sep 2025 09:01:52 -0400
X-MC-Unique: -blqly-TPvWwO2_UyupHIw-1
X-Mimecast-MFC-AGG-ID: -blqly-TPvWwO2_UyupHIw_1756731712
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b339e7d107so5986641cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731711; x=1757336511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLtHtFRO8RNQp1Ityjf6O1pIqu+DTiLuJjBp/OftexM=;
 b=wBsAUugceCbj2l0yY6AGSXGe/+UyI5doJTUHIvDJWzZjMcuwhBFHq5PWZHv51j4gWF
 SjiSRjiWOtD3uE7+tLtTEsZkr5kcBYUtb1mRYitZFYBcf0cCQm962Fi5sey+23FxtGVt
 BsJRiU4xJBafk2zqfwM/kHsrH/hC7QOWT1wkFX9T9WHmAtbdiOZoL7au6sT+oFmJe3pm
 jcN09zmhgNx24NTelAFJC92sOhjlcKXuLFthkdulMtwg4tmp8izyQ6C2WENU9A2/57J4
 72psKRgPMT/IQwV6LB0gntn4sb0Ba+ZjaYQ0TzS2IAC+mi3Fn6B1X8yU+ucFhqa2wMA4
 71WQ==
X-Gm-Message-State: AOJu0Yxzm8mHvz1zl8O4AiK/xLmgszbw3xwWrwuk/6jcM3jh1IH0Hvio
 KOvsDHsvrvYO53u76tvJxlczcs3DrG7PSWiAwyM2S3bIKAQ2DAZIH9HF11bRBL9RVHBchc8opeC
 73S7t1sAsugH66dAA0c1H3YoKs6Cp9pe9sqnM4EB0HxlyBIXt5RzXXXKpq6pFm4S6
X-Gm-Gg: ASbGncvz2Xl9sWLSEpXFbBTSf3upJ9RpybqldHAmXQoyHg1IEGQaMMmy/n+MGyaOB7y
 4z5BzjGpc/naDfN0KvoqmrIPKsFO019zhhscFL+p3ybV6Ggm6QbXFS1G06qFeb9oeu4ue2Vt/Ym
 pc/jcjNKd45CLaBdbeoNIKS4ThNfWEK/24WHLU47hKHcL4zBVhVDczT/4Nd9YKCXyLikom02B1g
 MJzZsaN7gC96u/8AvaSMabLlvrxPXrPVb7UmTmoWja5gKjE+B/4yQwz2PdMIeJa9RDJTpUoGCqP
 k+fNVXnCYgjF8jrN/v4tmq7m7cMwPw==
X-Received: by 2002:a05:622a:230c:b0:4b3:1b73:a732 with SMTP id
 d75a77b69052e-4b31dd59c7cmr102197151cf.72.1756731711307; 
 Mon, 01 Sep 2025 06:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkoD2pJG7JlYws8Lrh+TSri+CHMZLn1PU0k7Xzl2hp77Pg+M+NFRUu4XRYADUbpI+FVuFUdQ==
X-Received: by 2002:a05:622a:230c:b0:4b3:1b73:a732 with SMTP id
 d75a77b69052e-4b31dd59c7cmr102196661cf.72.1756731710793; 
 Mon, 01 Sep 2025 06:01:50 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b30b58b5fasm60866931cf.21.2025.09.01.06.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:01:50 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:01:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 07/18] cpu-common: use atomic access for interrupt_request
Message-ID: <20250901150147.406c2566@fedora>
In-Reply-To: <20250829153115.1590048-3-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-3-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 29 Aug 2025 17:31:04 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Writes to interrupt_request used non-atomic accesses, but there are a
> few cases where the access was not protected by the BQL.  Now that
> there is a full set of helpers, it's easier to guarantee that
> interrupt_request accesses are fully atomic, so just drop the
> requirement instead of fixing them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/core/cpu.h |  1 -
>  hw/core/cpu-common.c  | 12 +-----------
>  system/cpus.c         |  3 +--
>  3 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b01a0cffd64..23bd02277f4 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -495,7 +495,6 @@ struct CPUState {
>      bool exit_request;
>      int exclusive_context_count;
>      uint32_t cflags_next_tb;
> -    /* updates protected by BQL */
>      uint32_t interrupt_request;
>      int singlestep_enabled;
>      int64_t icount_budget;
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 39e674aca21..9ea1f3764a8 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -67,19 +67,9 @@ CPUState *cpu_create(const char *typename)
>      return cpu;
>  }
>  
> -/* Resetting the IRQ comes from across the code base so we take the
> - * BQL here if we need to.  cpu_interrupt assumes it is held.*/
>  void cpu_reset_interrupt(CPUState *cpu, int mask)
>  {
> -    bool need_lock = !bql_locked();
> -
> -    if (need_lock) {
> -        bql_lock();
> -    }
> -    cpu->interrupt_request &= ~mask;
> -    if (need_lock) {
> -        bql_unlock();
> -    }
> +    qatomic_and(&cpu->interrupt_request, ~mask);
>  }
>  
>  void cpu_exit(CPUState *cpu)
> diff --git a/system/cpus.c b/system/cpus.c
> index 437848b5eb4..9bfbe2b0607 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -257,8 +257,7 @@ int64_t cpus_get_elapsed_ticks(void)
>  void cpu_set_interrupt(CPUState *cpu, int mask)
>  {
>      /* Pairs with cpu_test_interrupt(). */
> -    qatomic_store_release(&cpu->interrupt_request,
> -        cpu->interrupt_request | mask);
> +    qatomic_or(&cpu->interrupt_request, mask);
>  }
>  
>  void generic_handle_interrupt(CPUState *cpu, int mask)


