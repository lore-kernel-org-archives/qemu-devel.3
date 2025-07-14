Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8234CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHKA-0004OL-Ar; Mon, 14 Jul 2025 07:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH01-0001CK-EN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzt-0001tq-J1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvpGOGtkXq9bzXlo3ev/yqxveN9qZSX3B7D9nwqE1Mo=;
 b=Wv9ygggiqO6kzvs35mv0YwVffHNFG2aQ+LU30VXpA5B1qoTd8TZ5zfkuk1xzymJF7O7xSC
 JZszJvNYfGzkNZWm9QWhzSNdant7iq4rHWLESeMjNwWyvwx1Xsk0izkenqyt5p/7k4lhR4
 Wr1jrWm/+gKyP6YGqAXBs07XPKAlGvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-4k2B5JDLOdqSpcRhxDd49Q-1; Mon, 14 Jul 2025 07:05:23 -0400
X-MC-Unique: 4k2B5JDLOdqSpcRhxDd49Q-1
X-Mimecast-MFC-AGG-ID: 4k2B5JDLOdqSpcRhxDd49Q_1752491122
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561a196f70so4834765e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491122; x=1753095922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvpGOGtkXq9bzXlo3ev/yqxveN9qZSX3B7D9nwqE1Mo=;
 b=kCSrTIu6aJiGv5PfvPVqyRhPFItMVUyM9o3rZOXshzvxkyOQTX0JoLA5akN6bUHLq2
 Z2ZXaGVJ+MvILDeQUqQj00Le9uuLFIey7ePqOgvzZvAslSpyJFFhYAfF81QsMjcqHiot
 aNMWXaWfYSEpTCCVxNeHFimNm/8NnR+uaf0FqE0nGjPFtGeBYU3xiM2b3ItLtzvYyenh
 myFvN72k315kDABwPQ/fNxDNurVD7vfQSC1ubaxjOZdIdFDh9RnaDj4qfbdEPgz6z8yN
 QaTKiJaV2aazsyjl38tJRuuGgsarkSI9sl8iu5lPq6z/rmOfcgzrg46q3QSN7DrL85Kg
 85JQ==
X-Gm-Message-State: AOJu0YwaEueWnfHOWUPpERNW32UoIM26LHR9WqPKIOFa81KY7JiFXSuO
 w+CJ8xPaOPJbiszZRiF6G2B6CYU4PduHkmpljz2dm9rzjKHt5UsUC0OWh/uvf2HPyzCsIhxy4TB
 YEs6RoGlxvAE6hg+av2e6kgyPd3NHFXG19O367OHZot9X41mxGK1+nAJj8ca5eXOVeSK0Y4BLeU
 6VBE2G+FPkSaCB7vgI/Hd+hQpJ4W7GtRoAPeljSgzI
X-Gm-Gg: ASbGncuhiX3HEpNlRAOThwBnuMjhcRIf7SRvdeQD+arhq7eaFley6hoDYx9ecZu3z/o
 iRT+9SA6+YQUlUc4LZ58Mc4A0f+N+Fkr4krg4vpKY9VVw8+UGLtBoSc70VEFban1aonjgyIw++O
 xMYLWLAtQV/TJfXaUt0hdW+SeZYSwS01CQxz1xAM+K470JD3/5EsZNykf6oYc/En0VUYYPhT+qa
 1NbIgw9DViK2DURrjefyvtaCoxMAsBcFvZ6XpoZJMlP25XnCDoxnahVBRzPfpH5yncxIjHvgAVQ
 P+0PgSVnIFqz5Zt/OrgA5+fsbddtOEHfFSU8qcUnmoE=
X-Received: by 2002:a05:600c:c0c1:b0:453:84a:8cf1 with SMTP id
 5b1f17b1804b1-45576aab8a3mr76216015e9.33.1752491121764; 
 Mon, 14 Jul 2025 04:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4QgZIKE5BhZ6dypBvpcgrGukwpCV43ru3hLDguuRVQEgHUnwQkNvXnfqHMlDXL/jInNndow==
X-Received: by 2002:a05:600c:c0c1:b0:453:84a:8cf1 with SMTP id
 5b1f17b1804b1-45576aab8a3mr76215665e9.33.1752491120958; 
 Mon, 14 Jul 2025 04:05:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d867sm12295222f8f.61.2025.07.14.04.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 27/77] docs/interop/firmware.json: Add igvm to FirmwareDevice
Date: Mon, 14 Jul 2025 13:03:16 +0200
Message-ID: <20250714110406.117772-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

Create an enum entry within FirmwareDevice for 'igvm' to describe that
an IGVM file can be used to map firmware into memory as an alternative
to pre-existing firmware devices.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/2eca2611d372facbffa65ee8244cf2d321eb9d17.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/interop/firmware.json | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 745d21d8223..0711b6f323d 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -57,10 +57,17 @@
 #
 # @memory: The firmware is to be mapped into memory.
 #
+# @igvm: The firmware is defined by a file conforming to the IGVM
+#        specification and mapped into memory according to directives
+#        defined in the file. This is similar to @memory but may
+#        include additional processing defined by the IGVM file
+#        including initial CPU state or population of metadata into
+#        the guest address space. Since: 10.1
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareDevice',
-  'data' : [ 'flash', 'kernel', 'memory' ] }
+  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
 
 ##
 # @FirmwareArchitecture:
@@ -377,6 +384,24 @@
 { 'struct' : 'FirmwareMappingMemory',
   'data'   : { 'filename' : 'str' } }
 
+##
+# @FirmwareMappingIgvm:
+#
+# Describes loading and mapping properties for the firmware executable,
+# when @FirmwareDevice is @igvm.
+#
+# @filename: Identifies the IGVM file containing the firmware executable
+#            along with other information used to configure the initial
+#            state of the guest. The IGVM file may be shared by multiple
+#            virtual machine definitions. This corresponds to creating
+#            an object on the command line with "-object igvm-cfg,
+#            file=@filename".
+#
+# Since: 10.1
+##
+{ 'struct' : 'FirmwareMappingIgvm',
+  'data'   : { 'filename' : 'str' } }
+
 ##
 # @FirmwareMapping:
 #
@@ -393,7 +418,8 @@
   'discriminator' : 'device',
   'data'          : { 'flash'  : 'FirmwareMappingFlash',
                       'kernel' : 'FirmwareMappingKernel',
-                      'memory' : 'FirmwareMappingMemory' } }
+                      'memory' : 'FirmwareMappingMemory',
+                      'igvm'   : 'FirmwareMappingIgvm' } }
 
 ##
 # @Firmware:
-- 
2.50.0


