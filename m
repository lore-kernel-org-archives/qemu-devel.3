Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FA2CD11DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNZ-0007bL-Be; Fri, 22 Mar 2024 14:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNW-0007ED-Dv
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNU-00075m-PG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oCRmigRwyKccyqZzlqOB3pVXpr4vlDHuJMd2fJ2F+E=;
 b=WBzZWrvxXGVhQh67R+5IyOqB/KLEGhOGnqShPc41TyPtI5FZLknrDg6AZEazY69CHX9lh6
 yFRovj+th+flS5f4KftAYKjDmSk7+avCUVnzGcsSyTq+AxqjZYJleyMYvxxE2y0Z1kDP3g
 V/jZlbiJD5axEAZHyxyfII8pO7C/p48=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-61muHn6fN1G5qP9xKjp3zA-1; Fri, 22 Mar 2024 14:12:26 -0400
X-MC-Unique: 61muHn6fN1G5qP9xKjp3zA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a45acc7f191so131378766b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131144; x=1711735944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oCRmigRwyKccyqZzlqOB3pVXpr4vlDHuJMd2fJ2F+E=;
 b=cbW/4oYT/b55g9WGg4AZAl9y9hM+VNP6YdxB/UtvU01Cyppoc5kgcHu7FCKHbRjHFK
 HCXZDceWp+udqjdJMWEb/83bOUwwZ+QGIBGNr/zwSL+adn7Km2f8C2wyXZ5a0iwjNfBx
 B/D32BBVPRzAwmO8q3u4tDZ+Hj7j0snrcM7gGODNp1otHjR8B4r/JMU3LOdErDldXZMi
 nYt5XXGoxHmc6b4y6Wbid6s4qSG/6UGXNJ1Jce5lrxQJjR6NWTSAfnqUrHDBb/qio1Vt
 xqMigXpVxENTIBnCOPgvBElmgS+R6OOOxf8dUbCvX1yj56VKa9ylTDiRaT4mGLkD3Ocx
 PWwA==
X-Gm-Message-State: AOJu0Yx1n9q69w7ePerEp25JntKb2c0Bbca+1aynAZohJU81z+IHN1fn
 8TkWBE878RUWb9Rpl5g8deqdEj8NgCaC5HOyMoM1Oi7439i3+tZ2HuJj25JBP2L/A1Egd5A22xF
 YASH9DmsaY2Upp/tR3uDzkZnVwcGCAxATsbCxbh6+2QqnxT9Ku41G4ujIPrI4GGsc6FWE9YlNol
 givGzTvv7ifgM6WqNIfin3c4xod3xYvlOvK/gH
X-Received: by 2002:a17:906:4a56:b0:a47:3951:ce96 with SMTP id
 a22-20020a1709064a5600b00a473951ce96mr435272ejv.4.1711131144267; 
 Fri, 22 Mar 2024 11:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDnWhUxmxCmbz28kqksHLWzbN/Uvb+oWsgGXmHuMlsFS8RzAzeRppb9wpI31TAqRc9LaBlUA==
X-Received: by 2002:a17:906:4a56:b0:a47:3951:ce96 with SMTP id
 a22-20020a1709064a5600b00a473951ce96mr435260ejv.4.1711131143954; 
 Fri, 22 Mar 2024 11:12:23 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 bw26-20020a170906c1da00b00a4650ec48d0sm72519ejb.140.2024.03.22.11.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 21/26] kvm/memory: Make memory type private by default if it
 has guest memfd backend
Date: Fri, 22 Mar 2024 19:11:11 +0100
Message-ID: <20240322181116.1228416-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

KVM side leaves the memory to shared by default, while may incur the
overhead of paging conversion on the first visit of each page. Because
the expectation is that page is likely to private for the VMs that
require private memory (has guest memfd).

Explicitly set the memory to private when memory region has valid
guest memfd backend.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240320083945.991426-16-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7fbaf31cbaf..56b17cbd8aa 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1430,6 +1430,16 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                     strerror(-err));
             abort();
         }
+
+        if (memory_region_has_guest_memfd(mr)) {
+            err = kvm_set_memory_attributes_private(start_addr, slot_size);
+            if (err) {
+                error_report("%s: failed to set memory attribute private: %s\n",
+                             __func__, strerror(-err));
+                exit(1);
+            }
+        }
+
         start_addr += slot_size;
         ram_start_offset += slot_size;
         ram += slot_size;
-- 
2.44.0


