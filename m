Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7762E64006
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECku-0006N3-KQ; Thu, 21 Nov 2024 14:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECks-0006L7-5n
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkp-0002WT-1o
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXA6V54Db51w/r+lVndlovYUw8qq+lukW3/9OKGx92Y=;
 b=Xxj7ZgDQEuIHOL7hZcJAMSNBMT1lzUW4kMrU+3raBIcUStypqRL3HDPtezUqF8GZtDpxob
 RIL3XodkRcXoQVwKmRtoXsf+b/CLchJ6cMjp2RFRSo/kx3A8NUA43uRF53FPpjpvAaVeWy
 4Dgd4V1vkeVb/GcBuLnyu4pmLnU8pQE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-8YSHDf6WPzOtlfuOmanNzg-1; Thu, 21 Nov 2024 14:22:12 -0500
X-MC-Unique: 8YSHDf6WPzOtlfuOmanNzg-1
X-Mimecast-MFC-AGG-ID: 8YSHDf6WPzOtlfuOmanNzg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83aba93c01bso138019839f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216931; x=1732821731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXA6V54Db51w/r+lVndlovYUw8qq+lukW3/9OKGx92Y=;
 b=Yz/tDRi42JDtNu5E+TYkaUbheyIw7B+ABDGdJqoAj7RcbRmv0RPX8qHuCEx6J0yEZp
 81C2BzVQnJKeAaTg5xjwKA4V27IgBvBicaig808VVzx21y8+YqzwUuAeI4YUb+YTjLmR
 BVTSqGW3e/w4LQZVIwP0Ew65FP7zR9aALHLOJwUTcrVmr1uGre+JvX536uMNbPTMlhTO
 NiaW3rD1BKPp1U5BC0ISGkV+LkxV3I4rdSOJpmFh+Y27nZZOpYamTmf8re4ticZe1M+6
 xL52jWZdpk4wDlPqJ+Htz2pQ8DKlfGywK8Xau8Y6A9rs0Gdai3p2XGUXOUETfZ6bQzd+
 uFlA==
X-Gm-Message-State: AOJu0Yyv+0UV/MpmtNAz7GBGQT6GW2rvZ5aHvpeosA/EsOrIn/xBGPau
 L/KAnkNM6YuKhhg379xYsWLxqP6MYgmY9L4mpZxZrQDPuAn/njxdjC/KArga2LdLg3wkeiX5yrF
 g2FjgouCE4n+Jwh+76l1Hi23RlgrDpQ9HpV6fEgYi0TobUd1nmA+mZKufV5G2RE55z21qxJ9tGk
 q3NthjZtOozf6J0KhstbIYbmv2fWsv2XeqxA==
X-Gm-Gg: ASbGncuiFrvoU4t62fxsNRY2miAqZfxkKt2mSpiFUgX11FJSh0GQmG/bmcHhGGW7DgH
 bfN7KOoZ0JTWvlPE6OK6UrBK/YsTEWCxT3OfCBV5ZUzaclq1gxfB5bYnjaQt7oqEEzowCXO6Iv/
 SsKAUYsEtXx0VYTvNLMeoZyiSre0zmfoiWjZETHRaZVi0k1sx5g0A7gNRqppqM/MIyenqXFPYVZ
 TGKg79r1i3DpC3fGebUinmHnBdaSPBHY9Xitlwx3WacqOdSstrl1SxoI/QSaMCzrURsCeXCNExz
 1/mge71bp9s/ENGkvwJVQePetg==
X-Received: by 2002:a05:6602:1345:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-83ecdcf3ca6mr9246539f.10.1732216931476; 
 Thu, 21 Nov 2024 11:22:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGLuW7O6ZSc8vUMk82eQ+C2nbxh6XjT2Ifaiu9QDIvfAtvCwxQgglH/X3KVTBphwZZw7AuYQ==
X-Received: by 2002:a05:6602:1345:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-83ecdcf3ca6mr9243339f.10.1732216931104; 
 Thu, 21 Nov 2024 11:22:11 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:10 -0800 (PST)
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
Subject: [PATCH v2 04/13] tests: Explicitly create containers in
 test_qom_partial_path()
Date: Thu, 21 Nov 2024 14:21:53 -0500
Message-ID: <20241121192202.4155849-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Drop one use of container_get(), instead switch to the explicit function to
create a container.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/unit/check-qom-proplist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 79d4a8b89d..b48e890577 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -610,7 +610,7 @@ static void test_dummy_delchild(void)
 static void test_qom_partial_path(void)
 {
     Object *root  = object_get_objects_root();
-    Object *cont1 = container_get(root, "/cont1");
+    Object *cont1 = object_property_add_new_container(root, "cont1");
     Object *obj1  = object_new(TYPE_DUMMY);
     Object *obj2a = object_new(TYPE_DUMMY);
     Object *obj2b = object_new(TYPE_DUMMY);
-- 
2.45.0


