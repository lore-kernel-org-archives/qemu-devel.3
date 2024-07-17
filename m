Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A14C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1sF-0003bz-GF; Wed, 17 Jul 2024 06:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sU1sD-0003W5-TG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sU1sC-0006LZ-33
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721212018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i9VM87ITNf45Hhz+qdj1VLEVG9zhlSVwKT5snqK9T60=;
 b=TL8VXsPdVJJQoYo3kKAUSrfGNJMAwFhmX8G6Hy7x6U5R4RWKypYDsbyvt6CJr9pRAZl6yu
 BY8/UgIiIxzIa4obuQxGtVuoaET6Teb8iACcrBaAdumrDnvNBRbe13lf3beeh1eT2ns6TX
 aAPHacqanZ7VHfmVvPTik1b4bWdEYXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-maH9WboSPY-fkGVBqbdcQQ-1; Wed, 17 Jul 2024 06:26:56 -0400
X-MC-Unique: maH9WboSPY-fkGVBqbdcQQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426724679f0so3124135e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721212016; x=1721816816;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i9VM87ITNf45Hhz+qdj1VLEVG9zhlSVwKT5snqK9T60=;
 b=qPbq2FELi7IVaYHN3JGYmvNpHz6jnNHV6IXtO+/CbEq/0Tkk/UV6xTmANbq5FvyyDo
 +ylamZ5eZz5QiHGxFUlDisn7sT6KhYphmcoBsqyqJaYOMV/g+wRdVKWbvagSTu4/SCyI
 BV5PHHN7c8wEAqwBiscH69me+97G/ZtP1UdDdaukliikBuOywkoPYWbQ/likmbdhHWT2
 qycLllLA/XmaNbsQKdqdPYmQFbfSS3VhqmlQKIk70Zx50XXAsnfNew/38F0VS7lZCiLR
 AoMZBFm2Xk8qFRJ4+S5FD4NJ1LDyb1JTzmYLD/DUOePzsB9IKb73PGsCJZr1rEOoEbXN
 gJiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHr8/TXAFccW2sdfObCvF5LRy/MBK7h7VJAjaXr34kKvOUqZQ56yriihlN5snxSkZ5tQxhSZDtqjwx/2rCdqklg0Oad7c=
X-Gm-Message-State: AOJu0Yzrke9aLHqXoY8l/h+yR59aP0d06cRGUfYKkpkvFI74d93zQfRw
 I2aV1stH9PiGMvIF096nPqhFgTIF1gMV4QK/0DXrw9jScAvZwca56bX3N/ZpnD1b3AEhgByo3Ui
 OY9+DX3GVEQ80foRuyzYkRkuky1julXW+fg4o78IbU6PfLX5EZHrP
X-Received: by 2002:adf:ea8b:0:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-3683113672bmr1022804f8f.0.1721212015822; 
 Wed, 17 Jul 2024 03:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVLW/gVEWlXeJ3VQ81Po3JEjsIF+JM9eV3fU8uCasfPCGhE9NWESycnrBuyPTaEhqYsQcXWQ==
X-Received: by 2002:adf:ea8b:0:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-3683113672bmr1022791f8f.0.1721212015493; 
 Wed, 17 Jul 2024 03:26:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde?
 (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de.
 [2003:cb:c714:c00:b08b:a871:ce99:dfde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36816758620sm8839634f8f.19.2024.07.17.03.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:26:55 -0700 (PDT)
Message-ID: <7a1addc4-2427-4761-957d-e3404146d70c@redhat.com>
Date: Wed, 17 Jul 2024 12:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: filter deprecated properties based on
 model expansion type
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240716173253.28533-1-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240716173253.28533-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16.07.24 19:32, Collin Walling wrote:
> As s390 CPU models progress and deprecated properties are dropped
> outright, it will be cumbersome for management apps to query the host
> for a comprehensive list of deprecated properties that will need to be
> disabled on older models. To remedy this, the query-cpu-model-expansion
> output now behaves by filtering deprecated properties based on the
> expansion type instead of filtering based off of the model's full set
> of features:
> 
> When reporting a static CPU model, only show deprecated properties that
> are a subset of the model's enabled features.
> 
> When reporting a full CPU model, show the entire list of deprecated
> properties regardless if they are supported on the model.
> 
> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
> 
> Changelog:
> 
>      v2
>      - Changed commit message
>      - Added documentation reflecting this change
>      - Made code changes that more accurately filter the deprecated
>          properties based on expansion type.  This change makes it
>          so that the deprecated-properties reported for a static model
>          expansion are a subset of the model's properties instead of
>          the model's full-definition properties.
> 
>          For example:
> 
>          Previously, the z900 static model would report 'bpb' in the
>          list of deprecated-properties.  However, this prop is *not*
>          a part of the model's feature set, leading to some inaccuracy
>          (albeit harmless).
> 
>          Now, this feature will not show during a static expansion.
>          It will, however, show up in a full expansion (along with
>          the rest of the list: 'csske', 'te', 'cte').
> 
> @David, I've elected to respectully forgo adding your ack-by on this
> iteration since I have changed the code (and therefore the behavior)
> between this version and the previous in case you do not agree with
> these adjustments.
> 
> ---
>   qapi/machine-target.json         |  8 ++++++--
>   target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>   2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index a8d9ec87f5..d151504f25 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -21,8 +21,12 @@
>   # @props: a dictionary of QOM properties to be applied
>   #
>   # @deprecated-props: a list of properties that are flagged as deprecated
> -#     by the CPU vendor.  These props are a subset of the full model's
> -#     definition list of properties. (since 9.1)
> +#     by the CPU vendor.  (since 9.1).
> +#
> +# .. note:: Since 9.1, the list of deprecated props were always a subset
> +#    of the model's full-definition list of properites. Now, this list is

s/properites/properties/

> +#    populated with the model's enabled property set when delta changes
> +#    are applied. All deprecated properties are reported otherwise.
>   #
>   # Since: 2.8
>   ##

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


