Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42CAC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXM-0006cY-9p; Tue, 10 Jun 2025 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXJ-0006cB-Vh
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXE-0002ad-AR
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so35100475e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560218; x=1750165018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BrH3ucC8SZAZIldmLWTeR9n/b3KT5QterWUvdSwkAc=;
 b=T0KDyOgJNtWTafoN1DcwLYyukKLmZvnVpDzYCLZVIrEKrleBTgnAgultD77P6MEy6A
 QaubLymUyvfdhAn9duWPMOjFx2hILaNOhmz9xIn4z1FbWRy5dCgtRnizTBdTjr233TVw
 fVhMUT+FLTht2TOq8lu5cmvSQ5s5Rlf7ScZxWWCjgbsfKPtQOS800in2xuAX/wBX37mE
 LGuVXRVrfVmJZ0KaAQPM9VqhBGrTFM6z+UIFzkAuTDHitIkIWq3X52MMG7kwPJe5s8fe
 5ciiJJ3jvHTm33JrwsEu/itW8NoozyuYuadeBn1BqnrFEXPChMzyAwzcEN46LFbKQbcn
 OuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560218; x=1750165018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BrH3ucC8SZAZIldmLWTeR9n/b3KT5QterWUvdSwkAc=;
 b=ItVQ309ImmsncLD3FOJDxLd/7HClM9jOFQHIZr4JU1QAH9mkOi5d0LmrSFJFOeWKZE
 428QlssVmOViXa6/tiaEYJPB1HXtJhWzv5wMDVZ+kVJhV9LYx0zWqLILRc81VATN326e
 mw7+5f+prUvbVEaAj81sBuOxpoNl0MPYaQnyJ4lsPxSYuVY4evDnpi5qcSaIFpiV7OKp
 0EnHmVXaHJqowCKk42KgZ9I/FpFl3+FtRrdu2HhCvYsxbVbZEn8Z58vpYiv8Z6GYmFLF
 APK/Itb6g18mePauP8y9OXAcQIcb8SMHDk5NgPLztfORv2TunXgTTQcVfIleMtz/LVgl
 V2Aw==
X-Gm-Message-State: AOJu0Yw7OTFKz6uuzUye3KGUuVdPt8rXMohyxxAKoocwCn8SMny+03cj
 fTmsW0Np+uY7eObC1yRIEQyJI2fRE+mgirctsnk0wKyn3FHhOiZVnPpzreWDVUqfiR5MpG1BI6N
 XZjL7yTw=
X-Gm-Gg: ASbGncsXAY7FOuyTyIye/QFU803qtebgtrOKUyQSLfk2ADynYq/blkf0iOXhyWMYw6J
 T2aDW3/Gx8BmndqXa5JnXI01vWmSoFoGRHNXusuXb5PR7ttmgEyi2bQPBegu4v7YwoTQtuu7c08
 +Ao84RtaPvtnX/4L/UbnOSIIifMy5kzwGcUmf5wL8OCxzK5a37ZjlIveTW8c8yuViaft1BrYyVI
 sLE0YS+Flqq01jdEtfU2SbXuoVfkU8dl/Y+H8BHT45fqncbvKkKqIdE08gCiiZzp6WaHxUhF4t6
 oYgjxJ5xGi6XRGBE5idZ+MbIqxcO8OgI/jnwlEMpxrOPP1lHPYjpZ9xrlR78nsO3xgW5GFrCmNy
 iPBJ92WJp+8iYM8m3buJxYlwkRzEV+qeiv1kYHT8kgw==
X-Google-Smtp-Source: AGHT+IHFif/iF++ZJM/kwhSj9EfjTQOc3HG5L2footbeUhTuwJDJ2WTGs2wHJTIQMtn4dZBnkL4ROQ==
X-Received: by 2002:a05:600c:8b4c:b0:450:cd25:e69c with SMTP id
 5b1f17b1804b1-4531de68e18mr24124145e9.21.1749560217869; 
 Tue, 10 Jun 2025 05:56:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464575sm12326362f8f.97.2025.06.10.05.56.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:56:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/24] hw/core/resetcontainer: Consolidate
 OBJECT_DECLARE_SIMPLE_TYPE
Date: Tue, 10 Jun 2025 14:56:14 +0200
Message-ID: <20250610125633.24411-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The QOM type of ResettableContainer is defined by
OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES, which means it doesn't need
the class!

Therefore, use OBJECT_DECLARE_SIMPLE_TYPE to declare the type, then
there's no need for class definition.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250514084957.2221975-8-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/resetcontainer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/resetcontainer.h b/include/hw/core/resetcontainer.h
index 23db0c7a880..daeb18c1ea8 100644
--- a/include/hw/core/resetcontainer.h
+++ b/include/hw/core/resetcontainer.h
@@ -20,7 +20,7 @@
 #include "qom/object.h"
 
 #define TYPE_RESETTABLE_CONTAINER "resettable-container"
-OBJECT_DECLARE_TYPE(ResettableContainer, ResettableContainerClass, RESETTABLE_CONTAINER)
+OBJECT_DECLARE_SIMPLE_TYPE(ResettableContainer, RESETTABLE_CONTAINER)
 
 /**
  * resettable_container_add: Add a resettable object to the container
-- 
2.49.0


