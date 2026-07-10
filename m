Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB2C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ22-0005o1-Qk; Fri, 10 Jul 2026 17:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1i-0005W4-UY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1g-0003WO-II
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3YNB1846270
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F+boKDXkZtrxefEbK51ZKU3cKRYbfvVYnSYNkwCngts=; b=YhdTSnpJ/XQ3jCeH
 ZdfNTnsWMo4zk+r9Ex0txL9bMBdvPBuc6o+2IGcj9VEhzoELvoTeHpfX1X+p00AA
 Oojud/BkJuGRMOcPw563/90r32M042IcXjFUTuMPyF9akv6rctPEZy3XONExtokj
 TDd7eV/dVhlliLJsnPhzuvop/BV6GEvcIHG11SpeOsXpbMFfVN7DAn+Vmn7lwunK
 h8RD9O+pSMs8duAoCtB0yOk8oTT3jlRzfIHgeWqx7Mmzt51LZTTuB5c0ZG/ZfFCq
 i0nwwavlddrax1XXbJ8pvHULdL9XKnan3YzldWSdiL7c2ukQZksF2+WdspmSYZi3
 ASIXbA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rja3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c890bac374eso2576966a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719881; x=1784324681; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+boKDXkZtrxefEbK51ZKU3cKRYbfvVYnSYNkwCngts=;
 b=W2dTNsXtadNkxAxGv6FsgqAPKwmfb1xYsz7smV0xzh/e4G/A9xJ/JIBkEE9th5vHup
 kbmQeMkQ6Qy55rRQKeb9C5Tj4XjZjTCjxtaYEmXAKbXZAjxNuzS03WzPCdJFs4lgU/CP
 5rgPqNkJBBpFiZ6EeG0aDiS1S6kL7+fepTUhmhQ1vuGCn8geGL5giaQOfSvuY+Q1nTLv
 pc3nvNF4DjHNgkatBUUwn7aYnqHWJtH+5mPuj6pmsQAy2swJVtVcfdo/0xtGwaRbbIBO
 mE7eXzpl8NeOvoLjpQMVNVzLjbGStbQioftjR9UoUtUT92D/Ec+HNP9i2+Qx0HrWV9yD
 AyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719881; x=1784324681;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+boKDXkZtrxefEbK51ZKU3cKRYbfvVYnSYNkwCngts=;
 b=gvRciUT71VM3Ler6+vyXcDvn3FDDf/Q/BfnkJTegIxQfIaXUpjiY9fd9+8mRc6wYxU
 Y14FV+/qaUn8T0bVByO54fB2BtxnJ2b+EGJ+HsP42hiKHy/9GfN0+cTRI6Gw/mqVdbht
 d8Un0SyGv2x7opWkxuEm4rgAeoGaWFlxZ9WQkn37L1bCKoWweJlYEdNdb0cg68yBXJ7V
 JwDr+ldKcNDC6flX621WEwKiaxMf4g8gEjt76OtJa5WBkQVrue3V28I0gx3K+B53AM32
 uPcpqeTV5dMLa+8gjMNPhk3hrKb4x6dsxs6/hD1ABxdyFZRI895Ul5CXWd+UA/5nixvN
 b+NA==
X-Gm-Message-State: AOJu0YyU1uBuapZnEsvezPqH+lEqV66ZQ9ZNbc7xYpHLlSy9dR9VjYGU
 fy/0TVMwx5KqBPdiLfIJeFqm7isNMnXjKWi0fKFk/qlRPyjpKOeNFQhAlibv9yaRwg/cHGv9woo
 g3X8cDtbVpghVzvLUMSigdjGZlhPabuU87ZJ6oo1gm0vciR4HUqUex0BJMGBC7iVG0A==
X-Gm-Gg: AfdE7ckq4Xn5/oMYUR8qmNWHcqFApl/e28I733a48WJD8Aid3Ev5iNOWSMECcXx+X8h
 5oVoFXaNeI80vjVmdy00x8yl0JlC8d7tFpugHUHfACfB3UNhDfGPedaDeHSbBTMJ1WQek/tnKZL
 Y5EjxAVBUYLp9irdx+GvGoa/S0Wo2kboTORCjKav1I4SYfnzszXVvAQhnEBjHeHqLh7gjoh6k5y
 tDFFBMEIs2FaUnsP6lEd6TKxTK84eyK5/JwFjARJgWwfUOQT6ixk7AdTNBs9hVs1wc/AjMQ/cdU
 rW4qPy38u4abBsF3KEETXRTlYB+w+3xZhGdWUOzlG+p6GNC5ViwbETfaGnXpArJQNoXDpjB/vhw
 mvu2nvnUX3uFjNMtPFlTnH0vOaJ0MuqPJNdRHIlYzWFUORG4tfJ0uyD1MFIhbphSw9myVT67keG
 2nR0zgoA==
X-Received: by 2002:a05:6a21:6916:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c1108cf021mr592067637.48.1783719880744; 
 Fri, 10 Jul 2026 14:44:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:6916:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c1108cf021mr592055637.48.1783719880267; 
 Fri, 10 Jul 2026 14:44:40 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 26/98] tests/docker/docker.py: return error code if probe
 fails
Date: Fri, 10 Jul 2026 14:42:30 -0700
Message-ID: <20260710214343.2065491-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qdXghZ9LBieu6oFNcirjkRTqh_lcX8Qn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX9RPpAHLRQMOb
 yuP2F+6FzRfGxKoNBLzxRKOyg73xTvBAmXlNyUx5VWum/XsRb6bdujCvL+sfdpsjJu7J1KHyeEV
 4+sZ9FfmIfnDyK4plrbEkYGr/ngy0uR8+98tktii6rT+0vgQguRd6UJWJ/RKInvgyRBJ6WwXoQ9
 mZsdM5NKMGHqBSRDn6EAVg/pWy73gZWWIjyFy5MigufpZfMleEv2Yy7b4fBeBkNhuNdPP910a9r
 iiE7zYGX36zHa9GfocsKGF1G/DLGZJzRa05jlemLXquuHUZ7B7kmkrk4E3Jktt6Tz/DkQnFJmCF
 Vkx1UfFJnhTKMp8UYQW8Bx16CdNdFs6j66/Soj2R4zjbXut1fPGrXoySCwS+x8fr6RD30aGT2YB
 jZZc30EU6N8Lfg8+eB+xDjRrZaH7S+OkdgMMTZCXnMqTJF4BlhmZs36vpQnnkFEr3XonCne9mIE
 tkMj4RLoTK9ERwcEw9w==
X-Proofpoint-GUID: qdXghZ9LBieu6oFNcirjkRTqh_lcX8Qn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX5jcYFACvsRqf
 eLagS+B5VY9hFwqhSQsbQOXuHgylYuYSGxdCFpT78LWIA7aDqifDNNsz595AGLxcgw39jk6AHE2
 8H8+xJzZjtSGJlLtZTp8IuzuDMcshwE=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5167c9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
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


