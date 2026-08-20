Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E674C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9BB-0007vz-7p; Thu, 20 Aug 2026 16:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Ay-0007MU-PZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Aw-0002ob-9n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7xui3941497
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jGYx+C/wjSqKEH0TVOmY80sKiqo+hAS2MJzZs3J9eSY=; b=fVqeLQcbgR64mBiU
 rbxu1H+foDgSYyQB/MpbuucvwF2pH3GWoBe8Ne4OOcBoA/i9VOwIKgZIvytro6Pu
 BjPirRj/lD0CLW4snIgOl81qo7UjOd0x40C5i5w3D24Zd98HQ/n+5bcdR4U/liTx
 GjV3OKXA3PgXxXMQD6Rxn6FHaU8tkdFZKtb+YBCSN5qWczHH1xyL3KnwvwlX+anu
 VSa1btppzvFRBCQKzsvNdHfi7NX80Z4SRBS7BGf/jGRXcxTY8Gnz+Mm6svds1+pd
 npR6CcFWRbD0mbosKBtzcaBdNDzfLWzFDej5A8UQg5tCdneP0kKdKaZ1LKoFHlT4
 myxkBA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7ujnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so2316321cf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256934; x=1787861734; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGYx+C/wjSqKEH0TVOmY80sKiqo+hAS2MJzZs3J9eSY=;
 b=TcUMD1aPhcZCWNVeq+DRrTchxtCNzAvaW+SO1M/hqm9dJ1tJV9AegrrXgEFC5Nx0Gm
 cfOXi3L0+RscgnYoo1hFk6C1cmdTJgRS7warluIDSJuUE/rbDZq5uv9oYHKcvQmB+KvC
 iwBxzNtC8uznqFCnwPKfyuBEmFMZZ1EcRw6ADjbDpEPNmlYNuuA5U/P3xx+IpsDOcLuu
 w0DvMBIZfpdFROLGRt5VAt1L3u021lT33ZH16RjBfhj0SpQXghq+8+qbY9u6Y/dKaHDT
 yU1DaDESxxipaqG6/T1Z5STsXzuQK7XxlWq7jxDBeEimTS9R4lXTA/Q8iSCv1Hi+h/mc
 WaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256934; x=1787861734;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jGYx+C/wjSqKEH0TVOmY80sKiqo+hAS2MJzZs3J9eSY=;
 b=BRm6gddSta3UN0e9twM2aYpronhh2JNw3TIL9BoLqo4Ge5L/RoTJilCMiEXAmEJtS2
 u9oAvcYC4WStCgPLu6BWpeHyCKV9et9K509/yI5lC4/4byX5/nGtIRZW1Nw38h20gqwU
 5iPq8mpHnwiong5BnU0Xy3u0xjPbUx9xApyXJtuqgYKktWwpU0zSc1rV/4bMzhI7p9dk
 cLl7rorhilItf8OfM7NWzWjb9tttDY8MaeUCIBAILcAaydp3mcx3AXsusDAFOVXI5pGe
 87Jm7neCf7lBC5sAGl58nRxcH1KWo4Y6Zo1ZyVMr+sfzEBzbTSldlxt/jWOoWxAW3pVH
 HzCQ==
X-Gm-Message-State: AOJu0YwLu0qbnt7jecB2aQ+uLqz46E/Ngn9C7ZtikZXoFDl9owjHPVdE
 uyRr96FaVEr2B5vLwVBdmScLddORuVvOvpoPbrzub6ttuh2iBSD/Rn7nVM1vExlhL2P9zrFTd2G
 G1x/MmgYhNT3x6NJqASWXu6OijIL3uYeK+AZNK7pMDa1iBhXhTwjQ9GfzsaQpR72b57BI
X-Gm-Gg: AR+sD11Fvc8gzQhT48PjAV2bsClkHFkeM7iyyxJj0FyYDd7rcNsmh/WbmYnvDsji9TM
 vCPuJu10qJgSNwaQ+WbpYFi97fBpj+RmqTntG391NsyvlO6iHzNiQBkNsGCMbrKTe/oYabux29G
 Y3wsXWl2qFb6z0aIb/ZcpMErC/G14P9tVN77hemhlGcED501CIfZiLyo0Rh11ErU25/HeG/WVV5
 RlbQ6sZ4qslK8pHo9gnqoVnSLXP3HcK0qVVT57We+pBJ1yOIhpvYWUS86DQHyzShDaB68166cpr
 aGFgtlLEfL1IzfKdbTi7Xtfn2EJrdvwUi3Cpn1prKr3tHqc251/edaQqCj4YyYWAQeEHMfvlp7Z
 iTxLg4o5CWi/QGwZJYgcdtxhB33XqOLUHCmsQkCGEwA==
