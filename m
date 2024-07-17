Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A479C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwps-0001fp-BZ; Wed, 17 Jul 2024 01:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpj-0001Td-Fn
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpg-0001zn-Ao
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FjeY3lbHr8W1TqtDdS/6AWEH+6oPWgu9f9eGwYiFZw=;
 b=jISuEmpQ0xxM2EUuAAtYnuhOR8Hl1xywGtkqDpPY3oChNYY/A+EY6Z62FFVhVMQ7wpCb4c
 OEIZTba12dUpG/7ZeLTlUXJWJPILrsjR/1aVjbTY4bvdOm4EWprROsvhdI1xidZ8wdRguG
 RuTHbhFHseBrGibJ92Oio182gphbGxs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370--pp0sM_KMd2b-DFSkHgHdA-1; Wed, 17 Jul 2024 01:03:55 -0400
X-MC-Unique: -pp0sM_KMd2b-DFSkHgHdA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42667cc80e8so45300295e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192633; x=1721797433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FjeY3lbHr8W1TqtDdS/6AWEH+6oPWgu9f9eGwYiFZw=;
 b=AUlOklkiqUY1lXawuXC0yq2SPZiylVhxgGiquihSDtQAKUsHrxFBv06Za0GF5n7Nv7
 8fnaYM3Zz6ujCEYVLEEnZeH+foEnowbJTLYal4j+OexgH7zlTfyjmr7W0b6kFuoZvlSj
 Vc6UUpwn6/UGap9N/r7CFtJx0dmLgGJuZSu2LNnSKhU94SjfvNNbbT210Be4vJigFqY/
 dwnX4b9PfsrE/NZ7QVdY3rtZmToxX5H4zr75csNoNQ8TAXElZEhfdvSlagoffopKIghW
 ZmP693iOFtqQdW12OGg25vJk0OzWTe6XlVrRRJD03YzWDf9BevgRruTDbnjh/HFTetNA
 3MUA==
X-Gm-Message-State: AOJu0YxOCwVoPSFMQ2Xk747hPKg+N0CUQsdhqvnb6KI8SSkUsMV11uMy
 qTktqGDDKrrmTr6nbfSEt7wE3yBeNkTCvWmrlbiyjAWmw7bfvz/HokfceqdvW1pBqWftE+hMm/k
 NbZ09nRCzmv+MiNcKqCQIwGTp4fa1BauohqOD6NT++64MhrgV3PQN8bk2Ep4RhtJBOaowH81D2f
 BId1Oo3KyYbEzQM6fHKxV/8crwA8HU4uK9Gbqc
X-Received: by 2002:a05:600c:1e83:b0:426:5dd0:a1ee with SMTP id
 5b1f17b1804b1-427c2ca7be4mr3055295e9.2.1721192633515; 
 Tue, 16 Jul 2024 22:03:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvgbbMCEY6VL70OiL+pHbqocOx/rqpql070/K80aimw8zTVxTKG7nqY/nje/0wmGowlQTXOg==
X-Received: by 2002:a05:600c:1e83:b0:426:5dd0:a1ee with SMTP id
 5b1f17b1804b1-427c2ca7be4mr3055155e9.2.1721192633152; 
 Tue, 16 Jul 2024 22:03:53 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db047c4sm10715755f8f.108.2024.07.16.22.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Boqiao Fu <bfu@redhat.com>
Subject: [PULL 08/20] docs: Update description of 'user=username' for
 '-run-with'
Date: Wed, 17 Jul 2024 07:03:18 +0200
Message-ID: <20240717050331.295371-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Boqiao Fu <bfu@redhat.com>

The description of '-runas' and '-run-with' didn't explain that QEMU
will use setuid/setgid to implement the option, so the user might get
confused if using 'elevateprivileges=deny' as well.

Since '-runas' is going to be deprecated and replaced by '-run-with'
in the coming qemu9.1, add the message there.

Signed-off-by: Boqiao Fu <bfu@redhat.com>
Link: https://lore.kernel.org/r/CAFRHJ6J9uMk+HMZL+W+KE1yoRCOLPgbPUVVDku55sdXYiGXXHg@mail.gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ad6521ef5e7..694fa37f284 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5024,8 +5024,11 @@ SRST
     in combination with -runas.
 
     ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
-    by switching to the specified user (via username) or user and group
-    (via uid:gid) immediately before starting guest execution.
+    before starting guest execution. QEMU will use the ``setuid`` and ``setgid``
+    system calls to switch to the specified identity.  Note that the
+    ``user=username`` syntax will also apply the full set of supplementary
+    groups for the user, whereas the ``user=uid:gid`` will use only the
+    ``gid`` group.
 ERST
 #endif
 
-- 
2.45.2


