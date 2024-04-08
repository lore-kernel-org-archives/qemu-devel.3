Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F000C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtqUL-00085F-2R; Mon, 08 Apr 2024 11:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtqUI-00084y-3F
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtqUG-0001rH-Gh
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712588443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=N3UjMAmN1A30p3DbPvNqcvtlRkfZHQqkyWYPrsw0sl+4Il5ct1zJc8Zv1zonYLoGxJ+RLF
 CISohrMXb/woNBVWMBhIBozfk1fKRNwgmE0V5IUV1ZvNVT19Luek2izhzdOdoI1til7Q0X
 rPKPMdOuVMO4eQPiZpGqKObWm6je7M0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-gKcDiWojOmCEvKEnWdtDAw-1; Mon, 08 Apr 2024 11:00:39 -0400
X-MC-Unique: gKcDiWojOmCEvKEnWdtDAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4169877bfcdso561395e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712588438; x=1713193238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NaGKQCdApLcGDzxW9M5mZ2WEIlsbz5OXjb5WsXhIDgYZfFyPiNqi+eg9YQ6DhQRHf/
 ypD/Bk51zh1IXYxitbDEL2cM6J0BzyXoHJ5SzZsJmJz3rJkolb3F1/3a28n1d2Lq7EfQ
 QbbtxxEDazmSqbFghbAd4gDPf96CEqLEmsgiOL5/UjrYK4DjrsXuGs1JmntA3B9P0X4M
 dcio6wKrRhHv7FT5JKDXy4uqTMmrVQ27c1r2+u0i4Ad4n31TipmJMd4FOqh8KBGtdBa8
 W2NUC/rHbPwRW22hVCjqs0RkRjfGwYjiW3OBKN+8rLYjfHRbVRfWViiX27KdCBxNfdMH
 kLXQ==
X-Gm-Message-State: AOJu0Yy256kajmLRzjR4Q/76+H4LS+FrN7GgGha83ZrmP3Xx9sRuFzhA
 mw4z/iMkIz5AdArDYOkwmdkZLps6XyacF2aoR74ew9K+RDAA6zTYbVS023oLf3HwFgf2KZfY+7T
 9+GDD4OPt+aCMAlAhZLYLIC1LHD5MagPGnRV8L8Vp8Ydaom6GwgRA
X-Received: by 2002:a05:600c:1395:b0:414:245:f6df with SMTP id
 u21-20020a05600c139500b004140245f6dfmr7182269wmf.21.1712588438151; 
 Mon, 08 Apr 2024 08:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcj54TL9rtB6fSwpe81XYNIGgUv0xB5QRVB4G+OhenBqjmH1lvmPx1hhL8RmXtgpVFqDxOMw==
X-Received: by 2002:a05:600c:1395:b0:414:245:f6df with SMTP id
 u21-20020a05600c139500b004140245f6dfmr7182247wmf.21.1712588437828; 
 Mon, 08 Apr 2024 08:00:37 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d540c000000b00343f662327bsm7961241wrv.77.2024.04.08.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:00:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: Re: [PATCH] kvm: error out of kvm_irqchip_add_msi_route() in case of
 full route table
Date: Mon,  8 Apr 2024 17:00:35 +0200
Message-ID: <20240408150035.500237-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408110956.451558-1-imammedo@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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