X-Received: by 2002:a05:622a:e18d:10b0:52d:f700:6dea with SMTP id
 d75a77b69052e-52df7007ae6mr3008131cf.42.1787256933746; 
 Thu, 20 Aug 2026 13:15:33 -0700 (PDT)
X-Received: by 2002:a05:622a:e18d:10b0:52d:f700:6dea with SMTP id
 d75a77b69052e-52df7007ae6mr3007631cf.42.1787256933199; 
 Thu, 20 Aug 2026 13:15:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b80a5sm15529861f8f.24.2026.08.20.13.15.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:15:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 12/15] linux-user: Uncast void pointer argument as Object
 in target_cpu_free()
Date: Thu, 20 Aug 2026 22:13:52 +0200
Message-ID: <20260820201356.29775-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX8+xolnvHLwIK
 1yhWVHG1ktLQqFyzSIKukJtTcsZhgiPwxSh+dPg/ZW//qhGnRNE3sNS/wluj4WrJhL9acQgWq7Y
 2WomFE0M1mzm6r/nR+lJNQHiK/twveFsa2Nc3d8ga09urW8QKSXxHU/PC0HvrSGx0c/fZIQ7Cvn
 JjFgMV0bjJ2GpI6etuNLk4MoTVEPosrUVVrNoJBg+2fmbFaprxG9R2GosVzUMyO5ZIoMCxL/FbN
 CRtHMo+SssD4ArsxBATgTrECMJCdZm+EXSM1kiet28Q3fA7hBLBR0hd2nbyTWVOEKPJLS2BqJK7
 Xq4Yz7+NZDpLA+nnJ8bdg2l1bL8vFgt/AXvV1n56iZsHqbRm7zLeVc3F8BcW71BI6693RK1BGvH
 rQ49kQ0r3bxMEbdcdzu7FkIiEafu/mSlej4JyuAds4j+gZlfP3SR3L2cSPu7upEzyH7zSXx8vUY
 bhWWiNseGZ6Mgfo7x2Q==
X-Proofpoint-ORIG-GUID: 0SwMg49Yt18LcHB915jFPifQU1p0Lx6U
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a876066 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2RGiIWwp3e7TAFkeQGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX7MQ0bYCG3AP3
 +88U0lb0Etf4vI/hWSVhSDwv9FMa56k+BzP6cVjdyHqnuXMHMAkIp/2uoZlxDY0S8giXHf3FUoB
 VAP15t9Px8v0fI2Auc+uBjTAwCf5Hxg=
X-Proofpoint-GUID: 0SwMg49Yt18LcHB915jFPifQU1p0Lx6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

init_main_thread() is registered as Object::free() hook, thus
take an Object* argument. Uncast the void pointer as such.

While now cpu_env() accept any pointer type, next commit will
restrict it to CPUState* type. QOM-cast the Object to CPU type,
otherwise we will get:

  ../linux-user/i386/cpu_loop.c: In function ‘target_cpu_free’:
  include/hw/core/cpu.h:604:31: error: ‘_Generic’ selector of type ‘void’ is not compatible with any association
../linux-user/x86_64/../i386/cpu_loop.c:331:19: note: in expansion of macro ‘cpu_env’
  331 |     target_munmap(cpu_env(obj)->gdt.base,
      |                   ^~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/i386/cpu_loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index fe922fceb5a..a0790f3f352 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -326,9 +326,10 @@ void cpu_loop(CPUX86State *env)
     }
 }
 
-static void target_cpu_free(void *obj)
+static void target_cpu_free(void *ptr)
 {
-    target_munmap(cpu_env(obj)->gdt.base,
+    Object *obj = ptr;
+    target_munmap(cpu_env(CPU(obj))->gdt.base,
                   sizeof(uint64_t) * TARGET_GDT_ENTRIES);
     g_free(obj);
 }
-- 
2.53.0


