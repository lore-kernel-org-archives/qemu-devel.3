Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F08AC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJwS3-0006Ee-Ij; Tue, 27 May 2025 11:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJwS0-0006EO-Jn
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJwRu-00039A-I6
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748360559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GYjzf1at/wubZxWng6gwod5nngx9YBoemHxwSWxJDjU=;
 b=fyWLGxtnjYV7jXDdIRUyDYUmxGwMa7DwUuw3RsGHMtTDN3ZN4xqbFpYCVaVYGMs3NmQfVr
 VsTanfIASwcZGMOmkotRlHxm95esp5/txvQ95K0Bw481ohrWMH4sj57qnPEAJsWfgP7wIs
 zUQd1o+9Pt9doOJ8eKMVHi5SQd/+gYg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-rIjJkSklNyW72pZ_acNO_w-1; Tue, 27 May 2025 11:42:37 -0400
X-MC-Unique: rIjJkSklNyW72pZ_acNO_w-1
X-Mimecast-MFC-AGG-ID: rIjJkSklNyW72pZ_acNO_w_1748360557
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6049c728b24so1699066a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748360557; x=1748965357;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYjzf1at/wubZxWng6gwod5nngx9YBoemHxwSWxJDjU=;
 b=r4KSA9FtJcUJwBGL/38BH7MPykLjzYAd78ubAH8ORyD9JqDPAxXNRiCggKhYxJPh9x
 4/cnnZ847LhiAa2Mdat1pwy2oWxkT6G395XQ8uZ0QcLDgs+IxBVBJNeBVQs3kjsTQO+v
 K7w6O3Q4HBmgFtE0OHQqJqBwmgt8GetYqyRB1FDW4JdF9+lYCKrN17ARGhY9N6/XO59U
 MguhLK0u1a8ryEeHS6biKaV7XxJmg8Vhef1qptn0Q3KPtCJWgXGxEMYepeLB8Lww12+B
 3J/fovQvQ02BOrqtUh13lb6f2589erlcXPULyL2JXnaxfHSe5O4CMuZVQV9HyX8nGTjV
 2QFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu7xig8AUvS+syMt55J/eeGOp3Htpr7gv8CzcMHGHB6WFVAEaNrVsbV6KmkV+aUmVGUkws5gQukAjR@nongnu.org
X-Gm-Message-State: AOJu0YyKOOhjKiE7cXk7J93BItf5vPE2n4ZEaMrb0t0bihyFHZ8fcSUG
 pdePhJjgpNN9GdK97NPyNRUvxKZLf2geMvgvS/lU+OEH2/GHhsgZt7vhs9p5nZ48E3bZic3+UZx
 V3A8oTEb+ymFH0fx+CcFKZGbWgU++l7xySbmS9Ifd/plXtWrCe0b15f99
X-Gm-Gg: ASbGnctmbt0hzduvSABDPRTIEVxtIo+gTRJWAmt/uXO5pEMcWGCnGAanVDPTfIkY4zU
 1orOpYcxaIWjbQHvP8KDPzEPk8KIWNqRqjjcfkNuy36l9TAuOZGXTBu6NEo8E6LvCyC+wLLXYTB
 VvMYHyDrtM9TkDmAHb7/uywDE7rElq9cjYeaoI8hHMSa9DUjfvsGCPITIeenhqxcOABqITg2BLz
 4dT97OBAe/FwSItY4zdeROUjpsZVQUf7Nb3ktK/QQK4MNfs3r3vHtUGaVZb2Pudgj5qQIhBQorn
 GHm3ugC7M3l04Q==
X-Received: by 2002:a05:6402:26c1:b0:601:d9f4:eac6 with SMTP id
 4fb4d7f45d1cf-602da407b05mr9682384a12.21.1748360556424; 
 Tue, 27 May 2025 08:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEegxgAG/pZUT5UobRfnKytKcy4UOj5G7CA/Z5+y7WjCTMgwf4Db1IDF2kQYfIv6uzrtVUh/A==
X-Received: by 2002:a05:6402:26c1:b0:601:d9f4:eac6 with SMTP id
 4fb4d7f45d1cf-602da407b05mr9682369a12.21.1748360556004; 
 Tue, 27 May 2025 08:42:36 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6045b95d2d1sm4498742a12.24.2025.05.27.08.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 08:42:35 -0700 (PDT)
