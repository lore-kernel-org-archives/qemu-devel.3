Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA08FCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJES-0001JE-K9; Mon, 15 Jun 2026 22:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJER-0001HN-Mt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:08:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEQ-0000sp-0L
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:08:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xkCl2147845
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 13xqUQeaFiL+vpizQn1RiOcuK8+bir7YOyYILHwhszg=; b=QoQTMRq6ik5s3blj
 qWk7YBf7mwu5x4KN1dmNyxX467PknlDDESpi7mfbKUSYEgXMt0pFnwJe+QiVh97c
 D4UvE4UK75gKgv1yrMyH0DJg+J0SSI+yzla3Ur1aw9Yz9VQIyhyJv2ewV2Uaam3C
 TyBOx01Zn9y6vgQ3RBxKYptQ8N1jIw8CTmAJG6Rnay2VpLBbvSBKLlnryzJ10/u+
 PXY93qxRHfHN78bPtAqaZlNMrSu0R+SpEt3xsOmRlRFYwVM4wXjRpVSz2OyPe4Au
 aQt7PxHaiZgxFGu0AQ0zx1LhLYPnpjFY0YbtPxDqyfQPB8mXOw+Rrg5vkeQzCsqp
 p8zTyg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf428s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:08:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91574ad6871so614572085a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575728; x=1782180528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13xqUQeaFiL+vpizQn1RiOcuK8+bir7YOyYILHwhszg=;
 b=HESNA231Nx+jpS/JRt+pjp81ycOb7iXglW78+HG3nIsvbhoW/ZwLrnNuixduivNIjf
 hOxhxcMGMgMoLuWBwDq3igOiDxtMtGaaMto2yaYhY8CKki+397KoV+gApFuXpdIsKMbO
 NoCSqwEx2V7syr8ZApwsOhio/9UFYJwR1NbXr7TiW7nzKpHKg6jp2VbdiLwTX41zFLP/
 F72riQxySKXs32l8W8x8/S+UEeHakkbRSp8Kwj3St9UKgm1ZBmzjPwZVH3GFvU1huiNJ
 t4pvrRPS5V+QERo9uei99+8g+HHhueBsmOLZ9j7vDkGisFAG23kA5+kTA91EolxOCgL/
 BeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575728; x=1782180528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=13xqUQeaFiL+vpizQn1RiOcuK8+bir7YOyYILHwhszg=;
 b=SjjbcDlWLvTmHtC3wa7TZHgxT8VYMIxyF8h4E3GiWCR8HvUDvCtYv8Dpyc8cxdoZ2S
 CTdnczKn/J3kwiSI8sD3K2y04hw2n/kiqlYGEg1alpUDtYI8iwVmsDO8zP/TJMu0zDyI
 V3xu/cVvU6xTjrNms2oGjKsSRJ4Lmxxm27wJUS04twqPBbFpSyZjmmJJfk67Wr2GMHUz
 xtXgyJ+HyVB4k9MejAG4UyBkH6ZUE2jO6Vi1COzpCShHZXwcDmvmU5lz/lPVsZQJp0dO
 MnkNP4+bwpVC54fK7+2i1cc3KxW6UcsTTggleQwQrl20BSAx4oE+tgb4BP9wBWyYpHJ6
 bDfA==
X-Gm-Message-State: AOJu0YyBmhM3A/8tg0PsblQfe2acCsofNAJO7IaHCbw9VNcNIWFvhP6r
 PN9Z3I6YkKE5ZtKV+IXhKQHlkFMlbiXjuHUh0jSd3VFrrfyXd/DKBshxZG4NAs5LRYoYSj9BVeg
 P22ZIMPpgy3VHvuynfztQ7HQo6PHtwAzbMa4/jvNSTDGabutMiffsgnJjSyzpwNVBbQ==
X-Gm-Gg: Acq92OGHlLpL4Fkb75otPQ5CFlZGXSQzR0S3bf7tkhgxDlQhah9CtOtF5BgM6xxiP44
 UzUvMy6iOXkvbalw4GYYun8igljLuinQSgxGCrOVLiS4OhGdvfKrcHj1KrA0OliNtDU7cMitZW5
 AwxAzZqHUMvHiPfeYKdpaBqZbhdaKQ05V265OG1wJO5eCy/R/uoPPb/FjnbNgHuCfXKm1JkUYLz
 EbjEc1yYpYaoQBnzU6hym62YqZkTqjg9MlsHTQZTVzaDXSZQwUfDX+/S5v14qByIf1aRcOFjPSe
 0DTHMkKMH9DMyOwtiHrOjpz/6K9reqF1pDjOu19tP3HXpO3jjb05dGynEdjqih+SPaaBtARqKoi
 yFzLn5dUWakuxHfmZyF3PjjV/v6eUmtSXrJe2+1D3Y/wut6MIKjQRtRFGX+IHCwdJrcRamQXNQW
 AbRc4=
