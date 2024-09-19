Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F55CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr95O-00050M-Jc; Thu, 19 Sep 2024 00:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr95H-0004JZ-KD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:48:03 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr957-0007c3-97
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:48:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71798661a52so342114b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721272; x=1727326072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nGORvbHJ+qdXbStyLX4ZDxj18G9D+mDlGJ72uSFPz4=;
 b=on3wnEfA/LUY3Ax1Ist2MYqMaO+zmDq8E1eJugjI6DfE9edoCJxrclc/Mr3Jdn5BW5
 qQQpciXRWfcQ61Ls1dT9t2Z49mafjTsyftpTgAcGYiWptOKG/TKLnYPWTdiU8rASYlgV
 +zkWuBWdHB8AwntAANIG19xf8UssvtbI1eER703tIR7+6Iu2JouKnNRZO1Zi8/OJCogz
 C9Y7uheegAV7/oVEr7cvGi/hsVAXGZx2up+oJYg+fTHztGUel+mCJdjOeueLZR/O1s8x
 9u+4dOtjFtBDQA6qaxqlI/uKECCosqTViMVnqPi6UCWMLGjwUvIB7/qPI7/7L/pCnXx1
 96Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721272; x=1727326072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nGORvbHJ+qdXbStyLX4ZDxj18G9D+mDlGJ72uSFPz4=;
 b=RL8VOTNADLIuoZgvuBulGznoV9uPYaKTiXE6N7xMz+UhGnZhv6tcyOa+jq052NVlGL
 oMTjdd7QOr//p/q2dXWhuRgn9tjAnWcs41lNCZBPzbsu8puOgSqEPSQX7KDmyVIlIlZF
 8a2vgizXv8bNPBX+WAqzLIQozKxlIYcq3C5CMHc15zLc9omCxUAkD947lVU9gM9J1QBl
 3AqyuqczgIvGmyJs4UNsMBzkorknUxSUXf378sF9c6m/4lBo+Hf38AHqmO7fffu07D+W
 QFBhgPtCPqhSCGR+qGuxP7s0X5D6JR1SJoCEQvP2N7pxr04JbrI85pCtBjz8KrsGdvef
 zCfA==
X-Gm-Message-State: AOJu0YzmZ6DNU7QBwE6iyPkaBN3hNK5tu8I39e3enV+IIPV7z6o1Z+Eb
 sLGdzOjLRUoVt1iUTSqCfxUgnM1W/dQ30vKXlJmsZWpU1bostIC7TSdYmo822FALeB8hPX/i6//
 yWvXpdA==
X-Google-Smtp-Source: AGHT+IEDg2pn0QyAuvoiOwCdHYylFwrCXGUqq3XEUUTIp+6S2LNPDo0LRqpJhUmVkaR/AJ8UyQGZ3g==
X-Received: by 2002:a05:6a00:1885:b0:708:41c4:8849 with SMTP id
 d2e1a72fcca58-7198e2c832dmr2743657b3a.9.1726721271832; 
 Wed, 18 Sep 2024 21:47:51 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Hyman Huang <yong.huang@smartx.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <minyard@acm.org>, Laurent Vivier <laurent@vivier.eu>,
 WANG Xuerui <git@xen0n.name>, Thomas Huth <thuth@redhat.com>,
 Rob Herring <robh@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Weiwei Li <liwei1518@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Helge Deller <deller@gmx.de>,
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 33/34] tests/qtest: remove return after
 g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:40 -0700
Message-Id: <20240919044641.386068-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/qtest/acpi-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
index 673fc975862..9dc24fbe5a0 100644
--- a/tests/qtest/acpi-utils.c
+++ b/tests/qtest/acpi-utils.c
@@ -156,5 +156,4 @@ uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
         g_usleep(TEST_DELAY);
     }
     g_assert_not_reached();
-    return 0;
 }
-- 
2.39.5


