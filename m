Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA21CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTH-0008H0-1m; Fri, 16 Oct 2026 14:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS2-00079t-Aw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS0-0000YB-N9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5ji51910963
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JHsIfNJ70Nn
 Zremj5UT8PMXbr6sJrxW9Tt6K3NlpEOU=; b=A+gY04n+xx+YCo+Qt3JX6fiJTk1
 30LiDCuhzmTXuLjioHd/8T11EwAZCWcNgHZE3tI70WVRB/L9asrrqbmoLxlgACeo
 JNuC0nSo0PUlonv1vZe6nM35BVJDi0Psk7rTGbGIMd1Chu+lyzZP42eRUa3MpBXa
 kviP+wXjO4uFIazPw/TrNMEjOdPWPE7obvi/bVNDQCOtcUSgEjD6FRxZxOAQRDeQ
 LsuaEVHs2UR3muCo9lTcxsmQb+/wIc13Wk1OfXXRnItw4uaoREZlD/9+aRGRpHNx
 UT3t8Ei/+8u09fvrJDsatTfTfPE63Ev5Z90ke7ldv4+xcukMMjHiXe5PiXQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf9mx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so245867a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174479; x=1792779279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JHsIfNJ70NnZremj5UT8PMXbr6sJrxW9Tt6K3NlpEOU=;
 b=AMRymsxzUfPTaj3nbhuceiZ6nT+jmNsKyR/JSw51RBrdW09baZvt65TJFqwG/0loNx
 Nh/HtpFutS3GL2IYT2YBoi99zmBgYO2ofEyqHzQzS3aQh6UBFi3RyN/sohgGQq7aZvKw
 zmqtLWZw7L3XXIDui2iMOMhQedwZu2pnNNsEckCvcaw92jBKzyXc/cnp0fAaGlh//L0y
 HBmpI+OTBEYxuxRdxsqVdfLN/Bz7LsmW1U4JVUBYCkhDiE3Xt32CJ77T2ErqfM/s0FEM
 Pj74P6OW6znFWQHOVtS1LSoj6BBjRgesNxM2wZ2h3hvLEPmMSWiWL8A4ZyZkbrrG5WOw
 Vqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174479; x=1792779279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JHsIfNJ70NnZremj5UT8PMXbr6sJrxW9Tt6K3NlpEOU=;
 b=yMiMfoOaFD14lbftw9MVOr7ZBhgTI0IxtVEjhyMrBum1kQANJCMD8027o8slFvshUg
 G+qAfz6dRvnZ/y1vmdRpn8PI+MwphFgBjvc++2vu6ZnCkk11NY0zR7mpeaOZuMmoQBAq
 XfvI1ZQZbdKz7im3xPEXLnUJGXZHlhbgCXjI5W7cwSWjW5zSj4sViBwrQp36B2C5nPmw
 L2PIJUjshH1UiPw3Mcs5Z+jHKbGuLwQiLRQchOOBFRYCjJrb46kKIhVw3ZiZqxpoQq/V
 mlDhLwEmSSdKNT84fY4tb7401OSDl6/PtaMeiUx3YOHfveUNFDXZUwQiMt1SYMnlIBqn
 tnyw==
X-Gm-Message-State: AFq9FYK2u5dPwfInsXyNuVCjGnbS8JbWw4Hw+5tKTUvnKCcx8AtC7aMR
 tjiP2VDB7k6Yb91Xl8c6cKTOqfJfjRZWZ60vXoNHExsDAMmNiVNxqP3tqDSkiMmNReC0II9qNFQ
 cJQMoykoPjsuhcr8oJZTHMnV5uB/W8oHyo8wI514Ia7zZYtk8lImD5HQbzpJ16oQPKQ==
