Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A07C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIA0-0000qm-Qc; Tue, 06 May 2025 09:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCI9y-0000qC-DD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCI9w-0006WE-J0
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746537389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3JirfBMvBI5AXjfyqj+Dfu98dFvQmMusPE8hhCytys=;
 b=bawgHUbzYjxgzs+anetYYTbI5M87QQE124+X+KHXMHDcI1tXQhzpSvY0pyfiHbWtbW16LO
 YKNao7IJxNPXrZineIRHRDNDusoRqUrzESNYHXdExmgFwuJR83QXWMm2e6bFWfwp72xjD+
 RlpzHyYBmIJJzcTmgjamqfso3n/lk3k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-obUZwB7yOtKy8v-VfjGqTA-1; Tue, 06 May 2025 09:16:28 -0400
X-MC-Unique: obUZwB7yOtKy8v-VfjGqTA-1
X-Mimecast-MFC-AGG-ID: obUZwB7yOtKy8v-VfjGqTA_1746537387
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-47685de2945so98194661cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537387; x=1747142187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3JirfBMvBI5AXjfyqj+Dfu98dFvQmMusPE8hhCytys=;
 b=BxV1pG73uc4iCfUfyMy0b5PCbX7PzXt/guGVQJdf/XO4/rKjsoHx95W1E6W+sFe/bo
 NJ1yvAiyqsUBNncCuOvw06+iVC4UZ1ZY1bACXraDa85XVUKAjMJZ1kGT1THACt5m8Xna
 Tv/aVKny/PVouhMU/pgt8uyXx404EdMAe1YE+wnHGdf6rHZFWtcIX+J76HSDLmazql5W
 9x9WFrkEFjRPOWz4ocfg/kfyMi3Pf7g3mjOqqkfHjw+uByl3n3VHhbVjJgg5YP2Yrk4N
 2Q2UN5m+CHiLZNuEVXJTh/Z47GlQ/DViI91C43g/m7tY2xpA6brFo+yu0RuHglYAPL7X
 ZSWg==
X-Gm-Message-State: AOJu0Yyrb3i2ZtQajKNb87NtrvkcJDMtusb6rMJ74+/c6ZM0B4JF6MT0
 xiHcUihEpCg9Oym8Bch2l8xFmoQV7qScysDFEaAIyHuBZH8J4goXQ2+VFmSdlMhHRqhfgi2/+2h
 qIuAqn5BKUZgf4uclOWjkBinK+X2T201DOhJrtyxQPhriwcFB7Y16
X-Gm-Gg: ASbGncuMGq9sqPe4h3npMHidRsHqL5xAVmuFAJjUBxbDiuZtzGx+gelb765mWAWayir
 uSBGoelbIwOluK+lxp2ldyZugT8zkaXI/1YcWHBUIzY9wO6vtC6Xj9QRg4eMh6UK5guTShpUYgs
 pK9LGdoftnL8E8ZorlQ4JNCUUI4DDe3+bWP+suxxLDBrvCaIjL0eHyXNJYZIf2hcRyMqs9bNDRz
 4vRnqSspdrnfjusf96plljAvhvr0B1RE1k6ALZ5mIxiRDRVx4ARsog/6IlNFrWQPAt1x7uoDGv7
 xI4=
X-Received: by 2002:a05:622a:1aa7:b0:476:76df:d26d with SMTP id
 d75a77b69052e-490f149dd69mr51815181cf.8.1746537387389; 
 Tue, 06 May 2025 06:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIwuPsr0AYP1Ux/02L007qIfQBjtSci+9WDERAAsPgcOGRb8mTZl4r8NrPbCz4zGfKgI4PGQ==
X-Received: by 2002:a05:622a:1aa7:b0:476:76df:d26d with SMTP id
 d75a77b69052e-490f149dd69mr51814861cf.8.1746537387026; 
 Tue, 06 May 2025 06:16:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b960ce251sm72038031cf.13.2025.05.06.06.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 06:16:26 -0700 (PDT)
Date: Tue, 6 May 2025 09:16:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, david@redhat.com,
 philmd@linaro.org, venture@google.com, pefoley@google.com
Subject: Re: [PATCH] system/physmem: Fix UBSan finding in
 address_space_write_rom_internal
Message-ID: <aBoLp9kw7-SHAGRa@x1.local>
References: <20250505222236.1616628-1-komlodi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505222236.1616628-1-komlodi@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, May 05, 2025 at 10:22:36PM +0000, Joe Komlodi wrote:
> address_space_write_rom_internal can take in a NULL pointer for ptr if
> it's only doing cache flushes instead of populating the ROM.
> 
> However, if building with --enable-ubsan, incrementing buf causes ubsan
> to go off when doing cache flushes, since it will trigger on pointer
> arithmetic on a NULL pointer, even if that NULL pointer doesn't get
> dereferenced.
> 
> To fix this, we can move the buf incrementing to only be done when
> writing data to ROM, since that's the only point where it gets
> dereferenced and should be non-NULL.
> 
> Found by running:
> qemu-system-aarch64 \
> -machine virt \
> -accel kvm
> 
> When built with --enable-ubsan.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>

queued, thanks.

-- 
Peter Xu


