Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E98C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxpx-00037D-U0; Tue, 27 May 2025 13:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxpt-00036a-3C
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxpr-0007vD-Ih
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ANwbqX+GPhJL2ywYhaI5v5xREWX/7od7GSpNgQw0K3VEFblSAgRaRdxCF8VBlYKVeMMm49
 T1LQgCpWmNsyy/dLt2/duN9yZCaV8GJOg59mVIa2kuZz5d55GjSdsO8tGnIq7TT5Bhd2Tq
 2cB7wZ7qJnVzD7RVcixrQN70WYxc54I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-G5IFN-OUPR6TGa02ChoqNw-1; Tue, 27 May 2025 13:11:25 -0400
X-MC-Unique: G5IFN-OUPR6TGa02ChoqNw-1
X-Mimecast-MFC-AGG-ID: G5IFN-OUPR6TGa02ChoqNw_1748365883
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-602df3e7adcso4083347a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365883; x=1748970683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BzYfaEHH+9fpTbJhvWXxBHGJSF8jhAhfbJwjjmoIuPR4i7q9cMWzI8RZheEvyZB2yM
 zaM/H5qfBLmlihF6TEtUfnitXslHPX4a0JWgHyX/XID6m+YkTHbzz9tiU583aZJzieRw
 AT3Cns8uJsrTOxxsEM13w/PCthVCZ72RyNVm6NFeFmWIF+Jl9Ox1l9D4c7Ze9w6c+5og
 6093pgRYEKrwIEM5Obal3VhVgUbwpxYMGd21eUvmgHqogZx/BpSbY34FkR/X9RMFzf6u
 FKMEcYg6B3iIkU4FBp9knTnl/XcUE8AZvQ16u7g2kgerK9IXqqHcSY07hopIKq/5NUwK
 NYRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8mJbevvG5K+O6MmplD5YofjPMJR2o/vhwslQM6l0yTV/5QZm75NfoPuwba8jasnTpeWvChwy6Du57@nongnu.org
X-Gm-Message-State: AOJu0YzDXMMGnUHvXTzt0rXOFRT142x8PKrhvp9nWg7RYPuq5ep5rVtM
 NW/qe0FoZ7kz+vzgMmwz9WRJFTkfo89nIE4ywZPo0bPg+G1cyZu9mbEYKhRPxP5MoZXTZTA/FWA
 iX72FZAqC93EkwtCyT5Wam4SkhlIIr2MSSJ32aLXo7eXHha4ZO54yOyvmjiELneyP
X-Gm-Gg: ASbGncu8gzj4oU3TDQYNSybqOZvMiyyZIwV07LfVKspgBjPqwBCmYfBzhVD/cGKr0QL
 Z+4eqchfhh+iUEVTFvRPIWeqnchV6+Ft5QYe+uLrrKEw5gvEDdxqmQXpqQLgFDx+T15dyIFVeBU
 NuNisJizlkx/6m2hTXxzlP6M55mTRSLCAMKtWflUE6M5lg8zHARVMA9sjXf5HFuXbuju56JXydi
 Q9lVHS9Fk8HzBnV3G0juZZ+x0yIo2XpDTPWkg0kpFHiIGEQTO5O0dYHcDHxmLjM82a7mfyJ3KHa
 7KRnC+6x1GFjLA==
X-Received: by 2002:a05:6402:354e:b0:602:14f8:9a2c with SMTP id
 4fb4d7f45d1cf-602da8dc68fmr11848659a12.30.1748365882865; 
 Tue, 27 May 2025 10:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2bN8EfaeSSnLgsU8wZOU7fJNtqLJ+TleDPtD3RopSmXupny3FLXsImJ1bktJ5gTCqZqqpHQ==
X-Received: by 2002:a05:6402:354e:b0:602:14f8:9a2c with SMTP id
 4fb4d7f45d1cf-602da8dc68fmr11848640a12.30.1748365882482; 
 Tue, 27 May 2025 10:11:22 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-602e336e990sm5411571a12.67.2025.05.27.10.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:11:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mjt@tls.msk.ru,
 laurent@vivier.eu, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net
Subject: Re: [PATCH] target/i386/tcg/helper-tcg: fix file references in
 comments
Date: Tue, 27 May 2025 19:11:20 +0200
Message-ID: <20250527171120.1581468-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526114447.1243840-1-f.ebner@proxmox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Queued, thanks.

Paolo


