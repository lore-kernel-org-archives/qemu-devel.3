Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25EEC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6gX-0003eW-Eb; Thu, 20 Feb 2025 08:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl6g3-0003cH-8L
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl6fz-00081w-RH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740058395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lyuyK4hJ50cNIkLA/9MKwa8uRRJk1MpmqfEcfpsnCFU=;
 b=BJmF57t2Ee8mSGwzikvkl2gC+whx3W3H7riTkBS7hZ5d7qiAnMiaq1eQCjBwobZ9q7iMTJ
 089LZdtcD/0v83qA/AW2FCVihtyyUKJz7ohXdw4bjxDXGMDL3jn2NWXqgU3L+NkatLfSIl
 3QIgjMqaTzgUjMIGMgoybxHqx8V1pIM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-M22d3_74Nl-Uawgs80c6dg-1; Thu, 20 Feb 2025 08:33:10 -0500
X-MC-Unique: M22d3_74Nl-Uawgs80c6dg-1
X-Mimecast-MFC-AGG-ID: M22d3_74Nl-Uawgs80c6dg_1740058389
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so6854705e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740058389; x=1740663189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lyuyK4hJ50cNIkLA/9MKwa8uRRJk1MpmqfEcfpsnCFU=;
 b=E7sb5kAdmXK3zy+mvFH/aqPNSlEPEZIoUfqDTIWDi1x9Sdf+3XJQg8jO1S9JVAfw8s
 Bx+rJiyJQJQch/L5uKTHp3NUydU0onnXpjprvt3KQRo4TjX0U71tfBnY+uFAxBJ6rNCN
 teMTNThwOTUMOstAfMQKkdT8HTYy3OqN9FoEcVzAKEM85ogGxFGpmG9b1XMlHRi3OYc9
 UzWlOYLm+PbFMY253gUU3z4YGSKGSfd8t9q7gxoSi2AfZb183wWGeolhHJ6YiKSu86n2
 JZFjB/OSZ8Zwabdg6Zp3hVlKa/bO+ZSPZZP1GU4YSkwtYn0NH4ZL9iBNdoRIwZmQKQpT
 T9rg==
X-Gm-Message-State: AOJu0YxlLdVSn2d/uO4plVbQgH9QY2+Uxdd5bcUPwL1IZYhqmGyktUIf
 bTOia1vaWI57N0lETConW/xBtL5uiwU5olYWeM6UJTKnU3wv48hCSIDNZJxTulc77xqgVpj4bvP
 M7Y0MjF6K300us+iY7CsVPTFZQgpKwhMG2QCt9P9yyEWrwVKKjMo+rM8ywXLFtOSThFy0BJzam8
 9fF+s49lTXn20O1rqVvAxS096ONimQMwClddJgDLg=
X-Gm-Gg: ASbGnctS41elD2s0aTq5tr8cUH4eEh2quyENBToxxPZIa2MI7TDN5vf5F/z+oEEmYqw
 Wmb5ef/geZpSOk6A07OLTcSbiwY7HXSM1/Mc1kzMygZloQlOeNnRkJzqDxZLbkPjIPA1wfywGlu
 qw0R0mnBet8ZONOX6BOumj7CscGM6rT5lBYgin1WWeDrTp/esKlLt4XCOgPgi3I58kgiqKqJ1w3
 6pxyLW5PMjQw0j5Vv/CCuVI1qUTyUMWdVUW9dNctepbtdUWCbZQb+zS1i9oLJCffgeUc/YrNP1z
 oaTLURnuYyY=
X-Received: by 2002:a05:600c:1c86:b0:439:60bc:71e5 with SMTP id
 5b1f17b1804b1-43999ddae58mr62157465e9.26.1740058388735; 
 Thu, 20 Feb 2025 05:33:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLHAXYng+AacH326e9Y03iAZFow/FpP8oxdMgKefIh3rPh4hHUUr1syzC4TqENJgza3muNhg==
X-Received: by 2002:a05:600c:1c86:b0:439:60bc:71e5 with SMTP id
 5b1f17b1804b1-43999ddae58mr62157195e9.26.1740058388181; 
 Thu, 20 Feb 2025 05:33:08 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43985c50397sm116057815e9.0.2025.02.20.05.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:33:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/2] pvg: clean up Kconfig
Date: Thu, 20 Feb 2025 14:33:04 +0100
Message-ID: <20250220133306.1104382-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Do not enable Apple ParavirtualizedGraphics on cross-architecture targets,
where it is not supported by the drivers, and add an option to configure it
out just like most others external dependencies.

Only compile-tested on non-Mac for now, but CI is in progress.

Paolo

Paolo Bonzini (2):
  pvg: do not enable it on cross-architecture targets
  pvg: add option to configure it out

 meson.build                   | 16 +++++++++++++---
 Kconfig.host                  |  3 +++
 hw/display/Kconfig            |  4 ----
 hw/display/meson.build        |  9 +++------
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 6 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.48.1


