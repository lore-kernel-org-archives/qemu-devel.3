Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53816606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=z2WXs4tz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gi-0002gP-S1; Thu, 22 Oct 2026 19:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gg-0002fM-BA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:10 -0400
Received: from mr-2003h-snip6-3.eps.apple.com ([2a01:b747:3000:202::53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2ge-00025d-Lw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:10 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 7BA2918000B3; Thu, 22 Oct 2026 23:59:04 +0000 (UTC)
X-ICL-RepId: 01a1660d-d22a-7f3f-b193-57fffd1f8a2d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713546; x=1824249546;
 bh=JKY4Le/opxQdbpaSI6OxDIj3xE6TxrNxbatWgt+UvJM=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=z2WXs4tzJBo/QBBcIZrabHRIYTBsPrVlzFJZLRuXqVSbdJVRY/N39EPkDxXuW8LXVsdrPtu576cxube8jYTJ8E32fNcRAYJqbUpLul42catQ4jjTg0d8achm1FMGmi24Ssr4ofgi1102JnK7eLkJI6jJJhu5slqy4yRPAJo/BDLsQNzkCMtXPq8mhkrZPWw5h/AubePeMSMojmWD0MfykL/EYKKSvQ/O3DLHAC2Yt083OQ6pPHHZuZNtozpIDAkaRr3YSHQrn4JWqUOZPPqzTPB1kncFZBcO3fHQaCCDry5KcUzTZdmrHw46nh+TgandJL9ysQEhgZKU0b7WHgs7bA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 35C691800242; Thu, 22 Oct 2026 23:59:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 00/11] whpx: i386: updates for QEMU 11.2
Date: Fri, 23 Oct 2026 01:58:48 +0200
Message-ID: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=RN++3oi+ c=1 sm=1 tr=0 ts=6adaa349
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=G-9ac8YlockB7o23_XcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sjYo76bsLvHhJX4lpGj8FoIleEfXcI8Z
X-Proofpoint-GUID: sjYo76bsLvHhJX4lpGj8FoIleEfXcI8Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX5OPyNAEKnbWs
 BX944Tx2PbhCDLOiG3swBWzUbmTD7NCuvPfb+fS2hIjQYcG8mb3Owjl6mlPS2VkTLQCq3SOglQW
 6LxeUq2pi4siBfIoCG5GAkvMcmB+Hx4uEllZLVYlzYoNKs35Ed5oXbEw9/JOhqjUqDMrKE0dsFD
 cn26WKVOx6YMZIJ02ADnPfC88mNcPFZ9ug29TPAuLitErAuTsihD9bFlaFE7PK9u97tO6UZ8PgU
 4YaFV/qGR8ebicK53qw1fMFaQ+M9t1kA0Og827jxj8WBoL1m543Fd+LTC1YVGQQei8nRy7XlrCX
 iPQVKJ/O/9C9FgOWTvC4wqV+NPeDY6+nakt7FYL9NpIV6G9PDVtqpL5rLLDQmg=
X-JNJ: AAAAAAABG6WjlaWDlDcjcNkLBr+CZF+XdCBciwK2hUj2bPbCTzufguxrvt01h8PAYQaSvW/CnvXYbtYKF81UgASa8X2zWX1Ig8tI5y8HhVNoQhIN+7tEptL/8cWjy+uNSBZz23GJVg/gTzDFN6DxT78DLXtyembhpllXbUJkBcqejsIs1qhbpYJX4UMWxsUuV4B4VQPsMcBXgpYoIff8f+Dn2AotoaeiDeIwrXLf5eJGBh2EguVAnWopBJj4XbkgFsG3Qgx4+1lsK6dBfrP2qM4xheee4IreRG7ybx3zbGFzRyVOV1G42MtFjPAAW4SYquV/8v7HO9aErn4Wh6Mck6GdpsIcwW7eKJjvXOaEWAlbi6gMnNA6DPwoK07AetFK6KA+mprWo6oPa5brZFmzRfGgkDkHxsRmCXFYRjWHYXoJRSXJoFwixHsSBXb3sjyDjo51zxoGHwokiV0BaG83PcV7ieezvYU+3oE5MVxNgPQNsfjPa2dARCzE74YRsx13kU1qxZmVmkqNtM++iz0QWvkAqK6Jce3JjZQU6gkz1fOBE+FpVW3DOGf0Xl8cN28E2pDssQO/q18ip/dSGYPTqBQZz6XpKm6NCSzf1TDttmuC//JvdJmhR+dswlVyt2IWlOCsOH3bQcJoWFfRxw25sL9O51pqBAwfpUqBsYLg8AB9CzKbYEhYoKAkhV4TkL/UmLku1DQGzgVKCdChy5BTrSv52HS0AJDXM+1rqAHNekqgqhtzxMJJF3kbb7IgfVqZAIhDhtyhfeRBK6WYaf5vm8S7tSxRJ45yVl/bMOXU9CT5vWgM89++l/AhGt8J6Do7w0kyc22IDHivsCLUO+FHkGgtgEH9WsyEosrkzVzdhLxew/rh5VZvi9iwxqQil9MyqNJhjgQPbgd7exAQ2xletSMymAFNweIe1nd+wlNUWg7mzsxO79/oW/qYNVu4DeXvOl+xqdPBQJV+HFWY0fNE1i+Kw6+xc6e
 QGO6NY3hH3OoEcOWascTNSaHpEH8BNjZBIXRWOA1LbZ/NYiAak90DnaWDw7FpWVszJsJTk1GaSnsYWo77VuyMaAKj2s+LtcYeJE721WJlDVYVwK26iEOV2zXDJWvUx8MtL039PnoZfqgdLF7xMUlERaqphu1j/WL99RZMf1g0YS6ynlDRgnp2PJoTjOZWu9XOXgJUaMjYVeL4aiom+Cv+dKHsniftXsHqsgt8eoUkYe8pU77eBLKj6qaTQmiVDfi+u78qC3WLiAyfjbLOeCRlpaKD1HTZi58YvJ2d1T07VtGkqFKAVSV8sGW9mfSYVloxYUBJgDIpykrlvw0D2pA=
Received-SPF: pass client-ip=2a01:b747:3000:202::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Experimental support for save/restore, a lot more robustness on
reboots are the highlights of this one.

Boden Randin (1):
  whpx: i386: avoid updating hflags for vmexits

Doug Cook (1):
  target/i386/whpx: fix VMX capability MSR values

Doug Cook (WINDOWS) (2):
  target/i386/whpx: whpx_get_xsave_state error handling
  target/i386/whpx: handle processor reset

Mohamed Mediouni (7):
  whpx: i386: get APIC state before VM save
  whpx: i386: fix TPR encodings for local APIC
  whpx: i386: save/restore xss
  whpx: i386: make nested virtualisation init failure non-fatal
  whpx: i386: allow migration for restricted scenarios
  target/arm/whpx: handle processor reset
  docs: whpx: update documentation

 docs/system/whpx.rst           |   6 +
 include/system/whpx-internal.h |   5 +-
 target/arm/whpx/whpx-all.c     |  10 +-
 target/i386/whpx/whpx-all.c    | 198 ++++++++++++++++++++++++++++-----
 target/i386/whpx/whpx-apic.c   |  10 +-
 5 files changed, 194 insertions(+), 35 deletions(-)

-- 
2.54.0 (Apple Git-157)


