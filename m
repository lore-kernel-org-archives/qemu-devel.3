Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3F606A331
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tm/nV/Qx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3WU-0001Xc-KD; Sun, 22 Nov 2026 04:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W7-0001W9-3e
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:48 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W5-0000yO-EK
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:46 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c511c0e2826so274455066b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795338344; x=1795943144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fsRPD7Cc+S/296aJvonbzWsh07yAOmWSmVYGCBL5gPw=;
 b=Tm/nV/QxsBcAmzWZ6ifLGDVtubEajT/AxPlU9X72HcNTrHmdo1OcaZfUiEY29+GbLg
 i/lKINKbZmagwxrhQqKcSsac6ub1psypfLks2liuB+PhdPA6DLuo3mKkcO/NWAD8dapx
 abF8epDBJ57GYvZcqP3gEDwJy+eu1jHqjVimXApfY/+18Ox6jJyFRzBDK5oY5BdrVjnr
 hvEXoaN3g9swpPtvXYRqtzOtjMMnldUAvqNXteGIW+VYAuHSc7nOE99qCToqeRNp0WOc
 3ByoGRRdi9utnpoKGKfdzHb7M2MkoRwRjIIScinq/i42/z1D1JXQBtwTJeYHfNiOY6p8
 VEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795338344; x=1795943144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fsRPD7Cc+S/296aJvonbzWsh07yAOmWSmVYGCBL5gPw=;
 b=sMEedk2lo8mLL4Sb79jeJrgssoNgxaJb1T628gOPHeYtJ9tHd41V/PoabR8jghshF5
 qzJKZmmiKEtxPEbJblalLdObpHkAW4csTQJxXG1LhcQPatVeEkCg8mofQ04TnqdbO0Wi
 64SQg5S7GS/tzlTuvbPXcPkZj242Cn13tvrkX5o/kIuN1wG1U8a1O0TqYoGWBm3SnfWO
 E4NCTeHyL/FO/Wz1A6YEyJf4DPzuYLzhQIm7gzFiLAlQzbPf3J+/FNnESI5HFZY3Sq1R
 KpVvVt/KHSQx2kgusuPOue2RCGJdqGBccABkcG1ZdFvSEGTE+yupqiEQii/taWrCrQ06
 64qQ==
X-Gm-Message-State: APuU4Z+IPkOPRp22t1rsYJDCWO9YLCLhYYpGdJY2yvq1PORK1Fq6tedL
 XqkxraNVkbjoKPA3BdoFA5Okl/7R14lR+08MT3gxfmIswzt4jaWi7AJT7K6qVdOk
X-Gm-Gg: AZFdTZev9Q59wBvBhHVB0y31NumpLmHJ6gOulwOylRHaiscUZ4wctouq+zQLfXuMv/4
 9X4eXLCDNWUhe+Lnd3gebQzJ1LRvlYH1vPkj9kM2k7J3wCrQZntn8pj+P1VPE0tU4cszJTOCKPm
 W4EKvLOCI8MTPR14Ppf1NAr84hdP4rmAVLFfZJDlUCutYyCkdNdJs93h6dOYizFs6hvmBAGSY63
 55XFwcBeqtJXZvc6sth0bu77wAlmjtJOLx2Sz8zwysyE6SS0NkINme862/HesNNmz6/7iQ2Z/X4
 CKd5871qrCIuJ2cYyYy7veDizDY+Bghf5dBJuClGDzJCvXy7o4XMghgX3kb7aCmCt/78I1w8Udi
 IBZmCIq2vGPzu2UHk7qG7wawrlN4Jd/Mg1nk9PmEE63uawlMXwwBhdKdwznTXpvWeM37xr3NkB1
 N5hum6cnARc7udrwYu6RR+xuMDTvQDtchgmbT3BkO1GO1lpltEL6sijUnNLWlj8OUAZTMWKru0U
 T015QW3Xqtd9imv2IDaDE7YXnyT0v0JfcXCJu9vFN21fZi70v2Y5LhyaxRbqGCwzd4F4gQdhGN3
 jMLBx51cHeU34gTkFLPnym4O8NgOPtQCcvxyFJpEzXm55jeWw0nNJbGYogxv/IJWVt5gV/cWHfF
 5q7RedjhSvbWKA1cROIAfP13UyzLODnwGiiUO80w=
X-Received: by 2002:a17:906:81da:b0:c51:1d9a:323c with SMTP id
 a640c23a62f3a-c513a88b0d1mr533350266b.15.1795338343644; 
 Sun, 22 Nov 2026 01:05:43 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad010a6sm298893666b.7.2026.11.22.01.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:05:42 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 4/5] tests/unit/test-qga: test 'guest-get-disks'
Date: Sun, 22 Nov 2026 10:05:09 +0100
Message-ID: <20261122090511.15121-5-bogorodskiy@gmail.com>
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

Add a test for the 'guest-get-disks' command.
As it's implemented only for CONFIG_WIN32, CONFIG_LIBUDEV,
and CONFIG_FREEBSD, guard the test similarly.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/unit/test-qga.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index a8387bd8e8..a8ef6b0e21 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -1095,6 +1095,30 @@ static void test_qga_guest_get_osinfo(gconstpointer data)
     fixture_tear_down(&fixture, NULL);
 }
 
+#if defined(CONFIG_WIN32) || defined(CONFIG_LIBUDEV) || defined(CONFIG_FREEBSD)
+static void test_qga_get_disks(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    g_autoptr(QDict) ret = NULL;
+    QList *list;
+    const QListEntry *entry;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-disks'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    list = qdict_get_qlist(ret, "return");
+    QLIST_FOREACH_ENTRY(list, entry) {
+        QDict *qdict;
+
+        qdict = qobject_to(QDict, entry->value);
+        g_assert(qdict);
+        g_assert_cmpuint(strlen(qdict_get_str(qdict, "name")), >, 0);
+        g_assert_nonnull(qobject_to(QBool, qdict_get(qdict, "partition")));
+    }
+}
+#endif
+
 int main(int argc, char **argv)
 {
     TestFixture fix;
@@ -1158,6 +1182,9 @@ int main(int argc, char **argv)
                          test_qga_guest_get_timezone);
     g_test_add_data_func("/qga/guest-get-users", &fix,
                          test_qga_guest_get_users);
+#if defined(CONFIG_WIN32) || defined(CONFIG_LIBUDEV) || defined(CONFIG_FREEBSD)
+    g_test_add_data_func("/qga/get-disks", &fix, test_qga_get_disks);
+#endif
 
     ret = g_test_run();
 
-- 
2.56.0


