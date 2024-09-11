Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA66BEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXq-0004ic-6u; Wed, 11 Sep 2024 08:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXh-000445-TG
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXf-00010y-Qp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YabOEkQqVQQuj2asf79OGJROe40H9cY/9FGkA84yObA=;
 b=B9cvOfIjD9SDyZTJRhYZmIXISngUYDCl5TtwC5iiGVF8mKjLzWpXYZE+O4vPzi79FUHGuY
 GLaKU14yuz9m85fuDKQqArjVEh5WUDsYCG5tpm3YlQlZz/59Z2Feb5kz7xxkX4urBzZcsw
 pw6AFHtgBti+bWJoyHWQ8DmnDCym4ag=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-LsMHo-U-NXmYxS-ZPFln5g-1; Wed, 11 Sep 2024 08:33:50 -0400
X-MC-Unique: LsMHo-U-NXmYxS-ZPFln5g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso35245495e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058029; x=1726662829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YabOEkQqVQQuj2asf79OGJROe40H9cY/9FGkA84yObA=;
 b=SEywijbqTRb7iwlS4yDyvK2xG9K2bDRXu1pLV5Y+irHoeyKwW3ykOOxdilXAXBJfm7
 DfUZw8HyVCJC8hJU/mmrpecJf6+afS8bpsADHpkUjvDwYnKiqBEcTB6MQ5T23CWtawa5
 s2aST3B528wG8C5+hs6Qu6pjrhlNhYaJQ1YtNu2J7Of07g9IdBFqEmb07fWsmJ6SLK0F
 MzR65XOpJK7ybUS1n1AnWzcGlnNBJ39We0pHH39+pzoKp35HIDOhII/vUq+kMA7tjR4i
 MiCN3CNh+oCR+fvfH4Lc24RsIDB4HpgVzakjP+cRviZoS7xL1fM3kKaeGdzT10p26x/Q
 zgTQ==
X-Gm-Message-State: AOJu0YwoNg7RFXOOFIOZin3P1tGp9cp1GugkBxkW8S2Fwi1rJ/E4nRXE
 IQqWEsBWdBbsHpAo3SGzHStTfM2Hn0tPif8ETmYmsXx0h9OpyrfjlX6f6VNgEzH/Me6l98GbcKw
 jCJEmv1YemhAUno7b/DY7YGcbWPa2igeIlKHzw1MXniY20+SGxwQarOBeDubtKXdSIlcU9e9qoV
 0IaTyz40Ii9hw3Ii0+z2a5zg2VCFqOUNQ03S2MF7s=
X-Received: by 2002:a05:600c:3ca7:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42c9f97caa0mr145663945e9.13.1726058028714; 
 Wed, 11 Sep 2024 05:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwHapi49LVjQ6ULmf4m4xN9cQnqUC9pfVNF8z96TFwaRrhUiNRrY4qaNwdnuAHV92T0acePQ==
X-Received: by 2002:a05:600c:3ca7:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42c9f97caa0mr145663695e9.13.1726058028130; 
 Wed, 11 Sep 2024 05:33:48 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb2f86488sm124715065e9.15.2024.09.11.05.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:33:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 01/17] target/i386: Delete duplicated macro definition
 CR4_FRED_MASK
Date: Wed, 11 Sep 2024 14:33:26 +0200
Message-ID: <20240911123342.339482-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Xin Li (Intel)" <xin@zytor.com>

Macro CR4_FRED_MASK is defined twice, delete one.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20240807081813.735158-2-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 14edd57a37b..2bf37dd15e0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -267,12 +267,6 @@ typedef enum X86Seg {
 #define CR4_FRED_MASK   0
 #endif
 
-#ifdef TARGET_X86_64
-#define CR4_FRED_MASK   (1ULL << 32)
-#else
-#define CR4_FRED_MASK   0
-#endif
-
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
                 | CR4_DE_MASK | CR4_PSE_MASK | CR4_PAE_MASK \
-- 
2.46.0


