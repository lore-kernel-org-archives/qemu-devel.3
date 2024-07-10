Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D2DC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRaz-0001y2-UB; Wed, 10 Jul 2024 03:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRRay-0001wx-CC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRRaw-000130-Vx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720595910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Pq6nq2ZZJNPEwZYhShA80q4GugeXnVlxVrGpNAbW+P6Sssru1ZEHP2x6Tf5YVnkl5XJ+7T
 OBKJMmKU5ovh8lJsHP+x8CWmHtZc2MZB9Bucn4YKHZYDvO0vV7Nwp7nPU9pIlPW482WvcA
 QkszyYF/BoOB9D35PdqlV+WPXdpx+yI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-9jODGsn9NHaUCEhtYCpNbA-1; Wed, 10 Jul 2024 03:18:29 -0400
X-MC-Unique: 9jODGsn9NHaUCEhtYCpNbA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427261986c0so8718645e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 00:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720595908; x=1721200708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=wT4zkUtuC+SSVGJ7nHoqPjFXoZgjJUE58yIVzGlofVXAmhpYIWIPMUVQKEVaXmJNOU
 82hOLLs0wkXcE5yh9SE956bVVcS/d+wEoBeRUNFP+whWZmUM4JmklvhAZnniC1RltOEq
 9P1iW58bUAzWdgwL5QnDmaYNhQiszkqHeWcm+gQHrAVBS3E7/YB08s+7yFs/+rcAVwah
 klKmBN5RaZdKUyOglR8p8xLNDJEARrjHBJmyMO21TToalV9iBc6bHyXrvpc0IgO2R5Hc
 9CNc8pLgkPkkq6oFKQa0FVQS8UToOkOrypK/otLQlLMjeFMTYVOMX7XK6pZ+H6zLNrdM
 BEkA==
X-Gm-Message-State: AOJu0YzF29o8V/dCnQs9jN4s2bfr2VNjf1nzs6wGOUx3lXIFVw6TLt3v
 duIr57hdLaCJY1iOkZSRjvVx3fLiQSKfEKwgzxJu1kwOglkg2tnpNGDcZTb0jWV7S+6VK8Z2DYp
 tc7pPTvsgNJX3WOLNoTev/o6/z0BDeWgC91kXGfj417RQOaK2ymOu
X-Received: by 2002:a05:600c:6d8:b0:426:6822:861 with SMTP id
 5b1f17b1804b1-426708f0e26mr32321425e9.36.1720595907984; 
 Wed, 10 Jul 2024 00:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkvsi7WUjnOEoVPlLsTI9WvuyBMvHYGfg/fRiw/gzhUH6gBW3jCKdZbMMfr4J/vaeokDmH+Q==
X-Received: by 2002:a05:600c:6d8:b0:426:6822:861 with SMTP id
 5b1f17b1804b1-426708f0e26mr32321345e9.36.1720595907663; 
 Wed, 10 Jul 2024 00:18:27 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f68e0edsm70568655e9.0.2024.07.10.00.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 00:18:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
Date: Wed, 10 Jul 2024 09:18:24 +0200
Message-ID: <20240710071824.78372-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710041005.83720-1-michael.roth@amd.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


