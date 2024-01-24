Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5EEC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 11:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSbp7-0004iP-Em; Wed, 24 Jan 2024 06:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSbp6-0004iG-Mb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSbp5-0004hY-9M
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706097217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hOuj7K70heo2hGx8cAjlkx6UmMb15xVuezZeMseMc4A=;
 b=A1ZP8fWyELo/8SEuQRV4pUdxYN/tSmQ61IPJJMK+F6emeEjhDn9aXC9P0OAv58Q25b/YPA
 GWW3KJABw60TewB90YU9b6sQ6khKQHNQ2722LHVyOhhE7W0fla5ds1CBMKlgyXFwqJKrGA
 PyVs+VHz6s7z6lsQf856ePCDxJspAl0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-6ISNXjS_Nzy3I0WxuuyjAA-1; Wed, 24 Jan 2024 06:53:35 -0500
X-MC-Unique: 6ISNXjS_Nzy3I0WxuuyjAA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a30c5ce1977so67712466b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 03:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706097214; x=1706702014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOuj7K70heo2hGx8cAjlkx6UmMb15xVuezZeMseMc4A=;
 b=Z7wVx8/0eHvIY9yTnmTwuX8NHb7iJLk9bgPn/Vf5oUVPbxnD62Pt2zW7EaIUJkBAhf
 lMDPOu6yubw+L46/TNDk5e/mjlc+Nwgo20Q04J52RpmyzD9+Z1UpKZ3aVoF0de71whBI
 BNZ5FkQ0bgrFFynHqVqTgE7TCwVd/PwFOxb8F9fdS4XyQjwOnhvGk5vqs3TPyPdfvfny
 NNnwcEBNQqhn9C2qvLjquzeXNY9hbG2iV2JyfPTRSSf6Rm23lF4Msq5dUAzk8dHJvUmp
 YDJhAXu8K1HYXFFCROcx424aZHxdk2ywTN1b38VFauLXWYfJ1A2XaELDtpfy7JYh9amM
 Z9ig==
X-Gm-Message-State: AOJu0YxleRXTYzhvWIHYPrCabCXHa6FJxTnepjfaGszjXvCVUFHkXHHb
 CD7xja60YcBUftMDs22OYWRfN0ZbcHDnR0s09MfIbBKQem4JruoTwjk8XSlpEbIioZlFiF99KuN
 9dwBO+QvNf0xFG6dX+NEsNUEaU9BTI2QdCSoZUnU9QYkg8cZVYdsRFOZtlHuaTUoxwGzUeVhRn+
 KcQokrosXuAmeiFGRmoG9lpJL8fl39MpQrOfa0
X-Received: by 2002:a17:907:d405:b0:a27:6570:adbc with SMTP id
 vi5-20020a170907d40500b00a276570adbcmr1076582ejc.33.1706097214403; 
 Wed, 24 Jan 2024 03:53:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMY/XbL1m0MJtUP3+NScatvnLhizDWF3Rymfj8P3ElycwQwBLSJxcVuBrpi26xf2+QLBu7Sg==
X-Received: by 2002:a17:907:d405:b0:a27:6570:adbc with SMTP id
 vi5-20020a170907d40500b00a276570adbcmr1076569ejc.33.1706097213942; 
 Wed, 24 Jan 2024 03:53:33 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 tj6-20020a170907c24600b00a311685890csm619505ejc.22.2024.01.24.03.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 03:53:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] configure: run plugin TCG tests again
Date: Wed, 24 Jan 2024 12:53:32 +0100
Message-ID: <20240124115332.612162-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
dropped the CONFIG_PLUGIN line from tests/tcg/config-host.mak, due to confusion
caused by the shadowing of $config_host_mak.  However, TCG tests were still
expecting it.  Oops.

Put it back, in the meanwhile the shadowing is gone so it's clear that it goes
in the tests/tcg configuration.

Cc: alex.bennee@linaro.org
Fixes: 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 3d8e24ae011..ff058d6c486 100755
--- a/configure
+++ b/configure
@@ -1644,6 +1644,9 @@ fi
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
 echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
+fi
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.43.0


