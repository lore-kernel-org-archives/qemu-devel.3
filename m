Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52F606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pxugjxJ+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GPpwIFQ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSBn-0003zV-VQ; Fri, 20 Nov 2026 12:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBG-0003MU-S9
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBF-0003uM-7W
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:46 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfIG12040039
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W3D2SEpfTFFAxEC6P7Dd3RXFNqOszp22BZTmv4IHdtA=; b=pxugjxJ+jpnj6EIJ
 Ss2QfVqDknZ7U4CMKAuYEuB2evMhWs14aqmSR/Pt0UJnBBtvmB1O6vd9TixC9Mw6
 RXwug0jAq2NUfpgpz3Kq287AkTrlkoMp8B3tGiD31LwNi2Kqzq0JcinkQxs0lqdQ
 Fw33BWmB8+mKRzTqz5IS2/0p3854vhegd2+boMRjws5rnAFmGTUqg4spRoMzYFgf
 2Z9ijCWzd/psq7SY9AhyJ/bsyyzgs4dj6LyaUmQRMtZLRlJdd/aj2eBUgw7KZ5wU
 25aCuhWUrhS8FUZKfGCu+ZfI73kVpSOZWKO96bPI/XOQAMfupoYnRliSCOYYWw2y
 t3cICg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjttxx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-946038e22f5so249135685a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194823; x=1795799623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W3D2SEpfTFFAxEC6P7Dd3RXFNqOszp22BZTmv4IHdtA=;
 b=GPpwIFQ6fWYerhhNmn1jCtjMSOASMgmgUi40LorATMPTuPL3zCpDWfieFnkuo2t64K
 YBxwpYJpuJ7nA1cf0jQXTTb/FUzRRzLiaYh8KWB0ceWOpFf0olk6+aORF5oMypEK1ljT
 D0mBShKAVRF3FLJouIg5XN9ij0gF4zOSiPRoIRor9rcLB8SKHp9KGfSOKaKiGvh5fXfW
 ZTmA0hfacT9Ug3JXynqRy2Ys0SnCxlCp61h0UMWfKuqibCYKURlgPf57CoZogiqYN3f6
 KV2bRExoaNaDzAOaLfbWrp7r6RQ2HQCawtPFzlFF06u6PwZn8T6H3PveMZ9Ppk7lIwNg
 QmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194823; x=1795799623;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W3D2SEpfTFFAxEC6P7Dd3RXFNqOszp22BZTmv4IHdtA=;
 b=EY9kR9RIBrGq8ys+q/7XWoIDvlNqOA1yyDDP1dKpfPaoSIh0ixL6yT5y2Ooub2XV6n
 21x4CSuMavJXpjFICKqKTFo+nnk72QqhRkVg1qgQpNVAHIJBhAVcvOzS8s3EIPFSvUyB
 yaZk2E2P4Kt7M02mxf0BEK/4FjHT+osGzDQUz8uat1qZdSk4jaKk/cLjRvt1W6l8dIux
 zl875MyUtMa3OaIg/CxcO98axhiOIlV+pcl1Mp/S1YxskcmkB2q06idvFkfunukE29dK
 p0HXNxRE0Az/dMX0jXpOHcFRJJqdG2pvbglpg9treNP39rExRaGcdpGEpcEQDqsP7eIF
 +kZA==
X-Gm-Message-State: APuU4Z+P3r+9yxygFMdRYVAp9GFqQ2BoWNtjj2MfnTcrRiooOSkgDKGQ
 PGMlb7QUzT5RdWv7ixx7KsjQz0L+NPsAL+R3IlqrnBQyQ+5+j3/D5B4zwQFvUng5ErXyivTG8D4
 QlO/B5NAwlMqWWZStjETWnyCdn9O4hxp8EthVR3cmVwIoTdVdudwfTcqG2Y2QyvDOBw==
X-Gm-Gg: AYBFou0rw8aJuY39pyOyc2tbCCLWUu1Yzhw/AzeAJxMx9a13yup3uKxcLqgBYGcmJuE
 vZOJR2hDElZZg2fNbRTQC8iyfklzIr64/99atnpGsn8qDDY+SQvOM9KgkJyg4jL5seQcwSIXwl5
 46/AaVCdw2PB+YifOqHmubel6LSrqEe6dp5NIWs8QDk+xfwvTKZap4ZNV9d0/ZVVT361WQN2VRf
 2vT9XgeFeOJ6doAtcrFkibugr8k6OG24mbiqzD66McQWHwmb00uLtJM8ox4X0ftXT2W0JNwhmeW
 HiGcEEVVL0AxH1AVBJ2x1L1upLE4CwfSBDeNmLomCZzeoKl8RCRWx4gROrRcDKdHcbogMAls2zV
 jIz5vjzWzVrtegm8BkFFj8YgOITiChvGHX/8OkdcIpfgCRLCzrbwlC0jvJeDCekPGfgMiRfrP3/
 rAmIUn1lJW+du7Ng==
X-Received: by 2002:a05:620a:8804:b0:947:b201:fafc with SMTP id
 af79cd13be357-949baa043b6mr542704785a.39.1795194823077; 
 Fri, 20 Nov 2026 09:13:43 -0800 (PST)
