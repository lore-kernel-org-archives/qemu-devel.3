Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B06CED63E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHR-00016X-6x; Wed, 09 Oct 2024 05:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHN-00013i-LF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHK-0008QN-TM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8vlBtfYk/aY00V5/AIvQmHcz5MFzLsYtflzR7ilOtw=;
 b=HYO1QZhdXK6FVAC/KhjmGjYIrdToLYR60Q+AZ12AU4oLoWdlZZdvalsjQZPNDkCUyapdgs
 YT2K4i5iIW9+CHHx8GcK+FoXp0wYssOb+RfMiqH27gSGyBzFMUQUh0Kyz+eLiv0M4Easn1
 +pBEdW+27tZky9avWi6G0fQkKgIm+pE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-n9sthKEPOz2hOH_4YOOi6g-1; Wed, 09 Oct 2024 05:46:43 -0400
X-MC-Unique: n9sthKEPOz2hOH_4YOOi6g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43111c47d0bso2992105e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467202; x=1729072002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8vlBtfYk/aY00V5/AIvQmHcz5MFzLsYtflzR7ilOtw=;
 b=fFApj49CwqtlpkYmptDh8BoE5wbSCWWYmfpcRs0m9+iybMbQG6aXCukFt9xoOisbFV
 rer+8IDNknmBs8mpVHUGDWj41Fx0DC9df8jy7MxAksXAQ7Txj13yclqY+rjQLv4BZ9c2
 03m3bbdTbiiZ4x/gSF25WkBBUG2/meRGqD1rDMKjajdiyjVzA7MeA0cjgK8D51yk1sKP
 KSRTRF+WhcUILb00AYUSP8vlHfH+655ErsVhxE7F0KXhKwcFk8d/DXVeyfxBe/KDAdHp
 pUvDw7KIw/vaDJZBza4JuRNivGxcdXtgehZUZh3/36S6CGjqSCPNHgVUThYa0C30Vvsk
 Q2JA==
X-Gm-Message-State: AOJu0Yx1Lrq+iu2tJV0k0h5e+jNkilXg2f3H0r1zlUt4rQT/k+Mrrgit
 IqMOFSv/y5eN3VUT1KaYVBxyTviSioSAocF3sgI6wVVYoRLFLNpo2/0RqVzSW/YmT4YYGQKB05m
 6zHrckl/Of7DjB+RBNujgU8eDjmwUJ/I5u6USeMlESBXpfDU09RjW+zHDmwTZtdSmt1G7ZytFqZ
 +f4ImyU3bVdtACFdCxCaLDzzbnI+ia+MvL7qDoCz0=
X-Received: by 2002:a05:600c:358d:b0:42f:823d:dde9 with SMTP id
 5b1f17b1804b1-430ccf49598mr11235515e9.21.1728467201757; 
 Wed, 09 Oct 2024 02:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhO/PqGt96hhFbK2VUBhqN2yIcupYYnwUNE+YRYn7890xuqW8+2+JTjZSN4NHbxyOdGZVFQg==
X-Received: by 2002:a05:600c:358d:b0:42f:823d:dde9 with SMTP id
 5b1f17b1804b1-430ccf49598mr11235365e9.21.1728467201373; 
 Wed, 09 Oct 2024 02:46:41 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43096601152sm16354965e9.0.2024.10.09.02.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:46:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/14] .gitattributes: add Rust diff and merge attributes
Date: Wed,  9 Oct 2024 11:46:06 +0200
Message-ID: <20241009094616.1648511-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/278e3878b40ecc7c424dec1ed978eedf21469f52.1727961605.git.manos.pitsidianakis@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe9..6dc6383d3d1 100644
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
2.46.2


