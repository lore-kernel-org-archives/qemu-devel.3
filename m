Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0900CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUUUJ-0003dt-Bs; Tue, 02 Jun 2026 15:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUUUG-0003dX-NL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:09:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUUUD-0006Yj-VX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:09:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652E5x4Q3302781
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 19:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QqjQ/9bPYn/
 TRK2uy7IVTWNfb32k4FAF9LGFsLcLOwE=; b=eYlzo+XVwQVzI3+gi9ba94uI3dt
 gySNSX/OrmKC0/AJMmmmxq+vmjsJovgaOtqNUWp30UDRZYIuVpVePYMigdYD/1YR
 bKJ5qUqkhT5Zh2fZuDGRwgjrJvXGmkDOnXN+VueYh3n4BW0d6Qt9zUT4Da4zrDcu
 aPZ2pJgRH/X0znFFa6TAE6g9PipoOTVYbFHM2Q4R3s4ge/RQTDclU1EDhtZUMkq7
 Ian+pwVUMyx1yd5nl+Nnk0LnxRYXKXlYfYsuReRuu9PS3SQz3xS2RRoD1Rx4EjCA
 7JIZZrwlBXkyiVF3o+Dy8riixpFJbsdixpPqEsYjlk2dnXQ0p5y5gGTLpFg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu18ju4b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 19:09:12 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6798c46f723so5547910137.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780427352; x=1781032152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqjQ/9bPYn/TRK2uy7IVTWNfb32k4FAF9LGFsLcLOwE=;
 b=Fgq1ddNXdQYMpUcDN4rZn4Bp3RWPBBijIX+7UXGfiHl9ugt+RIPV5Jv9/qIkEevp46
 TuHYLWTbDQy1xcKd7Qk21LdQCJ3VaSCBcMK5BHT1npi2L8hbc8e4WuEezWZiBXfbtH5L
 JnNK2Q/u7Ipsy6IZGrCnoccfyrFSfqBGjr/dz3KeUAsV7U6kn9F/jJqz6E8Vi2bQ8Yeo
 L89r3lzMHldEM+QwPnqkaTfFfqtGjfGqkfTBhmdmZyGS0lPACHIWR/8H+Um36Xn5PKEZ
 IAJDAlYn16DaI3jmMQ5NW7c7hG70jsgiDOf2nkS7ynOL2jLHZOh5IqHF4UbH54aDWIfI
 bTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780427352; x=1781032152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqjQ/9bPYn/TRK2uy7IVTWNfb32k4FAF9LGFsLcLOwE=;
 b=e/Jhkua5ymw+x7DIbYR4UFozzmyHC5UkUAe9RprqMfcB7Uk2156gWLW6mR7q6mTThb
 Xn4ATczDGfUMJVhhPyby4pYpLDrva3TtYRBYnANPXIcVDZbnxltfPgJU2g99nqSyAOCE
 CX0ZTEM0pol7t7lXaDQd2NDJdscB0jz3SfMLQSRwuZhyYJPXwyJQ8TurFP2OiDVeJ8uL
 YUC6V1oEOyhJsf2fA51LfuugvpNJ/LssGEK1rheTd2qXTslP+G3sA6RmPkTpf78xiWrv
 1Y71nr51+qCGUJAEO22EZyhdTpPkyT9aurng7EftOujrvbYTe7qSdEMve85JQrBn8+D2
 87CA==
X-Gm-Message-State: AOJu0YwnReBGXWWU9ZC5XWqByq9DnE8LXhYXq/eMXbSbjQjUGgQth/2Z
 N78gSXh4Z/1ypbvQrXXuB1zNq95hKaSQ4irvHQJut+vzIrTsBzjF2RYxeGc0Yesc3bgYahs+jfm
 nn86UpZWLcLFOOkdtQlpjJSt6e09wjGFVGN6jTYASFxwM+O0k+Yjn2P+P1nDvS+aEnw==
X-Gm-Gg: Acq92OEnBFwCo7qSJk1iVUrnjk5lLEcAZdWQkwsae+z/rYbnRgJV6cRqJNFmZtzudSs
 qy8Tvw0kjSirbNpC6rLpnwOZITrzmUcmA49JClfCy3VcRqy+ottKuOwoeOdQXSOVdpkJB+KU4u9
 20Q+OlZ043XiIAWzLkZLBjRPgKAlTrW+r64co7ycukUhdYuvLBssaUDdVtQIDyJmzzWhWWnACHs
 BVAA/UZyz67d8Y87wYoJMPPpOUEJBbxhmMO+WEAPLFSp6GcsqMmJpl9o0yY8EaSinK1+oiCv1uE
 QVgSHRNFAmsmCEueatXVcBwbFOh7RQ7nNRyFfTQVV04FxpiZrmtTRwQyK3hY2yKF7YOiNiItbvr
 S2EJPZ3kukdo+RHsfGzyXSNxHkvYBI8Zv8dp6RXQaJ/fXetIOk/LG0TfAT3FPKW6jaCoGhw==