X-Gm-Gg: AYBFou17hS7/rE79xrIMwe66eDFiM/E51MOrwy9PHsWRNNky2Idr5POm0julZk9+2VS
 Bv3rAqKwCSlkACLcPlXvRk+Xq0rOpxCpAtWwxkT3xh+OkaM44BvGwscF7SMb4wQZhC3PtFDjfr9
 sES2NuU0EZIJGoXXkS7rOklnTfwlV1ptHNu2zYtG97/T4kS7g7G5O32C4ZfRsjkrJmsnr6qzUy5
 qg9uTWj3Q6Aa4F/V9ZQpeAWBcW5lcmpB7mhShxkMdJ5C5WgZ6FV22kAtZkQWdjXgYI80mHOsJgC
 eLGdXn9v3zvayWC97t+O+q7F1qxuGNEcWs973uBwurk9n5u7Vdeu59j8PbYH4Z7O5RoDgNuk0mk
 xIApwEDZi5yOt5JAmAGKM8JAWBwfCTYKQlzEgxMvQi8KJItkTzcNNYK3aI1hziFc=
X-Received: by 2002:a17:90b:3d4d:b0:3a8:5cab:1009 with SMTP id
 98e67ed59e1d1-3aceefb0da8mr510721a91.46.1792174478544; 
 Fri, 16 Oct 2026 11:14:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4d:b0:3a8:5cab:1009 with SMTP id
 98e67ed59e1d1-3aceefb0da8mr510693a91.46.1792174478022; 
 Fri, 16 Oct 2026 11:14:38 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 15/23] hw/core/sysemu-cpu-ops: add get_note_size
Date: Fri, 16 Oct 2026 11:14:02 -0700
Message-ID: <20261016181410.191743-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A70rg0aqAPjzA56x_8L8LkjbV-Pf0elC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXx51lDFrxmhxh
 CtDX4tBlx8xXOy5K9UV7JYgkkaelwNXcj7CG6x6j6DmGVxk9Ir+uSq9xX3qshDrd7D/cKowh/AK
 KDZvo/TYc72ronYE11frI1KP/Wa6cRg=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad2698f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=s0xbLSvG6KTaNPbiVawA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: A70rg0aqAPjzA56x_8L8LkjbV-Pf0elC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX0BPUHasVlcwK
 yR8M47ykNSS03tNVGOfRsdPl3oCKoiKeAsnlP5nS7J1k3caAmXl0Rqk+FD19M7+eNeAAhJxyiUX
 Oqufn+d/C4aliiM++kY/uC8cVnIa2jgB/4PMN8VoYLCXDHauCi7k+j7nhpOsERMAXzxxvevCcOw
 EpwdThxuiyXqxTd6uR5gJXlKAAvrh5AKTQyKYvvpGVTLfZwk0ctd5KR6TORhAFi0drAcauHf+O4
 ljITbDnFkXVAqQA21ndnP5tEl+jX99WGJ5NMIXiNkBpw2XZdx1iy314XE1xU8ZOrXDUG1ouQWr2
 f/F76YKKK5hVVwK7zWW07k4splkJjcuP6acuBcuwsLHF2VqHCsjSp1bKJE/J1SYbqJidoSXoYA8
 pzyUrtg2wZznBQSairHSOpyi4hHIrp4NGxf4sAk9i+gPd6cvAuQDMAMrxNuqyHdq3Xv3Pk4cTSR
 5QdYSeb9nzqkklDZBUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This allows a specific cpu to report the size of the ELF notes it needs
to dump its state, alongside get_dump_info.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 2c7d0b94767..1ad482f9685 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -100,6 +100,13 @@ typedef struct SysemuCPUOps {
      */
     int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
                          const GuestPhysBlockList *guest_phys_blocks);
+    /**
+     * @get_note_size: returns the size of the ELF notes needed to dump
+     * @nr_cpus cpus, for the ELF @class and @machine reported by
+     * @get_dump_info. Must be set if @get_dump_info is set.
+     */
+    ssize_t (*get_note_size)(const CPUState *cpu, int class, int machine,
+                             int nr_cpus);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.47.3


