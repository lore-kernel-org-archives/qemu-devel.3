Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD241C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjRew-0000O6-0p; Mon, 13 Jul 2026 21:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjReu-0000N7-Fb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjReq-0003ii-VE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNmeTj3007684
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2eU9v6pv6WfPzKOISL9RzdqH9lYuibIax/ORintYNUY=; b=SF2gVfoK8BZRJ0SF
 yEBYFFZEE5Wp2n5zKGGLJbW/aYP3m2HLpt7C9Lhu2u7Hv4HQfKN0OOIEA1D1+6KQ
 RsJlKgkcsg8Gt9y1H8RuKBnvpt/0+SLZ124raTgMxHT7ovCfYJqwtJ8tRbRm9Nfq
 XGPSx9GyeL9o3zG2bugj1bIuQ3/w+XbI1VeGuDaMhJnon7/9xBvv83pFWre3vX7G
 jWS6Y3Vjx023EJKY0r7rmTWyI0u02t+dkt29UyPN5XtMMNA7LB5LJkd0zl2Nh/EZ
 04TXbAE/d2ZawMQDolYFBdK3UcuubSi5nuyFVlnFnMFrLLt43eVtq7wfp9zOouqp
 eyvrbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj03rf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:09:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381abcccbf4so434205a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783991398; x=1784596198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2eU9v6pv6WfPzKOISL9RzdqH9lYuibIax/ORintYNUY=;
 b=AfjU7lr38XjOkgYa7ep/PMKbqVjLxfS/o8SGnAmqFzHn+AXgOs7O7D/BIKsxIlkN6N
 mNq7RrYBnOSQMywHnT3kZuKukNt/nSPkAPv14283Fs0X6aL5SFH0e7BXX4Oq7iuz4yxo
 slZmJqX8RHNNESvbWjywmBBmH/Cb48U7dZJ+ZwUqkpgjEt45JupcuCNoYmpzit0poqqZ
 cAJ9bwCiwmGpAKgeozDkz7NfB4xvD0KuvPWjrKggMAIqwaUfaqrnY7lh/bgd8blZHx5s
 yYHJ1/7oBjOxYoZ0ElrE6yc9QsOSSnJGYI8EeNTjMxMwv8bAWmcjBvIYuJQbL5qPZFvK
 +SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783991398; x=1784596198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2eU9v6pv6WfPzKOISL9RzdqH9lYuibIax/ORintYNUY=;
 b=PJ1sGzUttoCvkZsxUDAWRd8ubgAr/2trIHOb7osJCBucjii9ArigsUV+wOKYjAku63
 H3OEGBbb+t/NTSAclzI3WZs0IVKwX+HjLH0n7J96tBve+tZq0ZyY2l67Av3WD4Eg2mXN
 Pt9miicXZKHcfqwP+rIteDJi1HJAGSGR2jTWh9YjAekzabG/Kde63NQPbx2+laXc5Djy
 Rz0p6sxZzVnDfADILhFzjVjMjJMvrkhkeCWElmKGm5vB175qZIVaUo6tU6BiswqF/fYK
 lDHSfcvI5iVnUs5SupHtoy/0X9NrwRGJtECknG2k2Qb/32kgJ5M/m8fRd5hFCxS2+B1t
 K6Ww==
X-Gm-Message-State: AOJu0Yz5reR59nNYRreWXRTi6++D4XUIKntKEWMi84M066/zruP8Yu/8
 KC15+Jx3Bvj8FwF2I5s1LdzQ/EnTc/za9CdHUBOfstbYcVBDCpyGC9ea0iSQsebIajh/mBMUXJX
 BaJGrqZwb48hKJE6Fw6bDxLsgGkpq8OUDO3NJCgGhxV3ZRxzSqQZ9dRREsot/X35s6g==
