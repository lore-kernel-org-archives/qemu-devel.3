Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FFFC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCs-0004ib-AS; Thu, 17 Jul 2025 14:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSO-0004cj-9h
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSI-0004Jm-Gn
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqG2DiLmplhxW74U3B4JYB/l83wKcoDTCpLDYKMWsIY=;
 b=Q5LPT0PAy5ROfUOVav+h3KeQrNdR/DxpnGq4eXm3z0yjx+v19O1gwqKVkMeKnjtNS8OdO5
 MMdm2YW+6HjSOjj8udkbzHkApTs7+JQ4Z4k7l4DgsmEyOgAtT9KswxraOMx2zliIj7Y7qp
 KWy1B5G50rTN7Lcg1cpvUvsDznHX2Hc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-HZUGwbhiNSisxlYag485lg-1; Thu, 17 Jul 2025 11:23:27 -0400
X-MC-Unique: HZUGwbhiNSisxlYag485lg-1
X-Mimecast-MFC-AGG-ID: HZUGwbhiNSisxlYag485lg_1752765806
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so7434505e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765806; x=1753370606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqG2DiLmplhxW74U3B4JYB/l83wKcoDTCpLDYKMWsIY=;
 b=lqdgFBbrFoDN5o6fR7MR/LkQXmX/tTxTzXVL23FWnrw7Xc61TDlkw/xrVk3jpcJIMc
 utDtQamYKtNyj7oO1G+VcQCswug4CFVEdi7ly5yA1aPurTyXpiPHQnm2wgRNBbKch89Z
 6UKYiAvwU0UVyTsuWE9quNfBwDB8qzQi94PkdGk6vRzYDc2FafEeIVmAXaLpV/QLYAh0
 piygrEQO7M9TfMQee35RPJZOFTwGNGJR4SK/VfO3DDO0Zg46LZFU4RjpEN6UkRft0tRx
 x3AKOsFrrR0e01jCX+n40dUdqgLnlTNeP/EAP1iea5/xryDwpAWpn/hOim9T9Z/1j0GI
 pLDQ==
X-Gm-Message-State: AOJu0Yz1K0L2aiE2CIVyAiWGf/kjV4WcP0sDYv5wYRwBdUN1gJZxmYzr
 ijCcnvjqBbeguyzPL0rAf3XYxBbThucESUa3Bjzw2AhS2eOXknmm9fKmdimW4EH8dai1fW+qqm/
 qHXx2VKPOYHkIIdEiBBFsGv81/pHVlgLZsyWVT90NWMHXyDndAd+lQ2xdjmHxdtrHjqerFiWv/U
 4DCzQsBZFNaiKodbnzz3EiQOfk/8kRh6+RS3cfs7M8
X-Gm-Gg: ASbGnctwA21DaCMS81buyIPkj4In/QO8WEo08WvgD4PfadTpus6icY/TtTYW05NEFuf
 Zjes+h9DX4GJh/38bcM+hqNgobY+HJiTNyhbqJ9sp/EHCovprRRaUlOdVImX/1Noh4kxqnZSRyC
 vr6S3ZwGtv9odTtl5yIp/0O2EZv6e55dB7k7l714Agxv9subcM/NJSI8HZ1BsfXJ0TbV8JhQVeC
 YfqhIpkk9wK2YcJ1lJytF9zQssIcnYt5SHvXKFZj7uEB/1/pVjBiExMcanveZg2SlH9afaUjALE
 2nKkfPfxbs6u5+TT9yCgDxHd5B+y8lrWWKvj7oYcD90=
X-Received: by 2002:a05:600c:450f:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-4562e27497dmr82003955e9.19.1752765805963; 
 Thu, 17 Jul 2025 08:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3T/LVF2KN+smCrvn0joUa8mhv8EM7POcMbCgIwKCjMzWv4zcCtN5TPP/D9zdUacM+VR/UKA==
X-Received: by 2002:a05:600c:450f:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-4562e27497dmr82003595e9.19.1752765805445; 
 Thu, 17 Jul 2025 08:23:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f6b1a0sm25064235e9.16.2025.07.17.08.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, roy.hopkins@randomman.co.uk,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/6] meson: re-generate scripts/meson-buildoptions.sh to fix
 IGVM entry
Date: Thu, 17 Jul 2025 17:23:13 +0200
Message-ID: <20250717152316.353049-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717152316.353049-1-pbonzini@redhat.com>
References: <20250717152316.353049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 84fe49d94a ("meson: Add optional dependency on IGVM library")
was inconsistent with the contents of meson_options.txt and the one
generated in scripts/meson-buildoptions.sh

Let's regenerate the file in this way to keep them consistent and prevent
future changes from including the spurious diff:

    touch meson_options.txt
    make update-buildoptions

Fixes: 84fe49d94a ("meson: Add optional dependency on IGVM library")
Cc: roy.hopkins@randomman.co.uk
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20250717131256.157383-1-sgarzare@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e8504689e80..0ebe6bc52a6 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -130,7 +130,7 @@ meson_options_help() {
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
-  printf "%s\n" '  igvm            IGVM file support'
+  printf "%s\n" '  igvm            Independent Guest Virtual Machine (IGVM) file support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
-- 
2.50.1


