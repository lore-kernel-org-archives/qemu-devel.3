Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495B4C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24su-0007jE-Ke; Thu, 03 Sep 2026 06:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ss-0007Ub-Iy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sq-0006k1-Mh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKTZ055412
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N0jc/6hIRKAeFm/a8kLXzoMAX33cJ/awb0zvbJDkwIw=; b=dqk/5lKZO/x/8U0k
 8gwmCfwSAO8AfO4t9QahcfSj0OIHqu9b4N8cO28TUthMYr38rGw0K1Zk7Vmw4L1z
 tnVjzd0qn5xWbvv6coroofOY2Y8dsDBXvJn3hofAQEcXhj0ghUl7E2WvI5HXrTCW
 kaBMu5jZVFwpFdjKn95iVsYqAfqwYUrrk5ek5xEGHEFaCiK03SbJoGg6MrJ8dwsu
 /g4NsK4GvprnndD99ER22ykuL32ZO5fSlquG3npzvRtMXGNBsa7l8Yn774AENLAS
 +0Jpy+441FJcGnP1PZADNIb3VW8/5itxB2/FN54GQdW9eg8fVUobVj82tpEa7RPt
 XcldqA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgpp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939665a1ae6so414171185a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432087; x=1789036887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N0jc/6hIRKAeFm/a8kLXzoMAX33cJ/awb0zvbJDkwIw=;
 b=cYHPRgF5OhGgJ2yyDoiCOXK0w3WpOx69DIvo5hEff9ZBLdjsDiS4ovegU0ma+Zl85P
 zPQuP2zchEXo0bGsX5g6HnWypEcGeA/bhecZDM3QNXgOYkMgeSBRdzcZJsxMY4tv9Pby
 YH1h3sp2y/6C6nHVf32XK+GD6BZ+ZA12+ExiDMhRwhtPp1PxP9BmGzDWDbgx1dFjDICy
 rrWAuSiqourbXFOdnQimgFNTDDIyNnIH2XGaLtxl03EVGjM7ezLX04Tf3tqFoSa/LmHD
 yGeb1jVioZEOSspoiRSrhJ4OiVuhI3BdvT3/W2emWlqveEgl2Vu1WXFGYCPqedIS2GHe
 RmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432087; x=1789036887;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N0jc/6hIRKAeFm/a8kLXzoMAX33cJ/awb0zvbJDkwIw=;
 b=samXExgw4IaiSBd1LBcEUxqf3WMWqKrUPnHXhznuNQ/U2CCmD561gPsmhE/1uRSRMY
 ApQ6zLQtkxkSoqihI1ZGndzD2e6zJ5u69t1gbyoQ+yQ3+aTSh0oMW0YaqhQcOWJUroAE
 ubQ/ijCPJ8fC6TaEFhk2ZAzqW9vt7buGpcimDaaPI4r37pwkSsu46E9YzN/GiQnvRL7z
 Tx7IO+vIpPplIaxEpQF1r8YKOBpw9/DTa6bGNc+IDDdOGP7CKPUvu9L+kZ4+bhRtXFK3
 LEA6BqHiL73LhjZzdNZI3uL7G0MGXZB/FyWRNl2VGYTCWzxkIY5wKpN0GsrKOuxnZ8fM
 gqtw==
X-Gm-Message-State: AFuF++movN6eyeq5uJk8xmGJdhznQDSRANv8FGbPjYzMj1levgdTgilF
 1CHFNGlrOmH0Y4vks/WW+rqYjP06FceXIHtmLpYcDKhGw8D4IxEd2c3SdACKYCehsIIJ6ypXsYi
 SLlZttPDgRJmb0ez96dyZxwipKUz5PLjMGZ2yLc754kqvqmAnvM44J/rPd1G93fT2NA==
X-Gm-Gg: AYBFou02FSl9kolkcdJ5ff22F+e/SYMHjDpZFPO4nBB+NQfY61P8ZJ+Jq2oE0lURGC/
 4qN5R4QiRZUemAKfrJNI8rmIGYh3iB5zSujDJRQDIeDgrBWYLiwOJBQnPV3XiqdBPeXjnr+KiF/
 MWjTttvVi81Ql/xYMxCO30JpFmYQQKjpeaNJk5ZZTqa/DScg4EYAuRL3NoWjd7rlgF+dEA0DL0Q
 j4h53QVDeYaP76+6dzOgK+7m3SdZWPDV2arMMbDinUJSXkQETVb9mHbDIQeOlbmC6qtU6HPkZ5Y
 7Km+JhCwYjMqKNYqwQVE0zQ3HIg+48VjR/+imIlkAhejaxqVaeF1gHy3SpW9EqAgA90ardMkhql
 p1guupvPmq5Aq6vRF51/X58fSuajBKNhAFM2YRum2
X-Received: by 2002:a05:620a:3d16:b0:937:7836:14ff with SMTP id
 af79cd13be357-93960f780c9mr925640585a.33.1788432086845; 
 Thu, 03 Sep 2026 03:41:26 -0700 (PDT)
