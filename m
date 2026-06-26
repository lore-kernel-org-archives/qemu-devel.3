Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552CAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdB27-00053p-4G; Fri, 26 Jun 2026 14:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdB1t-000534-SX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:11:55 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdB1o-0003BJ-Vj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:11:50 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-37e1607f7faso560763a91.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782497507; x=1783102307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyHlu+LOyaTsbn1girlG13QiqUK77G7uCKycT4sSqSg=;
 b=ZI0QHMTHKVr82w1/WNVMN+duOUxGt9DapSk+BsnuoEy8ZikRdKzwIyVwTF2RZ9lvmQ
 cXNys8B5xAa9CcFDBd2SUKqAozq3eG4014CqEyZvmB78A8D+p0JN1yfkIzBeiIVrsRCQ
 Bh1iix+ldCcPL6S34ZdQ8NfPLGZQiScDxIuhcGzgbDofc40ceL9aEK0DwyyXhn8gtibM
 WoWjpZRW6YaxkTYnxareowEFg4hDhL9St6wWghcUBU1bg61eBj5Rt8OJ9e+n1GGImEJt
 V6sVDUfLF+qym3PXNq0CddcgxZY3TVY3SqCFza4sMjAr2y+9Dyp684bv/ovXKyluNwy8
 CunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782497507; x=1783102307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyHlu+LOyaTsbn1girlG13QiqUK77G7uCKycT4sSqSg=;
 b=gkF6qAlUFdaJ7aIOm1AFIln6C8d3F4WdFwjAj619DJGcUI4dBnnznRAOexveIBBBcC
 uAW46o+EhytuCysrWXjdLFAaPj3YgnoHqQZ2fShjCcxat8h/s++aD6VwHo8V+NYKKrSk
 JVDXwi5/iqXM2YHLg/6Ev1Kxt2mZWyy94oYMfL+kYD64Qnu1JsxMvwFFupz8cs16dJzA
 KpdEs5lX5hXhXpYeBmNYME+/zbGFSEkQ/dCIPw0ZvZENrvLsj7Kz2/bPsC/MqigAVTo+
 cETPLD8UmKFHQ/TGt8hSrIb7pnTcRL7e21PZXYQMMeVzDPe6P3uOuN9hxl9GWBVQiRt7
 6qtg==
X-Gm-Message-State: AOJu0YyGIhgWBXZt5XWJn5ksfGHUOSzOmSsraVdbykyM3RykBRsZCRf6
 d3HkhNJbmwSNYYcUOl7cjdGTFf/LMT/sp88tcoUDCwvS4RigwNoqLeHahQVJIg==
X-Gm-Gg: AfdE7cnHJecnRFk2Amy1STehzsnjojHgmFWOMicKqyJ4fDdknz4NYtfE8nWl8Bs+I6i
 f50rHS+tweoUWp2kVY5QSPnSyuC9LHcVmX6gEjiC1piZ7AiAjQnzsJHvDnHmESj8CgBtrR5eZhQ
 0aWeAeIzHlvm++s9IICOks2kzk6/CZPVbVtlClJJD+5+Swb7qE9jAmShxzXibyGpe4Onab5ijlR
 iRkMrvsHv2gpeBVrS70a9QbX79JkyN8/UtPjIdt8NkVxLBKfLYflsAKHRU7d8GodjzxFFk1qgEV
 uA/f1QKXIUj+NMJVN9ebRT9vN4N0Lxl/Mff5bNtS2rd+KxHONPbSze4HJcBjjv9XZb7Cxh1egE0
 3En9/yRyO7RtqJmdPf2X3T70dsxSg0XlUnZYYE33SdC1vvMOhMVHJrysdfFO173uKsP6Ru76t0d
 xZg1ESVV/ShCEw44BrpqYdQU5q4X+ZZUy3aBABPvv751lq3Ov5PI8d
X-Received: by 2002:a17:90b:57ec:b0:37f:9cdf:f0b2 with SMTP id
 98e67ed59e1d1-37f9cdff85fmr953479a91.33.1782497507077; 
 Fri, 26 Jun 2026 11:11:47 -0700 (PDT)
Received: from localhost.localdomain ([103.171.172.210])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37f464b5dadsm831287a91.5.2026.06.26.11.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 11:11:46 -0700 (PDT)
From: Linisha <linisha232@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, philmd@mailo.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, Linisha <linisha232@gmail.com>
Subject: [PATCH v3] docs/system: add general note about architecture and
 machine differences
Date: Fri, 26 Jun 2026 23:41:18 +0530
Message-ID: <20260626181118.1136-1-linisha232@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20260625192121.1887-1-linisha232@gmail.com>
References: <20260625192121.1887-1-linisha232@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=linisha232@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a note near the start of the introduction explaining that QEMU
options, properties, and command lines may differ between target
architectures and machine types. This helps prevent confusion when
examples shown for one architecture do not work for another, such as
the pflash0/pflash1 options visible in -machine help on some machines
but not others.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
Signed-off-by: Linisha <linisha232@gmail.com>
---

v3:
- Wrap commit message body at 76 characters (Daniel P. Berrangé)
- Add Reviewed-by: Daniel P. Berrangé

v2: Take a different approach based on review feedback from Daniel
    Berrangé and Peter Maydell. Instead of incorrectly claiming
    pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
    machines too), add a general note near the start of the introduction
    about how options, properties, and command lines may differ between
    target architectures and machine types.

 docs/system/introduction.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index bec7291e47..8d9ef61d26 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -1,6 +1,15 @@
 Introduction
 ============

+.. note::
+   QEMU supports many different target CPU architectures and many
+   different machine types for each architecture. Options, properties,
+   and command lines that work for one architecture or machine type
+   will not necessarily work on another. The examples shown in this
+   manual are specific to the architecture and machine type being
+   demonstrated. When in doubt, consult the documentation for your
+   specific target architecture and machine type.
+
 .. _Accelerators:

 Virtualisation Accelerators
--
2.47.0.windows.1


