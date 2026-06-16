Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6324CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJAT-0006lB-9p; Mon, 15 Jun 2026 22:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAS-0006kq-4b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAQ-000824-AE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G202id1748223
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NAhqKK7+Vu7qtKIk3dyuaazJ1lv3y+VNix17Z5KE80I=; b=gNB9eF/SX+ne/54F
 44kC8Enp3jjj7702MKJb7cdZBSGLUyBFPU5UkaTBED291ZrpIyaqgAgVh7UDesRo
 BHpmQTLIqjqoN8f0nFqOIzAKB4reGD7rQZCTg3fV95XYBQR0k5cj2w31N0Mkhq5G
 Z4Mhzsz3vZ35ibG7APSq2F65iLcZMrYtZIH/P44eEej8vb2R8sePMDsHKN6kXnol
 37ZmHJH/bT+7/Fi0mxgzhF6rSMaiq1BxI8Gnm5An4kCWeFlc4IShYNw4uMLCVe+H
 0lxsb8Q5xfAHrJpQwZg+8mEg7zhoE+Y+DCb7cEVVvPetBW6TXWzyg2o8a4JVQ7SO
 +AhQwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter041h5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso687458985a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575480; x=1782180280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAhqKK7+Vu7qtKIk3dyuaazJ1lv3y+VNix17Z5KE80I=;
 b=h7ohdyYPg3rhFx3zFevOMAtDBO5jvlXzzovklU4irc0pka44yS2vugrkPcWnbAgFv0
 39eaCTEPFabnUzBRviVVFjlELsENlNLqVfu2aIvCus5tpMLVo/KQ8Y+Sqn2OX7AYsiCy
 NtD1Ccri0zZTx88WyII4gc+mC1h7Jn6xvGhYc4L9ZZPN4tKKcB9jk2yscEsjtQf19hzY
 /x/ZDIZ0DXhzeDEcQm+LENs6zKK7wkgZQtBEfXVIFVwXUcfLxCKm3Tq1NV62qMGwjSnm
 +3ZI/AxZ1o6y9PiUCbNGuSFYX0JDMM39QC9KRoBXudO2pVL1NQ0zcyq3FtA3kLWz9Usq
 gNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575480; x=1782180280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAhqKK7+Vu7qtKIk3dyuaazJ1lv3y+VNix17Z5KE80I=;
 b=ZmblorNP4Kwgn+xh05O1zaL4a0yXDfWGVU0yQljsKHEQT3IL3ovKSgzc7DVTgDDJqW
 yq0O/32FJ2TP3JJhVAJI8OjKvtOqb0wM3mI6Yl1z4DhJwIxKoeq7AO6d7Mna9K+BnNSJ
 mlVDQk4BGwsjdqhe4VvnDdhSkyJmD83IJIiL/k8Jxg804Tw+82LTDTL5GbSTYvkBkEUU
 8oc8wpYkATZUiVIzls1NN7jlAVEAj7wsXOy6ihpwno47zYlFj29s9Gt/ZFRmOCFdTSjq
 zPAVEUX5s8Rmh12o/OYflb+WlpqTS4/PQcMwgwZ+6AwLpgP334icXeY1XwqrKP90BuYs
 aRbg==
X-Gm-Message-State: AOJu0Yw0Nen9BhhdRgzoUTATVjXVbQH9kt/2IYxRIKOVwR5QK9vQ/vrg
 H5E8vF5GxN6ntBrNs88+migzkNXTG5WFRcTi9tXIQTjFDlQ6rGQBUKh4Q9bMG3/48SA8tlw5psK
 4j2xI4ova2R6SmuXnJSUNqRFGMyDyCgKy2juElfhV37MM2NflvMgDLi3EGcON8dMLkA==
X-Gm-Gg: Acq92OFg9kmHmWypzTIirW4KGWUQuAFL/e7U3MUR8ph/ID8hicutnZmkbSCcrEJ/RXO
 qOlsmYQ7S29uMax06bf6Y+qawu33OBaGBz1h0euUBv6A0WUiJQQsBhAqdsj3PiQ3MHSXDSvdkwr
 oZNDbIC3a3FOPw2DKOGWDpgUBKfsC5s7LKieLxuJxCdN91ddy6jMBJ9AV+0b+ynYm7msXoukrLX
 zjUDxZSng7E3IqQ1PfqItdMlPDCn/ZK09ikEM5r83XpsSAakk50dslYiSuGWCGYTmEuoSmf1VYm
 qEAt4MAWrcNCEaSZ6o9JDCV7dexPejiultjAgcxF3EuWgmzxNEk8FG/tsuA3Ntcw+Up9lKMJXBn
 U+KnOn6eDccc464NuIcReAZ4V/p1gL7vGVUn62NedF2bPzl6dYQ8qOnSHDEDSK5x3yKbmkQiaLc
 c09hs=
