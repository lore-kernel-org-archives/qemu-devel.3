Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51F5C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 10:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQlq0-0002Gk-Mf; Mon, 08 Jul 2024 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sQlpy-0002Fz-Hp
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sQlpw-0004e8-Ng
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720435391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bi469o/fVlUZREiTWiZmZr48bcGGON5dIfvtUPqFN1U=;
 b=haKirZnJCZFm3VvlHTVcv8HAc8EYfo1lFdcnDonLJY5lkIEdw9olrq+lSMOBHSd9zvkP5B
 G17q/jHL526SywzOSRWAv1M4bHyGTDY/EwCjfuudjx8l/jJPsDdqFeRzqtJnLrmwvyJW3F
 Z8BawATBRfqROsK0O0Dll4GHxI29pZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-cZ2pP1RYN1u0NF-mCgk5Bw-1; Mon, 08 Jul 2024 06:43:10 -0400
X-MC-Unique: cZ2pP1RYN1u0NF-mCgk5Bw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4266d0183feso2687275e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720435389; x=1721040189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi469o/fVlUZREiTWiZmZr48bcGGON5dIfvtUPqFN1U=;
 b=cXkFPrO2HfHU+rn4QA94ZYW8lpP0qarlkbZs0aqLDYb1PgkPv+ax6lN8T1ynyTZYgs
 94mf66+T+xcemMccqdI1SmXSAAKn+ZqdLRwczwYHSpU3GRULZJH2GW/3DEqseplV8PDy
 R2x0/r0oUg/j00LrC1ySZm6eFRPj4kl/cTpvLQ+ajBUXzgNWuXVZupgS3ZZQtaoIiVaX
 I+alYe+uxhqX/Cdg8pLm4rUDjj6k7AWHDuZP8cC6zu3R9oQShrXi5rGrvm0YUom/z6mm
 21PhlbBLLv0DsvgVg9hUxsFU5zA6SEeXnArivbElPxVFu/jsjqkBmpt+DixpEauX0lvf
 5Iog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSezGyVF/KQlCeJ0LK0UqdAwTkXvqko56C0K+Rcj5hlUui1A8iPkyLiA0G/33TYwmuTUFzt4MPoG1ADa+WUP4tY2fdps=
X-Gm-Message-State: AOJu0YzxLCzLmXanIbw/0E2YtKCFJMDBv7zjJVAkaLDznc/C8+daq3CF
 HLYXIdgVrx+Rfbr4kMQZ3F9ApEvgsEe8JZG0qnhkC7dNZzLKgxvI6DmBdlDgHKwrlHKlbpq+2No
 Uw5qA/pw56wQIFPP4WOzQsst3RZXe++ZBHpVPmyO8bjc0JwDtyrDW
X-Received: by 2002:a05:600c:5493:b0:426:6ee7:c05a with SMTP id
 5b1f17b1804b1-4266ee7c253mr51685e9.15.1720435388892; 
 Mon, 08 Jul 2024 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP2Nb11kSYxMTADcjissTE1/ZuD6dPdQyRFmBkI3VeGZqdTL5xF+FvOPCw957n1jp4C9zUtA==
X-Received: by 2002:a05:600c:5493:b0:426:6ee7:c05a with SMTP id
 5b1f17b1804b1-4266ee7c253mr51375e9.15.1720435388288; 
 Mon, 08 Jul 2024 03:43:08 -0700 (PDT)