X-Gm-Gg: AfdE7cn3UxQ6nsYImf4s6Di5tLhRr4zEosWmdz5alWJGYxyl6tCMx5chKCXDr4Xqt1g
 On5pJcQZZ2iq2fa3+ne483wrGki9Ji+Tu1P977385QboGLof7s/aSWdx4oLPSYnH+dy80xHZfdp
 zYggdeXChDhZ7xE70aS2ZTukbX/g/IdqiE+Q6vZ9duFp7wrnVgOWHWNe4Do0PTmLakqfMhrF7df
 +F+byHPYAhwlQ/WOLDbWT0g6TlnVVlM47Ccbwvq5GU14F1D1Q/8DXYWrXFR6ejRCeI8X0lYo5AM
 MMcRcH0GK5IP6A3nPxbu4vgXcwJm5RuwURJn7TJ2HKB/gbV6iy3oi26fARo86D6UHbgIMIlQtCx
 fZOyz4Fo/jQ+wyKutz29N5WbLZwBUv0KVftbxKewCu3U5DcLXkUBZ0qRcoAo=
X-Received: by 2002:a17:90a:d88b:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38dc75e3d4fmr10239640a91.12.1783991398515; 
 Mon, 13 Jul 2026 18:09:58 -0700 (PDT)
X-Received: by 2002:a17:90a:d88b:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38dc75e3d4fmr10239626a91.12.1783991397994; 
 Mon, 13 Jul 2026 18:09:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76826246eec.30.2026.07.13.18.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:09:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 1/5] target/hexagon: handle misaligned load/store cause
 codes in cpu_loop
Date: Mon, 13 Jul 2026 18:09:51 -0700
Message-Id: <20260714010955.2226493-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
References: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfXw6rppbj9u366
 oDS2rSfddclTP6JvO4i4LAKNMm0xmuov8qi/Y22D5Btny5KSU+vAP+g715tuA3Iv5o1Z/Xv9Kny
 BnPXq+8bKdPT+gtDRPfAWUUj27oPX6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX8Oc5+dwby+Yk
 n8CWEiqf7tHgB8B/yL5q40u+Il6dvdxywF+Pe1he6VfC0oINw4wZ1MQtWNTNqoLKXF4pRkTMIlN
 9IhgjyOO8llJna9CruIVSSG+DcCSkf4ImGEQjvm6X0uN4d85CgDcQWpQn/Lyv9ODPHB+p9a9khF
 pEEPEHbviSLhejnTE7lQIebG03xzKJaHDbPGOgGFzlWt8DCXr1HTJhaqfO/ggzueX06tI/BCWNT
 DX7ETmarLRd5oOJmVu5rmpXpXAw+2TpfWUNa9zF+xWPWoNVXyjEAaA7y8cw/gMG0Cz4VQ4FY3IG
 nGPD3wzSGhi+4hZFmv49zWAY2IHyPeg+mwea3Xb3OsMM/1fqeUoK9HuEc9XeR5GbDijmeKYW4y2
 XSwRh1fhEjIcklQa/5AbJnI9eJU/+99Kdnt7obHcUd7j3LYI7GqogVhS93rHXTYkC0eF1AyPo0U
 yZHH59gB+7Nu8EqPcjA==
X-Proofpoint-ORIG-GUID: Yo3Rp2Rhl9tYn2Z2Oig4-1TTC6OXolOm
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a558c67 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=tYl-21R0sE5cWuHd9JgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Yo3Rp2Rhl9tYn2Z2Oig4-1TTC6OXolOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140009
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add a linux-user cpu_loop handler for HEX_CAUSE_MISALIGNED_LOAD and
HEX_CAUSE_MISALIGNED_STORE, raising SIGBUS for consistency with
hexswi.c's sysemu handling, even though linux-user's own alignment
check in accel/tcg/user-exec.c currently raises SIGBUS before
Hexagon's cause-code machinery is reached.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 linux-user/hexagon/cpu_loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 0958c51fbb3..d7f73439dbc 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -76,6 +76,11 @@ void cpu_loop(CPUHexagonState *env)
             force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
                     env->gpr[HEX_REG_PC]);
             break;
+            case HEX_CAUSE_MISALIGNED_LOAD:
+            case HEX_CAUSE_MISALIGNED_STORE:
+            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
+                    env->gpr[HEX_REG_PC]);
+            break;
             default:
                 EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
                     "cause code 0x%x - aborting\n",
-- 
2.34.1


