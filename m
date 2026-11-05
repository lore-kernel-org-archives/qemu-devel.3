Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B83606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=llFc74pQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+Kh/QWZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx0u-0006fT-9A; Thu, 05 Nov 2026 07:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyf-0003mQ-AK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyb-0005qw-7i
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:59 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tehm1028357
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JH8DzDeDwo4oYATYdaoLXbb+8y3/Xbwej4F1McXNIIU=; b=llFc74pQAKHjRSoV
 zFLxGkC8Aafae/f8AqHExa0fE8HHlCNgW0hbkqc5BeAS33j/agXtiqyUxQLrS/qk
 CWQ6nWYFWcOFOE7wo7GxiPZ2xHiVwMe40sYlkF2zD2Ar6A6dgYECYEdIo3zzvzw5
 1vEhurQPkjj55M/tFH4byDGb9IBRe66xAwchfKTi3RkiZ6BY++qUGN7Tdbp/tAhb
 gjcwd6OAKeozX+Zpj9w0Y1EZS1hr+ASOkINcZVzFMsbeH5BqgHtaeP3ItkiCQ3Ju
 TZPBUrLXtUQsk09Xn1KCKaGInDEFSy3n9qCOEoeO1hhCunPP/u6wCMH/qbVa0evi
 V5E4cA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaq9ur1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:53:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso426498785a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883236; x=1794488036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JH8DzDeDwo4oYATYdaoLXbb+8y3/Xbwej4F1McXNIIU=;
 b=A+Kh/QWZoErv/DLX93ZlQVqVxBFDu0ssIHzZprOa0+ZKNu5i95ExDP2+kbTzHiXOAk
 P+Cg205PPSvs04sj4uuXNutDSEGysle6SUMKFppdNPOOkLA/e8uE/iqpK0qVLSO4qjbj
 lsGmqNNwImPkpiPpmZRU29z1c4p4lr/k+15A3MQt8svPVhCGOsCbJzp/+VvLMHRQpynF
 kXH+nWA/ABC3kjp7aFXcnc/kVsYn3L+zhtAG6UWlpjhKQLHgSX95c8yFirodBIpw3Na/
 YR6KOMhxK/lwJTmGGSIEJWUP08QeewC6vay3RgzmdSvTSKE/rqFvw7vTRn1dNWYH27pp
 Q1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883236; x=1794488036;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JH8DzDeDwo4oYATYdaoLXbb+8y3/Xbwej4F1McXNIIU=;
 b=vMjwj8WO4Mlu/89G1H9Ts58KTLSDPChgO0kd6i7HyWRJCq0Il5EXb45s38We1RryPN
 5z//SxU832iur9Fz1I3sq07tdbFfMZcXLqKGPlEjRb3Ub2b/Fu3h2Myed5LzyK36J3An
 zbSPHXEMJ2WyRC+GBLjyG067EbpujXDk/dO7+gETPcp0ExyuTJbLL3gMWaxKBYrVkEZB
 1lI8af0uWWlMtBsVoIZFL1crWowgaTb+PBMhQTBTB8o7Tq2jM4nlldVo5v8kMBaa0ZKV
 GmKzmnti/1uyybXwghxJbnbTNImLGEE+0LXwDP+VSzCB3osgh1h1iQ1gfLLRqintKcGT
 Zz4w==
X-Gm-Message-State: APuU4Z/m8zgQEFGgsMUOV5zZsn1/43otD61X8T1tMGojFKfyU5/jWc1I
 ISyUkEvTmyRGndZDZHX2Mazg+vDXDImFq2izXaBAkSAEzZ9LVwpuSXwNK2thRAwdiVcK0HVyaR6
 qxFeBkSn+quJ88J3fS0mOyid6C2G8egsSfg75BHySSlgn1QBiYOmpFoxk5Vhnx+xAsg==
X-Gm-Gg: AYBFou1/YrKPGBpe3MENxXIIq521O+/H4gI2SV9eok7/hCZkF02bXh9hJrKDRBXQfAf
 RY4Aslk9l3A5ioilngqFV4ek27wrQChF5vJzJZDbB7OE+nP9hTGnycF8IDfr2z/qxroSBnzXxtZ
 Pb6b3mCUEvGEwagRrKb4Sc/qwxsVrA763tw3esjak09DBSJHMjw/XTGNmh84wQtG585sL9HURNL
 MJ5eDJyXsm3JbFKORAJLfUPwI7wEWtSaZuAofPZ9/uV0/J6ln6AejNph2HY+zOE/SFcMISUK4zr
 TcvSiMv0i9NmwQMClXdufcpsQwm8F/wQtal9nY5r0Yg8doPRzXH6LNnZAb8Mn9EObJuyM5QE1Ms
 P/Q/ascoDz+3BYlmkACdM8JBiwponKyUjYyOJV0gX84dM6VPu422swndvgfFpHt9ZJnKvXAcxoZ
 G9/fxA3djLDaokDCkSIr2dkswiT0g/lg==
