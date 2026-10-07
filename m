Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6BBCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEb0J-0008ND-76; Wed, 07 Oct 2026 19:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEb07-0008EU-Kf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEb05-0001SY-UQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtTjC976492
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tsnVUAP+pbvLMtF7sOjGpQpgFCG91UZrM4+D/rMxAyk=; b=j8t32LonpHqWNDoH
 DAZiuxwOm7DeMTWQlCT5Py8lbYzON62D2gikR6I3gD0w5JDVp1phYU7/tXkbCUq4
 INPnzCCGsXLjyYVx8wkYyeTsZSSobxeigXumjtLOFylSIGBYDHC9AvI4MOk+a/HR
 ArZQdFX1wWIJ7V1IDCvdaLnKuZ3rt9YOU2lyUDyblc6zOD4hRbirilhs6GT76Y7k
 kyIVtfLHPC2vWOmifWmj6n7/G7H8giVbkLVKGApEFbew1M/C6CgKh0/eiZv+6z/g
 vjK+EAaZU/zD9wPf5qrYAi/4XS3yGZNPK3NoL3eQ3yeTouqX+/iw6lKScHTy7Nna
 9AY0DA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe387h7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:24:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc40759b2so949159985a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415480; x=1792020280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tsnVUAP+pbvLMtF7sOjGpQpgFCG91UZrM4+D/rMxAyk=;
 b=Ia/bXlXRcVBsc/KsZYUJglIaAcjoCzrnEbpziPiA6XIgxNxXiOQ3NBqkDAYXOLgCDv
 wfRU7Dr/VTmr/PDdVM85p2xXZxDgBOiJdSiovDL3K9860QX92hRmGwgJtVYVxEvrpvbi
 mcHNEwO3hNYAiMhpTHVNChiebIdE1cC3CsDBQ1Xw6NErAw9V30sry69Qowg34E47wada
 P17+v+/ZrM56niwqjol/rWcGhgKj2xFSpGt/6OKn/1TaqpLzffN+mkyEaDmNyl+OSxeG
 3uy4RRd6L8WP54kLerDbWFgMCzw7fr9ZhP9x+sGn+T59BSYaB9uUdOZW84OYKvbG83TH
 JMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415480; x=1792020280;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tsnVUAP+pbvLMtF7sOjGpQpgFCG91UZrM4+D/rMxAyk=;
 b=yG4+GLjfyjr+HPOx8ftoz9zP06IvwK3AMlyEwZg14nwc3H90lCUT1QdZ6ox4RvexyK
 HfnQRD7n3kj2Th/Mpkz1XGdr0dcFm/zd+f5c13AhLpIi5w0+YGFtOjXcijOViOSW/VRk
 0S47kLQEfdIs5jAfmZZlcUriRdZtffmNThulcCx7e6J5CiJZeoQk9q8lvz+86CzzDr/W
 yJkrnUPmEQKlQlpyXky0965dQ6Azon21QItp5NpG7Jd9lqJUhdn+nDTzEUK0m+vUQv/C
 TryF/FTVZw/BhMQvUzX70oLbyWSOStKNsfeLE1qd2orn8bMq/He+riV5UxvLbCFN1++i
 i0yA==
X-Gm-Message-State: AFuF++nWTTzQ388HhzfEihicm4btAasB6UaroDwf+7+wI+1dkbY9/C8O
 yCnuCwdrDoqdvllN1jQYtHZjfPFZVAytlDUhoJfyve+t89FEnJJrTQ3pns+p9MXdKdEIWjywsCX
 +M9BQDTUsd+4s5ptlVxexXA5vXP5TBagnmJ96lqZhP25XofeZ993W+bf3mOHJ+x1kAE9b
