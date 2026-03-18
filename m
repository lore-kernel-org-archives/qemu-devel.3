Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACFF103E18B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2reB-0006E8-BA; Wed, 18 Mar 2026 10:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w2re8-0006DO-H9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w2re5-0005ee-VV
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773843192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUKFDcF/eO64vgTd59UYgSrhBZZ2lBaSNEAFegVROnU=;
 b=Vj5UezgBr4sM5aV+LdljlzgVYHfoW7OexA1r1g7Q2eZJq4Ppwv1fCvOJ7ZB6dqbTCIgiTp
 5QoWRoyo5mMisXwX/VtaL4ACguPJeezh2oXpbFusMaT5pNFIu6fl2r5yz5KpUlYFeE8qrL
 1W2e5SJe4QU/uAXiPA1qyIU7EveeHB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-pL4_ItAuOcS09a2bqFQorw-1; Wed, 18 Mar 2026 10:13:09 -0400
X-MC-Unique: pL4_ItAuOcS09a2bqFQorw-1
X-Mimecast-MFC-AGG-ID: pL4_ItAuOcS09a2bqFQorw_1773843188
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso6048201f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 07:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843188; x=1774447988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUKFDcF/eO64vgTd59UYgSrhBZZ2lBaSNEAFegVROnU=;
 b=TLf7yxb0Sfqm+8s2+ZXoNEvAvXo9miVXtE2bwkkTGCjZkdWG+fiGtOxNFa4cJiGPuJ
 Utr7IqTA6pUulGF0hf9D7y7+oO2lWThR8eJA5C/TB+F59tt6j2jib29nfvEa7KaBc+h/
 TmG3PWbDvjuANuzfxDN7YoDFMDe8FPrN99Ez32skdVGE2gpR98+SW3xZJ8XiivJ6SHRC
 8HrZigjHBGEXC+gbsr2uNFQNM8BOPBmbeF8P8q4sAnHEbl4onYM5wnOFYn6cXdAxnHKM
 0VemtW+J0AaGkwg/8d+bkkL2/0TJw7+40WpfZqZ54YRlLNf34WJU+uoqmo27AI2N8aZI
 6s+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8WsqvbHHAm4rw0oz9l/tA8+SRfB+UJUrVikFdYRXSrzYChgajbGvnqOf9TUdA56mFIlvvIuLlyKX4@nongnu.org
X-Gm-Message-State: AOJu0YyFAQUL4VJiHS2Zg38zctf8U7pf+HoBPHctZsmFhIBbz1GHHWOf
 1oyoUYOrLO0pu82Lv9i/BPrZR8HAFkbHyQqQJZPwkdftim/7ftj7CfvB6MRLMiSWbq8vG0Ikk2R
 MjBqwdo0EqzETvYjOYtzo2z76+xM7NNWENla0BZf6BBGuZEZzwFslGLwb
X-Gm-Gg: ATEYQzzNuMwMP/Y6GY7tx3YnraE5Wynfx8c9WF7NoXXKbKINJhYpv+C+rmko8+o/TfE
 I0XrkPD17+91jXqXB0/5aSw9T6YyvFO0UHOlzjuSVh/PoNTJq6sAqrYyXKvdEFE3+SCOC2UvULo
 T2JugdH57O/SzBSxCDPbPCD7pH32NSzagR6MGvKuMcXL6r+kixyvqjMFNjhxbw9A5lwdTkl5SBs
 7MekIIm5dw8L+o1ofLVCa023j7l88F+ABsgvTS6tvQzy2R/MKqQG3c2PUuT0yVO18HtJXEUhGvu
 0S2mMrIwNeC9gyg0RO8eI2wLg7tphKs1jI5bsjz2xSmo8CMrX/GRUCn7cZer1vNXRzgMBDyYo2X
 d2jJC3PKB796pzROTUIDWsYnQouhSDCImumxEtgS2a17IU5GsiougOvfCUaWWmQfn0KStvg==
X-Received: by 2002:a05:600c:3491:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-486f4450338mr58867175e9.24.1773843188267; 
 Wed, 18 Mar 2026 07:13:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3491:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-486f4450338mr58866535e9.24.1773843187726; 
 Wed, 18 Mar 2026 07:13:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e5495csm36268005e9.2.2026.03.18.07.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 07:13:07 -0700 (PDT)
