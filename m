Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DE606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=koNfGauZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KrE0QCGq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgV-00047C-Cb; Sat, 24 Oct 2026 13:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgN-00044w-QS
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgL-0008Kd-QP
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExrdE2960295
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tJcnEjp2JFf
 q83YIQtvS8syAkqEsXLmZulMP9ZMuHAs=; b=koNfGauZYDmWRq2UIwk+UVTWpGQ
 5n8zQxd7ucUA1sf0V99uY8Qs+BI/MGYl6sRcPFD7YEAT2IlEJx1/4MYZzFt2CKyy
 ndWIen5AFkzZIrCMOuUKjTz156Xp38TILccd1uZ4xRYk/GU2AWQTougZ9yfVs2P/
 MHgoFMV3J1qQjlbuk0HI29gDS25ZDR/QMi7PeH/HbJfhlaX534Pc+Te5B6pF0cr3
 C/KxIC/+xi4jHeRyvmz/oVs9hf3Av19Brx5v5hiBkwqDzFyk/S27dqbE1cmNgFep
 cUrWp9uxZ3wAhhvg4XS6drs2DLGJiENX2CmnvM8yRPa/93gUCV2/LHLv4jg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgssft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ea446ea8c9so20182055ad.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863433; x=1793468233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tJcnEjp2JFfq83YIQtvS8syAkqEsXLmZulMP9ZMuHAs=;
 b=KrE0QCGqhM000IeZr2GCSw7bkpOpY2yM/2Lmf6Bqo3SnhGhPNexPpYW9jI6RS687NW
 v2yw71Yw6dkeFAZPQ52619GLa5AwZpqf8VyZTHaL3k9NKLRqoc7whqt1UXDGmGqy4y73
 IltJiPvVPsORitxpotMCRuAgI77W6IEb7ofJpUYK0iV+XCYQck4N29f0ot5iBIF+F60z
 xaz1fy2/m94C5BK3cddJjQ3m3SPRM/BNG0wXiSKZhSCpIqhs5w9V5DgvQaeew8uEIDjr
 3lgC/em4zK33Oy0D693A9+mfFvB0NGnggRLMk/7SbX3wIHlqE1kH4QP/Ly+PhAu42hQ9
 Kf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863433; x=1793468233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tJcnEjp2JFfq83YIQtvS8syAkqEsXLmZulMP9ZMuHAs=;
 b=rgVUUo1S5wVru3/FWlU3TibfHtdhlhc4VQ1sggb4+eyVupJXrc3+joYEPrH0/nooxx
 ta7JmJikubSuMMISSByQz0AUFyAbLti1gN8QDClAsf3Eyrkz3ff9Zg9kpQ6lP7HNtUTO
 jGMH0sUbihyFVhDnNSO4XE11UdawIi3gr2pt7iclnc3mKL8HIhRSMlPOgxJbvm65lZSR
 r6GchjnGCqLTuRw4zXQ6AqdewJnNz+Szycq95Jblv/MVTmmQXOCAcJAhdA8k5z8SiO76
 geONI2BZLmH5dgL/lj0hUyJKkg0YegAP56gyURS61hDMTpabXPSV7Nx1DrtemP6sTMZX
 JmVA==
X-Gm-Message-State: AFq9FYLoqOeMYGbYWPc6H1Oo8CqJNC97vaV/slGCi/CiQHRgb66wn6m8
 UbJg6+iDeQ4um0t7maWdwEU2RhFrscz1c5AXZ0us9UPuh39uXFvzvNLMefuDfQ6rKKmfp4VXbDz
 zTZ9wrfoaDyfZgNQrL/uttCEQ0GHzAssq9uE4vvH9NkQcqMdr0ntZvXt2b7dXexW6Mw==
X-Gm-Gg: AYBFou1SJ+CekKSAU1xaKTZgZuZf5G6xbrGb55GOtCKZ94D3Q4WjgIWiAcxlwSrIXJi
 QoM1u1hhywJZ7oofj/reKhDm7TZTLutJHAYqYlUkOBhWnL6oupm+Tsi9TGFPP+9xImfIURUMPKd
 J+KaiM1pdo9xV/SAIqJ/hbqzh+cE/W26Sf31EkXkhBAiUxP4ie1jFYMm0A+uVHNeCjoiKPDkLTE
 dTfwr0JdqmzC6+CwQoBScmJG0A+685ogQQUnAfDg4LvIELNEtyVSSF1Z1TgmzxkUdumh/FSKbjv
 6PjkRThJMfqljJDsHUSSqbk2npZJuR23R4tH60Cvqqwhb/zcZDXAHoIP5VTcelKQD1Jg52/HhhG
 sg0SC/DByQHV6sE8bb+Gm++MLrlNeXw6weEb9M6jCYCwcFi7XZSQCuMzAbcad+ik=
X-Received: by 2002:a17:90b:2789:b0:3a7:cffb:8b8c with SMTP id
 98e67ed59e1d1-3adeb695712mr1458944a91.43.1792863433554; 
 Sat, 24 Oct 2026 10:37:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2789:b0:3a7:cffb:8b8c with SMTP id
 98e67ed59e1d1-3adeb695712mr1458933a91.43.1792863433079; 
 Sat, 24 Oct 2026 10:37:13 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 19/20] meson.build: add riscv64-softmmu to multi-target
Date: Sat, 24 Oct 2026 17:36:48 +0000
Message-ID: <20261024173649.7405-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX9u2AEQcFDYud
 0FzUJKaeBEVxF/Tnw4pI+wuByLqWiP9B5Okg3VnAROCgSj4fqE1c+hWd+VM4fbmpkDfvS4rZ9mT
 EYhistgSIVSchr/PQYYYWiWt9ZcaJzI=
X-Proofpoint-GUID: vfVr4B0JnY6m8TFkUbBecjFyjqUGYAbD
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcecca cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=qhnqrPhcNOfDR7KW4t0A:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/HRy13NaQs1u
 wGF+5XyI1buQ0L/hFwHw/WwkJ0d3chAId22QastbCkUOHI/nR7kv++goEY0f1rlL/1oJ4/dMXEQ
 9y1iIWH0ite0Rok3QPxEWSs8zb8qFgp/aJQFqwQ+ot6E1cXFpcJnYOOqjf87UTDOvj/BY9BH5yq
 l657pKuuWfsWhrFAbX8ND74tzNyLwdEHKSwaPBQJ5tm2m+noRkpbCyBniRpOgOG5w68H7DZTevB
 elS3+W9wrdEKrL4+oL8XhJRtq/YE16mLvvHCdfTHseYDnnII61jJ6C9rrJ7TCq7gy3ZczjdWRvH
 e5BpkYIWxIjl/VvIsxMeoNpQgj8h+GAwR70BSnnPrskloRxXk6E1j4jclKEWg5q1J4UqJ2xLZrY
 lhhRupmwUWl2S+e8u0ArlaczuL87ms07ZWye0b6TmGrjZof6zN7tSmuFxC212ezUGdpm3rdyK8D
 SbV718mBi7vt1jdCX+w==
X-Proofpoint-ORIG-GUID: vfVr4B0JnY6m8TFkUbBecjFyjqUGYAbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-9-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index ad537e0c18f..cd328251829 100644
--- a/meson.build
+++ b/meson.build
@@ -4278,6 +4278,7 @@ multi_target_supported_targets = [
   'm68k-softmmu',
   'microblaze-softmmu',
   'or1k-softmmu',
+  'riscv64-softmmu',
   'rx-softmmu',
   'tricore-softmmu',
 ]
-- 
2.43.0


