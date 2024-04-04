Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB52DCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 08:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsI1v-00059z-0U; Thu, 04 Apr 2024 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsI1s-00059d-Jo
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 04:01:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsI1q-00051u-U7
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 04:01:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4162b016230so1706285e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712217657; x=1712822457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aBLdQAB15l4WtLYubiaVu+Q89jsw2nCA70Bnr2h1mmQ=;
 b=nHzj1yLRp4I4Z+FyXCD/V/S+nRYjsneMXWmIZZxMcc8AiU2IspgL3N0VFxChDTzi3Q
 lKa/iQeBEPJbTruWzVLYMsq830v5tpajobYWUIondkhXnCAUeTcev3//bdNfa81xnhU/
 waHzgEfwdT3/JiWrKPN/WkTGM1WLZx573P3BrPgyFCiZ+/HN8jDX5SBYF+1jc/7ETDOF
 ApkWtdPTBc9lU0DlDPO3Ri4NEl+Wb3YwIHyB0jvmpbZ5Ef1f1AGr2cWz3K1sgeNVpUOK
 shoXqK/eQ7Wnf7XfV9ivGXRv9xFftk0tYjoud6Wi1qXdCCsbIQ2IMCANWyXFs2lARyk0
 CJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712217657; x=1712822457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aBLdQAB15l4WtLYubiaVu+Q89jsw2nCA70Bnr2h1mmQ=;
 b=HGkMtyXDt2HShXxpLaIYi8s1gcr+JxhbK4SOhsx3i9jsbaFbc8PXVb3OcZapFj/8X0
 gkrOvSqAFO5d5UWo9a3fq3oZ3dL4lQ/YI1W4kykNmwUH9aQn2WLMQCqljyxTAMdwH6o6
 UyC5Lbicva5m4jC11BeCKvK0eLF3aHsfOZp6aGCQXkR6uza5HrUrvyN2tl3b06GpK4K4
 6n2Tug7iNZx0myk1y0Kabp84r+f3X3WYyCBXm0nrem3ojs/QPkgkrEqdaZOK5ji1mPKj
 Q4PA9pByofIZR2n6IogKMIGlwK4GhlcC2a3R4CU8MVQlbhZbqMTSpVPL+KhtylpcbhsL
 Y3sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURNROxXXLsF45rGa8K/nFrn0tg0jvZ7fNDWGLHYxh6/Cfud8btGMibXwGUjCBr4vgalHzT4v+vnNx5wdbMekc59lezmCQ=
X-Gm-Message-State: AOJu0Yy1DXMEKkYPoc/eL0OZoVnSV+jjGOh4QWiPIaBrluKj314jIZPl
 yXoDD21BeLs9P5LJqjvxDs11pgiZ1vypll6qzfWt/D9VYCdetKB5SDgW1mEE/hU=
X-Google-Smtp-Source: AGHT+IGb32FNmC+WTaY5TuRcykU5vf3D+uyOO9Y28MGHL/nyDi9VaPxEeJoAUVUYS5SkLEv31H5Avg==
X-Received: by 2002:a7b:ce16:0:b0:415:54d2:15a7 with SMTP id
 m22-20020a7bce16000000b0041554d215a7mr1429993wmc.41.1712217657223; 
 Thu, 04 Apr 2024 01:00:57 -0700 (PDT)
Received: from [192.168.200.175] ([81.185.165.143])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c355200b00412e5f32591sm1750924wmq.28.2024.04.04.01.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 01:00:56 -0700 (PDT)
Message-ID: <c31dcace-92da-4de7-93e6-631120829a75@linaro.org>
Date: Thu, 4 Apr 2024 10:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] backends/confidential-guest-support: Add
 functions to support IGVM
To: Roy Hopkins <roy.hopkins@suse.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?J=C3=B6rg_Roedel?=
 <jroedel@suse.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <1dff8015f9f9cf735de21a16e5dba14371c39155.1712141833.git.roy.hopkins@suse.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1dff8015f9f9cf735de21a16e5dba14371c39155.1712141833.git.roy.hopkins@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Roy,

On 3/4/24 13:11, Roy Hopkins wrote:
> In preparation for supporting the processing of IGVM files to configure
> guests, this adds a set of functions to ConfidentialGuestSupport
> allowing configuration of secure virtual machines that can be
> implemented for each supported isolation platform type such as Intel TDX
> or AMD SEV-SNP. These functions will be called by IGVM processing code
> in subsequent patches.
> 
> This commit provides a default implementation of the functions that
> either perform no action or generate a warning or error when they are
> called. Targets that support ConfidentalGuestSupport should override
> these implementations.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>   backends/confidential-guest-support.c     | 32 ++++++++++
>   include/exec/confidential-guest-support.h | 74 +++++++++++++++++++++++
>   2 files changed, 106 insertions(+)


>   struct ConfidentialGuestSupport {
>       Object parent;
>   
> @@ -60,6 +94,46 @@ struct ConfidentialGuestSupport {
>        */
>       char *igvm_filename;
>   #endif
> +
> +    /*
> +     * The following virtual methods need to be implemented by systems that
> +     * support confidential guests that can be configured with IGVM and are
> +     * used during processing of the IGVM file with process_igvm().
> +     */
> +
> +    /*
> +     * Check for to see if this confidential guest supports a particular
> +     * platform or configuration
> +     */
> +    int (*check_support)(ConfidentialGuestPlatformType platform,
> +                         uint16_t platform_version, uint8_t highest_vtl,
> +                         uint64_t shared_gpa_boundary);
> +
> +    /*
> +     * Configure part of the state of a guest for a particular set of data, page
> +     * type and gpa. This can be used for example to pre-populate and measure
> +     * guest memory contents, define private ranges or set the initial CPU state
> +     * for one or more CPUs.
> +     *
> +     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
> +     * context for a virtual CPU. The format of the data depends on the type of
> +     * confidential virtual machine. For example, for SEV-ES ptr will point to a
> +     * vmcb_save_area structure that should be copied into guest memory at the
> +     * address specified in gpa. The cpu_index parameter contains the index of
> +     * the CPU the VMSA applies to.
> +     */
> +    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
> +                           ConfidentialGuestPageType memory_type,
> +                           uint16_t cpu_index, Error **errp);
> +
> +    /*
> +     * Iterate the system memory map, getting the entry with the given index
> +     * that can be populated into guest memory.
> +     *
> +     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
> +     */
> +    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
> +                             Error **errp);
>   };
>   
>   typedef struct ConfidentialGuestSupportClass {

Methods are usually a class field, not an instance one. Any
reason to diverge from this norm?

Regards,

Phil.

