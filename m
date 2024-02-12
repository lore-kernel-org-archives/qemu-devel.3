Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C6C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTQm-0007sN-JR; Mon, 12 Feb 2024 05:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQk-0007rA-CQ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:54 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQi-0007cy-CH
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:53 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so1986276b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733251; x=1708338051;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KshG4XdFN/TjxiO4+Kgrx0bCb7ZBpfjPIzIbQ6JKIZk=;
 b=2aVHRMKaaAIZK4q2K9emgXnXBMMwvxlelwlLEQjjIFy1qnr0UT2Tz+dWVDsRO5CsIJ
 bFrm0GZzMlulr4yyUceGNQrMwePfc8H6uKFxSV8ftNDIMIYsi9LIWNwrp9HUk9o+3RUN
 RYRcaMsFW66X7hX+zahrsJgBQ9f1OEL6O3kX+O0mFh2j8x1PCAIr4IFVjSVmgWVtKBKh
 56XhaMzU0BPFgDGyiLEBuOjuCsntGa45LM8z+IxGUBWn2EJVslFRQE4dKQGR4uCuYK2l
 ivj2omm+ITMztHTRsNdANj/D9XxAxn4uAWxpLIvpUVnWND+9DKcpnzlSF1HY50wvd04S
 Ck2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733251; x=1708338051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KshG4XdFN/TjxiO4+Kgrx0bCb7ZBpfjPIzIbQ6JKIZk=;
 b=nShKJrE/1f8w75cD2jJO28Br42SqjwfJXc5+DM19Wqw9ULQLuzQcK0w0bJQ2AZw/E9
 /dVSxi3tyI20i+1vucfonRH6tmvFKprOxiWMSxYAUZDg5lcX72x/QK/ADHlve5LHKKof
 Mn8m3y3iwR2Qg6pgr4YWaLknnL0P5acohSjLPKxr1zSj+pRPXQNv8vFmjE40TzKFEyKI
 XcFZQ+BEuZxycXPfeASfIqICQyueLsrXobCtiw7KgIs38nqq43S3KbfWSEEMBU1M3CQl
 CeD/cY/AUVJcjAkKPiFCMVQFGJYPnk+7a8fRjj1qaqs4i8B0PasKDCyVOsmJuM09BVWe
 h+TQ==
X-Gm-Message-State: AOJu0YwJs6gXJwB0oi664Rp1kw2kGf+MNhayZm9k7GvUQrukXTeoO10b
 rq9Hi9vFENkmyqUJX1hcZauaXItcEErwFAGd+dRBw1RClfvsdv0eBtACA522Rn8=
X-Google-Smtp-Source: AGHT+IF+iSnjUkqDG4usBHCkhbfjWBOicQf+jEV/FNkn85K1176vGQB7Rd6r9Cs9e+ON+yIw7uDs0w==
X-Received: by 2002:a05:6a21:151b:b0:19c:a389:dd6b with SMTP id
 nq27-20020a056a21151b00b0019ca389dd6bmr5889904pzb.20.1707733251081; 
 Mon, 12 Feb 2024 02:20:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+vCqF2ZvPF/wjSExbO+MtKgLXs9rTldVc2iX1sWklrBG7uxJMPQdaOrUdC/A5ztC/FW8JsQGJYFijHRgPGXpPHguNRgfbq5PbxtmpffadFTel+BGxh8i2PgkwtXXTWHSsdbths0HaPwplDfAaGdyD/+UrzI4N/E1qBQjlBZr9kMkOmGwE6T9W/+v7hdD4Fhi1Sqt0ZaWWp+LvTdMguMysBifYTowmhikY611WqACJR68imixZh/CFORHM1vTKnUTAYEtdUvdWHrxeC84G93F4jmSUvLInXt2tr92BJw9bHBT0PzexW9kqIxmCmvqn1DjxVabU9XEH624UBTGkUxY8PTN0wEp14xnmCIfI0lAjfYOHRbViYmlDY5akNMx9w7lPfJiT+0V2FCzImjPT3aZQqH8sw5opqms68qs26JfcMIUUPuJ4vv7/NWcho+U=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 ff21-20020a056a002f5500b006e0737f2bafsm5166002pfb.45.2024.02.12.02.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:20:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 19:20:31 +0900
Subject: [PATCH v3 3/7] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-reuse-v3-3-8017b689ce7f@daynix.com>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
In-Reply-To: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7fe06715c4b..44178ac9355f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1010,7 +1010,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1044,7 +1043,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.0


