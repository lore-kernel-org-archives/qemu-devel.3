Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D1EB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWe-00014d-5Z; Tue, 10 Feb 2026 11:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWY-0000xC-Tu
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:40 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWX-00070W-8I
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740605; x=1771345405; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vdNJ80OJmBaDE0b5vBeMEMXp1qg90L5FjNPAtruH4+vuBEtZfxP9dLI3IOqg9Jhi
 p3Waj4R6jSvTe9pItiTr+vtNRdSQNrK0zvw/1GqHEwFTbVthbWHnhHacFckknWGAY
 1WJC9h4goYUZux3524O+QIK4B3/d4ihyCBf54HCRx1VCBfvVAa6QHfO/cdSXw+Sl6
 7HKHKDhAcsF3768IraciWthZjog/CCmlyd9rOP+TQX8HABIW/dxHtZEi2oGHbgkfV
 +p/eKLboyVSgJoaXjC6bT4l/RPJRrDwKAYM/eMR6iaMjVjGV8zneHxvI63blzsg47
 5uAIskbIVUCo70HLRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvvy-1wFepT2DoY-00R3JV; Tue, 10
 Feb 2026 17:23:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:14 +0100
Subject: [PATCH v8 16/17] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-16-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t4PaXZeLbnSem1+5F0zC8q+syhr4K26wWRu
 Y53U+6hk3aJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbeAAKCRA1qwsonF2y
 WC3kD/45Rn985rQBEsfZRy3TrNuSk6HBCC+oca6ylwtIVteoqwES8WS1rMUVDS/WCNGEvrV3XOD
 zHawQ2Rig5+XqahZCg8obvW4OY3+snDmPbqGzUc5VMfH4KhZevj3tFZOEYG1gI+mKRDzXNS5icm
 H1C5zmHvIPBLccAm5SHCjWipA0qMLymVBm0xKz8kk8hGexcxh7QTivsA8xlOdrJKvFB7Rh4G1dn
 TQzCmiRZp94dnMmOJohCr5ZpZ35H8MBEa40TUno4JJJV+0g/hjs40YQoCONVI1eGWCF4D50Ztry
 P0P6WzW5VjUIkeyiS6x6e1dEa0PXPqNqIJpiDX3FLENgszUyvMSsS7Cuf6VGCst8H5QYP0YmhTJ
 rXlFE+ogOSifVPrlH+ZAOovbXNWcZINoe5Lz2RS4LMcoL793vPGF3lZ0oRq7SzDpMZa1h0K2djk
 JIA8+O1Snm1pPqhtD3QpFxOVKaUTkBkdiiurf5173KA7VMsSJjTXX0ETjjU6vDmVrDIQzwCa+63
 9TFPSWdp7CedynS8GdJpY1ET9Wd7hojx41BL6NhzT8QnQ1JNs9SwVNak1hSEw1W5Ti+ZW29u6HF
 JWmxXdCCLXY+N5mj2UGW2a6ExODIdikmTtsaBY4ORkORoLzcGDE4sztrRyIlOPN2BIm04r7/19D
 /klnOqR06W7o/AA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:JYKaU7PP834gAwl0rKmfxdOyD6w9nNQaCvHrWeyphQPbeVQGuB2
 i9U7qjwksbs1+dbHBqC0wQoHjKldBBNXeBIXMxtlw30lvZoBAbtxILjss6S8v9LxlZ1ngRN
 010tNyTyWqKFi9B9D2Pqc2IwKIJj/NTwVu8k47SOfVDq9KV6vCrqckAkutFPbTi78TyEheA
 z+4hy7wfEjP+FWYt8dGCQ==
UI-OutboundReport: notjunk:1;M01:P0:xkX9hSXyLRk=;D3y5fAboE4QsSMp/UHQKHz01X/0
 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
 tkn/LDFxh1Z0DSPKLG5XbnLAVqLR7DXdaTYXyN
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


