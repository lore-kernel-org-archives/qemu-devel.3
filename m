Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5CBC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 22:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdHUY-0002eZ-7L; Thu, 22 Feb 2024 17:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rdHUX-0002eG-7A
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 17:24:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rdHUV-0003Cw-Pu
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 17:24:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso1292305ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708640670; x=1709245470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aV4SgQZuDXWBRvw2n8ljUcfJ5DI/n/OkG0enno6mss4=;
 b=YuJf5YE6DIYvSljaoegdnCIXW0X7IU9/mZs1OJBGrjFI31bUPjLpEcLiJ/HFmpQPrt
 HRV27u8AdEtDCyQHVp6GR012goVXuvVoL0AH4wrHhwaAygGU9Xrh/dfjiCwSVr4EAMxc
 14CkHjK7ltwW4Vi9JIsIwvx3invjgE0Uq+nshwBqigcdOmBnZt7hXuWGHBXOXz9svgWy
 Js0GXPtYQg6l2YZrlPZ705T1Hk++ssZDz4ZJ11L+TkhdDAdXChI0kWQPVBrdqW/iToea
 Ly+WME7WCcfzDudGDvEYpNq3W9m/pRGVpWxbwA8oJ5G2TyOzX8kkfqollOtI2MiC87pP
 sRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708640670; x=1709245470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aV4SgQZuDXWBRvw2n8ljUcfJ5DI/n/OkG0enno6mss4=;
 b=dNrj/oi5hrNFN3VK5JPOGV5ikA1fN5Dbnbf0+PXvuSTyEj2O+ixMiDC7AJY4LUcGul
 913zUmg9BMnJN/ECh107sqfTsmsgO/Mk1+32IG+cbITEkEX47orbdp/6mSf0l8Z3toLk
 cMupiWRBQS5agt22DngrznvXgQk1i83tKyPp0c3dx8rSgnZBZHKV0i53hQd4+mv0K7Cf
 u2BBVKIOK5jao5A8CcnYAygnhfWa3h5UqnuszDZYMqMztoDF3i9r+80uA/bsEtBoJX+Z
 dxucUV1U4kzap7z+n6wKErCVuxhxKy7UV8bQcTIfza/SvSgOqI+DOF4mC3B/kpMSh7bp
 3VnQ==
X-Gm-Message-State: AOJu0YzCbC547uGdrE/a6OpfuzdF5M+kZ5B2uJreQuWUrKGX/WlY850W
 OVxVxF5fO3W8Dcsf2/NrSg6Z2Dt6JON4WjiGhDWsJq8pefwcFS2IXkw1RkzhFgfCfKo42Scbj4d
 rHeo=
X-Google-Smtp-Source: AGHT+IEHDHhXrjOaOlv8eYLNQVqmtLZFZvkRRRNMtoPIYbR1t1kj5OWTJB5SJcgtpifQ0Cedc3YFMw==
X-Received: by 2002:a17:902:e74f:b0:1dc:19e:3d9d with SMTP id
 p15-20020a170902e74f00b001dc019e3d9dmr246112plf.30.1708640669975; 
 Thu, 22 Feb 2024 14:24:29 -0800 (PST)
Received: from amd.. ([2804:7f0:b400:285a:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 ji7-20020a170903324700b001d7057c2fbasm10457210plb.100.2024.02.22.14.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 14:24:29 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org
Cc: thuth@redhat.com, lvivier@redhat.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, anton.kochkov@proton.me,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH 4/6] hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
Date: Thu, 22 Feb 2024 22:22:16 +0000
Message-Id: <20240222222218.2261956-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222218.2261956-1-gustavo.romero@linaro.org>
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Because now there is also an MMIO ivshmem device (ivshmem-flat.c), and
ivshmem.c is a PCI specific implementation, rename it to ivshmem-pci.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231127052024.435743-5-gustavo.romero@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/misc/{ivshmem.c => ivshmem-pci.c} | 0
 hw/misc/meson.build                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem-pci.c
similarity index 100%
rename from hw/misc/ivshmem.c
rename to hw/misc/ivshmem-pci.c
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 84dff09f5d..4a9369082b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -39,7 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 subdir('macio')
 
 # ivshmem devices
-system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem-pci.c'))
 system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
-- 
2.34.1


