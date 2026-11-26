Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD49606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qEhhQNyK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaaT-0007uT-1y; Thu, 26 Nov 2026 09:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaaB-0007cz-CY
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa5-0001gI-NW
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so57552835e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795703772; x=1796308572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eC4yZ6tVjmzFcfPW+oquwB2kkMrMSem8XviYNNZQKvc=;
 b=qEhhQNyKbo9B+YMeC5eDNI6MHaSvxOy+4esIHgZT/FJ9X7bZJR8krZBOFz8dfwDn0u
 qUsqHKLsY3Uz9wtYvk52cZ8iHe5fktSMD9a0mbmSUKne/l8WAi/eAUFUMkxJOHYvftGM
 gudYa7pjzfMQGLafTGbL/dBsa56Rr+Yr54W9akQAvLMfcihOh9PNctc/z7ilYLiDBLKi
 ZYuAxK+ktnfemh9VveL9FDgxDfLZtygWmDNs5BfDzIzzVN9gdMAlwJMdeLqWGs9hSEYD
 GcykWtvFgZSik6DR9AoMbuK4rFlfGmKkGpDj6MAG7WFfohAoJ3i637cuVogL6IWgwnwF
 G/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703772; x=1796308572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eC4yZ6tVjmzFcfPW+oquwB2kkMrMSem8XviYNNZQKvc=;
 b=Imi3N0Jl0L3oiJwqOKy4dHRRheDBH1V/wh1jnY/k8zWvD7wwdRxWPfxx+RuBRo8eV4
 qoQybm68KhsRCmxAgz3bg8460F98BqFGNaoj0ca8hCl2bsJ+QoVoovqzCrTsOn5glFYz
 DHXtMDAxxcTc37jVYBZ09vvzdHimuv3iX3LC622hQQp8WU9M1u+mmH9vI8w5Qj8e066o
 iOfvbg5XAsVWksbBJnvb/09VzVTW2tkUn55uF5pExGG5njzrKMZwPYBlq0bPm26QzDvT
 JC5G7wNRijHEBxkfxxxDDHYgWoBUbG4OLpDVRQX9eryUS1AkeqfGgGzpR9O8Lmq/5qL7
 hCbg==
X-Gm-Message-State: APuU4Z+AeewWbc/iwQ73ca3WG5dFmKweuDsZonDSh15kjpVa8Celb4fp
 BDaV+WdSsM/nAqT07ovi41/BHxUMDSDFtZ37OTQTm3xbT0vqy3n4HkNg2kdqEGPjnCM=
X-Gm-Gg: AZFdTZdaYLbAAd6MdhHAhQASA3sLV0N1v+X8c6e0AbZ9yQvxp/8SLgSdDYJXttVaJeE
 dOtYTOq8xyCR8/X7KPLFpb38Azxtel63iSGW1nxvNGmHrTQtkSp7zznHjuV0nlhFz8XGCUzsx7/
 +qYjgjg7rpOdqDl5Y+POOuM2yunkdq+fFA/aUCaAXtfs0aTgVKoKI8GsFaYPH5hGcj/jfK5ANdh
 kpM19UgPO8mjtLUTBUTVyhypDWy4ejoV9lOa4cCsgTzKRinXK8nk+fuz2krf/8SIs4INUaIy/XH
 qXZyFK7gG1b5qIzG1k/9H8fFLLXO3lPc0lUkRzRUkyXa1qfS/fxuQ2scowMgQLn3RtL6tuRJvkc
 YtrB+Tr9jaYo8v+qRNfzPTaiWlv8v0GVZ/fkQTX27k1h9VrTGCbTosd+UHAWk1nc3jM/3UYvdaS
 wANno0DCvDpYNxgNGEBNSbBavj8VN+dpXEj6wv2skyuHpiU4xcqYNPm8NJrf/IB4R9nFLsI2dIe
 SeSwwExqgec8q2C0YFO0jAJElGO7XX8q376w+12fb6zAsWa+fCe/Etr4iOi/brQ39A8jte4m0GW
 u523Xq2ORPN1x9fZ09HndTVHZ6DL1g==
X-Received: by 2002:a05:600c:470a:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4bb8893071fmr428405395e9.24.1795703772069; 
 Thu, 26 Nov 2026 06:36:12 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm547554165e9.1.2026.11.26.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:36:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15BFD5FA5F;
 Thu, 26 Nov 2026 14:36:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Chao Liu <chao.liu@processmission.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>
Subject: [PATCH 6/8] tests/qtest: remove unused prctl/procctl headers
Date: Thu, 26 Nov 2026 14:36:05 +0000
Message-ID: <20261126143607.2374676-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126143607.2374676-1-alex.bennee@linaro.org>
References: <20261126143607.2374676-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Brad Smith <brad@comstyle.com>

Commit 6cbde91a2758 ("tests/qtest: use prctl(PR_SET_PDEATHSIG) as
fallback to kill QEMU") added <sys/prctl.h> for PR_SET_PDEATHSIG on
Linux, and commit 49e9f8644b03 ("qtest: kill orphaned qtest QEMU
processes on FreeBSD") added <sys/procctl.h> for PROC_PDEATHSIG_CTL
on FreeBSD. Those calls were later replaced by -run-with
exit-with-parent=on, but the headers were left behind.

Remove them.

Signed-off-by: Brad Smith <brad@comstyle.com>
Message-ID: <awPwS_xYsv2v9oKu@humpty.home.comstyle.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqtest.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3b..f39a39b85c7 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -21,12 +21,6 @@
 #include <sys/wait.h>
 #include <sys/un.h>
 #endif /* _WIN32 */
-#ifdef __linux__
-#include <sys/prctl.h>
-#endif /* __linux__ */
-#ifdef __FreeBSD__
-#include <sys/procctl.h>
-#endif /* __FreeBSD__ */
 
 #include "libqtest.h"
 #include "libqmp.h"
-- 
2.47.3


