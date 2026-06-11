Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4884CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjkm-0003tX-C6; Thu, 11 Jun 2026 14:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkk-0003sz-BE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjki-000737-Jn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BErnHl823169
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z9WJv6VOnE5WwFpRSGuXGHpfVT6AmepQWzkkQ0o13pk=; b=kQWNE8QJPlo8MKB0
 ScjrTTWnVEAlz5DH+IiRzRtPjVN1SL6XSHTnMmwDkUdnMaD0WQEm9rBQ2zk0oqUx
 kMGYX1XK/SWxN02zUC9XUSSToSlarwB2Zy5E0QgconfRp7tpcJKZ/oBo8MsuDyvA
 MJTrYLT4LkEwUr5JyL+u25ZJGNZLyNzDsJbSe3Ae0NrS/3U1TXmoAUkCCe3KMKm9
 Y+Aftw2kCyEsz4y9fvuZX/oELZiZkFbphzxX9gi+YUwZZQV2eE4kOOqDxnGNDbfu
 H+WX7dkMNAZ4jlaltQ3AvjgEMmpukmn6cz8kSP92+zJkG63VlTEJuB1iKe3DZo6s
 ML4q9Q==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ucy6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:38 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6db734d48so208747a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201018; x=1781805818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9WJv6VOnE5WwFpRSGuXGHpfVT6AmepQWzkkQ0o13pk=;
 b=GIoaMyaZVO5UASgIstniAz/ty/qDJSnPLnjCJr/JCZL6uodUX9DYpMQk679Q+lavms
 JLjxr4a6epaV/AsKIlsAdINnppU6p2krycTivCQkM0zVznW7Fc/s1w23VxSIrdI6Nk90
 eC6m4QP4xVmSPIZf28glaUPUfMWnpAGPzeluCb3Bs7+1pCLB8RE6BMLUm394xesRWXy3
 SQjGpatNpvf7rrTa4navjTMwC1/MbBcRd4mWpmwH+KmYBrLXrjhd/J76OeGALds9bHEx
 too2EngC5c2RuxcT0yAluRh6x8ubKwLZ4MP43WnUuAWgR0qC8TRvidPWRyHJ7kI3O8Ht
 +cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201018; x=1781805818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z9WJv6VOnE5WwFpRSGuXGHpfVT6AmepQWzkkQ0o13pk=;
 b=eHhrswVXISIB065oHYq5JmE1+y1GjsGopLQLWUAwi3RA0Q/tHO3huQI/7JTisNE8pz
 zqqBAnDbvK2jajlNW/nnXy7ZZmiZesXqf89svbqqv+bbSMF9rv8YLhqoP11JXKiIx+ux
 V6GhL2NX8Ln4tI5cJ53qzvegXv/kI1ahWU5VdiSnZjpYuaCxndKQGgQDSLFINbv6DnHy
 NDiv3YWo2EHppq33EC3yR0kFJN7Eh4/rFIKbuOEbKOdm2X4NtZcqCsoU+0k/v/UZYazq
 vogtPax/DcDCLcLlWTTx5r+vDihs1LTr7Ey2FuoYeoEdkA9hdXTln9b0gYyZGXpkZB0z
 LECQ==
X-Gm-Message-State: AOJu0Yz5QYJRMeXBSMnPaQwgupJfp+UeWDEr7wfNYv2ec5Df4stSerI4
 tOxCclrQJvjksjvWPHtFohhJsmUkOarhxf2VyjDsPILL19F9HTg4JjCCcjb0DBR9DegFo+5k+36
 dl1r9F6dpxjK4b9ZgEL+mLudEOrLgWqczanOw5Vrvr2t7zBcMcTIq7G8cDqZTU7IDxN1L
X-Gm-Gg: Acq92OH6XfMxiNdzbWTvoAV2SgTfD1W61JNiRIHYzlturQun9mFbZM4BWXuEETbT6+z
 jxGdcNmWZFeUodc+Vm/ln9JlBPKbqKrlBLPI3FvxtzUqY7a9L6PU3odlKagHUQYMGD/WjXW4TaA
 s+8XSKnRWVGuUqSumaHvXUOlh1lr1D4GTXF0qgjHVOA+etZkbDAHO5nNOSrwk1srKqHKMtHouH1
 0PxP/9BWYqGkPPu7lGhpWToIm4d6BCS8wND8x/3JWpaNLkznfp/C1oCs4MlcGHnjzTrPwdZBCm1
 H+lrlRt039mU911VXA5PUef+S3Nmp7OEw1ymxc1njvydOyPnzWMa5MAZc8q3wTD7azzOYmi5AOO
 LlQ7du/0ZIem9bq8qm6ZfuzP5c13wj2DsoOjTvhZ/0uGkHjwzIHvVVUyYIUkN0ZGN+S8WVhSA6X
 k5plvq2EV9
X-Received: by 2002:a05:6830:681c:b0:7e5:6d2e:acd9 with SMTP id
 46e09a7af769-7e77351b830mr3268681a34.12.1781201015943; 
 Thu, 11 Jun 2026 11:03:35 -0700 (PDT)
X-Received: by 2002:a05:6830:681c:b0:7e5:6d2e:acd9 with SMTP id
 46e09a7af769-7e77351b830mr3268309a34.12.1781201011875; 
 Thu, 11 Jun 2026 11:03:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0c2239sm740928f8f.7.2026.06.11.11.03.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:03:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] system: Document cpu_physical_memory_*() declarations
Date: Thu, 11 Jun 2026 20:03:15 +0200
Message-ID: <20260611180320.30320-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611180320.30320-1-philmd@oss.qualcomm.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfXw31lZ06fUL5I
 ZZ4sVBdY3QAvcP2Wtrzsnwu1SCDzXPIa7KFyekzJHdCBx4LKQ5ZhF1eST4bSKY6e3XhevPVZ2S4
 ETyTy5ak538wVJOpssXmquPZ1Z7QQcE=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2af87a cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ur4Lqk0a5foQtgUicssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX9OT3haDeKV2f
 3Pf0WTi5n71PxFOXAnK5C46PIYxHhWzn3Pd0zi9mEKq3TI56RvcizfjaOBccWgo/3ITDNfsw5rL
 SkEoilAG1fWng5k2Q4qG3Un3Z29AQIIbOh1vsUj4zXCSLsKg9h3P+yDgBofYFZDLBjiewoSw3LZ
 8Oe2Z7UgI9WKHgfbgBe2mLSsH1NFT1il4dq6c9XzEGyKuegHdRzb8+9+mFscPjIRg5MUI4qvf8i
 iM4AqOocp4JklmtVV1GjIXVJ12TjT3XLLImwW5ZAy0qTHKw/y5y7scNJ4BgOsvc7vohpwVoc8uB
 XqAmapB7dC+CIMAJBiFKLxbY3Qh0NSLATvSd+HeLf0KRlEnX+FGz5A8xziZKzyq0vfh140gMb6u
 NF0r574zOiwMWaRtJiDy2gRQNewKpk57MyuEGx4jB6AHVNSXDDrSvIRcFdDBcGIYr4eNJoANBT1
 E91pxRBa623iJHfJrXw==
X-Proofpoint-GUID: eFWsRJyaHUJosO6lG9MwJJTSXCdG3a_h
X-Proofpoint-ORIG-GUID: eFWsRJyaHUJosO6lG9MwJJTSXCdG3a_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110181
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
---
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
index 1eb28734601..271736dc53e 100644
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
+ * Map a memory region into the legacy global #address_space_memory address
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


