Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A19606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j4J7k2s5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMw66XA0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPEw-0008HL-2Y; Fri, 06 Nov 2026 14:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEQ-0008E3-7x
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEN-0007FS-U7
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:09 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HsxkX1511446
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 seMAMCdE78rqIJedjFVv8BQtse6+336QKr98Q3wU8w0=; b=j4J7k2s5uWsz+uLD
 RQIXu0RpKiaXqcn0QDBKK1pJ2Jd1D4j1SFWWhNn9dof+jxcjZYwjN/4l1f6iZCN7
 nq9U9NaBRmB50vRnMn91UVEtVItGKh1RinjvGx/d0JUjmNHD3TbYH1O7HSGAGWkF
 ctulr8EMZ7Wrnw5GlFHsoLAk1mnzpFrbaqXlJcJxLu13XcKhBAfzwehbD+N5ENjf
 nEhqG/3WoHBI90FZ/DHaQdenzqGkHLc2gVs8g/dM8dgyzVEd4dNdNPxVgfaO6a4V
 2TfVbVYjH2kTUxaDEUdEYmSwY85iwcFmJ7tZLWk/IZWH+CNPxq3QvAeajwiIlcL9
 v0oqIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9va7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:04:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ed2803f863so9681515ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991845; x=1794596645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=seMAMCdE78rqIJedjFVv8BQtse6+336QKr98Q3wU8w0=;
 b=aMw66XA0VYb8mmJKmSI5YuwZ1rLBsvZKAfB32hL4HXSsl+qBrYn4zPbI7BhgK7jrW2
 G0FtaACnJ1nzmtEW95esSPBWLUJg76VlerVfHt5ZbW9Peb94+rh626SGGcUqISFyX+hz
 isvH6+ZLuNC45PM66Bl6S8/MCKBDyUzEhaDXVFsh70R9yAgIF7CZ0erDZ4+Oc94ZuSl9
 n2qJlabx1rA+oKN39v4Qzw8nNuv/SxCpmnRJ/h+GFuplFCpiW1pMG+Kg7hergKxYqL54
 /DTI+piSp6AgBzU38NUqyUIkSN1EqUrW4W24tRL28uWCQPsJNR15MWtIB2MfJGhuRvaa
 fa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991845; x=1794596645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=seMAMCdE78rqIJedjFVv8BQtse6+336QKr98Q3wU8w0=;
 b=lqKi6THEmIKLUzTuyS+siJWaz9E3KATepHBHGuNFqdxyT15taEGEzZGqe6cU6LFMdJ
 38CnfwiDcB6PD5wedxg/uIdrIjmURNnpER5A+40PJ8nKVfoR0LIWXb0DVbkgCt0oH96a
 t0+logbTr6OEssBjWFVOyhLQ5raXxVoRSGn/QmL0HD/psN0l7ZZTqdTcHVDjReRmQb4F
 1bJvY0K3p1OI0K5m9rS8yhUKElw2U1ALz9Fno+67q7CovdaJD4IhgbxmFqLwal6+0Ew2
 L7FHVScIv2EYB9d+d80vRleluaekFKmlLMkAwjU71UsxrVNxmHdjgesPU7k2N8whTfVj
 Wi2A==
X-Gm-Message-State: APuU4Z8TMHSgQgYPB1rbWpT0LhlybtiGg7DgZwc+Q+8d+SquXddik8ZA
 keZkjIvnJlEnzkkBBVogBe1EhE45QdPxzdhyWnu2evLnldw2qgkawuRTvHTe+d7Bb/JQ6D0+PyI
 4/kA+SuD65p9kEYuj/oAYmeJNOSwg16dZzpxZcLKjdNDaAuH7QzHH3Wv3rM4S/9yZAQ==
