Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C30C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFth-0006F2-74; Thu, 22 Feb 2024 15:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdFtd-0006Eh-H3
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdFtZ-0002Tq-I1
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708634535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SMMYk1hW+4wa2pxp+obwp5MhaWJndY1DhzZQZep9m88=;
 b=iGdy5fye0mWoSYDMtbeIR7cHQhbjQP2tlkW10lbMqLZOLyiZ60EtMrmCyUGXtmNqlgqLTz
 +mXKGqQ+W1O0XWKAaT+M4g83htfTZSe9I7fVt8XdCR2384Q3CTdD3+yFxAxPNWyUViskxc
 OtrQdyvkb4d/pT/bUNK7ofzQB9seIrM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-vDxpQncKN7SFdpMey7Lvwg-1; Thu, 22 Feb 2024 15:42:14 -0500
X-MC-Unique: vDxpQncKN7SFdpMey7Lvwg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2c4e9cb449so19622666b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634533; x=1709239333;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMMYk1hW+4wa2pxp+obwp5MhaWJndY1DhzZQZep9m88=;
 b=KXwO/uqVcMTfbXqdj0/DqVNRMgVlTt9nyOsiT6ccScZfmAjU5LzvaSDS5IziY8bPZB
 QPPlHcks/63QvM5nRX9m+y7MqfAU0Dzzv8Q17k6+tpMljsIBjpt+QsrD2gcQaKgnzdjD
 3qhul3UGBFxlQ/46x26KwhsEuNANWcWQ7jMT8ZCciv4gUx05LWtNDrkiBMIZcWw6uaLS
 YGfGXc92W7geJhLatRui93+FIMQCrGmglBwQm3cKWxNEn7p8bl6nW8X4eIEKaHZU7BEB
 ag0czl6inCSGbSQwvJOYZoSfjGfzhS3IJjMVu7T/HHsF01vgz6v8tAbCr1aQBXRFnSc3
 BlUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjEq94K09gvVk/ch//vIYsujvMnJMZL7zb6ogQwhf9w69RMLux/617mttb6ufjj0avn1UDI3yDe/zBhDkJcYQ26oKXbj8=
X-Gm-Message-State: AOJu0YyXJXai1QElIQMNHlfw1omxkWgg4KGpCSRHg+6+AM55yeEbjGyE
 V1Wad2WaoI76iSUi99W4f2DHvCcvL6Ky/2wRHZpys5gGP+Wxmri2bXYlnj8RjTOHOgBpzhEOJkS
 IJ/BQkNDBefgND1cv820kGUOrvCuV2jI8JVyOOUoLgtJPlgI83GLe
X-Received: by 2002:a17:906:417:b0:a3e:ce49:f9b4 with SMTP id
 d23-20020a170906041700b00a3ece49f9b4mr7474065eja.17.1708634533041; 
 Thu, 22 Feb 2024 12:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEerpTlYBJ+tUuqHnYYC955CsL6NcgVny+Pxei2Is6NGFmOdkQtHtEm5hxsnifL0/wSw5uBMA==
X-Received: by 2002:a17:906:417:b0:a3e:ce49:f9b4 with SMTP id
 d23-20020a170906041700b00a3ece49f9b4mr7474058eja.17.1708634532550; 
 Thu, 22 Feb 2024 12:42:12 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 ts4-20020a170907c5c400b00a3e0119b4a3sm6388794ejc.140.2024.02.22.12.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 12:42:11 -0800 (PST)
Message-ID: <29af884a-c572-4dc4-b786-89dd8d51f75a@redhat.com>
Date: Thu, 22 Feb 2024 21:42:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: do not filter processor tracing features
 except on KVM
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240221162910.101327-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240221162910.101327-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

On 21/02/2024 17.29, Paolo Bonzini wrote:
> The processor tracing features in cpu_x86_cpuid() are hardcoded to a set
> that should be safe on all processor that support PT virtualization.
> But as an additional check, x86_cpu_filter_features() also checks
> that the accelerator supports that safe subset, and if not it marks
> CPUID_7_0_EBX_INTEL_PT as unavailable.
> 
> This check fails on accelerators other than KVM, but it is actually
> unnecessary to do it because KVM is the only accelerator that uses the
> safe subset.  Everything else just provides nonzero values for CPUID
> leaf 0x14 (TCG/HVF because processor tracing is not supported; qtest
> because nothing is able to read CPUID anyway).  Restricting the check
> to KVM fixes a warning with the qtest accelerator:
> 
>      $ qemu-system-x86_64 -display none -cpu max,mmx=off -accel qtest
>      qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.07H:EBX.intel-pt [bit 25]
> 
> The warning also happens in the test-x86-cpuid-compat qtest.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2096
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index bca776e1fe9..7f908236767 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6412,6 +6412,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               break;
>           }
>   
> +        /*
> +         * If these are changed, they should stay in sync with
> +         * x86_cpu_filter_features().
> +         */
>           if (count == 0) {
>               *eax = INTEL_PT_MAX_SUBLEAF;
>               *ebx = INTEL_PT_MINIMAL_EBX;
> @@ -7156,7 +7160,12 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>           mark_unavailable_features(cpu, w, unavailable_features, prefix);
>       }
>   
> -    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
> +    /*
> +     * Check that KVM actually allows the processor tracing features that
> +     * are advertised by cpu_x86_cpuid().  Keep these two in sync.
> +     */
> +    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> +        kvm_enabled()) {
>           uint32_t eax_0, ebx_0, ecx_0, edx_0_unused;
>           uint32_t eax_1, ebx_1, ecx_1_unused, edx_1_unused;
>   

Fixes: d047402436 ("target/i386: Call accel-agnostic x86_cpu_get_supported_cpuid()")
Reviewed-by: Thomas Huth <thuth@redhat.com>


