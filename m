Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CF5C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwZ-0007zw-72; Sun, 09 Mar 2025 06:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwU-0007yR-Ca
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwQ-0003zK-Tu
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgIRhA8V2yoGG7hQoR/1cCd/zfNZuMqAha1UxtZ8iWY=;
 b=eZFInYglTldYCPlwjQu1YQRQufeyyVVESJ5j/Wf9qapjhc8eEpKviXNj/f8Agv0i2Hupyf
 XAi4jfQVgT9c9kyu59hQWMqhsSjXMQrErBh6nH0MH4+l5AYNoLqF1TzynFu2hxFSX/SFdk
 1UDWXRCwL/NkgdyFD2dk11lrJ3iUnPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-hqNRVrjQPgW1w-KaP1XSuw-1; Sun, 09 Mar 2025 06:31:28 -0400
X-MC-Unique: hqNRVrjQPgW1w-KaP1XSuw-1
X-Mimecast-MFC-AGG-ID: hqNRVrjQPgW1w-KaP1XSuw_1741516287
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso27254715e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516286; x=1742121086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgIRhA8V2yoGG7hQoR/1cCd/zfNZuMqAha1UxtZ8iWY=;
 b=s60xVvhMzvFhocwHY1g8aX8PUOPVk/slh+BoZ+Q969H4uiAQuuYpSfTFpEnIAN6/B2
 ZAuaPew9xEIyz4zWb+8u80C5szsV/4/OuF4ba7KRubtWbmVjdNVErkEXexvVJxoRBRxe
 kf24h/vtxsdaf7urNB0AGc95RlpKGMpZ2l5b9Iorqr6a5EMs7zp3+egGcHPlj0Dz85sT
 Jblu3m52h8z5lGkAE/XkZoDy/mDwvl0aBATbYLA1E4oCZoo6azHTm5pL6NvikiaKu9TN
 g4NG+mGzcrItVA8JGy3CDcJYQG/5lPripjUV0MMPFTppm1N9EIWV1Td7PQi/t+c/Y/IY
 Y2pg==
X-Gm-Message-State: AOJu0YyiqlOLgFm5TK/CrXELWMlJcYTy6cvzHg7otw9riim8+VXgVI5Q
 6qYjnn7t7ckwf3jn5vZjG/b7PY6/pxnxDcJXbmsyY/UHt58QJLJGmHR2KwpwxU//F9wkjF83pdl
 jmzUNQ7mmh03AmaN0Dspux+A0IlL+rjGzc43A3LGtDyYZKZDi+wC/83VI1U0qt7ZMXGDEGvF4Jg
 svM2o9jZ4a9NcqTosr5M5fkxrX59B2pGK/5R3n1Po=
X-Gm-Gg: ASbGncs+MZPWrFq9ggpg3SqoK5w2+eE1SWkpTNmykyHHeTohjQQzoBBAzNq2pNLYlbG
 C63lzXA5wlOv0+/3Y+NpROKSWawgEXgedUN8wQs9lvqV50qN2AdrCbnQUIv1gzACX5SoOlFfs0U
 /a8BzlrpudV7LS2eKy7OQgZFvDquxB4KJIiyiSVvkhOJY4w5+FQgYWFB+XKnVGhTgaIQj6XDi8n
 RWjEZLYIH8aJL5mo4CLbdGTSS73cZ9lClDiJbz6i4oLR0ymB/WLCxoXwqm8OynA3+sS6hqoESPX
 aIdmlj0o1BBFNnksWJlpVQ==
X-Received: by 2002:a05:6000:1a88:b0:385:d7f9:f157 with SMTP id
 ffacd0b85a97d-39132da227bmr6500345f8f.36.1741516286426; 
 Sun, 09 Mar 2025 03:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaDlPjXUfgjM8InPOnJ0iOMoCeRWqonODvrAmP8IvItYQAdPMu3UHu2/qS3UzGctv9e2cfkg==
X-Received: by 2002:a05:6000:1a88:b0:385:d7f9:f157 with SMTP id
 ffacd0b85a97d-39132da227bmr6500337f8f.36.1741516286047; 
 Sun, 09 Mar 2025 03:31:26 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1030cfsm11732833f8f.90.2025.03.09.03.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nabih Estefan <nabihestefan@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PULL 02/25] scripts: dump stdin on meson-buildoptions error
Date: Sun,  9 Mar 2025 11:30:56 +0100
Message-ID: <20250309103120.1116448-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Nabih Estefan <nabihestefan@google.com>

Dump sys.stdin when it errors on meson-buildoptions.py, letting us debug
the build errors instead of just saying "Couldn't parse"

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
Link: https://lore.kernel.org/r/20250227180454.2006757-1-venture@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 4814a8ff61f..a3e22471b2f 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -241,8 +241,14 @@ def print_parse(options):
     print("  esac")
     print("}")
 
-
-options = load_options(json.load(sys.stdin))
+json_data = sys.stdin.read()
+try:
+    options = load_options(json.loads(json_data))
+except:
+    print("Failure in scripts/meson-buildoptions.py parsing stdin as json",
+          file=sys.stderr)
+    print(json_data, file=sys.stderr)
+    sys.exit(1)
 print("# This file is generated by meson-buildoptions.py, do not edit!")
 print_help(options)
 print_parse(options)
-- 
2.48.1


