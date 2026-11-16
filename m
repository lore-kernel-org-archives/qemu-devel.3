Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A5606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CmBOVwo4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RuAH3DE5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT65H-0007jg-0k; Mon, 16 Nov 2026 18:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65F-0007gX-9Y
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65D-0007WV-63
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:56 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNPs3R3075585
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cL9+k3XtzDMOko9zb71vfHlZhYVmkpLJk3Smbhb8zfw=; b=CmBOVwo4Zz+L1xyu
 TrB7Ea6Tsc9oAKwOzJ2BZz4mKi2wBrNdnBsQ4ZYWZDFX5xVzHzGO8Z+yRDOENKTh
 HZmot+7fLkBgTMaBFkIVa9mDTqcM6Ur65qeuOBRF4WYweXiaL05ct8vEDKiypkau
 tsL+dkgC0Cgq8QOOxgS2QuyMYiL+c40aOOR3L3gq1HB9WlIgz5S+R076+KpJVjq5
 7yJlUkMN/gbz7EjqiEZxKFJksUvQfK0FM1R3Y8yY6fJdtu94mU8yUX6K91Q+LXUt
 sQE/xS+dScy3akaeA7gCL+HfzmCP4PMAl8cvklcGa/Bw7qlh5JkPN0HsF4RzUS6A
 cD7gqg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k8f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc10da5ad4so706692137.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871553; x=1795476353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cL9+k3XtzDMOko9zb71vfHlZhYVmkpLJk3Smbhb8zfw=;
 b=RuAH3DE5uXYagcKHyGqGOJXrE0WeHtoIPd0/nDSTmEfjDdpK7M4HrQoQaCMOX5spAy
 kbjhy7W+V3w9z/0QTe2J9lBBuc8HSZp3ND1r9tebm8PH592QeJJ/PY9q0mwuUi1ig100
 FnvTaolw+a/wO65Pku9Bz/SpTX/TQfCgB8K2XRyJZn2bAQ1MYcqWnleQIK3BQNGM5EmJ
 ySL9vt+LYGn3AYXL/iv471wuU7BCLrxmRWPMy1bbbpV64Lgb+Gn5Nz+waHfHEgky7Ejr
 BGSwnV8WZ1QN23tAaP+qh04ArraJofDGDqjFbs9eY97KqOAPLitH6vTPwVSeVHQG31UT
 0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871553; x=1795476353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cL9+k3XtzDMOko9zb71vfHlZhYVmkpLJk3Smbhb8zfw=;
 b=t47NLpifvDTzhm373F23rmvTkqRvrHmPAr672h1qUfOkEvYMv+kanUApVzFkWUeazl
 Jatsb+cpnjj3G+8/Kcv7lIuIQ86YGAFe3jxMZkEVCznkis6N7fidK+tfrTznkGutOL6l
 cFbmm0Lzj5LWEGt4YuaFBxPI5FOmk2aDTjHPRG4f0J1a7fH6ekLYQtKoSHTNvB0roh3k
 L5ypgcR95lqwPd1iNMx6E07T/WxTgFp/1bTfFwol5xxlb/E6iPUb952x8cuzlJ8g+0cF
 oBquA9Y8OglYGHlcYVGkNjGhYXJQ2NGwD8K7yz3t6iRHC2aLIp/QVWKQriqtMnrlhrP1
 U9EQ==
X-Gm-Message-State: APuU4Z+JEIh2Z2aIcciWVp/+x2rmRM+VWKabJMdn7qB2Ythbvt6uzsH1
 v1OPLOqeDDjhipAlZLYCnxYvW+ed4IaZ49fj6428QAVYGtAD8vD7siWLPpqytyRxm926ynrKuC2
 iXC3an09HKMZtKi+ivUJ3FVZVIQqMJQ8BxkTVHNkhRxTH+b95dsHbGsgRNIp5lkNeMA==
X-Gm-Gg: AYBFou2CD6dzwKy+97WxkI9T59uwQCviwdaXroMW7IlYUYCtqVx8YNqO7QiW7gH9i9r
 MIHG1N8mV/XLXzwLcsYy4EGfr5lyQqIZlHmusGpBTgKgSAUOEJvmj9FwlsW9/MHWG5aCrHl/6DT
 yoBVhDkx0AvnxktQ+eshDJ32BKJziI7iWYqnLBKK72592ww9ILvLmeRkYUbIxa03Z1/39FsiV+8
 PlZqfjlWAowdH7gFLuNh7w1FaKul463bfze24/spgJyxENOi6q0iuRKKZP8ETVd9pU0qR+P7sIo
 2TVJvvV2XM3b2HJWBGB8X4AytSw5b+UbcKYHPC7QrD6TJNaTQl4sVwdkgbJg+XOkBb9RO8jFRAR
 ZAVXATCQXCiLy0YtvclLxVbeL+pwuoIcyL2BRSvKhGT6WV2oJvwTDVpOXDKOr2bj2WKDKtx08mo
 O+R4DnvgLyPUv5yw==
