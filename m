Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02D6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 11:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rNK-0003lW-BI; Fri, 03 May 2024 07:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s2rNA-0003i6-Gy
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s2rN5-0000xL-29
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714736792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uvasta9I+i7UwShPVPO1nVQS1rJRHFdQYPNeS/VWv0=;
 b=YYaIF2wt07gbW/bFGoKxxd+EUwDciFMMBEtGJYIr5jdSWm3vRw6fz9uN5iuSMkuAL/hcsO
 NPfjZ6YOWamPCJOfLjzns4mhpHm3AgD+p5VvyjIz5m359RFon3NU4kf/O0fnFkJs3qqkhV
 bT0RAGkxxZgHQAeIJZ1JRgPrAfIF21E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-wdl-8P7hM1WesEdRQTBTZA-1; Fri, 03 May 2024 07:46:31 -0400
X-MC-Unique: wdl-8P7hM1WesEdRQTBTZA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7927071f933so370232985a.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 04:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714736791; x=1715341591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uvasta9I+i7UwShPVPO1nVQS1rJRHFdQYPNeS/VWv0=;
 b=mojrabW4frMvmCwztgzAynr93HuCORCPXYwjmA+ZcpsSXHrkA1yc+EqYRAj/ACi3dk
 S2LF5ARNy8xIYo2mG71QuHdihXeZP1O/TDxVEUnAl5AEvmVBnLCgPSuiAdc/MrrdpB6f
 DG+YkSNC/MqnGo/M80wZ9xh413WlRz0BHIIo9ef6yAALKz4peEX5p7LfjsDpBiBrTWzx
 Bo4KEXQpfFu0QMJFn0s8DBdKO1TGIvH1/0yfCFO9mAFbX8qTqflH1aY1poAtIbxSNP/9
 FTnqdA162xLQQ9JHHOBqMF2QwzbjSIYC85g32slkT2dLUyehM5dr6JbJrEonTv7eKjb0
 ttdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1BxJUD2vtX0zEB8TkmUZ1LawDkgvobDzh5mZiNr2hRcJXiCzxN88jURIZXq1pAt1hippoW0DXcf0Z4AEknyNyA6JGalI=
X-Gm-Message-State: AOJu0YwBAGI2A6B/S3xWwOCldoZPIr8JMZjWOfDlKUIbYQwZwnmuD7mJ
 mwkWD9vEsE1vqbSGVqkXC1ihiG+ThSycWeiszIioo/mHOLZt0wR1EJRnCyir3qDyRzgZKX70lGP
 dnxYxqPqa9WXFtuIVG7ZdEvGrQ8tFmnR/j1h0M47zq+akfGPsYDv9
X-Received: by 2002:a05:620a:158f:b0:78e:bd5d:8d7b with SMTP id
 d15-20020a05620a158f00b0078ebd5d8d7bmr4193322qkk.14.1714736790698; 
 Fri, 03 May 2024 04:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJC3X5Xn9GnRho4+gg9+JMqRuz8waDWfsajVRpwTseVkejMd0U7f/UraohjumNyb7OmApZAQ==
X-Received: by 2002:a05:620a:158f:b0:78e:bd5d:8d7b with SMTP id
 d15-20020a05620a158f00b0078ebd5d8d7bmr4193275qkk.14.1714736790247; 
 Fri, 03 May 2024 04:46:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a05620a09d600b0078d5f7b9a2dsm1156452qky.15.2024.05.03.04.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 04:46:29 -0700 (PDT)
Message-ID: <919d07f5-ecf7-4ce1-9508-7ac8f8f6e7e4@redhat.com>
Date: Fri, 3 May 2024 13:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] hw: define and enforce a standard lifecycle for
 versioned machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
