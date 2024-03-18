Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfR-00005t-VU; Mon, 18 Mar 2024 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfJ-00085L-74
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfH-0004lg-5v
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PquRgok1zJPddWo+hTweh0skOewFWtqO+jh37rKiqc=;
 b=YrhbaJjDf2cl4f6ZccV5BaQ9W/EXxtHfoZvWS2B3Zlpc95pK/VXY7Nkbr0r1zRsY+CmsOp
 TeRUzTPSb0FDomXQeukpXBwDCD3mfR3c4XADHVzmGL0C4f62zbHARc+oj7emUDav8mzbWg
 fMLOZXrzNDADsywk7qGINHU6PBJv4qA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-s6eihdbTOjitqOEeH2D97Q-1; Mon, 18 Mar 2024 12:16:40 -0400
X-MC-Unique: s6eihdbTOjitqOEeH2D97Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41413823c1bso3959425e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778599; x=1711383399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PquRgok1zJPddWo+hTweh0skOewFWtqO+jh37rKiqc=;
 b=dt9GqFo4G5BmXKbWLa8W8Kvv0pVzofwpw+ed7EswzGwWF1RcgSCghVDccyvk9i8ONz
 kqjh/tznCvrJeLB2y8VubDvICxXk1B9LNSU2WvcZ+wvnG17BuU823ppLQghOdTjyU44q
 /+i6oSm9gYy4jv4jql5gUJl8oEl2BGn6UHrISfDPkx4kDfVPNPExM0yoxPDZG6oCZkXN
 0Q660jjfrpOgsfUi8fDeayHh7+QbZE3YMQNgSyISP8G2N38G1AW75WlK+rLwirTzHF4F
 yeX9u5s9SgvCEHnr8CeAWLYb36vDsA5dFy/ZX2rOAeWWTuSCAg3yDJfJjmbAgDIBPVVt
 XSJw==
X-Gm-Message-State: AOJu0YyY+3Hjs8T8OzrXVJ+MBky0ZO6yMm/4ZKasaQAIeNdsGm/h+UML
 Xw8pj98/vNltCCQYX+0wPv/9VaQUCrtOHHLmFW3nL3DLI/h/x9s/hyUu25k23VlGtz3wJXepzlh
 2wFA3/Soa8qGOzQiej3MHcofG4WtRtdL9yxijhngDQWJPo+Jgg4EHBFOuwRRZZbVst1Cov58CSb
 6ggCAiHLuIzFM9XDr4dK79v8c5ZjeY5w==
X-Received: by 2002:a05:600c:4f04:b0:412:e0f7:ef52 with SMTP id
 l4-20020a05600c4f0400b00412e0f7ef52mr57448wmq.19.1710778599271; 
 Mon, 18 Mar 2024 09:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3ORGzjXCzfKbfbFOBylAYK6/00IVbsyv1+VlkO7ECWTb6uBUCjoOkRbmYJYJ/DAoUZqzYMQ==
X-Received: by 2002:a05:600c:4f04:b0:412:e0f7:ef52 with SMTP id
 l4-20020a05600c4f0400b00412e0f7ef52mr57409wmq.19.1710778598704; 
 Mon, 18 Mar 2024 09:16:38 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 bt3-20020a056000080300b0033f20497d4asm5965569wrb.5.2024.03.18.09.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:38 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 18/24] smbios: extend smbios-entry-point-type with 'auto' value
Message-ID: <4901b80e13be62fc8ea2d8844941f336076af266.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

From: Igor Mammedov <imammedo@redhat.com>

later patches will use it to pick SMBIOS version at runtime
depending on configuration.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-16-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/machine.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index bb5a178909..0840c91e70 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1797,10 +1797,13 @@
 #
 # @64: SMBIOS version 3.0 (64-bit) Entry Point
 #
+# @auto: Either 2.x or 3.x SMBIOS version, 2.x if configuration can be
+#     described by it and 3.x otherwise (since: 9.0)
+#
 # Since: 7.0
 ##
 { 'enum': 'SmbiosEntryPointType',
-  'data': [ '32', '64' ] }
+  'data': [ '32', '64', 'auto' ] }
 
 ##
 # @MemorySizeConfiguration:
-- 
MST


