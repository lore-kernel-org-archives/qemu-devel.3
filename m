Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C0CCA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUrg-0002ah-J6; Mon, 11 Aug 2025 11:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUrc-0002ZI-2u
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUrS-0005KV-Ky
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754927690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=04oK95U5MeaQGjOI2iskdlRn5ls9OLL+Vc0ZCer93RE=;
 b=W33eKDhq2tiv6o9rjMKowEZ312b1/eSvRAIC6bKWk9nPLBjwGgiG0rnfdWXmoG84P14wdj
 j0h/OFCxKfntUva1ZZkUB+370rKokvKGKQL3Hi4GrUyv4URqhn4Eh+ZjMnYw3w21cVRF0o
 Nsz6v1johVhAVzu6NpupzXs6glBZ/GI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-3ltAkMB9OzSuZ7oQw42daA-1; Mon, 11 Aug 2025 11:54:49 -0400
X-MC-Unique: 3ltAkMB9OzSuZ7oQw42daA-1
X-Mimecast-MFC-AGG-ID: 3ltAkMB9OzSuZ7oQw42daA_1754927688
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7075a0b5580so90850416d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927688; x=1755532488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04oK95U5MeaQGjOI2iskdlRn5ls9OLL+Vc0ZCer93RE=;
 b=Mk46NdmbfqfcnXmvEQYv1C+Up1aAoHlR2scBxAc+mN2rk4P/BCv1W6f0aMo4qAiCMP
 wFNyALveUarJipwYP4gqu5UPXwlcb5OKeSaRjyger0+frX9LILKhnYGBgR6OuSKsgzRK
 l1z6TKJeI1QBVQW03jP0hJXBo1TeOznbljSTxnOBEE42a2Qy3OLzBcWcS7qF0IutUBa6
 MVIiYCxR/MbkhwC9yjPOKZFxBl3bzx6leCt9x9gtoA59Xkj1CPbExv6oNc9D8pAEpJPT
 yYncEIMJanY8QvI/XVW2LGSlqpdSvbyXAYlrkzlSQkzSct01dLOmBsDT3vV8vKzRzIZA
 slaQ==
X-Gm-Message-State: AOJu0Yznx40Qu9rdXWcJs8D5btGEV6iH+qAY6RVCVBV2iLHioSl0xO/U
 KStKxLrbrozNmgKt9BOczFHyay87A476QmvL3EPF29Y6enV5RBTtQJWCgM+HCdr6lcUi3V0Wrw3
 XM5mfZ5IbGOf5e8GjMMU82UDnB9O8kTPaOrt3wydnnYbqqWKVdpiMI3L4
X-Gm-Gg: ASbGncvvi8ajkevcDCaF9hpizFvmF6JT4QDhFKuRfyTp1ofLH71OfRb7Z2ff0BVr01s
 diPrQCB+/dNSLdgG+TkZNXuCRcWcBiKSJXGWp0rcvRa7u51wsBrumpYWRlGLsO2q0WZtMP3vqvw
 NP5PMAuJaUrC5Omiqsoq9akhS0vaQxLs5ONmG3XeqGAsD6f4qlbJoLyDh/rmYL7cfnrtstaWJTP
 swh/+4lwwVXvRVwDlid5Xlrx4hhR6hnR6Q/oHiAQsyHNMqYlZ9/irJs26va4kdto4xajzDrtGKp
 vTgLtFqJO4xpb6c1LhG5vAqyoXIXzz1m
X-Received: by 2002:a05:6214:2508:b0:704:8f24:f03d with SMTP id
 6a1803df08f44-709d5cd2475mr6108786d6.16.1754927688460; 
 Mon, 11 Aug 2025 08:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMfdd96fuXtCyUL3+flJGjEiWwdeAMX2B5e/uh7O95Sk7UZTroYWxQlSVegU+uTgALyr9BQg==
X-Received: by 2002:a05:6214:2508:b0:704:8f24:f03d with SMTP id
 6a1803df08f44-709d5cd2475mr6108226d6.16.1754927687887; 
 Mon, 11 Aug 2025 08:54:47 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077c9d9b06sm157141226d6.6.2025.08.11.08.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:54:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:54:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 01/10] memory: reintroduce BQL-free fine-grained
 PIO/MMIO
Message-ID: <aJoSO27NPHcIkQnB@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-2-imammedo@redhat.com>
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

On Fri, Aug 08, 2025 at 02:01:28PM +0200, Igor Mammedov wrote:
> This patch brings back Jan's idea [1] of BQL-free IO access
> 
> This will let us make access to ACPI PM/HPET timers cheaper,
> and prevent BQL contention in case of workload that heavily
> uses the timers with a lot of vCPUs.
> 
> 1) 196ea13104f (memory: Add global-locking property to memory regions)
>    ... de7ea885c539 (kvm: Switch to unlocked MMIO)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


