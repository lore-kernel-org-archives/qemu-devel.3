Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36873C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEm5o-00088K-8C; Tue, 13 May 2025 05:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEm5l-00087s-Q8
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEm5j-0004Vl-Jp
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747129106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KrX5dQOsiuTyKGPiD7lJuvLzjNro5fZEtw25f9WuCU=;
 b=WRLHmOh3lqKMu1dk7IB+CInN4oPyCj03OEYhQIklFdn3ad7AfO5xdaWacyqZkdtqoKpFai
 W1gqfS/c05+UjhlB/M0JY4etUSZiUlTOv6deP6cUkSpnDPX0CY6QzdIdq7OC6JlvasieJ4
 P+Mth4EoLZN8PO/fX8f6Wq7U46mhszk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-MxgwXJIkNbyoaEw8rH7wlw-1; Tue, 13 May 2025 05:38:25 -0400
X-MC-Unique: MxgwXJIkNbyoaEw8rH7wlw-1
X-Mimecast-MFC-AGG-ID: MxgwXJIkNbyoaEw8rH7wlw_1747129104
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso26331875e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747129104; x=1747733904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4KrX5dQOsiuTyKGPiD7lJuvLzjNro5fZEtw25f9WuCU=;
 b=iAdfsTBbuMKdTpf57MhGnEgeWPsiWnbMqrjpBgp26rPEX/cnBv6TY1WxnVjOPSc2BK
 1PKgiZeVIKbRNoAgYroxHyU9N5xEfI3M2lLTsAs/Fge7ZOpgM8QTDXtdSTUMyCtiwAJf
 DdaUoO6Z/U8oikO+TmRwGaRNT29oSs4rbqMHvrT21Wclo9gW9InpRBXxw5ATkah9M0cd
 zfz0O0/wKund51XaWcMREvMGilkP+vvEifu7XPY4ZhjxzfWTzj/8FJbqVqnVXE9TINrp
 sb9mR3nCL0gS8u4kGMEk3w0bio+da2JAzR8ahc3/QmeQ0XCamexDGazRb1PEudsjUp6K
 pPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHEzBlcyQoLk/ygYOA7nIuxnrzc7dL9jTKN1igQJMiRwrEYw0sRCy0lPgtkbIldbZAbZefdZPw77oy@nongnu.org
X-Gm-Message-State: AOJu0YwpfOxc7S0XPORWq4A0SiquThhSXnb8QwCT2zwlkwO/HxU0iZaj
 P5ykeOK4hy7QAdFe6z5KstX0i4JkZIyXfPz6qCj3/NWqVHd5/j8Mu+0JrVcvmNNuFIRTgzxmFZy
 9TvdlnEhiXaKz9Z0bEL+1+FU0HEry2wp0FYeJh4ana0bOBkkHJ/kz
X-Gm-Gg: ASbGnctdM9l1wFTS5xt5a/uIFM4FguTp+nJeWj/dJlcMsJ94IH6eDD1I/puWGs8Iyd+
 LWa1ZA2TvXUKhhCAPgVMbiNFJN5aoqsbcGIYZgUALZIa+TMbRvIQBcgk1xUR0U3u4pg+oIEY8MI
 bZybc1fXeGr3jXHiEVj19ztCqp274dHAXJug+BSkS8YnPKuigGGPAb6uEYnNlW8PvA3dqX5tlJG
 mc+P5ZFvyNA3j0Lh+Jo3OcpmDGN4iFPHfL1Q9n4Le6uz+pHfKXK/jLh+xWsW+ke8JcHVd8mx5aW
 Lskawuj1GpMx8Zk7l79l+dU0nfxJlBmQZZE5Jlqru2AbDCzmVA2zABT01UM=
X-Received: by 2002:a05:600c:4d21:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-442eacf980fmr16403405e9.12.1747129103733; 
 Tue, 13 May 2025 02:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJLKtmMNprOtP6whNggUMo04dtnwmsVA/9z9AbAUkwvGFFOL65KoCRiCgBsYTpq3eWLP7Trw==
X-Received: by 2002:a05:600c:4d21:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-442eacf980fmr16403125e9.12.1747129103224; 
 Tue, 13 May 2025 02:38:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aecb0sm206781415e9.28.2025.05.13.02.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 02:38:22 -0700 (PDT)
Message-ID: <7efea440-f472-4115-9133-436347632c50@redhat.com>
Date: Tue, 13 May 2025 11:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] arm: rework id register storage
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250506085234.855779-1-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250506085234.855779-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 5/6/25 10:52 AM, Cornelia Huck wrote:
> Just some small changes:
> - fixed up some botched conversions noted by Eric (thanks!)
> - rebased to current master
> - new patch with a small cleanup suggested by Eric
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v6

The series looks good to me and I have not spotted any additional
conversion issue.

Thanks

