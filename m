Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB4FCA0ECD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUur-0005QF-Ka; Mon, 11 Aug 2025 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUup-0005N5-MY
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUud-0005nC-0U
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754927892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nywi9k/60Q+iA8RkJ0a625zECrwXRIgRvuf+sGL6J4M=;
 b=DsTbIQMIcMtuNZC0KeBlDBo71FnC7JnDHQZ38atKwF7KCJi+JYe/wt5TdzhaBRAiTBTnqr
 z/cUvymiRpjw9zFq7w/JlRczkMyR4o13SYxawb5uRY90pYwzLW2+lDV3PkryrUfKghYjvz
 Lz4YC374EncY1VvuQDkrhV109XgeoHM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-FGoYUd0GNHS4x3qvV2vXqA-1; Mon, 11 Aug 2025 11:58:10 -0400
X-MC-Unique: FGoYUd0GNHS4x3qvV2vXqA-1
X-Mimecast-MFC-AGG-ID: FGoYUd0GNHS4x3qvV2vXqA_1754927890
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71a4742ddf2so63454907b3.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927890; x=1755532690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nywi9k/60Q+iA8RkJ0a625zECrwXRIgRvuf+sGL6J4M=;
 b=H8KXzR7VsqQfby2XLjcUycPQwqbUIyl3UUqHSK4yqcMMwOgitDbrdu1RLDxW0BtMhd
 iT4yZ4NbQz/bSPaC3fTeQID5t/6EhUwkhquYEOi3Zbfu754L/HEtyOZlfzNNdiJaSt/O
 YGXx9prGLYqKeHGDfo2fbYXgSJpd7hliQRPWUyHi56oETTqwCGNufgpjMCwEMLIPweES
 773VarXzLInwTGQAkeAeGOChftcya+sz/FVTIvX8Lan/odhXJeN9KyXQGRdoFFnZzosP
 4ZXqFhCKmEjNp6y5MxE1bM2WvKMKMK8K0kGhykpI4thuuDqaiBchIx/DpnKZYhjVs7BT
 dZEw==
X-Gm-Message-State: AOJu0YzCEyc3CeUDREZNilZbFPaB89uGMUfNRgAPjTAon9qByiTjqZAJ
 74v1EHwisQi5WRvIsB64uH2cjkS3ZNPktpdJ1eH2EQHQz/fCI4sp78EoxKvc0MB6IHkpf8ldzIq
 aeLsaq4Kx4T49V2TtMsd/oubYnfkChRlBcRYUhsSDWRu045OibgBc+WXZ
X-Gm-Gg: ASbGncuYUbdAB2T3afDLNgdSByP/pwRk6PgaCWWmwch/jE/B9LbyQhpRXnLE3Xv6LfF
 TzqGP7adjy0NcE5J/JRI7WGu3Rkeil/KImqzioOlqu4GkwK9rGFshwUv1ovqqzzk9ZX0XXpAAGM
 pn98GTP4bM0Wjy/Nhzi+3dws+PFNAgo8QseGkIA0UZgPzI8pot+MvIBnmCczmYXnc3bLQIYPauZ
 eTQLmcdInVDDNsouzb2RBT1djBbkcEuIg73xI6Db2Gvm5+p8fy1zLonh1YLt1vM0l4/RZDCogRy
 ke487SydaKK+qWZNey+o3dplXsYxhc5IMEBVBfOFc/jFBoks0+bnyDh+/3ms04xHriY20CTxC0q
 Zr17wErVcom9rQVfk8nBwpQ==
X-Received: by 2002:a05:6902:1244:b0:e90:8a48:c3eb with SMTP id
 3f1490d57ef6-e908a48c970mr4992287276.47.1754927890146; 
 Mon, 11 Aug 2025 08:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF87h8YsIJ6IU03fSnSmPoFjCrSYD32c8P6rBJOE9iiYbTooMb6Ic9CnkcUyfU25cDviJOquA==
X-Received: by 2002:a05:6902:1244:b0:e90:8a48:c3eb with SMTP id
 3f1490d57ef6-e908a48c970mr4992259276.47.1754927889748; 
 Mon, 11 Aug 2025 08:58:09 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e90495fafbbsm3434819276.26.2025.08.11.08.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:58:09 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:58:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 05/10] hpet: make main counter read lock-less
Message-ID: <aJoTD11ISypQFjR0@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-6-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-6-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 08, 2025 at 02:01:32PM +0200, Igor Mammedov wrote:
> Make access to main HPET counter lock-less.
> 
> In unlikely event of an update in progress, readers will busy wait
> untill update is finished.
> 
> As result micro benchmark of concurrent reading of HPET counter
> with large number of vCPU shows over 80% better (less) latency.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


