Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E08606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=CEa90mGQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoy6-0003fl-4S; Tue, 10 Nov 2026 11:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQoxv-0003bP-1p
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:44:59 -0500
Received: from sonic304-21.consmr.mail.ne1.yahoo.com ([66.163.191.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1xQoxs-0007c5-9E
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794329094; bh=X+FCBtGN4oSuxMPheAllyKnIQZbivuGJWKr+LOI1/Dw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type;
 b=CEa90mGQuW4n6tyTWk6UlQwxrBbI8V8z89aahHIEAnAs0y5f0RZVXXNLaavt9SxCtCJ+dHqp7iuibjxSO3qf3rTS1qH7Y7UHJHk0LrLhtBs+b1+8KkWULHklWIBABRleK6CaX5jjJ+1CrbQk+HdAfHvx5p5kca1CO8xvmS+jidqVK45d761Iwdj2Mro+wS6QhJMjvf90+yjlCHRUWp49VtItrpqaZ+xTcFu/LV9PdLlJEIYxLGEXmbaky5ETQuTEWUSxWEYCZo8CQUeuTea4xQWd0+3n4oxZMmpwwX0HFayzw8IwLjtPGAVBjqEgka1o5lktsJNcaDavvXwrR/Prig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794329094; bh=21lZPvOsL2XGwkN2N5donNJVV9Xepe4kEcVFpFY5VnT=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=gg6wp/vt2yqMOukjZWUa3AU3qIG7SDtchX3WpaXR7iXepYBQqnE2uRincaoz0uSaLHSlFJ3DuDgar+kd0I0DAnPCbOuaEmYsScrfvc7YqEXoak7JLoPp2Nr3VTkjcFOQrobD/jr4HrrED1eQjE7ctjPda7+Jqb8LDxnDmphP1mSzxXgMzWttlRV14kssZWhEWZRJaUQnfgKIaDzRZkI/2B/0HEcbLYBBX9fH4197+RY3+ntFMgyekQJxx4SC+0WA9k3GVuFydqBzeGm7MwCLLA6Yptb76uTBekaxUL6Lvf9prRCwy0UrLjFo7lRvMIkIwP1TS/GhtA/rz2hsAhObHQ==
X-YMail-OSG: Ry.kswMVM1lss.qXvo9Eh16.VvdTSl7_zjKsrLObsB_RVY447_bUrrdM98lTpxt
 .XOSK_XXQNeS8aREm..Z0INVllecHrH5bZEqjNqxSZ6P1taTaIJYQnx3aCfTEBeor3uS_yy067Ok
 xV0oGjnaZOsf3.0DTnrrWV0KYiCFBu7Q4oml8QzuNK6P_C042.dHryLih9nsMj2aKAtsim8BCpVf
 M5_314rcOq1BpbUUGsco3W9duPFmCxyNSKfG.nlivR7DcLEvC6EDuC8e9pv74WILb0BFSk7ORoTt
 tTiO0ohDXLDVmlGicSXI6HEXmuxYP8h6ijx5bZLgXkdb05GtD0aTPH4Jsz095bJRHjfzK_q32l6c
 sBo05Wjq.XqBjxLXEI_71e.BS0mtZDommQMDBLi9H6lMEYy_Am.OTuZIkR2Z9UzR1ryLmQRAnk1P
 EZvi.dVcrGz3sCiR7ba9DUI88GJhYMmF2TQyWuKSPXUK8dLYTupgKYCSeb.CdMH_fcnZcEi6zXTS
 lmw5BJNXP2JEyPAhfeCoSQgbexRoW80PEC.h6btOiXwi.7YsZjUEN59vkiYuBlzLihdzlQ9n2Oee
 N5iLwPBLfrDCbasHtsCz.k_Gvbh.TdffW4VpMP1bJ1R7T4sXXhuubHAigI8JbS8bH8NyHFDbPbBO
 QsyEqHSeUx82wkQ3BnKKfjxF5sJED7wLAMDdtIrT7fb3we6RbE7QD7rOSgElz_tyipmZuQtfEwaK
 1ms5wD..DzteZmxRr3UxnsD7C3QAhaaczIZulQ40LuZs5Jl_B8ruatN6aUSarFkvZXHK1kMoZu2m
 hSuudnSQYlxFJM51bF4E_D1VMCYJ3nxQzEWEXAnZapa4isKhXHJtQRU5cnDAyfSpW0XMmjyI0I21
 5Bie0ZNC_6UR9WFcoHhrec7boP7d1JqDd5CS.k8MkfsxawQ3XOAV_Mp7TjXVAMqR073N447IwwIu
 lP9Ole4JZMPNP.rurMR_f9cP1H.Z2aVVjhLgjqi6Nh1Cp09AplobeIpVtw9a.1r9YbMI2Ehouj3L
 8XEW8QKPD4TJcMaKb2YQ6ifJbhxDOCN0C9pwMGqgltCLDl1ub.LxnJDvwDy_PpEw_CqzbUsIC7Sm
 EWgCTa7NK6d_8AnLD_b9lOiPj.fB9a1ZuO5Z4J1YUbEb3T06Sj1Co_b9OVlyUJu4OvVmegCaY2zI
 czWg9_pvDQ0MQ3ptSVStxrcPY2rlAlTX9ZeKNBD6QCgjp4t_i3LEGt_HEVrisCoRFDRWGoq8KfXl
 POS7UFoNOPQ0J0wzsF9T.FSnS5UTdH0EPyPuFPRb6iD_TQC6sZiNZ5MKC720R6itE0s8fVIbl8QB
 HPSk_GQqi5qmzr3YU2G4WFjgk3UxE_1Eifsr_lsOlpgicjPYQrh_xk_wMyDhLQyDOauaPgyTCnGK
 p8UlJusvhkuLXfyTZ7JG_dQwrxYKIvyu2QeeXIzc_n_nX9xPMkrPbOSjmE4hFdmJM5eWAluP1Hpz
 JLIeQJXAfIfJfApwEOgYfd2rNFkjh.WBcMdLBw3TdGCZsf0sSRZ0ojZ3XdDFwoKcknWTO.bWOmnV
 2d1knB.RFsusbUMsDp5OwDlfgcgnxYgf1n8v8OviS0eWOY08JmvXxFlp4Z3.hBDSr7_4weAQ5oNX
 dY7KeNZPWtxAEG2xH_eqbzoXW5MQuQh.M.PYtH4v.m48l4JDTcy2YFPj_n37vI7M_SCaULt5FIi_
 LPFPbKyyK9Gyi4DBxpeNSHqUWtETh9MzgEuON6KID.ttUJsbUDeddU.gYg1._MfpVnnfaYKaqBmI
 b0RHb.16L9WFa6o7QQSWFuSmvZ2Aj6YySIFNnDCE__3Ur2lpoQD8QyiMtjpn9u.JPXLT9YAf0.wE
 i8.Lx1kVFDlKn9voSdVpD9Hm6cYg.FYrqRggrGhFPXdGoWRFEcQjtmIvLDcm2DROojFMNe.t487h
 kuJ93dc7S3oEwSCqYCC6qau3gEZiK76gCVRkhs4YjxOBHVzqQwHNwiQ.Oyh_97UmHETkJokMrnr6
 MazVf.0VHk_Iz9xS5HGbqOlRotLNVWwiS8Wft69wfNYU0EamW7Px4Sjtr5CRadP_QSRoE05IUw.0
 cWq88XUK8H68uI0Xi7O_hUFG0EAoSli5Ox4rAYwujLaPEKEptPf7TX6eGenFqu6L6U2k7vaHI64S
 i4qforAVwNCt6NN03lQ3a11LuCqovPVm4VFz9byGWlliV1srv9EzTT9dgUON4yOHQlyoZGwKNEQl
 mpjEEnfGxI31KzeriLrl5w_QN1mvezWtUTFpezTOlB7LPdiuPOrPlanIOGK_XSZqo_uY0AALvLYa
 y7y5qUVW7OQ--
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: f434ff5d-d996-4544-ad12-60bde1417bc5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 16:44:54 +0000
Received: by hermes--production-bf1-6d6877594b-8262h (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 8eea9870d3f5e817fcc649df52712fd4; 
 Tue, 10 Nov 2026 16:44:52 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: qemu-devel@nongnu.org
Cc: Eric DeVolder <eric_devolder@yahoo.com>
Subject: [PATCH 2/2] target/ppc: Raise a machine check on a failed bus access
 on 6xx
Date: Tue, 10 Nov 2026 10:44:43 -0600
Message-ID: <20261110164443.488899-2-eric_devolder@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110164443.488899-1-eric_devolder@yahoo.com>
References: <20261110164443.488899-1-eric_devolder@yahoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.191.147;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic304-21.consmr.mail.ne1.yahoo.com
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

For 6XX, enable ppc_cpu_do_transaction_failed() to take the machine
check.

Signed-off-by: Eric DeVolder <eric_devolder@yahoo.com>
---
 target/ppc/tcg-excp_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index b04f07a637..29fd1d371d 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -297,6 +297,12 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
         }
         break;
 #endif
+    case POWERPC_EXCP_6xx:
+        /*
+         * A bus error (TEA) takes a machine check, if MSR[ME] is set. The
+         * 603 and 604 have no DAR or DSISR update for it.
+         */
+        break;
     default:
         /*
          * TODO: Check behaviour for other CPUs, for now do nothing.
-- 
2.53.0


