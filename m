Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBBC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsZ1-0001Ef-1C; Wed, 20 Mar 2024 05:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsYz-0001EW-F6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsYy-0000Cu-4N
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710928127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BQPHNj5HNBSMyuoftz28f+ScBc7BnpscC2alH68qkWQ=;
 b=TKVXZWlgi21Pr2/fkuL6JWEKnrkpbqPqyoYxABUYuXeVJ5R12miqkXOfOIz4/0NR+tDrm2
 Qoius7jmJk1uHeqXe72fw8t363keGPctwvm7mTW+7045pKSSP9Z6360iorCzxeqgEDNiuu
 IWloyGc01RbZAPflT2Kfr1o8zsddpMU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-gX47eNk4N92TUZbhwRL8Uw-1; Wed, 20 Mar 2024 05:48:45 -0400
X-MC-Unique: gX47eNk4N92TUZbhwRL8Uw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5685d83ec51so3097057a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710928124; x=1711532924;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQPHNj5HNBSMyuoftz28f+ScBc7BnpscC2alH68qkWQ=;
 b=XzRXCySKaEj5tojR0K0eTUsCJd0eL+eIJ8dR48p9Gy1NN2R6G4obTqAb87mKgChVvJ
 WVkhnokoCJAs3850pgCXoAUc9veEF0Wttd0uAl5PhDm0kS7ytWa/5MCMwxJilLzV5Wxm
 uROhnFXfAzz5uWB8fzWCceJqgOZt17aBFKPceLp6rc5HfyJJFNavI6DZBw6kqMejMeN7
 KnlbB2IRuib2coDY/8qd5BDqsFdzYaJvXv/DIY9aAD7gOYza08Tlb5yiohsS+dhExhYy
 sK/jyi9sQTpu8z5sPCWkk1YNpofTVq7vCc2Bok00gR3TawYW6HE/zigG1GlXj/W+//TD
 KYJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfpzM+KRXcMQEX49MSMevt3ZMjXjsb4Zf5gH3C8Y+e4vfpsdsYjjIBpoCTwgZVunHiHcqJ1PfAlv/yECiOUnf7HGquGRU=
X-Gm-Message-State: AOJu0Yyz6KGS4Cw79WpHBMxi//Req9Eamx+asLC0OGBldtSPHtTEEUAN
 eVCk/XGdwxFO2yVJ+zpedH2L16PXr6+SxCJcYrPmKq3sPnyG7+3yADNF0T7V5nDAE6aWKXQTdqe
 aMZTPLu7zzKKfxkIaETJ24lOLIwmWj2x9Jnd1foI+tCHTXH6EjYDy
X-Received: by 2002:aa7:dac3:0:b0:56b:b5a2:f8bb with SMTP id
 x3-20020aa7dac3000000b0056bb5a2f8bbmr407502eds.3.1710928124592; 
 Wed, 20 Mar 2024 02:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERx4OIqJeH1xeNZL2HDSL0K9OjfpG6J7/cAG0JM1w8983tChGajXSMWG/nuORYnUhGGTQtGQ==
X-Received: by 2002:aa7:dac3:0:b0:56b:b5a2:f8bb with SMTP id
 x3-20020aa7dac3000000b0056bb5a2f8bbmr407492eds.3.1710928124289; 
 Wed, 20 Mar 2024 02:48:44 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 a89-20020a509ee2000000b00568c299eaedsm4763686edf.81.2024.03.20.02.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:48:43 -0700 (PDT)
Message-ID: <45d636a5-c3b2-4125-9837-097b07bbc963@redhat.com>
Date: Wed, 20 Mar 2024 10:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/49] i386/sev: Set ms->require_guest_memfd for SNP
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-28-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-28-michael.roth@amd.com>
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
> SNP requires guest_memfd for private guest memory, so enable it so that
> the appropriate guest_memfd backend will be available for normal RAM
> regions.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   target/i386/sev.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index e4deb7b41e..b06c796aae 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -880,6 +880,7 @@ out:
>   static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>   {
>       SevCommonState *sev_common = SEV_COMMON(cgs);
> +    MachineState *ms = MACHINE(qdev_get_machine());
>       char *devname;
>       int ret, fw_error, cmd;
>       uint32_t ebx;
> @@ -1000,6 +1001,10 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>           qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
>       }
>   
> +    if (sev_snp_enabled()) {
> +        ms->require_guest_memfd = true;
> +    }

Likewise, this and the following patch should be done in the 
sev-snp-guest's override of kvm_init.

Paolo

>       qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
>   
>       cgs->ready = true;


