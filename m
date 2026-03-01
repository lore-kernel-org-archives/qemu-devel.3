Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14279FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHj-00013l-2v; Sun, 01 Mar 2026 14:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHh-00013a-M5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:57 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHf-0003VK-VW
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392614; x=1772997414; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qIJkM9sfwDXBfZr6jdX3sKNXqC7nIyo732T5TF7XkwnNmO86/9A/Y/Um/S/e2v5Z
 dOe2Ao4xenlvj/NwXLvn/dyy7e0QAmdQMg8y0EnkR9KO1WKdlrl+vt9KJ5SWQqCBr
 +vlICtVXftLl/kdhGg0OwjOc8FzsNfbz9lVbk+OKfzloozYcqD82kToS/BDhvTqWy
 27AbGomiCiti34qa9UyBNddddNZX8DY40DnrnXCaEqe5YmoXYWH+4O8Kjy6mcejrW
 yJ/drZn/P+rcCkGmJ/vszvRRyytO4hmz8doFFvJcPdRwi1J5NzDRiMNIgI7vKYDer
 7GGSN/0OlZddmENHkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc4g-1vU2740l7g-00bh06; Sun, 01
 Mar 2026 20:16:54 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:41 +0100
Subject: [PATCH v11 16/21] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-16-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCd/mRVRXVVVFkoK7FAa9sDyPnteoSs0Wgax
 YxCEfQu4xSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WLyLEACOQhoTtO20TOXlhr3kgVoEhzZL15TNvsMzWNlwZOBkb9W3kTq84BTE7Umb05NS4nTXmGI
 8IZdVvNPmTexObK7tZmdX5UNN3aBvZr4ZvHZ7wMs1dOqUDRP/I67kxiGeJ7hfvYWsdv+jPJgOEU
 ne3S7iA5hHPfbEVhQMoMEzaFJOEvYbCh1w0N2h6Vr+fZU5J+X7BgYtDZgWwVf2VGviTG2zRH6iX
 NTSxkkvsPQUGwXmveiMNy+/X5+rLOp7toBan+h6vTHkyPxD9faRo4LFb0CZ0REeTmH0IgS0RfHU
 dWCYXSITbsXC5zDiWQD9ahbyVxJ+zxLzBEpi69jOG/gVqz1l4Ij9imHQIyW0+TymLi5HEhTxMi4
 y4cxZVbh1WAR/i+vdfkGti+qsnXGLG2w2bO6KTwSsbQXjwnU54zr7QtgXK1jEWUfvSZrcog6j8q
 ZLxa2fBxm1D34H7yqShjraSu+ihxzWV/0+SuADA4oHHtFSV/Rpcu9rSTXKgotrwbQ7eM+BLIM6b
 g3hAlIwEVEf3e2cgG8qvNM/mm6HLKV8MufsQSDd0wZQUJFs3F6EczJ0T5tFe+zukzLrZoU8Kfad
 HSu52NZx3UVXz1TApuNLjZwp5E1r+ZrDeDiGSm5XzYVrvt4LcssnPwW5hcrIe0G43f4Du4brGUF
 XDs9aShCPkTA7Ag==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:s8WwVruOhLKMGgfb/+5QpQKbO7iZmLHBjb+COeIDBev0Mm04xhX
 rRmiC+deXktyHdOyHtRqhKEgTFUf4xp6TmMz5c6oQI8o0xHXytrZpz3IYwRsrUIEc/YawGP
 2xNhWyvzt0D/b6SXzCs02LfoLXRPrnWmQYWbHv4OKbbEz4GDJjAyHzO9aDjO4KUcmCQGlMM
 hInDW8cxV9C+Ns1mexM9Q==
UI-OutboundReport: notjunk:1;M01:P0:ho9QG27jcAA=;GV9s586u66N3eNyRugKsMaVNhzx
 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
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

I have so far contributed 61 commits to the colo project, waranting
the addition of my copyright to this file.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index a70e61aa09391cda933031535fa982d27cf6654b..75abbd80298df79223cb8e7006=
4a5dc83d70f4eb 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -356,6 +356,7 @@ Wait until disk is synced, then::
 | Copyright (c) 2016 Intel Corporation
 | Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
 | Copyright (c) 2016 Fujitsu, Corp.
+| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
=20
 This work is licensed under the terms of the GNU GPL, version 2 or later.
 See the COPYING file in the top-level directory.

=2D-=20
2.39.5


