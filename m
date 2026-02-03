Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6079E8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSG-0007Yj-9C; Tue, 03 Feb 2026 05:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS3-0007FG-Am
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:09 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS0-0002E6-D4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113752; x=1770718552; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=W/5jxnOdfMJfVsLAbBYZZlsgMaNfxqcr3ki06g7rNMJPZ9TNxQX50wC+ya/x8lfC
 Wp1QQvl6QUUHMhsoilWFYnYxs45ddYCqTaZQsV9wnLxXnx0kcwtOBL6iwHLEKmGRY
 cuP8JoOgS3ZA9R+GYDCGgRzXax8PzNVBfmxghA02vhQSpy5oFJfYwlCefzuyN1IRo
 3NOqDuYbD+UVd19lzygHSfj3kuWP/gxsaBhIkOfKOL3sQE4sZ4xkXLYCpeAmr7WO6
 WYr09GdusPTci76iZK5fOzBbbpcIxwwrI2xtzgS2rtBiO8j7QTG8OZjAMre8/5k+k
 rFoVMHW+gADRoCDGDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1voatT0G7L-00ASfR; Tue, 03
 Feb 2026 11:15:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:21 +0100
Subject: [PATCH v5 15/16] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-15-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQoGEJE8/7ijOhf8cVtzT2s2EAJ9/jgqPQT
 PVd4kx26N2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WFOOEACHG8qzhoJgNu+SsluNQlh+yvozUKS7xHU3hn3YZd529cuPWJioINq6jhmHd7+DXEbzQ4j
 tl/RzTAH0VIvNqH2kxpj6f5C2+I7NmE1hDlls/1Ctea3mcKPTAFgOB9p/BeTwJ4LET06pISX63A
 Gg+WBb4rwEd4fzuAQhEhepGhsJIGsihsnBMRgUJwo7UVF8JwMhuYOBxCUO22873hZDdx4cKLgym
 l7iH07ws4pKNusiXLqz8JaE2O9Vzu7WmJRSDJA0UNv+M+QcEiqT/sFCRSeJLHJIQD9iLjyt+iAb
 dZX26RZ2RPckL9iNUS5lPerrvVlJwA/aGQPnm9A3O0qR1Sv0ij16HgDo4xZDNOFuwrmzKYfqD88
 KGbHZxfrj/RyJhGDWqk7irEUNBLVK7SN/JL+eDc/4d+6j04MsgLV9WeNzl0Bc2JOA8kZG3ZjGbU
 21qkl1ELUOYGaataps42YtaqQynBy6axI/02nvhvmPqtJNG6Hqt4QJnr3vRsz7IILqecBUdAzRr
 X5TOD7Vl+jgCMOIf9DIbYQsvQXnW3Tt8Qg+eAN874ssnr37ZPvIuF3UQf7kjheLKXGtyxZfNArM
 ixr0UOOuJyXx/fW/bgfM+epBh9gLFJNlm4kcQLrAQNYoRIwPnuwZoKDGxIYm33JyYLPj3JqzTnf
 ThQNlLtuTJMrWPQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:XrYk89A7ABLa59tx80D43RUoWVNNHQ8m+lgpkbQZk7QHrfg3CM3
 HKFxNcagnhqDai06luYoE5h9+KymA5vQgM+6goJ2BC0j0Yrr6ycvqcUAWo9+5vtuHNWvIt0
 RyJ8ghWqzhbVcomtrvcfjD0LindNOgttPaZuZ6PhLl4T1UfAQ+TW9O7Mw0LRwv/dmAnO4RQ
 Fb1n6/k2ziUJGC5q066VQ==
UI-OutboundReport: notjunk:1;M01:P0:vwb/bPYYvYM=;myBlUIMeV+N6iZ67MavCM2kwcsG
 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
 PAB8jWq3VwkNVevBgDmj0fhCb6FL1FpIwUaPew
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


