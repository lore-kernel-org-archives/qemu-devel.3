Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E5606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=f4/F7ki5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWEdT-0006s9-65; Wed, 25 Nov 2026 10:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWEdS-0006rD-2N
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:10:14 -0500
Received: from mr-2006b-snip6-4.eps.apple.com ([2a01:b747:3000:204::f]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWEdK-0007UU-Sg
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:10:13 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPS id
 B33E11801582; Wed, 25 Nov 2026 15:09:57 +0000 (UTC)
X-ICL-RepId: 01a21341-9f64-748f-a9fb-e90b4bcd955e
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795619399; x=1827155399;
 bh=o3vIPINPGSd1iGdp07mOrlqanRBMwa9uvG3PqDlbaJI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=f4/F7ki5kqCSs8jp0S9mzwmdcpzq5FsjB7KCvizBNyGyq8iyrFXrN7ghPKeO4B0QqF3LREVWVYONx6KjmCOBRemAD307IB4EGuv9IXehPFXSIyFUkXGugIs/0wnMMXuR2C7OEhFrpOFxsipvuTuFUM/GdvPYHFDyTTsNIWCRLWdTsDbwzKA3tQh8IQWEqfaChXAH+4+pcu+F4lEjEUeontu4VIcdX+F9mLb/X1ElZRkE73ucZz5w/CLdm09KUSL9bCC09ry50NAoxAr8cnWVW8SazqTZQGYbYB7k+jLLm5n27Rrqh1L0uWqF1Q9vkLVocIRzlJ+XFVCGIDpHoFT03A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPSA id
 0525F1803A8D; Wed, 25 Nov 2026 15:09:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/2] whpx: i386: fixes for QEMU 11.2-rc2
Date: Wed, 25 Nov 2026 16:09:50 +0100
Message-ID: <20261125150952.48332-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX7HwRF07aAl9u
 M0o6pJPLhHWHoEg3TojAZu2TREv+LBsyBfgItD5V28ovIFPLFfruxW7iCT46EN7WupdANwTzfpe
 R8d9vUMwzOaEXq7Owt93ZB2cLq7yzL9Qe5yGZJaZMXdlOaVCBBbyhihTUks88rvpDcnqbq2n4mg
 ESfxUcENFtt6TPJ8ruwGHayPm5bIKiDaFlH/jg19M89u368iGNPZnXS8REUI6sCrxhEQz5wCfl+
 9SmMivq8bzD1OwJGgTR9by88BQ9VHvkCWHmsItJe5g1rwH3z4yy6GPMtRVGbi2CuuDF70++kXOS
 /1Jy6mYCRHdoB/dra6nuMbgqsjso/Yh9fAgSb3BBN9wJKJtE8Qma6plp80nbg4=
X-Proofpoint-GUID: 3ioCbGLxdePSp5bj4yxogKLqMYuLhI-G
X-Proofpoint-ORIG-GUID: 3ioCbGLxdePSp5bj4yxogKLqMYuLhI-G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX45qLsYAeKA5k
 Tv2oVpoxINVa23VPOO1B76w+49jtcHYGaOXzh50NxEvkiJvwUnK8RVBaSWKNHgxFS2mO1YrRH2v
 E6/BLzK7LHxWVJCFaDfCE9n7Y50ntIk=
X-Authority-Info-Out: v=2.4 cv=XZAcX455 c=1 sm=1 tr=0 ts=6b06fa46
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wbbCu9YnSpm8ZdSLOl1R:22 a=_mclknXjrhVi08tC7Eh6:22
 a=V2yAxr9Igm7D79kBl7oA:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABkPc7iaHoM6jB83XyHcv83M/fqGMZHdMPR7zf+YqhjFfBAhVPH0rYLTa1SuDsFA
 /XhVIlO7OywiDKuqn8EbcDJRDeeAN+zvM2zbs7z69DEPvs12MpuPTqaRvqu+u314uy3ARH
 w68kNppeYFlpS2qgqw6kP6efEQ/rsPxYHgKRgiMX43wkhLUsda9EXaonzBWFHYP/cKv6yK
 p9VLcmBtC17v6HjaJu5oNa1qSpMl6O4BjUsBxZZHdg2WwDaWC3Ra/z5mR5Z+KnGObzObJC
 Ui49mV4ykaKjNonjGpadBskhZ+Dy4AMaDK0NMkc4ZPWrM3dggAyi8DL98TyXu6VzadRvEN
 LnIt7SmudYcBNIzpalIab/+BJm9FiEf7mGPGGWvp9w3A9rt9R+Yc7ko//18IW2/GYknWmm
 QcJj3xz649iL9UKmhd8QSgYN7T/mg31xazqy63OnLGTz5XDjWtkK+5/qZUNY7ZdKO9rQcJ
 ZsqOQPIqsP2nhS/c/qeRbmikHvGa7XjgrYLP4WKR2Q3tMpj3Bii4RSqycduosIATZL5oxn
 5NDC9HeVqhESy01Qx+NzxR1VUeewbzNsbwpkDxLSkvJVPA2M6K0tPR+cLuBOYcXboiCWIs
 nZ7MBJtV3WAvoo1qXUC2x0gutPaiOwOLNMDSUoqtLZ3bnIiSXsSn33r45PMh1hrlMTgcN1
 Tuwxq4m8Le5d+OZVWK4bGukJzaqDrBqLMHofM0Ilmolrz9LwCvW/VdiApvsQRUp9CeNrS0
 QFPsUxPNsbawzNH7EN00tNeP27SwkLyQNhhHBnGzQx3WmHidslx+JloPTRsUQdCa6lzCpO
 aXM8Wqv/NpcKy6HIQNOSI5tU/AcJme8iLiOZOOLahCRWQ3i52bOjuN/nb2ZCxyt99H/0Ut
 DNkUKaXfQc8CfOqZevaxcCx+0gTZoz2R+aEfoiHYsLij4USdUY4tpn1MzSR5EQL9T77hFZ
 u0MjoUXeKK2KCMzBCZC29+yhLO9fcY4PAhD1+MewhKdduE/ruXzGS9n65o974zLfBTzQKb
 /Upy4+yhZ4kJvGITVFJPrw8rudyAPXL4t1uFoQc4yIAswOjVb4MFamOhRwhrajVELnHaqK
 F6unWE3E0yN4CRj+wub+or5EWkoDilyor5b6LfYHi9cizwwOOfnKpviRNDwwVg0D2uo+6k
 irJ0YbbCj/xVKyas1PYy3RAcSm6nN3N0Z1zPAf6445Ss6ZBVM=
Received-SPF: pass client-ip=2a01:b747:3000:204::f;
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

These need a review and should be there before release.

Mohamed Mediouni (2):
  whpx: i386: only do partition reset when exposed
  whpx: i386: make nested virtualisation init failure non-fatal

 target/i386/whpx/whpx-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.54.0 (Apple Git-157)


