Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A0C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHrX-0007mZ-TD; Thu, 20 Mar 2025 11:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tvHrO-0007js-Vz
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tvHrL-0002Mz-SR
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742484661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FHzTTbYYErG3BHAoth3Rm1XEBwqah4VOUhcwHJtuowg=;
 b=P0nzilu+0tKtNmBwO/qSV7urG8/ZltOZpWeqtjNX8P+tZLjQbOrpXmT5KseRNUAAjk37pB
 9TqSaEOXRA4HOOIt6lkT+01fTS0Y7KfhssvBS45WGVs3xHMz6CBG6f7NYt7oM017DfR/fQ
 c9IX0aYhlZ2wOXjRJrDMtLvuT9eSc84=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-_U8cbHbhO4eVCeUc537v7w-1; Thu, 20 Mar 2025 11:29:45 -0400
X-MC-Unique: _U8cbHbhO4eVCeUc537v7w-1
X-Mimecast-MFC-AGG-ID: _U8cbHbhO4eVCeUc537v7w_1742484585
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39143311936so474174f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742484584; x=1743089384;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHzTTbYYErG3BHAoth3Rm1XEBwqah4VOUhcwHJtuowg=;
 b=avy9y9A6q33CrjCpeLO+o8EFkiV49fxvjci3Tw7sHP5AJV13S5kaMXQ34ED9hiJOF3
 1DXasbZTcv7wCsKgynLkT/5BB0Ph0fRdQJYyeNcrsBhqM9YyJzbTJzyJxWWhcy4hknu3
 DK8a2P7PLr4qyHvj/KHW8Hr9SVj8Yuzm592uBO6yElOrlab0TI/72DDsOjAnXbyFq6Ev
 b17Wbr5VwJkO78kSXAxbz/38LIe8a4b9sic/nhefwwWL3gvZqgNqER4IJzOze2VSBhFj
 LAHvzIxskXKy60PLkg2WiRAgg9HXouDsbBxA+CVvBQ8Nilc9TBmVzU8dY0N7d2S1KUtE
 7Mcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdNE7lxPbhW2709+WPNa4TTKCbiZ2SeXmrwjxaBeACDm4IaBG1h1XcI9SL7YN8HubijKw3/6g8S7IU@nongnu.org
X-Gm-Message-State: AOJu0YxQzRr0rVhhSRNDppBvwleLyrl+cU5C/3Bf0KPwSwe0Kv7hxw/d
 NBNGUeD3bksq+xV5iDcb9Qo2UBn4sqWHqrMv03RUQiCyVxgsO3ve0arsd5erggp1BXPxvBOh7oS
 PgYU1sV79liKLivQVbOhl7vQCZzDigKukWEQk2gdEV6BHGS17nmoh
X-Gm-Gg: ASbGnctR+Za3zAZTPPSNhNvSEPbvy+kcUgxQaFBDGGwjpugktthlL/lqDvEk7SfpksG
 85mCqSAYP0S3LSrDF1WEa+oEiktvttdb9Y+CQxRce7JMDKlhPfQHFz+dYKIh8gFhwaKj+C0AHQJ
 JsD5BekevV+STFRhCe4gyO3lLRD2JB7tIfUndhf7ui0xM810bZJ9VR8nCMKVoBhgepbri3Nbop/
 2Kxe2s22f4aChvM7zvkOi6VtOwDz5VM8B4aO6frvqrSeU+GOIJC/EjLsmS6L0x7qR9in/lG/0vv
 /XC3QfUC4sWbC+nbkvx0vkm1IcKqWsjpffSo+272YlSwLHzzg23gZtsFd5HKCoxr
X-Received: by 2002:a05:6000:1564:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-399739bca2emr8416862f8f.14.1742484584437; 
 Thu, 20 Mar 2025 08:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXy+T6AX+SYujMTq96rpZX7KePBdG47XdfU/eRIThKezdv+D2LaJTOVhbidce5pfIbHAeHZQ==
X-Received: by 2002:a05:6000:1564:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-399739bca2emr8416824f8f.14.1742484583976; 
 Thu, 20 Mar 2025 08:29:43 -0700 (PDT)
Received: from rh (p200300f6af11ec00f9928575aec32536.dip0.t-ipconnect.de.
 [2003:f6:af11:ec00:f992:8575:aec3:2536])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3adc4488sm54468955e9.0.2025.03.20.08.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 08:29:43 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:29:41 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 13/14] arm/cpu: Add sysreg generation scripts
In-Reply-To: <20250311162824.199721-14-cohuck@redhat.com>
Message-ID: <17649857-752b-a149-3935-5bcbd5c50627@redhat.com>
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-14-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, 11 Mar 2025, Cornelia Huck wrote:
> +++ b/scripts/gen-cpu-sysregs-header.awk
[...]
> +BEGIN {
> +    print ""
> +} END {
> +    print ""
> +}
> +
> +# skip blank lines and comment lines
> +/^$/ { next }
> +/^[\t ]*#/ { next }
> +
> +/^Sysreg\t/ || /^Sysreg /{
> +
> +	reg = $2
> +	op0 = $3
> +	op1 = $4
> +	crn = $5
> +	crm = $6
> +	op2 = $7
> +
> +	if (op0 == 3 && (op1>=0 && op1<=3) && crn==0 && (crm>=0 && crm<=7) && (op2>=0 && op2<=7)) {
> +	    idreg = 1
> +        } else {
> +	    idreg = 0
> +	}

This doesn't seem to be used. I guess this is in preparation for later
usage, when this can do more than just the plain register definition?

Sebastian


