Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRL-0000Dm-8X; Thu, 09 Oct 2025 03:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRJ-0000Ce-CB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRG-0004Ut-PJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpLehWuVj/iTQMlAG5SBBBJrQjnUYuy4M749N9Qa2C8=;
 b=esskA8Ism16xjV8qpDXANW9uN0wLN3xmRZtixHpiInwv6QYFoSiFt3PcgDEUy1WLSP/DEw
 GvAfgcUDStkl1mjc4wkwO03dkBeXUF6/8jVaLp9FnK1A4CDk7n/vDuiBti3ZT1zk9zv34p
 nBgxP42y6MwGscpcb6kv6AccZC6SLAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-nwltMzyHNyS04xeH472pow-1; Thu, 09 Oct 2025 03:51:47 -0400
X-MC-Unique: nwltMzyHNyS04xeH472pow-1
X-Mimecast-MFC-AGG-ID: nwltMzyHNyS04xeH472pow_1759996306
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3d43bbc7so3140895e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996305; x=1760601105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpLehWuVj/iTQMlAG5SBBBJrQjnUYuy4M749N9Qa2C8=;
 b=j6vn+UdfOm1B7o9WSw28TtJ7FT1dGQ3oOLSbXA93Wr1Cef1sTlMnwJmNH+z9+grEWt
 kbAnXr+rAj7tYdPn6gyd3Rnonzn4z45ctzKu7kuouNFJiav7LJK04A74ELFUI1aYUW1a
 ztBf4hyia7j3AdBuPyTkz+iNZRjfCBRUbiUAiN/gygGqfx3KIOb+/la/xkT8RW2Uvd4U
 eFUqB2pzLnTDEJ/VhFbsxDqG9IV6WNPBYLjRPbkndS0uXQT3eVyIZ9Z7/TBjK1UdRuWB
 Cox2DgEvb+LLLBpDpcdYB0oQZ0uUWoVNqVoozAbKXJt1D1D8SvQpXFLZ4OaMa1x5xzh1
 M5MQ==
X-Gm-Message-State: AOJu0Yz80/pTANhgQWq/vpVj5EzIsuZ/SK6KYEp53Phq0B3P5XGIZaUb
 6Pl1CUAEn7rdCe39Eo9EvkT+rxLgJFqheh4KusXXkqbSTjHibf85LcZ2LRFLIRd6JrFkck/dN04
 zMtDaBFaqlP0oBPvnudH6JsVrbIr2gksos6no8DRhHSnaM4uHBs3MpM5lGT2RN1MAI3Bnf5ORlS
 rrir3pMck3X/ioPXlmKHgm6YnT0cRNo+zFbYCz+fN/RmU=
X-Gm-Gg: ASbGnctFWkd0FP70JE60gOE0z+LX1hutyfvsVqZowEwZfBQfA8aSEurVp9xTZT8v8g/
 Vv5UUBvmPVviKb/24k6wGOFDAntreC5gyENgSvYixDBlW/t5yOYs1BXDtczKXB8I21rvDkX+1zV
 DQvc5NyxsDNTSMu0ukMiE9i5thF/n3pWXxb81agy5CxgGyISKFgMYjqyFIyehI4o0DS+CjNMY1L
 GwPSrpVYxdGQ9aD4eN7lNblYO02Aj+xhWSZAgjpLN8CUdacxyZCALI/4zpsBVp+S2KbmYHbqFMo
 YjNMRlYwJqzih4/7QiF1hUs7w+i5xzSL8U4bmzWdFm3BDbrIflm0GYM6VFZg3Ts6LwlpEVypmqW
 Oi06oyi59hJ/p5qXaXZgzchytYN7ZJaMkc354id1NMh3NKaTm
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id
 5b1f17b1804b1-46fa9a96712mr42492515e9.14.1759996305656; 
 Thu, 09 Oct 2025 00:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyRaTWhC2L8anr87OdCOfpThLQPuwvxVjYJArYTqPkUqCXCt0RIp90HT1BjwVOd/Lo49yEVw==
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id
 5b1f17b1804b1-46fa9a96712mr42492325e9.14.1759996305188; 
 Thu, 09 Oct 2025 00:51:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb1e0f019sm13875935e9.10.2025.10.09.00.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 34/35] tests/docker: make --enable-rust overridable with
 EXTRA_CONFIGURE_OPTS
Date: Thu,  9 Oct 2025 09:50:24 +0200
Message-ID: <20251009075026.505715-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20251007153406.421032-1-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 752f4f3aed9..79d533ab2e5 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -53,8 +53,8 @@ configure_qemu()
     config_opts="--enable-werror \
                  ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
                  --prefix=$INSTALL_DIR \
-                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
                  $enable_rust \
+                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
                  $@"
     echo "Configure options:"
     echo $config_opts
-- 
2.51.0


