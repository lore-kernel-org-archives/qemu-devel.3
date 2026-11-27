Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A6606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oEQbNN1L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxBw-0006aQ-R7; Fri, 27 Nov 2026 09:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBu-0006WT-8u
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBr-0002TA-2Q
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:45 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so83129075e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790681; x=1796395481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BcjrLEb1/iZJUf9MfpKhHmYq1MI4TCqecTpvNrlC6rw=;
 b=oEQbNN1LzUSAWYOagnmU6TSs5p9NFYuNP+5Cbm3q2wcZ7be1tUauXsz6BrvNE3xcIW
 14li4Ge/oC1SVUUI3NGGm5wkezZLwU/prRY6X6kqfrrH7K9/2WwgQ0G+UB9JqWON/2vq
 9eaD9J+jmgB8XdKkhHlxcNTQhzQy6ZQXlA1+3Qn+T1TT0aM12E2QDUpz0v9pDjnECYFw
 KJ8uID1J3VIJe4u24fzvPkM2yLvHQDLDMaS8nfrluJOgoylsyhXF5BeFmfrAvqJSIRc3
 ZX//VM77i+iL48KlJe3e0p8sT0imOBSeTpQ0gfpy1FzNQdXhMIJrJtRrCKUmU4nwzO4W
 Z7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790681; x=1796395481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BcjrLEb1/iZJUf9MfpKhHmYq1MI4TCqecTpvNrlC6rw=;
 b=sB03EIasIiCG6/q5hLw6iD2cimQHfpmn/MfUW/3Yd5xGZ129jerOV6afm6p2MCPT6F
 CBCHsHl2T8ohF3Uu/ck8tQIz7MFfdFesFDbSdMB1HI740DLiHkR6cb6wQ8naUcmMEUwR
 su4J4vdzz/tjwsXPbL20bZ6txu9QON+GOjVUdDbuMgo2S6WCajK4C77EMWttkLK0Yqsj
 njWx/l5tlThKMhiFRjCdXzbQHRx6aCtcssHxt02dkEiORULpmRPoypZ5OAfLYG4pAPvS
 nKX7chIQlj+EMR6Fle+u9UEu10pYkTZgFoI4er1XR28Js9Ukm1vPFRSlQQbWSaIHI1dD
 Ma2Q==
X-Gm-Message-State: APuU4Z87Mgxl5An8CrNwqU3r9INYEEVOZImpUaC5780bJySIAOMi4uoW
 TlNxADAXma/kssMpSvI38PC+j5Fw+ogX6f9o/cLgUlLf0xTVEF6fEAVzEuBZFVT52rJd8N6HlgZ
 eRgNZ
X-Gm-Gg: AZFdTZdel5NBuwOESB9Mhs2fIofKihejEL0vnRg29LXmWEjilyANnaC42fmX2se50sr
 REliLEF/PXPeakh7NehFaeAT3viE1MtfTR/JD0wfXnotPzVHW0FEcECtvQwB4CN9PybfMEcYgJw
 /wenl5DLenh+bpiPvs4aPmYgmzzN4F13T39gvYoRSoS/o776UxmEoNaPoKUeBXcvRqLXPHAMA5a
 a81gOwMstBwGwxZgJtvJwhQotGgewGQJh0IXqK8Ikej0haNoOfE6cJ9GaAD6404LEIaY+TOu6kI
 bIvEYx3Re6cnvPvftbNELabozhpBmC7z3XFNn6RcPg2ESCTeaneHOJ/ueK2RMifsk5xj6HdR11x
 YVwL3gWuaB9kVgh+crFFQPFkp2njqgEoj/qu0HR/rpIE829L/YCqk4TxqnH/lybOfYWcTaSdZsn
 79+ZQScZQxDiAiYv7FhxU6g6mvqB1YGjt/0Mck4PP9X3P9EUqCNOzz8b0zq7xoeelCxUBx6QwrS
 l/Hd4XyxkKBTjz6j1MNkwz8CHOUbSft8yuSMMbMiYUT+zozjAahghpVG/VUtZBc2wXWhLeF/8wP
 8S3peQfwldWa9T8/VJ3oMlHMb1I9VyK9KtvbEOEqBAhmcKBRs2HYhKUysBrqugnoxik+cCNzUdT
 CvzXdZQXB3Ta3TRZ8E8FEeegGhYBB/isU7nSJ6Q60RZ9k2CuQqz30kcA=
X-Received: by 2002:a05:600c:6219:b0:4bb:a5f1:fc5f with SMTP id
 5b1f17b1804b1-4bba60168f3mr176959045e9.26.1795790681606; 
 Fri, 27 Nov 2026 06:44:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm216862975e9.3.2026.11.27.06.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:44:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH for-11.2 1/3] hw/misc/mac_via: register VM change state
 handler once
Date: Fri, 27 Nov 2026 14:44:37 +0000
Message-ID: <20261127144439.627586-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127144439.627586-1-peter.maydell@linaro.org>
References: <20261127144439.627586-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the mac_via post-load function we register a VM change state
handler callback, which is a one-shot (it deletes itself when run).

However, loading twice before the VM resumes means the post_load hook
adds the handler again, overwriting the old v1s->vmstate.  This can
result in a use-after-free on resume because the first-registered
callback does not delete itself (which is permitted) but the
second-registered callback (which is not).

Follow the pattern used by vapic.c and only register the callback
if it has not already been registered.

Cc: qemu-stable@nongnu.org
Fixes: eb064db94ccd62f054 ("q800: add a block backend to the PRAM")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mac_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 26ee230dcc4..dfc7d304ffc 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1192,7 +1192,7 @@ static int via1_post_load(void *opaque, int version_id)
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
 
-    if (v1s->blk) {
+    if (v1s->blk && !v1s->vmstate) {
         v1s->vmstate = qemu_add_vm_change_state_handler(
                            via1_postload_update_cb, v1s);
     }
-- 
2.43.0


