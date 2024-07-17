Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BE2C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpT-0000S1-Pf; Wed, 17 Jul 2024 01:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpS-0000L3-2Y
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpP-0001xc-1w
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MiZsDxj20LLlzrMi2/7wvwlwKsAWITaw1ARYKEIkALs=;
 b=aMIBozwBpoMPiQWyEx0xcxOQo/5N40J66hk1hNt43FIlC9eP9bGhxBHl15cKxZ7FRKvplv
 R3hItdq4nwGjZL8vI3d8vuzrECxwxAna4vQSU0qeHJQd87EV6w7ua3oMDjiriPbxVUS7mI
 GAyiJZGJzcDz1rlGmfaquvQT6hvQpw0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-aq3PH_YnPIaxNUUrl5YLLA-1; Wed, 17 Jul 2024 01:03:44 -0400
X-MC-Unique: aq3PH_YnPIaxNUUrl5YLLA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36835f6ebdcso75958f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192622; x=1721797422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiZsDxj20LLlzrMi2/7wvwlwKsAWITaw1ARYKEIkALs=;
 b=G8dlro5P8aNg9upNtpPwzDgZ8KIBJMDXBI0irVI/inlE3NE6rPYtc+yetgiDTqLdtv
 MP3r2KrvCwwf9tiNeOrQp1ltHckIok+Wix67/6zBBDXH1bRZ27kyNwFa/EorjIi0ivoW
 Q6pVTvKQVj+9AnO+OCyQLxVC0OEcrtg7UMLdnDJ9jjTl46m3U/xvASft7Gy1J2eVOqrN
 P0qsI4PXS112ndVAtxd+AWYfOS5qfZbb06iqBF2hmDHDn4WvVWpZfqEmG4xcudnP2Fdo
 /c7FlNRq5DMU/RpzcejlKIEvhWWge6iTYnAuwFCBVUueSlWlPzeSbcThRcuyEjsELlh4
 QGkQ==
X-Gm-Message-State: AOJu0Yw5GwOs6YPr9LYrMhxEAgIW5PlMHcEJHn0Whp/3SevU5JmCltkr
 GAwtiaXp84UvsAIhui+um9Kq9aUFRRrVzlE/kRFFxkuHQH8T1yvbjtqgMY4h5VxeQoWpdQJNgLm
 2yTbwUnsIXWo3yvH9cHjS1pw7Gd5DyPQfAehbHcgS7u8aeFlHphYlUK7idTTG8sl3SfGOS+tB4F
 p+XEtrbaozctOGuYglIFj18xejA75c4zX0yBat
X-Received: by 2002:a5d:526b:0:b0:367:9522:5e70 with SMTP id
 ffacd0b85a97d-3683170e342mr428168f8f.52.1721192622671; 
 Tue, 16 Jul 2024 22:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg+xzseiguqIS0pY0p8S+8AYayez7L3kuE7gxLZP5LYWbQArHCdhyVRIp3UTLQEtD/M6nJcQ==
X-Received: by 2002:a5d:526b:0:b0:367:9522:5e70 with SMTP id
 ffacd0b85a97d-3683170e342mr428153f8f.52.1721192622352; 
 Tue, 16 Jul 2024 22:03:42 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf539sm10677999f8f.47.2024.07.16.22.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/20] disas: Fix build against Capstone v6
Date: Wed, 17 Jul 2024 07:03:14 +0200
Message-ID: <20240717050331.295371-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Capstone v6 made major changes, such as renaming for AArch64, which
broke programs using the old headers, like QEMU. However, Capstone v6
provides the CAPSTONE_AARCH64_COMPAT_HEADER compatibility definition
allowing to build against v6 with the old definitions, so fix the QEMU
build using it.

We can lift that definition and switch to the new naming once our
supported distros have Capstone v6 in place.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240715213943.1210355-1-gustavo.romero@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/disas/capstone.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index e29068dd977..a11985151d3 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -3,6 +3,7 @@
 
 #ifdef CONFIG_CAPSTONE
 
+#define CAPSTONE_AARCH64_COMPAT_HEADER
 #include <capstone.h>
 
 #else
-- 
2.45.2


