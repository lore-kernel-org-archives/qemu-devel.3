Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C081075289
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3AC0-0007dz-9K; Thu, 19 Mar 2026 06:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w3ABv-0007Yc-3B
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w3ABr-0005LQ-Ic
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773914478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJR+FB4zupFa66r5+UpSLHi8qpJ2cK2sdEqWdSTj9LY=;
 b=D8sUCy8kuj3JHf1CQ6q+jr0UhYNeGLTfhPIRLVOrfyGraRo4ZRszLmFDJSP8UA4EIxAuAb
 RJq1XGTk3lO55h7AP/vCWWx1iJtM9ad9jTV8Or8cmSfpLhcFFm1wXhpAAk0ZhUEutUHOID
 vTRo7nBVL1BShBYGzLPaF4hfpz+rwlc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-1LBfwTOEPcidIRrz-jk9gA-1; Thu, 19 Mar 2026 06:01:17 -0400
X-MC-Unique: 1LBfwTOEPcidIRrz-jk9gA-1
X-Mimecast-MFC-AGG-ID: 1LBfwTOEPcidIRrz-jk9gA_1773914476
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b4dcdb372so424806f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773914476; x=1774519276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJR+FB4zupFa66r5+UpSLHi8qpJ2cK2sdEqWdSTj9LY=;
 b=W/vvjHX873RDltWdUgN1KCZ+a7VM6hnbCHfGPD2V1Sccwa1r1Fm6a9Pp/fh/PuZK7Q
 S930VGh4quP3pHuKkbRJTxpnIE/wCOUsfFh4ewfH99HhMT6+uVPaJbOHoo9f/1La7Nok
 rUXLoA808P8kmAG1N/RR0ddTzgWDqHjD6Nww1gT6uJxjRhpaQIYKEadoZ+Ttun+5l75s
 QkZp+Ty9Ow+bPMWzS+faM1VH14vdnUNSOMA12sm256QzuYRakIuIaa/PGsusr9+h8DtI
 ZJKjw2pzJ68hpyA6W2Dm2gYu4iv0tldwwyk2Z2FrIejXB2G89dgnTu/xqMTFAV6Fl3h4
 gALA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXImgKaFsZC6Aq+42mYl45LwCE/ztHgzGklsWmFlYq2t6pyDbiHmS48Or5n7jD2jjVHgSeSyN36LJ2T@nongnu.org
X-Gm-Message-State: AOJu0Yw4WWr3TL1Nsd8nPNEvwZgaC3S3mI8eJE7sL5pW8jWI/jUs1SWK
 WFwb80kujA9kFjKoQMXEileBKrpQHAmExG4Qmr2/aW9uTuKPGy4kgLRuGN9Lp9qst9mhALYMR2I
 qg8hpP20BqHfRwTyHkb2uEX+C6R96A2RNDiCperYi4NGtppItc3rXJWst
X-Gm-Gg: ATEYQzzo1tk2D438uobPfCPcAA0sJLvm5PZHQDuxDgsb6MCiOVFMnI1OdiY+g5qqINZ
 ZvH02MAe6XdBbOYvNYjO4YAIAGCdR0S9jRmTD7neruQgZL0s17U8GYanexJ8GZSFc4XK2wpT9hJ
 El+Tbsx/1SGVf1lJ7fsXVSFAq4ZpecYRSXyCYwxqTdUnVLs7FPSbaBlkpAXOq73fDSh6QME6/ae
 XrO5eOHE4i4LM5Xu5ga789c5S2yaT8n0KclJQPYkYuUCIaE9rxvVUHUig/vxOOto4W4Nz8ipOC6
 1iilnCu6jF0iqULAcrH+knywQQmWJNheph7Cpb1QJQWR4z2oCVv1F2OsZCEWSBtB0S33d3vDO8+
 ifR0vPXcMBMElUh0pdj9IoDasDBoWp7IST/cYF1d8Mo7xIv8gRlAdr4TNuAzXAtO4jkufjw==
X-Received: by 2002:a05:6000:2307:b0:439:afd8:621c with SMTP id
 ffacd0b85a97d-43b527d2f29mr11603152f8f.55.1773914475545; 
 Thu, 19 Mar 2026 03:01:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2307:b0:439:afd8:621c with SMTP id
 ffacd0b85a97d-43b527d2f29mr11603067f8f.55.1773914474978; 
 Thu, 19 Mar 2026 03:01:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a3d78sm16275311f8f.34.2026.03.19.03.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:01:14 -0700 (PDT)
Message-ID: <28a0a449-3f5f-413d-9e12-4a9b90795a10@redhat.com>
Date: Thu, 19 Mar 2026 11:01:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v4 0/8] hw/arm/smmuv3-accel: Support AUTO
 properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/18/26 7:48 PM, Nathan Chen wrote:
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
> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v4
>
> Please take a look and let me know your feedback.

Thank you for having respinned quickly. This looks good. All patches
collected R-bs and this was tested.
This brings (late) fixes to features introduced in qemu 11.0. Changing
the option types is future proof because layered products notified it
was tricky to retrieve the host values for those parameters. If we
really care of not breaking JSON/QMP compat, it is still time to
consider getting this in 11.0.

Thanks

Eric
>
> Thanks,
> Nathan
>
> Changes from v3:
> - Revise auto support error message
> - Restore original comment for ATS in smmuv3_accel_idr_override()
> - Update the description in object_class_property_set_description()
>   to mention auto mode not supported.
> - Move auto mode check before check for accel=on
> - Remove SMMU_OAS_44BIT/_48BIT and SMMU_SSID_MAX_BITS defines
> - Consolidate documentation notes about properties only being
>   available for accel=on and not supporting auto mode.
> - Include R-by and T-by tags from v3, thanks Eric and Shameer!
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
>
> [0] https://lore.kernel.org/qemu-devel/20260317183755.3721625-1-nathanc@nvidia.com/
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
>  hw/arm/smmuv3-accel.c                    | 41 ++++++++++++---
>  hw/arm/smmuv3.c                          | 63 +++++++++++++++---------
>  hw/arm/virt-acpi-build.c                 |  2 +-
>  hw/core/qdev-properties-system.c         | 27 ++++++++++
>  include/hw/arm/smmuv3-common.h           |  3 --
>  include/hw/arm/smmuv3.h                  | 11 +++--
>  include/hw/core/qdev-properties-system.h |  6 +++
>  qapi/misc-arm.json                       | 44 +++++++++++++++++
>  qapi/pragma.json                         |  1 +
>  qemu-options.hx                          | 32 +++++++++++-
>  10 files changed, 192 insertions(+), 38 deletions(-)
>