Eric
>
> <v5 cover letter>
> Just a quick respin to fix a missed conversion in hvf.c.
>
> <v4 cover letter>
> Next iteration of the id register patches; only small changes.
>
> Changed from v3:
> - added R-bs (thanks!)
> - added missing SPDX header
> - merged patch introducing accessors for kvm to the first user
> - skip over sysregs outside of the id register range when generating
>   register definitions again
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v4
>
> <v3 cover letter>
> Yet another update of the id register series, less changes this time
> around.
>
> Changed from v2:
> - changed generation of the various register defines via the "DEF"
>   magic suggested by Richard
> - some kvm-only code moved to kvm.c; some code potentially useful to
>   non-kvm code stayed out of there (the cpu model code will make use
>   of it, and that one should be extendable outside of kvm -- a
>   revised version of those patches is still in the works, but I'll be
>   off for a few days and rather wanted to get this one out first)
>
> Also available at
> https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v3
>
> <v2 cover letter>
>
> Changed from v1:
> - Noticed that we missed the hvf code. Converted, compiled, but not tested
>   as I'm lacking an environment for testing.
> - Hopefully incorporated most of the suggested changes -- if I missed
>   something, it was unintentional unless mentioned below.
>   - fixed repeated inclusion of definitions
>   - hopefully made macros more robust
>   - removed distinction between reading 32/64 values, which was mostly
>     adding churn for little value
>   - postponed generating property definitions to the cpu model patches,
>     where they are actually used
>   - juggled hunks and moved them to the right patches
>   - fixed some typos
> - rebased to a more recent code base
>
> NOT changed from v1:
> - definitions are still generated from the Linux sysregs file
>   - I still think updating the generated files on demand (so that we can
>     double check the result) is the right thing to do
>   - I'm open to changing the source of the definitions from the sysregs
>     file to the JSON definitions published by Arm; however, I first wanted
>     to get the code using it right -- we can switch out the code generating
>     the file to use a different source easily later on, and I'd also like
>     to steal parts of the script from Linux once integrated (which I think
>     hasn't happened yet?)
>
> <v1 cover letter>
>
> [Note: I've kept the cc list from the last round of cpu model patches;
> so if you're confused as to why you're cc:ed here, take it as a
> heads-up that a new cpu model series will come along soon]
>
> This patch series contains patches extracted from the larger cpu model
> series (RFC v2 last posted at
> https://lore.kernel.org/qemu-devel/20241206112213.88394-1-cohuck@redhat.com/)
> and aims at providing a base upon which we can continue with building
> support for cpu models, but which is hopefully already an improvement
> on its own.
>
> Main changes from the patches in that series include:
> - post-pone the changes to handle KVM writable ID registers for cpu models
>   (I have a series including that on top of this one)
> - change how we store the list of ID registers, and access them
>   basically, use an enum for indexing, and an enum doing encodings in a
>   pattern similar to cpregs
> - move some hunks to different patches
> - update the scripts to generate the register descriptions, and run
>   them against a recent Linux sysregs file
>
> What I've kept:
> - generating the register descriptions from the Linux sysregs file
>   I think that file is still our best bet to generate the descriptions
>   easily, and updating the definitions is a manual step that can be checked
>   for unintended changes
> - most of the hard work that Eric had been doing; all new bugs in there
>   are my own :)
>
> </v1 cover letter>
> </v2 cover letter>
> </v3 cover letter>
> </v4 cover letter>
> </v5 cover letter>
>
> Cornelia Huck (2):
>   arm/cpu: switch to a generated cpu-sysregs.h.inc
>   arm/kvm: use fd instead of fdarray[2]
>
> Eric Auger (12):
>   arm/cpu: Add sysreg definitions in cpu-sysregs.h
>   arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays
>   arm/cpu: Store aa64isar1/2 into the idregs array
>   arm/cpu: Store aa64pfr0/1 into the idregs array
>   arm/cpu: Store aa64mmfr0-3 into the idregs array
>   arm/cpu: Store aa64dfr0/1 into the idregs array
>   arm/cpu: Store aa64smfr0 into the idregs array
>   arm/cpu: Store id_isar0-7 into the idregs array
>   arm/cpu: Store id_pfr0/1/2 into the idregs array
>   arm/cpu: Store id_dfr0/1 into the idregs array
>   arm/cpu: Store id_mmfr0-5 into the idregs array
>   arm/cpu: Add sysreg generation scripts
>
>  hw/intc/armv7m_nvic.c                 |  27 +-
>  scripts/gen-cpu-sysregs-header.awk    |  35 ++
>  scripts/update-aarch64-sysreg-code.sh |  25 ++
>  target/arm/cpu-features.h             | 317 +++++++++---------
>  target/arm/cpu-sysregs.h              |  42 +++
>  target/arm/cpu-sysregs.h.inc          |  52 +++
>  target/arm/cpu.c                      | 111 +++----
>  target/arm/cpu.h                      |  80 +++--
>  target/arm/cpu64.c                    | 128 +++----
>  target/arm/helper.c                   |  68 ++--
>  target/arm/hvf/hvf.c                  |  39 ++-
>  target/arm/internals.h                |   6 +-
>  target/arm/kvm.c                      | 139 ++++----
>  target/arm/ptw.c                      |   6 +-
>  target/arm/tcg/cpu-v7m.c              | 174 +++++-----
>  target/arm/tcg/cpu32.c                | 320 +++++++++---------
>  target/arm/tcg/cpu64.c                | 459 +++++++++++++-------------
>  17 files changed, 1103 insertions(+), 925 deletions(-)
>  create mode 100755 scripts/gen-cpu-sysregs-header.awk
>  create mode 100755 scripts/update-aarch64-sysreg-code.sh
>  create mode 100644 target/arm/cpu-sysregs.h
>  create mode 100644 target/arm/cpu-sysregs.h.inc
>


