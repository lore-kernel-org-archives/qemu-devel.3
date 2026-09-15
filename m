Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEEDC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZsA-0001Tn-2C; Tue, 15 Sep 2026 16:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs2-0001Lc-1B
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:15 -0400
Received: from mail-wr2-x24.google.com ([2a00:1450:4864:30::24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs0-0005cY-FN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:13 -0400
Received: by mail-wr2-x24.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so95582f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504511; x=1790109311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ycZ2dbNgs+mypYkIGE7rKDXXsuWLMfAsfKt89XxETm8=;
 b=p8P2932h2cS0ZxKS7aV1LCtQkh8Rbt/NcFV+auoO5NRV+0NYcXYvvPkuJn1xMlijh4
 Ou7PWq6t6ZgPcBCJeodFlDs9ZsLBUCt6sZRtknYykZVlpHf1odJ3udD7EWnYzeu7Jehu
 oOLwS6flm9k5oEzd4bYApiYykbYmX2hdPhClR8u4py53WtINWvS5Pcj9sl4s3XfV5I6c
 y2SN8EewCUXq9qDufoY21SCUNHPVartXi2kWn/sl4Vqa4kKxDqRTbC8Ll8LXJEBc499j
 7K1NTXAS3VJcZqNWCIQzK6JCKOXE0cRNlW7D+cZMdSuwV0FSbN7jK2iXkTAftcN7r1AC
 48OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504511; x=1790109311;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ycZ2dbNgs+mypYkIGE7rKDXXsuWLMfAsfKt89XxETm8=;
 b=dq5p+nr3Ljv1rhIU8GPgx3uRTJjKxKbxCnampU2SvdDsv1vpRVVRt796rUVIyAooZ6
 xuaD0ih6h653lW5iNoDDatxqeLOO8uCF41mGi9qpt4r66wVYW0wPvYwNCOUfstNHPTJ/
 Yee917Ib20EIRgz1QQCvXs2Uj4c+2LjnSj0i7l0HW4hrS31meWResJtCGS69HfZ+Ckrg
 SIyybgvo0DisB+l9AQSjgl32CPeBH3GVFOSt5a3SANNMyKEM/Dm1x1dCPgjJbykeU09g
 k9Md3b2q+tL4IRB4IeTEjKKebsLKFGauBVY/a0ODptXASwz/wy7G3x91iTGW4S7mRzwC
 2qbA==
X-Gm-Message-State: AFuF++l9tRw50dywZ9y+Bn+MttoCB4+XcGMBncO/ikBthHlZ8Pa+DRm0
 jumNss0TRXqPT60flQiQmfDnR0t9yohw0yxq+/wd0gkF3EgTYA3WDzWzs1KSJmgU94NzBCHIbg5
 NGZ+3
X-Gm-Gg: AYBFou2lUMVSfIEYp5TdGBCnDe6y1DLa+/Ydh5UfxFi8aBy7P3GSxig2JP2APWDj2XO
 whOWxl1/2tbuVoIaKmbEn0FRcJhH5kA7smsCc3Cbz9K3XJjX0P/zXiXIqLriJJA80HwlV8T5v/s
 EUeNhtyHPR0qE+ucomtz7JwKUC+8WauPzer3YuWuSPS4riOcjbiSm+o5Z9u21fYd9Ls1SgJsW9q
 Q7JAmYagT6QonoFfcIIBKqBJPH5xqwSQrEW0rTr7RWSWIqDRHYexMhUaT4Z4wKkgBNxU/khRHif
 NkccWot2Ep1sFKoP48sX29sXUY+dv6BM1za88xinPB8YPyvG39vt9QXrZaCXGQ0Dpl051Z95G3O
 Eg2fIhsVaMKuvN+RS0Zgf3cVncN6FurgVS+Ef1kwjqU2pUaS+OJhDuljQndBznEUPUrIDtLlveA
 +3VCCeiwl0Jqx3gxxaqDuBcoCWIJOjNccVIuw3cZjBbKS5LJmeT5OkFxpOs0oUhD+SdWHWF0BCl
 6RiPbQ=
X-Received: by 2002:a05:6000:468c:b0:487:7b9:4f7e with SMTP id
 ffacd0b85a97d-4870cf0acfcmr87577f8f.5.1789504511049; 
 Tue, 15 Sep 2026 13:35:11 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:10 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/10] system/cpus: hold off the BQL watchdog under a debugger
Date: Tue, 15 Sep 2026 22:34:52 +0200
Message-ID: <20260915203455.580999-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::24;
 envelope-from=den@openvz.org; helo=mail-wr2-x24.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

A debugger stops every thread, so the sequence counter freezes at an
odd value and the watchdog cannot tell that apart from an owner that
never lets go. Attaching gdb to a running guest would report a hang
that is not one.

Skip the report while a tracer is attached, and restart the count so
that a detach gets a full deadline before the watchdog can fire. Any
ptracer sets TracerPid, so strace holds the watchdog off as well.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 system/cpus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/cpus.c b/system/cpus.c
index 9e03f303f2..03a07e4824 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -441,6 +441,10 @@ static void *bql_watchdog_fn(void *opaque)
         if (++stuck_polls < BQL_WATCHDOG_POLLS) {
             continue;
         }
+        if (qemu_debugger_attached()) {
+            stuck_polls = 0;
+            continue;
+        }
         if (seq == reported) {
             continue;
         }
-- 
2.53.0


