Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RWhaqWSb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jzLJ0ddF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFiN-0007c2-5n; Fri, 23 Oct 2026 09:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKFiK-0007bH-9V
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:53:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKFiI-0004G6-PQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:53:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAZLj1948506
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Klxa1+oW26b9DHN2HNFK93
 aht9xBdB+m0xLCIvTtr2g=; b=RWhaqWSbyp6qh61RxOmaskYDW3vsF3riqCADue
 F7rxbjFPjWWtjGnPrRnN5S4AJzjwVgoLgYSBrDKrD97+Vvj9W0/8373KxuN2hr8f
 U2BVnvA/pFChDlUFIwh5Kk84tC2ycum6HnQtoi7YNOGkSs0oSaHXZsM0YDTSiYkD
 GlJY/J/vaQJOSoDKE4VJSYr7dluBK6AYhJURbvZ5jGrIs6rVZl3EZMs7GHv3k9eN
 w2OFES7PZ3UFshcwIjD/KDx2aModK3fAYDR4LX2Khb1nmjgV9uCwX7yY4g4Q+XJ/
 aYHrAgrbZN2ZigmhdnZvwVWnIuVX3rJTtD6h8IEeW9Ty2UaQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtuymp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:53:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a3c27c9bso17819806d6.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792763619; x=1793368419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Klxa1+oW26b9DHN2HNFK93aht9xBdB+m0xLCIvTtr2g=;
 b=jzLJ0ddFzRif6qKMALGUCFpsdbJEUGfe46L1HSrM/BvRYl8FpXKAeNf3+rdn74ikv8
 1EPzi34+fcUAGn6oZUA9k+mRqBvTLG2/tqau4mod25BVYglrzhbgfHz24FEDRNi3M817
 OBgYU9vXWKRhwo9QUsYJXXGyOmldxFLyfvPXHc640ZJbp7KRgHChW1JZ6e5n+l1LxMcC
 kt9LV+qfgDiaBozFuss6Ilzg3pTdWimoYRX6PPFGSXYJTyfuhGPpDYM9laA0UCXFc7Pc
 nR0hHcZG4rAhGdGMLeTmszhwfZFI2ru6X/zNm/8nyl1Oc4c49LgfnB9YZHu5qBhS7vcw
 7W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763619; x=1793368419;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Klxa1+oW26b9DHN2HNFK93aht9xBdB+m0xLCIvTtr2g=;
 b=WkuQnGuczs9Y1QDp5Xq+Ko7hkr/RIv5HXzOwEAurOs1oGjS/71AdPIY84MgTwTiXT6
 3ZR6qxW3Wem2TsGZPfFiqnuZX4+Xf01W82gURx/XbvsiMrpEMfkmvpDDgu2AONALcjxb
 hub/uKNYcG9KWH/tFyd+DOfccM0tliMshxpa+ERLV357EVg5YaLmQIjG1E2tenhngfGB
 LyKQFbFjSisXgm67fjGqIkzDuO2kv7UWoQzF81z5apr3RJQJ4TSJi+hIHcj4ZC1ZgDPO
 Jb91L286E0RtZiUe5FFAxRV8LBM0dxXsJVilOVBLv/7l2n1tF6OzB5BfRg0a3kWgTx8l
 7Ddg==
X-Gm-Message-State: AFq9FYJaCiVp20Z0XQuSC33XBUKK5g3pINGnlRRI60EHVfCWosgz0U2l
 mWcJvm1JVrJnfIX3QFw2yE/UT1+q95jlTuMgYXQfGyRmUofhfZp4JsZ15lpt7kpHbJDN1Xec+3Q
 SuP8TilC+6nZm2Z4mYtr4FFcdiU0ffSj43csNlNkFhFDH9/ZzR0nKNCv09wcOfOTWOg==
