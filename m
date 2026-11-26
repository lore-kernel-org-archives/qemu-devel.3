Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4573606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=beGGu0XU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IWfgHVFs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj3H-0001qq-4d; Thu, 26 Nov 2026 18:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3F-0001hA-21
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3D-0001CZ-3T
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:52 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw6HR781851
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cqmwO8eUXokHwY7k+6o8UrAjVE1mFGN4V/zMu8vhll0=; b=beGGu0XUNAd3y6D5
 1y8bnIEIUIpHGh6RqGPcwyGI1UFqii2cXGxkV9gtp9PGVnSLdWwAcj2mfP0PjX4p
 A8ms/CARJCkeCyD1PR6ik8CmeCuU1jWMmrTKgxTrI9hTjUbQK7F8NNdL88oZNBcb
 FMarzp4N4uoZ2ZoD6I+4OMvYnia+HULJe3O1OMs/204VnN3uNhKUGgzE00EgvfdP
 h3MQ26e1TUI69ihQ4NL0HAaRH8p9FKidLCfmPRVG3TeVCRcpu47VgXgZYp87goXv
 SZR+pKnB6yX0EPHv8Et1Oh2dOVttwrhq4wXL2OofFO2JdDHqoXb/yaFP490sXhLZ
 Q+/9rg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm82ma7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so1627470385a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736319; x=1796341119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cqmwO8eUXokHwY7k+6o8UrAjVE1mFGN4V/zMu8vhll0=;
 b=IWfgHVFs4HxmY81063GfCpBUI113V/H6K7kbFV+NLTTs0wN2KRkpmHyhQovUBtae69
 1Sa0bBwsBgiykd24j8k4XLDACVRkVtKnaiEJ9z0K2cyCOR/XgbTx+uClo0+BfbI9IJG0
 Jg/VHQ47CmlOClpAj7E9Dyw6F+TWN/K5Xvt32RjQ+beJy07lsEdVOaV+tiS3XZfxcbLZ
 uGof9O9sa+zbHKr6KMfsjLZF7s4xPPoQlP+yzPgnSf1uSGN7dL24bESLvVgO2OHDUvUY
 w9zAWNbnsZ1Nt6tjkSdaLUUy5BbhKJwV74sRiw/qsXByec6gFOtQEjl0U1m83lLHtjD1
 MJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736319; x=1796341119;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqmwO8eUXokHwY7k+6o8UrAjVE1mFGN4V/zMu8vhll0=;
 b=DC/3BmUS69+aA3Vzxwlx2CteZW1hH9J5wTdD5ZgnncDU40+g5jgQsWKUe4gnv4/0QU
 fUwwT/pOqbzb8Gx1ijd8ru9U18NrHbtVP+NC/HWN3xPGY9BaSEeuRe0SIOXqEK5L3IFV
 2zXdFEFiEubDJeU7/cLetearXAKponfKnNvKrmx89nimCje13xug3q8qX9qWFsSAXKGb
 EN0JDP74CVby5+ZUSV3wPN/0PaO2X6oVjC5Op3lxr73BZ8zwbDzn3FBkBJ8XUqmisQ5p
 QSLQxW0n7jlZ1eESoQQVR5fhLEPL0LYXZbjc2hpcmq8vr1vjhVRUAkB6eS0CPP0ycXQe
 WKsw==
X-Gm-Message-State: APuU4Z8EEVGp5OXjlhsxrmtrRDBi8vVNZwSXm67iLkEb4P57tcQVuhGT
 4VfIQSDqNHctqYjbIXhvqMnPhAWzHtTnEMSNRwGitm7aZtVbsJ5AFhi58/a2dFKIg/eOHGENFtu
 naEZpiVw9K5fgVkvq2Hbb698cFKJKy4uyGdVz1t8bFJ4estQmDt9VZNZeFh1U5W6Zeg==
X-Gm-Gg: AZFdTZeeb7TQa1gFcTHDQtrsU4wii08uWsxLHaq4poC68BMC2hj4JfI/WKeDoWR+Urg
 iC73y0wltEpLG/hIbEDkh2JiqxrXIKlRRO/JUCinS3suKZfXrvM3g7jJSw5ZSQWUT5Dswu6Bvbv
 FuQBGBZLo7NTihgsqfcNwn43MJ5GxAzWDAEt6eGtoO2heYv06cLppIWewdTpf/X96vwtQcd7Mq5
 28GxZruCuCjPfdl+81tG3kM61kqrIRGmxccIWbfki65RBdkwJjiPUCLo7UrFqEmzOkCYzQ0qjDv
 tS+kOm4yR85TlC5F7ea5cugCUtO3p/LeAmQ2oMFYWvhrmttfCWPbYQKshUv0aydxpu4DPOSzPV9
 ePZwKYzNlwJqQvKa8La4ZLwGxo2F9y+XVM8CqsfbY2iQQluQcb2hf8ZDtWSuL5PaG9CmRFVjU+j
 g9DG4rVKvlt3DACw==
X-Received: by 2002:a05:620a:2912:b0:947:81e0:bd0b with SMTP id
 af79cd13be357-949ba99cb28mr3822468085a.20.1795736319423; 
 Thu, 26 Nov 2026 15:38:39 -0800 (PST)
X-Received: by 2002:a05:620a:2912:b0:947:81e0:bd0b with SMTP id
 af79cd13be357-949ba99cb28mr3822465385a.20.1795736318999; 
 Thu, 26 Nov 2026 15:38:38 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm39611286f8f.23.2026.11.26.15.38.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:38:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 19/24] target/s390x: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:57 +0100
Message-ID: <20261126233604.67722-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OvIeoCrZjmNkshQ2oH4YVTQ3oJ2PlG7D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX+xbn6sXs6itR
 m/nozlfZNn/UCk28Cb5982L/WXi5CAGEZecsL0vU5owaPwJaLAzSINESc+oucgdDvfN2CukXXPi
 i2W8nSQDLuITfb5lFZtY/yLmcOOC0As=
X-Proofpoint-GUID: OvIeoCrZjmNkshQ2oH4YVTQ3oJ2PlG7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX/6L9PIPClY8W
 Iz2QlJefyXqqGK37YD4F1WUZVP6/iUBT46Cjwp2LCH4cpWvSCPFKiC6cod99XcdA/AJKLlUq7oW
 5ipoI0NU+rRludE+jRyL+GXPfQfQHp5uP9Dl5V8i09YosfqXwaUZ1gjtAjyuYc4vJKyDHt2JW5F
 czc+t1ubPSBw9gb2jju1bcjHPhMICkquPqzA9OAUI9vAZM/4ukcQBQhHrc7ONfS2CmGn00fYtIC
 8D1tB+pwIdLFbfqIPJhSyyx2u1zbFvPbpDUWWKSY82Md5DaSNy7xrvuBTFrhK5ZTohlacaUq58S
 hw6xFwEVTDbQVVkG1yvc4jRkU6Z/rH8AJeG+tPLxABGiWPbfTABt8V3ZHmusFism/6Wz4LOVDLJ
 DKzZzetqMrZUvwCMSQcPfnIaGHCvvtOD1MCe2clcFrfOAxJPi+HumEZtxG6/c+6SUqVQvfzNtER
 NSUUo3nOVtlDi+0Ecjg==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b08c300 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vHQHl_Q7FjuyMDeck6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d1250945d489..c6564974c50e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -319,7 +319,7 @@ static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
 static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
 {
     CPUS390XState *env = cpu_env(cs);
-    uint32_t flags;
+    uint64_t flags;
 
     if (env->psw.addr & 1) {
         /*
-- 
2.55.0


