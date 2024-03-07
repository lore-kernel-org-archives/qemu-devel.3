Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAso-0005Pc-Dx; Thu, 07 Mar 2024 05:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsk-0005PL-Rh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:46 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsi-0007E2-3j
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:45 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso5851835ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806902; x=1710411702;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ahxRZ3SD7lLMx3muKeGeJx9aSeKYvKbViQJskOgE7S0=;
 b=I68rP7CTVuDzdr6/nK3QXKNzvVmtB4U/KZXVXJulE9ZERAL+HhO2y84rrIvr6T/4fj
 3rdSfd7Mj4pSkLcfPVB3aTRVU+ic63GS4pNHqGnr+a1gjmY9Kt2VDzTehlWdOQ+Es/wU
 aJTvIyMkIPpJtuapQag7o46qqFlz56+Putc8ODdcMEfAOPrrP/eXdNcpxYMxeJPMaFlc
 kg3AcSXGS7Wr54xPbIW5wgGiHb8jgFM7CSWhP5mK7HfCWsRGjib6JejWerAPqnySrMhA
 WyEh+Z4oTwqSIBJTV3H4NhCZ6ek4nyvKqNAP7BQtd4MxBlLnRU5VD1cwyWtqEP52afvT
 WZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806902; x=1710411702;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahxRZ3SD7lLMx3muKeGeJx9aSeKYvKbViQJskOgE7S0=;
 b=HSS31Pt9/QWoMt0W4Tv113/mNn02jDhh1ENC4v1WMLof3Jzh5EsVak8aoX5PLNEzie
 noi7cFDgH7U4/FEYaFVOIEPUnupAGyICfEFdR5O54Z/ANsDzTzRg+6GaMHfUXuQNoWWa
 inXLp3vdhuqvFaFAzIVlijmayV7yrH6FAY9qc9ZOe5uw0J2bRUpT5Hrns55cb/1bZ1KT
 MXf+yPy1c7h6cW0vOUGqPnumjqX31r/jGcGj48c900wCP+64OgvOUGl260aEEx+xuHRy
 H9o3DFNDjAFWRswlEHfuRjOS/TVHPN+ogyJ5VI/AMhDJykK4RSlgurQ7hr/KNx9dAdxk
 TTTQ==
X-Gm-Message-State: AOJu0Yy3ETY4y3ALFxI9ViJK47G5J9jCFPvd8OoKK9dw45jqFPvmWI+N
 Mi+I8IgNTSulc/mBqhiOyEjecm+iNDTi+glezx0rUrBjgcGDTbbrbA/U5uy7oSk=
X-Google-Smtp-Source: AGHT+IHEYROO8JPIUI0EFZv06Q0m+0BcIE5xz/NFQNC6OSq/XBAOUnCiH6OImAU/5yaQzOLvy/tQIg==
X-Received: by 2002:a17:903:1104:b0:1dc:a40c:31c6 with SMTP id
 n4-20020a170903110400b001dca40c31c6mr8261517plh.25.1709806902441; 
 Thu, 07 Mar 2024 02:21:42 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 s13-20020a170902988d00b001db499c5c12sm746733plp.143.2024.03.07.02.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:58 +0900
Subject: [PATCH v4 15/19] MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-15-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65dfdc9677e4..d25403f3709b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3583,6 +3583,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Maintained
 F: contrib/elf2dmp/
 

-- 
2.44.0


