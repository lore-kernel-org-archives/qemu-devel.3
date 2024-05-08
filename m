Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13029C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c0h-0004v0-KJ; Wed, 08 May 2024 03:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4c0M-0004XX-LI
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4c0I-0001FP-RM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAiSzzjOveYimzBp5y2bZ/4qPL62nC5N/ynRpoSPmwU=;
 b=Bsr+siGCFzeGTYmUJhMIneIfX0runPGjiM/OMXjIPaRokZRPSgxWNOk7yRmZPHNUPtokeh
 tSRGPwvteHCvfMcywTHjDK6iAzNfvKP5dpXYT6+byRZNfHoEEOccf17NfjVF/0rDbH7eD1
 lt+lQe7DKCkhGBdDXkmSBnyNUs/U8ts=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Z4AAhblfOz28vz4C358WEQ-1; Wed, 08 May 2024 03:46:16 -0400
X-MC-Unique: Z4AAhblfOz28vz4C358WEQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a599b55056bso228896166b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154374; x=1715759174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAiSzzjOveYimzBp5y2bZ/4qPL62nC5N/ynRpoSPmwU=;
 b=CVQ2Qx6UgaN5Ivpueiz3FKGA1kcm2UJntIakPKSo3DxjLA9O651kg8BaPcoMTOvODv
 c93D4SXNVdwq2a+pNMwtYqPutLbGst2aeGdGhy+7eRGlOlpiD/afhJsBOt2hRQrqe682
 2Fdj0DTc/0vKG0fd5aZrTFQSLjKkUeLPkQ2zIeKcD1b2jpx9IQfLMJjSY0KVICvu1yMt
 GKGEtQNBcPentUBK9RG8K1iSL30glH2zLxDc6Hl2LXwj5oPx9OvskxR/1z8S/qyXBV+a
 TRjt1YlDzOx09qdSPw1itcEpkaLbjuYPoAJpgwt5EgRfOIJ/E0XZSOzQNcMrvw2Mb8yM
 FAIA==
X-Gm-Message-State: AOJu0YzwYRZRTENMjCqvl/9kKT1orBzHVPx8fUlvxRHy7jmEEkONIW0X
 WYlb1g/kJDGYUjyW6T9BBCOAjP+M15n2OXw0hH4lHUlEWuCQAFqKXUT0FZ+ImrB/sHtauq/cE/B
 x1o7N5AVn2/VcjuTSn2z1rpxa1NQocCiH6cuGAjBISbS4rJfYSj7P+fWF+ihYJcFScjUxp/T03k
 1B+T71qPBH0YvKPNvmn/f8cr824AC3Be7/ywZg
X-Received: by 2002:a17:906:e2c1:b0:a59:b730:59d7 with SMTP id
 a640c23a62f3a-a59fb94b7d0mr105984766b.25.1715154373844; 
 Wed, 08 May 2024 00:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmngoyj+GfqYTNwBA2bNoe0AiZ/8XfiJm6Y9bTQSzlPG3avE6Vy66Uym5vEfMbG7PwqkTWww==
X-Received: by 2002:a17:906:e2c1:b0:a59:b730:59d7 with SMTP id
 a640c23a62f3a-a59fb94b7d0mr105981666b.25.1715154373503; 
 Wed, 08 May 2024 00:46:13 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 xh9-20020a170906da8900b00a597ff2fc0dsm6730359ejb.69.2024.05.08.00.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:46:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 11/12] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Wed,  8 May 2024 09:44:55 +0200
Message-ID: <20240508074457.12367-12-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

`memory-backend-memfd` is available only on Linux while the new
`memory-backend-shm` can be used on any POSIX-compliant operating
system. Let's use it so we can run the test in multiple environments.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 117b9acd10..e945f6abf2 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -906,7 +906,7 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
                            vhost_user_blk_bin);
 
     g_string_append_printf(cmd_line,
-            " -object memory-backend-memfd,id=mem,size=256M,share=on "
+            " -object memory-backend-shm,id=mem,size=256M,share=on "
             " -M memory-backend=mem -m 256M ");
 
     for (i = 0; i < vus_instances; i++) {
-- 
2.45.0


