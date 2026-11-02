Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF0606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iv2vRJct;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L5SVVjcN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoz5-00064h-Rj; Mon, 02 Nov 2026 05:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1xNoxo-0005td-8j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:08:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1xNoxm-0004vJ-5O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793614104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z4QIWdQCrDK0qnVh/p5m8lR1tD8alH2y0vj4XN67fBA=;
 b=Iv2vRJctHatOxoh7ezYSK4afqFeFmucy3Pt1kkEQKexhk6phiMHcMHGqE5+yKpmn4TgyrW
 7484PTDVWp4anjnZrSm7K4xfsGhLr2wvt+PYIObWF4qpTPUjbXpKR0/eEOaxl3pTjqqPKH
 iBjSkiiPuOn6DgViXPlsgVhXq8CuRSA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-VUug-S6AOTq-XJYpxCtWgA-1; Mon, 02 Nov 2026 05:07:18 -0500
X-MC-Unique: VUug-S6AOTq-XJYpxCtWgA-1
X-Mimecast-MFC-AGG-ID: VUug-S6AOTq-XJYpxCtWgA_1793614038
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4046a3bso2805370f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793614037; x=1794218837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z4QIWdQCrDK0qnVh/p5m8lR1tD8alH2y0vj4XN67fBA=;
 b=L5SVVjcNJlpGHZZexcn8xy6AFSuzuwPRscINZgC+9lGmVniFb6xYI3vx+6VJobOs7l
 Xpv3Wda2/R3Yv3Fx4IZRR5Zdymvh+WHCnonnav5LrE5cowVMyQxmis5NlWv50HGBb6J9
 kBjiQVJTKtsAyJOs4N/x7LtKYu2ww/ewEBEvMY9kBDWJSMUousunJNA3uPIkA9QTQfWi
 0ZYkEVbwCYAetjiVjsWEpYuPPyyLJdMjFoRbjhUABZmPsT9bPn/kuVuSYim3NV+ZAYVX
 Myi7qv6pz5hE6oqwFxJhxCPombxEM4kgSOfKtvRMOBkMLElJ1shuFWUGjYjm9EwpxGv5
 l4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614037; x=1794218837;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z4QIWdQCrDK0qnVh/p5m8lR1tD8alH2y0vj4XN67fBA=;
 b=ZwHhzi7PiMNn3HcqnSupQ/FmyY9KNWC4oHmneDa7WiwhqIa8Ud0SN/5MFzpuxR1MZM
 fPP8pRYBUtRw013yBIcmzqfHeY8PfyxHqNg+Dupna/0hHCIuO/ifeWT6E6o+tqD7QmOB
 i1kwlkw6ja8GgSN/EpuJSooAnkDQdLOlUgc4jcywfh2Z5uQUvwf1DHXKjFqTIYSXSNUn
 rEHZaENqQx6DlGqwj+I3b7AT5izfPcILytTbXzt4+H1DRNEPbm6EW54hDz1oQi8uKpqQ
 Bnak4UD3e5cuRBbRhnzD8X7iTneGvXd012KcK1ycKx2zv5YVmSEzZSyBCnk81O0cFw2Q
 Zzhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNuiXMt9Hi3w48TW89SDfz/p1Ey3fn7ddVp9URUHvk4XPjP3uoynrl2NSoaC+40rvycAnjATrvl5WU@nongnu.org
X-Gm-Message-State: APuU4Z8v/tTISze5lLfI5ZYQmkEg0EVm7v7ItvPG7Eq6gwni2qxGjeka
 FoEun7BEXK/zp/xDFWw1TGXKWJ420RwsetUjYmKatCZswq0DqZUMP8IpMNynXPmBtmp6aIEl5us
 8sbXIetGohe+E6I7LEoWh+3U2bHMlLM1HMOzZOXidhk9s/xBpzfMFLTfp
X-Gm-Gg: AYBFou1RT3UlJxBf/vq34naEo+n61Xvz1sY1KliAfHpz4qik/GqFONxoIMgrEayNgDQ
 UZSPEooJBKu0cNJ4uRqXLIC/MwFeqvlyixtB2xI3VTB8DXAEMD9DRv4za2KHxoACFOz5NIYVASS
 W2NmIfkGtdacn2QEeDBGqA1lk7BbpOmIBbJBHeZL8wzp3XxTrYdNVHZKERBF9RgCfRStrnsrCTH
 NcZhSpMZlN1mnJCVBpY6Qby/YZA6QVuagLd2cWjDvRBTcTuj/glbsftn0/XswML9IgRAG1EbIKz
 Vhyzf98Jkm7zh/aZA2dbOJ/M98SHi68iO6jpMaYVCtGSlGX/fAzuytnWTieHS1H9/8UgWNxQERF
 OkyidT3GHuvzF8w6hv+iixMQ/HRLCNWbkzd4nhimjo7FueV4xQvAYvav+zS3ZkiT0cbv792ypMu
 asgyYXxTuz4uE4DSE=
