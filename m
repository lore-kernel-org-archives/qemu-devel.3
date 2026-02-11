Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205DFECD6F7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqIZA-0005MI-FY; Wed, 11 Feb 2026 17:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ4-0005K4-9D
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ2-0004vO-6o
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:06 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61BEVBKP1507195
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=t8JlQGBXQryJS+pcvQFfN2
 X58AzUx6DXi3B5SLYmCHw=; b=Y1tnh6atIwp7e+nU8T7/zDh1DqqKOKhKJjvuU3
 LrbwTVqeSesh4rDhBcJMlzn+Pc76Kv6VNOjxfbRkGlWNOiSx/5jOYz0d2P0rSM/1
 mybj3YMOnY/hqcfmFODT/h+Byb7jdIiOa6K4kymyif7GEI8fzAODKvcsg7ZvpqeA
 DMGPlELwG4GT3QzplXcbbZWugvfBtZMnOOiqR8MXI3XrtZW1HBiXzZZyEO1e3f+m
 Wk6qYzu9dillTMMIOLhZc+S9qSEmTHmu8n0J67qxP1eVglXVdZ9kaOH8WgaKR+0G
 l8AlMc9UqxfO2JTGNqUl5+JtV7TLepw5ZWMZmpo71K5i/hmg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8ukt1gh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba66faa692so3857161eec.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 14:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770848399; x=1771453199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t8JlQGBXQryJS+pcvQFfN2X58AzUx6DXi3B5SLYmCHw=;
 b=dbN2vWPR/VDSJ+LfCi/nrIfGpwSKNP0OxGBv3zwany0O+VtHOqjm4VmcBJeDlUyUgE
 CUV9B/uWTIY3gltS6xS/c2gDZOOwV9iavVaMfrng8BfYKzODnwgVWgZsG7Ev4fS3zAbn
 bOmEp5PReAPmowMbYD1TZfcZeRhSznxnQdgK16ILFBuaVafu/5V/6bceUw4aXdXX1tEq
 T2BzJppMgwYKD6Eeqts0GEkbNSfICQz2kHc0uM2y0mq88XgmUyAKPHCwnJyjFRVSB/du
 Zttahp6qpGpUzeUtsatciSQ/NGI8FFwimcs7+Xa5eOR93k6E7KnfszFZB3mvRwZ1rs3C
 FhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848399; x=1771453199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8JlQGBXQryJS+pcvQFfN2X58AzUx6DXi3B5SLYmCHw=;
 b=DY5fGLRD2IAHP6titW18b4PHETvAYRT6YA1KwfX+xEVdBFHshEHb8IKQn6uDcTte1j
 LVHzKq8ZiE6pw8aLZd8bcU6uwtIcGrAnjkpp55RyWtmhQGGbHxrG3GUtiL8RiJmyJOET
 hQPPh4m/w8HVY6mCh91hzLausCrw4YJww0RCnxGl+jYF+knJl5JQNxkKALocus7FDYPC
 AEMd/d/Jv5duIz5YjCfsrsHZpGtgLgd93sPeb3PmD3YQzhtE9+7QHoRDUaXi6DjakEql
 R5Oi18b1bes8VdE1njL8jNpGTITtkpuxFNyhGY7MFCw/V6OBPqhR7jllx1tL+KwG+3nf
 l+eQ==
X-Gm-Message-State: AOJu0YxrXbnqOFjoACwDCNTkzJh8ylEjUJFxUut/ghmejonSiUDT6Hza
 O3EK5Glh+M2uvrQYs2Lp3dBN7mWH/WnDfAyts6fEXoTRT4nkvLZ1bLm+48N5xgFsR7JYLGKoXw2
 Fj2JRO2lrxJ6sn96IS+io0eufP/FH99kFuXIsfL12KeJioHyVJZlV6i9fT2aQxPkU7g==
X-Gm-Gg: AZuq6aKkyc5VbPbAeVFMdIeAfBJP8O+0w6wTY1X71YUVN6UCi8Q1ui+Fo42rf1wLiMA
 g4ezm1CE5O65w9jMwmaiwuCZ0g2tybNTzqPIJQAkW2JFZhl22AqtvlaN8MLwApvOfL3TOiSzqzJ
 fvsE+0RjrhyugTov2ERaAtZT3FM3+AZq8U6L1cQMiaPyJpvOZ6BYGYwmUu0aA1qpiD1O5iWFvtw
 MGAwMwcGXBUpik47P+hBkgeRKX8y8aReV4wDt6vI0yNFM9jEBq0hqdAYBk3alu2Set4XsgiqhmA
 DNKGVx++RelpPtOLnmkKZQqk3fSa1/Yvj2AsmYoK+2b0/WV+KXYiUHsxuHANKAMOBk0N3Ffinc5
 eZg57Wpk7Yh+w+EqSMt+eXETfZGDySGmnhYgolar69nFT9SC6UeGjgqpM4UkONf1l7G3j5g==