X-Received: by 2002:a05:620a:468e:b0:915:6758:24d8 with SMTP id
 af79cd13be357-91c48b319bfmr270382585a.42.1781575728299; 
 Mon, 15 Jun 2026 19:08:48 -0700 (PDT)
X-Received: by 2002:a05:620a:468e:b0:915:6758:24d8 with SMTP id
 af79cd13be357-91c48b319bfmr270379385a.42.1781575727878; 
 Mon, 15 Jun 2026 19:08:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47d1csm37228205e9.4.2026.06.15.19.08.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:08:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/6] system: Document cpu_physical_memory_*() declarations
Date: Tue, 16 Jun 2026 04:08:34 +0200
Message-ID: <20260616020839.19104-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020839.19104-1-philmd@oss.qualcomm.com>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a30b031 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ur4Lqk0a5foQtgUicssA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _wdHvQK301BWLZuzW8ut7ZtNiYZuJCYt
X-Proofpoint-ORIG-GUID: _wdHvQK301BWLZuzW8ut7ZtNiYZuJCYt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX8VibCJfgV/Xs
 FsmbLucB+clnh29yFnwnZl3PzME9ar6QY4Ou8grGsI7S9i0sfXj0czgeP4Cd8c1bq13a0q9G/aQ
 YYcEu+CAF7Ae1Y704cXpxFzW+HND/d0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfXy6rMgMi12Mzi
 SDU/cbzus2TEOb10KyF2WVtjtVjjjniGZ81s6ud8UD2k7g6hVU+EOdMulKJs8h4oRIrr5KubIcG
 vUhCzTVfZ5blOFIrW4US5gM1FBdVW/O1z8i10BcPcq6r5UFcB1XsaxBKi3nZtOPXBT7JI4Kt04B
 OXK0mrVRF7VyMBiVbf1Bzg5qovGE/iVaIVeOK7ZuolZBaZbOsDaxmN0ECEji/Cgjw8q36GCuu4G
 NtrCI1kZNfoi383+VEeiQtOGFMVK2EXjH0T8rm7Sp2eqpG/QqIEk9XXvHy+VO9HuzD7fvOXD5tA
 gDaO4YPzOinFAmHRa9Y13xGAHN84qaCig8pLIfiBGMhXXmTAIAA+495QD7l4OnJgOMf3iwS4H5Q
 HFn8UmU85/cx1RMqvBH8lvcFKAvmlHR/h/XaxLFiq2ifeQ0QT8e0Xj9tiFAy0GmIb8LyV8SsfLS
 Hn1RlqzHGKmQBGhYnFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160018
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Document the following methods use the global address space
and discard success/failure access information:

     - cpu_physical_memory_read()
     - cpu_physical_memory_write()
     - cpu_physical_memory_map()
     - cpu_physical_memory_unmap()

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst | 10 +++++----
 include/exec/cpu-common.h   | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c719241a7f5..f2c66e44454 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -443,15 +443,17 @@ Regexes for git grep:
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 These are convenience functions which are identical to
-``address_space_*`` but operate specifically on the system address space,
-always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
-ignore whether the memory transaction succeeded or failed.
-For new code they are better avoided:
+``address_space_*`` but operate specifically on the legacy global
+``&address_space_memory`` address space (which might not be used by all
+machines), always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes
+and ignore whether the memory transaction succeeded or failed. Expected
+users are hardware device models. For new code they are better avoided:
 
 * there is likely to be behaviour you need to model correctly for a
   failed read or write operation
 * a device should usually perform operations on its own AddressSpace
   rather than using the system address space
+* some machines do not use this global address space at all
 
 ``cpu_physical_memory_read``
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 1eb28734601..9cd67d3ef9d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -64,11 +64,52 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_destroy_address_spaces(CPUState *cpu);
 
+/**
+ * cpu_physical_memory_read: Read from the legacy global address space.
+ *
+ * This function access the legacy global #address_space_memory address
+ * space and does not say whether the operation succeeded or failed.
+ *
+ * @addr: address within the legacy global address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
+/**
+ * cpu_physical_memory_write: Write to the legacy global address space.
+ *
+ * This function access the legacy global #address_space_memory address
+ * space and does not say whether the operation succeeded or failed.
+ *
+ * @addr: address within the legacy global address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
+/**
+ * cpu_physical_memory_map: Map guest physical memory region into host virtual
+ *                          address.
+ *
+ * Map a memory region from the legacy global #address_space_memory address
+ * space. May return %NULL and set *@plen to zero(0), if resources needed to
+ * perform the mapping are exhausted.
+ *
+ * @addr: address within that address space
+ * @len: pointer to length of buffer; updated on return
+ * @is_write: whether the translation operation is for write
+ */
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
+/**
+ * cpu_physical_memory_unmap: Unmaps a memory region previously mapped by
+ *                            cpu_physical_memory_map()
+ *
+ * @buffer: host pointer as returned by cpu_physical_memory_map()
+ * @len: buffer length as returned by cpu_physical_memory_map()
+ * @is_write: whether the translation operation is for write
+ * @access_len: amount of data actually transferred
+ */
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
 
-- 
2.53.0


