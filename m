Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A8ECD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUUUH-0003dp-Mx; Tue, 02 Jun 2026 15:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUUUD-0003cl-4c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:09:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUUUB-0006YO-Ba
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:09:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652HedYZ1937322
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 19:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VN/hr8h3SNF
 ghD/q0IKvIxK8cbNS7N6pQ1oUol2/AqQ=; b=gfmRriQFNDVSxcHvMBvlFFTPfBm
 kNxMQDlZnYAfmIFrebW+iZU+ao35+KFVDrM5zcloOhU3iW2hcagxqSgPHs+I48LE
 q47gGCIunfKFe4P008j2/Uw+CbwGi7z8VOCzIKzrK5CmwJCjpbOVinFvpOEdwJmq
 /z9JyzlGekmEyAmTiNLpED7aT7JV/X1l2rfLK+6CMItjLTeT0qzYeptVfutfJi3f
 /NYcObv5uV5hKrdFeP7V11sPIbaOHUU1vDlKMq5T+93ZVoP3jXq68CA/IRf5UU9C
 MQib7WgI4lfxBOhgg1V/n7rb5LBNShU6P5QxT2kwpcCALd/FDbPUM4rYtgQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqubkmbk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 19:09:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c152655acfso2372116137.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780427349; x=1781032149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN/hr8h3SNFghD/q0IKvIxK8cbNS7N6pQ1oUol2/AqQ=;
 b=OITXPtxqfjZ17gd6Ti7GuAKSvl2uWmjbG2GWm7vM1X84jvqAjV7vpzLhWz3JaaWWfd
 UHfj0BdgQquC6Sm9gBLVyBfIzQ6ddKGTd8UIO/1acF8XUc+bbomz+yiKWgVG4SiQ+2wP
 lu3YaKPxdUMjkKjuqIhR4qMzByJSXRz4uftlZmtV/jZPmewMOsiYaw0WGJh5WewSL8n+
 oFsFoKYhON8g09Y/iPf8jHG2mKbzmfDiZ7ettyQp8b9Jd4usTIl3kgwtuBQDDsnsp8Cj
 WrhXwiA6pv2sFYtiYsYoYJUwEzML/074Klr0oPyDBAwQ7pndQ7CmsMUZC/qLDESWG4YX
 920w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780427349; x=1781032149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VN/hr8h3SNFghD/q0IKvIxK8cbNS7N6pQ1oUol2/AqQ=;
 b=LF6cOt4VZwafPZS+WbeIa5UWX09ohlZvQCdpooVearLAFrK9AE27Tbotlo5IIoXD/n
 CaXsJVnzIwu9BbbR4GghoJir8c+TSB1piPujP3xH0QgRWAiQsNxvQgHhnf8LkDyTd+K0
 Dcc6E+v7/fO3LM7cXXa7AMKS856gBJu8hrQ8R+PSi60MNYBvNfH4gm/e18GzHJU0y7vb
 Do3FoS89bHfb/gdHseC25LPed7CBBBbZGxiKs+p099nYRuK0GwuAGzBYPGsnJwQME2ME
 cvfZ1SrTf6Kilk6MQAMd3J1kBF+VqyeCAK07kRsjz3oaXm9dTOKS5qeNyKZ0Efobx2CB
 ++yQ==
X-Gm-Message-State: AOJu0YwrZCDIXZXx4JBhbAf80SppCpoPNybY3QBIuG1Ag1CrnInSvdHn
 aSr5HyD/i6oI/tI856+BKRcsBk3sqHO71RHUpLSsk3xoqRnIs7KVZ+oHo/CBrdISed07Y+zjACC
 4pNDMLB6hn9Hf7r3sQ6q95O2ZqGShAFOPBXqrrlQX4JSFzi5XOob8D5c2njnRGHCNlg==
X-Gm-Gg: Acq92OHOoa7YxGnT9mwYvIP0OhVZAVnWLnT7NDn7JyA2OcweWrBAEuOUMwX4xcN6KaT
 hLHnOyrprMws+OaeUckP6AKoAuPlInXFj3KXyLcbJR5zObrW1625/SwNzvDIo0+pP588GV2KxJ1
 BEeh5qQWQexoYEozuDfEoDmMGUuiGQDVX5CcFrAqyzNOa5J62NXj6GrRdqSzs4goHCdnVUM7D9p
 u1n+ksv0nRloSw5p5Kr/glC37mz0xan2sCatnBJmO2YCQHalWEKESwt0nefrdtbTFL74WXtUuiN
 TOcTKdsQtvZA4Fi0TRXeoSkg/vDLZAHq1sChI6yhN7yEyKmtofpn0j+YrhmaQKn3sjz+/2/UyPv
 0W8ObQoupR8sxMkKbixi9qwx/BpQKCOi3iuZWIr0wS0VtFzFrT8Kc/DEsfsRrpv05za8eHw==
X-Received: by 2002:a05:6102:32c2:b0:6ca:32f1:f06a with SMTP id
 ada2fe7eead31-6ea2a712890mr1160119137.15.1780427348587; 
 Tue, 02 Jun 2026 12:09:08 -0700 (PDT)
X-Received: by 2002:a05:6102:32c2:b0:6ca:32f1:f06a with SMTP id
 ada2fe7eead31-6ea2a712890mr1160081137.15.1780427348027; 
 Tue, 02 Jun 2026 12:09:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb649b54e0sm232986137.9.2026.06.02.12.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 12:09:07 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-s390x@nongnu.org (open list:S390 PCI)
Subject: [PATCH 1/2] system/memory.c: add MemTxResult arg in
 memory_region_access_valid()