References: <20240501182759.2934195-1-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/1/24 20:27, Daniel P. Berrangé wrote:
> Thomas proposed a new deprecation and removal policy for versioned
> machine types that would see them liable for deletion after 6 years:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg04683.html
> 
> This suggest was met with broad approval, however, I suggested that we
> could take it further and actually mark them deprecated sooner, at the
> 3 year timeframe, and also fully automate the enablement of the runtime
> deprecation warning without developer intervention on every release
> cycle.
> 
> This series implements my suggestions.
> 
> The first patch introduces some helper macros and documents a standard
> code pattern for defining versioned machine types across targets.
> 
> The next 6 patches convert existing targets with versioned machine
> types (arm, s390x, ppc, m68k, i386) to use the new helper macros and
> code patterns.
> 
> A further patch introduces some helper macros for automating the
> handling of deprecation and deletion of versioned machine types.
> 
> Two more patches then enable the deprecation and deletion logic
> across all versioned machines
> 
> Finally we do some cleanup and document the new policy.
> 
> ........a tangent about VERSION file handling.......
> 
> One oddity here, is that during the development and release
> candidate phases the automatic logic in this series has an off-by-1
> error.
> 
> This is because when we, for example, add the "9.1" machine type
> versions, the VERSION file is still reporting '9.0.50', and then
> '9.0.9{1,2,3,4}'.
> 
> IOW, during development and in rc candidates, we fail to deprecate
> and delete 1 machine type. We should already have deprecated the
> 6.1 machine types, but the most recently deprecated is 6.0.
> This is pretty harmless since the final release does the right
> thing.
> 
> I wonder, however, whether we would benefit from changing how we
> update the VERSION file.
> 
> eg instead of re-using the micro digit to indicate a dev or rc
> snapshot, represent those explicitly. eg "9.1.0-dev" and
> "9.1.0-rc1", "9.1.0-rc2", etc in VERSION.
> 
> We don't use the full QEMU_VERSION in the code in all that many
> places. It appears in some help messages for command line tools,
> and in QMP query-version response, and in a few other misc places.
> At a glance it appears all of those places would easily handle a
> tagged version.
> 
> For release candidates in particular I think it would be saner
> to show the user the actual version the release is about to become,
> rather than the previous release's version. This would make the
> reported version match the rc tarball naming too which would be
> nice.
> 
> Anyway, this isn't a blocker for this machine type versioning
> proposal, just a thought....

I would agree with such a change. The version numbers always confused
me. AFAICT, only QEMU_VERSION_MICRO would need some massaging. It
shouldn't be too complex.

For the series,

Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> 
> Daniel P. Berrangé (14):
>    include/hw: add helpers for defining versioned machine types
>    hw/arm: convert 'virt' machine definitions to use new macros
>    hw/s390x: convert 'ccw' machine definitions to use new macros
>    hw/ppc: convert 'spapr' machine definitions to use new macros
>    hw/m68k: convert 'virt' machine definitions to use new macros
>    hw/i386: convert 'i440fx' machine definitions to use new macros
>    hw/i386: convert 'q35' machine definitions to use new macros
>    include/hw: add macros for deprecation & removal of versioned machines
>    hw: temporarily disable deletion of versioned machine types
>    hw: set deprecation info for all versioned machine types
>    hw: skip registration of outdated versioned machine types
>    hw/ppc: remove obsolete manual deprecation reason string of spapr
>      machines
>    hw/i386: remove obsolete manual deprecation reason string of i440fx
>      machines
>    docs: document special exception for machine type deprecation &
>      removal
> 
>   docs/about/deprecated.rst  |  12 ++
>   hw/arm/virt.c              |  30 +++--
>   hw/i386/pc_piix.c          | 252 +++++++++++++++-------------------
>   hw/i386/pc_q35.c           | 215 +++++++++++++----------------
>   hw/m68k/virt.c             |  53 +++++---
>   hw/ppc/spapr.c             |  96 +++++++------
>   hw/s390x/s390-virtio-ccw.c |  98 ++++++++------
>   include/hw/boards.h        | 268 +++++++++++++++++++++++++++++++++++++
>   include/hw/i386/pc.h       |  32 +++++
>   9 files changed, 666 insertions(+), 390 deletions(-)
> 


