Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDBECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBry-0008AW-6X; Thu, 18 Jun 2026 08:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrw-00086e-A0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBru-0007iK-AX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArfBP936323
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QT+lpRDehsZI7hXyRu6vmgnawl7vsgjxkM6fKi7YS40=; b=oGvj9X3MLT7ESzoH
 t7S0pgNy3Ai7chYNNsaZFYTzeF4kH0cz0wjsWgXidurTqJ6NyfHfsZpj7IZgWpKG
 /vSG5R7DjQCzcjlU8OjpFqnl/0uigOqM5AX3uC3FZ3y1hnnshbpUZK6i9DIwzzcd
 WS+OjyC6uVtNwrEYgEFGdJVjCRYqVbKVx9e49xiwsbzaB8uHmDWqsmpOy5+pw/a6
 Ogpq6CwYU8iXaKo38xZQk70xG5oZTkV8UwXf6P31R2OazxfHVeTCyHrEj+Hkqibz
 pxyW4j1CKmBGDVgIipDdBeZwOtvkD+HCnIJ+i0II8bGIgqmYPxZi4vy0/WneMjd2
 RbNtiQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt5469f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:12 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963b0a0b727so154236241.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785752; x=1782390552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QT+lpRDehsZI7hXyRu6vmgnawl7vsgjxkM6fKi7YS40=;
 b=K68on8o30JxgENIAmV8YTMQTXSmtipRo43DCTzlc9uE2Bh+AfQLLMDnr6H5z+sJfMD
 i4Ud4mWp1WTWkVZouJOzs/Y5p3nxburlb+k+5MOGizEkQbOigUyOA+tlsL7CSC6/vBS1
 0GIokxDI2NXh7ZmUTSyRRuFg02uLZAgnIby6Git7ftblhvZLv0gjdq6wNEl+ITAvRmD5
 x9GcBQmUksJ24ar80DuvMg2xMvrOtnfAUws1VEa+Ag095TiLFV/ND6tg0yZwferUE/TI
 5JsnFMD0+rMnqrdys4dHsk2ZXKYAJOqkayO5sPe5WPbolLee4fxBjARwT/E5SdbmDpXv
 A+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785752; x=1782390552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QT+lpRDehsZI7hXyRu6vmgnawl7vsgjxkM6fKi7YS40=;
 b=acHa1fJTggHxvXxYG91xJOqLviBpr5nE8ykSDWfl+CTuMQggEWAAiy9msXG0heEHAy
 1a5XEb33D9BQ/OnjYz6qP0yCoamb9kVJCGiFeG7J4wk64M/2V/ogf6McMY9R57NQp9iR
 KQ2Ee9jKL0H6xYFB0glG+j1ZpyomLkQEj6Rhl9Ih6n5hy5jJPdRtXttMIlzrsDoSQdrz
 jXsMEhnVwycq2qg4Ryt9BxNFRbvg6Y3XYfeP42zKC7z2G++R79Srbq07NYfpwNbbMBHP
 NuF69z5udnUuk4Euoy/mGoJRn6h5+w8nWpv5XKcaXVvMPEIVQP/ph3FwcHzGlpwR0z+2
 m4zA==
X-Gm-Message-State: AOJu0YyYsCK0FaQAGN1k0wbw2xN+51T3hE/4hsuwwCiEe/IzDUuLDyMp
 CCNfX4LZ24Cmruyc4+IHLPyx1wnRvPGK5bDl4/GOxXgl5/amc1+FzjFnCobmaTbsS0yp6JRJHxS
 dUGktTaDjFbC3pxive9bDo5v3FAFfKyV4FsGDggDuKsvKhBSujm/cQZ6s5p4mWGhd0w==
X-Gm-Gg: AfdE7ck8rOqUI6YO+c2LhJ7lDjxgQwAsJynWD7gTSGcA0xL/V7UBjl0MIu3YiBduOK5
 Esy0UnUpvQm4jzrkSo8PxaTCWljlbPiSdp3ImbYtHWHVhHJJzjTynq75FdiNVtGyX5CENKkv6Vw
 ouyUaUuF+yMFK3n4FkNqY9iklA0d4W2MM6QSIZXMTBn/J43ILwV0HFCs0mnvuA0oOnkzZ9e2nIh
 k0CcMwGUnCYRUcIdz0PGKBL1yJFXt73by1gfbfHFyMpKy6DNfU17WEhhLj64rq4NFu11NUvyPOE
 L/m9VQsVKH0Ma4PPwsQaB3AA9QOPqUue7Ulgqbp99t65w66sns0aHRh40lFMav6bpFGFzsbiNFB
 YN/kYhTVMY4gBzpGFBvSMvKx6t5PT6UKeoAdZA5pWP7lIl29wVXMczpRYlDhGpcnA2tHJ
