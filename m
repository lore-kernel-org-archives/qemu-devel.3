Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44C606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MO9IRSGk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf7f-0003hZ-51; Tue, 27 Oct 2026 07:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7c-0003cH-AR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:40 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7a-0002yv-Ne
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:40 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2908053c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099617; x=1793704417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0ai/QSqBTFAuRX7lmjVKoN/SEjV9ghG5XJlOke7CMg=;
 b=MO9IRSGkiovsqT073cEGznqz0/Xq79tihKLpdiB1BYQcbAQVfqyQi2TvshB9P3c+LB
 PvKiiGtNit7HUb2HeqimI1eLQEGUHA3NH6tIP1WSPXoCbSW+cWl9OTgXAyduc1JdOPbv
 k8kQIt3J+hiqLjnWtMXLiCdaCCYIL2r6GLJrjDW0wTZcqLSWJx/YB/yKOnUHI4qwdqOq
 /hP+MTs1w1VY1g0cKTf0dZiXoKboyIUgUt+jRxuGXk5B5aSWuveAt/Cnu+8yZVbLIptB
 l4FFRR2cNpzUCfZSQmgN4jXL+HYCQ4Pit9lpkpvqJEmFsnCxyXX6BcE9r9JWtFIfd1eO
 Im8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099617; x=1793704417;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0ai/QSqBTFAuRX7lmjVKoN/SEjV9ghG5XJlOke7CMg=;
 b=IzQQkrIXoruW57EYQManhliSInhjFsE85dP8okC9mfiKeP8BqUW3GiMg4JEjwq22R3
 +1TDkMYaNgw2cy/Ol9DgpbJ8l9L1uba1GWDPm7fKfIw4p9RhbOAJLB9b4+nG5hsL3ELa
 /QV+VHCZHF9RKalaqMTOHPvtK0T1UXRthzsd5uZcORv594t5kkLG4bz2EgTLi6O6kx9A
 jlJOTdxxYZ8Hb3oZUhT3ONdurQk25VKhNNM7y6UN3yFmzwI0F2ijS7btOjIXb7UuxyNo
 wjxPvpgyMYhQAhIwb1QIO7+Yyw3C2flpZYhNEAgeLFukI99WwLJK+i107cG8z8rKgLMH
 3Fqw==
X-Gm-Message-State: AFq9FYJ5TVUhtX7CjcnXAlmy2385xbXop7bpRh0ZBjFjzRI1vg1B+6tw
 EWtSQzKVqzIrBAVqJazhA5wZ5ztfvOYj92EjZ0FuX2doq66p5WlHnpOCaaMF4VTm
X-Gm-Gg: AYBFou0o78IKtGW0CKzGbqA1JsDCW3jyP4Pg9ugV5XhUZ4GHvOotjLx+7r03FP1Ihx4
 f7lD5Gz/NZQJoow5NgMF0YHw72lvNR1qytj73m81BRCXhfd5OkwNTdBz8sb2xYbBVhTqIh4D2H4
 QnPazvrfisyF4mgzOSSJCRQVbSWHbklwAgibhIiWKTDnGeBSEvmTAw/uMwL3gWi0/OFiIh56CEZ
 J4A6/ta+Y6i7quBo4ru2z1VZu7pI8PLU8AvH1xZ+2twpnaV+LiVU5o8DWpE7AnWLSaHjxq1a4DV
 el3AMTNuyFIJptSVBYAkcatJvNCznVzPslMtaxvVadIHK+6mT9b1zr2u115PV4FKht1Fc3cgryD
 13bG1vovOVSMdMFkFsoPbbz4SalyCdNSHWcZ5rZj2dnzVVkVF1POAA3U/pT06M7KIUKqUACEJPs
 NOExkY9gI6ejCmAMGdPBa/6dI0hyvQzdKBh//dpwph7YRvA6zb6GInlkLBZoQQk8xfjU+QDF7Kc
 19Rul7RD8o4euZhYT4AVshQSfW0d7JnQoMq+L+BsssH9sQNfruMY5xXn+Wq+iNBqzsNK+dpY//f
 d+m+Rcg/SuMV
X-Received: by 2002:a05:7022:84:b0:199:107c:25fe with SMTP id
 a92af1059eb24-19937024784mr12738672c88.31.1793099616923; 
 Tue, 27 Oct 2026 04:13:36 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 11/17] hw/or1k/virt: use unique QOM name
Date: Tue, 27 Oct 2026 19:12:09 +0800
Message-ID: <20261027111216.392-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122f.google.com
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

Set TYPE_VIRT_MACHINE to or1k-virt when target_heterogeneous() is
true, and to virt otherwise. Keep the -M / help / migration name as
virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/or1k/virt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 90916234dfd..6671f3b677b 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -34,7 +34,9 @@
 #define VIRT_CPUS_MAX 4
 #define VIRT_CLK_MHZ 20000000
 
-#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE \
+    (target_heterogeneous() ? MACHINE_TYPE_NAME("or1k-virt") : \
+                              MACHINE_TYPE_NAME("virt"))
 #define VIRT_MACHINE(obj) \
     OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)
 
@@ -548,6 +550,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "or1k virtual machine";
+    machine_class_set_name(mc, "virt");
     mc->init = openrisc_virt_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
-- 
2.52.0.windows.1


