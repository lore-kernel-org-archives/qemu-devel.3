Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B9ACF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmx-0005JZ-8O; Mon, 12 Jan 2026 17:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmi-0004eq-M4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmh-0003Uv-5F
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so54726655e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258393; x=1768863193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XNdDIfwnqdkqTT9HrfGf4W/wlTOS+i1k8CQmHo9TELo=;
 b=fWD788q03wO8kh77CpkEi1T0AGt16mkkhgQv4NtAENPXsW2hD0AjUM1BJvhT11FFI4
 OQkr14OVTL1sct7EawKGPflH/8THzplxKWXau1xd8/bIHYoWgHNVllt+m+14XqqkZGgw
 /3ggybcCDNIeAWKjhlYN2w0rnRjYxVHYhD9hm5mDN34bxvmJZyxx8NQgEvIMojuGLOdz
 b7jdZS1MdSAaoIIJqXxPHcpCAovnjTBIRlJRAjxotgAGI+wnptQqBpNpdfWMyvm2jKl/
 Vw2V2tViJy/xOgfSxPkYkz3ulPVqvQYWcx69pr0Z4mV2PO/cTWsQMrzqj2uqWotpbzLW
 GCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258393; x=1768863193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XNdDIfwnqdkqTT9HrfGf4W/wlTOS+i1k8CQmHo9TELo=;
 b=S9X1NYE8sKXGWL0zxvP9tCCQQLKmGIrPgFwR8grzZ0cCIgMhg0DTLlLPRtG3smxZ35
 5yqHHEcYewUhaEVp5kaJGw9HxUaSLNsAXINS7GWLxs6ENEem7++pL4HCvgS/AiQlDq5n
 JwkxJQ7lYZKbK0y2wVx5KXsn64hxZ/zL4NoK2mv9/NczbB05h4ETDY13eJmwgxnDmL3p
 ERP14U0sJeTwAlzSuwBGSWxyCFxjnb933EDGXyshhgCmFAvg5iuDjDPtOAJg3wZd1kCv
 Sppe6Wjk4r6CXf2OhSchtYO+MpwSkenYMxWlRUu7eo2C8nbz/EY3GDuZyDdcVs8Lyh3c
 ToXg==
X-Gm-Message-State: AOJu0Ywi2qh7MimgQ0rVle1cqSByAKxbgUDeuKMYAd9EWsynL/NgfLZW
 xK71FFvIOBBl/hRk5I7/PeuusHJuAzeGpG8nTj0MxBRTlqFuVwTeaZ10tedpjDXkx6Cxezw1eTR
 cNtW47Z8=
X-Gm-Gg: AY/fxX4nocQWOn9ZcJ1cDgAkCAXLuLrnPmc1auUmV8quWeObXe6jXuTEtpZvwI1796v
 TKhm0L7BYZqGL5XD9HC+lkZst3TJ5XPT8uxAARYBI4UlKAMjogj1WUqwzsA238Oy232/lRl7tpp
 XWSLn/36+TiznVmBfV3wcFVFRM/umxeSCNT7C5hSF5vncYXKnck157CkYpuC8wzVy3rGmDu7RFr
 pTX3KgpG97wcgxH/rhOWwVo94jmY4uIWVceGmLvvE3Lfw3xv85YpvW+Oo7pJZoQdMUi1lbivaHR
 +nhS5Oak/8Kt9tg0VQsuELPSB+/0bKPPB8urwTcSUVeuAoxL2rxucezc9Ls9KV209oVXcnplad0
 /r1/ILdrBzDMru7pZJJmjImw9BNTakF5FQOdsTo7IHPMCkABWOkbeP/ojIW6Xk1Uj55pMDhSbEc
 ndrKoLzqd39CRLAd2Lp3y5vRRLKivzhb0iR8q6eXKE60q9EHEzf6tj+3RM6J2odjN9hA5wUoo=
X-Google-Smtp-Source: AGHT+IGF8+R301rd+at2P6M8CZz0Ds8pvnA5GcBZPIMwpX/0QQPIUESY8Ou2O+GYFs9/BBX9EkKlIA==
X-Received: by 2002:a05:600c:8b33:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-47d84b19f5emr204553145e9.9.1768258393472; 
 Mon, 12 Jan 2026 14:53:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm392475675e9.6.2026.01.12.14.53.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/61] hw/microblaze: Build files once
Date: Mon, 12 Jan 2026 23:48:32 +0100
Message-ID: <20260112224857.42068-38-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Previous commit removed the last target-specific use in
hw model units, we can now build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106235333.22752-7-philmd@linaro.org>
---
 hw/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/meson.build b/hw/microblaze/meson.build
index bb9e4eb8f47..d8e7dfbe0e9 100644
--- a/hw/microblaze/meson.build
+++ b/hw/microblaze/meson.build
@@ -4,4 +4,4 @@ microblaze_ss.add(when: 'CONFIG_PETALOGIX_S3ADSP1800', if_true: files('petalogix
 microblaze_ss.add(when: 'CONFIG_PETALOGIX_ML605', if_true: files('petalogix_ml605_mmu.c'))
 microblaze_ss.add(when: 'CONFIG_XLNX_ZYNQMP_PMU', if_true: files('xlnx-zynqmp-pmu.c'))
 
-hw_arch += {'microblaze': microblaze_ss}
+hw_common_arch += {'microblaze': microblaze_ss}
-- 
2.52.0


