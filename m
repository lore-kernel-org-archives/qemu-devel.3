Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFBECD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8xq-00076J-EK; Thu, 04 Jun 2026 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xd-00073w-VF
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xa-0005R8-Ru
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654CCffJ3221208
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 14:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=O5XuXYgwern3WljTVhvmtz
 UQrKjPf3oPj4CKUf03l20=; b=LbI8wUwf7al3OkPPqb8erUXzFcByRO/D0GDs4H
 /7ySBdbgwh9uu4Z3OP89GGwVSRTtd7UfmmnwraBmZm/4kjHdEGET/EIWeJ7WmPIQ
 luggJgNrLuvkvCl7Oed+2eNWphJPRh/VMbGP9oKtgQtct97AOIBpnL9D5aEHwKy6
 BjWtDgnQl+sJ1dVHVSHuaG6Pf1+xZOjjwVnZ4OCyentvKToxLEp7chg6HFEAsr2w
 iD8/02v1wvrthgm6g9OIAvVKuALzjPN+el2b4fYGV1URgcDJMK03dM4VchUBWWJ8
 c5YRCajZiWB2lXLk/nCEN4M5/ARbTpUJl2RGx20mILKGg2Ow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95u8k0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:22:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3074797dfa9so1021588eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780582931; x=1781187731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O5XuXYgwern3WljTVhvmtzUQrKjPf3oPj4CKUf03l20=;
 b=i2xMsrZEYSun+apbZOfGOG9cE60LhRUgMFAV9B+h2DeOoLWr7OGcj+Pb2OhEF4XafG
 DVJ05CIwYqufhCmRF9NPO8/8ZASZvrVWZRlUW9DM27k1zxN7NSgvqQDouN6Kt51XmyfV
 bnI3nKUgatISdgfpQjNcIjaEwzjd6Zh8qkm7D6draIMHwPsUYJPeXFH4P0Pcx6LtBRJ3
 GKI6w1fBVDOSndNKeeHBBe7j8PGm1b6Z5vhF7UHq8wBMxSHwAuATwJEMyYBrVjru3MEs
 oU6q4AxhLvFrNDaEBpMyreQuNc3MHJmTRdMwkeIVfdDGdWcE8DvKu3gNCUlw+WQo9hoc
 btPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582931; x=1781187731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5XuXYgwern3WljTVhvmtzUQrKjPf3oPj4CKUf03l20=;
 b=C5B+NxRztWUEkNhpatUn+1Dx2axNESsyM0Rw73g5OaEp9oK9FGIqT+G4q+6iJmZm6s
 WSErbjMH+TIaqAouw0V+qGMp2iNMOR6mw7fcrDX7fTPheUwPgS9wzIKhl9QD0tAMYK2P
 NeCfK04jiddyvFoyizGtHMs3bjWIh7+vN4KUjeKtQt0u0LSQyk4PMTvZEUmBLSoSG+mi
 ICtifLeaFTizXr+Ih82ZCwM2j/J7QRTHua3PkuUkzzOJ17YCKB+mi/cVbYAeght2TMSC
 NIuAHmJbu0jkuUnZnvtPRCnQ6cS7FKxbxdnQ5d9GaYrGwKBwS6wf1WCtua6ebBO9Z/31
 y0pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WXDgRrN2S746n1/U8yVJ+09zL/VHOYEnOztNXPvuWFbtkq5mJAQR+xGYqTU1nQQQ6H88GG0QZW7yO@nongnu.org
X-Gm-Message-State: AOJu0YwbwskWcagyIL+D+c2oT7VWRtT8JPhKwtrUbvoShMCOn/BomDZj
 jbqRJsB1sb6bHZc+RqSpE2Iq+9t3GmgAYwJDi4nqI5uC0nnJOhmYwCfbNDjnwpvbNLcrf/JawYA
 BSWZnvxqmZq1tEws6d1dgBtLYkHbSC8NujYkAPRktZrqJ3phn4Fz/NCv6aQ==
X-Gm-Gg: Acq92OGMeOgV9NwlYBHPW5W7ZqP7Bbssb52ZtWHFyHzZwg94IuwxeJ7tnHk31oEyr9Z
 ijC636hft6x5tmH36uhCssMACSI4FWgdVZTANrN0cuAH9nC4v9sfKCIQsJpdybdlQOyIXGdohUr
 brISJ5jinopu9/wMfvlJ65R6ZJVsUtyO5KhUWJS+xWxaybmFcStkNxY8pq5AF7b1Z1cn0ng6vX+
 VuymAG3cYTXbPH2LOC+MgmeE6Z/aOJrgkch2NJJjrs1qPX6NVuUZ6wsTdOkOWKQH6zaiqaFYqhP
 HfS9TBGmpCesS6nKFp5iviaJptMmyhkHNE8KGNvl5KGBHgwFRZTnzqQRrA36zMJUQXT/nt1TETY
 k7cW8d/LzwI3gr+A45WQuWswDzqITWhLsgbZbiG1OEJEBZAIxvU3v6+WwNHN294WxgTRDxKMfB0
 fq3uOgeEYmk4E=
