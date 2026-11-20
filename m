Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3F606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jqP+gq66;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WuY/8dAj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSC7-0004Pt-BS; Fri, 20 Nov 2026 12:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBq-00046v-By
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBo-0003xb-PJ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:22 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKGFsvH3830173
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 USH/JKygShHw6X3ZYFQaznWFbfNOQiqRfMa4UtUGKOU=; b=jqP+gq664YQJTjO9
 RsW1aliazSXrslJ1K/p63BcfxxnkQbZ/HODDfm6bDWqkQgewCrJ6XnYGO5ScDMum
 uC6DS5zl9sz5y6fwOF/jDtiqKJ6fBRcDXWaXooukyQ1bBwvf5vtyrhaff+1shxV4
 vbX9YNg2g7zSOoBKRVO3VDtD2G8kBSJgAnyi0smSe37hEhFwnUN1Po1LutvLqyxB
 vt1Ur8ZUZNmyj4JGY/s7DNuvFWobOLoY1VuaC0HZmPp03Qsre+8MSsuybWbV9me2
 HEpJWOiweGk9EawU70gtzxUHuIVbVIxb792wsjCpz1DAAfg1VOrK6413h3yHSXM6
 J/p19Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2sjwg7ns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:14:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f3969a2a7so182061185a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194859; x=1795799659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=USH/JKygShHw6X3ZYFQaznWFbfNOQiqRfMa4UtUGKOU=;
 b=WuY/8dAjcfIeLT4hisIwiZy/b9LsYuIGov6CCLbJJ+8LyXEBgQPn0QTkMJC+NyxGgq
 dA7ATJ/XjopmtINTAVIVdc9kelxfvqe9YJasukZYenIxRvakxRf+PDkkvE3nIhLZwJqA
 So5/Hdp1Tjw9DwnC8a1/ZLqPYOLLWWxABX5tr2Xs0bcnzMk/iBP65DGA1O48yBusrOOT
 ncLpknyDhtIwCgmaOspqQSHJjo1n7+vUBLq2Q5l7/AafZ+Ahj5QfXAy7miFV3XUvZh8B
 9GhKj/KfHVM2g66W4Ij1ZyJrmJGIOvLYd0TfYHLWkMA7or0bPV4xP4bDZdQSNqZz2SZl
 E22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194859; x=1795799659;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=USH/JKygShHw6X3ZYFQaznWFbfNOQiqRfMa4UtUGKOU=;
 b=HFgRQii5vxj4JbLuT3+rIuOtKcjWFdSxSqNBfUk1rNHluU+bpO3GbnBZxFmfFvtH+B
 Zf8TYLP5Unch3DfZZSL+JaLZlTvV3aCjrz1Sqoh++dANXHQXz2dkH5ItC549iPRoLyjE
 9VFP71begHCxfkznRErCeEsiE14OrnpLOlVbVOFJyNUmcF9p9DwEQ1KeJphmpcoL78l8
 2TiK2W41/ilX2R5rEvhzgaSSHUBjdv2OqsF2p6i30IdPWbTAE+wbvasdcKRmNBMzKkkZ
 RK/uAtjSeNArqa2JfJK8T7wTpZaUFdD7dG5njUMWypqhmMmYUs/wqeTATCVZ/01nns1W
 2f0A==
X-Gm-Message-State: APuU4Z+UHPGL/061cOAv7xDY3nzZcOI5Mz/Kq8GnfKgcbJg8Ewa9Izea
 /A/+vzpkKHwh7eoz2DnYonXXrkAUhBoD9qdq6Uh6KyIdilCPWLH8obIHEni2/zLQgedqid5EY0x
 1eI9W0ypCTtnZb0TU/V/a8zxTVc+QM1gyY2hi+1xIkiAwvEU4Ww0hsTdKEXevPx9b4A==
X-Gm-Gg: AYBFou01CcMAiwCxRpanRU5RsxeqvTLQNCuKowL7oXQB3gXS0xutIIVVvc6TNzQqqbf
 o5+9Zqc4xfX9YoDxJwCvAXwMd94R5JuVms1kdTDZja/lHE5KKth+ZMnsKMNs+RvfVy5ee2GQsv9
 MJ0BW1VoZQ9zcDTmCvTjpycROZP61dLk3zqCd5tFvX0+mnCqS5GvWBotgpjCU3Zeknly44b8CR1
 +90wCKHpRY0rUPiRrNDLbf4xEqV+aXNSVeNadaod1LMjIuNNA/sdqIdv3pXImaGPA3RQJCVreFn
 xrLEINdm/xlp1wuqFN9FS9q1qAtpNxxyaEVrTOASc5/YOLSkLVrjNwbNzVUtZmXVI3mRspteEBI
 zH1M9dyKLQe3KRBqmgroCSUuhgG1X2q0+vg0g7UBYnCXwBGZfc95z/vizBXjT30qvTizbDZiPlB
 Jy6gzJPJL5C29mLQ==
