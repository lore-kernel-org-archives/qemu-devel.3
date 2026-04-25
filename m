Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD6FF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 00:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGQwA-0000Ht-F9; Fri, 24 Apr 2026 20:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGQw6-0000HM-Ty
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:31:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGQw4-0001Az-To
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:31:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLq23k293351
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 00:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/ZeS47akej6
 PhIgeXyFdTcl7RFnm1tOvpj4pxBsfD0c=; b=Mriz9o/To2PkGRd12ihPIm9raCg
 QcYN4BlpFZoXHc6yWy3X3GaF9p0up/QfaTRc1+WhJDd+8/zTTY2fKuNqo5kDwrNn
 fz3xFXCYt3pMG0YSgxizdQVb/pcm8sE6MHQG7mGKYt+MaFHuYev3R1lkIdWUTXLu
 HOFUgzGoL8qpDCvW9+pEeedcl1GEuxkM6akOaCVeMudO9rZSEiHBrvaJ+UpUeHtu
 z0P9tgLGmpm9ulB2CBwUHZHGdPbN9gB7+MEcQyLwfYJY338gsldP0/7sakmh9e7M
 gXtH252WEc7NLwPzJSy9RKTHWUFlxskfKRqIRhIfO7g93gsTR7tGFjTSGwA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr6rkasp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 00:31:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so9548689eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777077110; x=1777681910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZeS47akej6PhIgeXyFdTcl7RFnm1tOvpj4pxBsfD0c=;
 b=CqwEIU9Q9EcwTqEV30KBcNwNA/mKuWsos/Z6+ww0WVd5ahJwwIBWTdI32g5kuCsxYb
 el5wa5bsiY+yVfwXUHdRkXj5PCTyX2+JOefnC2ZFk1T4M4pMcViRfyOo3dIgSShpyAll
 eMGf5lmU7dzyoJbVEbrl7/e2xGGX7fjrkLaFUXdTYLk0DaGPL8xmqpZJHstxkcjJBJqL
 ebJkSjPsQYLVjTQBuxwPxC/6YHN8WkwKQrfUTN0Kl8JUNK1JG/7TbmLuluqncXTB9h7e
 pEmlTM5gRdrTv49aM9iSTM9mH0leciQlvvfpuMZwDKReUbii9MgkhFmWDckAcm8fh0ka
 F6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777077110; x=1777681910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ZeS47akej6PhIgeXyFdTcl7RFnm1tOvpj4pxBsfD0c=;
 b=McaR/8wXE/uz8i1uLbAOQen8p6JbnO4/ToOMyAxZXPIbV2yNcBXBKfVaeDD5zcZVlx
 Fa0+Ktuux789wGgUkVGvkFE5JnzAjF5uxyUSj9M20ybjzJA1VA3MMcYRbXisXAC/urOJ
 cAY3HnLjcUJT3ufLnz9rlbWZg68xwzJgK9HoxQDV21mdX4ll+7xyzqW9d1M5im1fQ3rX
 fCGyQrgAS8HmRZokEDv/qc9rD0s0Y7gV6TiPYy8ZMK6M42PJrZorMGLYsO3Et0nOfQjx
 xUoFLAjrglNOWcWLzSCSeEZkvx3Yxd/fcmCpv8jdVc2PpWM5qZV+vvEDrQURhnzu2ow/
 A+Zw==
X-Gm-Message-State: AOJu0Yw9W5ukuCIEDpJBqB496vGHgfOSanPBcjplQwPVGnm7mah0IayT
 n3hmQ26Uh4yMK06PqG+Paeu28U5E+h2E2cnxw1N/gsKDYuk8NssWsWH2YxUvzaJ8+gkgWOkVkkB
 tQ1mCg5JXfkNwHdtBy9fqTUHrW/WI0uDa/j7p74YqyKwwt8Ey05uSq0d3T5QB+3Si5RUK
