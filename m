Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52960A2602
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pa5Ejf/e;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JQHe9Byo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSAO-0002se-8E; Fri, 20 Nov 2026 12:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAH-0002or-5b
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:12:47 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAF-0002RZ-Cm
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:12:44 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfGpo2039943
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Kih0Z0lG8GKA0mcMhfbeCw
 RJ9JDoHxLn+005nffqU4w=; b=pa5Ejf/eJD+LT6AXE7B7Klt//V5ImXb0q8Y6iA
 NTSyDzrYSXB/ZR2vQW23Z6rt82zW8Xb3JQ3hTILrzt4uq4NTefzfURtqMvGPotLm
 JRooDv4DYiKvY4NIrcNsSpz2LMGyOAUAGjiDF/8AFUlXrJiAsRfCOU9K5Sks2EMd
 1V8uZhRERF4oJF06oF+ygJik5v7koBKxZyYftxvJiSGEzz35OnTFLl1IjwVzzj5T
 Mv+vCXTCMT2kdPLygP1VTRl++mj8TdvXbiUlWbHJP48VAsLy6SMYD3YXLkhZZcGJ
 bfYzcJ85nAz4htoFZefBX2vI61JFS+TGkznPC310ahUAjA5A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjttxt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:12:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so1019479e0c.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194759; x=1795799559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kih0Z0lG8GKA0mcMhfbeCwRJ9JDoHxLn+005nffqU4w=;
 b=JQHe9Byogkw5/+4WDH0gFKz9BzRrOBCv844BFBNLAl2Rb43+ebY2zPp7KCJPGiOqpa
 HovObsMwekGdXcyQytMG0gsWMsW/ksMwZ9O8ZG/oOVH4yhkTBH/5vRq3MhihA/Zfv76S
 72HVtdErC+NGNurqx66chJm1B19QY+RX9mQoF4AIMtreRnRWMd45FKxNRZl2QBxf0yT9
 RQ6XJQpzrJ312cudMm+WV21DYFy19x4vk9LcSZMdQuJwGgQT4Cb7AnuBoSDgqsi1Ji/M
 KWvqSoZztEHfg0qqchkn07q3UOf4MqQcDzOwaWM/WjrBcrNN2m5Q9f7EbNet+thzhPmA
 iQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194759; x=1795799559;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kih0Z0lG8GKA0mcMhfbeCwRJ9JDoHxLn+005nffqU4w=;
 b=tdyo6V2LNLwFsTg/8odpbvKbWVj1/o/gs2Ew+MPNioSZo0EzqHpdo2IFXAQ9ZT36sD
 N+hV+S6zwohjznQ1k0NCy5OpfTWi08PwXSglewbtNv/jSqRoymUvbGNeS7+Ec3liIhjs
 7bLmZxXEqRXUINCtKzGFeAbw6MM918oMcMUXcz+LWRpNE4i24jyWzgGL1I5DtSUeGwqt
 cSq0Utm3b3S+mWcsS5eq5LDI1LyXZ0L5aPT6oijbtyRScQSfI0XE16vEVA3VG8gcuBGO
 YdmmwhKxyo5q/NffjECIHYW6xQot8Avkh0Mj3S4O4wvIARhJzwHz9X4h45i7z5ZtWosS
 U1rw==
X-Gm-Message-State: APuU4Z/RRBCS7YnEJMJml+GTGZOLiJ1UeJ4mC6yp2n+nDpYOsYLNHJ/r
 m2DHFVvS5ZhumoXVjS5mNAmV5mG1XzMYA8ajLsK5wHWL7MqRORnTR1x+uWF3DNcd1nYLplGBLar
 Q971TR2OfE0TChHfDDBVmN7qZ1LhVOhQ6tOBWUvYUrXu4IGDz5e2Z4WEvuG2tXQ8K3Q==
X-Gm-Gg: AZFdTZcI3cKJ68X7U43QmsdYcBRnKiaNL8DhdgBIHxZ0JaZYb3qHqsY32QajWQuV3dP
 VDkKuoh9cBW4XiL/RmYRbzhGNW/hEJFaojEHYQ115UTDGA7JvtpkhI1Y8A8NeFJqGm+PcXo4D8y
 UZ9dLFLbJoZlj8VPAzv/4LVwA/2rR8KXqfCPYbTKD2IjWv8AWOn6EmRi3/SVZUPjBfYtAK9u7zc
 HD+XNunxQz9XKjOrguRBTKf0Zqnh+K+n74kgqiqKm0HsnYTzjXs2wB/znBPGT33JeY/yKGtqTxB
 s/GTtvTVBpRiRZgNOOoM+pJvHuXxGRChn6i8geEzLjbPZyYx+zyhUkEaUd4kClvkHgPnw0V9t76
 H0XWLaqeRCNui13MA0IBy8h+Jissc6FTMyl0CByLHyX2//qEmCtaatxiAkK5Q6xsAeU1Kdhx7SR
 J6iaypEU3DNqC0Zw==
X-Received: by 2002:a05:6122:1d0c:b0:5ea:b991:d489 with SMTP id
 71dfb90a1353d-5ee8aed6f75mr2260430e0c.13.1795194758697; 
 Fri, 20 Nov 2026 09:12:38 -0800 (PST)
X-Received: by 2002:a05:6122:1d0c:b0:5ea:b991:d489 with SMTP id
 71dfb90a1353d-5ee8aed6f75mr2260402e0c.13.1795194758203; 
 Fri, 20 Nov 2026 09:12:38 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm90273865e9.10.2026.11.20.09.12.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:12:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2 v4 00/14] nc53c710 rewrite