X-Received: by 2002:a05:620a:4724:b0:93e:c12c:43fa with SMTP id
 af79cd13be357-9442171c8a4mr3144907485a.71.1793883235545; 
 Thu, 05 Nov 2026 04:53:55 -0800 (PST)
X-Received: by 2002:a05:620a:4724:b0:93e:c12c:43fa with SMTP id
 af79cd13be357-9442171c8a4mr3144905085a.71.1793883235019; 
 Thu, 05 Nov 2026 04:53:55 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4657d0sm168195566b.48.2026.11.05.04.53.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:53:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 11/17] hw/net/rocker: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:51:56 +0100
Message-ID: <20261105125203.40320-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _rDE3hbUGue-o2dGNCZi2VW5Wr8cN47S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX0YiidIH76GCw
 cGZYjxjLtViCMNHrloXU1qZZPDftrNBbxRWj2ot4MksGRwaGkPAme/62pBuYDzYF+d675jGb9k2
 RqPgCY9ON9+a7oBPmDMX73nDQrqm+ew=
X-Proofpoint-ORIG-GUID: _rDE3hbUGue-o2dGNCZi2VW5Wr8cN47S
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aec7c64 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=f-zRNqtaeIehAayABMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX6zVIAeHCD/+Y
 lBjwsSXfOiEF+62gmKIfkbPmMsWEuyE+mhgACph8zLL7gZBkVCSqXhkkNXDDAhf/ahWKo7r+lfL
 ujgRrHSjN++wMC/RYFZCpYWuzrhqgYIUTiZ+eenF3epnRrt5vfuOYE03V/ZYLQjYcd/bKOYLq3p
 tSvwAWeGeITIu4JWf09o22uIwAEK/E3jzad4zt7f+BddvQhxkz7IkuAUF0bo5IJuJhql/XNLmCq
 sdmgUzGERdegRTsw9PEIHpGodvcNfiK93XLP3ewTI2+XbwIAluTSJ72pJljcpITv9EXppcvgyew
 1zUY5EGlpjG1Wo0xd2nOI0B8ebnVTlJsiJMEhkyTKzZhyFdL+WyS0F4j6SJ1TF1UGKJqqhl91lv
 NHkN+ZtNWuCwn0hhH0d+5IbWEeDf1n2FJDsXjLLVstL6QkNMEhvYyaOqLXrmccCWnmvwRCSusOx
 GHn4HaGSKJkvCiyZyvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format debug
register, silencing -Wdeprecated-declarations produced
by Apple clang 17.0.0.

Use pstrcpy() when no formatting is needed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/rocker/rocker.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 910dce901b67..aaf447641c86 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -910,40 +910,40 @@ static const char *rocker_reg_name(void *opaque, hwaddr addr)
 
         switch (index) {
         case 0:
-            sprintf(ring_name, "cmd");
+            pstrcpy(ring_name, sizeof(ring_name), "cmd");
             break;
         case 1:
-            sprintf(ring_name, "event");
+            pstrcpy(ring_name, sizeof(ring_name), "event");
             break;
         default:
-            sprintf(ring_name, "%s-%d", index % 2 ? "rx" : "tx",
-                    (index - 2) / 2);
+            snprintf(ring_name, sizeof(ring_name), "%s-%d",
+                     index % 2 ? "rx" : "tx", (index - 2) / 2);
         }
 
         switch (offset) {
         case ROCKER_DMA_DESC_ADDR_OFFSET:
-            sprintf(buf, "Ring[%s] ADDR", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] ADDR", ring_name);
             return buf;
         case ROCKER_DMA_DESC_ADDR_OFFSET+4:
-            sprintf(buf, "Ring[%s] ADDR+4", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] ADDR+4", ring_name);
             return buf;
         case ROCKER_DMA_DESC_SIZE_OFFSET:
-            sprintf(buf, "Ring[%s] SIZE", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] SIZE", ring_name);
             return buf;
         case ROCKER_DMA_DESC_HEAD_OFFSET:
-            sprintf(buf, "Ring[%s] HEAD", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] HEAD", ring_name);
             return buf;
         case ROCKER_DMA_DESC_TAIL_OFFSET:
-            sprintf(buf, "Ring[%s] TAIL", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] TAIL", ring_name);
             return buf;
         case ROCKER_DMA_DESC_CTRL_OFFSET:
-            sprintf(buf, "Ring[%s] CTRL", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] CTRL", ring_name);
             return buf;
         case ROCKER_DMA_DESC_CREDITS_OFFSET:
-            sprintf(buf, "Ring[%s] CREDITS", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] CREDITS", ring_name);
             return buf;
         default:
-            sprintf(buf, "Ring[%s] ???", ring_name);
+            snprintf(buf, sizeof(buf), "Ring[%s] ???", ring_name);
             return buf;
         }
     } else {
-- 
2.55.0


