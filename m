Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E028BC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXg-0000go-Vd; Sat, 08 Jun 2024 04:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXf-0000gU-KJ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXe-00005A-9O
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAfO6Ix8e+bhIYRVOpA1NwjJTADdLTV0dP5aAUkqZAo=;
 b=MozaAGmPhlSWWnRcjZ7583kWWoO3HOYCTGnTnyZ+n5NcIG9klZB1F1/GZKID4jpyELtYm2
 uKFveZ/6CtQtgXTwi01FNswFiWFoN484/4EZCIpU8GVH18vTBIJSiTd79qD1TRPbGtDZaY
 NsTnZcwdua3erse8s4GgecXc1r47bw8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-boOv181CPQCF13TTO989ng-1; Sat, 08 Jun 2024 04:35:09 -0400
X-MC-Unique: boOv181CPQCF13TTO989ng-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52c82e67810so26115e87.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835707; x=1718440507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAfO6Ix8e+bhIYRVOpA1NwjJTADdLTV0dP5aAUkqZAo=;
 b=ZTOvdNCmvuAjromUobIrxFZMBEDFECK5VVEBS3caGiMCr4GflvnszNlmW3GrTGex7K
 gPNDWIVYGAUQVw1aBPaXPPLqWGamDsWlhLrhYvPoXacX10IxYXjl2nG3W4YHVp7WcRhz
 VFf+6wEKCpcKmq5jxGQsj16l5ZDJfG2C7aAM57eN4NJ4b7vn5NJlx7RYa1g7CA1GT3lb
 K/uqVIs9apbGALr+BOcoCSzJmrK1wXN0ibRz5RBqmimtu3w8ak7uND7cx+hdFxS90MPG
 Nb1eC6pfqmv7XlaF2rzTldPs5HQZg4ZYmmPyRRBRqDzboCz8hV27xnfL68HQ2m/gsxPT
 fStQ==
X-Gm-Message-State: AOJu0YxxNPQ/QdD3Yb0gvVPXB1YezN75y8XrsvI4iWl8fzcjoAjsecK9
 EX+9x+Cet1CXzF6aIKjOuszB41R8NohDl6olxKUxla1MzZ1VFE8V6V287631kHI7x8W6nqz6WWH
 +YG/h9r5R0eyLEeNndl93ft1hSl2b0fjYAJfN8YE1dObZ5I60y8VYV5txkE+Bpl7RknDYNHds0f
 2n4ohiFNRe2uDSC2fGRCfOj/EJH89Ya+r3z6fI
X-Received: by 2002:ac2:5588:0:b0:52b:9d65:afc2 with SMTP id
 2adb3069b0e04-52bb9fc5e49mr3478345e87.48.1717835707002; 
 Sat, 08 Jun 2024 01:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfvHvZxPboAc6fO9/9MGHjOc/6cAS8N4vsfkaOKetpVEQVeoYtiEaRMPVLsu/IZ1Jgz0e6Bg==
X-Received: by 2002:ac2:5588:0:b0:52b:9d65:afc2 with SMTP id
 2adb3069b0e04-52bb9fc5e49mr3478337e87.48.1717835706680; 
 Sat, 08 Jun 2024 01:35:06 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef4581827sm146920366b.215.2024.06.08.01.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 18/42] osdep: Make qemu_madvise() to set errno in all cases
Date: Sat,  8 Jun 2024 10:33:51 +0200
Message-ID: <20240608083415.2769160-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Michal Privoznik <mprivozn@redhat.com>

The unspoken premise of qemu_madvise() is that errno is set on
error. And it is mostly the case except for posix_madvise() which
is documented to return either zero (on success) or a positive
error number. This means, we must set errno ourselves. And while
at it, make the function return a negative value on error, just
like other error paths do.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <af17113e7c1f2cc909ffd36d23f5a411b63b8764.1717584048.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/osdep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index e996c4744af..e42f4e8121d 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -57,7 +57,12 @@ int qemu_madvise(void *addr, size_t len, int advice)
 #if defined(CONFIG_MADVISE)
     return madvise(addr, len, advice);
 #elif defined(CONFIG_POSIX_MADVISE)
-    return posix_madvise(addr, len, advice);
+    int rc = posix_madvise(addr, len, advice);
+    if (rc) {
+        errno = rc;
+        return -1;
+    }
+    return 0;
 #else
     errno = EINVAL;
     return -1;
-- 
2.45.1