X-Received: by 2002:a05:6102:1484:b0:7d0:6db8:dc33 with SMTP id
 ada2fe7eead31-7d64d4738eemr4218224137.2.1794871552952; 
 Mon, 16 Nov 2026 15:25:52 -0800 (PST)
X-Received: by 2002:a05:6102:1484:b0:7d0:6db8:dc33 with SMTP id
 ada2fe7eead31-7d64d4738eemr4218201137.2.1794871550172; 
 Mon, 16 Nov 2026 15:25:50 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm84281395e9.3.2026.11.16.15.25.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/22] hw/usb/dev-mtp: Fix recursive delete of directories
Date: Tue, 17 Nov 2026 00:23:30 +0100
Message-ID: <20261116232335.31593-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb9102 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=V3ISmJJGlPdSwDKQ4g0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX6rQUtt7T3nXS
 0aDN703ZRYME4tMNpbL5Mi2nZBV13fBYrx7QTUUsRDSySrPxLxeV+EJNgCit9yEK8npX3VLwExl
 W7a/6UeMj+Iknd+03+HePjrmlQdE33M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX+r6gOacScna8
 Q6tFcyg+PzalGv99O/YUG3YihGWZw/KvzIxo81GVQaSPx1AAUdscvN36qTa7LBveUoxF0NUyjV9
 A+MEUqDd3dOQvs6PhBtmNwVYXJpCnOdokGLE+irmiOL3q/bZ0ynhNTpHw7mSt9YLPk+CR05veo3
 ceWw6xMhOiCyjYXILrzxpaL41RnkZdjm7xfqvbmG28kf0rzfTMjPrNLMmDbR/i9BAHCgyJVyDKi
 h0Q65e1MYsZkCES3PXwau16o/r9J2FgJ4TbvMoRSk5O5fdGNXNohDw9ktWysW68LbkZluCdSHLv
 MX3gQgiFt1rEy0pTtZoossa7R84MdWZ+b7t2Sh0GsxbbtvJg8TW43P0ZO6Cce6w00/pDp2FMIWB
 NkGplWNHi+m94zIdQvd3Y4SuWxI+ud7JmKBOfZaNwKkuQ4MHfpMqM6u7hfDBh0k6SUy65bAuQ4T
 OpIuMcsvOZTw0thy5ow==
X-Proofpoint-GUID: jLyhd4Z2vDjl4S_gpS-D53PNoKWXcjiO
X-Proofpoint-ORIG-GUID: jLyhd4Z2vDjl4S_gpS-D53PNoKWXcjiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tommaso Califano <tcalifano@redhat.com>

usb_mtp_deletefn() only recursed into the grandchildren of the target,
never deleting the files directly inside it. The directory was left
non-empty, so rmdir() on the host always failed, and objects nested more
than two levels deep were silently kept.

Recurse into every child of the target instead. Since the root directory
can now actually become empty, skip the root object itself: rmdir()'ing
it and freeing it would leave s->objects empty.

Cc: qemu-stable@nongnu.org
Fixes: ec6206a68f70 ("usb-mtp: Support delete of mtp objects")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261112174907.158825-2-tcalifano@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-mtp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 8507e516ab1e..bc5a6f089178 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1152,19 +1152,20 @@ enum {
 
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
-    MTPObject *iter, *iter2, *iter2_next;
+    MTPObject *iter, *iter_next;
     int ret = 0;
 
     /*
      * TODO: Add support for Protection Status
      */
 
-    QLIST_FOREACH(iter, &o->children, list) {
-        if (iter->format == FMT_ASSOCIATION) {
-            QLIST_FOREACH_SAFE(iter2, &iter->children, list, iter2_next) {
-                ret |= usb_mtp_deletefn(s, iter2, trans);
-            }
-        }
+    QLIST_FOREACH_SAFE(iter, &o->children, list, iter_next) {
+        ret |= usb_mtp_deletefn(s, iter, trans);
+    }
+
+    /* Avoid deleting the mtp root */
+    if (o->parent == NULL) {
+        return ret ? ret : DELETE_SUCCESS;
     }
 
     if (o->format == FMT_UNDEFINED_OBJECT) {
-- 
2.55.0


