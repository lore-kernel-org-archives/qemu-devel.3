Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C7BE9D419
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngZ1-0003Db-Pr; Wed, 04 Feb 2026 12:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vngZ0-0003DL-73
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vngYy-0002pY-FJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770225670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h81uoTrIFwGOm67byZDCjGj/nEMdjzlyasvu12FCdXM=;
 b=CPT2ByEiw8mdrxGzM1zfzalKnTvA5yxyQgT7NGdVIw6ITeq3FqwKPRkxrcxwq+KIAT2+OF
 skTEmMOabgIPKp5+UGTfw4GQx1Zs5NzqPrHBx8yrIRmM3CxrkSIvOBcljGs2j+gN/uCeBq
 hQ4LSQ5SDvOTw6J/IDQ8vhY+N8r6I9U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Mio7Da7DOhC76u9rSUyjJA-1; Wed, 04 Feb 2026 12:21:09 -0500
X-MC-Unique: Mio7Da7DOhC76u9rSUyjJA-1
X-Mimecast-MFC-AGG-ID: Mio7Da7DOhC76u9rSUyjJA_1770225668
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5033c6265d2so2018781cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770225668; x=1770830468; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h81uoTrIFwGOm67byZDCjGj/nEMdjzlyasvu12FCdXM=;
 b=U6zKkea0rivoKPtgoCioBjBRx+nfKzd+WVK40dh9k33KjxgJmYeHYTU9IVenKu2Szm
 WtfL5xDqm+m7zhdFHb3v+U4hi0DzSTz5cflAmFH5WZKUtO2Gs5XVv9H9YzvK9//G0AeR
 oo45bvlPbGFZwvRPWjU2X8rMH2s0WLvRZv6ahQSFjedsBZepGkuQ0axCxO26NtyaTSIT
 gRBgWZ3p9Rv6m5dA7H3pQwaG5Pl4BlQnuPjZNGTUy0skVCaHTvkTXrS1Q6kfEk0gSSQT
 vlBC8CjUgoX3aQguKbb5ahIyWRan7/WEVIh4ICxpjOVyFZcLOEarAomJLjsBbrHKvqEA
 7v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770225668; x=1770830468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h81uoTrIFwGOm67byZDCjGj/nEMdjzlyasvu12FCdXM=;
 b=Jl9di0nZO3GktOBKdyyjeiBxyAngbC+qB+sDfAJlB+ojcZZhhmlAKplRFya4cH6bCn
 a+Q1CR0fuZbllchzo2w5PhT6EVFU1SxJUn1Y+07GWXCSete7ilENU7hUTOgCUlt2weNF
 D/f8k1VO7lN+UQ/Qg320d2GPxrH/SLKkkCTSKZFPrROmIUpz+kQ6hdCxdOXL6e9y+k0C
 MwEm8Nb+3GNUn5lj3L9hxwwaubxg8aoD1o/9Ov8nmIYFh1TambzbiNsLr7NEz5jc+02+
 jmVWQ6toJz7xMEtkRGH7xl+bCUFVs0UqETgL1xHtDOC6XlMdOkM1zY3wW5TbaO0480oO
 zAYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmpujqzEh81AKgncTZ9FQDr4GDjSeGH7YvlUSSUahP8TLUxRcxFYpUFAfgCEXT9UazOafuHG1AqOc0@nongnu.org
X-Gm-Message-State: AOJu0YxwgZ3Q9z3bFunFVaRWhqh2XvpPCJpen26io7spCjRPUMRE6oQh
 cVTOAa7aqRDosg6OQylSqjNqHyjHhf21EDGYO3Qk0bI7b4TQTFU02/cg0j3yc6E4WnhoWtBfZIy
 6v3w8vMJqIi1sODUxSLO7AlW/oGObqpEbOaFLVNZigKYzH+tG1rrmf1qL
X-Gm-Gg: AZuq6aL/ARYSaVhzjA5Ged0xN5rShq+CwGmyFltbNYckFdV6sDVss4BOCXhjAC1/WX+
 /YvneYMN0MNDLR5LpoYHKMpzEP4nNUKNSt7ABUF7eQcfMvtdfuGkRq3Bj5uVhfXnA49R+yRA9Ym
 fTwfPMca6lj/7kc8Hmdg8EizFl5YSYX95ZDGLd2VVfQNl4iBm+G5jy/9ZzohzhFdPGBLADcfIKT
 GDYoWA9s5KauN/bPV29EyI+lz7ic/FfNbW+3yhpYYEGaUtoIkJj3I7qWbSlHh8CoXh67NNNLED3
 H2EkURrj7tyTRN8SETVAw++7n8KO+9AH4s7wUxu1SMp6197HlEL2aoN+4Vq76fgch4ITLAnI6am
 Fl3Q=
X-Received: by 2002:a05:622a:546:b0:4ee:26bd:13f2 with SMTP id
 d75a77b69052e-5061c1dedc6mr48373651cf.72.1770225667780; 
 Wed, 04 Feb 2026 09:21:07 -0800 (PST)
X-Received: by 2002:a05:622a:546:b0:4ee:26bd:13f2 with SMTP id
 d75a77b69052e-5061c1dedc6mr48373201cf.72.1770225667235; 
 Wed, 04 Feb 2026 09:21:07 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5061c1f9470sm20819991cf.24.2026.02.04.09.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 09:21:06 -0800 (PST)
Date: Wed, 4 Feb 2026 12:21:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, thuth@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, zhao1.liu@intel.com,
 wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: Re: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
Message-ID: <aYOAAfzZQ3PeKf4q@x1.local>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260201162001.296328-4-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Feb 01, 2026 at 07:19:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>  # @migrate-set-parameters:
> @@ -1004,6 +1005,13 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: Enable backend-transfer feature for devices that
> +#     supports it.  In general that means that backend state and its
> +#     file descriptors are passed to the destination in the migraton
> +#     channel (which must be a UNIX socket).  Individual devices
> +#     declare the support for backend-transfer by per-device
> +#     backend-transfer option.  (Since 11.0)

I still think it'll be nice to either have "local" in the name of parameter
or at least document it with crystal clear terms.

I used to suggest fd-passing, but maybe you wanted to emphasize there's
more than fds to be migrated at least for tap? Then it can still be
"local-backend-transfer", because nobody stops a device to transfer backend
states in a remote migration either.. so "backend-transfer" seems to also
work for remote migrations, but it is not.

Or at least mentioned explicitly in the comment, saying this is a local
migration / upgrade.

If you could at least update the doc on the locality attribute for the
migration (one way or another..), feel free to take:

Acked-by: Peter Xu <peterx@redhat.com>

If you decide to rename, that's even better.

Thanks,

-- 
Peter Xu