X-Received: by 2002:a05:6102:5087:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-727c72841e2mr1566949137.26.1781785751796; 
 Thu, 18 Jun 2026 05:29:11 -0700 (PDT)
X-Received: by 2002:a05:6102:5087:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-727c72841e2mr1566926137.26.1781785751334; 
 Thu, 18 Jun 2026 05:29:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c5266sm68572030f8f.29.2026.06.18.05.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/48] system/memory: Constify various AddressSpace arguments
 (access)
Date: Thu, 18 Jun 2026 14:27:43 +0200
Message-ID: <20260618122825.90331-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xVRhiGM3T42_VPQtmHauMBZMfwo7-XIa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXwyjX0xmzkxGY
 UpyidXFxoCbAzBEq8z5XqwvcRo3tC8KeJ4rFU/3XmTL/Z26i4k+6ZQZy9krzgYDDnyW6+nNF9Cq
 iwR9Vj02FKTq/VNbOwJdsx/YkAZPjDU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXylcd/uE/mk4m
 NlhyLv98rNmvHyTnmZUWc83QZ6R8WHPMH30Qey5677DbAuzxpu/a4rEwtBHb2zVmhyiVNC6on65
 yC1k8SzRvwvQu+THSgoDMEkStnRMaWz2ctloVMjsD+jQN3YWjDpK2uMceAv8ZRbY7BkhiNT6ClA
 +T988FBXbEgUm/bZ6t/OwDiB53HD1NtctbaFsVvUnax22GiH1vckZV5vxI2yB1jDCuCu1k3u55A
 pqcezNd62ZSwTIy6sN6MXUj3WdouUi+lpGjM6uEhnaXh2GZ5g9WiSHd+5zX7610XLFwfDaQRHhZ
 NCtuSaw4+ukUGzRVYAxteR/TQwvkIUN6qthxfo22cXO4CgGFyHebfv6t5xtP+7AP9oyQp+hPjFN
 vCedHtHA4wNckHLuZooMmhCPxqQfBMBtUiJjyO2ngDWhkGVAyTgr81nPW/n9Hu5I5GMavg5OIcC
 2Oq5oqnVHPe9wMTm3mg==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a33e498 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=6VrJFKV1bllTVhfUZIYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xVRhiGM3T42_VPQtmHauMBZMfwo7-XIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020359.18627-6-philmd@oss.qualcomm.com>
---
 include/system/memory.h | 13 +++++++------
 system/physmem.c        | 14 ++++++++------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 7ecad33130c..e143c9c3f39 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2719,7 +2719,7 @@ void address_space_remove_listeners(const AddressSpace *as);
  * @len: the number of bytes to read or write
  * @is_write: indicates the transfer direction
  */
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_rw(const AddressSpace *as, hwaddr addr,
                              MemTxAttrs attrs, void *buf,
                              hwaddr len, bool is_write);
 
@@ -2736,7 +2736,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: the number of bytes to write
  */
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_write(const AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const void *buf, hwaddr len);
 
@@ -2799,7 +2799,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #include "system/memory_ldst_phys.h.inc"
 #endif
 
-void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
+void address_space_flush_icache_range(AddressSpace *as,
+                                      hwaddr addr, hwaddr len);
 
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
@@ -2919,7 +2920,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
@@ -2974,7 +2975,7 @@ static inline bool memory_access_is_direct(const MemoryRegion *mr,
  * @len: length of the data transferred
  */
 static inline __attribute__((__always_inline__))
-MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, void *buf,
                                hwaddr len)
 {
@@ -3017,7 +3018,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  * @len: the number of bytes to fill with the constant byte
  * @attrs: memory transaction attributes
  */
-MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_set(const AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
 /* Coalesced MMIO regions are areas where write operations can be reordered.
diff --git a/system/physmem.c b/system/physmem.c
index b33aa14ab64..7ea65395863 100644
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
@@ -3447,8 +3447,9 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             void *buf, hwaddr len, bool is_write)
+MemTxResult address_space_rw(const AddressSpace *as, hwaddr addr,
+                             MemTxAttrs attrs, void *buf,
+                             hwaddr len, bool is_write)
 {
     if (is_write) {
         return address_space_write(as, addr, attrs, buf, len);
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


