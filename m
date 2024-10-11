Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51100D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ6W-0003TH-3C; Fri, 11 Oct 2024 13:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4U-0000wP-4a
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHdT-0007D7-Hl
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8vlBtfYk/aY00V5/AIvQmHcz5MFzLsYtflzR7ilOtw=;
 b=hPRZAMMC5tyIiGbVJLt9EyB38riHGzJTGdGk+pWhtqnlCS9lKgbiSpECTpJz68MBtOZ1IG
 UIrl/RUIsz64ZZPkmsvODjSiwHX0w9KWNPBmdkKjFTxl14hBVoMTLzPDdmfdZnGQlWvwrK
 oo9M0AzgqIg8Ak5rAAdE9Ojgv85p5lg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-7UJ1kSIxOjmrhyYkmbs3kw-1; Fri, 11 Oct 2024 11:32:57 -0400
X-MC-Unique: 7UJ1kSIxOjmrhyYkmbs3kw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c9452d6344so790328a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660776; x=1729265576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8vlBtfYk/aY00V5/AIvQmHcz5MFzLsYtflzR7ilOtw=;
 b=MWvPvG2jQlTUZMyRufBJ3Qdrr5IKIFCzHmiNq/QgOJlqbylb2lqFYAVJtIfUhgkS4a
 UYRfdN5e4HNRwdfTp8XlXGOOzx4ym7i/6nV2VPnnEeIj7HO8DNyttdRUKdDSxiCCF7NJ
 0xDlxqqKS0nbxzQwgxzSFYVluBRInBkff8LsYC4PkRTHgPSWJnDDgUo2bcDV6Wr3PSTc
 YuaLGE5kGytZd6yFqQTIzfcpFmGkcx4tlx/1HeFwvoq/xDCdawNg7FwWmAYZz3Tqcl0r
 0g4chFf6gREoi8ABu1WWpi1Q2KtSFtk1ugXZK/JdDNDbv++6TCoT5XZ3e9uU1xAvbdyg
 FBHA==
X-Gm-Message-State: AOJu0Yx6Objnty0nj2dqqUcSn/8WjvN0dFIXxGe+7SmUH7ICMmZ376hD
 c0dO5Ynm/jYdbQSMDRI6Uzy+yvqkPfTeOsVeBB8vNGo5QWKP+7H5XulDBWKj3fKOnzPKi8OjcQ3
 jt6xPLRcAE84jGKrpto9RdgJc+Ko1w1R5AlR3Jy0zfckJnapmdffSSipx3Ek8+iFZw32AWu4YJn
 CD1M2YBQHFAz9w5LCIdRg9INw7CLPgwzIADsTTKZ4=
X-Received: by 2002:a05:6402:42c9:b0:5c8:8d5e:18ad with SMTP id
 4fb4d7f45d1cf-5c948cca082mr2365920a12.18.1728660775701; 
 Fri, 11 Oct 2024 08:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHwwT/irIzAfs9HVk8sJFzGgXcXsOLjEEbSRkN9I51QlvXi+doaU6KTmaezxnrldUik5KruQ==
X-Received: by 2002:a05:6402:42c9:b0:5c8:8d5e:18ad with SMTP id
 4fb4d7f45d1cf-5c948cca082mr2365879a12.18.1728660775114; 
 Fri, 11 Oct 2024 08:32:55 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9370d3795sm2031803a12.9.2024.10.11.08.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:32:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL v3 05/18] .gitattributes: add Rust diff and merge attributes
Date: Fri, 11 Oct 2024 17:32:13 +0200
Message-ID: <20241011153227.81770-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


