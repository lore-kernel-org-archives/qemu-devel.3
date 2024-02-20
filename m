Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0115C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLBM-0000lr-4h; Tue, 20 Feb 2024 03:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLBE-0000CN-P1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLBD-0000gB-7X
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imZ3RUOwHgnSlC/oclQrKn0u6lgwbsaQMoHzpRTzBAo=;
 b=Dae2Gte1TcJuJIVbT7H2gJgEyHdGVJqN0ZwdHEvHvUdt71iQWTVDf4X4rEFGqpaYowWZES
 RNTGGdn+ymChw2m6IB7Xm0drtWgvZ0DmnRswp3qGNVJI3kfYnO83mmhcipUC9yUGvBprG4
 Xwv+6qIt031Oh/THxoU+4YKjvpwkxFs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-3eNryg0qPrWdyi6cxakWBg-1; Tue, 20 Feb 2024 03:08:40 -0500
X-MC-Unique: 3eNryg0qPrWdyi6cxakWBg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-564347c68b9so1318916a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416518; x=1709021318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imZ3RUOwHgnSlC/oclQrKn0u6lgwbsaQMoHzpRTzBAo=;
 b=BN7bN125f5hxTJ2KMR7G3FgdK5nw3n8T5lEv3zr2sUAr0WtW5BX3NE+tbfEFn1+n2Q
 rUagyMoXfuYtvBehM5RZzck6Da90diclADMrj1LfY0G7F6ap94GWjyl7CvQfjIdpan9M
 aW4K7iLfsuQJJF9mKfMi1n85QHwZBFDtooKTabVEib8qCtZQFTmjP6zOoc07RSjcumjf
 2uwSiKgbiKdSA3dZyiyP2p++CstFMA/Lzrvc0u6RhKJCpmD6i67EkkNpUMMtWZxfu0ws
 0G2uJ1fagXMVnqAk1Uk/ViEQ3y6m3i5jxSYBdyUCaInZNSl+QkjExc5ftCCPEL9S+8X/
 +ajQ==
X-Gm-Message-State: AOJu0YypyXDWK14AQsJIeAZ9jIvTlptU63htWpgwqIebG2q8gZZCkiFI
 G7ChLd3AWsikQqhaQmaBk1RolwFS8DEiw1lZGf/J5SqwZL3TB6kx2AVjAIGDlj6Z0pxKFwDlR8x
 9QVwKwjP1CxMJUfch/mCY2yhKrQNJQmzGwOz1dIkxR4Z9he0Eupl75CeZSNN9XyyDSGZWrrCNdm
 1RixPrdTGFM78UITNlotPZ1dnS7UgcLXdaUtkM
X-Received: by 2002:a05:6402:3513:b0:564:151c:747a with SMTP id
 b19-20020a056402351300b00564151c747amr6526054edd.27.1708416518580; 
 Tue, 20 Feb 2024 00:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG30koI5qZs4a5xKdpAuq9qT1dU4Bb/cdXI7UwOssBki42XKDwDU1eT6JVzLkNdC9SFc7fsdg==
X-Received: by 2002:a05:6402:3513:b0:564:151c:747a with SMTP id
 b19-20020a056402351300b00564151c747amr6526041edd.27.1708416518359; 
 Tue, 20 Feb 2024 00:08:38 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 i26-20020a50fc1a000000b005603dea632esm3436754edr.88.2024.02.20.00.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:08:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PULL 17/17] ci: Fix again build-previous-qemu
Date: Tue, 20 Feb 2024 09:05:58 +0100
Message-ID: <20240220080558.365903-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

The build-previous-qemu job is now trying to fetch from the upstream
repository, but the tag is only fetched into FETCH_HEAD:

$ git remote add upstream https://gitlab.com/qemu-project/qemu 00:00
$ git fetch upstream $QEMU_PREV_VERSION 00:02
warning: redirecting to https://gitlab.com/qemu-project/qemu.git/
From https://gitlab.com/qemu-project/qemu
 * tag                     v8.2.0     -> FETCH_HEAD
$ git checkout $QEMU_PREV_VERSION 00:02
error: pathspec v8.2.0 did not match any file(s) known to git

Fix by fetching the tag into the checkout itself.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f56df59c949..a1c030337b1 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -190,7 +190,7 @@ build-previous-qemu:
   before_script:
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
-    - git fetch upstream $QEMU_PREV_VERSION
+    - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
     - git checkout $QEMU_PREV_VERSION
   after_script:
     - mv build build-previous
-- 
2.43.0