X-Received: by 2002:a05:6102:3e22:b0:6a2:cf9a:9221 with SMTP id
 ada2fe7eead31-6ea2b3a604emr1108669137.20.1780427351823; 
 Tue, 02 Jun 2026 12:09:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3e22:b0:6a2:cf9a:9221 with SMTP id
 ada2fe7eead31-6ea2b3a604emr1108646137.20.1780427351349; 
 Tue, 02 Jun 2026 12:09:11 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb649b54e0sm232986137.9.2026.06.02.12.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 12:09:10 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 2/2] memory.c: read memory_region_access_valid() err reason in
 memory_region_dispatch_*
Date: Tue,  2 Jun 2026 16:08:57 -0300
Message-ID: <20260602190857.1506939-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a1f2a58 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4N_lpL7AQvWsAYpz3zIA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4NSBTYWx0ZWRfXyXHXIO6tPbVk
 vhkzBs2QXlUA8ednIThgN8tE144t8NDV2SMYQ5GyEXr7ljPkbkCxlxCoUMZFG1Vdik+jJMNVRb8
 LXDZEH9IL98sXrZmMcesaEg07P3mbljpTwUdQQasqxKHyImYxt0MiHY3JgsWkIFFAq0g1lI/15y
 3mnujHkgJRQ6f36A5/EO9BWXMh7p53X2QaGybEYo1aP2I8VVPcrqL53oBHs55oXLMfbWRyvR7Co
 jFH6+FkOhy+S8V2xBa4KIPLy4mUFQcglrrya1B8NeMMePj3S0TdaPyy16yPrlepRe4KcFF+s/d4
 1YbFylH530PxpTr7glc9hzNDViG/BucVqlsKWFsoZWUGCjMh/8pe/50NnNpiwIZg6e8+OdSdrt8
 Jlkfd0kBmj7uCuj/X50+wsI89CvoCqn94ELZrXZh25uiVqYFSEReeWLsGLtP8pHe5iU70SwFyvG
 1moPKt4z31WqacSVmqA==
X-Proofpoint-GUID: J49ZpGvEshWQmT74M20_P9MdLFyuNf7O
X-Proofpoint-ORIG-GUID: J49ZpGvEshWQmT74M20_P9MdLFyuNf7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

memory_region_dispatch_read|write, when dealing with an invalid memory
region, default to MEMTX_DECODE_ERROR error code.  This happens because
memory_region_access_valid() until recently would just report true/false
and nothing else.

We now have access to the internal reason why memory_region_access_valid()
would fail.  In particular, we can now receive a MEMTX_ACCESS_ERROR when
the mr->ops->valid.accepts() callback fails.

Make both functions return the actual error reason in case
memory_region_access_valid fails, allowing more precise error handling
throughout the code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 system/memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 48348edb96..7d38b9774e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1492,9 +1492,9 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
                                            mr->alias_offset + addr,
                                            pval, op, attrs);
     }
-    if (!memory_region_access_valid(mr, addr, size, false, attrs, NULL)) {
+    if (!memory_region_access_valid(mr, addr, size, false, attrs, &r)) {
         *pval = unassigned_mem_read(mr, addr, size);
-        return MEMTX_DECODE_ERROR;
+        return r;
     }
 
     r = memory_region_dispatch_read1(mr, addr, pval, size, attrs);
@@ -1535,15 +1535,16 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          MemTxAttrs attrs)
 {
     unsigned size = memop_size(op);
+    MemTxResult r;
 
     if (mr->alias) {
         return memory_region_dispatch_write(mr->alias,
                                             mr->alias_offset + addr,
                                             data, op, attrs);
     }
-    if (!memory_region_access_valid(mr, addr, size, true, attrs, NULL)) {
+    if (!memory_region_access_valid(mr, addr, size, true, attrs, &r)) {
         unassigned_mem_write(mr, addr, data, size);
-        return MEMTX_DECODE_ERROR;
+        return r;
     }
 
     adjust_endianness(mr, &data, op);
-- 
2.43.0


