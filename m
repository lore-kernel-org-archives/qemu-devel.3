Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C48E64007
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECl4-0006Rq-Dg; Thu, 21 Nov 2024 14:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl1-0006Q7-Dg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkz-0002Y3-UM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuGehJbgv141qLUXVKsNXVVCCq2wAofdQ+Smc8OM5Tc=;
 b=NWNZGsdO21QRXN6eTWVrznTTVvSTfwLZjWeEj7Ak9UiHdGKwUMHfTIydU85KpYmwiENvun
 8ExUNCe4YLtMA5D7K0UgFqwhJIOdKBT9CcPRDEbxOEBidAheahIqHbMc159lW9z4eUyrn4
 R8NbfFX8/7Xlmg/Zopj/XUxSgZpW53Q=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-STuK16_OMeuexs0eqo49ag-1; Thu, 21 Nov 2024 14:22:21 -0500
X-MC-Unique: STuK16_OMeuexs0eqo49ag-1
X-Mimecast-MFC-AGG-ID: STuK16_OMeuexs0eqo49ag
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ac354a75fso136820539f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216940; x=1732821740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EuGehJbgv141qLUXVKsNXVVCCq2wAofdQ+Smc8OM5Tc=;
 b=ezlCfj7xGReSXIXAZkrfwjB6JCstv6JdTMeryNr7UwoaL1TCQs8BRCKDmabG2kmbKB
 YCr0eASjitxhlx8+lnixTbFCPiHR2jdlxOAizMuOY2P3Wbr7pzF+a4FtgPlNozXyFUyi
 PJ6NyD58sRrSBtZUEhxC8ECpblolD9fyh3gI9oyeoy2VZ9aXlP+ICcWqj9RBfQNPDoVV
 hcl+IOERob6ylgad15ptoDJOYTnn3VXeFSCuI5D4lrIJOB8u5HXOhUt12VsyVX1SVxL7
 h30QQfWF3P2Vyfr6+2P5kZplAFDYoi/73T4CXVJ83uDMGcOtecA+nMbuMTsWVeLM7Dq2
 g58w==
X-Gm-Message-State: AOJu0Ywpv4uW+6e4snVog0zC2I0IwTXki2rC9+AXpM1zWGLP6Q9+TYTG
 Lk9XMZLuqPGKLPCU2ccaZJ2qt3zfKVFXayleT2O/UnOH96oaR1N2t0iUkAIDw86ZEmANKDa3Ysz
 4FnSUnRBGS9sPFFpVFb6+ETyG9jLjJPz4m5W4cWpLH03bOQ+zqAwjTyYd9Kh5p0252HOMUZJI2w
 FISLCoenPHOKvtISEKNqhEdTHUvrh0z92tgw==
X-Gm-Gg: ASbGncvpOV4MF2TaI7Dq1PTPo1iyniw7mv1TSYwALZqHRbtgNjW9BsoWavo6Cn1DwTM
 otQYJ9c0OfXL5udcpyp+xUfaW4/t3z9M/8UuFHU4oAWXI16KNnzSurGwKsqXIWFKfYh/9TNOPmc
 +uuumdFCfqtmZQs+wIJQTXMWsImpe8owimpVVCerwQLjt6r59/y5sbvTDmJu6ekC5b1yfh5lCkF
 kQOssBBfae/virO8UggK3e7G5RPQldRDc5q28eyscLdd3p/f7p0ruz/oFnABCrx50upv24gYW8l
 DpgPwvDroP7NqBZJ2RfAplidZA==
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr13102439f.5.1732216940256; 
 Thu, 21 Nov 2024 11:22:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWO7+68ekArDszaWSulrWY2ZxtmZ3Hlm0inaZJbNq63vsipazd5paMUDLaMzCUeV65K9Ze4w==
X-Received: by 2002:a05:6602:29d4:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-83ecdc611d1mr13095939f.5.1732216939493; 
 Thu, 21 Nov 2024 11:22:19 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 09/13] qdev: Add machine_get_container()
Date: Thu, 21 Nov 2024 14:21:58 -0500
Message-ID: <20241121192202.4155849-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Add a helper to fetch machine containers.  Add some sanity check around.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/qdev-core.h | 10 ++++++++++
 hw/core/qdev.c         | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412..dc6cd951fa 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -996,6 +996,16 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * machine_get_container:
+ * @name: The name of container to lookup
+ *
+ * Get a container of the machine (QOM path "/machine/NAME").
+ *
+ * Returns: the machine container object.
+ */
+Object *machine_get_container(const char *name);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b622be15ee..fa3bc85d9a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -828,6 +828,17 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *machine_get_container(const char *name)
+{
+    Object *container, *machine;
+
+    machine = qdev_get_machine();
+    container = object_resolve_path_component(machine, name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 char *qdev_get_human_name(DeviceState *dev)
 {
     g_assert(dev != NULL);
-- 
2.45.0


