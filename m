Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D32F013C5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22a3-0002p5-5J; Mon, 16 Mar 2026 03:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22a2-0002oi-0N
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22Zz-0003kx-Mb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773646894;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtMYXrBa6J3JvksFjNHT5TmbtzMJB16I0jV3di2ysTc=;
 b=hcL9zzRL5QhIcEcjWoa7f1bwRQAXbW1GiuYlFsCf6iCly628veri04g2jN2BfoTnImFsGV
 Xo5P+U+IqLtTpl47+RfH/0f6lB4n7dTxNkTSjmyWcPQG2E1aAeliGEihYjc11JNenlXgfm
 Nl3s4T6qbLA+E8JbcCtnbksKtfYOTOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-bqDELDnrPPGXQ7unZl86Gg-1; Mon, 16 Mar 2026 03:41:32 -0400
X-MC-Unique: bqDELDnrPPGXQ7unZl86Gg-1
X-Mimecast-MFC-AGG-ID: bqDELDnrPPGXQ7unZl86Gg_1773646892
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso36771155e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773646892; x=1774251692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtMYXrBa6J3JvksFjNHT5TmbtzMJB16I0jV3di2ysTc=;
 b=GIorByuGzAwG/bWTWQLp+SZGBc4MVWcOXkhVIISmJhYBhn+d8HEC0ducJCYzWBYyNq
 etpt3tuOy2ROAaX/4Pj/sgDrUJfVlBhv/Ip2NQUEOQz3TBmVXLpEswp2+MNTfkMPFyyG
 6cSR/EO6jXqarUbrkAlXTNKIvsxYuc/3MwF3Y06ZZ8PLQ19W8F3MEwOVBR+AFubDyBe2
 L+p6u/tKvZiZl3muuegcX8qahzdZVeRrTye2mFPhf3Srt1tOqiepVGazuEeE5uSEk6g8
 OpphQlYmW1p0hgu+WmbBIKMJnqeZeGHHu0ZX6GX9fElSbXQ46YBdn5nhMwaN0+I4HMZr
 2vlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG8ZlXBCbmp8Ee0uTJMJ3nXSkePrnuuaiGYK/BPIIlxOMM9+Rs8kfgch4pVuaGGqQdBLsnkw9PFyuK@nongnu.org
X-Gm-Message-State: AOJu0YyYXzruLib7r4EkqpVXlxXZLUNmA+6BppqelSFa0jnTbe0/YVrc
 q/AlwN3YKg/QcLiz10+tYIFSsjbFd1BbXEZMrpAtBYKf+4Z9aOGwIwdAKc+46Na2Q44NZQKmBWm
 JXh5mr6uuozri58mMlNhOlLwLez488zOcCZp18r1BWqJcMCzzz4X0nJ0p
X-Gm-Gg: ATEYQzzHRRMle/89MjLvnIxW8rvq9/ZdtMU6ilxpY64blqROX8njxe750spn3jaQOy+
 +mDwD6fnwluTYceUSV7qL8BmAV0KZ1ibqVyak+YTtmY86LMq2Q60bEaelTHqMugFkHZ7/64prIV
 oG40/hDOV46i8DJzGcSZUqLt/MOyuNKkH6vKXrP4TPg+cybtXqjAGmSwqYEvLY2frDq0VwrzqLb
 vxY/ufG/+F5pvuRxSWYANxlKl74KjkK4Iw0RG7J2pxqszgM5t5Wgn0pN7Lyt8AJFsJ7uanKjHtE
 UJupjkXjkQSHfDMY6mrH6RZU6hBxmLebkc2aN6JToUQ/ILNay4XG0ntUYS8jv/U69yT8khjfw5i
 U1MfS63lcghRh/Wd77/aR6g8677zbrauWBi2YOW6jQYMXwE5R+WBADMj6Ua3WWJosIXOCPA==
X-Received: by 2002:a05:600c:4752:b0:485:3dfc:569 with SMTP id
 5b1f17b1804b1-48556700c54mr198167425e9.16.1773646891643; 
 Mon, 16 Mar 2026 00:41:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:485:3dfc:569 with SMTP id
 5b1f17b1804b1-48556700c54mr198166985e9.16.1773646891201; 
 Mon, 16 Mar 2026 00:41:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6756e4sm469142155e9.15.2026.03.16.00.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:41:30 -0700 (PDT)
Message-ID: <2bc83190-9e8d-4d3d-b0f9-9831a8d9783a@redhat.com>
Date: Mon, 16 Mar 2026 08:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
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
 <20260312210328.2016191-4-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-4-nathanc@nvidia.com>
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
> From: Nathan Chen <nathanc@nvidia.com>
>
> Change accel SMMUv3 RIL property from bool to OnOffAuto. Setting 'auto'
> will use the default set in smmuv3_init_id_regs(), i.e. 1 in IDR3 which
> translates to 'on'. A future patch will implement resolution of 'auto'
> value to match the host SMMUv3 RIL support.

Please a check to test the AUTO value is not set at the moment.

Add the Fixes tag too. Otherwise looks good.

Eric
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 8 ++++++--
>  hw/arm/smmuv3.c         | 4 ++--
>  include/hw/arm/smmuv3.h | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 5d14abe307..6f44fd3469 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -824,8 +824,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>          return;
>      }
>  
> -    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
> -    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
> +    /* Only override RIL if user explicitly set ON or OFF */
> +    if (s->ril == ON_OFF_AUTO_ON) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> +    } else if (s->ril == ON_OFF_AUTO_OFF) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
> +    }
>  
>      /* Only override ATS if user explicitly set ON or OFF */
>      if (s->ats == ON_OFF_AUTO_ON) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 862ca945d5..acbd9d3ffe 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1972,7 +1972,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>  #endif
>  
>      if (!s->accel) {
> -        if (!s->ril) {
> +        if (s->ril == ON_OFF_AUTO_OFF) {
>              error_setg(errp, "ril can only be disabled if accel=on");
>              return false;
>          }
> @@ -2132,7 +2132,7 @@ static const Property smmuv3_properties[] = {
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ce51a5b9b4..c35e599bbc 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,7 +69,7 @@ struct SMMUv3State {
>      struct SMMUv3AccelState *s_accel;
>      uint64_t msi_gpa;
>      Error *migration_blocker;
> -    bool ril;
> +    OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
>      uint8_t ssidsize;