X-Received: by 2002:a05:620a:f0b:b0:90f:5da3:950e with SMTP id
 af79cd13be357-9161baf48a4mr2561459685a.9.1781575479547; 
 Mon, 15 Jun 2026 19:04:39 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:90f:5da3:950e with SMTP id
 af79cd13be357-9161baf48a4mr2561456685a.9.1781575479125; 
 Mon, 15 Jun 2026 19:04:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm40456639f8f.8.2026.06.15.19.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 5/6] system/memory: Constify various AddressSpace arguments
 (access)
Date: Tue, 16 Jun 2026 04:03:57 +0200
Message-ID: <20260616020359.18627-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9xu-GO0vmLdZHi1coZkO6sTT9g2f36Fx
X-Proofpoint-GUID: 9xu-GO0vmLdZHi1coZkO6sTT9g2f36Fx
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a30af38 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=6VrJFKV1bllTVhfUZIYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX/4Kiwz9xH+D4
 RzELZqYlYi17WlheEXTk//tY0dZG0s45255zV3HjzJZFRDv2awy5+tC7/RaHys3qnJGTjIbhx/J
 gUxR1M68Z92KT12Pqj40VUC981vIyLTtq+Q0KecX57OmbJYkbIimN79kP44lugunSVTSFtN03uB
 AZrPwVDegyGDzUYqAYOxiv2G8OoMvOljkllASOYrFjNrW8Fd1DCJGn3Y2GzId4lo2lDyx6tehj8
 2tPZJIHXarGjN3JtqFjFd2u8YBqpidx7tZMta8+4Att+4czeZExnz8eqJ0TWNyK46bJjqCqhKpX
 Z/1hPdSVpKB2S1i9SQVRulgMgo99Wl1brnCwXo4R17YSBpxi12sxYzcqVe7cC1JxMKokFTJFmZZ
 f9WiOyivCVg1VflvpKe6IKNMYD4nx7s7MCDgx+iGQH/vvyxY3MzZ0PHz3MMPTZzK4X3QkLAsAOR
 4m1JcMYnrv9HXr0Ruow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX2CJAAF1f8/tr
 hg+PuKsZpzbKKt32dhmcn12tEb19cEjF34qpCPLE3NRRmQLY/vrjw2Fx/A0eNxfe9TBt0+lUUeB
 Q5oHDz5lWUoIea+qarV8CPrhk2WQ+do=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160016
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/memory.h | 13 +++++++------
 system/physmem.c        | 12 +++++++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbb4166008a..918f5bc80c2 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2698,7 +2698,7 @@ void address_space_remove_listeners(const AddressSpace *as);
  * @len: the number of bytes to read or write
  * @is_write: indicates the transfer direction
  */
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_rw(const AddressSpace *as, hwaddr addr,
                              MemTxAttrs attrs, void *buf,
                              hwaddr len, bool is_write);
 
@@ -2715,7 +2715,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: the number of bytes to write
  */
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write(const AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const void *buf, hwaddr len);
 
@@ -2778,7 +2778,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #include "system/memory_ldst_phys.h.inc"
 #endif
 
-void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
+void address_space_flush_icache_range(AddressSpace *as,
+                                      hwaddr addr, hwaddr len);
 
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
@@ -2898,7 +2899,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
@@ -2953,7 +2954,7 @@ static inline bool memory_access_is_direct(const MemoryRegion *mr,
  * @len: length of the data transferred
  */
 static inline __attribute__((__always_inline__))
-MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, void *buf,
                                hwaddr len)
 {
@@ -2996,7 +2997,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  * @len: the number of bytes to fill with the constant byte
  * @attrs: memory transaction attributes
  */
-MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_set(const AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
 /* Coalesced MMIO regions are areas where write operations can be reordered.
diff --git a/system/physmem.c b/system/physmem.c
index b33aa14ab64..d202e540c09 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3416,7 +3416,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                   mr_addr, l, mr);
 }
 
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
@@ -3431,7 +3431,7 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write(const AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const void *buf, hwaddr len)
 {
@@ -3447,7 +3447,8 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
+MemTxResult address_space_rw(const AddressSpace *as,
+                             hwaddr addr, MemTxAttrs attrs,
                              void *buf, hwaddr len, bool is_write)
 {
     if (is_write) {
@@ -3457,7 +3458,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     }
 }
 
-MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_set(const AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs)
 {
 #define FILLBUF_SIZE 512
@@ -3514,7 +3515,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
     return MEMTX_OK;
 }
 
-void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
+void address_space_flush_icache_range(AddressSpace *as,
+                                      hwaddr addr, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
-- 
2.53.0