Message-ID: <b65e3f7c-c8cd-42a4-8eae-b673e406a31c@redhat.com>
Date: Wed, 18 Mar 2026 15:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v3 0/8] hw/arm/smmuv3-accel: Support AUTO
 properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Nathan,

On 3/17/26 7:37 PM, Nathan Chen wrote:
> Hi,
>
> This is a follow-up to the previous series [0] that introduces support
> for specifying 'auto' for arm-smmuv3 accelerated mode's ATS, RIL,
> SSIDSIZE, and OAS feature properties.
>
> In QEMU 11.0 we introduced new options for vSMMU [1], but feedback received
> when starting the integration of layered products shows the need for
> auto/host-retrieved values. To avoid breaking JSON/QMP compat, we want
> to fix the option types so that they can later support the auto mode. At
> the moment the auto mode is not supported though.
>
> A future series will introduce support for resolving the 'auto' values
> based on host SMMUv3 IDR values, as well as setting per-device ATS
> capability.
>
> A complete branch can be found here:
> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v3
>
> Please take a look and let me know your feedback.
>
> Thanks,
> Nathan
>
> Changes from v2:
> - Enforce 'auto' value not being supported for HW-accel SMMUv3 props
> - Revise docs to mention auto is not supported and these properties
>   are only applicable when accel=on.
> - Only override non-defaults in smmuv3_accel_idr_override()
> - Remove check for SSIDSIZE AUTO in smmuv3_accel_idr_override() as
>   smmu_validate_property() checks for AUTO beforehand
> - Consolidate comments for ssidsize_mode_to_value()
> - Include Fixes tags in commit descriptions
> - Include R-by tags from v2
>
> Changes from RFCv1:
> - Remove changes that resolve the 'auto' values based on host SMMUv3
> - Restore defaults values for RIL, OAS, SSIDSIZE, and ATS
> - Update OasMode to accept all OAS sizes instead of only auto, 44, and
>   48
> - Include comment in SsidSizeMode schema clarifying enum value
>   ordering
> - Replace ats-enabled prop with a helper that accepts the dynamic
>   casted TYPE_ARM_SMMUV3 object
> - Separate out guest vs. host ATS check in
>   smmuv3_accel_check_hw_compatible() to a different commit
> - Document accel, RIL, OAS, SSIDSIZE, and ATS properties in
>   qemu-options.hx
>
> Testing:
> Basic sanity testing was performed on an NVIDIA Grace platform with GPU
> device assignment and running CUDA test apps on the guest. Additional
> testing and feedback are welcome.

Feel free to add my
Tested-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> [0] https://lore.kernel.org/qemu-devel/20260312210328.2016191-1-nathanc@nvidia.com/
> [1] https://lore.kernel.org/all/20260126104342.253965-1-skolothumtho@nvidia.com/
>
> Nathan Chen (8):
>   hw/arm/smmuv3-accel: Check ATS compatibility between host and guest
>   hw/arm/smmuv3-accel: Change ATS property to OnOffAuto
>   hw/arm/smmuv3-accel: Change RIL property to OnOffAuto
>   qdev: Add a SsidSizeMode property
>   hw/arm/smmuv3-accel: Change SSIDSIZE property to SsidSizeMode
>   qdev: Add an OasMode property
>   hw/arm/smmuv3-accel: Change OAS property to OasMode
>   qemu-options.hx: Document arm-smmuv3 device's accel properties
>
>  hw/arm/smmuv3-accel.c                    | 43 ++++++++++++++++++----
>  hw/arm/smmuv3.c                          | 45 ++++++++++++++++--------
>  hw/arm/virt-acpi-build.c                 |  2 +-
>  hw/core/qdev-properties-system.c         | 27 ++++++++++++++
>  include/hw/arm/smmuv3.h                  | 11 +++---
>  include/hw/core/qdev-properties-system.h |  6 ++++
>  qapi/misc-arm.json                       | 44 +++++++++++++++++++++++
>  qapi/pragma.json                         |  1 +
>  qemu-options.hx                          | 35 +++++++++++++++++-
>  9 files changed, 187 insertions(+), 27 deletions(-)
>