X-Received: by 2002:a05:7300:aca6:b0:2ba:6c66:1f0d with SMTP id
 5a478bee46e88-2baa7fa8458mr390835eec.14.1770848399160; 
 Wed, 11 Feb 2026 14:19:59 -0800 (PST)
X-Received: by 2002:a05:7300:aca6:b0:2ba:6c66:1f0d with SMTP id
 5a478bee46e88-2baa7fa8458mr390821eec.14.1770848398539; 
 Wed, 11 Feb 2026 14:19:58 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbe123asm2588379eec.13.2026.02.11.14.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:19:58 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH v4 0/4] Handle some invalid encodings
Date: Wed, 11 Feb 2026 14:19:49 -0800
Message-Id: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MSBTYWx0ZWRfX99h5oMnXKrlI
 5C2Wgc2/5Xy/OqQMRyW0l2NkwTHPxLE5R68GJPFALqLXaDXfYwbmNxYRD7H4i3RagkDMUq/udOJ
 UoEQSeD2a8wCI/KzjBeONgulrBD0wf0A89FcP8nfuD5oDCdZTVpwv8ecZG0PXJWOJIVJ8H4CB0L
 iTQm76ci9cZdpy4p3ax0AjKoKhsCGIpjMGpWtreW+YiJnvDKRFWmm672CvpyDPMLt/o/I6n6NtV
 GDuZcbpYFDGY8LY9pSzKzv0UYFBCPclcyt6pVGaDGBf4hxTPFR3KJC7hdHCaabpLqeJEf5RV4Lm
 YwbjUM6kSUFntZM648ht19Hihv1V2XBn/PkI5CjT5hyaZKd1UlpgMmANK0dGMwKeBz8X4eWWCAx
 RRO4zuj2DM5HSTqdyF/MY+g75cs2qcieaz/QSyHVMBl+yTY0GAv7a0LRgeNX7djW3eYv30Gys03
 m+cwro4AnrGG9DpKFsA==
X-Proofpoint-ORIG-GUID: Uu_8wWHr0LNj30DZgOQDAWgMYn96vhDL
X-Authority-Analysis: v=2.4 cv=INIPywvG c=1 sm=1 tr=0 ts=698d0090 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=7OUETykng6pzQwdykssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: Uu_8wWHr0LNj30DZgOQDAWgMYn96vhDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fix the issues reported by Alex Rønne Petersen causing zig test suite
failures.  The 0x0 case is a conflicting "multiple register write" - the
handler here will cover duplexes but not the more general case of multiple
register writes.  I'll include that in a subsequent patchset.

v2: use a signal handler for SIGILL, combine the tests.  S-b Pierrick.

v3:
  Dropped "Reject duplex encodings" and added "Detect register write
  conflicts..." -> more general algo S-b Taylor.  This patch moved over the
  test_zero() case covering the same 0x00000000 inst encoding R-b Alex.

v4:
  Reg write conflict moved into decode.c, S-b Taylor.

Brian Cain (4):
  target/hexagon: Fix invalid duplex decoding
  target/hexagon: Return decode failure for invalid non-duplex encodings
  tests/tcg/hexagon: Handle SIGILL internally in invalid-slots test
  target/hexagon: Detect register write conflicts

 linux-user/hexagon/cpu_loop.c        |   5 +
 target/hexagon/cpu_bits.h            |   1 +
 target/hexagon/decode.c              |  70 ++++++++++-
 target/hexagon/gen_trans_funcs.py    |  10 ++
 target/hexagon/insn.h                |   4 +
 target/hexagon/translate.c           |  28 ++++-
 tests/tcg/hexagon/Makefile.target    |   8 +-
 tests/tcg/hexagon/invalid-encoding.c | 106 +++++++++++++++++
 tests/tcg/hexagon/invalid-slots.c    |  76 +++++++++---
 tests/tcg/hexagon/multiple-writes.c  | 169 +++++++++++++++++++++++++++
 10 files changed, 447 insertions(+), 30 deletions(-)
 create mode 100644 tests/tcg/hexagon/invalid-encoding.c
 create mode 100644 tests/tcg/hexagon/multiple-writes.c

-- 
2.34.1


