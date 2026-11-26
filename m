Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF0606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5ny0p88;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZeniNtNR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhVl-00074J-5v; Thu, 26 Nov 2026 17:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhVg-00072a-Jr
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:00:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhVf-0003bz-55
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:00:08 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw7c5781856
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0j48yQU9/7V8nrwa2xf5Lp
 sh0O13XBCh04OwfC2FuvE=; b=A5ny0p88ki42YiDrIgcd4vNRKxOGKtBUgcpW2j
 L6n4BVGlCAF9syyznJJ4EkDlLcSCjzho8Rw8zeGuGEwGW6rhFJF4laQYO2VFihyK
 aokPHFaAEFvaoADwGL2FIyrBJDOTF87JKcklU+GrWhkR7qSVO+o03oZ3IAcaZbT7
 vPyvtTAVUIBOZOEjwoRJg3nFXW3ZSGoo1SX0oV8RT029+a3jLEk/W1OIViqPRIkQ
 TW8nnQTKqqx+6NpuP+djIibWDwaw67++fuaUCmTpKDnUjQzoc6Zvmz6P3rlmhKml
 1wmpR3u0jcUcla50Q9TwJdIK2vpM2Pgib6We3aqntTQ/aRaA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm82d8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:00:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94961511b61so1188564385a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795730404; x=1796335204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0j48yQU9/7V8nrwa2xf5Lpsh0O13XBCh04OwfC2FuvE=;
 b=ZeniNtNR9QYRCJRuJnxDh70MEv21CcDGGjHIDPvDHfaxxRWVGEzb2ZoGQjzc4jUHi7
 gCSRpdSv/m3lfXaeZ5S0UfpwYC3v5p69SWzj8EQER8EYC43KsBIbuqIjbJSdVtRXNzmP
 I4ALr0HMCEvfkimLTAgHhWoY7ztVPyGfr4xPi4XWcJGY4s5WpfaK9YNL1OukQXevRz++
 bC4RDf1ePRV3l341iCVNVGimZiFrOm/utLdK+Lln4ppddH0jOc2S0QD2Q5nb6GHN0dKu
 5dMRxJwLhBGKx2iV+X6SBD7V4P51hrDW+8XfZMTRxinDyCqBoNoAiiPOF0ogupx3vRlF
 Bfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795730404; x=1796335204;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0j48yQU9/7V8nrwa2xf5Lpsh0O13XBCh04OwfC2FuvE=;
 b=duw4yfxAtaMhXGvYi3a5Js/WSSvz3Pnk9ZkV5F/2diKJgpvovR+Ude1PsDGEYp9tsY
 tkKdJzBdPqHlgypBKXL8nfMZmYtqxEh71A/CeSlHsNx2Qwt3qcvLIndogYRw4Rcv6dcv
 j4bTuHPe0Y6MNcJ8rHOnxv8nY665R8wtLB4nF8pp2+ATV65K1UkqTMssyDT/89OFwhlu
 etST5CsfUaoT8M5O1m1IQw5yeB+X1DBWGvbIGfn1VP+bz/pwmguICrVhBZTtr1b/MSGD
 iyu4LLslLIftcvbxfB4NtyG7Dn/1U17OTFxloaacaRY+iDmRorYVWY93u6/KCv/u29Y5
 2xEA==
X-Gm-Message-State: APuU4Z8RoiAIbw+Jl7iVD2lxPtCUhrdAox2LAkGpo3GeA9N1cBqlsjiO
 iRsVe1FZqwANyXcyLcKuBeH7sfSmVkzwGHJljkmRAfL9Mb1TP3suITmjll30mJpcBPJ5X6iZLpT
 QtvHS/oxx3BHakSEFTiyKSgic5GyE2auDB8G/0f64h70Iaw6GQ9KVe/zToUg+KIotMQ==