X-Gm-Gg: AYBFou3mTEbAkXv9rRylv2tCHiuE5e8srkIY2m9I4e+SOPoMVmjdyJ9jvkJSNTmvHBI
 ct49tPtonXeTO6i2a8BxZ4dM98NEBTTzVVOIOM+A332PDbc5fieJI9xsUG+TMyy8aV0iCWh7XJ9
 K5yrt50O8IhdZWZdX5RxcGvzawhbuZgEiNSc3e+RXCcf+yBnYfrlHVARb9DyxKMtkdoHvIt/JDM
 QFRr7GiTAOyOR1YTHzpo3MqzI0+r814XQy864hJKrQkUKnMnvpAXB5YSZot3enmIAUXqHHKcqer
 VqL7SEloBYcNWNjbo3ea7wrGSr+YQ3xdQeUNjE5R1g9QNFOj67C1bvG0Zj0ZjMusHdk6vgEsnM5
 zNENYjKyLvaFxZ23vGzYUyk6UjDNs/qUQifmVRBch
X-Received: by 2002:a05:620a:2947:b0:93e:9808:8d6d with SMTP id
 af79cd13be357-93e9b84e340mr739670985a.71.1791415479588; 
 Wed, 07 Oct 2026 16:24:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2947:b0:93e:9808:8d6d with SMTP id
 af79cd13be357-93e9b84e340mr739668585a.71.1791415479119; 
 Wed, 07 Oct 2026 16:24:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f4482c4sm176238625e9.0.2026.10.07.16.24.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:24:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 09/10] gdbstub: Remove unused gdb_get_regl()
Date: Thu,  8 Oct 2026 01:23:24 +0200
Message-ID: <20261007232326.66240-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac6d4b8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dptnKJBBxpfCNAqMoRMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX4QgMXrHNScgn
 aZ9HlC0FiejGnAbqxt9rgYVi8r5axImQST4tfGKEEkhgsw/TStjuWPWxZzHdv/dZKsOv/S250ZK
 dG94wlqOIZcXtdYiPfhgdHrGlNddq5U=
X-Proofpoint-GUID: mRCak-W0kPhKo5t7kCEe9B7jex6SEbbF
X-Proofpoint-ORIG-GUID: mRCak-W0kPhKo5t7kCEe9B7jex6SEbbF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX3Hw80PwmeZbi
 9TO8VymltDSIXq5uNsc3gCkMY0S7+QRKYMEgv4qgwdd1hoXusk0lqY7kFXiPCjreo78Zesesrr1
 NsDoHaVI6OkW9+KaTZYzNwUZpKoAcAPT/aQynzDKIWSZwKK/WTAHi+toGNuzglXNOnJoG8qXspe
 9bBCvBEId+MIO2axefLky5hoYm/UXsj2kfvVOlJcBDv3G3Ob367jmj1htJJwyo4EG5c0HK3ddZ2
 R5z/XnAKEsbFeO2JmZtuzjH9RnicfIEPF2Ea6syLHoeaggFB4wQL5ZbNGCv1J1cftmzwOxsnBZa
 Gw+5rboTHo5Lnz4zp7z1UWmFBl1AfmM0eSvvCD7cb4YFp0CK1FDLsb9D5ykYf154JUqbcrzXcRA
 4tOpLO/ByzYUcDoaYTylU+8iVH7Dy14W90n+Qdcg6ooAcPH+eEkmh1JTa2HBDkB6Xnhv6J36xX9
 OJzHXYZGb3e7vun+iBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
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

All callers have been converted to target-specific helpers, so
gdb_get_regl() is unused now. Drop it, together with the
"cpu-param.h" include that only provided TARGET_LONG_BITS for it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/gdbstub/helpers.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index b2f41d6d280..9833725b611 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -15,10 +15,6 @@
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu-param.h"
-#endif
-
 /*
  * The GDB remote protocol transfers values in target byte order. As
  * the gdbstub may be batching up several register values we always
@@ -88,20 +84,6 @@ static inline int gdb_get_zeroes(GByteArray *array, size_t len)
     return len;
 }
 
-/**
- * gdb_get_regl: append @val in @buf using 32 or 64-bit, depending on target
- *
- * This function is legacy and deprecated, thus should not be used in new code.
- */
-static inline int gdb_get_regl(GByteArray *buf, uint64_t val)
-{
-    if (target_long_bits() == 64) {
-        return gdb_get_reg64(buf, val);
-    } else {
-        return gdb_get_reg32(buf, val);
-    }
-}
-
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
-- 
2.55.0


