Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E925ACD6E71
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 00:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUvcg-0001rH-U4; Wed, 03 Jun 2026 20:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcf-0001qM-IH
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcc-0006Y8-EL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653K6elF2076419
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 00:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EtyexG+nQsF
 Hervoia4GntLrrrmor65HgX7z2gKHgdQ=; b=IkUpwunUEh5nHlDQOCQ8S3tuxHA
 52WT9KaY4OtVNNmlUZbU2XsKmdYsTel6/faGP7WL83KLEeDfHrkw1x7IlES5/EVO
 czzPHMYqbK2zU4zLVbwJaMyvyT2G3VXLbRw+zIU+wIbu0NyKxFMnLw0tjRFFMNX4
 iT/hytcVWkgGGlGuzabHwhu3/zD9uW//nJIFoFRnPHud8RR1kChDl484UQsvuXct
 fi92/ZuZE3Ikk+5D4aETEyc/8AGVZDXVIX+eVAzQgJYfa8Yhq2r2zwpOQ0ZysuQD
 Bj8nJ9jw/RexwFILaVpUdBWBM8LmWjdKS6yxjg41GpuPdwJTs7XHFH5WjtQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1c67u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 00:07:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3075fa5a407so275002eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780531657; x=1781136457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtyexG+nQsFHervoia4GntLrrrmor65HgX7z2gKHgdQ=;
 b=c9tKmy48E9xlNctimlZ496w1+R9QpaN5jpb0kuobZ10NayQY4Tdy2FBKA3ousrEF43
 IpGOLe9AYf66qPnA9v7ttcQhcaWPThBG3zySvJdSkEjHXlzIRWIVHPNIRq1WZLEMS1Ug
 nT4DaKb+fTGhlCnpPfXIwMCAkuhjo7+dOU5AWdDKyxWmcFCakFh46x7NtM9XuvQc8eda
 v7bRqRIrDjmZF7+j7XxNGCgmWhn62UUda09FNh2GUQ233rskxMmxf7kGtrTmRtEiKtF2
 2kqqjxgcDI6tL8kxMQrIGi6aOImwXDwYds02MIFIFGqfehGenjik6i0/O5Rl6HR8cdzV
 DVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780531657; x=1781136457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EtyexG+nQsFHervoia4GntLrrrmor65HgX7z2gKHgdQ=;
 b=V40maEuSS3kERy3RD3QR5KNo7ETINbrIqmZwPTidG0aXbIM/FcSq5p0/itnZoamOsE
 eK3QapW3qCa51Dei1lWt1Ai5ljNRLxxT0k4N0FsCvxSrt8D0MnIt8LOhnboR03Z3Kq9I
 astzVxLHqAugWgFYfCdeStYEX60x/5kglqog5drw98eVZAWvLDckszoMeeYHQORuC2/u
 aEhpCt7Ab+NoMFLbrswSOgBggSxdzaYVygBS9RVxB1nzw6ZmBBWI4iFt4zykrghI800O
 ZmwiGpGlRF74LgAlXat0EWu4E+A6zxIWYjNE6Ofl981eVp5ctXtYigGskp19X1LUQG1o
 eSBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F37TGgeJXSJDMYTJ2LssxTiqJGBkJrJTMLG+QIUhlGFBPkAc593zNPpiYZhcPQPdQiW+v/+ORQhYT@nongnu.org
X-Gm-Message-State: AOJu0Yze4+tP0YlCvdQamebgTtxE8C/JEDBbjdF6IbAptZw6F4Oqvorn
 7lOPSlbrLhYOTXz/YIy2cw88xDueI6Y5nyyRJ804mhNoM12YcIugLsfD9H3uuTrGAZYzcdRbmNS
 rFoGDmey1mIaq48pM/kamPhWOZZXvcp/U/1YJf95cOpmLyzGShMruhHYZGw==
X-Gm-Gg: Acq92OFj5cOk0vHI3gGHHZ70+NDhXjQDBFDjESJtgT85soEXHl0kHYAiiP5nrJFziq6
 J5DU3rLYXWr0eIKVyiVlxrUPpu6ilzTEJPcFE+UZKYT3vX8xeImNfYlkyv6XT+x34Og+xP29et9
 98whoFSU59fodxVnQSbh5Ybg2ATDZZkfc/8RuG21/vpV9c+Ix/pL0FlM2iLOmUkG5oe3ODD4Vtf
 x9HGrl80YGLd6CTpLQNgyFadDKLVAiYYmyHXI5ldDnKZuDd8U0167dda6LdvyJGSm7n/Nup7EoX
 VhPyF8lt5UDxcLBNnWeqsigy1gUyGFKjMXQKvfeamAjfJflpvEPc1/rO53V9ZezNYziJQ8Cf2lp
 WjgjlDR9shmDtLDSZQmkOSD3lLyauCyTXB6amNyABbbEVT032Wx6LYOjOvcjFGkDYIvmQEK8WpD
 iqndlPsPrxv4k=
X-Received: by 2002:a05:7300:8b84:b0:307:26a3:75e4 with SMTP id
 5a478bee46e88-3074fa57610mr2746983eec.4.1780531656738; 
 Wed, 03 Jun 2026 17:07:36 -0700 (PDT)
X-Received: by 2002:a05:7300:8b84:b0:307:26a3:75e4 with SMTP id
 5a478bee46e88-3074fa57610mr2746954eec.4.1780531656105; 
 Wed, 03 Jun 2026 17:07:36 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dfa3a2asm5374960eec.31.2026.06.03.17.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:07:35 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
Date: Wed,  3 Jun 2026 17:07:31 -0700
Message-ID: <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mAZfC7KQY_UmecRm9YRD0aaqMON036mI
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a20c1c9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Bat5o3Dkq0--bRBYi74A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: mAZfC7KQY_UmecRm9YRD0aaqMON036mI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIzNSBTYWx0ZWRfXwfZIqUn59xog
 N+h+DQ/apWSC4ncru1SenyN4A5ZM2P29TuT/ffFTpdXbjYevTW3YZ4uzfw1Zuaw6V/FJ9Ge+14Z
 7GDUJz13aO6YABxETltqLF35CX/+8IY8cRK2w9VNbD68Ur+3gCWP4XVFWgrzFRO4ujcfywmsw6X
 xN1Pc2y8bNm+/hyk1yZ0wGs28hzlGJGOwnvtQpx7rus6ZjuW5BwAq7sASIcHAruD0uNcpeAlpLc
 TH+GTeQ701ygmXnL0FZLoifJC06EF+205qhtCPA8ujMFMCBc3Bk+0XteN/Hfo3TtGT7VYVLLMuT
 lgg+KK2LpLu2Kn17L+EhdYsvT15sH1Wv9bMe/V/k6dlRRwWBKtjKvB699JAfrTZV1nBBbKKDCTM
 6GCxjsdfvInyVX5FwjqT+sGUTNbdMy0vLTV514k8oRN5GDJcWUE8dN3jHb5kUcmQxbcLs854xfh
 /7mIdRkPgGgE8BGQBBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030235
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


