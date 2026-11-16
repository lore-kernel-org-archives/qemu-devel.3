Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AD606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=gogUIYtz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSy2P-0002cx-9J; Mon, 16 Nov 2026 09:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xSy2H-0002ce-WF
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 09:50:22 -0500
Received: from qs-2005j-snip6-11.eps.apple.com ([2a01:b747:3006:205::67]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xSy2F-00016R-Jh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 09:50:21 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 DEF631800240; Mon, 16 Nov 2026 14:50:09 +0000 (UTC)
X-ICL-RepId: 01a1e4d6-43b6-729a-a5a2-24a4a6070dfd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794840612; x=1826376612;
 bh=FC0gp7mlAzn5Dbky023lL1dRCnffXHTE0LAfA09dqq0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gogUIYtzOOI3N/SSGNr0zp37/X68ZXxHNUroNboBsLNgIZCRITdXY62U5L5cST86bUS5fJMhWRVdK6sJnvH6ye1gBJqkoscyTrZfhH53CnbNe1I75egP94gPde4AZq7ldQAeoHqpGILcy01BQqgpsWHbXbSQElmOfaPRksXhZ0P6Mi667ibC1auqEk1Y5rACNjIT8cHrXyQ0nce9IO9rJlCDIcq/JEXveg0rEHPc8axIvjLhsjwiBFHJwKoeFxyQTTggT7I27dzD5xyvxg6e4E79MOIW2CuQc6gIRvAt3hKIMQ1oP4tTA/Opf2myiKWwzaQnGDpOTEVnoKeSsvysbQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 BA3C91800157; Mon, 16 Nov 2026 14:50:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] pvg: disable by default
Date: Mon, 16 Nov 2026 15:49:51 +0100
Message-ID: <20261116144951.71940-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1OSBTYWx0ZWRfXwsDV1xxEPfgp
 g8Y+6BiyFLnj+6yLLrXRoAtbCA/i0+sA9GK3tHYIrf7AsNIIsaxl8k9TB3raB6kcsbmLZS70ZJU
 qEhGDbWjsc7egCcwZ51WWq3qEpPCdZz5twRyG7aZbAm0nT8XR1lGKiQLKfYFhO4PjZ6vDLmx0gU
 TSlDACllXTVFK0/hx9d7jv3aYsOd/lwVvTS/Hc8hiqFUeC6blgjcUEGPa6L1KFacwpPgSpPh2qc
 lZTf3OD8jwa+GfSzP4FgkG3bPWkImiJTReUs0DCK3PBNI+KN4gwjTc6Fn5l0Hd32x57Zw45kRrA
 OPUlCtAmSRMygSjwEcmVJuch3LtjeVfwhCKYhStpkkOGRN+TuBHvazkUXXFnU8=
X-Proofpoint-GUID: ROwFFSSF7q3aGjl-EAaWjgf32zoQNkLk
X-Proofpoint-ORIG-GUID: ROwFFSSF7q3aGjl-EAaWjgf32zoQNkLk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1OSBTYWx0ZWRfX31HvT9A+giN6
 sWuD7wY8LtHhiHE9Q+pLV2Kly1nWVaaBlBE00qgnwuuE/w/GWsYZMpkGFI8Wc6yvwSJ8+rUWoWp
 QUfI5Y79rW2Vsjaj048ljfP94o5Wl5g=
X-Authority-Info-Out: v=2.4 cv=d8xgWhjE c=1 sm=1 tr=0 ts=6afb1822
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=51JdnUhQRHFq8RItG6ly:22 a=ip1r3hEevcMRvXd7E94j:22 a=sNqdT3DZ9Mi9C-_xMs8A:9
X-JNJ: AAAAAAAB3N87PvPhgVa5OOpNNYELKG0mUvSRvC5pZr+FPNy/FvpHazkvIk23R6lxyWa6Uv
 hSLqyH3P7q4XfLRt+b42d9HAWaKMophnJmRtCsqlkxsdqkOYb8RSqyECHMUc0E1x60x8YU
 wXo3XA8QRG63QiqE+nAM6+ymzUlQFiCSmGERoT/s3YZWn36iMoTr4CF2UjvFLHvG1PiW/C
 JiY8+QeEB+3XHM08S/fA5Q63S6XAs9TypT5UCUbDDdKkyeezOQ3tqjICCsEXAmm/aND2w/
 gKYAvBCL/DRUxwChU7xjFiCUAjjs9WRlFB5/HlXtMeMm2VwRohhkpXZVmsPd78QIUFucJI
 MvR8ppDeVv9uvRRM4Tmsr82iPTe9vW+wSBB/jGTrAE30QubfmcQWfxoqJSjvysLv7nOzer
 fczG9naaHN/YdAQjnVVHfAKJtvt+c0/lDk1rIX63y7eitDn4dFgt2fiGe7nqcUjAxVq312
 14Xy1llN1J2oZbdQLcM3dWZuMk6WvZkWZBwLMNZ8DAiC7hkAtegXJnH4i1T6L0MxMlb7jg
 zQBBLJaXfWSGGawv9k2rAxySAG0OORXc2iTrWCFz+gVt5nCoNqEeQ5nPM6XuY63CRC7d7u
 RybU7joTQ7leRJYGF6S1MX1I8fZcYSzBj2X9ySIC/ZxUfEb0TBCVKx+p2lV7Fb8uSLQRAW
 zKRI4rIArAUFBkLe8TnEvCerWRUS+tx67wpPd/R7vqnnc1toJW0/HiSHJoZuypdslLTJEz
 x43WHYadv+CxklNoG4XWTi4uCaUqc4b3qsbXsjZt9oK92/FuzqJkNE+RwOwO2oJQoBZUzF
 iGGS9KKvDo1+BarJD4oo7O4gt5Dqe4BpLQ9jgHRZtwS7ZDxJENum35da1NqA/NAWOFaOgx
 6NUYCZGZEJJ9JCHJ5guhYorFvwRzAeGEPrOVnMu2PNW+f38kLEhHvHCWUD+Iu0CrFOi5By
 UBF+CedEG1WgW6J1fTSe3coUn6OXsI9ON+s+oo+tx6Dck4Y5BdQz8Ar9fU0Z2Wj7UFJKsX
 ycqUP/zSoZZ8NpEuP+I1lv2/p5uj8ux20WxqmuOoRBlsj5RR1sxJC6NXxDkAfFtQS2qZtA
 bVaJ/pQ+REB6SXFEdGFWhwhkjTY8JBFFcsOY1yixsAA7k7D8CezSpf/64avSKCJrXV4dhE
 9QkxYp+YSZ3o1Ug/9ZQ//8y9tSEEznpG3LKuv4ODnJmBnYW3cLgwHrjle04bCjr3mvYPT4
 ovwnCE/b
Received-SPF: pass client-ip=2a01:b747:3006:205::67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

macOS 27 removes support for x86 processors. As such, support
for ParavirtualizedGraphics as a public API has been removed.

Current QEMU does not compile with ParavirtualizedGraphics enabled
and the arm64 side of PVG is not documented or supported by Apple
for third-party use.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 meson_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson_options.txt b/meson_options.txt
index 0d4907a0d3..eb049479f0 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -208,7 +208,7 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
-option('pvg', type: 'feature', value: 'auto',
+option('pvg', type: 'feature', value: 'disabled',
        description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
        description: 'Ceph block device driver')
-- 
2.54.0 (Apple Git-157)


