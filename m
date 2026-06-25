Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F82CDE013
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrV0-0007pg-DN; Thu, 25 Jun 2026 17:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUy-0007i0-5k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUw-0003br-FK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUu2SICVtier0Tnb7CxJKyc/ewW3x183YcMpT+FJb+s=;
 b=KpuPWKRhwKNnAhZSK+y8GXg9C9CSMosTN55SjXf6c3vM5BxvdjiUDUSoCYE2jeAbhjvlqP
 JyH91bB22ZU1gWmyOfumgDiH2O1DqpDF6gEuH44RgwxKbY7nPv22WM7pkmwuQQDKhDwL/Y
 ZWFqontIUtPYEch6ydgUgIZOQyqPof4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-S6B5Y8wONFyNivgQo0OSPQ-1; Thu,
 25 Jun 2026 17:20:22 -0400
X-MC-Unique: S6B5Y8wONFyNivgQo0OSPQ-1
X-Mimecast-MFC-AGG-ID: S6B5Y8wONFyNivgQo0OSPQ_1782422421
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBC231955F3D; Thu, 25 Jun 2026 21:20:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A09BB18001D2; Thu, 25 Jun 2026 21:20:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:10 +0400
Subject: [PATCH v2 09/39] hmp: correct the nmi documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-9-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=606;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+QRGJalote4uzB1iRMSKaDD99pTJJl2HI3yPBUU5DxI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtccs0ebQ/Y6z5gPnOj6TxyNXZU8KU56UBpF
 Yv97gBY0JyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5UopD/9KR7pZXEmkbTaHozQy/3JB1sZJZmOv4NmV4FiC/J7iWrpg4OfTh4hBRmSFkLuNKs30nH3
 kfcsWgEQGEJ9zhBbmNkIaFJCrpr0vcoABlV9FyxlgdRMySu62WVMItEzW+MnBkV4zpNmQcoVutD
 zJU8nk0Xlrze3h88IpoLx+YIm8uwl4r5FoigT3A6gXGQSyGZUQu5RA6ldJqEOfpl/Z5Mdf/5f1P
 vzymlG97Z4ch01ng3BV6TwV/x40qqBvxIAmjCal4uA3nxKNghf9yXMxqmsL5teLcjm3AbNleHrD
 Tex/HTV63bRIn0HPtDbWPWoWxFcB6il1DwAU5YFJPhxHiea57sXJ6pZrDysTJMklV78ziDf0PBs
 C8DRZ1IgNhbygmpqDxrC0N0FOt+G0pHhUUVB5hrI4T/Z/pSdLSnnfnIfqSEojh5WaTHmA4BozIE
 5HFgUiTs9+fDFp1k86JltrHuarz200pdzT5ZTzvVfqztrFjPsJ8RyBMq4CyDeyHfqCxS0xHc73k
 UZMqak9D+9aXbpxxVLNhrHk9MosMHOd8Lhet7/JLyZYn34t+9qB1SImshEEl7y3UNzUjm7Q4RkF
 YA7YZIQgiAkbpt71v5OCugT5k97VcJqADLbPiM/gZdEbK0IQqoxSSazt4gnH/D/ggKzRZnRhdT0
 hhS4ah1yKGvRI7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1e286b7c89d..129052963c7 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -868,8 +868,9 @@ ERST
         .cmd        = hmp_nmi,
     },
 SRST
-``nmi`` *cpu*
-  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
+``nmi``
+  Inject an NMI on the associated monitor vCPU (``cpu`` command, on s390x) or
+  all vCPUs (on other architectures).
 ERST
 
     {

-- 
2.54.0