Date: Tue,  2 Jun 2026 16:08:56 -0300
Message-ID: <20260602190857.1506939-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9HPKkINteJD3sDdeKS_wpPQC9HPRJfvr
X-Proofpoint-GUID: 9HPKkINteJD3sDdeKS_wpPQC9HPRJfvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4NSBTYWx0ZWRfX6Kq4S5JSKsZm
 BV4nZ55svA2XQimHu5/nkH1I2PrjynGLh2WILxPOuukWPoOnEsxkcWWe4a8k7Bpq1DZxEhXiu8p
 Ss7DyNHcxkz9EEbvHRqFUTE8+myw3zyOicmrsTxl+oJFe2pX9ha0JdaNMjDOSeckD1YWJcLHzNl
 F0Wf3+Ein6qbOOmRHPNxs1oFGhDSg+nuXDqc1AmYsKnDGhgvCFeN6xHJHiuLCH/04MUQ3EDtImY
 Gal2vNRzbHs6JGJ1rZftHn1Dw5AnXKkXyRiyeiYU9FfSJcY6UtRl+Clu7X6H30JcPDOJSgNFquW
 sFSzHz9xt0iTlmyLmcbzuhteCcU5umwWo2zypPoLxrtE1B5sjFLLIE58t1Akh7d9nUShX14eGmw
 j/wgwDMfVUqHkwflqCtthwE890XXwTfNI+WCoq9AaVPq38edPhLyKHsMUC/vQNCCSmjBwmjTiDb
 VrTZ7LwdaFScwh5RMTw==
X-Authority-Analysis: v=2.4 cv=FcoHAp+6 c=1 sm=1 tr=0 ts=6a1f2a55 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=-Blv1l1VsOseSYjP0k4A:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
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

memory_region_access_valid() returns true and false and nothing else,
but it makes distintions between error types that we can see via each
error_log message: if mr->ops->valid.accepts fails the reason is
set to "rejected", reason is set to "unaligned" if addr is unaligned
and reason is set to "invalid size" if size is less that min_access_size
or greater than max_access_size.

We're particularly interested in the "reason: rejected" result.  In
RISC-V this is thrown when the mem_op tries to access a protected page,
and we need to throw a special exception for this case.
memory_region_dispatch_read() (and write())  will default to
MEMTX_DECODE_ERROR because memory_region_access_valid() does not give
additional info when it fails, and back in the RISC-V side we're having
to make assumptions to determine that this MEMTX_DECODE_ERROR is in fact
a "rejected" error type.

Add a new MemTxResult arg in memory_region_access_valid() that the
funcion will use to set the reason why it failed.  Based on the error
reasons (described above) and the definition of each MemTxResult, we're
setting the following results:

- result ok: MEMTX_OK
- rejected: MEMTX_ACCESS_ERROR
- all other errors: MEMTX_DECODE_ERROR

Existing callers are unchanged.  No behavioral change is intended for
now.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/s390x/s390-pci-inst.c |  2 +-
 include/system/memory.h  |  2 +-
 system/memory.c          | 20 +++++++++++++++++---
 system/physmem.c         |  3 ++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 10066ca618..877ed84b94 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -904,7 +904,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     for (i = 0; i < len; i += 8) {
         if (!memory_region_access_valid(mr, offset + i, 8, true,
-                                        MEMTXATTRS_UNSPECIFIED)) {
+                                        MEMTXATTRS_UNSPECIFIED, NULL)) {
             s390_program_interrupt(env, PGM_OPERAND, ra);
             return 0;
         }
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..d74fae52e3 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2602,7 +2602,7 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
 
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write,
-                                MemTxAttrs attrs);
+                                MemTxAttrs attrs, MemTxResult *result);
 
 /**
  * memory_region_dispatch_read: perform a read directly to the specified
diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..48348edb96 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1403,14 +1403,22 @@ bool memory_region_access_valid(MemoryRegion *mr,
                                 hwaddr addr,
                                 unsigned size,
                                 bool is_write,
-                                MemTxAttrs attrs)
+                                MemTxAttrs attrs,
+                                MemTxResult *result)
 {
+    if (result) {
+        *result = MEMTX_OK;
+    }
+
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
         qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: rejected\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
+        if (result) {
+            *result = MEMTX_ACCESS_ERROR;
+        }
         return false;
     }
 
@@ -1419,6 +1427,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
                       ", size %u, region '%s', reason: unaligned\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
+        if (result) {
+            *result = MEMTX_DECODE_ERROR;
+        }
         return false;
     }
 
@@ -1436,6 +1447,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
                       addr, size, memory_region_name(mr),
                       mr->ops->valid.min_access_size,
                       mr->ops->valid.max_access_size);
+        if (result) {
+            *result = MEMTX_DECODE_ERROR;
+        }
         return false;
     }
     return true;
@@ -1478,7 +1492,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
                                            mr->alias_offset + addr,
                                            pval, op, attrs);
     }
-    if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
+    if (!memory_region_access_valid(mr, addr, size, false, attrs, NULL)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
     }
@@ -1527,7 +1541,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                             mr->alias_offset + addr,
                                             data, op, attrs);
     }
-    if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
+    if (!memory_region_access_valid(mr, addr, size, true, attrs, NULL)) {
         unassigned_mem_write(mr, addr, data, size);
         return MEMTX_DECODE_ERROR;
     }
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf87573..a0f77aae66 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3635,7 +3635,8 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
         mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
         if (!memory_access_is_direct(mr, is_write, attrs)) {
             l = memory_access_size(mr, l, addr);
-            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
+            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs,
+                                            NULL)) {
                 return false;
             }
         }
-- 
2.43.0