X-Received: by 2002:a05:7300:dc8c:b0:2d9:db50:c6a5 with SMTP id
 5a478bee46e88-3074f83a230mr4450539eec.0.1780582931151; 
 Thu, 04 Jun 2026 07:22:11 -0700 (PDT)
X-Received: by 2002:a05:7300:dc8c:b0:2d9:db50:c6a5 with SMTP id
 5a478bee46e88-3074f83a230mr4450503eec.0.1780582930364; 
 Thu, 04 Jun 2026 07:22:10 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm6179560eec.3.2026.06.04.07.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:22:09 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@mailo.com, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
Date: Thu,  4 Jun 2026 07:22:03 -0700
Message-ID: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a218a14 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Bat5o3Dkq0--bRBYi74A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0MCBTYWx0ZWRfX8BPUS6pdsXxg
 6hAieoXObRhORMvl7Je/odqxJf7H8czKkW+V2dVN6qH+Ze7AQa+DWzarbxu3aGB7x7B905LabAe
 Q3K28p2D/Bs98+4+0lqcMqhetXsn1379OCZ1JIFlyLNcHzFyX6jN0P3bsn4QcALNalU7O/E9B9k
 M7DOrZlyRbnLUg6q3UmEkTL8Vw/5clrSVO8HbS4gJrtqaOo3G5dMw5Tb09TmAvCJlxZonoQNxJw
 Da1OH8zKdSta88AfvrCqxJjPbMnYKazJg4mWgDWs7il3C1ia7XyzS2W8v3eR8QCw5uacAvpWwd0
 ZyPSjp4SWjghiNexM7mKg7qtiq981NkI8MQE3gH5RIZQ55k7/muYDWbWhu3Rmn6LiaNRngEsqSk
 9Y/eVEsQmHz/pdv1wueX6EiyTRV97RiJdLTKcak65dzy2Zey3FnlYdR7ydU4ILEe+RxJrPvTdEu
 r/plvF5DEbpNL4VOfwA==
X-Proofpoint-GUID: A3ViU1lifEYA_eJCWexN8yRhvBrKY96v
X-Proofpoint-ORIG-GUID: A3ViU1lifEYA_eJCWexN8yRhvBrKY96v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

This series corrects the DesignWare I3C controller's advertised CMD/data
FIFO depths and cleans up the misleading queue-capacity field names that
made the bug easy to overlook.

The Linux DW-I3C master driver reads QUEUE_STATUS_LEVEL and
DATA_BUFFER_STATUS_LEVEL at probe to learn the controller's queue depths,
then rejects any transfer larger than what was advertised with
-EOPNOTSUPP.  QEMU was resetting these registers to 0x02 / 0x10 instead of
the real 0x10 / 0x40, so the guest believed the controller could only do
64-byte transfers and failed any I3C transfer with a payload larger than
64 B.  The backing FIFOs were already allocated at the correct size; only
the advertised reset values were wrong.

Patch 1 fixes the reset values, and additionally drives the advertised
depths from the queue-capacity configs in the reset handlers (per
Philippe's review) so a configured override is no longer silently ignored.
Patch 2 is a no-functional-change cleanup renaming the queue-capacity
struct fields and device properties from _bytes to _words, since the
values are word counts passed to fifo32_create() -- the old names were
what made the depth bug slow to spot.  Patch 3 keeps the old _bytes
property names working as aliases, since they are user-visible and shipped
in v11.0.0.

Patch 1 is the actual bug fix and is tagged Cc: qemu-stable; it is kept
self-contained (using the _bytes field names that exist in released
branches) so it cherry-picks cleanly.  Patches 2 and 3 are master-only
cleanup.

Note on the IBI queue capacity: unlike the cmd/resp and tx/rx capacities,
it is not advertised to the guest through any status register (the
hardware exposes only IBI occupancy via IBI_BUF_BLR / IBI_STATUS_CNT, not
a depth), so it sizes only the internal fifo32 backing store and has no
entry in dw_i3c_resets[].

Changes since v2:
 - Resent as a new thread to fix b4 trailer collection (Cédric Le Goater).
 - Added Reviewed-by from Jamin Lin to all three patches.
 - v2: https://lore.kernel.org/qemu-devel/20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com/

Changes since v1:
 - Patch 1: drive QUEUE_STATUS_LEVEL / DATA_BUFFER_STATUS_LEVEL from the
   queue-capacity configs in the reset handlers, in addition to correcting
   the reset-array values (Philippe Mathieu-Daude).
 - New patch 3: keep the renamed _bytes properties working as aliases so
   existing command lines do not break (Philippe Mathieu-Daude).
 - v1: https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@oss.qualcomm.com/

Jithu Joseph (3):
  hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
  hw/i3c: rename DW-I3C queue capacity fields from _bytes to _words
  hw/i3c: keep _bytes aliases for renamed queue-capacity properties

 include/hw/i3c/dw-i3c.h |  6 ++---
 hw/i3c/dw-i3c.c         | 58 +++++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 17 deletions(-)


base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
-- 
2.43.0


