Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD43ECAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvduq-0007pD-1A; Mon, 08 Sep 2025 11:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvduk-0007eR-Vh
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvduh-0005HY-OM
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757345760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2z4WZjc2Qw7Pdj0ZxOVrwEMVV/HOnLvbPYbjiPri8k=;
 b=f2Rbm6ebnMbdB5D8cJHgmLbDltyenXVTDqo1FN6Ieum1Ymcdd+Pi5fSia8cItZKJE7w7j+
 sb78uzpVDDRNCDxaqFmIqEeMV7Nwl9OzNQT13DvCqLJ9y4CnZz8M45h60AwYl6w8JFXkjZ
 6b5EVL6+C/aiDfXoZJBU/xtSwu4GBUA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-eTZYaSIENnOmSTh70G13Ng-1; Mon, 08 Sep 2025 11:35:59 -0400
X-MC-Unique: eTZYaSIENnOmSTh70G13Ng-1
X-Mimecast-MFC-AGG-ID: eTZYaSIENnOmSTh70G13Ng_1757345758
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-816a52d9a6bso169760585a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 08:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757345758; x=1757950558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2z4WZjc2Qw7Pdj0ZxOVrwEMVV/HOnLvbPYbjiPri8k=;
 b=h1TbCq0sEtG3kinnovQumpnb4N9xU5vcOu5SKBQGP6/lgiTbI9ADMWqgdbqqz1t2DL
 86MP2tOIs3HSWR6kqVlTzzhs8pWSjCfOekNH2xyxM/TFjshxICFY7qG6ml2CfSMLscZj
 i6LwDYnFZ99o7jqoE/T/4DcTi/JLtfUmk9TScqvsAgnEfV2ZEs9sbvIAa1s4OpTg7XZf
 OgBZUZZVw7XwBObPRP0/OMnmZZh3uNrT/jpNJ6edHJ70tqC3cFp2mOGwjqc0AYsc9VyX
 ByMZ5KYq2/ZeyG+i4JQfp7/3YjAi0jIxwXrO9NjknLYWPzTK/mT2NU2T/jRNibbUQZEv
 uWHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFtI36fF+eREQpqv0fIu/dY8phR7+wSuq1QrNUeDF8y8PKxYdQtf889tnh3w7ym37gOWWeZhJyCVaI@nongnu.org
X-Gm-Message-State: AOJu0YwpVsYhFKpYBiLbIF4eYkUGy+8Dl4BxkL791INDFgYUGDuKJwAZ
 L4TiVkMb78mTxpgECjgGJE2KD4rO1T+Sc5aJp69uDiWJjO33H3CdZRocruOzKAXJzDvsImJmFxL
 5S5vcopjGkIaq4eufJ9qUqbvKcdZPi9RWJj7DosVAWutjQlNbKRot2Tyu
X-Gm-Gg: ASbGncuR6PwVtiGuT/2tesPIVZTxNQdZEQvz7fdGC3XFlWCIpNcdW+7EDgL/EapV2Zj
 oVIpN9eaO8BLb4lE/Js/ALqwetwY117Puc03zNnq/UmQ/oQFdWXORcnjntZr1N72aXSEeWK8bOe
 GQQqrKhLAwmTI6xtukyQZYr2OoT/h+sZsOQ92FOdlFv0grNaGr6eQgH0sB5m0Mu8UzomdgADon2
 pbulY1fRUtT1fEH0KbrKVlbQy+/kLr56Ni4G6dYJ3EARmkEm/JRpMNfTdeUx25K/sqWTtCiCFPK
 DoOtUBKfGPfJIOmqDqh+z6u5EaqagIVq
X-Received: by 2002:a05:620a:4609:b0:816:638f:4ab0 with SMTP id
 af79cd13be357-816638f4eebmr484521585a.27.1757345758214; 
 Mon, 08 Sep 2025 08:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeac9ERaUm6vN81GgYU2HhrgjfSVe6+tpZBCcuERZexbNLnH/CSDwkQHP6uHmLtUAv7q5Pfg==
X-Received: by 2002:a05:620a:4609:b0:816:638f:4ab0 with SMTP id
 af79cd13be357-816638f4eebmr484516185a.27.1757345757560; 
 Mon, 08 Sep 2025 08:35:57 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f62aa29sm105884081cf.11.2025.09.08.08.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 08:35:56 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:35:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v3 4/9] qapi: add interface for local TAP migration
Message-ID: <aL730XiXhM1Vj4Zg@x1.local>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905135039.2202924-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 05, 2025 at 04:50:34PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2387c21e9c..992a5b1e2b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -517,6 +517,12 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @local-tap: Migrate TAPs locally, keeping backend alive. Open file
> +#     descriptors and TAP-related state are migrated. Only may be
> +#     used when migration channel is unix socket. For target device
> +#     also @local-incoming option must be specified (since 10.2)
> +#     (since 10.2)

IMHO we should move this into a per-device property, at least we need one
there to still control the device behavior; we had a similar discussion
recently on iterable virtio-net.

But maybe this one is slightly special?  Maybe the tap device needs to at
least know whether in this specific migration, if we want to pass over FD
or not (e.g. local upgrade, or remote _real_ migration)?

If that's the case, we may consider providing a generic migration
capability, like cap-fd-passing.  Nowadays since Fabiano's moving migration
capabilities all over to migration parameters, this one can start with a
parameter instead of a capability.  The problem with migration capability
is (at least) that it can't by default ON on any machine types.. meanwhile
it simply looks like identital to parameters except it's always bool.

The high level rational is that we should never add a per-device cap flag
into migration framework.

Thanks,

-- 
Peter Xu


