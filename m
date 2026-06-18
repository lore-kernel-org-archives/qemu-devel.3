Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A9FCD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBsO-0000T5-Lg; Thu, 18 Jun 2026 08:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsK-00005x-LZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsH-0007uU-0x
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArg1J936388
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K7zSoOStIl7IIfcOC5k1dkMhcKXnAaFY4ub9+VP6h80=; b=XACwrCRcGTidoE1k
 Nt47g4SOQBZguEdfHUw56oyQch8gNRu1bq44+TAPGt/eACuMGh6+gfDGEPnMyKT9
 4jRQiinFydM4zmBphwZHKkhUUzMZ73VRESR3qMVuuL5TFnLTFmJV5MuNZgm1JKlo
 uwRroC1wGowU27jKXTxCZKzcJWgTXSjCADaswUS427uDENbQ/gaw5pTqWbGYiFpI
 TUyquz7EFYi2FPSeC7fO/9xwXRGcSSZIVv/Ewj55JAId2YSQUzNhgHEuP01dXxHz
 38LBETFgfdXc3xc+sk3HnMdTvbyODsXpygndfH6FBKZdaqDAxl7rOUr4IqalCZbr
 mlB1/g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt546a1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:27 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c89de84f33so1380460137.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785766; x=1782390566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K7zSoOStIl7IIfcOC5k1dkMhcKXnAaFY4ub9+VP6h80=;
 b=bXDysEMHLXPA+9vnk5D3nS/Secn19JkSbd53SumSXqOW7XMuV3c2NOGWysiUvMHKDt
 8y2P6as677zBUQqEG0Vo+Jw/erAE+ECTHUC2UeFzMP0koexJP44YNyV8MHjtDGJfNfvh
 FcBtf+qsxOUqolswwa9SrghKf439YZs+GJDNogknqOB4820fnk+xuQ7A6uPSHcxUc9Uo
 0gbjim/Au0JLvIyv0PjlMneFmPqD3qEt1JOzlLyMmxG7OFXN9aPJD6YdrZz/k6tjVtJt
 mrY0sd1SNo4yB7RcbAkR+4A/2igF3THs158tZYv+0Eg+RryTqBh108cibdNcycd0LivB
 PUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785766; x=1782390566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K7zSoOStIl7IIfcOC5k1dkMhcKXnAaFY4ub9+VP6h80=;
 b=EY+GTmpghclcM5+ohNKlAuypwsSj8h2firdWrDbFL2OO2I0vBKOB5/4/GSxl1fqXZ4
 byywf1RajZeMBPj4OpT6k4jxf/qEPO1oUdqtHOvsWC7wcTBMef6E/73075QNUSSzZ9Nk
 ZSjCtpYCuON6RwsrxkU2RTdlfNQMZFO9A8jDAAPdk+AA7BXJX1QLQLcy0tfHDTgnsVZc
 /r6LCw9aK+rQMcEzDH+1Q++/ujasdlj6yQ6kDmNulRgpW/4BGM1jxMZsYgwHLiVUgPmV
 0Le4JKmU0qCyeLnG8/YP2Dhj/nBlDzLygoZqOoAuhui5c0yD9IlJ+13FiIMLuB27Osp8
 +4vg==
X-Gm-Message-State: AOJu0Yx+nYSomAfBCX+dlhsDSiSHU6s7BJJvrqXMSuVlo1T1ZbrY8yPJ
 ZZVxJS9prMPsqP6gn548QyIiOokKM4jPH+OMfs2hiY1BDF2A6r7KWztXfm/GWkVJ42ldzVh9oZg
 xEA20ZJ9AN85RIX9nwpZhYgsUunF1oiEocXy46DUQNB7PGCdME3B/IKMuvB4KrGQ5BA==
X-Gm-Gg: AfdE7cnceyShu8CNXIq84DWbYWGDJqEaIURTPu/P6XP8l5EjFzoe25uf0KHBtCB/BWN
 bd0y7kOFojtIk1jDbg1TcGqtcF5aJg1Ob0E3PFUBDdFiysaFSYzBKgPJVjHSMq2QiFrmA5lkW3O
 QB0eZv08b4NxxRZgsQx/w9AHn177lHAdigZAMx4N/UQrGMEfBSd72cOKIB/NCEzpw7lEyI8wWe/
 hj8gPRtuL7AZiSPrW9xxSmb3NoQtNGH1OCZ3vUpiJ95k9YrLY3+w6jVFBCFubdUWkl1DtSMH0wQ
 7ej6EQmDXld0GGRGPP/dSwNkYTtcNMpqUlMQwZtgEfxDXZnWcKOdYOpEklbyLX71N8pRC5xULYg
 Lb6Swjue1SXHvAZZ69jg3BoCAr3OJfP2WV3YgZxJnoYnNQO/J+3WZvUmrXdYUtYqtOiq4
X-Received: by 2002:a05:6102:c54:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-727c51d101cmr2056582137.11.1781785765901; 
 Thu, 18 Jun 2026 05:29:25 -0700 (PDT)
X-Received: by 2002:a05:6102:c54:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-727c51d101cmr2056573137.11.1781785765460; 
 Thu, 18 Jun 2026 05:29:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa9f2c0sm292657955e9.15.2026.06.18.05.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/48] system: Document cpu_physical_memory_*() declarations
Date: Thu, 18 Jun 2026 14:27:45 +0200
Message-ID: <20260618122825.90331-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F5IKC7J5Yc7jZqmzwn4rrGRIB3VX0TyM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+TxhUK0cAki4
 zxDr7Pch80sF7iXnQLINJP4NV11Cj85Lc22FcCUHPhu54dFjmS96yooPxoSk1cIUmwjx11gARcp
 AwB7XBz+HJP+0KzVqWStxcf8AEzYuRM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXy2Wu+doTs3Hq
 mrYcikENKjQci1gZriYBxDIGyMUpq2dC8+aFtgTw8sOi+jmJ4gI5YWp0AopceGF/ul0gwPzxRkN
 z3brMjU7cieyYo2er7+hs3+LBGaoOe2NdlvXAMyS/5Zj2fSZ/1w7XghCw6qyTRUVIo9sDzeVLFI
 IUi1HoyN0xlUQpnm+lJf7HDkwigrRfRxgmbpnjrJ76DEnuC+VuiKKr2Nx46S/xr/PmBeVeTzUba
 R6XC9Tutx+6Geji6ChkAbd3XgSooNhPLW/hMY0NqL3BazC0qUmncmR7KWzG7ej/IeqMybf5Hb4x
 iYmT4NErLXgSETpfE+YY0y2P7uamGGUnlOtpFiFA5UVb3Shxt1TLXhB6djeVq3zHKoBunvIr84Y
 89824c1/ponQSRyaKWZYX5+l8uzyJurOof9DrW/U8S+fatVm9BPoDKdl4yoyAJs3kXVysBPqbXe
 S4xgkxThHK1YMdoEaXA==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a33e4a7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ur4Lqk0a5foQtgUicssA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: F5IKC7J5Yc7jZqmzwn4rrGRIB3VX0TyM
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

Document the following methods use the global address space
and discard success/failure access information:

     - cpu_physical_memory_read()
     - cpu_physical_memory_write()
     - cpu_physical_memory_map()
     - cpu_physical_memory_unmap()

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020839.19104-2-philmd@oss.qualcomm.com>
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