Message-ID: <1a5cfe89-f7e2-4e3a-862b-5d5f761e145d@redhat.com>
Date: Tue, 27 May 2025 17:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] target/i386: Update EPYC CPU models for Cache
 property, RAS, SVM feature and add EPYC-Turin CPU model
To: Babu Moger <babu.moger@amd.com>
Cc: zhao1.liu@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
References: <cover.1746734284.git.babu.moger@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cover.1746734284.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On 5/8/25 21:57, Babu Moger wrote:
> 
> Following changes are implemented in this series.
> 
> 1. Fixed the cache(L2,L3) property details in all the EPYC models.
> 2. Add RAS feature bits (SUCCOR, McaOverflowRecov) on all EPYC models
> 3. Add missing SVM feature bits required for nested guests on all EPYC models
> 4. Add the missing feature bit fs-gs-base-ns(WRMSR to {FS,GS,KERNEL_G}S_BASE is
>     non-serializing). This bit is added in EPYC-Genoa and EPYC-Turin models.
> 5. Add RAS, SVM, fs-gs-base-ns and perfmon-v2 on EPYC-Genoa and EPYC-Turin models.
> 6. Add support for EPYC-Turin.
>     (Add all the above feature bits and few additional bits movdiri, movdir64b,
>      avx512-vp2intersect, avx-vnni, prefetchi, sbpb, ibpb-brtype, srso-user-kernel-no).

Queued, thanks.

Paolo

> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
> Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
> ---
> v7: Rebased on top latest 57b6f8d07f14 (upstream/master) Merge tag 'pull-target-arm-20250506'
>      Added new feature bit PREFETCHI. KVM support for the bit is added recently.
>      https://github.com/kvm-x86/linux/commit/d88bb2ded2ef
>      Paolo, These patches have been pending for a while. Please consider merging when you get a chance.
> 
> v6: Initialized the boolean feature bits to true where applicable.
>      Added Reviewed-by tag from Zhao.
> 
> v5: Add EPYC-Turin CPU model
>      Dropped ERAPS and RAPSIZE bits from EPYC-Turin models as kernel support for
>      these bits are not done yet. Users can still use the options +eraps,+rapsize
>      to test these featers.
>      Add Reviewed-by tag from Maksim for the patches already reviewed.
> 
> v4: Some of the patches in v3 are already merged. Posting the rest of the patches.
>      Dropped EPYC-Turin model for now. Will post them later.
>      Added SVM feature bit as discussed in
>      https://lore.kernel.org/kvm/b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com/
>      Fixed the cache property details as discussed in
>      https://lore.kernel.org/kvm/20230504205313.225073-8-babu.moger@amd.com/
>      Thanks to Maksim and Paolo for their feedback.
> 
> v3: Added SBPB, IBPB_BRTYPE, SRSO_USER_KERNEL_NO, ERAPS and RAPSIZE bits
>      to EPYC-Turin.
>      Added new patch(1) to fix a minor typo.
> 
> v2: Fixed couple of typos.
>      Added Reviewed-by tag from Zhao.
>      Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging")
> 
> Previous revisions:
> v6: https://lore.kernel.org/kvm/cover.1740766026.git.babu.moger@amd.com/
> v5: https://lore.kernel.org/kvm/cover.1738869208.git.babu.moger@amd.com/
> v4: https://lore.kernel.org/kvm/cover.1731616198.git.babu.moger@amd.com/
> v3: https://lore.kernel.org/kvm/cover.1729807947.git.babu.moger@amd.com/
> v2: https://lore.kernel.org/kvm/cover.1723068946.git.babu.moger@amd.com/
> v1: https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com/
> 
> Babu Moger (6):
>    target/i386: Update EPYC CPU model for Cache property, RAS, SVM
>      feature bits
>    target/i386: Update EPYC-Rome CPU model for Cache property, RAS, SVM
>      feature bits
>    target/i386: Update EPYC-Milan CPU model for Cache property, RAS, SVM
>      feature bits
>    target/i386: Add couple of feature bits in CPUID_Fn80000021_EAX
>    target/i386: Update EPYC-Genoa for Cache property, perfmon-v2, RAS and
>      SVM feature bits
>    target/i386: Add support for EPYC-Turin model
> 
>   target/i386/cpu.c | 439 +++++++++++++++++++++++++++++++++++++++++++++-
>   target/i386/cpu.h |   4 +
>   2 files changed, 441 insertions(+), 2 deletions(-)
> 