X-Gm-Gg: AYBFou1KZaWFq7C6R1FyOjbaTQoAkxoTHQa7j6h4DeONSSEri5f2rz2xiAqEtkYCwtd
 dMDUvcUeust9Q2rFr+fsoh6R+IS6mLZp34OBlrmiLuwMJrih7JeaNGXfN9tm6BropgTqJytr9NF
 TBCV70wquwHAYaSSYpcv+ru5htpFfwxL/DkpQSGP6wADeIEROpbiGzaW3xEKTy3Z9wjs4yBdfMX
 NYG00WWnjKQoOUdTkKPQruc5aswmdkA3z6g5dFfzojeHuRV/GubBrNf1rj41V6qro7zWgGrxbfF
 f2aUkXVuBWT9bUBERKBTNVHnk6BRV+saMRl5BkyScygLyPrLKGPGyRtRCPXG+YP3qNizlmdTMr9
 ddfKqKgtb5k5o5Rz9V0goiT6N/hmKU142L5NGA40A8jLzrZPeb5zWHh/4/dZQebgPFUlr9PkX4E
 dBVVcxowZBwZNRKLuvFDBSOfqd+Cr9xBXDLj5q
X-Received: by 2002:a17:902:f68f:b0:2e9:3ec9:5ad7 with SMTP id
 d9443c01a7336-2ed40c5f4admr46813655ad.39.1793991844996; 
 Fri, 06 Nov 2026 11:04:04 -0800 (PST)
X-Received: by 2002:a17:902:f68f:b0:2e9:3ec9:5ad7 with SMTP id
 d9443c01a7336-2ed40c5f4admr46813265ad.39.1793991844476; 
 Fri, 06 Nov 2026 11:04:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d40d19sm8283735ad.32.2026.11.06.11.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:04:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 4/5] MAINTAINERS: fix typo in test-multi-target.c filename
Date: Fri,  6 Nov 2026 12:03:51 -0700
Message-ID: <20261106190352.1665081-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX0NqGIN2si9FS
 YvIDrcVm+Dhcjj4UOLJOxyy7GZ1rFzbeqL+PEmWynb73GxPh5SOBP3cjJrPDDJyTlUWv/gJz+rK
 J0Lepv6jYFoXo57sAwB80nA3Yxp/UaA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX+wWbc2vjcweI
 lIIlATBSBWq9E9QOuGpFT5lVt2Nx1tUPvtzz5G7JOTT91DoiuotiDEe21EVoj0d0aGMDZFy1ChN
 8RlSDM9/vHNyBl8gxBPg78NJL76kEAtJc9j0Oo8JDmUVNTh+MC5abGQvZ8dZQefq3rfLWmufS7Z
 2KSwGLUSu4GdoW1jHZAAdzuersruxBjHPYv2ta05uYaD9f07w9IQaIy8UAMzvZsSfGTBaIPCrbY
 0DfajsoWVmlmb86yBdlKF3HDbZvrMhliNMuiKsw24ZUk4bCCvqmy6Jsg5kjGPqSG+X/WKjeU88V
 /UXKQFQg79GIVDHw6Dx36MYIPF9f5o2nNVB6YZ9uSh7ZM2NjP6rBQwwRTwc01qWXRNZBQw6IACt
 RYdyyNbYtHoY2uavSjS6Mb31T/xEfUcBXcM0MOGRaJyiSwDW7S7MVGl5nSW+w/j+GLGIpE8TUpy
 Q7woZ7K3UeYVfrHKynA==
X-Proofpoint-ORIG-GUID: M9W0GDk3AFMJv9qknk-MH7XiC8UyDVKg
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aee24a5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oKM7wamHQ2kMubwCaG4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: M9W0GDk3AFMJv9qknk-MH7XiC8UyDVKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075
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

From: Daniel P. Berrangé <berrange@redhat.com>

Fixes: 8b395deb9475 ("target-info: add multi-target test binary")
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261106171836.2020151-5-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55463103ff1..fa0c6d0c9bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2186,7 +2186,7 @@ M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
-F: tests/unit/test-multi-targets.c
+F: tests/unit/test-multi-target.c
 
 Xtensa Machines
 ---------------
-- 
2.47.3


