Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1D9C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Xc-0007lg-VL; Thu, 08 May 2025 09:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Xa-0007df-Fb
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:43:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1XW-0004uK-L6
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:43:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so902606b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711832; x=1747316632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz56OqXDxt7nqC4LwA+a7OYiuZlEyLYttSp20fJi6+I=;
 b=RYMclTj9lOI1cUlMD3feG4ufuIXaaBlvI0giA9qYKpOCsUval6rcNOdTDHw8tC23RP
 d8J0PTMhRaie4r6CEVA/osf2C8RzHcKs1Rl5bQ8heX/vXh+EoW9DTqTVajkDt17Gw4E/
 nXDVGIX3QGR+xYFYa0P/PDObQYf/ZPqzEP6sYe+sZtJucVJT2o17ALVBVmWC8wff7lXJ
 VJDlZ3xKQAvI+R/jxb7Zq51gvYsj7Keg9B8eWr1woVvvNCMB73xnukJakGZhEKCaqMD8
 CpZ3mYMjQ9DNg4fdvshJTpXa+DWz3Alkylx56utGoxZjTmQqLww9yFZqt80XVQrbJydg
 951w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711832; x=1747316632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz56OqXDxt7nqC4LwA+a7OYiuZlEyLYttSp20fJi6+I=;
 b=jQl3hO1UVBdpcolcz6U70h+H95UQBS42DL4mRGHciadUWryvuBFzATv4r0KqqL5W61
 6xzwLVsSBhvbgDwV96GzTvkwGdsQbdcPF5vY8SkO/y5XtV3bWHiGew8Kc93F9vhRshqV
 LX3o3JnZ4dXhWWjcJ/D7QXVFTBraqmekGghGterk42IH0FxBkObIsGyYLC5FoAp4ueiI
 IzJxmFbCmV1Sid7Y7cWdTgsXpBs2xlSvyAWnO+PBQGCEQisYK48LhdXFFVi1M0UDyfXA
 TxousLTbWg+tVeE74yF2Emu0dNbiSUU7IcZP8RtgYkYIPodV3M81fQ5bUIK4UVYq1GxY
 qU2g==
X-Gm-Message-State: AOJu0YzVQywY5kzEh7QeCdsXC/+P1U6wTXewtNcmYdQwIJLzGn4YqfoS
 POX/TNYe1p6NTEdzS1JLDrMXl/Po2fm9K7yBwSFe/PcIkkbWs8P0yMByeGVUkfPJ4Ful+kLRX7N
 ECkDKrA==
X-Gm-Gg: ASbGncuYdFgRIyjW4ZB0WFfW/z2TR19oO5AXVW/Qjg8/cvVO4lud8ZNYXxwl9gz9SUq
 kpuowSbDbSp1MevWYtB1QdodsEibaictOwAjgK3XP/ZvnwdCJ0fSDfsle7SghxEEy41pC2+2ORt
 7f8gcSlZI/IRajai4SVYIVI0SoCVFmpPLGEro2VgwB684ZG+fmJE5U/2jr3bgNX+INPD/P554IY
 zbf7N01T5cu/yT5UkJDjuTfYdOdbpwKu5mVIQSZLanyIbPidGKSAP8x7AipkxMjcfyQszWgabAR
 gRtjjs28dMYK1qtQl2dvPKnrrnEFYpSO8Qm6pX7PPAYy02A5UcZCyrT8LklPdT+pDkwwkFs1O8w
 r9Rc8FFjdx11UYgU=
X-Google-Smtp-Source: AGHT+IHYW6laMjiHc6hZ9CXPvMKDRBiIggZW6kdWUwxA5qsOS+e0Hn9w40Bkb0wK958QO+bMwwTmhQ==
X-Received: by 2002:a05:6a00:418d:b0:736:4e0a:7e82 with SMTP id
 d2e1a72fcca58-740a99ab539mr4600433b3a.10.1746711832328; 
 Thu, 08 May 2025 06:43:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm13751300b3a.90.2025.05.08.06.43.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:43:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 21/27] hw/audio/pcspk: Remove PCSpkState::migrate field
Date: Thu,  8 May 2025 15:35:44 +0200
Message-ID: <20250508133550.81391-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x435.google.com
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

The PCSpkState::migrate boolean was only set in the
pc_compat_2_7[] array, via the 'migrate=off' property.
We removed all machines using that array, lets remove
that property, simplifying vmstate_spk[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/audio/pcspk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a419161b5b1..0e83ba0bf73 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -56,7 +56,6 @@ struct PCSpkState {
     unsigned int play_pos;
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
-    bool migrate;
 };
 
 static const char *s_spk = "pcspk";
@@ -196,18 +195,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     pcspk_state = s;
 }
 
-static bool migrate_needed(void *opaque)
-{
-    PCSpkState *s = opaque;
-
-    return s->migrate;
-}
-
 static const VMStateDescription vmstate_spk = {
     .name = "pcspk",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = migrate_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(data_on, PCSpkState),
         VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
@@ -218,7 +209,6 @@ static const VMStateDescription vmstate_spk = {
 static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
-    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
 };
 
 static void pcspk_class_initfn(ObjectClass *klass, const void *data)
-- 
2.47.1


