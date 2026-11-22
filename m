Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FC606A332
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdp1BB9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3WU-0001Xd-KI; Sun, 22 Nov 2026 04:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W8-0001WC-Av
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:48 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W6-0000ya-Rl
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:48 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c4d5b2db4bbso526485266b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795338345; x=1795943145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZlG5sNKBkvXvY9Mqh0mDtE4lKYoM32I/uSr5hNM8NDQ=;
 b=pdp1BB9vVRNXnS/XbVXOMzCjdjvJhiR7I7UBJL4rCXXbNwrxRf0DIeqFsABMb6qVOb
 IITMOW3CyUm9QTRg/RHYnobzaJIkmOmaKwUwAWg9JiWkeJyGz0PNYzkFffn4CBorXaBR
 7fsQrY7M27mjywMkoF30i0eeA6qxeoM+apwSoOagBYTcg5WWXHSaTy660g1TeT22zMHo
 yHCFak+0Or2eV2mV17yEB5YWINNaB4O3ZjC0vt0b5KXoLa9OZWvNhZQ3dCENRiLhXSjA
 I8ipcQEobiXoQpg8Z0P3jRxKhofEBc6mUYGm560OMNELO7iNsg3BzkVks3DxStw4Xynl
 Rw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795338345; x=1795943145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZlG5sNKBkvXvY9Mqh0mDtE4lKYoM32I/uSr5hNM8NDQ=;
 b=uETibEOcDiVZQY8rFxO756JpWhG4Y6gc7AeHTqOt1NsAozpa2fU8ZqPCHXKIRIyCUn
 u9St1JM5FNYGK7mL0tsCO9XceOnWrtQBX8HT9+qWhd20tqgQEXcsBOVB18P9siiIAkyj
 1Kf/YJHiuEvOUvxROQ+fWL/gjo4woo9t6CHcZtt4FFfcJ5rPA6ekAIjowX5R6C0FI2hu
 fLJ3atY4Wi9lhwv/88k2MaZC/ggUCLNSZoDqCR1jb5qNBjLClHnBWINyhdPHmyZkjVW4
 c0XVKThGp5xqFv5jgWM0Upzu2J5R9KQXwot4cqy7g/dGwpcSkh8vvxi0bgcBaoQDHidD
 Z+gw==
X-Gm-Message-State: APuU4Z9iOPhU2RLlsyEjx+NzvtHFSiWOIvFn1DIt2H8k4C1RHBT9buU8
 CGbP2lWiJlePjBpUGySaho0gygdItO+kK0tdKUDiJM6dIcCxBqHZujQ8dcy5+wBL
X-Gm-Gg: AZFdTZf7ROsTcFIgbHK9yezFfDkulbT1Q6ri9Ajo7diLO0gfSlQVAXh8Mkgg1o4FjX+
 N6ARoXdrvjCEVBhgWhjwJgHoRir6B2yr5VGqjkf1+xdHOAzAjm/g4B/ycmlMdKRm8/SGtrGOCWZ
 QZzZtzsl0KOUpnHZuN8++4GoE3Erz4Rq0EbbHaOVpThQvrcsCzAa/znoi4vJMPkoRgmdZtwK1v/
 LwYcjYdjeSmXL7BqD3zf4E7jrgxVZnz1Ca65qDF1ExktpUSjexKkTjRbxclsTXFWg7HE4/Z+d9s
 Kmf0EKB6g6wcWhq7OHR4XAN46gAF0cZv7ow9KyOfCyrUKDuUHrEU2HqlPO38KK5A99aCGqG2jm7
 tP5N6PlNOL4+i8A1+GFZYa1l0Toad3E99X324dGa3YiqlnZemoCbizNE+awYBCicfCo//6qwh9X
 4CX2vRp5juJlAQUz79xsMi+mJl1mxqfzArlNJgUgIAHtSqfsIc4enruYyD5GK8T8FLd0yV21V+C
 Wg6YP84UJtbSY6nHJkdK5kbrkPDjXo6nCCj3IyDDxW+u4tXmAy0g12XVyKS/Ef/vD8Dli6hFOdL
 kNd6l3KWSoetS7EbdKjudFIRNZG7srqpaFIWXX85KiFyM3JC1n+t1sZwI6EmCz0nIKtxzMFNALQ
 I5XMbCZS4H0iTeRD/HbF9sgASFQseqepGS325XnI=
X-Received: by 2002:a17:907:3d4e:b0:c4c:e91f:e1db with SMTP id
 a640c23a62f3a-c51319a7850mr830662266b.25.1795338344574; 
 Sun, 22 Nov 2026 01:05:44 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad010a6sm298893666b.7.2026.11.22.01.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:05:44 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 5/5] tests/unit/test-qga: test 'guest-get-cpustats'
Date: Sun, 22 Nov 2026 10:05:10 +0100
Message-ID: <20261122090511.15121-6-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122090511.15121-1-bogorodskiy@gmail.com>
References: <20261122090511.15121-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test for 'guest-get-cpustats'. As it works only
on Linux and FreeBSD, guard the test accordingly.

Validate that the result is not empty and all the required
fields are present.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/unit/test-qga.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index a8ef6b0e21..530bf97fd1 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -1119,6 +1119,38 @@ static void test_qga_get_disks(gconstpointer fix)
 }
 #endif
 
+static void test_qga_get_cpustats(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    g_autoptr(QDict) ret = NULL;
+    QList *list;
+    const QListEntry *entry;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-cpustats'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    list = qdict_get_qlist(ret, "return");
+    g_assert(!qlist_empty(list));
+    QLIST_FOREACH_ENTRY(list, entry) {
+        QDict *qdict;
+
+        qdict = qobject_to(QDict, entry->value);
+        g_assert(qdict);
+#if defined(CONFIG_LINUX)
+        g_assert_cmpstr(qdict_get_str(qdict, "type"), ==, "linux");
+#else
+        g_assert_cmpstr(qdict_get_str(qdict, "type"), ==, "bsd");
+        g_assert(qdict_haskey(qdict, "irq"));
+#endif
+        g_assert(qdict_haskey(qdict, "cpu"));
+        g_assert(qdict_haskey(qdict, "user"));
+        g_assert(qdict_haskey(qdict, "nice"));
+        g_assert(qdict_haskey(qdict, "system"));
+        g_assert(qdict_haskey(qdict, "idle"));
+    }
+}
+
 int main(int argc, char **argv)
 {
     TestFixture fix;
@@ -1185,6 +1217,9 @@ int main(int argc, char **argv)
 #if defined(CONFIG_WIN32) || defined(CONFIG_LIBUDEV) || defined(CONFIG_FREEBSD)
     g_test_add_data_func("/qga/get-disks", &fix, test_qga_get_disks);
 #endif
+#if defined(CONFIG_LINUX) || defined(CONFIG_FREEBSD)
+    g_test_add_data_func("/qga/get-cpustats", &fix, test_qga_get_cpustats);
+#endif
 
     ret = g_test_run();
 
-- 
2.56.0


