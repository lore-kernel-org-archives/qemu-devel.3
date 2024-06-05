Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A756C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErOk-0001Yo-AO; Wed, 05 Jun 2024 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sErOh-0001Xw-Ic
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sErOg-0004jZ-6R
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717596829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXFOuCjO7G5UCkIFsgitrynWMfaFo4WfMng6DJRMxN4=;
 b=SPSyVF5RsiRlCPanxlLLiSEvGajF6kYya7bqmBvGF+Zv0zb8SBnSd2wNOfphFE8o4v8Wjy
 1Vsp9D2UBQsuHoxJhxj2s8FTG8fAugSCfCn7RQDSZVLoopC5AAzV7yCf6ktICnwFGjBXM7
 iHZow8J2KSUGgDwPUqzyYA9bfkqnjr4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Pa9c_Y61MZ6zNJ4nTJ3ChA-1; Wed, 05 Jun 2024 10:13:47 -0400
X-MC-Unique: Pa9c_Y61MZ6zNJ4nTJ3ChA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1f682664703so23081545ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596826; x=1718201626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXFOuCjO7G5UCkIFsgitrynWMfaFo4WfMng6DJRMxN4=;
 b=POCCzvaXMPpmGB1S3+WFNrdQjCy3OINYXhEsfJHns6QQ/hd2RxfS5v/mUQgZUzkfad
 llIcl+fVf1/mljHk0UHAPOxCUzPyjM7+Vpzy/7IH3exb7ws+4O0zc2AmexTjE9rjslU4
 iUUdmjd2j2j9yJ3xRRYr0t5Ail96tRqViGRJGX8dqaAkdsOqkdg3Js9gY05G5wyjAAYb
 GWd3goXjJfa5ozjj6l6+aKfqGV0giVuU9wgIRcAbDRwIn9aaW4rXyd39qztZGyH33BPh
 UWJwPIi5f3ML4WSyE5DqiFPojbKKX+lKMOrWUUZQce0PYVbGwDZFNbRoqm3v3lCR/JOR
 1xVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtEw4aPytHt2tspxEiu0A+gcX1DavDd8PaTqKRSnFFZYNBeCah3iYtelrnU7NTXKn82s7A7WFyHSDoPSHyqPMywWwdWX8=
X-Gm-Message-State: AOJu0YwzSQ11NhzqOsFshIrBbo4B8NNf4yF6syu342Dt9TRc3oHvZI2L
 Cm7/ufa/ofsRlPtpIebtkqKre39siVm7TucAEhChvS2UTaeG1BnLYSdGAtQI2UFQsjM1H7DC7Qw
 tlr/IpBYcCZ6UOh1AdGZao4Yv2xN8IXuiFnjKLsHMbJJYD6Ry4vTV
X-Received: by 2002:a17:902:e810:b0:1e3:dfdc:6972 with SMTP id
 d9443c01a7336-1f6a5a042damr30849465ad.9.1717596826529; 
 Wed, 05 Jun 2024 07:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8efO6sn1nPpF1bJYIAFV/UHO4uMlYwW9ExMwEK0Wbou/RrKGGr+d9gyYKWPGYebOoJw5emQ==
X-Received: by 2002:a17:902:e810:b0:1e3:dfdc:6972 with SMTP id
 d9443c01a7336-1f6a5a042damr30849165ad.9.1717596826092; 
 Wed, 05 Jun 2024 07:13:46 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6323ddac9sm105225665ad.173.2024.06.05.07.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:13:45 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] qtest/x86/numa-test: do not use the obsolete 'pentium'
 cpu
Date: Wed,  5 Jun 2024 19:43:14 +0530
Message-ID: <20240605141316.91955-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240605141316.91955-1-anisinha@redhat.com>
References: <20240605141316.91955-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

'pentium' cpu is old and obsolete and should be avoided for running tests if
its not strictly needed. Use 'max' cpu instead for generic non-cpu specific
numa test.

CC: thuth@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/numa-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

changelog:
v2: added reviewed tag
v3: added reviewed tag

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 7aa262dbb9..f01f19592d 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -125,7 +125,8 @@ static void pc_numa_cpu(const void *data)
     QTestState *qts;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-cpu pentium -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
+    cli = make_cli(data,
+        "-cpu max -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
         "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
-- 
2.42.0


