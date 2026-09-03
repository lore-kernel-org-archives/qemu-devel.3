Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9390C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24uv-0006is-J7; Thu, 03 Sep 2026 06:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uu-0006dF-13
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24us-00070h-Al
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBW3212433
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r1ILxo6mmx63aRLirfFj6dx57ZFPx3gOEtU3qssEgDM=; b=jAh7ae+5CWXKHK1t
 1a4yvT160RLKuxkao5LIdElR+eMNWzYW5banlmw6u2yw5710k6htEIPcMJoWwQDH
 8rwcdcbdi19hCuzOj54ewGQp9QMyCJBMZOlXNrK2PRGxSsnOe34vpomixnSNNeZc
 D3Tkoua5bVJcY6cx4/rj6sqDE3FPVAEpkfGVmIklWiMXoj/8eA8rh4VCtm79070p
 lsanJEXlBpBx0CAVg2VNupQqIicZxg3tuy43Ry1UnMyCkrVdOkZh2PtAIqJbSeqL
 ljnPKj9YjLjLbyGAbZlcrNpvz3MeQuEgqd6vXs2OJ1/LSU7ZsuXQJXA+YxWphdRp
 IRCXvg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhfyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9382f9430deso412511785a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432207; x=1789037007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r1ILxo6mmx63aRLirfFj6dx57ZFPx3gOEtU3qssEgDM=;
 b=Ks9BzIMii6QjuEjqhDg8BHexJ6Hhku5bnF86cKQbUPaQfXKlV7dfwh2HFRpbP7gN0N
 tftx+IhykCFMSYBNQouKtQH4kZsz7cHHXiWMLYDwN25gvP2iMzcS2jJZDk+cGxImK6NB
 lsOQsB80P+pYmaJX46+sUPanSTrUBtCIdR74x/kZf/os/AScvKbD+lUwD/GXkXQuAlDL
 p+juks4w0/K+ZhTkUq0nkDLg1D2/5k2fsA9UBiD+EM9Pw32MWdyzB6DLjQUo8d9m2pro
 f0EuOrpsH0M+yo7+3cjsrJrUt2Cu6rH/KBi2dH4AM1CgjiODK1IoCBS5RnvL5MhsG7FC
 SLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432207; x=1789037007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r1ILxo6mmx63aRLirfFj6dx57ZFPx3gOEtU3qssEgDM=;
 b=aazOPzkSVner1uCUumVe3Jk+NTZw06wtuN1mDocJiYsojEGZ9LU1QouBlaZ420hsvo
 xbrrJMyMjtvw5tcvrWOSMmwcKtXmOSV3uhPFEbRuD0Gy71zbe1AT/8KrvK6agRSF81kq
 HNL5RS7oiwb8hZv8bQfTEqV2Bguq6DJzRYDHFsDaiBZVknQ/cMjRoPc/te3o9W3kSfp6
 f0CDFwqKUuYmu/WiUMb21h5Rg9TRnxY83DsgFe2fA2a8ClAHaKAwc+4iXhFMohWJ8CMt
 S53wdxyWk4SKgYMUJ85YdyWlGBoZLfvxBiUVwzXRWYoxHHkeZ0SZWD8Rgk/NAPyGAUkX
 q/Ag==
X-Gm-Message-State: AFuF++kkzjR144fotaFmp5rgE0PUZ5yTfqCOBC9a9+4yvCaTloFQM9FD
 KEi88/tRK98qA0OeGQTwV9HPBqwezBtJW9alb+Z6ge9a21qzt3vCF8keVYzeizlooytersxS035
 P/0b7tZjzpW6F7/vsFNoxUKGfrOkDzVUcwlfjdKKiFaOgMOQgTVFgjfjhbKzD7aT0wg==
