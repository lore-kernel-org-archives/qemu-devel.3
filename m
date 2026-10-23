Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB60606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OwPslWQY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W6zTLdYC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2F-00059l-4w; Fri, 23 Oct 2026 12:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI29-0004dB-73
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI27-00035j-4o
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6NKk3000254
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EPqK9FgncInfBO3cy6uZq24qJbp2xZCnU/aGr3kwsJI=; b=OwPslWQYfCHDtofZ
 lRW/SwJpfkCv/YGs6yLTv65y3URsrEG5nZdx8087b0pSkPlQJZWatq/m0x0F9gNa
 OvRaEypD4m+Stqx60VIoTCSvVsm9/OaiOeIqr/bWVA0ZGNu62BI1ueTQyP2+ZxgY
 45+ONI+tdPBpxh6cOn4ZjmMnvbFpp7eu4OhkncLCMbL0A8yqDhF6UKCIIfADzvCf
 9SNRFlHh6+7fm/bYd6Yz1UoiYISb2U5MsBfmdmb0d47oDcG6sJPU53ohMI3XHL9s
 guZz5elQwVk5MZsXpMthBigdbTTzrmfLUmreNIsmO/ONnqRSKuaHO6ihzkU3gaWP
 FAgm6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0wg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so198596685a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772537; x=1793377337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPqK9FgncInfBO3cy6uZq24qJbp2xZCnU/aGr3kwsJI=;
 b=W6zTLdYC71kC6jsvodjiP7C8zpzpbO/siNBRDCkcj1EW4lVPIGzn2Hg8NLo1c2O9hx
 CRhU1Wi3Vfs8oLtmJ5ZoVRU6JldNQZsFWBYqBIUHmcTAFQJK6MsVvshponzFBsR5zwE2
 L9jeBe3D02UhM+haqjhk8I53xkWNqrfo4nBYaDspyAbTYfqHsMGHzSBvqjhuVs0pgLsg
 DBeyLJmrLEwGgB0Zq6GcwXT44BzpFuakneDYVmhUbvH3aJ1oNnZxXR9UQzl8aGuWVLNk
 +QPoYk43dc3aPZWJ4vkQMvCwUJ8kTrNCzVyAvYN3nTvvfkUlUY5hYTJnS78F1/C2qsg8
 E55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772537; x=1793377337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPqK9FgncInfBO3cy6uZq24qJbp2xZCnU/aGr3kwsJI=;
 b=VLu/2mxAA630MQBK8st/M/HOQmlrNQBmobCEvE2/kvVfB1m68jElJ6DqvM6gGS/dWT
 Vaxzyve6d9BtRnf5nAMw1YF/aW41++IcQeCpBNMWhttUeM/EPqdd+obJNlUUkmygUsak
 rHhLKBH75xDBiJFCDV8RtdWJpEqjh1hUl6WRqwrN5KEkXFxZxyZsEl3i2f+AUV1E4nLw
 SmzhxdQ3sxafmv6ceTNbMQdBWz1TWt5SHTfUqqWGy1OdGtmudDRk9QNLpT7JBBkg9n4W
 owbVbEloCNkEvecibd3QV7XcqymriNS22ascH0PK5OCNlL4+RLtpI9gbFGdN7ERoiEJE
 UflA==
X-Gm-Message-State: AFq9FYLdFDzNK10WdE/BoqAOOdQhUgbRAC1jl+g7FIhchmT8CJ4J6uYN
 rgyXp7636ziiO1c/HU/5tjU52uAj19s6C+pQ0ENY2nk+Az89sNjjioFNxsetS/+P7GGC76H+TyI
 ziDn6qnaYisx1MP+P3X95gKZXpB0GNksjMN8ly1UuWAO68GknZUCWlK25atYjaaUZlZth
X-Gm-Gg: AYBFou1OBCs6wgOULnedzwPfXM5HY8UK8+F5/3SYl2oZRqxJkOn+Z4I5iT1eRdBUZSG
 rtTQEvgLIjaZWRxrgMAHVve/A3swvM8DO7HpjmIbmfRwcvSSHvBXphAElQp6OOYgY0qqymPmrNr
 zpclWAPbdxSz65ROushSmcDPYadezMeTXZZSYuVe1mZB8XrBXg3NmJiaHF9j4+EeaFSKmfgaSlG
 8hsp/WycJNuoeZDueJRnTZc5RGBB4QEqXrQqN1mSax/jZmLBCWta7nsq7ntgt1goF4wNAe02oLv
 NmRIIe+pzZbTyckjq4iOKzKk6cSys9DglWCQmWdW6wHRgEWD1PtOrGCiOfH6OrbJN5v3sCx22N+
 sW/G5SbuyfiJFTImdKCqru41nBpENHsSQFczFXFlT
X-Received: by 2002:a05:620a:1a05:b0:93f:2b23:4820 with SMTP id
 af79cd13be357-93f6f7bd38emr528855185a.48.1792772537474; 
 Fri, 23 Oct 2026 09:22:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:93f:2b23:4820 with SMTP id
 af79cd13be357-93f6f7bd38emr528851285a.48.1792772536969; 
 Fri, 23 Oct 2026 09:22:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f9f28sm776695f8f.21.2026.10.23.09.22.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:22:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 72/83] target/s390x: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:20 +0200
Message-ID: <20261023161332.60153-73-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX8FdBbtwEjWeB
 5KTalLuXOGaknmSfXHA/RHYC7bj5XQ5Ee/qHf9Db3q1cda6+j0kCByb0coTbsChttsHlRhcg2I8
 U7Ea8MMAT0FcEb9r1Mx5UCjgvHsJx5n0K9NmA2QfIMXBk0XF0BASyUAOz99wbIwQspao5878Kwi
 GhiL0x4j+0cpH386UfukI+F3QjZMq3CI2+W753BLd1yFB5eh25zjClQogTYYUF1Ut9GtAYKG95Z
 vN0ogHLi97IfH/OPAD0UiL9T/JIeJE5CR7yX21sURADEgvAXlgdV2HLo2G0sC+nYfZbhr4JhDja
 yws/mpiQlhtNNvbgjXo9ym8PLkTKb7LBiRrD36BCdPQujruZlbshukL4RaObZ4evU6QHG70ZCv7
 9zWh13bZxoMQuGO+AgMKWz6mLSK4NctUQU+nmEEu9vCf3DxI5K1DmDb77BT7O5iasQS6gbhBEip
 ykC+ka84Kr829EJlQwg==
X-Proofpoint-GUID: LK_JbGBSB3m4dNuLrTbpb6mDYLwPD3O6
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb89ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Wv-XcSyDAywttTPMHZIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: LK_JbGBSB3m4dNuLrTbpb6mDYLwPD3O6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXztfmi/5ZF5o/
 nRlwedaAVVMn72Sl0wEJk02CeanSPfFLPpagQ90qpgNXqIdMIT/P9aooQIBF4m/MX5hg7lLuCRY
 epWIWfvS1+51JRlpJnNSOqp1GWrXesk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-15-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/tcg/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 414e6838c87..baf074240fa 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2488,7 +2488,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     } else if (opc == 0x0a) {
         env->int_svc_code = extract64(insn, 48, 8);
         env->int_svc_ilen = ilen;
-        helper_exception(env, EXCP_SVC);
+        HELPER(exception)(env, EXCP_SVC);
         g_assert_not_reached();
     }
 
-- 
2.55.0


