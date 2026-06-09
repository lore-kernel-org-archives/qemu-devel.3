Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5C2CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsWt-0006Rz-Ok; Tue, 09 Jun 2026 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=462017f29b=eblot@meta.com>)
 id 1wWsWr-0006RX-P7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:13:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=462017f29b=eblot@meta.com>)
 id 1wWsWq-0001qe-7z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:13:49 -0400
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658LLkjg2763177; Tue, 9 Jun 2026 02:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=+iDBOYBRZVmMAGcJkE
 7kKXzjS3Y3HP+12LHc5YuntGI=; b=wCP8FqDYY3NB+rZ4s6OSGQNJZg02bEr+z5
 ozELHu2+GN2AhjhVRjmrTLXwyWi5vvHZEC98DkFBsNlo6adBayxTPJUY65Kqpmwg
 tPYxQA6CWhruZvUvLveAE+KOW+vP/VQoJOP/wtrTNA7GWlBYW9WrHsMsXu6+hx1A
 6Sv/T/Xv7beCoBYsqcvHCbLrnrsWJigXEUsd6GyBNa5qogc1XwewlDayH7Hruuaz
 fkMdKL+nyUj8woi/eIXjuAVpgpU+QJqK5fh6TolgDI5ryfY5pa0tPcdgVtxSHOYQ
 Khl2j9PNez6xrqHUfvkgAyy9SRR4/Lh7cU/msVwhDhP3gBDjYQGw==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en46huv7w-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 09 Jun 2026 02:13:43 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 9 Jun
 2026 09:13:31 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Tue, 9 Jun 2026 11:13:24 +0200
Subject: [PATCH] meson: build macOS signed binary as part of the default target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260609-macos-default-signed-bin-v1-1-e013ccb5ccb7@meta.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQA8bWq5QuxmRip9RYMiqCe
 HfTdvkW/++gnIUVumqHzKuoTKmgvlTgn5QGRgnFYI11xpkbjuQnxcCRlveMKkPigL0kpLZxtfW
 xpWsDJf9kjrL91vfH37r0L/bz9wfHcQJG6UHrfAAAAA==
X-Change-ID: 20260609-macos-default-signed-bin-a75612cf7a85
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780996408; l=1005;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=zjr/QKM+njbtyAqtwyyz8YTffjDylwZqRpWBDiS4aJQ=;
 b=pM2e15XsBD5dlx4KPpc8rGRzqL2ztaxzRC3X09XwlxCw+gAlfxxciYkJB5ig49S71RTGOyY1j
 0SrF2NnX3NmChIycvqSmztVybtoDBzbUIdUrl+141VenN/cQUroEvl3
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c0a8:1c::11]
X-Authority-Analysis: v=2.4 cv=OI0XGyaB c=1 sm=1 tr=0 ts=6a27d947 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=ETmPkIdoy5APuGKoMnsA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NSBTYWx0ZWRfX0P/T5rDOtKFs
 zd4X3LxnwffoOGTJWniHrIZDtr7p1QgVZ0qMW//URpAHhbeZNtP9P0Gmf2rfoUQoIM3YRQjjTmj
 OfmQ8Dk06BOVAOZ5kcDh6eHhlvcTgwrd3GBaRLuE/MZKQ4qqQq94Z4IogS5+GqKONy8EydFfKRD
 hmo90N1JZ6Xj9gx7noDPEkEiF2MS9qULyeoVezFe7nunRG/hTiWclIX21bo4G9e9T6iuZoyy9rS
 NkFbgg8MKvR/LTNeWeO6U7Hjx5UtabAl/0Xa70yFhvsTcszbatQR5aeWEE/BvMXSTfg9NndJnn9
 c08cWTnx+A0hWl13S6/EqDgvnphpCC9/D+zA5zgg+VyRlVEA66qNLYKHKMiHxFfE9gEffcST6mK
 DxSe28O0dZQTTjsKx5QmrZ8kH6S7suIDeoJ5qOqhFsZzu/S3g0kajaXelxkBOgefimPJ4QXfvz5
 566EMzpn/6S3T3u11yw==
X-Proofpoint-GUID: NWAWeFccjhnoM08tonK-g4gnH5UWQqpW
X-Proofpoint-ORIG-GUID: NWAWeFccjhnoM08tonK-g4gnH5UWQqpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=462017f29b=eblot@meta.com; helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
Toolchain on macOS hosts generates unsigned binaries, named with a
`-unsigned` suffix.

The default target does not generate a signed version.

This patch adds the custom target that generates the signed version to
the build by default target list, only for macOS hosts.
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 19e123423b..e026851309 100644
--- a/meson.build
+++ b/meson.build
@@ -4453,6 +4453,7 @@ foreach target : target_dirs
       emulators += {exe['name'] : custom_target(exe['name'],
                    input: build_input,
                    output: exe['name'],
+                   build_by_default: true,
                    command: [entitlement, '@OUTPUT@', '@INPUT@'])
       }
 

---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260609-macos-default-signed-bin-a75612cf7a85

Best regards,
--  
Emmanuel Blot <eblot@meta.com>