X-Gm-Gg: AYBFou2mKHkdI13BBiqP+nSi68RMsut659n7RVI/PPqg+W4HhQA8737QxQH6Sr3+nDl
 UiMIgAd0hUWns2+5FS06NpQus2IpXuo4Pa2XphP+4Vyw+xMcyZYyJ2/F8YdsnAZAC73PawbBwX5
 /NU4Df8CU3GXrAtt+hjJJKsW0XIoCoemdYDS5lBngUjqvex5zLlWjsy+wLYC8++XsCfvPqLZGOI
 +Vls7PD29Dxz7dT4XSlzoxG6Xhc7X7fzjfAQqVQHIz420d8t4P7ZIwTdFWP13hVs3zJV8Zv4Ai8
 8hpoukoezmOekjodSv6VHdFoF+nG1Exhv+XfOdvkaS7gBrl2nMoe0Vgf4qk0R/BuivWIVFH88J2
 kD9tNlF3xuBxcBxS2Vgj6plb7FxsIgVLYviF4QmqM
X-Received: by 2002:a05:620a:711b:b0:93f:2eaf:64cc with SMTP id
 af79cd13be357-93f6f796a05mr436878185a.44.1792763618995; 
 Fri, 23 Oct 2026 06:53:38 -0700 (PDT)
X-Received: by 2002:a05:620a:711b:b0:93f:2eaf:64cc with SMTP id
 af79cd13be357-93f6f796a05mr436874885a.44.1792763618539; 
 Fri, 23 Oct 2026 06:53:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38025c72sm4428671f8f.18.2026.10.23.06.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 06:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32() again
Date: Fri, 23 Oct 2026 15:53:36 +0200
Message-ID: <20261023135336.49641-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb66e4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VPkRLLWhYSvasvs8gAsA:9 a=93vEdE7WW-5SwXDR:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: IisYbxiFLObTiN09LEpBA7iLpLiNBGkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX0CF3qnBW14GI
 x+RGnjMoLviUs5UIf57Rl5EOp5tvbDmNx7LXY4jd5G18dEaLQJy/4H5W9rLxUj7S/ikgyhX1dCM
 gpPvZujV6TMV2dPPeYClQV+WQCxl1NewsS1OA33jqknDnElY6bHWZDaluKpOilLN5ne6R+GYk84
 uWBNOv5bSvP408Jkf9OZa1dX4SkWZparT5RPFhA/k1yZ7QjcWh8VGa6375757QYS1W2Vt/KidJu
 MtLVQXwAlhBQy1f5NeSli+3oq3CSILJ7fzt8KJpGT7mdKKdER4c/ggcFJdz+h0m6BmYQ9Ouv0+s
 U2PzyublhQVXnn63oGq90o/4J8B9hPe8+jbVDIhfib5sQRU1cejhU6OYYaPDJL1IEgdUSLMZv/W
 GAk4r64wPoq2fJ46OzldAag0raSJrSm80JtwlegVdVQJM8W/pOqY1JHKdK9n0RAUJtrqTb9sSKc
 Caq6pPfkjShoktlOv8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX+KLVMvsIph98
 DboO+/7/zbCGd6O4/WGAsH+QYslgAk+YODjxAm3e4+smMYCxhswLnqoL9y3BTOkQ1sSIQlDFcKT
 b57xQ7v4C5bef05ffFHeGNkMV/dnDGk=
X-Proofpoint-ORIG-GUID: IisYbxiFLObTiN09LEpBA7iLpLiNBGkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230054
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

Commit 780fbbef2a2 ("target/hexagon: gdbstub - Add sys reg
support") re-introduced calls to gdb_get_regl(). Since
Hexagon target is only built as 32-bit, replace them again
by gdb_get_reg32(), similarly to commit previous 7831e5f48d2
("target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hexagon/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index ca6d4a98369..85d9845cc94 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -96,12 +96,12 @@ int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             val = cpu->globalregs ?
                 hexagon_globalreg_read(cpu->globalregs, n, env->threadId) : 0;
         }
-        return gdb_get_regl(mem_buf, val);
+        return gdb_get_reg32(mem_buf, val);
     }
     n -= NUM_SREGS;
 
     if (n < NUM_GREGS) {
-        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));
+        return gdb_get_reg32(mem_buf, hexagon_greg_read(env, n));
     }
     n -= NUM_GREGS;
 
-- 
2.55.0


