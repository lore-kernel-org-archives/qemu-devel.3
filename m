Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BhKyXbs9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMolZ-0001Rn-EB; Fri, 30 Oct 2026 11:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolR-0001QT-8r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:35 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolP-0002g1-Sp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:33 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-35b2c599f43so2023587eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793375010; x=1793979810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbe96r3rFQ24lWAUPaW8v3vfQNd9xEpQXRl+wvH1af0=;
 b=BhKyXbs90hlE/e6d0dG5voW8NPwL1TJxtnliZARRunhhVnvdaCsrVZfa+625v0L+nk
 pJWAQ2wb5TvJOmHybEIaswo6z9rZmX9ZnefEgWOPh2NORQbcgZoxMk8ZuyfyLQxzzJnq
 nHWdMumQnVGvuU0ieeBL5DPR+CotW//1HIvtjybli6y2pV5bLez8PgHpvdbLTYT2wnsy
 80aQWwYh4P1Iw1JV6fzIzjESSy2vhfyNJj0DuxsA/E7fEWO+Yh7MeUiMchiUHWp45Cwe
 44ob8l0LkdL1P8ne7TZQPh5hInPVeLs4ZE6RQLq6J5BjMtOiUxyNTW5vR+a0xoWg3lSN
 b80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793375010; x=1793979810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bbe96r3rFQ24lWAUPaW8v3vfQNd9xEpQXRl+wvH1af0=;
 b=IU/XDymp0xmuJP45jUhtpy/RLZqG41RPDn8bhGG7TQJelm/Pe5z6sEIiOt8tKcoacy
 d9xV9wcJp5Po9J5hYChvkInPl1ceJq0MyvBeYMFSr3sLPtgc8Bg5XZyWkEj6NJnKQZJ8
 BzKLmDhATn83lPdqZBZ811YFQT5tLbR0/5p78VsDxpl/i6oZqYpwfBLb5Ws6cjUYwd0t
 8+CVdnw9+Dow7fWAEP2RnUXLt5nSxjvcz4qsXMg2ucmri4VFRW47YVlhVz5bri26STPf
 WUNrLQdXJUq9pwpqvVKTdaQHA/uXIS84JHNE4pQqZNkv64NoOEpnZEVPbuFpvK7jwuP5
 mDdQ==
X-Gm-Message-State: AFq9FYLCNk+hFz1qGRgnE0lGCE0i0nSUCP4orrET+2nySWKsr5J3rKfG
 sFV9Iy7ptCj7kKDbEGoiNFolhqUHqkWgT+9wYsYIc+QGiU93Cr7mzYyVj4t2XEwX
X-Gm-Gg: AYBFou2/LUPy4XxKI+MkJfHjQz7Giq11GUOmgFiXxsFZevRC1yBXaSmbXi//dfVKRiT
 9RARoByElJuC/IRNzAXDyjda8WFULsp2KHI/38AbGKJq8gAPYDEA5UdJ5zmk7G0QRtwU3KV83oi
 pKJiHjHc0jzAdBxg2NK2yJHzOsLmS+4KtbHqO5YVNBCIroia85AKTlyidI0yZ/pmnCwFpQ7Tjbq
 ++FVpxCssbwc/R1OtKFMGUsAKqbzeOwt6bKTE1XMxGUV8VH+MDoJFAIG9GwOuIeADvG+vLb0MqL
 BAyoGREgxZFTvGeqGZ+NG/NXdCiigavFh4LVTPEMvE7V2CkfyQJBcnioH51TCsvbnnt9PGe5bIC
 JoR3XuUfrmllm1C+7+iqLNN6iSODA0pbp2FzB2rQ37a62duF2NhqfW2M3oHPwrUCnShH6AQ1EtC
 b3/e4E5iAJxU8WjTHcNOcwE0e+0qrfhcSlT8jJFXQvbWkjAWdZVFMOH/CVSS0G5pDIA7M0z2y8a
 JuLoXAz7SU5hUA3BYV/w8mkRj8iM8L/mV6PqA9T9WirbQZ2NIQAgrh8gYgNTfVAzefaJSmOjnJk
 lHvrU39muTtNC8UOFP+j/7L81L4Wt/Hg84ba1e47XdpZZynk
X-Received: by 2002:a05:7301:618f:20b0:369:fa8b:d725 with SMTP id
 5a478bee46e88-36a42440a69mr4246395eec.35.1793375010069; 
 Fri, 30 Oct 2026 08:43:30 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm9620706eec.22.2026.10.30.08.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:43:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/3] tests/qtest: double qos-test timeout to 240 seconds
Date: Fri, 30 Oct 2026 23:43:14 +0800
Message-ID: <20261030154317.1807-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030154317.1807-1-luoyonggang@gmail.com>
References: <20261030154317.1807-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46d4fc1d2b0..c2dd5e5ef2b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -15,7 +15,7 @@ slow_qtests = {
   'pxe-test': 610,
   'prom-env-test': 360,
   'boot-serial-test': 360,
-  'qos-test': 120,
+  'qos-test': 240,
   'vmgenid-test': 610,
 }
 
-- 
2.55.0.windows.3


