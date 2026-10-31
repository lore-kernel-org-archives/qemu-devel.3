Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s4ElI+G2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC8V-0002G6-Qv; Sat, 31 Oct 2026 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8T-0002Eb-Bw
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:53 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8R-0007j5-U0
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:53 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-36a1947498bso2087133eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464850; x=1794069650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijec5IqKtte5FEFZKHuL2v/76f/YDRGlyoBcQv2L4Uw=;
 b=s4ElI+G2vqSPwYwlcIjA2K0PcSKxEovzUhO4M9mIbR5NAKKDdviGshirY9SLqXtyA/
 yXISa6bbc/BYavBlPFrCsS1QmasFgi9LEjwU2mkh5vmEcMQrNHv1jRJXuLAzjgIEXs8i
 HK5nQ/UZYTWjZ/g4Hp296F1s6kI32OEp0jDbLWefXuzIHfGs3oyDvVVcjALTvzdtkM/1
 yKh+69rGwcuBhgzCXQnKB3KNM0H2fQ9lH2GdxbaHa2TbTdh0QNGFQmJ7R10knOESZwF7
 u1J7/7M31q8dhQ+KMWdhTQgLm1Jgf5VXWvn+yu0ZNIswwghjDDyn4Rum/8D6M6Jp/jFs
 FUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464850; x=1794069650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ijec5IqKtte5FEFZKHuL2v/76f/YDRGlyoBcQv2L4Uw=;
 b=Z0hV6/891H0rLvM6i83jQA7l3egaSW1s/dpFL370MkYaMgGjSdrA4RxiUgoPkOe0nB
 x6o2KI6iBpr5K9NQaimh7lKQTXosLtsN2aCpcpZyRgmvkwCmSOQXaSNcD4wdcg1E1+eb
 CxP+kY35VJeFWB141hZHK63dl/BCo4ccGXGxoTDggCI8/OQrzF1lx/XMxNzoK9p+Slg1
 SEU9V8Ii7yo6O9RlztuHVXJ8Q8A2ref8Ae8dgZJTc1+yAqVKoQ1yqbtZ1m/3KUSKMKbC
 dLvBjlNjlEof+zkZ2AtlYzGW2LXQ4UDuM08XdvIqhBXdzFwBwPuXJQRXm7mXwomFMMBh
 fq1A==
X-Gm-Message-State: AFq9FYIKEI1jrEvnZaPiGM2Ps9bcDWm3ROmmKMJe9dVcn/riOrewsgly
 Nfy/TKbYzH5t2l34YbsBhDluvn+iK/kz/BV/pSu7NAuyXqNzmy+JCCiy3va3//n1
X-Gm-Gg: AYBFou3QJDqryzfMCpZBk5AOjtGgTGLdIqQ5xCXGnwosVcQar9vl3vVZ7GQfL3jFKp5
 RfNSZvK/p4/Amyjqh0J7wWoZAhBa6F3hRPs7P4v7zm2V+JA2swLd6d8tHwmhuNRUAYv8Q69XWPZ
 eJko/DQexuUsDoTSZ3L5hGmbYryTBOIg8X1YSu1CDribUMWtXePSva3b3XcXWJKrHsEJIQucibn
 YyZ/2LNUk4Yo9Dy2E1jy4d+wy3XfAT1fnkk95iM42GNABHpUj8XElXTNKDc0HIRAPGgiJjKqhqR
 Gy8vBDABXWAmDkTPfoFzPkrJzcIFz3VNU3kzm3A4fLBZOS4H15rqdk9V4TOjqyibrn+kIQz85rq
 KQnGISVWbJxmpolSVwmGdhwH9NWeS8wQoIjyzu2bQmhwVP/1LMNJWLLJkES/Ccr0+y0MiFQJbt9
 0P81EjpVB3kwGxnBT45brTSRL7HbF3GxxRDTpO0kC6+LrCSfjRPFPPoDhLwfQzdl9Sk8jFoEOLK
 1xwNoXmDORdBUW0MXpwAk+GowL7rsL3/W6ZpowV+ph+qMAYmZnoKmq6Z68nrMDk8TzdoTEX+uae
 h8WD1lcGqSDK70B7dNP0tgNQmAowpm8iF9i8rTBAz4crzlBZtw==
X-Received: by 2002:a05:701b:2710:b0:189:ff2b:b194 with SMTP id
 a92af1059eb24-1ac5b9cb051mr7767795c88.16.1793464850203; 
 Sat, 31 Oct 2026 09:40:50 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:40:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 05/12] hw/xtensa/virt: select virt machine types with
 is_available
Date: Sun,  1 Nov 2026 00:40:00 +0800
Message-ID: <20261031164009.2048-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132b.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Xtensa virt machine uses the QOM name virt-machine, which other
targets register as well. Register it only when the selected target
is Xtensa, via target_xtensa().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xtensa/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 8c8fdad72f0..962646ba98d 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
+#include "qemu/target-info.h"
 #include "hw/core/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "net/net.h"
@@ -131,6 +132,7 @@ static const TypeInfo xtensa_virt_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = xtensa_virt_machine_class_init,
     .instance_size = sizeof(MachineState),
+    .is_available = target_xtensa,
 };
 
 static void xtensa_virt_machine_register_types(void)
-- 
2.55.0.windows.3


