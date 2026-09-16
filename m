Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F6CC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ofi-000221-1k; Wed, 16 Sep 2026 08:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ofg-00021j-7G
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:23:28 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ofe-0000iV-M9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:23:27 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 d9443c01a7336-2d8fe517774so10555115ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789561405; x=1790166205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CUgiAVZYE0gTOxSveNorl8DwUXSD+rKeSlpQidEFSGY=;
 b=HllFVlDLCO9jA6MdTsaXFBMgjKSjDSpIh5aLVm5x2TwZ6vKaB663dmcY2Y8rVO54A1
 0hgU4Fh6mWRRv8sOXtfiTjHr7P7n3TdR/IBFxYI1EPX3kaggxEChutZgVKQXoRU7XkRy
 bIboe/Eu9dUUxTfXkkd2ZxJYwxX/ArBx+8hYw76O/TkBOUtB8oUVPJYDWFAByTMhPvU4
 C+aBawwsPSy3UF8M6ZiUbUi0nHvsj0fZjlUkv4GlZ+Pr2bKenooLpO7wu8MPEVikXh3d
 7xt0UIZiINWDF7DD5zadw0sbZQnNN+ptj1GPjBig9wFBGsCP1NQs3Zc+SmppGldOCGZT
 kBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789561405; x=1790166205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CUgiAVZYE0gTOxSveNorl8DwUXSD+rKeSlpQidEFSGY=;
 b=eSIhOHwexZPN6vhnPLt9EvMvPla45KW6RWwiiTWnXGeHwADdZbcrhDkudsgMj6jB3v
 z0i3ELk8q019vlyyzZ+/MhHlWyAdRTXBhMdmIvAYrZ54t9mk3Ax/TMN9fNexTMj2pdeA
 kRuAcd5zCDEDssH9CP1pDZofzlgCesC9zfDD9KHRiPRQ9RRKS21VRT3DDUA5nWgsl5j/
 U7Y2pL8Zxg3EwrIaZbkUv3NzF5Y55I8THbkqb95SXFpMG4mUiM6XQOg4EzwVBHWCs4Ez
 aqmUgAaKk/zNLNsm44S7dPg6kBguOb3pUFZP2bJpui5o4WLKnw0jIhw0EUAFDJ/SmDjt
 5gGw==
X-Gm-Message-State: AFuF++lLRZ911r+p9d39NR7Ff6MkY0BYlg1yDG7QBUVpv6p6mtbvhjVF
 XpjE9iUuKvK2epOPs/LqEzlwaRFrwHYgLcFzw/HdXtcJOckDddV+6Ncxf4rXxeYV6plUgfnVpdA
 yARH3XLs=
X-Gm-Gg: AYBFou1pLtyRPZp0/csrOHOrMlkaCXOqRidekytPqd4ZnMKgNPfzDb7z4WloFEVDLMg
 Yrxx7viIq02dm+FHi2UUf3e/7xORpQ4vKEgO9Aofh3ZrbPFPqlzqjgeRpou1iDKk1LXbdJCx5Bj
 pMzmo6Svm7zB87bmuT/crpFtOy9425hZnKLuYe8H0Vfa70nJ31v0gJI3U1WGmUL1e3Cm8vDwtWt
 7h6lvvhNDXNI5+b0BHRLe45cLemH0x6ebzKsXYPCqahApcGPp/w3r4yVG1Vc85jzSt1h+OLmVJk
 GJwkShccRn7HY+Ju2gHapfVT16YsHt0yBMWrypMyDB6/rf/mWavnC/fh4Lz8D5O+v9r3rwoKBjZ
 OTxigMrRNzyZig0pXpeJiyW4Fj+k4hSGAvjx+d3SXvO65hz6GC19URzMUGLntfMw9Io1TFRZCUo
 notO2LHd8fI4mimec3ejya2Gxv8JEQE5dNG0XxSZ+nAKOqdEY37bzy5DoZ/mcRRkk0xB24STTew
 pedk5I=
X-Received: by 2002:a17:903:2f91:b0:2dd:9112:c4c9 with SMTP id
 d9443c01a7336-2dd9112ca94mr37143565ad.7.1789561404647; 
 Wed, 16 Sep 2026 05:23:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b0520asm8254656eec.27.2026.09.16.05.23.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:23:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg/optimize: Fix expansion/simplification of deposit
Date: Wed, 16 Sep 2026 02:23:20 -1000
Message-ID: <20260916122322.3224918-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Keeping the test case separate to ease backport of the fix to stable.

r~

Richard Henderson (2):
  tcg/optimize: Fix expansion/simplification of deposit
  tests/tcg/s390x: Add regression test for #4449

 tcg/optimize.c              | 29 +++++++++++++++++------------
 tests/tcg/s390x/issue4449.c | 26 ++++++++++++++++++++++++++
 tests/tcg/s390x/meson.build |  1 +
 3 files changed, 44 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/s390x/issue4449.c

-- 
2.53.0


