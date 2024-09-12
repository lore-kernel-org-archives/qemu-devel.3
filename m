Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF978EED618
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1somQh-0001VC-15; Thu, 12 Sep 2024 12:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQc-00018n-5z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQa-0007Vm-E1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db19de6346so839486a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726157535; x=1726762335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWN+Oy9HOzHEP1zqC69VZ8fDvc5xR6kboU5Mz4xPMnU=;
 b=qliJfrYWjg9UCQEjJ/2fj5MgAM67NRso0rLrm660LjwhmRDC2ygYSZLO0MdAOhZLkm
 tBE6SMfcNoOXrtbdVGHJA3NMRmL59t0dmB/IJ6+/0vxlYD+UBA/xVSRCArPRzLRNCRMx
 kCYUMvfJq6o70EMpqu+g5dmGkcJRdACfz+McdEB/U7YkREMM9hRpOuX1L2l8KczvBO7P
 KKBvrIEc2actiK7SFCxYDJq4nLEu/KO6oU30Lcutp2C1wBbOFt0tv+9NRmQ5IrCL5q0E
 CdcMex/H3y0XJ3hY9OXonjj4N0KdG9pz32SLwT7CWnKdPYbWuz9yaf4DKAVpmHvSFPH+
 G91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726157535; x=1726762335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWN+Oy9HOzHEP1zqC69VZ8fDvc5xR6kboU5Mz4xPMnU=;
 b=nj4q+Xv6zDjzdJLh5+JAIBmkf6FAzgsI0F/Bwpw4xn2eCkqbR31welaR4jQIpgDiYV
 hFNCtCrvGwqsPEOXzEhoWmzDpsIn00dFv2FFkPyQDznLq8BLdfHSjOghSP+woAsdJVF3
 sSGdLSihH8GuanVm+rEFbMpcOft+jyi/1410okdHEFdLHeiYQ355xP8NSTFUtY/GtTDC
 8ErUjzS632q3jEIgUnCoTc81pHtobKrbGs8HiRW4TznQUOajgwnZ6Woj2J3SuZPuM+3J
 Z11TtZPuGNOjP+xiu6s4Hc0HY7gbpXqTPBw2UuQp9+QTxSs6kcjHZrmk2wMQRT+OtAEV
 j+cA==
X-Gm-Message-State: AOJu0YypN1wOIcKzU8ASw7zzCbc5h25M/TcTfSpM9Bt6f6mvep5JKA5q
 zdjvlsPqTyXplrJ2IMtofD436QFSSNIFRrjWgSLuSFuXGekiCY4GKlbsqWJBANL4z3NyiubCNXN
 P+bqvXP4T
X-Google-Smtp-Source: AGHT+IEudqjJEaJGfdkYpDawDooI9CPu9lOGv3V8EFCc9McG20NJHsadE1XKePiqdhT+Fnpsv3OOxg==
X-Received: by 2002:a17:90b:4c41:b0:2c9:3370:56e3 with SMTP id
 98e67ed59e1d1-2dba008304amr3540812a91.34.1726157534900; 
 Thu, 12 Sep 2024 09:12:14 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db0419aab4sm10868139a91.15.2024.09.12.09.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 09:12:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Weiwei Li <liwei1518@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-s390x@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>, qemu-riscv@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Jesper Devantier <foss@defmacro.it>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, WANG Xuerui <git@xen0n.name>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 48/48] scripts/checkpatch.pl: emit error when using
 assert(false)
Date: Thu, 12 Sep 2024 09:11:50 -0700
Message-Id: <20240912161150.483515-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 65b6f46f905..fa9c12230eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3102,6 +3102,9 @@ sub process {
 		if ($line =~ /\b(g_)?assert\(0\)/) {
 			ERROR("use g_assert_not_reached() instead of assert(0)\n" . $herecurr);
 		}
+		if ($line =~ /\b(g_)?assert\(false\)/) {
+			ERROR("use g_assert_not_reached() instead of assert(false)\n" . $herecurr);
+		}
 		if ($line =~ /\bstrerrorname_np\(/) {
 			ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);
 		}
-- 
2.39.2


