Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABFDCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlXH-0001nv-HO; Mon, 07 Oct 2024 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXE-0001nA-8S
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXC-0006XK-Mk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20dyWKLKsbm7AEIlw57210l6FlDmgfQn7D0criFKTj8=;
 b=Y5uj/dRLkSb9BqJdVnKT8jDDqd1vDfNfeFjQZVfuKhcBRq/BxAAiFgherwoFnuClosjBZZ
 caK/C5J8Pnd2ryh5ISIlBhU7nYpfWyfxrwzHN+d4SCpF8xHl5K1urWVB/tf9X4mP53QQ9u
 pMxI6WX3Fbv+lSEuvCTsFqaUNebV4/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Nog-IN-pP3CxoJL11WPFnA-1; Mon, 07 Oct 2024 07:04:12 -0400
X-MC-Unique: Nog-IN-pP3CxoJL11WPFnA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb6f3c476so38931215e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299050; x=1728903850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20dyWKLKsbm7AEIlw57210l6FlDmgfQn7D0criFKTj8=;
 b=oDFeBevVUzeitriEMMVa0AeqqNYTKCzhd9G8/nxnUKB345YD9wxeKdbnF1Sw2i414B
 ZQnMdHn+ONU9qVicukOMJEjk0g9M4q1xSirqYYdO8blV61K+h2I00ifXZa+wjBYwiC9N
 5gcVhP95TyIxS31K5lSuZJDOoPMOBha3EsN1ES/fn4FeoKlJuglzJBIirz99uh71ZRoR
 wyOI0s3azwihNJnI+THAX2DS+b93+vEoqZPp0lvdKCjNfifQFLydTG3KaZFxBmp5N6qz
 /t9SoqsWmn5aOoLVopKo9LkL1Y3VcvpgXqy4HmYzx5ivrgPdsBdeF99OjnnvEzsQyGR3
 RlAg==
X-Gm-Message-State: AOJu0YySUA6uGdWKRryQklkcfemRY7KXreUMONEBT6Qqn3TvOaAIrrAr
 eBI+dr7cAeh6sUZ7QiaN8FSztD9vrnzc62Au+/BaGnq8eZ/jSgUEZ3liaHjKAgdGtGEGMlfYms0
 2q6XzACyr5+OxEj8w/bQ358RCFPYYXckPnwtM3BsviOi8SuWzLwNmlIXEnsU3i21b/H3zDSUd8z
 /5i+DMqm3Y7DAP58E/q5HLD7o4iWbg6NYsvlqxLOM=
X-Received: by 2002:a05:600c:3b96:b0:42f:6878:a696 with SMTP id
 5b1f17b1804b1-42f85ab9c1amr87493545e9.21.1728299050475; 
 Mon, 07 Oct 2024 04:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHs7YjEMTk8RhwPariSJFJQHZ55cjhhJCmnGDi48BwQbisjA3t3LWk4THctiaLiYJidYRMHg==
X-Received: by 2002:a05:600c:3b96:b0:42f:6878:a696 with SMTP id
 5b1f17b1804b1-42f85ab9c1amr87493225e9.21.1728299050028; 
 Mon, 07 Oct 2024 04:04:10 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e462sm5488869f8f.87.2024.10.07.04.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:04:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Subject: [PULL 05/12] .gitattributes: add Rust diff and merge attributes
Date: Mon,  7 Oct 2024 13:03:33 +0200
Message-ID: <20241007110342.1298598-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
2.46.1


