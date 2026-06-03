Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38B7CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfek-0001Tr-PQ; Wed, 03 Jun 2026 03:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tahsinahmed217@gmail.com>)
 id 1wUcum-0000QH-17
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 00:09:12 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tahsinahmed217@gmail.com>)
 id 1wUcuk-0003wd-Ij
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 00:09:11 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-915767ea2d0so178349885a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780459748; x=1781064548; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FVvLPhtSjcR9JUA+chKlMdrtJg+0QqpGpLjLsEGQ0SE=;
 b=cb0hxN9JjEZgylPlaWGs2EgCgrW2rkTnSpm6RhpBitLKC9fdLmDU4BFlRs6SvM9UNH
 8faNsXRlEhYno3VRYMlvSYGUhjDDQC5WtsMxJIqMqnWtPR/bBA0UiYQY3DkO/HotO4fG
 p5iUPLTS8gpejUsQ5+VtmYtOJv8beaMVgryfX8t2eQpTr77AOpIDJJKykalRLsPTqDt5
 Mbf9n18m5i4utQCsvdPFKqgfwjdpK8X2EA5tddQp+IKllgB+OBGpKibIfLXYpkzAbtoB
 O6p1K+Oy3NBV7u9OD+3FzCu6ak1pOlcCtk15/fHFCk1iFJCnB7MaIdIWgu7eA6Q8CCH5
 VExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780459748; x=1781064548;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVvLPhtSjcR9JUA+chKlMdrtJg+0QqpGpLjLsEGQ0SE=;
 b=LbbqM2nlFI2nJlqqWpbqxXgQ5iY4eYFJ5WYKADBPxJPcrRZS+atvqOvLLSfCK+LZPu
 wdRIJaLiBUCubSqGlmKGCpI18WiycFr+nLK0CZCEQGcaW8QRhIwLcmX99OxS7pmK1xZZ
 K43hKVLmBDnx4+tnkLpddbPZN1yblGI+181/ALkf2WSx1SOnncdEaZ+AX9ZPp0jkQ/mK
 nIZDYgj5/IhxRhN9P+rzkGuVxqtiB3zZ9Ol94oOSlSpTZ8JuAQcMci9cJBVKcXrofW73
 xGq29uABcD9pM7APJAxPuBws+REdfCPIsTQo82GnDyHxZP6f27Mu47RVZO6WeWg1CGSr
 FhTw==
X-Gm-Message-State: AOJu0YwsDyW5Nv+8olWlGa2nVPBRFLo8gAnzWgL80skje5Js8NsFJR7M
 q71i7warkiIh1mlfXuhJyRbdtrUfJJdh3Bqrol3YpGlgGfIuyb02Dj8y
X-Gm-Gg: Acq92OHwMZOa/klIXOWp+/R02emtSOlXARtQxTJHocTRxqc5jTR1id25YXSq5e1N2gV
 6QvzKw3nQYGFdQn0KVQ29Nw6gfXZ7uysTli2KtIbSI7btKzuT427bJtiEwjE8Pxd9WmZ5MUPAMh
 v76++10D9nEtfEOl/30I2SaYmu+07GQuWi1yPfipQMOFVhqEpjlspFz2ewGXokpQDkKQbBshpkN
 CEEKLIbhZPUyo735nOP2IZm0RvUUCFVJEcsjf2ETUFEEu4b4hO+cuhmp9SQk4fMik7MO91dgpsC
 Zeyh9x8VSGnbkl7EHeyoUBKyw6D+LM6WyAyE5IYO6xkA1XrUFxOV7v+28M8eFwrktzU9CmqvU/J
 hK5VfB77DO/rapLQV2Xqy8rft3VH4GorPtWpew3sv81sp1rb3jI+H2zake5vMSFMsrLrZuXuh1V
 08fbOmJNJjvx0MeDT3QiZMTOH8I0u4QaaDmz0tYWiJTDLCdisov6s=
X-Received: by 2002:a05:620a:2406:10b0:915:6c4d:d74b with SMTP id
 af79cd13be357-9158a7aa7d7mr236671685a.31.1780459747767; 
 Tue, 02 Jun 2026 21:09:07 -0700 (PDT)
Received: from cosmos.localdomain ([47.230.224.41])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37bae6sm132017185a.31.2026.06.02.21.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 21:09:07 -0700 (PDT)
From: tahsina13 <tahsinahmed217@gmail.com>
Date: Wed, 03 Jun 2026 00:08:58 -0400
Subject: [PATCH] system/cpus.c: Change qemu_cond_wait -> qemu_cond_wait_bql
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-qemu_cond_wait_bql-v1-1-0d04f0d587cd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMj3cLU3NL45Py8lPjyxMyS+KTCHF1jSwPLZNNUI3MjExMloMaCotS
 0zAqwodGxEH5xaVJWanIJyCSl2loA3lJ90XYAAAA=
X-Change-ID: 20260602-qemu_cond_wait_bql-3909c5e27244
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-trivial@nongnu.org, tahsina13 <tahsinahmed217@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780459745; l=1379;
 i=tahsinahmed217@gmail.com; s=20260603; h=from:subject:message-id;
 bh=8wUkmQvp4eac2gbo42vE4QAyVYFNtSicEAvecVTgQvM=;
 b=6kryT1Wv65VAkKTPwU9mkNnE7A4cCWdmUPVdBOcxs3i0Dqkq3bD31jzEyxkBOvE3Cf/ccMOAx
 XGfppltC29ECw7HoBz5GYteI9TLK7y7Ox2aQJ0fkZscAmmsvhaZqUTj
X-Developer-Key: i=tahsinahmed217@gmail.com; a=ed25519;
 pk=JfqIEYrQSsTnK0suzDJvT1w9PC0wESzl1NHgiFwAMQQ=
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=tahsinahmed217@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jun 2026 03:04:47 -0400
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

Change qemu_cond_wait to qemu_cond_wait_bql when waiting on the bql.

Signed-off-by: tahsina13 <tahsinahmed217@gmail.com>
---
 system/cpus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index bded87feb1..33b33bd4e1 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -469,7 +469,7 @@ void qemu_process_cpu_events(CPUState *cpu)
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &bql);
+        qemu_cond_wait_bql(cpu->halt_cond);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
@@ -654,7 +654,7 @@ void pause_all_vcpus(void)
     replay_mutex_unlock();
 
     while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &bql);
+        qemu_cond_wait_bql(&qemu_pause_cond);
         /* FIXME: is this needed? */
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
@@ -726,7 +726,7 @@ void qemu_init_vcpu(CPUState *cpu)
     cpus_accel->create_vcpu_thread(cpu);
 
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &bql);
+        qemu_cond_wait_bql(&qemu_cpu_cond);
     }
 }
 

---
base-commit: 405c32d2b18a683ba36301351af75125d9afda08
change-id: 20260602-qemu_cond_wait_bql-3909c5e27244

Best regards,
--  
tahsina13 <tahsinahmed217@gmail.com>


