Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D5606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ePCHZldG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HdL1/E3x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI1B-0001li-Az; Fri, 23 Oct 2026 12:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0z-0001c6-Ea
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0w-00030s-UW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:09 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5s9F4072757
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oa7LmP7wYWRmC/5aR+wNtnkHnznaonhU2a6dl5HdFHk=; b=ePCHZldGfOCVRge8
 O/+JC9Ew6QJlVCNoKaWYt9HOo5oDvgkb+1Z4eR8rHiqOEoEEUklKZuGaN22eexJn
 bbttr5eM3vXmbtF6uebfLct5Aqq/tfyjEhMiUYTG9GMjf3ftJDDkxthKGauE2H8H
 4QFGuYub0lputL/OKyJtCHPbhVeftxSlAP3BBNDNRokEyufLoA3LakhzgAnYxrfW
 nM3+PPG6snk7w4XMWmXlkDLfoyPIm+XC4w2XuMBD4TacChdX4+zRXB5iK51800g5
 YKoQuqr0CuLS6iFUaym4vMHfcl6Zk5MOzJbXtEb2MxOt6T/Yo3l8SPC87LdUJvlm
 ANUffw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0xju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93dd3c3badbso266539385a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772462; x=1793377262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oa7LmP7wYWRmC/5aR+wNtnkHnznaonhU2a6dl5HdFHk=;
 b=HdL1/E3xyKUvz7nsJVHTJj8CLAuHXKbv7aeRxq0Fvv04kWkxUqZE9iOyZpOYsheNB5
 ey9mi4q9N2xHyqldgD/uWyoeGVqRSZaLIbiei1tY4yTmnn0vGVlELCwK5KDW5H5sfKEI
 MqOQEGuClpbjyamLBndeC0n5OaHskydaOgmTMhziKViqmjDkDxsfBoSc5/gh4KOZOqNv
 ou72kIGf9oLYUC2OcxKnRwN9YwoFCXK82IbVtkwwaf90EPcgRRrBO3h6JrmkuQba9dR1
 ZqYVwcsnruCVnDe55rhRjNiETRh/PPHw5s3qOo9d6h5AKdUku/VNOzLVdwn46kvNzH7L
 dvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772462; x=1793377262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oa7LmP7wYWRmC/5aR+wNtnkHnznaonhU2a6dl5HdFHk=;
 b=u8/IJnYEJ6GqZvES3esN4/5rY2xKC7siSLAY9eSFa4uIly2O8tVHBFJRrYaExpqq3X
 OO6mzNLjNxcbYR6UTp4yrLbF+JDqXCDdpjnLg7Q3/HiJTwn90wfm//aqQnlqRb516A84
 pY/Hh5iUpxW6VqtjL9dOvZsiPLfzhXqa3z6EdAjdH3DRmapqzAr4PjlSyNGglCMAj5G2
 iQvRs0PwHiYqQgw5qdswCfeqx38UhAcl7MaE+Zp9brv2X8I7vm4ffLyP9WHfBwlzs0uj
 UL75ohzZBKPLM7DRImRl7S44xT9mfh5OVruyRhrWqpRxuitHMsvRYNSiDSy8p9HkUrtE
 3WCw==
X-Gm-Message-State: AFq9FYLJ9DB5V6xVGl4MtGBjc+LaP6GTvwsIEvZ/eC76Gt+c+FZGd+SO
 oUiareBlYVj7LLnslHeEcnAI5nSUNU8Xf024nGcW+CbBGpM/sPlzDCW4+OPeoAZYWlKPkiWwm32
 nGqmdDKL525KsYyySl5jEjIt/5DEpaMPZ0RJXXHOcuI3X879Qd/dRFxEJb03ErEjRiBh0
