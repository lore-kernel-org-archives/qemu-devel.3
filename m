Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5647C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANaJ-0008Ez-1m; Sat, 26 Sep 2026 04:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANaD-0008EP-Fj
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:35 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANaB-0006p9-Kx
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:33 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dd025d06so1040173c88.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410590; x=1791015390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wpCAiLq/NIQne16b95JcTKYglPeBieSpO35EZW0OqVs=;
 b=UBRYb0xqs+5xbFZ0fVbWG04l4Vb5FcRApE2iO119Tvg/DF4m5rvKpncnYJxjOZx1Se
 iDmoDttTYaV19nAB2A3eKROaz56jhSfPZvkmG64ab6wF4vS19kCd0+efNt2zDz3+oBSy
 3CaMkyT1aF93CcjvGIuD/p8d75HpQDNLKLxc/oS7LCaVvY2Rb2Bn7hX6lXQCsRMq0RZv
 21GXPAZdbe+fwDSkrlAwkDiKYjCqJNOMNN74TwpqjYrPzRmfIeb3oPPllgYQ5sylCKyF
 /dBEbfkQIxPsbQ6rjqAEXzzCdwIZIWWZu72idg0d2UMFt+LXDB5s9N3IOWxK6hXkZPef
 x7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410590; x=1791015390;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wpCAiLq/NIQne16b95JcTKYglPeBieSpO35EZW0OqVs=;
 b=m/9sMWGTausMH8Fx09jXfMC6Ho1CiPoEPsvRNRBtNIfIsRJ80YIgX/QYPBPexOl2pS
 Zk3eIA2inR2gvAoC5mx6uj0oyNDBhSCq+RtLeHveXgy03pV43sZ7hzGGBwwxPY49+j0F
 9lZB7M9ldQy3kCprTdlNNTJirveDk635wjZ2/bfor4Pn5W3CH/x/BJZTXZLRUNEZxGNi
 nn9RWwI1bTgATI9PuwxvukF2zUOlWTXEUM5dsBFcKIZ9ZJMQRRP+ZXzmaO4T/JPpWlKQ
 IeNgE49foS0Kf0ZpkE4mJO9vGYlVuQEJgVHNvtG8YH6RXcjBQFUkpqvwiEK+t7AOw38Y
 6Zhg==
X-Gm-Message-State: AFuF++lioM1Ef4NE1gaU12NBAMHt/Kqm0aIy5R6yKN/3Vv14KvP8jsSX
 qGDVfBfhzs9OsWKqaWsobhc9b/w/q/XCo++oEe9wHXJrfoFUjBhC2PUO9ExoA/0o
X-Gm-Gg: AYBFou0Yt1U2mrtPxcrdPjaDvg5ubqWiZfxN7fwm5hcEcRTFLeoywHdAkT6mCVaCY00
 dgaHotTf8D3zW8f0wQ1YdShngaNYuTEzNJxFKc1CfeKJVNwxbO063ePrk3Gdt64TdKXaG9Ec3XZ
 Ew1sRc/TY8fn/e6cEQG0GIYyvnzGHv0oC2Hr4WXlpLnU72LTkkH8QPqXOJbkhdjN7NCUQyVuH1H
 dorHS4UsbSESgqqWOlmqJC6leLNXpmU0wPicCgd9RX7Ze7o4//dwqdYIcpcefpaRv6fCrd6A5ji
 KZ4MTvqOFMa1+CoQqgqBPpnuJySckVtMFyCiEZzXCxda5cdOejkuViBs8u6sw3/PzEvO1nKiqJ0
 TBdxm+NSTzsjNd9SFNK9uQ7BePkS8mKZWu94q+Kv2S81qTCBhp59xnL+l7huKaS1+J1bbYQEq1l
 VZsSnUIOqRsGnBVcodj78EpnlX5GCeueAHq+2ewvLI4HChmcur82Kz+HZXk8lIxZqqd/uBxsTpi
 mhxtoBH+cY/J3wvsVUXtlZhQKCFmmU=
X-Received: by 2002:a05:7301:3899:b0:342:5098:a983 with SMTP id
 5a478bee46e88-342706b19f7mr2314817eec.11.1790410589508; 
 Sat, 26 Sep 2026 01:16:29 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 05/10] hw/hexagon/virt: use unique QOM name
Date: Sat, 26 Sep 2026 16:15:45 +0800
Message-ID: <20260926081551.29-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set TYPE_HEXAGON_VIRT_MACHINE to MACHINE_TYPE_NAME("hexagon-virt") so
Hexagon virt no longer collides with other virt-machine types in one
process. Keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/hexagon/virt.c         | 1 +
 include/hw/hexagon/virt.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 64d8366d27d..04591066bef 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -359,6 +359,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Hexagon Virtual Machine";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_init;
     mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v68");
     mc->default_ram_size = 4 * GiB;
diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
index 4ca2f1ef859..523c4858036 100644
--- a/include/hw/hexagon/virt.h
+++ b/include/hw/hexagon/virt.h
@@ -26,7 +26,7 @@ struct HexagonVirtMachineState {
 
 void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
 
-#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("hexagon-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
 
 #endif /* HW_HEXAGONVIRT_H */
-- 
2.52.0.windows.1


