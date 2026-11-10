Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C3606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=sHmUqfJp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoxz-0003bj-VL; Tue, 10 Nov 2026 11:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQoxt-0003bE-TL
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:44:57 -0500
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQoxr-0007bz-Ug
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794329092; bh=b7PnRNooROnWbACLMl/4J7cfU7ZEdre+n2TAIqA7hTQ=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type;
 b=sHmUqfJpWdwbpgLDUtsc32/SFg4/EyFrhLAvgtSBUuaeiNHE0v7KmtFeBtXibJ7V839TeuXntQKn6SrC/uaVIma9Zto31ZDt5eXx6mLeC+8saSsc2Fs3dsPQFrQTuZp9mhf+7gyXtrmDxFP9bdgj6/QaDJlLRH+yeex2gVthBBWmFmtV0JoH6gQrqvP4UFwUFsptGZUQsoysrgtmFeMK1mHCNArXkQqTkKz3ZPei+OObaEZ/FZOvsslNzlvYR0Szhy1STDCxizGL4bV0aXPf73BYX4mkmp+oGDVfaAFpb/UXQL48pgpUKsfJvogmeBLXtISpZE+SiIOhCtoa+UlNpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794329092; bh=I81Gbn1yHwnT9RwncY2aBjAvg3lXuQD3WEyIetN2pnM=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=HXC/AZ+Ba4bS6qTN7Uxhf1H3bcsH+YN4qUi1kdMgWq+/teK0vY4VVudVWr6EzR4a7NnB1AQrPxOKJO3+kd67Q0S+AIxETPyWhFOPwdQLU+jR99cWO05SQPpG9fNyf/ozaRliOGhwFfb1+Qt8qOHOR6tXYk32rfZkcPY6zyjlcKTs2t6bHyyUBHKLWNq8tnyeW+fCoK3+9DOfHJP1dCC9wz75hggkWumc5TuSdz8HgaLvn0znB9iirWGvsOVPEtcLNmez5GCS6oaFG0ImFo7zi5QxnEeqCizcfgdj32y3m4Eh4fyJAvQfUVAaFE4nie1+a7rck0t1lG4stGz5xLYdyA==
