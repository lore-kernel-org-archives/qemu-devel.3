Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65B7C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAwPX-000450-AL; Fri, 02 May 2025 15:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAwOP-0003i9-WA
 for qemu-devel@nongnu.org; Fri, 02 May 2025 15:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAwOO-0007mj-45
 for qemu-devel@nongnu.org; Fri, 02 May 2025 15:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746215390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=h2G/cEM9012U7N9Vt+WC+X/0SeON/038Nk8Ta5u40h7UMiGbFSMtDyF5JRjCuJ4zqEt9jh
 v6JMuP5JH11A4RAfqoClp0QTiN5js3a0K7PYjy+1MzOW9v7mPeKLu9f3ya3IO/zuyTaqoV
 KCU1ne9W+CFztzgriPe61sjeEySdTyo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-m6FRNsNxMw6nT0flOIUVlw-1; Fri, 02 May 2025 15:49:49 -0400
X-MC-Unique: m6FRNsNxMw6nT0flOIUVlw-1
X-Mimecast-MFC-AGG-ID: m6FRNsNxMw6nT0flOIUVlw_1746215388
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391315098b2so819612f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 12:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746215388; x=1746820188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZCMW+Uy821+uBDlQtvZza2DeiSIbpi8F6Y0WymljhkUnuTFSdaozcgTp5U1c3/pWxM
 e6a8OjRe4zjwHbndGBVl/Lf+ZA9ft/wHWwTE7NN2cClygZACnufeqd6HcwonJZiRGNzi
 vIzW+DEHyxqHM9/lRCRDYnKY4xVeoZeuhnTEviWpOYfgOq1528yVdc7bx7daw89lq1hx
 ooNK7lwjwg6tNwjEsLG2BNuxXNJAVZTMYEZXTIhMof+Qvoj3gBN8pnl7GxZvVaRdVBCu
 jHFKjj9TGHMMo9Ii+hhcaUxrxVko8RSU96cXlc75DHZfQLIUbmA9FCEo46/aofSzma6b
 RZ4w==
X-Gm-Message-State: AOJu0Yw/Gwx/9le72QWQAmdV4Z526YRxwVzp93NVzNb2cWcTqmw/lvVK
 q9h/NBC/m+iLzfPuznHkEY/r6/mu7nC44j0LowW66icJigxegyFkt1eWkFxukpCm7ie9dSPgruk
 Ah5xTGd6TkhTPb9IEHgp31gNq0PzqRAyoadPbEiQkg93YQogJCn53
X-Gm-Gg: ASbGncsBphPN9n9iXrsp5pMfAdrM4h4GR8rmGYdNY4M5G3CVOk8cfon7bOU993MtI9H
 ke++nUsLVXpi19K+pXEEGnc8LWgzDN6JFiZCBmKm6obC0Mf6Gj6g859imO5+vajCBZ0rR+1U0qv
 l0FrDITRAW16YzEf3wiSZI0FnrvjCBXLpGiOI9/1poM5HP4PbMiCovAKppchCZ/2pu63pL3hCqd
 gRypRo/Xi7yFaAPpFxPPAtDrNYaSLat8HGgjJzVEM3TnGejcuN1rvMW/FhGYw9Wpy8DImaVhao5
 UykVySdZ1WUgKXE=
X-Received: by 2002:a05:6000:40dc:b0:3a0:923f:6d80 with SMTP id
 ffacd0b85a97d-3a099af1145mr3064268f8f.57.1746215387952; 
 Fri, 02 May 2025 12:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWa5gUUPhNQUUesw4TUfziBVsDhTG4AlchzWqHLZuoRtpX5tfbhT3JeuaI5Ia7tNHbfcmZVg==
X-Received: by 2002:a05:6000:40dc:b0:3a0:923f:6d80 with SMTP id
 ffacd0b85a97d-3a099af1145mr3064260f8f.57.1746215387677; 
 Fri, 02 May 2025 12:49:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ae456d7dsm74772185e9.1.2025.05.02.12.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 12:49:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Michael S . Tsirkin" <mst@redhat.com>,
 philmd@linaro.org
Subject: Re: [PATCH v2] hw/char/serial: Remove unused prog_if compat property
Date: Fri,  2 May 2025 21:49:43 +0200
Message-ID: <20250502194943.205101-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502095524.DE1F355D264@zero.eik.bme.hu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

Queued, thanks.

Paolo