X-Gm-Gg: AZFdTZfBPR3YAjFJ7+q+AIhKvwp1Ro0BqZf+eJ2LxSlyuaav9TXc6JkAwbUeg+MarhX
 cCiIkthKY+MrKREDf9cHNqjdgLmTRu0tiZ+SS+U4bjIinBiu/r9FPEJGWd3LMYKl0G8l2Fl7B2n
 MAbxmHt7g7gX+RqWPUp76Ez1f9yrMa7pjCVvbFpGtlOws4xc+Kz8h+Ne3xnPvBfsiA1UaUo77G5
 iyLVAJqsFN83PMnDKZqrZDdN4oJzl6JoNXI0F2i5l6hWLESF8vuMI8BdJUSTdWH2uDY79VMa1OE
 KqcJSyMow2//6gp/3A8bONCcmllEZqYQAXKJqQeCvJU32Rq6X4kJ4kfiltmzJchSNwzmsC7iWgZ
 g+r4bReyCQ2Zth0gnqcnAiMW294rOl+ASHNQ5B4vRMBpG3sstG9mlBg0eN6meS/4+hZ0wDz1qYe
 vskbPvPvTmM+iczQ==
X-Received: by 2002:a05:620a:4555:b0:93f:3163:3e25 with SMTP id
 af79cd13be357-949ba955764mr3797912885a.24.1795730404455; 
 Thu, 26 Nov 2026 14:00:04 -0800 (PST)
X-Received: by 2002:a05:620a:4555:b0:93f:3163:3e25 with SMTP id
 af79cd13be357-949ba955764mr3797908785a.24.1795730403924; 
 Thu, 26 Nov 2026 14:00:03 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm43602248f8f.44.2026.11.26.14.00.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 14:00:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] util/oslib-posix: Have qemu_get_thread_id return the thread
 id on macOS
Date: Thu, 26 Nov 2026 23:00:01 +0100
Message-ID: <20261126220001.58932-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: y3ypHk8EXzGrkZrSI-NeJfdQ71k7v17n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4NiBTYWx0ZWRfX+KeaDgRsxgLp
 IfyCYc2QD3T+r91AmOiNkHD5xpzcxegBmyLcXcp0nG8//qU+1M2xd9p3L8i3AisCk3hrndMbzjl
 AP7N7N2hI6Y6lK/MBS5Xr51FOrQVKBk=
X-Proofpoint-GUID: y3ypHk8EXzGrkZrSI-NeJfdQ71k7v17n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4NiBTYWx0ZWRfX/WrGMVJ0HM75
 bldjxDFWvJVN2rFUVneG70EaSqijGCBDXrdzzovKKpKqOnlCGz+dqlT8oaS0m1i6QCk9sHeMp+7
 +HI3L37UK3gRnyY52RNvl30Ki2xUzu+TXCbuwQsU4fN2sR8Mgi/t53nFZMsEbKk8qEoRr56d/y8
 9DVrJHO+MGEUP7sLqP3IePbb3wi913d3E7VfaVshEjs5UACqeROS6Zh9+wVBFrpOz3ElsOFuzhM
 4GX2PJHwp+mVp7JJ23MrS6ya+L0/b4QXHJDdfPRsmzymMjqHllTqRJfmqtOBj4BxW2BOPx/8YMM
 neq/XRfsIZwcDFBbXzOab8Y7bNdjw1h76FaMhXQg7AviqVhsqJ1Q2tAyHZsbqAu7UZvjWZFldY1
 a8VTbrKjX27hfKDup1K+tlDB1hblNbSUuc6cYxDby74mj/dX/vQz4vALpfJJhI+ThqXLnkbq2A7
 qvZJXLh3ufusxnUrGxg==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b08abe5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=YUKw_LfCYkKSf84aOdMA:9 a=lzZJjnUGwD5TvA2e:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260086
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

qemu_get_thread_id() fell back to getpid() on macOS, so
every thread, including each vCPU reported by query-cpus-fast,
shared the process id. Use pthread_threadid_np(), keeping the
value positive.

For example running '-M virt -smp 2 -accel tcg,thread=multi',
QMP 'query-cpus-fast' returned before:

  {"return": [{"thread-id": 58412, "cpu-index": 0, ...},
              {"thread-id": 58412, "cpu-index": 1, ...}]}

and now:

  {"return": [{"thread-id": 75188616, "cpu-index": 0, ...},
              {"thread-id": 75188617, "cpu-index": 1, ...}]}

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 util/oslib-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index dc001da66dd4..71fd369e42f1 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -107,6 +107,10 @@ int qemu_get_thread_id(void)
     return _lwp_self();
 #elif defined(__OpenBSD__)
     return getthrid();
+#elif defined(__APPLE__)
+    uint64_t tid;
+    pthread_threadid_np(NULL, &tid);
+    return tid & INT_MAX;
 #else
     return getpid();
 #endif
-- 
2.55.0