Received: from redhat.com ([2.52.29.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f2391sm163262455e9.25.2024.07.08.03.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 03:43:07 -0700 (PDT)
Date: Mon, 8 Jul 2024 06:43:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
Message-ID: <20240708063152-mutt-send-email-mst@kernel.org>
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
 <20240708-auto-v2-1-f4908b953f05@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-auto-v2-1-f4908b953f05@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 08, 2024 at 04:38:06PM +0900, Akihiko Odaki wrote:
> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
> bool.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

There are a bunch of compatibility issues here.
One is that PROP_BIT accepts different values:


bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
{
    if (g_str_equal(value, "on") ||
        g_str_equal(value, "yes") ||
        g_str_equal(value, "true") ||
        g_str_equal(value, "y")) {
        *obj = true;
        return true;
    }
    if (g_str_equal(value, "off") ||
        g_str_equal(value, "no") ||
        g_str_equal(value, "false") ||
        g_str_equal(value, "n")) {
        *obj = false;
        return true;
    }

    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
               "'on' or 'off'");
    return false;
}

Another is that query now no longer reports the actual
bit value, it reports "auto".





> ---
>  include/hw/qdev-properties.h | 18 ++++++++++++
>  hw/core/qdev-properties.c    | 65 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 09aa04ca1e27..afec53a48470 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -43,11 +43,22 @@ struct PropertyInfo {
>      ObjectPropertyRelease *release;
>  };
>  
> +/**
> + * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
> + * @on_bits: Bitmap of elements with "on".
> + * @auto_bits: Bitmap of elements with "auto".
> + */
> +typedef struct OnOffAutoBit64 {
> +    uint64_t on_bits;
> +    uint64_t auto_bits;
> +} OnOffAutoBit64;
> +
>  
>  /*** qdev-properties.c ***/
>  
>  extern const PropertyInfo qdev_prop_bit;
>  extern const PropertyInfo qdev_prop_bit64;
> +extern const PropertyInfo qdev_prop_on_off_auto_bit64;
>  extern const PropertyInfo qdev_prop_bool;
>  extern const PropertyInfo qdev_prop_enum;
>  extern const PropertyInfo qdev_prop_uint8;
> @@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
>                  .set_default = true,                              \
>                  .defval.u  = (bool)_defval)
>  
> +#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defval) \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,         \
> +                OnOffAutoBit64,                                             \
> +                .bitnr    = (_bit),                                         \
> +                .set_default = true,                                        \
> +                .defval.i = (OnOffAuto)_defval)
> +
>  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
>      DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
>                  .set_default = true,                         \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 86a583574dd0..e1c336435e05 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -187,7 +187,8 @@ const PropertyInfo qdev_prop_bit = {
>  
>  static uint64_t qdev_get_prop_mask64(Property *prop)
>  {
> -    assert(prop->info == &qdev_prop_bit64);
> +    assert(prop->info == &qdev_prop_bit64 ||
> +           prop->info == &qdev_prop_on_off_auto_bit64);
>      return 0x1ull << prop->bitnr;
>  }
>  
> @@ -232,6 +233,68 @@ const PropertyInfo qdev_prop_bit64 = {
>      .set_default_value = set_default_value_bool,
>  };
>  
> +static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop = opaque;
> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
> +    int value;
> +    uint64_t mask = qdev_get_prop_mask64(prop);
> +
> +    if (p->auto_bits & mask) {
> +        value = ON_OFF_AUTO_AUTO;
> +    } else if (p->on_bits & mask) {
> +        value = ON_OFF_AUTO_ON;
> +    } else {
> +        value = ON_OFF_AUTO_OFF;
> +    }
> +
> +    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
> +}
> +
> +static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop = opaque;
> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
> +    int value;
> +    uint64_t mask = qdev_get_prop_mask64(prop);
> +
> +    if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
> +        return;
> +    }
> +
> +    switch (value) {
> +    case ON_OFF_AUTO_AUTO:
> +        p->on_bits &= ~mask;
> +        p->auto_bits |= mask;
> +        break;
> +
> +    case ON_OFF_AUTO_ON:
> +        p->on_bits |= mask;
> +        p->auto_bits &= ~mask;
> +        break;
> +
> +    case ON_OFF_AUTO_OFF:
> +        p->on_bits &= ~mask;
> +        p->auto_bits &= ~mask;
> +        break;
> +    }
> +}
> +
> +const PropertyInfo qdev_prop_on_off_auto_bit64 = {
> +    .name  = "OnOffAuto",
> +    .description = "on/off/auto",
> +    .enum_table = &OnOffAuto_lookup,
> +    .get = qdev_propinfo_get_enum,
> +    .set = qdev_propinfo_set_enum,
> +    .get = prop_get_on_off_auto_bit64,
> +    .set = prop_set_on_off_auto_bit64,
> +    .set_default_value = qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- bool --- */
>  
>  static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
> 
> -- 
> 2.45.2


