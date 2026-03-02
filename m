Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F738E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gx-000589-0d; Mon, 02 Mar 2026 06:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gu-00056i-O9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:44:00 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gt-0005kj-5Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451824; x=1773056624; i=lukasstraub2@web.de;
 bh=ulLSVe9J/4FxIZugf2W3Tsb5eFQh8fOd29S7Dgc9JTM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tooALIpJGKn1a6UrE/pZra3CtaTTNKq0/8rQtzv9cMZiSMVuhjoFLyg3A6yBE1yg
 IfS9xsjxanTh93obDpiB39MG9CEtWz85tzmY6sw7FO57UM3uSHbziZ44plMYXJDlZ
 E6mVKYILDV4mXFvwelgE5bjpDZ1ZW3kJZ3CFVZQF6Nwi14F2MtGCH/WwLvkNV9A1r
 SO6zaBTRGcHpBmhQKUvEgCGccngdJzMQdvhlZPlvtqM6YN/Xw3EuPVou9KR+Wdn0X
 LOGWn5xk88YQwUUpk6q99Mhj1d+mODf4nkyF1Xgx4OrF6SZ3iXwfG51Deky9mn5+7
 /JUjt9RVJ4aLW2xNHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1vWvul15O7-014ewD; Mon, 02
 Mar 2026 12:43:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 02/21] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
Date: Mon,  2 Mar 2026 12:43:32 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-2-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=KCRVBGcCfPDGLbGpOm74X3+VG1Zpq3Yt87JPJ+cVEVQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TD9BwLI6lHt8ZszMfHE7UlAELoeAAaYdY7
 5oCH+dU/GqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WJusD/9Fnr9yyzj17EhYR6xs8KHiVup+Pyv1WswSxieJ0xb58Pbi9JBiDa+xv7xhzQB6jhJPe/+
 RSuyxFXjcaAB901H6w1zGY99C5J3vai64KtgmxNqA6jZDZvoM2xkyB/Auy14UMe8tOM/QOhsmcV
 u8l4CmyW+y7gTKWFabflkMr7jvcKE5gZZTDWasQdZsXwBYtCknFDoRaCwIS7qpVE7PlIjLlf83o
 wOJrck1QE2Zzsx1OsZ/OAdBZfVSgxV6mBbfTn5cnXEgWuy02F+1DuSZ+YSXhCO4GUPVIYj9NdPm
 dHKI7rD1MBGlH9O92v1J+sSNXM86Fv72NMSV3KF8QaDdWegGDZIOom/WJ5znedUkTlU0VU+E3eO
 ntiyTMU5rgX9NWRq13J0c0jyjYo/OYxeKKGBfn29EDGJ0q8MV89lKFH8gN+aWM7qSb22oHZadL3
 HxAj2Y3mwZXbOTicnA7XL0XzIqp3dW1pbK3/aeT2r2q0BL7MO73+ZWZPVsb+gLUfyRXjRzq/jlR
 z3zQ3qrnzQNR/UNeo0ni/7M9U7TKuPclErTdXG3c1CbP51A/gf8SnO37mNItatjmCsHKN5VR7k0
 bMMilwDg/hYrNQvc8DDN7+YIzDpwv/2/NHO1GxkGJh4xx5pfSOvcgXbjjo294dZ+J8Z+uUio+i6
 cRCs/juaU+r7EMA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2zs+Og61eTs6+OCU17bu/xA1/Ehr/edn7ge7Bni7gGqTTmgEja+
 VSkpZ/QLnbWP7JfqNZyijLtZQwHyurlk3S8wOWQ9UI/93MmKsN4dOaDDqxd5aOagFjaAvld
 enGH1zGttqJugIncc2W6KZvbF+sXaVrjDeX1PIiDrmERFqn3Qoe85liJj6AWvvcZuh4NyNM
 aiXRpdODE9KMeU9nwSW4w==
UI-OutboundReport: notjunk:1;M01:P0:227oQC8CBvA=;whDb1CWB+tEatmmnZtmU/OZtdg8
 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
 kKXEF2X4=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

His last email to the mailing list is from December 2021:
https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfu=
sion.com/

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff592384b366acc823f19a6596ea8f32446763b2..aa8f795783ba936ce2521e08aa=
ca8de4a112ed33 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3869,7 +3869,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


