Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D87CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLta-0008UL-0I; Thu, 03 Oct 2024 09:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtX-0008TX-42
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtV-0005y3-LZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so125101866b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962164; x=1728566964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXjCGVQS/+hcLwTR+qUNdXq2a9N5/772SuBnlrJC6HA=;
 b=F19vobGfd1MQklhK+d0se8HaToh4F6bqyL09gsfnzfHmUnsrxfnPnCIQF6XvkK28ko
 P9FG+VgDo4rSnH1yw44/QUqg6Wxs+XW/vdFzTppwEknqKSqs5Fdy3kWSXVWSCz5W/KNX
 aLM5GptwPHhsv4xSoqYZ/17pMNl2Wmu2b5mLmlOLzm20PhtosRtiyfQv6DpnOUgKdLkZ
 ruoI7N+bdi3hyHubNDU3W5UXCcxk0lUyg0UVXLCj/SwQHpmxOk2rxCSD7kenUu9o/rla
 C1n7ktLrouxLYTsxjjPofrMMWfyfZ0GfMO98d5MLfIW1J5S8n+IrC8SWZ5T+pXSxpbZ9
 T4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962164; x=1728566964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXjCGVQS/+hcLwTR+qUNdXq2a9N5/772SuBnlrJC6HA=;
 b=plpvkOz32BVlTSANTGtwuZeDdeFBIYbItticrGFPtmngvpDhd9q6PUyoo//AcPYLuV
 6z7RGaPm1h6t0rPGpprUVqvpEcfzjCiJ1VBSKbzNrY4nWgHHQKoqgoujTN1qvjP9O16j
 mF0IsILuZq6ohYAdsF8eUqnjxtP99Jmhascg+BLdoUyk+f6it7ZQy2jw/83LIYBV/pL+
 r2bGq3zbjDkud1rBlSgYv2LodqRDDUMcxzMJYDiDqjo+FYzA2bhOeBSBNUaRjs1PZyEo
 DVStCNTILeiqw7JzoT460VF+6UsaxQ5gBLsv3ubmUnLQonKZYsG1kOiZqJflYZeGKUmm
 ZIIA==
X-Gm-Message-State: AOJu0Yy82PM71XHrqo+UWW6hhm52TGcwLGmVW0ZO9zB+vYXOSteW0TPI
 3EdmquhtqxMAOQXM5N5Kr7mdgJbVjv0SJmipQhR0x9iIbmS16KZTw/ldJ/6Gw+2zAEaY+Xe+04U
 Nch0=
X-Google-Smtp-Source: AGHT+IEQPMKzaiNupy4x5n57gF0o64BdBk7rqJ2cl6KAOhPtCdnIXPvV0CH45Ue7z/mKhmz2VS07kA==
X-Received: by 2002:a17:907:3ea9:b0:a8a:9054:8399 with SMTP id
 a640c23a62f3a-a98f826d705mr614828866b.27.1727962163669; 
 Thu, 03 Oct 2024 06:29:23 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:23 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is
Subject: [PATCH v11 5/9] .gitattributes: add Rust diff and merge attributes
Date: Thu,  3 Oct 2024 16:28:47 +0300
Message-ID: <278e3878b40ecc7c424dec1ed978eedf21469f52.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe..6dc6383d3d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary
-- 
γαῖα πυρί μιχθήτω