X-Received: by 2002:a05:6000:18a8:b0:48d:e696:8a65 with SMTP id
 ffacd0b85a97d-48e6e50b4f4mr21339354f8f.46.1793614037589; 
 Mon, 02 Nov 2026 02:07:17 -0800 (PST)
X-Received: by 2002:a05:6000:18a8:b0:48d:e696:8a65 with SMTP id
 ffacd0b85a97d-48e6e50b4f4mr21339310f8f.46.1793614037113; 
 Mon, 02 Nov 2026 02:07:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:e9e7:d9a0:a4eb:dc4b?
 ([2a01:e0a:e10:ef90:e9e7:d9a0:a4eb:dc4b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d425sm19605298f8f.1.2026.11.02.02.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 02:07:16 -0800 (PST)
Message-ID: <8b74c033-6efb-4729-b0d6-6d1288fe3811@redhat.com>
Date: Mon, 2 Nov 2026 11:07:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rng: Remove deprecated "rng-backend" property "opened"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: amit@kernel.org, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com
References: <20261028152612.953491-1-armbru@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20261028152612.953491-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 16:26, Markus Armbruster wrote:
> This property was deprecated in commit 6815bc1d03c (qapi/qom: Add
> ObjectOptions for rng-*, deprecate 'opened') in v6.0.0.  Commit
> 6e577937485 (rng: make opened property read-only) in v7.1.0 made it
> read-only, and also moved the its entry from docs/about/deprecated.rst
> to docs/about/removed-features.rst.  I have no idea why it made the
> property read-only instead of dropping it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>   qapi/qom.json  | 22 ----------------------
>   backends/rng.c | 11 -----------
>   2 files changed, 33 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 4810d53e58..2a98b1de5f 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -925,25 +925,6 @@
>     'data': { 'pci-bus': 'str',
>               'node': 'uint32' } }
>   
> -##
> -# @RngProperties:
> -#     Properties for objects of classes derived from rng.
> -#
> -# @opened: if true, the device is opened immediately when applying
> -#     this option and will probably fail when processing the next
> -#     option.  Don't use; only provided for compatibility.
> -#     (default: false)
> -#
> -# Features:
> -#
> -# @deprecated: Member @opened is deprecated.  Setting true doesn't
> -#     make sense, and false is already the default.
> -#
> -# Since: 1.3
> -##
> -{ 'struct': 'RngProperties',
> -  'data': { '*opened': { 'type': 'bool', 'features': ['deprecated'] } } }
> -
>   ##
>   # @RngEgdProperties:
>   #     Properties for rng-egd objects.
> @@ -954,7 +935,6 @@
>   # Since: 1.3
>   ##
>   { 'struct': 'RngEgdProperties',
> -  'base': 'RngProperties',
>     'data': { 'chardev': 'str' } }
>   
>   ##
> @@ -967,7 +947,6 @@
>   # Since: 1.3
>   ##
>   { 'struct': 'RngRandomProperties',
> -  'base': 'RngProperties',
>     'data': { '*filename': 'str' },
>     'if': 'CONFIG_POSIX' }
>   
> @@ -1372,7 +1351,6 @@
>         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>                                         'if': 'CONFIG_LINUX' },
>         'qtest':                      'QtestProperties',
> -      'rng-builtin':                'RngProperties',
>         'rng-egd':                    'RngEgdProperties',
>         'rng-random':                 { 'type': 'RngRandomProperties',
>                                         'if': 'CONFIG_POSIX' },
> diff --git a/backends/rng.c b/backends/rng.c
> index bc9c7a5ab3..08d57e47ab 100644
> --- a/backends/rng.c
> +++ b/backends/rng.c
> @@ -41,13 +41,6 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
>       }
>   }
>   
> -static bool rng_backend_prop_get_opened(Object *obj, Error **errp)
> -{
> -    RngBackend *s = RNG_BACKEND(obj);
> -
> -    return s->opened;
> -}
> -
>   static void rng_backend_complete(UserCreatable *uc, Error **errp)
>   {
>       RngBackend *s = RNG_BACKEND(uc);
> @@ -123,10 +116,6 @@ static void rng_backend_class_init(ObjectClass *oc, const void *data)
>       UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
>   
>       ucc->complete = rng_backend_complete;
> -
> -    object_class_property_add_bool(oc, "opened",
> -                                   rng_backend_prop_get_opened,
> -                                   NULL);
>   }
>   
>   static const TypeInfo rng_backend_info = {