X-Gm-Gg: AYBFou12zwYCZzSL1EB6qdKu6zQl1amroX1ztAon/X6nYrv+A4q1YdyTuu2ufVVBV3R
 yXT3YjOVQ0JSmECOKnBrY0EeY0rTQ1djKbZMe6W4nwe25NdNydWeww3Ei3eCV7mrDnKzMQiKy0c
 QNDkXgOISHouLlSCyULwkj6492CRd2ofg04aFfwnMarJgVARpXbtcRIfz9YeqWG/MHKZHq43H7e
 b+wtBDNLB4Zg+tP1IxkQfIEF59udFkGzAP3VP9VMFMLnjtsUTGx4riMKkYKS1T2OG85qe35J40S
 fV7dwY6Dk6gpFwHEaIkdzpHLBDTB37oIggD3NCFHAQoI+MtOlXDHdSYgNjiBQsZDBlC0Ld3RAsE
 lVvz7w88pIWd2Fob98P5mkDvWP4OR9nJpJ50/7/iU
X-Received: by 2002:a05:620a:178b:b0:939:1d67:2231 with SMTP id
 af79cd13be357-93960fb087emr1271849085a.34.1788432206803; 
 Thu, 03 Sep 2026 03:43:26 -0700 (PDT)
X-Received: by 2002:a05:620a:178b:b0:939:1d67:2231 with SMTP id
 af79cd13be357-93960fb087emr1271846285a.34.1788432206377; 
 Thu, 03 Sep 2026 03:43:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dec54sm73066395e9.12.2026.09.03.03.43.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/51] target/riscv: Constify @iprio argument in
 riscv_cpu_pending_to_irq()
Date: Thu,  3 Sep 2026 12:39:15 +0200
Message-ID: <20260903103936.62355-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX3VtSuyMZYK1f
 RuO8CVgAXpTil7BDkiCv3dEKN9KI/US2f/KU8fFUDyyXM06Rt5mHtfbf/2lqHJx9SL8nI+uroM8
 TumRGXJc370/TRcAK0l959VoLyMqvFSOl6Pzdg7GTONr9QxoU97JMyIqjVg04+kmK77tWaE1scW
 YNzYekjRFilxGvioh2JjgvRL4Ksg79kzz5iHWGp83N6lukeWunmDA/RhKWVUXSbB58m6csM3b7b
 /iBO+KFo2S3+xJTBSj+bi1ODK14kV7+FYzH+7mumKtH1nttquELh9d1y/wBTlC3WOInPSgtYSyT
 1cbyFlmUU2ANJB8tMryGxbPxyUGFsMbtSAUO+8IFI+TaYO0Gsu5bNxdgKk9sX7E1D1CJryEGdIg
 nkuHJbSFqcTsxfkHFbkhsWNZ48DYu4b0xlnNByLYaeT7g1t368/IIEg5fVFUb+Oq/lvQMcaviQ5
 YKjx2wInQmMcqzva0xg==
X-Proofpoint-ORIG-GUID: e52UG_jE55gw-9JM-MoHGtlpkXA4EHh4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX21v4QQwblD4+
 gptOLq2W3kqDtjpHmABK+A8zOBtb9lQ3TsJpKDJHpDAUZqEk1bea3R4uU34UbrefKT4eY6L7o7/
 wDEPGEFMfkyFKUiyygzHtm1MF4Eu0Ec=
X-Proofpoint-GUID: e52UG_jE55gw-9JM-MoHGtlpkXA4EHh4
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994f55 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

@iprio[] is an array only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260901095229.72018-16-philmd@oss.qualcomm.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 718b66487a2..b974c2f4b4f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio);
+                             uint64_t pending, const uint8_t *iprio);
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a13177b7b77..fd1afbc7fe2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -869,7 +869,7 @@ uint8_t riscv_cpu_default_priority(int irq)
 
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio)
+                             uint64_t pending, const uint8_t *iprio)
 {
     int irq, best_irq = RISCV_EXCP_NONE;
     unsigned int prio, best_prio = UINT_MAX;
-- 
2.53.0