X-Gm-Gg: AeBDievCjlpsZgUvdEItPxdFTCiHSyiShF8jU9TdclDwrZE9mBf37ho1iq7KpwosOVv
 XgrJ3DfUOQ93STXn0+o6rk/fHVisrCXWHRJ03GAQGhQMf8fAzvFu+FF8O/kU8f0iCiLSm+ecw52
 HHPY1NQCcdaw0EjV92my8KHO6CB/qiWOKr7it+RolPqU1udMcbAkI7QjTRAOyq3newzaSWxfggQ
 Z67xU8MQX0FlCxBzER29wcViCs0W6oml8d9xZqlf295gU0EJrluTxldtSBU3Te5HmlzoHri0XWr
 brGTPNLzJBBVtwdpHg6NPuhi2ygtp8s1qQRpqeU87zW9fNGxHXd0iat+qAceT0h+OchTwWAxJ3T
 w5EVPbsfPgMMguHfIblE1FbouuyiqmfYEtNwzsedxt0E4annBXweqTuS8V1UWyGjCujfxuKrYrp
 MuKx72GuH+Wkwqo1vk
X-Received: by 2002:a05:7301:6793:b0:2ca:7eb4:3e0f with SMTP id
 5a478bee46e88-2e464dafc32mr17747409eec.5.1777077109817; 
 Fri, 24 Apr 2026 17:31:49 -0700 (PDT)
X-Received: by 2002:a05:7301:6793:b0:2ca:7eb4:3e0f with SMTP id
 5a478bee46e88-2e464dafc32mr17747392eec.5.1777077109238; 
 Fri, 24 Apr 2026 17:31:49 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa3ce1sm32510323eec.4.2026.04.24.17.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 17:31:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] contrib/plugins/uftrace_symbols.py: handle missing source
 line from addr2line
Date: Fri, 24 Apr 2026 17:31:40 -0700
Message-ID: <20260425003140.1688666-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AfWB2XXG c=1 sm=1 tr=0 ts=69ec0b77 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=piHZDCMnzvVDxLRhvVgA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Lb_irirFyHrh06wQeEU2vdVW9Ht21sLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDAwNCBTYWx0ZWRfX5XxdBvVyocQo
 OsRkKHlNuA1bFMz9lwBUZSZhbIcnLXvOXvbyiGTbSPgVyl/0yd6NtqHvKjxRy/isoL8j4dSSiC3
 AFKHxirs1l/qR3Q5ueZehirojcqI+jZEMgZCzF8NC1Cucs5Lzn3g/Use4jvOGdt49UOf1UipLCZ
 Fx8zpdbUu/snPMvfZGu7+HnE3ktXBkn6yot2WThpJmBPTpA3DQgszI8WWmDZvlDgrlmP4PM4Sq9
 DVtgq0k2zRohtf2svBt6+5pP/Ae1e88gpCT5w5ZghUQQdOE+Je14ayHYHVs5QTSH/5r1wF4WGbI
 WNDN178wmi9Is/vOI00dVD8QrDgcRuuY7kB7Dyl8OHLb8v3incv9AXdVDmNvA0DEaqmDSTl00Ey
 +q4JmR7DrV8Fmx1bENZdpAT1H1Ug1QbsjmLWff8AK2aW8OIjROw3saO4f1RKIWFG72zrELEnf5K
 yimEOta2Z9OA3hmCSog==
X-Proofpoint-GUID: Lb_irirFyHrh06wQeEU2vdVW9Ht21sLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250004
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

Some symbols have only a file information, and no line information. In
this case, addr2line reports '?'. Replace with 0 to guarantee consistent
data for consumers.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260424194451.1439316-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 6eb999bca5f..9f0095e73b9 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -70,7 +70,10 @@ def find_symbols_locations(elf_file, symbols):
         file, line = out[i].split(':')
         # addr2line may return 'line (discriminator [0-9]+)' sometimes,
         # remove this to keep only line number.
-        line = line.split(' ')[0]
+        if line == '?':
+            line = 0
+        else:
+            line = int(line.split(' ')[0])
         s.set_loc(file, line)
 
 class BinaryFile:
-- 
2.43.0


