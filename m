Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07801CD37AD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN48-0000pX-Op; Fri, 08 May 2026 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN47-0000oY-15
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN45-0005Nl-A1
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so1409623f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253871; x=1778858671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdv7iLUiyYux6vdv4F7nLiGDM9BvBEVURyYAlirext4=;
 b=zsRysIr/Sw0DVvIiRke/t5ybsNV4gac2uQPmHCxgK0fD/6jRE8hsaTiT7WwuznANeX
 Va983L11ine/zYmTKrsYoDZVO+h7ajY3I9NycNtRQKGC5KuNzEnyevNg5DV8wAiU6VWj
 xA3Fd3w8VwzWkQ0FmQeMl030rFNOSuMoPwzkkWAtHorK9YgMyvlR8MpQqGkJ9yvbdeZt
 gx0ofPrmrN4H+WgwNpfR9+QopqBb2evCXEuIiOoOyFoDS5OWEn56OQKrL6nYdkP/J2Ot
 hVlN86zuGVratCY8OSFV/1g4RgiY6tCRKAC3lLXNc1UwX20/B6SZkRqqASQB5TwomTxi
 50Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253871; x=1778858671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mdv7iLUiyYux6vdv4F7nLiGDM9BvBEVURyYAlirext4=;
 b=SRXcdg6b3EoId4JC72TYjaWeIiBZItPN60MnkcSLQAf+1cxqOkl7BCQ84mTuURurMy
 mSYXEbb09aSkKQfPHs3vwxW3nLzu4QJrUcgEFFPI22eJYnw2hZ4W3VF93QwbP5vrQqRG
 N0F681sb9IGxMjAujT/nCSg0XwBxhXRSsfxgtGyh7tXKwgmjBbHvIsLK02IddFxz6j/h
 8lz3463GKgEeCcbo1SRAWxwbitTe5vPn1i/rZTAceh763nEnYNMfLHKfeCp6xFgwe3xA
 eiazUXiZWshvYQJ/KDXIpUEf6lPRdCM9yl/hAR2YP055LS4nGQ3uRHFtW9g8uNoBBAY7
 5atQ==
X-Gm-Message-State: AOJu0YxyVNNF8GRGup6iamsj6cqyYjz6lW7kPg67W1RmlJhfZQ8B8M/4
 ow89OU0sx3TvSiCR/5ccd7nzgCXAJ2W3BsfAHEvTFRyH4J/r4SPH/gpPOBbOUsPbSTvtEtORko5
 +27Fy
X-Gm-Gg: Acq92OFqt2iRP3GbsQmg64al/bLwWS1eXjx0NNvEr91bfOCSlPTuexrtppiRhnWKqrH
 5hZnr0XcXi8jdPOXzD5QQUa4R97vGClTpCT0Z0MiKWXo3Efe35l9q5xqyTYJZRzVvz2ZnQmSyTg
 hzaQaUDqbP6KfY4dmYcVGoKZof0LEGq2XBhMZNVfQ/YAJQJPbA8FcUAh3jElQNp6ossr/9oMPNe
 PW1gq01oDNPIR7ABWG3OwUuskHImkVFika7QzEewr+6W9bdaWYRZqgIk2d41Gp5h6kpvWKugtdl
 ocCCp0Kzrga+F7QYSsiB3x8cGtPfJwm0Nr1hgvZSj3m31cGaWo7QS3TICd2lL5hyGDMwskCqW3G
 dCh1410DoRpikHl9OaBIApCTTwGFHm2mAadFtAHRMaM3/4+zwhTQdLFQm5XlcfVl4y+402Ukn1R
 lE2OppQsXO7yDoGQKAiUqxh9PBsJzAuz5+hQou1WFESkMY+ghaNcn/jv2YVdy9X4I7LeYpwvKcd
 EImnv1a4RAKR67nRRyhwk8TWzmuPxU=
X-Received: by 2002:adf:e00a:0:10b0:455:4695:92d9 with SMTP id
 ffacd0b85a97d-45546959361mr999866f8f.12.1778253870711; 
 Fri, 08 May 2026 08:24:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/9] ebpf: move ebpf skeleton source to ebpf/ directory
Date: Fri,  8 May 2026 16:24:20 +0100
Message-ID: <20260508152428.2648560-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Currently the code and makefile to regenerate rss.bpf.skeleton.h
are in tools/ebpf/. This isn't really a good fit, because the tools/
directory ought to be standalone tools of the kind that we build
with configured with --enable-tools and document in docs/tools.

Move it to ebpf/bpf-src with the rest of the ebpf code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf | 2 +-
 {tools/ebpf => ebpf/bpf-src}/rss.bpf.c     | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf (96%)
 rename {tools/ebpf => ebpf/bpf-src}/rss.bpf.c (100%)

diff --git a/tools/ebpf/Makefile.ebpf b/ebpf/bpf-src/Makefile.ebpf
similarity index 96%
rename from tools/ebpf/Makefile.ebpf
rename to ebpf/bpf-src/Makefile.ebpf
index 572ca5987a..7ed0e3b440 100755
--- a/tools/ebpf/Makefile.ebpf
+++ b/ebpf/bpf-src/Makefile.ebpf
@@ -21,4 +21,4 @@ clean:
 
 %.skeleton.h: %.o
 	bpftool gen skeleton $< > $@
-	cp $@ ../../ebpf/
+	cp $@ ..
diff --git a/tools/ebpf/rss.bpf.c b/ebpf/bpf-src/rss.bpf.c
similarity index 100%
rename from tools/ebpf/rss.bpf.c
rename to ebpf/bpf-src/rss.bpf.c
-- 
2.43.0


