Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7329CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENKE-0001cY-N8; Wed, 07 Oct 2026 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJHK-0003go-S4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:29:29 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJHA-00015x-72
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:29:09 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5ba357a1929so1302204e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791347346; x=1791952146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07cFrgUM6cjvx6tpFpm8bpJgkAMQMVUlJURJV9H4y9I=;
 b=V6T7qu9vndO1plop9s6aM/pqTYsAAxIQj0YPXGlbwyVdfsKIV+hGl9gMrXY4A288Et
 8SStiqNGDcc25ql6nyruBpH3s4KE1g0KpVHAnbo/FxmGxtONTsazrtZAYXGtlOrKGqW9
 G+TfOGsJM7VrFAScJM7q69SUGPgnt8wWhMNpnYdqbqLOMJn2+6sAQYRKnGILqto02zpj
 u+/rIuVtFzONCOuTS/DI68+pzohIqzFF4WEXXyGFonU2T/8wUZazvycSJwG+H3x0jZ4w
 Y2dUKd6zf9HRVHBNw5VQQVbvdsjwd1QgYCEPtqLaPxtGO2VhMo35KssGxYkEcd0JtSKf
 E7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791347346; x=1791952146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=07cFrgUM6cjvx6tpFpm8bpJgkAMQMVUlJURJV9H4y9I=;
 b=ie0vvvsJ/KCF5v4J/lpdMdGtSejet3X2XOyZxBS2f63pBNSeSCqx8tbT0HYU5DIx3C
 qfdMFCgUkfh6eL9oI0ruPQ6kOMq9VN2MabxOJeGzLJjD6kll2KHfpOmqnE4rCuU3M2wd
 NxwFaWKSl/sexZ+n3JLWWWm4jkNNp7/B9RnP1o3NhAw+QswqekHzMare1ixRH6Lyt55u
 CMl9XfQG5aKd8dm2nY0gXpRGhdgFtzNj+n8bnZiecYARqmUCmR6gyca0Uvcgl37Chzpc
 W6FOPrhXWxNnC2stqcKd/BbgoPuny/IWqFP/xsdhAGfTWz+8yZrKANjiNOg6IkehqZHG
 kfow==
X-Gm-Message-State: AFq9FYIguHU3TzyiBubtSnrbSlpImef6W/YXkrh8ifk6/DPJAjglnxhz
 eK4JigTUkIdxU1NzRKH7NZ2NyItHMY+/smTfvLRyPli9GnsQZIjfBbeh0GL52w==
X-Gm-Gg: AYBFou13NuZ/GP+63xD3TJvM75xI+FtRL7XZAqry6xeIqIWiT8VmhrcM1uSyYq4rR1j
 +/9PGcipNQJQhoyMvkeEfe7EaUSvlaEHHYnej+L7EcOeRrZKqpFTPrHGDtWr+9AEicEfdTN3sZG
 msebx9BVb99bce91EaWWTAoSUQF7u521O2AYORBByOYh2eVCfDybC6rwQHxcDNJ9mHQoymVUqUm
 K27YMxgvYZ2ckdR+54nNiFgPFenaz4jVMEzav6RGKC8+FaflLAM+V/31phJx7UKWJtKq9TT3KXo
 otGsfjPND5uzo83mxpPlGmrtYijIpw1XdNThPiA/P4dFIJ63JJ8UewCaFWwycsdMJQ+8weMhJJa
 zTA0YYI3fmE2Q8trfVHCNs9NVk7sbf82XIEe6cc4FjfWOPZN/NCpv80y+i2B2dKCtagSCaZ8eZJ
 HYccvcOzTHf9z0QSZHVA8OgBlMtAQaxtXfGi/e+Jx81BxUl5uT/V1Az/lhXk/BiTZ4/iFdxX3Ey
 ZTAQofTTWxWO0KMM7X8BI8BZFdXCUd2t62oig==
X-Received: by 2002:a05:6000:4305:b0:487:27f6:a4e4 with SMTP id
 ffacd0b85a97d-48c6d1ad525mr1230103f8f.52.1791275732032; 
 Tue, 06 Oct 2026 01:35:32 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:31 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 10/31] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM
 by default
Date: Tue,  6 Oct 2026 10:34:22 +0200
Message-ID: <20261006083445.30362-11-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx7d-sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 65fdb19c06..47744e66a4 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -81,6 +81,8 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