X-Received: by 2002:a05:620a:8804:b0:947:b201:fafc with SMTP id
 af79cd13be357-949baa043b6mr542700185a.39.1795194822542; 
 Fri, 20 Nov 2026 09:13:42 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm6042565f8f.23.2026.11.20.09.13.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 09/14] hw/scsi/ncr53c710: Drain asynchronous
 transfers in the register write
Date: Fri, 20 Nov 2026 18:12:29 +0100
Message-ID: <20261120171235.61325-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gnh0TnHPcYnR5RuEVEdaP8KgdeEbgczG
X-Proofpoint-GUID: gnh0TnHPcYnR5RuEVEdaP8KgdeEbgczG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX3E08zJ1Mtet6
 Sc0r1vd3oLHnMtPEay8zQ19laCQ7BEMWzPP8PdEiCxffYsU30PvIgM1PpbLwggXp9d52I3Ocsyw
 tSXlGGDb5inPuLoWAen/a9N0GuGIAVR3v9s+0/H6vlI1oReBY4hlvzgPlWdIaaq7z24HuE33/9N
 PONMdvUEuqFNDmmghnVWnMrEKCuWXFUW7TH0p4usG79K9jiMD3OALtdxyx7CMJbqzHUtgtrBAIp
 1C3sx+hlUK7v5YhvhvLVp7UsakOOnWkzlC2wihkyFclh+2XGSADKLUXYCkKl79TTb007cJzi/ns
 b/JGdAJq4eQ09GIroPiXadC8uMVNFI5Ei8EvdTjKd4Wp43kuYqEu5XgRVeqq/wsfYiPMqTEwsBe
 fpkNmTbEyFCcft3j+h0WqTkZcyGIuNE7CxTntu9/14xZ0FsVcsFxJ47Oz4pTpI81CUab35bfUly
 +NY4f8DbHAvnKGat2vg==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b007fc7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=Ld5TIVOHH0keToIO5T0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX1It+8DDi3uv4
 1eCxJ/uILjzTv6QA+YzqsIzLZ5NneZjQnirQwCxa+YCnNLwUoCao2+E7S3+Tpxh7iVoY2eJ/dMy
 YvWXq26mDQb8M6A3n19DUizSQbqXkSQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
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

The c720 driver of HP-UX 10.20 needs the completion interrupt ordering
hardware provides, starting a command with interrupts masked and then
spinning.  So after a register write starts an asynchronous transfer
the model drives it to completion before returning to the guest (a
bounded synchronous drain under the BQL, as IDE and MegaSAS do, falling
back to asynchronous completion if it cannot advance).

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.c  | 29 +++++++++++++++++++++++++++++
 hw/scsi/trace-events |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index b9ebeb4d96dc..9ca025ff6334 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -53,6 +53,12 @@
 
 #define LSI_BUF_SIZE     4096
 
+/*
+ * Safety bound on the synchronous completion drain loop in ncr710_reg_write();
+ * it then falls back to asynchronous completion.
+ */
+#define LSI_DRAIN_MAX_ITERS  100000
+
 static const char *const lsi_reg_names[64] = {
     "SCNTL0", "SCNTL1", "SDID", "SIEN", "SCID", "SXFER", "SODL", "SOCL",
     "SFBR", "SIDL", "SBDL", "SBCL", "DSTAT", "SSTAT0", "SSTAT1", "SSTAT2",
@@ -1552,7 +1558,30 @@ uint64_t ncr710_reg_read(NCR710State *s, hwaddr addr, unsigned size)
 
 void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
 {
+    unsigned drained = 0;
+
     lsi_reg_writeb(s, addr & 0xff, val & 0xff);
+
+    /*
+     * Drive any asynchronous SCSI transfer the register write kicked off to
+     * completion before returning to the guest, so its completion interrupt is
+     * raised first.  A deferred continue (lsi_issue_bh) has not issued its
+     * backing I/O yet, so pump it inline; otherwise blk_drain the backend.
+     */
+    while (s->waiting == LSI_DMA_IN_PROGRESS && s->current != NULL &&
+           s->current->req != NULL) {
+        if (drained++ >= LSI_DRAIN_MAX_ITERS) {
+            trace_ncr710_drain_exhausted(drained);
+            break;
+        }
+        if (s->issue_pending) {
+            lsi_issue_bh(s);
+        } else if (s->current->req->dev->conf.blk != NULL) {
+            blk_drain(s->current->req->dev->conf.blk);
+        } else {
+            break;      /* nothing deferred and no backend to drain */
+        }
+    }
 }
 
 static int lsi_pre_save(void *opaque)
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index f0eb1457022e..843d8f1a1e27 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -340,6 +340,7 @@ ncr710_memmove(uint32_t dest, uint32_t src, int count) "MOVE MEMORY dest=0x%08x
 ncr710_do_dma_unavailable(void) "DMA: data not yet available"
 ncr710_wait_disconnect(void) "Wait Disconnect"
 ncr710_illegal_insn(uint32_t insn) "ILLEGAL instruction 0x%08x"
+ncr710_drain_exhausted(unsigned iters) "synchronous completion drain gave up after %u iters"
 
 # lasi_ncr710.c
 lasi_ncr710_device_realize(void) "Device realized"
-- 
2.55.0


