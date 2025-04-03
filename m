Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435D6C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 07:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Ecb-0002hf-Ia; Thu, 03 Apr 2025 03:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0EcZ-0002h6-LI
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0EcX-0005iZ-Q8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743663852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CbDG0XVeKtQkI3nT39/LaF4yIxnJ9f36Us7vFLpQr1M=;
 b=eC/HwnUrIylH1hxDJkapXuawu8CRV8fdg9lik6aRR1LyxpGHLO2pXtaLJsvVIMUF7Kdqku
 McA2qptoaP0a5Y0AL3MV96mHa2gSlQXbUB51Yq6yDRBtWUtlKh578zGyKHQvZUZOe56x3B
 BjH65HH8dygHPY9C0EWBGZk0d08a0O0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-3mvcUP7WPH6MFhl8dnwCjg-1; Thu, 03 Apr 2025 03:04:11 -0400
X-MC-Unique: 3mvcUP7WPH6MFhl8dnwCjg-1
X-Mimecast-MFC-AGG-ID: 3mvcUP7WPH6MFhl8dnwCjg_1743663850
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so2394145e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 00:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743663849; x=1744268649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CbDG0XVeKtQkI3nT39/LaF4yIxnJ9f36Us7vFLpQr1M=;
 b=pZ2UItAyZ7DXoHYLbevprNbKtlFKE+Rqvmv7JQza+LXOJk+dOCQMHDhF4Jkkf6o2Hx
 OgUBBf5bX9eTdu3tkYbNcUtsiytLdpm2Lct4SRWNJkQCLYzVwscosFo82mxqeIa/XWzz
 UIfpnqrD1SohZgtwqHN7pFf/DCVzI4YS/QBkwvABHL9HDAUxG7U4o31t+kACV/KDYeOU
 L30rVBSBtupZFWxo5hdiF5pGrgWi5LDSgJBHjlEvUDVPUJ+9ufk4UWeM1/snuWfJC4d+
 A6ujxoFtlfiA7U/lPPtUDtU4v7W8LKLpjXlyJQMG+Du0ukjF8SiL9Iy4Nbo3j9rgsNsW
 YqlA==
X-Gm-Message-State: AOJu0YxozWgMd7U9CEPO9ZKSauUOdXELReWgi1a+065RnRNrjRd4evk/
 Vb20lczjtyWhfGA22Ys1iSGiwX6w8zAFMWpWevqsaMrW8HKQgX6x84NoBu8CtcL8pgb0e60wJqC
 0OHBPZAmIA93CZZGjoBSblDiZR7GN8SLuBsWu+MeHzRGIA2wsXEPuFS/idWTdZKQP35ASjnQrza
 V/mM24zlCL1apA/MGWfKVaKyTE/as1CQuqqyg=
X-Gm-Gg: ASbGncvsUf7mA/g9iR8s9EO2rSEcxFQUN2SQYUIhx21L11pG9eQy0b+kFKMHkFabZjJ
 zAYXs40EvffJinpTFViLRq5awp9tNB56VztEIPo4qYUtmI40qfony5jn47mkBl03xihxKqQaKzq
 g=
X-Received: by 2002:a05:600c:3c82:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-43eb5c966ebmr47119805e9.29.1743663849081; 
 Thu, 03 Apr 2025 00:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw4YhyvalXEvFZ6yqZlBsePMNFDqzTSPIiMggFiNqcu0vddnqauc9PfF5uaH5ZJ7RP0IkZphreV1FodORfRoI=
X-Received: by 2002:a05:600c:3c82:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-43eb5c966ebmr47119585e9.29.1743663848809; Thu, 03 Apr 2025
 00:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-7-ppandit@redhat.com>
 <87v7rpkzjp.fsf@suse.de>
In-Reply-To: <87v7rpkzjp.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 3 Apr 2025 12:33:52 +0530
X-Gm-Features: ATxdqUHybfqtjBqUHcogp75JQ2Dsal8Ga244fpSEKCRm4R1A7dDaFgxQwSKWI4Y
Message-ID: <CAE8KmOwzoHJ0hx+cDk5N911rZF4Z8_RTD42vq65MrcumJWn_SA@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] migration: Add save_postcopy_prepare() savevm
 handler
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 31 Mar 2025 at 20:39, Fabiano Rosas <farosas@suse.de> wrote:
> This patch and the next one need to come before 3/7.

* Okay.

Thank you.
---
  - Prasad


