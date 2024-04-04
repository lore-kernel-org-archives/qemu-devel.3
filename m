Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4708FCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8v-0001Ay-6q; Thu, 04 Apr 2024 08:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8t-00011i-CE
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8r-00015D-Uv
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2fIVWILzKzQaFbqxYLTu1zrjB/5hVEGYyQqHDi9HUo=;
 b=Hs0epVWuxTrwPMpj0FYTDafgzuhO2RiDBKdhD6v+M1M4zzbWiOayvJQ+ch0TpATve7nQaR
 GVlaf4DorBAsSgd6skUlwxv9pPlqFIrLhcw0OEhwA+MyaGhNN7nANGPSHv98KR6oQfpEkH
 By39jpufb6D2jck3NWkNPkopuR9/QuE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-yjjNMoecNDqa8qDdz6028g-1; Thu, 04 Apr 2024 08:24:28 -0400
X-MC-Unique: yjjNMoecNDqa8qDdz6028g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4747f29e19so40095066b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233466; x=1712838266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2fIVWILzKzQaFbqxYLTu1zrjB/5hVEGYyQqHDi9HUo=;
 b=dUZ9fvUMbV6pMq75jAS2AoIvB62wQfIsVtAL2T64yJREGTf9lTIVQAKdBKq3GhyqAm
 8LBT//mBdRRed8SwgpPeNp69Fwv8KCBrP2BjoAo/UfRNomilnxxyn++wmtJtXetZ6dHF
 Guo9+N/738DoxAMRmUrH6yKDlVA7EvJor1euEzvb0t7pVe1hhKxP3XLw2LBUZZq02COb
 MeEBNlv2Vl0hs4SI0BN/RnpePA8kyEnPMeoKjHoIL9wPTFvxvvHwvippH/uMuqOAJcbm
 VTlzqAi8PkNSfpLoYgmyRxZaK4qsUfIuBet9M26f/rbQuftqSy2wyUE0XX4fDwT8pUpN
 H2Cg==
X-Gm-Message-State: AOJu0Yx79+4P3bLAxxks0ayCkMAi43JHDvi3JHPRTfQhDNfgvCape7w4
 ShNDTjqY9ew8ufMonEcrPl4lEJIUm/U2z4Vtz2jQd4IgXobtJWJ4zqrNAeuKklbghVjtjTBbgVN
 pguTGtIhtHEMorqWvpp0Mi34sG1W8Clnt4rCg7+gOyBUD84YDE57uCYc7JQecw7Oom02WJXmZ/G
 TTRBxT4d4dQXX8nevwJuZck70JeDmnJuduf3wu
X-Received: by 2002:a17:906:ad88:b0:a46:be3d:1ed8 with SMTP id
 la8-20020a170906ad8800b00a46be3d1ed8mr1548527ejb.54.1712233466521; 
 Thu, 04 Apr 2024 05:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPDbYYtYutONj3xlYGfi4w0M5oZBHPpxKBz3NDyMUpKM7tjlT2megPDbztsFyxHOS2hezpsQ==
X-Received: by 2002:a17:906:ad88:b0:a46:be3d:1ed8 with SMTP id
 la8-20020a170906ad8800b00a46be3d1ed8mr1548491ejb.54.1712233466202; 
 Thu, 04 Apr 2024 05:24:26 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906128300b00a4e2bf2f743sm8248392ejb.184.2024.04.04.05.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:25 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 10/11] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Thu,  4 Apr 2024 14:23:29 +0200
Message-ID: <20240404122330.92710-11-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
2.44.0


