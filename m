Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AACC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6I-0007LY-7u; Fri, 10 Jul 2026 17:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6E-0006rx-00
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6C-00055J-6O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3LOm1832636
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=; b=ZH/2eaFKSzVKCWUN
 FM7hnodVJ4AJK+XgeS+EPEFHtlLESa9bX3DdiYmVVzA/tmUWUbaMKrH5By+8Rz6v
 qxqBB4+XCWZwiFgeDMU707pmUAXQTU8Z/In/oG5isxfJ0hIFp8VMGQRXR6RLxXtZ
 Cy+snv1xWFQkMuRwOs1Z10pX1cmL+rW/FMFXDAoAgzkdxIR3VWBym8yb138Rbako
 ORe8dEWiZXs0PmnA6TjQbXi2FQ4BoCVj4WcsObuZ4HEFRhDBn+g8Xy4wnW3NxrJn
 MIZnOOL1NhCCukSGrA/6KeGPI8luzogivraObIXlj549IeKiCkYoMS1UQqNcal2I
 1eaDvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwece44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381e93bfcacso355329a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720160; x=1784324960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=;
 b=CnoESsI/CViULtHRWzH7LJhVdFl90QGxf+EJ/El22R0cvPcVPOU8FOLNXZYIpoVSCz
 e3hWj/yFTyNgzAdOt9RDovGknbbjeuxvWroOR3e67ueQKGqX2drxvAP/ToURtGqWzF8/
 hWgNDk8/U9pJbaI4SlGjHWl0UYZ5UnGMSPrebpV3RFXnPS2bkWwVLo4scaYNp27hqZbs
 0BlI2/t42/WWJ+7OUzrNt5O1HmWi+Guoe/+Wy7btGhoeOqPXQzPVm866N97OR3Zt6mWB
 mAhfn9FbyNCfJmfUXaL7syy/O0ZuL3SMZcoZmJvc3KSM2kjXV3b19VXJHKTHVFU8X6w/
 RWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720160; x=1784324960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=;
 b=OGWDVUuCD3NH0fqEpvUm32a9cQZBv2XQurHorU0UMeJzWhQrRMzkLEf0nk0oaN/ozq
 Jmqs8KhKEvWSwC4N8Y7dsTE6/vHsryXy0P5UmEyPyInQFQN5faUfB4R8zydfzVpevdPT
 UOgtRrUX0QXw2phBM0XD6ne+IoJvqR55QR4GQYFyubmqMfj+DPbapirrIlFfNJAhHaH6
 oWGl4goOgfuCsgclAqQUK4qqW9KsWHGmKNfzqTHqriu/na32gIyirhTXbQHs2k8ZghSM
 LUjzm6EJr5U8Wanir775a/+c72zAhvbaI5a+mKWJ2XtcJwTE/dksFPUXUWj9Gfyr4BZ4
 eCcg==
X-Gm-Message-State: AOJu0YxAcyzrf/moclSFBckAspgaGq0A5hXjYGneKJVPrgShRWNrXHWO
 qRQjWR/d2Z9/J1FkrhBBoCCIyVFRjxU63lCJCbj6GQZtD5OdheXogTTBa4YQeP9U3N7Ioyd5m5a
 Z2Qkoj9OcAat/3y6i7r/dyFcFuoOSll0NjZBfZa7zv9EZFrC9t8Q0qYoovZahvrRjwg==
X-Gm-Gg: AfdE7clXUHnm1gO4SE7+p1sv3pFm9qYJ61rcX/a/0YguRvDztQLsKAAR0trqCknoSx2
 JTHH8PKuOdi5JcYtFvfMremnBE6wp3+NATsLRk0tb1ntcTaBIzdW0khZOAKw+ZXbuzV4yB5ttgz
 vC93XiyQYGDNJWcNYSO3syQCaKDsJVv5sNvjxvtcdpgVnc+QaJz/zIYMgqVFP46jZEe+uBQLd5M
 gLu1wD9DeTT5Kw07VLBirV5304/wy4E9cUmKjvtzdrl1zOtfO0m7EbNY59D3cl7sSv0n6rzJq6m
 1utMBWRYbqUD8zYiX8FqYCVjI/1/ifr7Tasxme7a5mp57dzNVYqL6WQeoEhVlVxJLvtJojfn5MT
 P46DV8BrpElSqPaC53sSzchYxK8PuM8P1630FCYK74ycdLi7NmQdGzMHO4n2YmaR17jxet8ajL6
 18yUZFtg==
X-Received: by 2002:a17:90b:3fcb:b0:36b:a4c6:da96 with SMTP id
 98e67ed59e1d1-38dc77384e6mr629948a91.25.1783720159748; 
 Fri, 10 Jul 2026 14:49:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcb:b0:36b:a4c6:da96 with SMTP id
 98e67ed59e1d1-38dc77384e6mr629915a91.25.1783720159293; 
 Fri, 10 Jul 2026 14:49:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:18 -0700 (PDT)
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
Subject: [PATCH v5 68/98] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Fri, 10 Jul 2026 14:43:12 -0700
Message-ID: <20260710214343.2065491-69-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5168e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Fbn9wURAhCV4_gqr_ywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXzXpQX8/tJfH/
 e5e0fnCt0UQfU/LJjBUIHRwTwQOHPaPFuB15MO1VwcEqw6UWWM8wbIFSZKNo028KtPtmL8L1Irm
 sn4L1y5JXW/o0zWuR2tIvv/pGtIYR+IuVcKNC/NirRwJ8AUoyWUHXDJ9IcXW3GK3TGu8q/TG3c+
 atiyYFpkqAqcz9dAqtxbziTJFRun5lcfy7tlZYzGfCkBk7UgPaI1lrq4o1Qn3x4+cF5Z1g6eI9h
 9dWcEbT6yK1QnWbri7sybSJHm4cZciw941Fa0/jjiZKAsFnso0i91EAIOyTLdDzTQljYaH/wAtX
 zwS4ePuiMgPQqpq754KFHdkUPSsH0vHMWZblXchPs4c1WQzm72uD4xzjYqvsBFxqRR611YV9oRw
 zpliQolLiK2EZ5CZsJUCIC6ggXwB/Fh7EsumhubAEwXDXKu6Hb2o8aRxc+DoZZqNt+Sqogq9OGa
 Zu4GuRINSmVa7VafxVQ==
X-Proofpoint-ORIG-GUID: S2DUz_cRcEI506G8lF2LXxiCUEVH5fFs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX/0w29IgqD/sP
 L0SHVXA0325GFzHew9fCpTK2oIq4/zxNZCiVi1NF558KGMSCgVJug0ttPvq+3im2wsEGKLq54ys
 sI+SmXluqlTMvLWPND6k4rN3ghNcanc=
X-Proofpoint-GUID: S2DUz_cRcEI506G8lF2LXxiCUEVH5fFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_muli.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.47.3