X-Received: by 2002:a05:620a:4443:b0:949:6193:acc5 with SMTP id
 af79cd13be357-949bac79da8mr619368785a.74.1795194859015; 
 Fri, 20 Nov 2026 09:14:19 -0800 (PST)
X-Received: by 2002:a05:620a:4443:b0:949:6193:acc5 with SMTP id
 af79cd13be357-949bac79da8mr619364085a.74.1795194858438; 
 Fri, 20 Nov 2026 09:14:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm6190814f8f.20.2026.11.20.09.14.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:14:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 14/14] hw/scsi/ncr53c710: Bump the migration
 version
Date: Fri, 20 Nov 2026 18:12:34 +0100
Message-ID: <20261120171235.61325-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uuNhgpYaQsupsfof57p5n1lKhnk9zJ1-
X-Proofpoint-GUID: uuNhgpYaQsupsfof57p5n1lKhnk9zJ1-
X-Authority-Analysis: v=2.4 cv=dZ4VTnXe c=1 sm=1 tr=0 ts=6b007feb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=10KMK3kvz0OphFO8KX0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX1wlEitxpvBVQ
 Ff3hnMQ0kc9rG1HQ5XwiE3+ArKYd8qECPg07ExnW9W9XOdM6cjQhPQByGvoUPYjEmjcvpNEKMF2
 wz8/PjJtZpwuuASvVqAkJW+h0ZzF6tM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXwTgier3DT3TN
 SF2s8iMWixOqS08xCRoJG1OWPBDWZjT7Ocw4hbIxsd1dizrT8RgumK899w0tP9cYtecVWpC1sY5
 stNUrR30oVGZ2a7Y/kIOeM9qXblQKfMT2blDm5pY059EXPNUiPFLmbNMwrSKpgTIZJi8P2KGcQT
 A073I6QowZOe9Y0E/L6gq9/aswRoRwFgoUCdNs4GAJjS8xFUhISI4Hqt2nL1keXCJTECBrDaK5s
 kMmxu+vu+KgFsZE2xMGWC+q7JN2P4E35XJ9kvo0Dojsfjcr8unwbfrTm0ATQYEskjD7RPjjSn76
 3VBGUZfBzVRRBIpsFQy65QzWA1CurGEVd3BgoWZ4H13KsTPVTj2H/vkrZkH9zZY+SGv7uN+qkXz
 8sAzbghmJ2EEtj88Jfpk+OZB3MnT6d6F5qJ2EFzH2o7EFo5cgQw1CY6tNr9cngXxC14Yc1s+8jp
 D/DRtAHkYvRmECUKpDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The migration format is incompatible with the model this replaces, so
the ncr710 and lasi_ncr710 vmstate descriptions raise minimum_version_id
in lockstep: an old stream is rejected rather than silently misparsed.
sigp_pending_resume is a version 3 field: a deferred SIGP kick can be
live across a migration point.

Intermediate patches of this series do not preserve migration streams.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/lasi_ncr710.c |  4 ++--
 hw/scsi/ncr53c710.c   | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index c8a28cd987b8..62608d039c1e 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -163,8 +163,8 @@ static const MemoryRegionOps lasi_ncr710_mmio_ops = {
 
 static const VMStateDescription vmstate_lasi_ncr710 = {
     .name = "lasi-ncr710",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ncr710, LasiNCR710State, 1, vmstate_ncr710, NCR710State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index af26d26a05bb..4a37d011f229 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1674,8 +1674,9 @@ static int lsi_post_load(void *opaque, int version_id)
 
 const VMStateDescription vmstate_ncr710 = {
     .name = "ncr710",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    /* minimum_version_id rejects streams from the earlier 53C710 model. */
+    .version_id = 3,
+    .minimum_version_id = 2,
     .pre_save = lsi_pre_save,
     .post_load = lsi_post_load,
     .fields = (const VMStateField[]) {
@@ -1689,7 +1690,11 @@ const VMStateDescription vmstate_ncr710 = {
         VMSTATE_UINT32(select_tag, NCR710State),
         VMSTATE_INT32(command_complete, NCR710State),
         VMSTATE_BOOL(script_running, NCR710State),
-        VMSTATE_BOOL(sigp_pending_resume, NCR710State),
+        /*
+         * Version 3+.  A deferred SIGP kick can be live across a migration
+         * point.
+         */
+        VMSTATE_BOOL_V(sigp_pending_resume, NCR710State, 3),
 
         VMSTATE_UINT8(scntl0, NCR710State),
         VMSTATE_UINT8(scntl1, NCR710State),
-- 
2.55.0