X-YMail-OSG: G.LwkZYVM1kF1dKbMjgtAtltDROyOrfiP3tJFmx3Twkho5aKT.ORd.pn4FzdIKE
 G2OJzSiJWu86WkNN.zXfwLfnKELdtsnDbQl5nuEVYgU3YxClB66HZv_RayNgo5gCCHeO78jE4pfy
 MEXb3f.VWuTJ_T.Uy2RUEtkiQRKBGdcB66aYMI7_p_6fm5NJiwBuXLbzjyOP5aIlp0yvPW1y8Sdo
 KPuHbb4y.AFYjxMIt9L7PgxWwSRatPNWWYQrsd69TECSqGJZql_aRwIMioF.g25iIIWIEsJblOls
 soTWsbw3nEQeCvfxNGp19xwhIFbeO56cW6AFz_mCc5Q6QxpI5tGwqaYJ3sUtUa9S_39BHJbWdRKn
 gNn2mt37tvcXneLIUcTiClFFoQA9s.VIp2d1pP5qjuK.X5zo0KliWj1CikXYxaBTyqI_kDdYz58r
 W0B2y.VgQLfFdMu6Y_0uCN676P0AhhneQL2e1PrK.VjSE7GuhxhnsFgEM3GQ8xtGACQggvbSVWWu
 mOM7sOVR436.p0PftMkDzt_ELhtl4mqZgbC2_gCeLiPHd7adNtTDIdvwWFHajG59JYjzbK4r6Ews
 yx8Gp97F3bkQfoMjfOkDoeQ1qdEnYy9dA7maMAPwb.5w0VRM9Rgzh4GOd1Zx4SV2fxJdULt7nW0y
 xWiKipluGvD_7davyXhGafCTU9QE2fgU5xavdU7j7tM8oXp0lBECHQvjXUtX.eKd9RhWVBd0ILBM
 phi1UdGhlvC4h.m9619Wvu3WunurP8zOnxoHHKfOP9gglIJkz7oAwcX96RhLi5I4t3W7HPlml4tE
 0v8SpiXOuZE7ACPDIrnCahRBRK.p0YuRNvUQubTZY9Hg7IHKRT0YSJDTXjHLALbOS9IJmr2NxXZI
 JrT50GuBnjKf5zFFs.d4gSBo3A.PrMEqj_7mTRcSwTpCfSvPmihF2MxdKMPnyfiHKOE4ZrraZmIS
 1Gy5fw6XvrHRGPyFJg8nFhosANlmnsh_3sOk883f1GDuOmbNh2Va9QmqjUfTqsnGSIkDvBjPONgZ
 vbdOpu6rgAnJ3gD8vPOGwGWwHUWh1OxjUPS_cAxz9ntYPjstyciGG4Ac6uCXEmbBz.YNAWGOObxp
 FlofrvbGSpJCJG8knIP8VKB1zf0kEkS8hxdml.G8taKVZr7sJMA.2YL344WyXT2oRd.9B8DAcwyl
 SgMzZX0DVtVjIfEf3TPSNKk0_8YBR4035YzvZPJkUXnFSDQ4RhSWFqHs8O7FS2Ax4ZZ3aYhtSsut
 Sdr.HzGbaZPnfyNpoU4YBKc_y3ml4MQYjaevg7UJigM1NK0hZB8JbH9qhgd1W1xAclYGcPU5EnX7
 uvgN59KWC1PPLbxFhqD8qoMCtXhtPkiVmrxdbbatdNsSJ1fy.jNK4X3DpHtWHuOxNZ9u7hD4Jb0o
 3eb8yUCHIaDXVm38TFHWkhHGTlD4Lo.2FhwFSJKTtQJLw6luUIBZHOPnHhsJjwZp2_CMgoRYBjxy
 sqtWizW0xNa0t4xv2mo99O7JCJMc.O8uzIzyvIDS6CfkDmSQa8T6PUnVdTqh3W4YlakPQ7fMLpc0
 AKt6PM5QrxflLph3cNiObafTH1924iUBJBhOLq.TFhGFntBeWU0btdXHkiMPPVJe_XVXIWS7ZBIi
 5NpWyb9Ullq6ZpwmtkSM6IXsisKTH1IzJfokGxCaEwmQ98HkgJJRyXa4UOYG1L1hFsNovX1FDBt2
 nUl1IafP5ZPL6Nb0zLxeQS2jfTtS4yDwrujfIYkZGSlzaCuqYdir68hsd73bNTQHdgVLZTorQxFW
 tnqPYM4873NlGkyxFHl7VfH8DfCH1LHWyj0IeL56GtC8OkoMxqb8JDH4ITC9xLnPU5xKHyCBscSy
 T0qZD.y4aXBgXAVvUfOZNuwfOWvDk9C6zFVAb0ElOiuE5hk46WUXp5qYBtn9BhRf17T.QCH0iu0m
 efgBcNjqjkFRPEU49mH60uK3Xyy5K1kEsn1CssxAjN7wWbku.ya276wjsQXPhAltRW1mu0QX.kos
 ZGrEjSSo4ApcLdiI4lHq81LWIX_YCFC0NJkLzLdV9QoesxFkj0A17gaa8iDUSu5TBOPcS3pmY4nV
 tuoY5bWr4q9MQuugzUSqAv3AYiaFvcdg7LYFmtvjjQpm83kvoGOFPwQDKsC1Xezc8e1jKJTziZQN
 sRx10BsgF5A7SI4VbmnRKd6DdoklxRQQvOSnvSYrZ8ksRKs3pFQlA1oYhj6nmddIph_BFvl0swwb
 AIatMtXyTZd3m8tzgzsRnh3UR.sShb.i51Rx9kWZEvl.KOmQXmtm7.g0rBUiithT4xbQOZxkU4Z8
 gVT99dbcSDwY-
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: feea85b7-3f5c-4aac-be61-1d04b3134ba5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 16:44:52 +0000
Received: by hermes--production-bf1-6d6877594b-8262h (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 8eea9870d3f5e817fcc649df52712fd4; 
 Tue, 10 Nov 2026 16:44:51 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: qemu-devel@nongnu.org
Cc: Eric DeVolder <eric_devolder@yahoo.com>
Subject: [PATCH 1/2] target/ppc: Let mtmsr set MSR[ME] on 32-bit PowerPC
Date: Tue, 10 Nov 2026 10:44:42 -0600
Message-ID: <20261110164443.488899-1-eric_devolder@yahoo.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261110164443.488899-1-eric_devolder.ref@yahoo.com>
Received-SPF: pass client-ip=66.163.190.146;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic315-20.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On the 32-bit processors (601, 603, 604, 750, 74xx) mtmsr does set ME,
and permits machine checks, otherwise machine check ends in a checkstop.

Signed-off-by: Eric DeVolder <eric_devolder@yahoo.com>
---
 target/ppc/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 06ed2adf10..808f913aa2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4282,8 +4282,12 @@ static void gen_mtmsr(DisasContext *ctx)
         mask &= (1ULL << MSR_RI) | (1ULL << MSR_EE);
     } else {
         if (likely(!(ctx->insns_flags2 & PPC2_PPE42))) {
-            /* mtmsr does not alter S, ME, or LE */
-            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
+            /* mtmsr does not alter S or LE */
+            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_S));
+            /* nor ME, on the 64-bit server processors; the 6xx can */
+            if (is_book3s_arch2x(ctx)) {
+                mask &= ~(1ULL << MSR_ME);
+            }
         }
 
         /*
-- 
2.53.0


