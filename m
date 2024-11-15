Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD71ED68BCB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBynj-0004Eq-No; Fri, 15 Nov 2024 11:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35HA3ZwYKCuMWTVZJMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--roqueh.bounces.google.com>)
 id 1tBynX-0004C4-GF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:52 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35HA3ZwYKCuMWTVZJMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--roqueh.bounces.google.com>)
 id 1tBynV-000437-U3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:51 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ee3fc1090cso27005017b3.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731686628; x=1732291428; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HYD6Oh0snMVDE5n3YbBrC3LNYted9IIM3hf4WZIwNL0=;
 b=zohZPZKnNTrQAHnADcLT4Gwtuika1F0DtHV40zSXw2qhTHwYQd6p4Ivr4Dd69kWgG6
 vpU/aRTahD1jcwg9hstK5QQU10RkphuB+IOdBNfb0+pvC/QGzqu6ebjBTSMxBkpZ2FtD
 LxHvGvUwqYZVbDL2jGbgWW5yynaF/gQoaBMivVGd6ZubWN4R6yadBq3q83lX63sasa4T
 hUSpAGY6FW7qTWqghTlcf6zAN/IVnfbxdMV1QrNbks3bo89EQwPPsDWc1WWNnOagLOts
 rupNCbsj3J3sXvyb+IqPwPlwx9oSzQK3QuFUYodaDsZrRmZDz6+KOq/GNIaJjWQ3IhXm
 P8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686628; x=1732291428;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HYD6Oh0snMVDE5n3YbBrC3LNYted9IIM3hf4WZIwNL0=;
 b=YHpK/pQ3WSMS+kIvflAFb1aLF3dA/yNndkft87GI4y2XoqEQQg+AeQIhnQwxRYeYFV
 fWtsBSoFyg0hGwV/BR0NJnHZ3R9B5Plj2PZM3YlKV9GWj/Ccems7P0Tedq2Q10B99buR
 TTCyxcXbXivRHEsB1F/08UvhIrJghVA+8CYgymFT//ek+dXbiu4czU+nvf/mf/UQNsF3
 1GD4fM5xVncqR6gSy6rdvI0RaMsgKAh8uznm+1M3ryecbFBRpfpM7RhAv46FcpNw6M+0
 OAMjCOqq9Zw5uklpZj31Vzmev5BQ1sIOwKIpkhQ+CqXB4H9AAcDQ7Lebm/bIB2E7eIAR
 iPXg==
X-Gm-Message-State: AOJu0Yxe6xTAtpmLn8eS7l1dK5fHlAZZlK83nm0WDPnaaPIznVePLyyi
 XYvJPs/jm/+6+DX7cPW1q+6ebai0ClF/xHfeMf2s4GNsu90NWjsFo3TaZasm54d9bBmeMg7VKcC
 vTQ==
X-Google-Smtp-Source: AGHT+IFtjkCgsR2+WT9YlhmXa7Cs/SRJlB4vLF2ZYynZQTd40HXQBwwNZYH4gis+tkLpM6dKdOt3xZ0ePBA=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a05:690c:9003:b0:6ee:3f39:493e
 with SMTP id
 00721157ae682-6ee3f394c55mr592627b3.5.1731686628131; Fri, 15 Nov 2024
 08:03:48 -0800 (PST)
Date: Fri, 15 Nov 2024 16:03:27 +0000
In-Reply-To: <20241115160328.1650269-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115160328.1650269-5-roqueh@google.com>
Subject: [PATCH 4/5] tests/qtest/cmsdk-apb-watchdog-test: Don't abort on
 assertion failure
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=35HA3ZwYKCuMWTVZJMLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Currently the watchdog test has a behavior in which the first test
assertion that fails will make the test abort making it impossible to
see the result of other tests:

 # ERROR:../tests/qtest/cmsdk-apb-watchdog-test.c:87:test_watchdog:
 assertion failed ...
 Bail out!
 Aborted

Changing the behavior in order to let the test finish other tests and
report the ones that pass and fail:

 # ERROR:../tests/qtest/cmsdk-apb-watchdog-test.c:101:test_watchdog:
 assertion failed ...
 not ok 1 /arm/cmsdk-apb-watchdog/watchdog

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 tests/qtest/cmsdk-apb-watchdog-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index bdf6cfa256..fe535a553c 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -164,6 +164,7 @@ int main(int argc, char **argv)
     int r;
 
     g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
 
     if (qtest_has_machine(machine_info[MACHINE_LM3S811EVB].machine)) {
         qtest_add_data_func("/cmsdk-apb-watchdog/watchdog",
-- 
2.47.0.338.g60cca15819-goog


