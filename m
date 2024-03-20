Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E8FC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsWw-0000Fy-5D; Wed, 20 Mar 2024 05:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsWu-0000Fj-2W
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsWs-0008DU-IR
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710927996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+WZs6qFUYItA5gvCkkHLzU1au93L0AnahHvuXruBMKk=;
 b=Pca+aJ7gfPKR0N7yyBbzMEj5P5AygC7Lf3Cfgr+iLemBbAMNtBYF68GpXNG6mSgvYfyJ9V
 5DLar09yvyBSxV3f1bOel+N2Thsse/WsCdflXwmHxPgBM9jeXCQyXmYF7hJ99zDEEicdWJ
 2Dhzo6pd3Jb4WDuIKBOFgGf/Z210J7Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-qQ_NAtBeON63xK-WyBanLA-1; Wed, 20 Mar 2024 05:46:32 -0400
X-MC-Unique: qQ_NAtBeON63xK-WyBanLA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a469d3547c7so71707366b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710927991; x=1711532791;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+WZs6qFUYItA5gvCkkHLzU1au93L0AnahHvuXruBMKk=;
 b=xNvFlgaJE8jYmjrRXnaC7NTVd3lkd+u5hMquItoVuGm3Z0AqoFUqlDpw0fWVU2Re7z
 pq8tsd5htjhDTXfVbldII4+0nhHpDBORnNLBn/xwFXIsxeHRPGbDR9fmUfwKosCYSrpn
 rcACf2vCbZrlA7V0jfO/tICm096BTTi2K2QnEACwUzIAb0QtIilMjVWimTFRRc9mqcIF
 ner2ER10JGQnVna+oCxsZS51rrMKZvuc1krIAWejZtsz2lBe1WiDE1NgexI5uIKdNpW/
 Fc0FmBYXa1b0kmDQlhkhtmpN+ahK1UTG93fllb10kvVJP6P6Dfo0ATAMJ60EDQX6m20i
 9h1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYStiU89mZyb4qACtqPYqyA8DyL+gowDAHQZTesYL4Y81pr0lf9EKmNE3p8wN8jV+sIb6Ytgy16CnkYBvpr9n9cbZp97Y=
X-Gm-Message-State: AOJu0YzEnq2IDdrXrmheMiEnQzHcYArU+GKSmw2FlzHfzsZG8PjXh87y
 N+hpwwh2fSsw31m+0/p9lY0hM/ECOqPmNCt84eBlyn8pyHyRWi4PkRjgEkG/2r/luB6vSN1u8JH
 cC1T/J4ue81lpllMQYrosxvS4DFlCRQOP5fcBYpPWmQskzVNje9mp
X-Received: by 2002:a17:906:af8a:b0:a45:bde1:a334 with SMTP id
 mj10-20020a170906af8a00b00a45bde1a334mr1652425ejb.27.1710927990922; 
 Wed, 20 Mar 2024 02:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYWyHr39ieL8VW6sq78MqBLPco9oQ7sYS8RNzT+os3VOZljrCtsjVKViXIi+OETXikeC19vw==
X-Received: by 2002:a17:906:af8a:b0:a45:bde1:a334 with SMTP id
 mj10-20020a170906af8a00b00a45bde1a334mr1652414ejb.27.1710927990617; 
 Wed, 20 Mar 2024 02:46:30 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 j1-20020a1709062a0100b00a46af0fbf5dsm4271330eje.103.2024.03.20.02.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:46:30 -0700 (PDT)
Message-ID: <7727f1f2-2a30-45d2-85a9-db22ec5a9be5@redhat.com>
Date: Wed, 20 Mar 2024 10:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/49] i386/sev: Skip RAMBlock notifiers for SNP
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-26-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-26-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> SEV uses these notifiers to register/pin pages prior to guest use, since
> they could potentially be used for private memory where page migration
> is not supported. But SNP only uses guest_memfd-provided pages for
> private memory, which has its own kernel-internal mechanisms for
> registering/pinning memory.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   target/i386/sev.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 61af312a11..774262d834 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -982,7 +982,15 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>           goto err;
>       }
>   
> -    ram_block_notifier_add(&sev_ram_notifier);
> +    if (!sev_snp_enabled()) {
> +        /*
> +         * SEV uses these notifiers to register/pin pages prior to guest use,
> +         * but SNP relies on guest_memfd for private pages, which has it's
> +         * own internal mechanisms for registering/pinning private memory.
> +         */
> +        ram_block_notifier_add(&sev_ram_notifier);
> +    }
> +
>       qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
>       qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
>   

These three lines can be done in any order, so I suggest removing 
ram_block_notifier_add + qemu_add_machine_init_done_notifier from the 
sev-common implementation of kvm_init (let's call it 
sev_common_kvm_init); and add an override in sev-guest that calls them 
if sev_common_kvm_init() succeeds.

(treat this as a review for 25/26/29).

Paolo