X-Gm-Gg: AYBFou1UGMutS1Fdfho6oCEq4nvZGxomNC7EdZI51p++BqrEElVhu9DzHwbpgjDp0yT
 /ao8Pj3jClKqwky97eij7GfNM1kDPhwp1asOQr9iZPwiQusxpDH36t4AjpIhut9gbccG1hJciWr
 WIjrDzhsI3J8zEyJHdKO4LwwBJq6teOruuTLEKgNcv9VCRJVyaB8aJnPE7J3l2/zhzs1UHQB0Rh
 alF5iStH9PjTA4sgEN4n+aWNvD1RyUf9DmXwN6sXWPMgVkagjvb0Gr6W4cKbLawb5fp6i5l4vml
 WC//VWogqhiN5Mt5/rGqaf6k9qmHQRdaHqCYDdxmgxiPcQkEHBIYBJG80hRDYtBKNzdTNYR6WF4
 eD5e4CG3gNYZUvYi/OOpQ/Fo3R2p1IiJOyVTf0SUa
X-Received: by 2002:a05:620a:601b:b0:93b:d7a2:83d1 with SMTP id
 af79cd13be357-93f6f842370mr517060985a.64.1792772462282; 
 Fri, 23 Oct 2026 09:21:02 -0700 (PDT)
X-Received: by 2002:a05:620a:601b:b0:93b:d7a2:83d1 with SMTP id
 af79cd13be357-93f6f842370mr517057285a.64.1792772461814; 
 Fri, 23 Oct 2026 09:21:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42f4c6sm711265f8f.59.2026.10.23.09.21.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:21:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 62/83] target/avr: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:10 +0200
Message-ID: <20261023161332.60153-63-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9wbqURs8b-hGX7eDEqjrEjuxmWCS-N52
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX0T0FhaO4XjXz
 g7uBL7QgxUiBNF5han8mtdIu1TxfwW1R9FozTaVBqKzSe8JPPEuWSl8fFkPgi/o5hwtwrhKrdzl
 4WZlojuP+fN5z2sEvc+g7zFZz+HYoNg=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb896f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ya3Pk_hNRNhBRN_1oewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 9wbqURs8b-hGX7eDEqjrEjuxmWCS-N52
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX1dqE1yy01I0+
 pQMoFMJGeFvbdcm/96n+gNf7ppay75jq5rHrA+c08vqioBvJHiiK3BgUHBLJhttc+Vckeee0koI
 GxOnKm4fwbWn7GHsWyz5jIg0Eifu2jeinHh/ZQhrQ8Rhcr/wg2XXEEpJQrc6q5HGrY9tVnuMw8k
 uuUMV7s8MGeEFTtkHHaZV8l1hZiwWwzi/yku2ZkbJk3pY+2fmoNmLPpkI+KEMDuhaHagWqnxUxL
 rCqf6YTFoGGrOlWWAfJiWyB+ZOXE2jPTX2Fk1wX4w71V7ZShRDhWHbHmiAJVkxOU3bvc1ygyFj+
 9Y+ExmznDN3q8GFwH9m3hPVZ4ZsMT5b9xjYwC5yS/6DJ+F2jR39Jf7fkgVb5wjssDdhvgNsYMcy
 rw06/Hzft3Td1R+V7zwogghQaGB1aMCY6LD7Q0W0wUNT4hV5zApSrAYjKrDvZC3Xzr9qvNtRGaP
 rx/G3Vgvsjlkxrwpp7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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
Message-ID: <20261019212046.149572-4-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/avr/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 8f90b8d9a45..49bd2f57c9f 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -159,7 +159,7 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
  *  helpers
  */
 
-void helper_sleep(CPUAVRState *env)
+void HELPER(sleep)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -167,7 +167,7 @@ void helper_sleep(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_unsupported(CPUAVRState *env)
+void HELPER(unsupported)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -183,7 +183,7 @@ void helper_unsupported(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUAVRState *env)
+void HELPER(debug)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -191,7 +191,7 @@ void helper_debug(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_break(CPUAVRState *env)
+void HELPER(break)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -199,7 +199,7 @@ void helper_break(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_wdr(CPUAVRState *env)
+void HELPER(wdr)(CPUAVRState *env)
 {
     qemu_log_mask(LOG_UNIMP, "WDG reset (not implemented)\n");
 }
@@ -281,7 +281,7 @@ const MemoryRegionOps avr_cpu_reg2 = {
  *  this function implements ST instruction when there is a possibility to write
  *  into a CPU register
  */
-void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+void HELPER(fullwr)(CPUAVRState *env, uint32_t data, uint32_t addr)
 {
     env->fullacc = false;
 
-- 
2.55.0


