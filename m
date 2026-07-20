Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696ABC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluEh-0001fs-0P; Mon, 20 Jul 2026 16:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEb-0001cU-5A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEX-00059y-Fz
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTqSS3599631
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I8DBmh5HtiJ
 ox03kLcelCuLHkJ71ZO85rbYQL3zlJQg=; b=LynyyeZK2QT+iATv7ubLAXlvcw5
 iOtUHntm7vX11RttxUEciSgUZrVlvgNDWCu5jLVA5Hu0yv4uZA6ECvKaz6HfKmG2
 xRgEatSpe7k6F292lElgWhEgeNPUUa4Gi8a7yOGreRUMoV177pNW30IaDLWApJFB
 uOKpDxTSgdXA5Vt/C3swLSRk5kk9HJGfJQ4UxENkxBQpxcXFKOwS/NyLmzGZUoEN
 V5aOVJG/F6R/iHOvknKbhQtysd9xqtqf9aBDBwEQD8NiFFth91cR+PrbRPk5g4NV
 Sve6WJpndd12Jo5NOYjkctkf91mB40GixLvhpOInpdIpqIWKfAHopehJqkA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgreay4k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:05:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso14801489a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577899; x=1785182699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I8DBmh5HtiJox03kLcelCuLHkJ71ZO85rbYQL3zlJQg=;
 b=V/BXqETsm2W7Y9gt+OqSTvjVT0Sl/nXv5tSIVEYQzChAVCC+bN8vH7O/+JqM+LPPDq
 RySIQaz8HXQCQMdAFi/BvEko0YevjSUizOtS7FTy1GgfRuZgTxADtr73cjlwu5ZSSZ4M
 Xcosm7SC5BjXmPv62fXb2pCggW2ec0zirlEwSm3s/DPiuStX+IlFv5Uesnmw4ICitCDQ
 OXgIVu8sx0j3dD/8uHrw8ZoezuLB50+3KEhE7Yq7wbB5U9/prsuEbPZF8K1SuvORvHTM
 CZtS0I+7WXtu9sYNgFwVFn0muagqTI93VMxBwmkEkIV8MnAVfyYVtXUoJjKfmLXCbpoQ
 jUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577899; x=1785182699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I8DBmh5HtiJox03kLcelCuLHkJ71ZO85rbYQL3zlJQg=;
 b=Gxgq3fPKneR35BzV51Bk35f5nplqZDBFxQXW6Y95maDv/WkCrMcrxIX9LxtRvBmqnf
 Ds4/4Ft1G6Off9suNX3re3yNXktL+ZR7buB8Dbg7ilq88+29ARKn69LMPcSrONDi2u0Y
 L98Z5+YUuyCgu7pCW/H4HjCTkWdLbiVtMW6duDxG5kW232OemqqpAk0XFKhJSvm+c+iz
 StHlyf8blDKr633OugW3o0fg1gXALGZLRoXN+MRVD/xuLmmauHQbirnjezrokhIBNnaf
 kOjbRcyGQBF9a/fdcVZdKUivHNRCjzEnPylrlq0daY7fBj5yjCRc93FgjdXaxhfdScsx
 DWgg==
X-Gm-Message-State: AOJu0YxrDHrdoUSbbXrJ3slJAkvhCgTDAS6YzZvPQGQjTcGkJ/QYCpY9
 LV3ePG11FEtK6qPoo9gMhdgjoseuFosofSDLqg/1D38EGB23t4GLhUjFCRHzrhkabv+4hFlXDdk
 tsnRk2TF79F9dCs0SniU8wJXr9jlM4XS9D9h60U9VtU0Usow1Vav/YFFDtDFcUCrheQ==
X-Gm-Gg: AfdE7cnaRh0Z4cqT3J+mq/uBAy43vz8KldINWn1nOonaCZouxJ1Wdds+uhTgFqVJcK1
 pLCGg9Qlkm0VtY2kwzbyOx+OgpWkjW2aJusSCWxiZIndCQBTWqN7GwA7sx055P2zy7rYqBcyHt7
 QGTDA9gjDPm4xeMukCxx4jbU1vZBN1BGqqKumst0k7TqRYONVJajw9Elkbbw3ohnbXOLhFtpij9
 HH3Fpe2S+MIA/iNLBCz72Adpe0+kHJh1NQNlVtGghSIWt9DINmuYRAweZMopY7bPQWgVM2PtZn0
 xMX3vyal/ZGy5Nq597L+M2QO5AmIWVGczoUymfkiRZOj5v8R7xoQ55rLMRZOL0O/m5Nr3eRbW3a
 iLlwqhsVQpwioTLfKBG+GxooPwmzzc9mReWqITJfzGtFYgBE7SnZmc8iIOkPFObuZlTfilh8=
X-Received: by 2002:a05:6a21:3b89:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3c3ad7928e9mr16730005637.3.1784577899186; 
 Mon, 20 Jul 2026 13:04:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:3b89:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3c3ad7928e9mr16729953637.3.1784577898517; 
 Mon, 20 Jul 2026 13:04:58 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dd90fsm38487229eec.22.2026.07.20.13.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:04:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] docs/about/emulation: sharpen the dlcall boundary and its
 guest requirements
