Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAA0E7FDE4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Ni-0005fs-PJ; Mon, 02 Feb 2026 16:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mj-000543-PD
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mh-0007TN-8l
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso104327f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067305; x=1770672105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h8AH44wPQHZpOUXhv2UytKh40nLP9b1Xn9FHzgyG/Pc=;
 b=Yj38lTkS+KdBl6MGuuP2o3yVehsjM726yYKgEUzlte2bispilBw/dFd2JzlbO0MlBB
 8T8SUPAk4Xeil/wXyvKf9gCd28blRmDCj2FfvZ74SZ+fFDr0etmzu/bCapx0lPjwVSbU
 px9rnJl3paAHTR3OIKOpCApD0226f9yGVKFK6ytMa+IJQ6FlhAd6w9Oju2mCHhqli+xg
 oYuvD083Sieb8U+tOUmu4eUbB45yv3LMbd8Y6ksr30JPw9dOy6yd5x/DS19Xc3wclro/
 u3tUmvhM1RP6lh6G2Wla78th4W+QSBQqVH4l3FJzycXC4nrp5EZB3bITqgtJSV8Kky+l
 0pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067305; x=1770672105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h8AH44wPQHZpOUXhv2UytKh40nLP9b1Xn9FHzgyG/Pc=;
 b=fKjpQT0ktpy2tH56V5Sub2ZJJOVitXvzjmok6qBsDFkv1Tl83g3dAiwmlsXu5IT4yL
 NLIaeJruo/1NPtez4RwZWRgSKK1BQGMryaWeHlsYpQPUs9EczlXHVOEBtSQyLayefM2i
 SjgZL6Be1SWaqomWCGRuptEzULYVVInQj0uZQXBkpV7QDM9ch1CWlQJpayMUIKC+UPTr
 57+Ld/jkKK3lgj8HWwarLuMz7b1SWyCNn3c1gssfNRhu9HufPdIRej6LzTNLZeqGB/oe
 XN5gxsk/d8ndLnEJ69lGlCsQ5TUuhHEubcJOfXJDcGRVNUEv75aqCReA9jIy9orlZmea
 Ee9w==
X-Gm-Message-State: AOJu0YxEndjJ6aKoUXRXxbiGof5uQrUjAFH07uy1TbFdu1K3CKyQBggH
 dlBO/Nh6Jxc1BFLTZxWtQ3qI/Witu1H25px8DVfMWU26j8r9hUn0QMeY2czWRR56p60rPINNChg
 nb/JFOuX8Qw==
X-Gm-Gg: AZuq6aK094du4Bt+6fyFm+gnWMP6WM3bzSAleEJOSa9l5C7sqdlU43nt5v12kDgpKYU
 kyDngXsCzTy/uAenPhqjhWGzRmPhwDLcRJTUGMhdfY4KAWxthLeQOzolTUVJMEiULcVTb7p8btd
 P1j0b1bUzmnEd5Jog88DYdwhsLIu5N1Fkv5jgB0l3HJsuB8XCN5TvF3pBOdUmZUA95+3WI4ns/R
 XI2tpRyVFk1b6P9+f8lsOeJ7cE57fHH/IcWnO8znPEeknclwSPa5i7jrMdlRj6qEGtbcerNU0yT
 ++5uZZ8dGgbDwE94PWY0M1aJB6Huje0HATaml/M7DY4dDcumH0l9zYT7zTuUp2eIMhAYFJm2ZNB
 8ZCIQpLLahY6RluTm2uON6AdoIcQh+JXpn5cZ/Q4ENFcvO0TXJghqCbwI8Y/2TWSOTAFpc8blg6
 Sa/XEaMv9jllpVIVJvCKEdwfJiZjS0CElj2S6FZERsi7Idd05Xqg5uYeLYtBj1
X-Received: by 2002:a5d:5c8a:0:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-43611427af4mr1281296f8f.22.1770067304885; 
 Mon, 02 Feb 2026 13:21:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e474csm45486985f8f.2.2026.02.02.13.21.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] system/physmem: Remove the assertion of page-aligned
 section number
Date: Mon,  2 Feb 2026 22:20:15 +0100
Message-ID: <20260202212019.94205-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

From: Jim Shu <jim.shu@sifive.com>

We don't need to OR the physical section number anymore since we now
directly have a pointer on the memory section.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260128152348.2095427-4-jim.shu@sifive.com>
[PMD: Reworded description per Pierrick's comment]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index d17596a77fb..2fb0c25c93b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1323,12 +1323,6 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 static uint16_t phys_section_add(PhysPageMap *map,
                                  MemoryRegionSection *section)
 {
-    /* The physical section number is ORed with a page-aligned
-     * pointer to produce the iotlb entries.  Thus it should
-     * never overflow into the page-aligned value.
-     */
-    assert(map->sections_nb < TARGET_PAGE_SIZE);
-
     if (map->sections_nb == map->sections_nb_alloc) {
         map->sections_nb_alloc = MAX(map->sections_nb_alloc * 2, 16);
         map->sections = g_renew(MemoryRegionSection, map->sections,
-- 
2.52.0


