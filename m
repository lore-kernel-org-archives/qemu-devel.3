Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C44C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uENsu-0002m8-Am; Mon, 12 May 2025 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uENss-0002lb-Eh
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uENsq-0005Cc-04
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747036050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kB+84O32NNQuNhFFDlypLnN85DKxRHXA0L3G1iyvYwY=;
 b=LQ+v5Z+DRJHQV3n2yxK8pDNdGzeh0ZbWShjBFqUEaoCXLPlZWhIK7shbgtH+vyzCNK3vd7
 RIMCrgCIpaNT8vXMNrRahY+WWWrZn6Bl3yzc2lBBLDnb4HW3KWuxE3ZmBvQ3FHSot+KirO
 oBcB2WHDlU8OA4oKxZSTjPv8HgYU8G8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-9PAIKeGJN5yl3sL7HCZM-Q-1; Mon, 12 May 2025 03:47:28 -0400
X-MC-Unique: 9PAIKeGJN5yl3sL7HCZM-Q-1
X-Mimecast-MFC-AGG-ID: 9PAIKeGJN5yl3sL7HCZM-Q_1747036048
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so21192745e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 00:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747036047; x=1747640847;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB+84O32NNQuNhFFDlypLnN85DKxRHXA0L3G1iyvYwY=;
 b=ra35b4a0t0++vOtpXTU/AZpodud8U2OuzgNWSNmM+FLu4ZBmc6BgS1zlDFMHa6GWrZ
 AyyXJF3fRb1lBlewVmXnJbo+1BqfflO3bcIR9T/wOCHbvMH4OshOkyc3c7eMsgpKpFzP
 uqC73l8I/8flm3LBlDzgjp5g3Jorj+8sHjtCumKlv7Eoge8zWKb2md5LGLqtCEMMz6dL
 VBISLaaeT2o9gxzDB5AvsCEF5ZVfysOmntm68b2aD1amh5rJSBbrOXMUNHdbku+GGE5v
 OP4jFgtBWsd8qjvnTNbaiDB1/CxuWY3yXU03iG5g3T4ecvxjhlNJkFn5f5aDqIXrzzrl
 /OWQ==
X-Gm-Message-State: AOJu0YzKZ73X0y9CWdPvlBLl/5YQm/3cKiwpVjI4YDoq56WwWiZoNLzk
 aWL2PJWTIzGj3FhkEbjXKXZ/d+i7AWeJd4uDVofzuc8hLS1lrBxlQFa+IDEsnfXUWUfSMnSckoM
 eIu3gRZC9zWBjn1Npc70B3QdsOj088jeodYYHRdBm55ub5UdG9iUKfe6+8E8/B83l4kfyr6trzY
 t2mlN+fhlrEsYyvHBvLHEc2ZHCb/Javr+S
X-Gm-Gg: ASbGnctOcPqjxCKgytVgQ3TFHLp0z4jRSYDsk6ReyQC5vUL/7lTnLqFDtDa+3frvApB
 ZBLONZp3ZLSh3CbeYexXBxOODE8vF4OGEiVS7HKoB7CA7vWl3Z3CaiVpVJgkntgg7kbTPVH32xL
 GG3mvchvBlwsejk+H3+UG3/TfZScbI0zW/PEvwPMp8buZcZXsn5GLr3+u7z9YfDUSPEOX0zazJe
 mbC6FXR96E0m2CQcnUo6rNrjB6fqlYcLK0LHMywn9dD0PQvabYNAfl/rKtkTPi+2Zhl9OVTdqKC
 KF77GnyzPHl0iXBs0l9C3chcwxdvmlk1gvN6BqtVCas=
X-Received: by 2002:a05:600c:4e45:b0:43b:cd0d:9466 with SMTP id
 5b1f17b1804b1-442d6d44b3cmr98907165e9.9.1747036047597; 
 Mon, 12 May 2025 00:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzjmxDwc8pFoD4g61kp1RH1GBLIn1L0qH0EGo1jV3OfZwyUraahY9ZqlZj/uLehXLeKXI/LQ==
X-Received: by 2002:a05:600c:4e45:b0:43b:cd0d:9466 with SMTP id
 5b1f17b1804b1-442d6d44b3cmr98906845e9.9.1747036047081; 
 Mon, 12 May 2025 00:47:27 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f9ab.dip0.t-ipconnect.de.
 [79.224.249.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd32f2a8sm157197475e9.14.2025.05.12.00.47.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 00:47:26 -0700 (PDT)
Message-ID: <f9602133-c616-4b41-b856-785767644257@redhat.com>
Date: Mon, 12 May 2025 09:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/23] target/s390x: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1746968215.git.neither@nut.email>
 <e7b270caf050f837fb9222a88cd4f156c608d197.1746968215.git.neither@nut.email>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e7b270caf050f837fb9222a88cd4f156c608d197.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11.05.25 15:14, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for IBM System/390 targets. We treat "program
> interrupts" and service calls as exceptions. We treat external and io
> "exceptions" as well as resets as interrupts.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/s390x/tcg/excp_helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index e4c75d0ce0..b7e7a4deff 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -34,6 +34,7 @@
>   #include "hw/s390x/s390_flic.h"
>   #include "hw/boards.h"
>   #endif
> +#include "qemu/plugin.h"
>   
>   G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
>                                              uint32_t code, uintptr_t ra)
> @@ -499,6 +500,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
>       S390CPU *cpu = S390_CPU(cs);
>       CPUS390XState *env = &cpu->env;
>       bool stopped = false;
> +    uint64_t last_pc = cpu->env.psw.addr;
>   
>       qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
>                     __func__, cs->exception_index, env->psw.mask, env->psw.addr);
> @@ -528,21 +530,27 @@ try_deliver:
>       switch (cs->exception_index) {
>       case EXCP_PGM:
>           do_program_interrupt(env);
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>           break;
>       case EXCP_SVC:
>           do_svc_interrupt(env);
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>           break;
>       case EXCP_EXT:
>           do_ext_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_IO:
>           do_io_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_MCHK:
>           do_mchk_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_RESTART:
>           do_restart_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);

Might be easier to check for "if (cs->exception_index != EXCP_STOP)" 
after that switch-case.

But I'm curious about the semantics: are we supposed to call 
qemu_plugin_vcpu_interrupt_cb() just after an interrupt got delivered?

-- 
Cheers,

David / dhildenb


