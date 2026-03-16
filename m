Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264AEF013C5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w231b-0006y4-8I; Mon, 16 Mar 2026 04:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22zm-0005cz-Nk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 04:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22zj-0002Hv-HO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 04:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773648490;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAFvNhrUgUGWXqlQg3jJvBrtZYCMzhU1q1yjSGG0fiE=;
 b=WCYKfocO0rMtOw3Pv5OqSitpkNeInpIToCDDXzSAfor15i4kGMsU3jn5TpKnNfcVcSaD1Q
 vtbpWs5eMqADiXYfFoVD4tgU6I2dIsiQ7SQ2/oD71QcMux/zJHvdMPx3AndsYEWF2z2Krc
 tmQdGxbmo4x/266+C+Lar3hcQLFMmcg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ZeNK_s2sOLa3-DsW1SS3Og-1; Mon, 16 Mar 2026 04:08:08 -0400
X-MC-Unique: ZeNK_s2sOLa3-DsW1SS3Og-1
X-Mimecast-MFC-AGG-ID: ZeNK_s2sOLa3-DsW1SS3Og_1773648488
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b4730dad8so127147f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 01:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773648487; x=1774253287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAFvNhrUgUGWXqlQg3jJvBrtZYCMzhU1q1yjSGG0fiE=;
 b=ZKklR48NQN18c6wc3FfGie2lrbFOHu4GBdtc6KsxX4N2m4/ORjsB3n7hlysYwbfCxf
 vEPVlhMqqyeyu3z8PqhhbqhN0NPD08XcC2FEc41kP7ykWhYaLhdBvql5IBO6qwkCGZOI
 tzA7TdOkNaP/6lDVmBbMNOrgzcjSAeyAbegGnneDmT+99Kk3ajspIqt1HfYhwVwZ7DtA
 tohujcFNK6tzRajtM3e4bWUhUOtKFfhUyrq58UM7RT/B1hm7HrRKWj2Rt0pI1k8GGE1O
 dnGh6cGqpy4qDraCjEDLL+RMgYDXGmfwri8y34lq4VmPSpHw5FVxQqlXvfxVpKv0N4uQ
 OFxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHY/qVH1NH8nPi162RYBFx7H0iVsE6YucRVWfO4O10CgpwDVrihPAtc/uygkL1/Dhv4cjowiZHZf3@nongnu.org
X-Gm-Message-State: AOJu0YzNicB9dzM2JlTzN6lzBaVdoknmVVhV+QvBzvjDQskDFMYXavqz
 wnscX67zg+mJNMiNbW092/xAh2T0OXfc8M34Z9WuAELj4Gu05WnxAypC2VhZd1fXU0V3r6vYoGU
 fueCAf7txjV3dI5TzyyyP9K2z/iSD4ValhNtDNZS2OblgV7emLx03LJqss3/0FRDm
X-Gm-Gg: ATEYQzx9+r5zmDJdcB55iCqqhclnNZQU3YLDYbHOsN4VlnF057CvoukJZJ2+VxJLUDw
 n6lXUtRoIyhbc7d2FPiTRtLYM0fzyoWSkh/Q7+YWGGO8+VDq6bRQbbY9pk1PO8idurO/f75e0ED
 7Q6UpixeM2neqobAtVrEgtbNMri+1aX3+M5HGLaDTHm3enNUMQBu75TNMqc1ILXP4BjIr8Iag4i
 aUpMA+cPcw1q2U9UNFyaDTAm9jJHNQmj1tfonGSUwl7gcmP9wJc7yBn07ZkLi72AAHP6r/ZOO+w
 jYzT4AWpGTJg1r4TemAuyhJ2YZJUKDMJgdv3uQNqgVRJNwc2lw82epn8xZ1lMmT2/kXDUBXXXz/
 Y9qJOBBRuY42E5Bbpyf5aSnaPZziNmiPH2wOLcD+krmQ/2pAwSuryHv5+trFX1CNaURRPoQ==
X-Received: by 2002:a05:6000:26d0:b0:439:b6f1:cd8d with SMTP id
 ffacd0b85a97d-43a04da7c89mr22219595f8f.28.1773648487121; 
 Mon, 16 Mar 2026 01:08:07 -0700 (PDT)
X-Received: by 2002:a05:6000:26d0:b0:439:b6f1:cd8d with SMTP id
 ffacd0b85a97d-43a04da7c89mr22219539f8f.28.1773648486568; 
 Mon, 16 Mar 2026 01:08:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b419270efsm9699773f8f.16.2026.03.16.01.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 01:08:06 -0700 (PDT)
Message-ID: <a0ca818f-8e05-4756-b6bb-8f986c59cd54@redhat.com>
Date: Mon, 16 Mar 2026 09:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
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

On 3/12/26 10:03 PM, Nathan Chen wrote:
> Hi,

If we want this to be taken in qemu 11.0 you need to clearly indicate
that in the series title:
using a subject prefix like "PATCH for-11.0"

Then you need to clearly justify what those patches are fixes for stuff
introduced in qemu 11.0, something like:

In qemu 11 we introduced new options for vSMMU but feedbacks received
when starting the integration of layered products shows the need for
auto/host retrieved values. To avoid breaking JSON/QMP compat, we want
to fix the option types so that they can later support the auto mode. At
the moment the auto mode is not supported though.

Thanks

Eric


> This is a follow-up to the previous RFC series [0] that introduces
> support for specifying 'auto' for arm-smmuv3 accelerated mode's ATS,
> RIL, SSIDSIZE, and OAS feature properties. Based on feedback from the
> previous mailing list discussion, this refresh only converts the
> properties to the auto form, keeping the default values from
> Shameer's HW-accel SMMUv3 series [1]. A future series will
> introduce support for resolving the 'auto' values based on host
> SMMUv3 IDR values, as well as setting per-device ATS capability.
>
> When set to 'auto', RIL and OAS will use the defaults set from
> smmuv3_init_id_regs() while ATS and SSIDSIZE will remain at the
> initialized 0 value; i.e. RIL enabled, 44-bit OAS, ATS support
> disabled, 0-bit SSIDSIZE.
>
> A complete branch can be found here:
> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v2
>
> Please take a look and let me know your feedback.
>
> Thanks,
> Nathan
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
>
> [0] https://lore.kernel.org/qemu-devel/20260309192119.870186-1-nathanc@nvidia.com/
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
>  hw/arm/smmuv3-accel.c                    | 42 ++++++++++++++++++----
>  hw/arm/smmuv3.c                          | 38 ++++++++++----------
>  hw/arm/virt-acpi-build.c                 |  2 +-
>  hw/core/qdev-properties-system.c         | 27 +++++++++++++++
>  include/hw/arm/smmuv3.h                  | 11 +++---
>  include/hw/core/qdev-properties-system.h |  6 ++++
>  qapi/misc-arm.json                       | 44 ++++++++++++++++++++++++
>  qapi/pragma.json                         |  1 +
>  qemu-options.hx                          | 29 +++++++++++++++-
>  9 files changed, 169 insertions(+), 31 deletions(-)
>


