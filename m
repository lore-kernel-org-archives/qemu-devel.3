Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A81FC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03R0-0003KT-EI; Fri, 28 Aug 2026 16:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Qy-0003Bw-GQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Qt-0000SX-2s
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfoPCqnTZIE6i4/lwOooOZP0EnfLYW28cDlRixXBTdc=;
 b=JDelFEQLue9O18nvTZQy48iAl+SgkA+RP3e0o/dW1yJzsxAzJ2rB9taUv1VRgBnHTFg+CD
 hHcUoyeVi26NUgJZ/4/0HuCkNT32XobXWz1OPbvY7jmzB/dq5C73xZb0k4j3hhtj8Dtam8
 C9IC232UH1FB6ly/IfqrGMU0iPY5RHY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-kGvFT0DPO62dXM3ZnMGCeQ-1; Fri,
 28 Aug 2026 16:44:07 -0400
X-MC-Unique: kGvFT0DPO62dXM3ZnMGCeQ-1
X-Mimecast-MFC-AGG-ID: kGvFT0DPO62dXM3ZnMGCeQ_1787949845
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC8FE19091F7; Fri, 28 Aug 2026 20:44:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3F0118001CF; Fri, 28 Aug 2026 20:44:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:13 +0400
Subject: [GIT PULL 34/50] qemu-print: document HMP/QMP behaviour better
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-34-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Dr. David Alan Gilbert" <dave@treblig.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KjYt5VMknU+zhdOOGGZoVmw0P+kwqyai2VbWN9tXTaY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVJGO6yCmR4qSruDrcHdwb6mit0kLEeOk3P
 nqHqJCNlsCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5a9kD/4ll59kY+7XXPhO48EOIbnqmS5oRdC7UqirYjY0KAQGPItxxeWQ/Wyve6M6jfxRTiDaxDs
 dhcGel9ewpk8U8qEBjqo7zo57rf9lHTW/4Jpaug5eJNB9pVPBzS0k+F/757xHsGCm+ojtXoO3P9
 CLQ7KKYu3JP44v4rbHWNePzk5/8D07pHBS6LUl2qjQfddNJq2/gipHJAlsyj3DBRVkqK4/0/N3a
 aUGJUNN1khX2YY2A8LaR0ElHERN/rtDNAzy7YAFA7Q11I9zwD9MQl4oyunowhHGIMSOmwumCcuB
 tn0T9yhOXKnSA3YnpUALalNpxynJhWOSG/w/ReNvV7lA0gK6NTbvvVE0yN58x8+TZgWI40pmQfy
 wbLNRgEd8BIiBp5SiIn4yMNlX6AJpIVdeX1tVBJBD3mboylybwboJ7PnpPgSopEmU2umk0sy30y
 J4Tc/Qip0ce+qLvUrfkdc0tswznE8AOlQVjJclCwcCdRvZYTsxCTZDAJu5R3hLz6136vQltIxFM
 1h0ZVPtp/6UNJukSOhJY6qYO20wD7g3R1rK8qzbbbMW6aqdVVkKjpThd4l7UO+Vq+hRP1kDzNTG
 ht8W5bTEEsGB+VJ8if6/EYu9sAGgMtLufRGv6XoBICTuWxupYKcttJVpocecG8hd5j3usrGzFpR
 3cg9IYh6XxwM72A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-34-9227de146347@redhat.com>
---
 util/qemu-print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/qemu-print.c b/util/qemu-print.c
index a2d1f0244168..5d4143d425a1 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -17,7 +17,8 @@
 
 /*
  * Print like vprintf().
- * Print to current HMP monitor if we have one, else to stdout.
+ * Print to current monitor if we have one, else to stdout.
+ * (if the monitor is QMP, fail without printing anything)
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
@@ -30,7 +31,8 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
 /*
  * Print like printf().
- * Print to current HMP monitor if we have one, else to stdout.
+ * Print to current monitor if we have one, else to stdout.
+ * (if the monitor is QMP, fail without printing anything)
  */
 int qemu_printf(const char *fmt, ...)
 {

-- 
2.55.0.543.g5ebe2ebe4ea8