X-Received: by 2002:a05:620a:3d16:b0:937:7836:14ff with SMTP id
 af79cd13be357-93960f780c9mr925636585a.33.1788432086338; 
 Thu, 03 Sep 2026 03:41:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72b5bsm12773785f8f.4.2026.09.03.03.41.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/51] hw/block/pflash_cfi01: Always set romd mode when
 clearing wcycle and cmd
Date: Thu,  3 Sep 2026 12:38:59 +0200
Message-ID: <20260903103936.62355-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994ed7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fur-dfHGhdaOEbT7ATMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Jc8KTyQ8RSTBLLbKghPuRm6Kr0uKo7A_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX08TpUnTDThc3
 9TEtnHbbpKvnLusETA/UCdKmWnZrnP27w26XSf+FI1KHegbX+u51nM4s2agbwiWPhFlATsNIYPn
 3IxB1fgg01AcYOQE9HgC6ecoa/yezuZWvQ6v1xveKlNJIB3YXF5xZNS6NvluMdUVKFFfIBzaypu
 YLi41yCFOw7mrSktriOzy+MFC2RTv+xLw2fC9nBWHetwj2FcX6YqaBwOnTZnaKrdZ9E+ARusOQU
 6vtQAuCT6HOkHhaE3drfW4rr6eoEsTFtq+RIkW166fUqwH26TUNJS6WRK7jXHvdL7LGCVxqsy25
 Q5AXLGEFU0N6mSsxL9gX3454pS4IY6GKwLkVJxnufAddtlV4NTxuXVJYbDTilzaed4dbziOIzsT
 dILwltBLkhIxTswEnJ3sVGzxbIuWuZq+zY0MB20wx957ntXFHvrvc6uJA7xoF6eu0LaWz9uldCQ
 5SxkXzRz34jKhoq46cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxLYh8xCCfiVi
 ms/qxjqzDOjSN0mYckF6WNfcLMN2ho1hQIf/m/QdkJA1wdAFXQnNd1nAIB4Nc+Wk4mHA9ar/09e
 DgRZZr5YB708i3oF+ytmKHAiga4ZXGk=
X-Proofpoint-ORIG-GUID: Jc8KTyQ8RSTBLLbKghPuRm6Kr0uKo7A_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Peter Maydell <peter.maydell@linaro.org>

The pflash_cfi01 code has an invariant that the MemoryRegion is in
ROMD mode if and only if wcycle == 0 && cmd == 0.  We rely on this
for setting ROMD mode on an inbound migration.

There is one corner case where the code clears wcycle and cmd without
also setting ROMD mode on the MR: in the "should never happen" code
path in pflash_read().  As the comment notes, that code really is
unreachable (unless an inbound migration feeds us a bogus pfl->cmd
value), so this isn't a problem in practice.  But it does make the
code a little trickier to analyse.

Pull out a function which does the "clear wcycle and cmd and set mode
to ROMD", and use it in the three places that need to do this.  This
makes it clearer that we are preserving our invariant, and tidies up
the loose end noted in the commit message of 60d010f66f2ad7
("hw/block/pflash_cfi01: Restore ROMD mode after migration").

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260818115742.2268257-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a13b91967ed..486fc6350d8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -243,6 +243,18 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
     return resp;
 }
 
+static void pflash_set_to_read_array_mode(PFlashCFI01 *pfl)
+{
+    /*
+     * Reset the flash device to its "just read the data" mode.
+     * The command 0x00 is not assigned by the CFI open standard,
+     * but QEMU historically uses it for the READ_ARRAY command (0xff).
+     */
+    pfl->wcycle = 0;
+    pfl->cmd = 0x00;
+    memory_region_rom_device_set_romd(&pfl->mem, true);
+}
+
 static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
                                  int width, int be)
 {
@@ -270,12 +282,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
     default:
         /* This should never happen : reset state & treat it as a read */
         trace_pflash_read_unknown_state(pfl->name, pfl->cmd);
-        pfl->wcycle = 0;
-        /*
-         * The command 0x00 is not assigned by the CFI open standard,
-         * but QEMU historically uses it for the READ_ARRAY command (0xff).
-         */
-        pfl->cmd = 0x00;
+        pflash_set_to_read_array_mode(pfl);
         /* fall through to read code */
     case 0x00: /* This model reset value for READ_ARRAY (not CFI compliant) */
         /* Flash area read */
@@ -652,9 +659,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
 
  mode_read_array:
     trace_pflash_mode_read_array(pfl->name);
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle = 0;
-    pfl->cmd = 0x00; /* This model reset value for READ_ARRAY (not CFI) */
+    pflash_set_to_read_array_mode(pfl);
 }
 
 
@@ -873,13 +878,7 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
     PFlashCFI01 *pfl = PFLASH_CFI01(dev);
 
     trace_pflash_reset(pfl->name);
-    /*
-     * The command 0x00 is not assigned by the CFI open standard,
-     * but QEMU historically uses it for the READ_ARRAY command (0xff).
-     */
-    pfl->cmd = 0x00;
-    pfl->wcycle = 0;
-    memory_region_rom_device_set_romd(&pfl->mem, true);
+    pflash_set_to_read_array_mode(pfl);
     /*
      * The WSM ready timer occurs at most 150ns after system reset.
      * This model deliberately ignores this delay.
-- 
2.53.0


