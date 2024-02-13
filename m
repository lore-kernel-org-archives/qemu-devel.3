Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8208C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv23-0001GR-0m; Tue, 13 Feb 2024 10:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv21-0001G8-SQ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv1z-00051o-P3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oNEznVhh47Z5bGoBC049BDTFU2QASJ+BUlFQbFSkzXg=;
 b=ahY7/QEibAEgb9AkM1g9zcnnsEa5tuPlqFrtvpZwtQ26Ihz8oGwkl5i7kKzKfjGW93IW3N
 6CU1KfetIs8OOBa7wIeMdjzrFH3ah7xI7ha7e/D8T+8M0HLe6jGT6f87KNJfcen8/U9pWN
 +5O5+u7cQzAyKpoo9HxcYCzW7b9mt2k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-_0Dg3MsUMfavqvzL1nZfYg-1; Tue, 13 Feb 2024 10:49:08 -0500
X-MC-Unique: _0Dg3MsUMfavqvzL1nZfYg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5597da35ebbso3226675a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839345; x=1708444145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNEznVhh47Z5bGoBC049BDTFU2QASJ+BUlFQbFSkzXg=;
 b=RsGjaKYJJvX+2VFQTkTsaYazSiytrIz1ejml8r8t20KfsKxdA0v/+q9PHnocPqK8wk
 ybN+GRiE8Ql8Qe0KvzQQonxpbi6AdcPseAWxVX6v74NakEudGS9wkUneECYTfGgxiqiF
 jU+HP2QQ03APhUhYB+wrANWeDftrsIejrP9nwCCAu+8bb7NW6F+NExunJ4yyC3acvMp5
 SY5aGj7VOQwqhftZ+gciFnwxi1RxVMHoBzrvw5HNknCE/OXSSeUrmN8TG7HXEJ93nAk9
 gM8C1DsCIoFT6cdI4GsfQWXASvXKf2ebld1ut9Hs2W7nBigftCaADNYV/jBmtEPGqLqn
 ZlCA==
X-Gm-Message-State: AOJu0YzVEdN1NDp16zvbxk9e/7CKFZ28GWJL8G5E+M/q1Xc0DnjmZVJV
 2zHaNT4XhVr7QXIaruGA7hJ6SI5MfvDeXGMIEz2gqvex6gUXsXxw8fk8mUnC5u4zHeA1qGsgfB1
 Dij5DiXNxFncu685iecCqqGf9PGu4l5uDy+kT5HXgWpGcycokujfsUX+SUSssSorDeRwPCtmzZ2
 DqktF4vb/v/PJmTek7UysfCdgS3zr8SNISaDq9
X-Received: by 2002:aa7:c1d2:0:b0:562:80:fe95 with SMTP id
 d18-20020aa7c1d2000000b005620080fe95mr21764edp.39.1707839344985; 
 Tue, 13 Feb 2024 07:49:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEgG6nywG3dR61v5MJJkHLC9XwbTbk6DpHvIRWmtWhWlgE3awkdMQhGkFJZjwzYYmSzaQ5PA==
X-Received: by 2002:aa7:c1d2:0:b0:562:80:fe95 with SMTP id
 d18-20020aa7c1d2000000b005620080fe95mr21753edp.39.1707839344577; 
 Tue, 13 Feb 2024 07:49:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXvTJkeelnKYcWeJSzUc2BiN+CXr93/KrNdh5Zkl4yvixnMry/ueeWeaMmZDf5F/7z0XiBBTcBcFj+9IEVl8K/FKaZmynkInKGgeP8hX0+RbLxHGmI=
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 q26-20020a056402041a00b00562149c7bf4sm103379edv.48.2024.02.13.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:49:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	berrange@redhat.com
Subject: [PATCH] ci: Fix again build-previous-qemu
Date: Tue, 13 Feb 2024 16:49:01 +0100
Message-ID: <20240213154901.109780-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 3aead277246..901265af95d 100644
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


