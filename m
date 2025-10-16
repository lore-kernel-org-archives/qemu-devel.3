Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD66CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KgH-0002Wk-2x; Thu, 16 Oct 2025 05:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KgE-0002WN-W8
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KgA-0004bj-Ml
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760608426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MRrA1y9Zdz995LzT2f5IapVbtgVBs+jfQISBhgzp7jA=;
 b=Q7ZwjRZe7YpMcjkS3Pvnii+8+MsgsbqvpajESPZ19AFudOqnTacVBqJKvfj6L2pEX/6cvo
 OqnaTxg00vITELzFQN77qiZ6nk9DPbtN5N6WIAsAJAhMZlcsYaQ9uwu5sieOZUGzJrw5NS
 lemDTTZ5DkPTP1AHgSoncygMa4b0W3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-KFdLVZdGOfOZshzQDqugHA-1; Thu, 16 Oct 2025 05:53:45 -0400
X-MC-Unique: KFdLVZdGOfOZshzQDqugHA-1
X-Mimecast-MFC-AGG-ID: KFdLVZdGOfOZshzQDqugHA_1760608424
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso355743f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760608424; x=1761213224;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRrA1y9Zdz995LzT2f5IapVbtgVBs+jfQISBhgzp7jA=;
 b=Dr0yTpUTz6K4GmyPJQ1GuJUM+M8qatDfvJnkPTt6B+0AFtiIeq5IMJ2imOc6gu+IhG
 6l4OdjPYzM0Yrs/5WgLi2/qw0ZixeY8DnqQGz4yJhrshGYWJDUZsI157zHUXUQJ84BLU
 IPcmd8MGlB+Wo+Y7Rx23ZzS21aD2EeRGpcUp4Xt9nGzKlYC0MHrt9R90Sqln88NGb5R3
 bZtlqpLoyZzCZxJ9SkB8WBb+YY/cdgdsZsEFz92I6BoduVp7x4cnWnVdgFzpC3+Qs8Sz
 cXd7haerqbNqbfoKlXIZAhdAXTosozbv4P+H9sfTt1Ngpde+dacnIQJ4V9b14b1LJa/1
 E/tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFQZdn5VHNeK7byhErdLhN3kbKSB3srx2h+lU5RsmgABhrgyhzveHJU2wMK8gsKTVtwh3V/A3O8Y4f@nongnu.org
X-Gm-Message-State: AOJu0YzQQsiQvlVILoawe2tbIfio5VbwrQJzG9cmQP4wiXxceVwJI5cf
 ahIPaxT8lqEDGWWD1+g/DNy+n94D8CACgb5CBUv5qKT2H6FghFpbT/gu5QQpYCyk9BorW+i5BiO
 VAcNMMZct4Mu3ciD0hIW0b5rWTrtKeW7tj3FkoBjB4ML4Py/koKL+Rpf+
X-Gm-Gg: ASbGncvAJ0o9bVMExPuZibdcbZKKW6SP33xUPM677U2EW2/hOd9awkeNTmhd6t600vi
 uosmEHPwQeKABoPun6usTjh+YiU+3IwswnN4eNJOXs3Cz4X+CmmLarCQ9OYGo8bWT4o/5di7Xvt
 J0dvDnS1mhMmTqKrsd4XfNdId4epF4sAOTnzisf+go0G/zglbbFqaGQD66YxMe2Ldvhar7E4bV7
 TNSOGmJ5+toZSc3gUzYcZ+R/pL3MhqjZOUN90mMqVe2qivHYibNQ9VdTNZwPVfFyhc3CtSkHkgY
 fygziAN5hMEvHEr29JEKy5HqfEuwClCsjfq6ltGwHaV3dW1U3BTda/xhYfkONOBNkAsTrYAGZGU
 52rNjv3+o0ZOjMw9XtKK87/mfVxyw4JnaiKooUv/5
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id
 ffacd0b85a97d-42667177de1mr21188498f8f.19.1760608423859; 
 Thu, 16 Oct 2025 02:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNoWmcthGwu1jPgTc91IwdMyLSKnmyijzspB/OckcWekzDIrlpF/5B9hiymBLarSZijJ+EOg==
X-Received: by 2002:a5d:5f54:0:b0:3ee:1586:6c73 with SMTP id
 ffacd0b85a97d-42667177de1mr21188482f8f.19.1760608423432; 
 Thu, 16 Oct 2025 02:53:43 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42700072619sm2272623f8f.46.2025.10.16.02.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 02:53:42 -0700 (PDT)
Message-ID: <54485257-164e-485d-b82b-baae4b175a9c@redhat.com>
Date: Thu, 16 Oct 2025 11:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: Fix missing clock-comparator
 interrupts after reset
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20251015142141.3238-1-iii@linux.ibm.com>
 <20251015142141.3238-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251015142141.3238-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi Ilya!

On 15/10/2025 16.21, Ilya Leoshkevich wrote:
> After reset, CKC value is set to 0, so if clock-comparator interrupts
> are enabled, one should occur very shortly thereafter.
> 
> Currently the code does not set tod_timer, so this does not happen.
> 
> Fix by adding a tcg_s390_tod_updated() call. Initialize TOD clock
> before CPUs in order to ensure that the respective object exists
> during the CPU reset.

Can this really happen? Looking at CPUS390XState in target/s390x/cpu.h, the 
ckc is next to the cregs[] in the start_initial_reset_fields section, so if 
ckc gets cleared, the cregs get cleared, too. I.e. if ckc gets set to 0 
here, there is no way that the clock comparator interrupt could trigger 
immediately without the guest writing to the control registers first. So I 
think this patch is not really necessary. Or do I miss something?

  Thomas



> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 6 +++---
>   target/s390x/cpu.c         | 8 ++++++++
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index ad2c48188a8..9f37a96ae5a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -286,6 +286,9 @@ static void ccw_init(MachineState *machine)
>       /* init memory + setup max page size. Required for the CPU model */
>       s390_memory_init(machine);
>   
> +    /* init the TOD clock */
> +    s390_init_tod();
> +
>       /* init CPUs (incl. CPU model) early so s390_has_feature() works */
>       s390_init_cpus(machine);
>   
> @@ -332,9 +335,6 @@ static void ccw_init(MachineState *machine)
>           s390_create_sclpconsole(ms->sclp, "sclplmconsole", serial_hd(1));
>       }
>   
> -    /* init the TOD clock */
> -    s390_init_tod();
> -
>       /* init SCLP event Control-Program Identification */
>       if (s390mc->use_cpi) {
>           s390_create_sclpcpi(ms->sclp);
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index f05ce317da1..cc2de6ce08e 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -40,6 +40,7 @@
>   #include "system/reset.h"
>   #endif
>   #include "hw/s390x/cpu-topology.h"
> +#include "tcg/tcg_s390x.h"
>   
>   #define CR0_RESET       0xE0UL
>   #define CR14_RESET      0xC2000000UL;
> @@ -215,6 +216,13 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
>               break;
>           }
>       }
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (tcg_enabled()) {
> +        /* Rearm the CKC timer if necessary */
> +        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
> +    }
> +#endif
>   }
>   
>   static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)


