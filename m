Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A6EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bH-00011u-OD; Fri, 10 Jul 2026 02:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bC-0000z7-Cg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bA-0004QJ-0O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3modM3629759
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=; b=AX49zpkrCjfPQJF2
 DpA2p4jRme3JFy3Oudu/CQQf7plw0QAxUcNtotc4hVJF+hlfsJD51YIYBwHycTVX
 hAiZD+mEcVM6NuckFB5we32tmzraso/q9eJyK1Kz7RqbqLOuMtqF6DaRj9A1qilK
 9G3leXRS347B8w/85asuoiv2xZsbK2G6XiU0mN6H1Q+gs9xBa0omx+zdX5w/rV8S
 7RgZPkfTV7zmgvG7Z6QwNrT5GJiwSAIUSf6G2cHVv6pIffunStcmlaVvBbUPp58X
 zzP9wgfEwLQ+Life1H+3aHHMDofhV3fm+rCSj5/++ZqR6Stvwmmkr9qYyPNPwuNx
 Rl9lgw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hwt0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so457630a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664429; x=1784269229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=;
 b=ZeJC99BU6dMwVtoOcz6NGWr8D9RPH6qwhcDr9MsuGAO0mX2W3xn2aAiMO/FkI0H+26
 EYsT8GgPXF+2A/DCttO8+4hP1mdP3SmhaPCNl4O6Py7gMirnfMznMpsiCyK1HElM5SsY
 K+D7EFvvs8Cx0FnRFOLd6ZSvfsgFm4egMOe8jpQKuMUPapG2FJrRLpZyWyvwBtfiM46b
 GM9/G9iN8gIYUMobrJDIgjqkc/cI/64gKfe4w8lK6ZXJfTnx0D7dGMI+d9We3rf0mVen
 95xcf/veyjPEWOysBt4Nk5SodmJQAyqR7lCIDXdy+MjvhF7W7374j93u3O3qZd1y+5IR
 gU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664429; x=1784269229;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vx0cllOobbsXPmwrjEPPycZdYDN4TOMh5YcxFe7w8PU=;
 b=D1k6RjxOWH8lQ/UoY9PdHDPBDZvC1RSC/VpaKoOBUwfz1hDR03rwCexTeS0YCTfqu6
 2tbjSNEBzo7qDx/4JLpfosigRXyuTUjUxnz4/H6q67nauJNMQfoz/9qpKYqdf3y2exW7
 otFPbRQIlVuLLs3bowJAgZxjJPxPItmJ2/NSpAI4tagvxEpW8n9X3JNbKt8yOL4yDTkj
 wwROrcybO94vcs4iEAtp/37Cie6QwLZk5lcpluZXogMHXEk2v+OMxvuyoj2Q5r/24xhr
 WErF72HieAMiiWINTWptc+z5MgDv89bjtWVBflQKchJ43Z7r9o4OplKjIH+L6EWJPErb
 815A==
X-Gm-Message-State: AOJu0YzUxuLduHbEKZzUcEueKiDBh/OZRuzL5GLFbsSqDKSXkWocIreJ
 IV9eAnVCYJgX8AB48vGmVBNBeWnCW+7WwTYWvInEEIMNXI1GF3ZT2m3EzRsz8UO+1WftKAd3KsQ
 y96rayugRzNzwnWXOA5GsK14wx+Vq2/ngxEoczoZh+SCNaat+4T8eQI/MGTJBh9Kulg==
X-Gm-Gg: AfdE7clK/2NI5O0wpqUgZVgA64spGnfK4pxR8VTO3+bG39BqY/6oZ//KlsJ1cB7NV9A
 R+nBYoa0QMd9ij2ID9nv214NGGf+Kg81r21lVQoSwnDIQpeG/GcRie9MYn22GOkPYE7tlEN4Nop
 cBtMFykNihmtWj56H4Oh2kCHxa/+MrJ8ur9PKOAMQWYLidGa/HP/kGpmbhsTLa7j0bP2xwPlCA8
 3Umc40Jduh+u/Z6UBfVkcKAVitCDePVRJBFQgFd5pPa22S7KEjeIxvpvX/s+eXkxX2X36c/4s6s
 id7Ggp6zmiIJ/I90xLaBAQ3jVe4z2S+7Dmm4dBWK264307bRtdQiiKRvBgwgoGdGViPAI95FbhI
 lOlPxKpNGWvfxD1Xquv4EJMk5+SmhMNIVqioQZwJaNzs0xEZGc3/ZcgHlC8o5kbI8yVnGNxOabj
 L+hRmvqA==
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c19:65a1 with SMTP id
 adf61e73a8af0-3c0bd23f6d1mr10659507637.73.1783664429176; 
 Thu, 09 Jul 2026 23:20:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c19:65a1 with SMTP id
 adf61e73a8af0-3c0bd23f6d1mr10659487637.73.1783664428701; 
 Thu, 09 Jul 2026 23:20:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 03/97] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Thu,  9 Jul 2026 23:18:41 -0700
Message-ID: <20260710062016.1818125-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FL3cmz_G9Vd0_0mpI1qMVzaeeZhj4Rx_
X-Proofpoint-ORIG-GUID: FL3cmz_G9Vd0_0mpI1qMVzaeeZhj4Rx_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0daLANhaavTB
 1Qag53Xtl0V1mcwxuB1JRHpO/TTcZZ9KE5wW5auY2Q14GnOP92ykUucMdG9VRVBY/sXnPNJIihZ
 DnPYHxQ//PbIMSIdOQyISKjcq+0XfoU=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a508f2d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Fu-9CGv2gRfvjT4HfT8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX1asgk0JXreNJ
 +cM9DljPkDMmkNAkGAVsNrdkpsQfAbQtTeYXYUAQWOD5FSHSYTgiOI34c2t29Lv3A/2DGAM/OI6
 yNlO5F4NRcihL84QrujCD/rXoRZqOlaxaIyin+QbgSXt9E4y/PpqkuH6rtCkUCOLSZUcdEhb2C5
 G1HncYM0qu9VtD7BcwiCWvFjnuzG7hsoRGWmd6hXW24knBPdpPIy1/fpTpnpwtP87ifKG/3G8mu
 zs3sWr35TZz6huV3Cyy5ZtE2VSxApVr+dcgwSqi7y6QoasreXAUgFGFQTGAdMWTxzeLFtU+Zi5E
 16fJ+g4Uus2ESUA9kAAenOuwkxJI4Ds+3XkBX6KzHqR/gfXV8YmtP0Ov4ey2XUw79NpUIpm/mlB
 nmwdb93KX/I/0O8WfEp8k6pTplSfxROvjh1byjP7GQ5vorHQODEc4kJJTRMbD0hMYX4Y54ZPT+G
 9ZMNp4VYl4wqZrCAcdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We'll reuse this name later in the series, so change existing script.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target                             | 2 +-
 .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 9bcbbb11286..35050acedc9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,7 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/regex-compare.sh
similarity index 100%
rename from tests/tcg/multiarch/plugin/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/regex-compare.sh
-- 
2.47.3


