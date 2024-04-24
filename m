Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256C2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzWzH-0001up-As; Wed, 24 Apr 2024 03:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rzWzG-0001ue-Df
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rzWzE-0005Mj-Pi
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713943451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E3xeUdbwboe4vx7bUte+Qx4JP47pLYuyNZhr+eMnsXg=;
 b=UUTm2H6TlxQk8hA8hZfpvxU4cPG16Ur9NLLLZI4nnfsh0UJ0FwSsHdGXlE+scLRXpY6Ksl
 MMYbQ1Nc8cGdfl/ShdQDv2g7BQxUa2izlH1AEzgme2lmLEj94rhzR60tL/FGyld2ha4UUe
 OZh0rPkrKVUyIatLROCsgrdupzqZYJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-prGilsA3NQ6mgVK5EHcg4g-1; Wed, 24 Apr 2024 03:24:07 -0400
X-MC-Unique: prGilsA3NQ6mgVK5EHcg4g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-346c08df987so265843f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 00:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713943446; x=1714548246;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E3xeUdbwboe4vx7bUte+Qx4JP47pLYuyNZhr+eMnsXg=;
 b=SnDUomnFoZUfw64avC5uJWQxSI372OmBtuEhkct+CCCbgSDswwqW7KAEbWeCeOYmSr
 bLP2g7/S5GeDeQ9lzVcN6gJm0Fq+0KBxIhYyLv1zVrNtGjTphOysTII1W1hOIcClqvTj
 MRfs0wBwsNAPsXDPuzD7nBZiKgh9ii+frHQ3iUmoaMck+gPru7IzlCOMe/axBP9XEpiE
 WBsN6VMQjqKzsuKnib3sqv+pmu7mxd2n/ThagzdZ2oj0SC/E/nmgR4jYBZPoClK0FxZ2
 N1P2B+Op8cqdVF0rW8ZChdvAe5URqxorwIHl+TLu963Yq5cbxhMmYMLrLH3RYky3L4YI
 /BQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWx6du6gH7ef8VzLilxmLrZWeoj/2RnvbZKM+b/nVCjeDBD2v7cZhKBi9zaDGqzgvXpUEJ5wqBdk1KcWs//nvt2RF4n0I=
X-Gm-Message-State: AOJu0YzKn7DD57rQEOME9wYhG+mW92FX1BGskp6XSl/rZRyICaaMy6YL
 SubJRmkxKqv9vNy/65SRBLrQuseWaZebGppxxSBYg+opZOHYaNIdiQc7wz4A7RFCzp1x024qtyb
 ZeYK+x2My7UuKyFjsfedrn1C6CD0olAQcGCe+cKEjGntp9Nl4JUL7
X-Received: by 2002:adf:edc9:0:b0:34a:eb4e:2633 with SMTP id
 v9-20020adfedc9000000b0034aeb4e2633mr3237569wro.10.1713943446634; 
 Wed, 24 Apr 2024 00:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFErFRF/of7S+yvNwUccfooh+98sjj8w4fpPRDhb4Qfnk4dutL1mILc8/lJ8igEGnL3GDDHMQ==
X-Received: by 2002:adf:edc9:0:b0:34a:eb4e:2633 with SMTP id
 v9-20020adfedc9000000b0034aeb4e2633mr3237550wro.10.1713943446233; 
 Wed, 24 Apr 2024 00:24:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef?
 (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de.
 [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05600c470b00b0041a963bf2cdsm6707452wmo.36.2024.04.24.00.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 00:24:05 -0700 (PDT)
Message-ID: <ec18d260-a882-480a-b7db-9c20aa4aacf7@redhat.com>
Date: Wed, 24 Apr 2024 09:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: add support for
 "disable-deprecated-feats" expansion option
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-3-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423210655.66656-3-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23.04.24 23:06, Collin Walling wrote:
> Retain a list of deprecated features disjoint from any particular
> CPU model. When a query-cpu-model-expansion is provided with the
> "disable-deprecated-feats" option set, the resulting properties list
> will include all deprecated features paired with false. Example:
> 
> 	{ ... "bpb": false, "csske": false, ...}
> 
> It is recommended that s390 guests operate with these features
> explicitly disabled to ensure compatability with future hardware.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   target/s390x/cpu_features.c      | 14 ++++++++++++++
>   target/s390x/cpu_features.h      |  1 +
>   target/s390x/cpu_models_sysemu.c | 20 ++++++++++++--------
>   3 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index d28eb65845..efafc9711c 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -212,6 +212,20 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>       };
>   }
>   
> +void s390_get_deprecated_features(S390FeatBitmap features)
> +{
> +    static const int feats[] = {
> +         /* CSSKE is deprecated on newer generations */
> +         S390_FEAT_CONDITIONAL_SSKE,
> +         S390_FEAT_BPB,
> +    };
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(feats); i++) {
> +        set_bit(feats[i], features);
> +    }
> +}
> +
>   #define FEAT_GROUP_INIT(_name, _group, _desc)        \
>       {                                                \
>           .name = _name,                               \
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index a9bd68a2e1..661a8cd6db 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -69,6 +69,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>                             uint8_t *data);
>   void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>                                  void (*fn)(const char *name, void *opaque));
> +void s390_get_deprecated_features(S390FeatBitmap features);
>   
>   /* Definition of a CPU feature group */
>   typedef struct {
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index ef9fa80efd..b002819188 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -171,7 +171,8 @@ static void qdict_add_enabled_feat(const char *name, void *opaque)
>   
>   /* convert S390CPUDef into a static CpuModelInfo */
>   static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
> -                                bool delta_changes)
> +                                bool delta_changes,
> +                                bool disable_deprecated_feats)
>   {
>       QDict *qdict = qdict_new();
>       S390FeatBitmap bitmap;
> @@ -201,6 +202,13 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>           s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
>       }
>   
> +    /* features flagged as deprecated */
> +    if (disable_deprecated_feats) {
> +        bitmap_zero(bitmap, S390_FEAT_MAX);
> +        s390_get_deprecated_features(bitmap);
> +        s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
> +    }

Likely, we should remove these features from the actual bitmap, such 
that they won't appear twice in the output? I'd expect the 
cpu_info_from_model() caller to handle that.

Just adding them to the list as disabled is likely wrong.

For example, if someone were to expend a given model with "... bpb: 
true" with disable-deprecated-feat=on, that should be remove from 
"bpb:true", and only replaced by "bpb=false" if it would be part of the 
CPU model we would be expanding to.

Or am I missing something?

-- 
Cheers,

David / dhildenb