Date: Fri, 20 Nov 2026 18:12:20 +0100
Message-ID: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ENFhgQgFYR0a8DHvOHTALSlC8T-D39dQ
X-Proofpoint-GUID: ENFhgQgFYR0a8DHvOHTALSlC8T-D39dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX1GLW3/JddCcG
 nghNuMswNukhfXSJKT0AIhqSgX6gZTCAVqUj1Pr8h8vANHhb/JXG+oZp2nhLlJ5SlCdfMZkjYt7
 g3qN2XbQ0tBulcI0ILZEReyBu63IHTbDUIVzW5KdLdTGD9l2VFi6neez69AkNan/SZ02KFjK9H7
 RWn5Nn/JDHKCCeu7zMiDRRsxsfX6/xIl39vO6V6EVVWHjfNMkqAuotzk4yd2XAPjGzY+eHN24M9
 hrPzVaDPDViwaU3o0vMs3c8/GXGrLIFBzjSxh3YrLa6O3CEvCIPLKwK/0KI26wr3PWHWtrIR5Og
 PZJhyzQwbxr4o7dikV2F13NMOFBlGmwdqVMXvd5TzKQau6G0CEc/LgOBdZleZIoqJ1QijjSl6Kq
 XSSa62Asd2S4S9xPTwMcIoELxilEEBjKwD5VGlpQ7JXnlPCs306e9NGsAKiEDC+7LZ3TTqPg5i7
 VrV+uqh9Ggs3tqHti+w==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b007f87 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=esfwdczC1VlDm5BGEHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX8150hlTWvXwt
 YUKrt2a0cXPLWFaOPYeXyxRkQ9UsdZFJ++X1VCfH0A0JdcYi5GRv8tzxWLJSbYTWh2pDzgkXmBn
 EErw6YHcbL0tMetTv5ijEUF7xP2zq6s=
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fourth attempt to replace the existing 53c710 driver by
a new driver based on the code of the lsi53c895a.c :)

Used LLM to decompose v3 as logical / atomic changes when
possible (didn't work well with the rewrite patch).

Fixes extracted first so could be merged for v11.2 (patches
1 to 5). The rest is the rewrite, so up to the maintainers
(Helge, Mark) and is probably OK as hobbyist-only code.

Since v3:
- header split, Suggested-by tag (Zoltan)
- I couldn't figure the "hw/misc/lasi.c" change so dropped
  the comment about it.
- Dropped "move to COMMAND on CLEAR ACK after MESSAGE REJECT"
- Split rewrite patch as separated commits:
   - base engine
   - asynchronous completions
   - synchronous drain
   - HP-UX MESSAGE REJECT quirk
   - reentrancy guard and reset-time request cancel

hw/scsi/ncr53c710.c is derived from hw/scsi/lsi53c895a.c which
is LGPL, the rewrite is now declared GPL-2.0-or-later.
hw/scsi/lsi_scsi.h, which is moved verbatim from lsi53c895a.c,
keeps the original terms: its header says "This code is licensed
under the LGPL." with SPDX-License-Identifier: LGPL-2.1-or-later.

Series reviewed against the NCR 53C710 data manual but totally
untested (I don't have guest code to run), thus compile-checked
only. I haven't tested whether the series is bisectable.

Keith Monahan (9):
  hw/scsi/scsi-disk: Add quirk_mode_page_no_flexible_disk, use it on the
    715
  hw/scsi: Move shared LSI/NCR definitions to lsi_scsi.h
  hw/scsi/ncr53c710: Rewrite the 53C710 SCRIPTS engine
  hw/scsi/ncr53c710: Deliver completions from bottom halves
  hw/scsi/ncr53c710: Drain asynchronous transfers in the register write
  hw/scsi/ncr53c710: Append SAVE DATA POINTERS after MESSAGE REJECT for
    HP-UX
  hw/scsi/ncr53c710: Guard SCRIPTS reentrancy and cancel requests on
    soft reset
  hw/scsi/lasi_ncr710: Map the full LASI SCSI module page
  hw/scsi/ncr53c710: Bump the migration version

Philippe Mathieu-Daudé (5):
  hw/scsi/ncr53c710: Cancel the in-flight request on soft reset
  hw/scsi/ncr53c710: Do not load SBCL from DBC after a SCRIPTS phase
    move
  hw/scsi/lasi_ncr710: Limit max_target and max_lun to 7
  hw/scsi/ncr53c710: Keep DCNTL.EA and DMODE.FC1 across an ISTAT.RST
    reset
  hw/scsi/ncr53c710: Document the SIGP latch deviation

 MAINTAINERS            |    1 +
 hw/scsi/lasi_ncr710.h  |   28 +-
 hw/scsi/lsi_scsi.h     |  104 ++
 hw/scsi/ncr53c710.h    |  279 ++--
 include/hw/scsi/scsi.h |    1 +
 hw/hppa/machine.c      |   10 +
 hw/scsi/lasi_ncr710.c  |  135 +-
 hw/scsi/lsi53c895a.c   |   79 +-
 hw/scsi/ncr53c710.c    | 2981 +++++++++++++++-------------------------
 hw/scsi/scsi-disk.c    |   13 +
 hw/scsi/trace-events   |   43 +-
 11 files changed, 1451 insertions(+), 2223 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

-- 
2.55.0