Date: Mon, 20 Jul 2026 13:04:47 -0700
Message-ID: <20260720200447.2145622-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfXxBHQpPYhojAl
 g0wA7n6TB/U8m5vkZcugsiPCSIR0wkIvI9sNeUnhDQtMqEGD0o8DWDS9I8XnlzQAprxjdtICJxE
 qaIKmKreBhsGgAjmhJ4gc+y39h2GvaI=
X-Proofpoint-GUID: a6NvfwvAM6YsjkOQqb6wsS6dKSq1AoJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX4qrLhOeo8cgC
 7UQV3+qqz+a0dZWQv9CdejeuqKdf0b+B4h7wV4hwmDzpvHrD8jzWWqOxxjqRh4wW3jI12lAi2It
 YMEDlZFgdrwYaJkdDAVkXqNp+/TiJrpzDBwuTiFnucr6Ge7TjKM8idg5PrAwUw0fN1tE1HLl0Bs
 CPWr6x3M8E0wjQO8DMof5YB8dqqjx9l4aG8BHkuLLQvBZxdrbtaz8Afi7sai14lDBqQTielIknM
 Uk2yKvdGlZ1UrcOPe2S8oi8sRu64MH2egdpDtaA9jNLl9ts4B0R5sUSD1/mWKJIeJ933Nvv749r
 qeca6vG+mk+Up5kXj3C1V4ghDZZiknqwf6fF/pHwGCRf6mYW5pwlY3ng/h0aHBE8oRV4ZLo0hPo
 UyZQtacrP5dwnCbnxpBHlNpDp7Gq5fYIt9ctlaU4aaLQDyTYHBO+bEoh6SOl/Z3uM51mz5IwNEF
 i3mvAwar+domAj04TIA==
X-Proofpoint-ORIG-GUID: a6NvfwvAM6YsjkOQqb6wsS6dKSq1AoJs
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e7f6c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=wufgJPMxU6gFt7MLWdsA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200219
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

Record the same data model requirement as the plugin: guest_base == 0 is
necessary but not sufficient.

Describe the magic syscall number the way the plugin now does. It has to be a
number the guest ABI does not use and does not reject before the plugin sees
it, rather than merely a high one, so show syscall_num= being used as well.

A library is not turned into thunks, it is left alone and the thunks are
produced for it, so say that instead. Argument marshalling, callbacks and
variadic functions are also what the plugin does not do, and listing them in
its description blurs the boundary it draws. Move them to Lorelei, where they
are pointed at as a reference.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260719074730.1520517-4-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/about/emulation.rst | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index b861501e85e..c58149086cd 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1072,14 +1072,13 @@ syscall, so the real kernel never sees it.
    Trusted guests only. The guest can load arbitrary host libraries and run
    arbitrary code in the QEMU host process. The plugin is not a sandbox and
    provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
-   default), as guest pointers are dereferenced as host addresses with no
-   translation.
+   default) and a guest whose pointer width and endianness match the host's, as
+   guest pointers are dereferenced as host addresses with no translation.
 
 The plugin intentionally keeps the QEMU side lightweight and knows nothing
-about any particular library or its calling convention. Turning a real library
-into working thunks, including argument marshalling, callbacks and variadic
-functions, is done entirely in userspace, and any toolchain can implement the
-interface.
+about any particular library or its calling convention. Producing the thunks
+for a real library is done entirely in userspace, and any toolchain can
+implement the interface.
 
 Loading the plugin is all that is required from QEMU's side:
 
@@ -1087,11 +1086,21 @@ Loading the plugin is all that is required from QEMU's side:
 
    qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
 
+If the default number does not suit the guest ABI, pick another one, and build
+the userspace side to issue the same one:
+
+.. code-block:: shell
+
+   qemu-x86_64 -plugin contrib/plugins/libdlcall.so,syscall_num=8192 \
+       <guest-program> ...
+
 `Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end userspace
 implementation of this: it provides the guest and host runtimes and an
 automated toolchain that generates the thunks from a library's headers, so guest
-library calls run on the host's native libraries. It supports an x86_64 guest
-running on an x86_64, aarch64 or riscv64 host.
+library calls run on the host's native libraries. How it handles the parts the
+plugin leaves out, including argument marshalling, callbacks and variadic
+functions, can serve as a reference. It supports an x86_64 guest running on an
+x86_64, aarch64 or riscv64 host.
 
 A minimal end-to-end example uses a one-function library, ``libhello.so``, built
 two ways: the guest build tags its output ``(from the guest)`` and the host
@@ -1201,8 +1210,10 @@ which prints::
   * - Option
     - Description
   * - syscall_num=N
-    - The magic syscall number the guest issues (default 4096). Must be high
-      enough not to clash with a real syscall.
+    - The magic syscall number the guest issues (default 4096). It must be a
+      number the guest ABI does not use for a real syscall, and does not
+      reject before the plugin sees it, which bounds the choice from both
+      sides.
 
 Other emulation features
 ------------------------
-- 
2.47.3


