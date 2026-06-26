Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2CDC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9q-0004t4-SN; Fri, 26 Jun 2026 19:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9o-0004k4-TX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9n-0004NN-8D
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxBH22487120
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iEw9+4qnpQG
 fC0w5ladnSWMt4gvdJXjxhPCDCCY+xyk=; b=pOVQT987hjEjOVugEsB6BRw53r+
 ltMvEwouvluw/D6J8r802oE6xjQYfSR9QUBbvOLdSAqGI55shdEmNyxgt8IiNltv
 KvQ97FVnAAmGLjj1QJCSrdEtRuF1p3Hb2sLXmarWNIp4Z40HoLaX9OGLXIAAL319
 3H3dx/E4Q3s+YU8ES+rcIzSBxespdYSwIQdQQC72Bjw4FD+EmcfFnukYOSA1wKCd
 EaIkU2RiyBx3+mY41kMiEDZYrWDidzZFedMl+v5wO5zb+w2pqR62CgonMhEfYN2P
 WXmVnTLQSM22DTj3U/kPIBO2qFGNPRKhVDCiubFAUW3STvVKCdLn+lOVCNg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1wsds4w0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso1094535eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517211; x=1783122011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEw9+4qnpQGfC0w5ladnSWMt4gvdJXjxhPCDCCY+xyk=;
 b=UEeOa4xiyKwwu6GNqOHmQy0S28h7ZrEoLdEtNqNh7xsjldtB1XNJPtXYgjJMx5k6bv
 Ty+3ilrMckAab48aQnBGeM2c6ASRsC2OQYcvajXF6HsHxtWtxyX44REH01VRSny8oVA5
 ecMoMKBmWdF3uxmFgcixGgVXVsSiiX3egLWB+7SPdhPMrJ2qlcSwKZE3P+Pg0tdOnTQu
 3LzxWL6rMz443wsHTvs29YUxOoNidZBolLTsLpUwzRm/HkqO9MwI8/mbE8bkNSbpNy2g
 BK//NlwrxA/pgiLrf013ySgIRX+Cs0Il/mD8qvgzaOQHSAFixtf1wZIAPuXXezJjH3Ba
 GuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517211; x=1783122011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iEw9+4qnpQGfC0w5ladnSWMt4gvdJXjxhPCDCCY+xyk=;
 b=Zh42P+cJaBxduBvzVBKqOVW2Kl93KtL8HYS/j28XH79qbRG3G6LjWTR6rqx8HTaRqJ
 26Kz914ZjoHg/37UgkL3VPsdsUNg2UuubXy7r8dcpu6bUlKb34IWPaBHDBn8cQ7TPTkR
 3gIciAc4rilo9XabhCIh/uhXkJUvHGF0kc/jBB0VotHyhDUDjKLhRuD3UEnI0Lh6ZQ1S
 5XgQz8uCOF0cXKCQD9fO0MC+wY2ltF5c1sNr6WJEKb4B+BbKLdj7nttqDCtwoOFjX1Yi
 gpU/5MSnDuAhB69lollmO6nqQ1nrlQwROTmBNEwA8YQihdFFxK89LNJ5j5hu0H/1i/cX
 Gp0A==
X-Gm-Message-State: AOJu0YxSypeB8nMc4Ausk5u8YH7v5PpzTOoi1AaHDA4rjlHXhsg6fwMB
 wUG2ApXsYxjldoZfMxV+BRWJLdPnSx7EK4y3B8VHD68A6DH/+pXv8RX9B7pyAVSvh2HBtkaWsSr
 lUmP3GgD4OIKn1CYysmTemCgfH/1feLSiPI7ajc91WrUcsI76EieZebHAHAfQXPRz/Q==
X-Gm-Gg: AfdE7cllEkTzo/9quKQ2Aboe4algYVuAo+UUn2QaaXU4rf668v0mSP1E4YYlh+6IN9b
 Sd1xtd5J/RsR3b114I2lIGjBcvQzoQT7BNr334Xdo1EER+/XIODWezhYJ4MIbst8TRPP7P+6ri9
 eFNRmJMGZ4jFmm1h+XD5e586gm3iF9jXtEb6wsoWi9dQbEvMWyWOK57gi8RqqrbvgHBjz3iwaDY
 Dgt688LBu3gM/t6R0Ibl6Q13o0s0KcPda50NImrLDCgW1TD9foJ+bYNgGHEAQ06VoKH7gp3VtZK
 LwqzuDnfhcu/u3Jywft7ngwWgOd67aUQPO+vHOvXOvFfo36YeZKBbXp/c4RduBm8hx0xCod3HZe
 u4+QbpxZQMip7KmT40sfXiIXBP3Jh1ZUgijqHRtuLUWTAFw/kgOzieOS1GvaGECX6WMamhGQdZO
 wOCma2ig==
X-Received: by 2002:a05:693c:3105:b0:30c:ab4f:46a9 with SMTP id
 5a478bee46e88-30cab4f4865mr1926668eec.45.1782517211288; 
 Fri, 26 Jun 2026 16:40:11 -0700 (PDT)
X-Received: by 2002:a05:693c:3105:b0:30c:ab4f:46a9 with SMTP id
 5a478bee46e88-30cab4f4865mr1926634eec.45.1782517210763; 
 Fri, 26 Jun 2026 16:40:10 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 34/37] tests/docker/docker.py: return error code if probe
 fails
Date: Fri, 26 Jun 2026 16:39:15 -0700
Message-ID: <20260626233918.158740-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RNyD2Yi+ c=1 sm=1 tr=0 ts=6a3f0ddc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=9pnB6j0hrbqWY5gff9MA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9zzCsZQP_nF5Eug8cufFji7eGkH0z9r0
X-Proofpoint-GUID: 9zzCsZQP_nF5Eug8cufFji7eGkH0z9r0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX0XiavZZiT3RV
 M51SRozoPxdQBNzSFp/DhzQofM6AA8uaGJ7gz7HhLHJnFsinVaMeavsJETmiA+tc3WlTEEWO4ts
 8RgPjcki3WnXOkwT+je7ol27yJ2r8Og=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/LQ43X9xDKGK
 GWvGmQtisAe9geq9i9wFITKbXja9LXUkWjb2Rpeu8GKmmnmGSu/jSTx59UdcczXtiFZVeUrFBR6
 uVZfU8JBfN0T29HPZpo88eVY8exD78Vzf9jjcb2wqxr1lxx/l8+M0F93YFVHwOyRbfEUMpn2btJ
 Qj+HZKH1nk44LGsk77idOhneLwh+CwpaIyx0KNIYQx7FC41NJZahjmkcjIxSUbDPMprC3qtspKA
 Tm20GyaqhIckCM2Qlz+EOmcVctNuCa3B/lCMdv/Uj65I6MNkgq+JCmAfxESbgNr2eMPn98ZQ39B
 7hIUmbJMHRM9/CHtj/H1iSgmZABycDzmdUK/hY8W2r8AknHJEBKPFu2kuSTmLihVy5Bi2epLJeU
 YmfjKiasfmNu6DXyeJ/7AmO8Iqh3xvcJTQJWbbcQJl14WkdrhqgllnxxO+jZgraEBNTdCXVLGlw
 66FFUwKZEd62QkAk9ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

We are not necessarily interested to know which engine is available.
However, parsing "no" as an answer is not intuitive, compared to
read an exit code.

Thus, exit with 1 if no engine is available.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9e18b984f45..6640cebfbec 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -623,6 +623,7 @@ def run(self, args, argv):
             print(" ".join(docker._command))
         except Exception:
             print("no")
+            return 1
 
         return
 
-- 
2.47.3


