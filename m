Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039DDCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDGfQ-0001SQ-73; Sun, 04 Oct 2026 03:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfN-0001Rz-SV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:49 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfM-0006D8-6g
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:49 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a156f4so746088eec.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791098987; x=1791703787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ddCKrpdgx73sLaCV7dGrQe9PQYIk74/lmCEDJ0TQwE=;
 b=G3uDMlfZ6yAce7xuqCH4Cpi59wI+3pwiSTRlJ0DE1i/QuHwR261IIHn5pUvfSDW9oI
 cdf9ttJqvE/tUK181k6ZOwOOzLYj/HUxAR3oKgMObbfIVDb0uAPJrHdjPxoFrvefqMxf
 NVH+p9Oh0Rm8SUl37mkWcmqSBZtpllo54FquPTtmOYicOYensWQmKI+C9ae45RF7GIgT
 mKIvZ+E+kkf9Jlp7TPid+E92GttluQXm+tGcDqTBkoqXD04NTyMbxPvHbvDYyRwUY00A
 /IxhhL+ZaO4tbuqCblFs+PoMSMljp//pVdtJc79Cs5Mnwj/UBXTNuFSC2Dz48HE0mfLl
 8rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791098987; x=1791703787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ddCKrpdgx73sLaCV7dGrQe9PQYIk74/lmCEDJ0TQwE=;
 b=bp7Rl+ZCOqqz8OefCyt8v/YTz00OTRNrcZVyaeyIqetpOeRuyUGWUWavOLPVlEAFhb
 3Piy2ckER5IYhhqR1tAMNBoH8VdTi1C+KOQqtxqRPFx3D2R5T3f3prILDWUNBG1xo42L
 POilr+TMX44C2qnIsAzVKFt+61GljMzdqSOn0hXwOvXZoEqC+mABw5IvTRsXY9aJ32sM
 r67f14A6FNQBdVyHv9UeOhrurlRw4P969Wt5SiIpCxAdCrWNY8jvSGDxfB4BYOaAoK7L
 IOTCoVxmYiHzg2prKrvfkfl+rOLK5sjQ53VT5epSqsQJIbExTBsvmpn0O3I8cZOggFeQ
 kLMA==
X-Gm-Message-State: AFq9FYI29dX0CaIQnr6NUyvxUBrT7STKipsSgh0U02v1Ksvrzcpojpov
 NgOSPIp3FzO4xPjU+IGwKa+WqGbejwWv9y1juLyM1ZRPfbuoGUchWO98Hbm5GnDl
X-Gm-Gg: AYBFou1I9y8XLOP2uYNL2VJfoosro9sWRu6MUKHotImP9wmxRkcOwpbA6xncGQPuV/8
 od5IYCzuOyyiZfgnShL2KCPz1zVPP3f6Bnhh7wFMVhUU6w37koIZ3J8HOfaZu6pHTW4uwJn5DwH
 xbXNU0MjBV1IAH/FVnBVrBXUk2pZPXYLjdNKHA6nvsRDrDhr1BC4W5F385WvQswiGEAdsvg/YpB
 pJbjP47EFsS+nuN1Y6yCE/ipGjejxwg+zQCxBR+42vIBuvpDG1h72a7sD5sds0Hx4B5pdfB6lfP
 qAc4XcM59X41FReTr66xfkPAmXG4plvQxVdZhPsEyyHk9VXbz8wH1vwenQv4OLUqJ+BxShgRAsM
 ikcDBy/O/MK7fPxaMR/OD5YwHN14pOI3vABYhka526etlxTtm9w3CXZFw0KrHtvE+6GAgIbThbu
 WiEaharQJ4pkdBGzzYrmooy2/C+X+KZIL+S7xGy8IWFbNGG+u/MyCBw02d5W4UfZ1e16Qe+jWcF
 8YQpYU8y0p04maWlw==
X-Received: by 2002:a05:693c:62cb:b0:351:1da7:7895 with SMTP id
 5a478bee46e88-3511da784bcmr3324654eec.19.1791098986766; 
 Sun, 04 Oct 2026 00:29:46 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-351270204e0sm3036770eec.1.2026.10.04.00.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 00:29:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/4] tests/qtest: check query-target architecture
Date: Sun,  4 Oct 2026 15:29:25 +0800
Message-ID: <20261004072927.1142-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261004072927.1142-1-luoyonggang@gmail.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Check that query-target reports the target identity selected by the qtest
binary, including softmmu variants.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/qmp-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 927ab053f8..c70f6a681c 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -164,6 +164,18 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
+static void test_query_target(void)
+{
+    QTestState *qts = qtest_init(common_args);
+    QDict *target;
+
+    target = qtest_qmp_assert_success_ref(qts,
+                                          "{ 'execute': 'query-target' }");
+    g_assert_cmpstr(qdict_get_try_str(target, "arch"), ==, qtest_get_arch());
+    qobject_unref(target);
+    qtest_quit(qts);
+}
+
 #ifndef _WIN32
 
 /* Out-of-band tests */
@@ -517,6 +529,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/query-target", test_query_target);
 #ifndef _WIN32
     /* This case calls mkfifo() which does not exist on win32 */
     qtest_add_func("qmp/oob", test_qmp_oob);
-- 
2.55.0.windows.3


