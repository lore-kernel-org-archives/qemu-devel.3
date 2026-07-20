Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F477C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlwIl-0003zh-TX; Mon, 20 Jul 2026 18:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwIk-0003ya-7p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:17:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwIi-0003ad-8P
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:17:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTesd3599056
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jO/J1F3PTSe
 PA+r/s+MTzyjsgyWftxrcALWS2j1MU1E=; b=KpKqie4evHFch9q0s3I95rhAj1o
 c3iVf5h9hr1UAlZrLH/nrCSF1UMVu9LY2q+s+2QpIGbU2S3hUcPUOAZU/n5PGWpp
 D6qg8gt15f91ShZJVCTtekZUfKmnVLO+xtG5aomu28iqOAwh3wm48vBSujN5ZRCD
 QH1XCazTFd/mn+9TdnAghufMENGISwS9Fh7/EFvvsCWDVS8+wDmSX5oDAdMDM8GK
 DLQX5S6AuMsVZi2RmKn2fDNiLb+Kxkx9kZSanmcq2Jmll8bYALTgaX1GbK7e9OKB
 75RxZfw0fkkB2r9tWlqeFzUqPtO+uz3hK6qcbKqmFnGUTYKUtvIkkGhJJMQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgrebdbf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so7402930a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784585846; x=1785190646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jO/J1F3PTSePA+r/s+MTzyjsgyWftxrcALWS2j1MU1E=;
 b=Qdve/m8elrPvqcDCBkwKf1Vj9AS7TnlGYqrM0V7DP84w+BbfC4iEbnIlUw10ASupgb
 9LAwLIS2Cmf3GU5059zwcAC17CxOoXvew7sBGWq+fEeSUUzGxRtgZyuh347G5tEwSKE3
 Ii62ri6wELmMG5wuK5sjIjunUvYc3ozatIoR5u7aF1W/si+u7/5zTInyVwHdAdaSxdce
 ey2TtWKFARm8JVbqGtx+eM1OOl25BtkbHl0DotqFCBstKgzYsT2k7+Iw0Y8RljgZT75i
 dug0BQ4VWeTE4EQMkPCP8ivufXrVNElTvHbxl2inpPbSR2W1M/+DuMKcDnuqgZupO/xA
 mrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784585846; x=1785190646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jO/J1F3PTSePA+r/s+MTzyjsgyWftxrcALWS2j1MU1E=;
 b=qnkZFlmym0EnEgWn2VNYpiBcJiKBV8YirzDNUT8mWhxVNL41UZbRtEI8OoQTxcLTfV
 uEAd7xFr0+xgNWmxMRQ3fknkMysnmrqZVwdaSjSHghLHlkJoqo0r0DW1AHT9S03HEfSK
 0jzavERwxJFJi1QwNPKzpWv0wgH9kzRKGNRgkkJJdH39g+j83cMYw42wrMWk9DEBANYD
 tHKC5cRAyCDLEHgkgwAfqyysEOn7FdiFWgVPiAFGmNhmSjaiRtaKcLUh+mKIvf5I3C2A
 jQhB1cO792u2eED4oIwFag47Xl4VmENNqe+fzHMhAYIE/eCjhPTB+Hk1WIlAC9kWPvsM
 sYyw==
X-Gm-Message-State: AOJu0YzHmpd0VdOouALwqw834IXhMntWEfUdHOugJSfb9IV2rGd1FjCp
 LC8lPCQ7lMOb7RyH1LdZE4GnWQKHRWT9AAsfJyvqwClN4K03EgJl+bE0MKppFtQURFIXLimUAfc
 2uIJQmFZFywp510Y2ofu/IWQntr3H/9YD/QFOzSFt0XlJ+JakCetdX7L1RSy+0PIZeQ==
X-Gm-Gg: AfdE7clh1rAkqMU/GP38q7zuP4SqL9k8/hxeuGTD3KkL8OL/Fmi2v1eFwZT446gsjip
 7y8SpC/IODMA2GLB2jVeoYAvvkHb/BujDEdk9VvsbcAS/ihbgaABbwd6RF5Pvzz+1lSNAdWeXvM
 xvfMcSHc/bGpR49kBJdjBXACWAn5e6SvqI4b/wcBXIxJzknWdqNcb8+qNyX93I2VJCFLfn1Cgk1
 7gNBGsfg/XxFId3bR9X1+hi8/CVESAOTN4ipp8gn+N9MhQXrKZy8qyusmLhsMV0rN/dp+4eFdMf
 z/Pzs9xNpUzTKt2lxAlPPYDcjRCVg+JyWrYgJLi6AWwH5EGmu1iZAr8ZFCYZ1xjsNl4HkQ4rJNE
 ofHjIga1melZrN2SHaAcG2BzCCd9fU+0TsYKmH+c5l/0DBv76lDAs6pAGCfYFUhRTcHYua3Y=
X-Received: by 2002:a05:6a20:a103:b0:3c3:87e1:2637 with SMTP id
 adf61e73a8af0-3c3ad7abaefmr17142793637.22.1784585846113; 
 Mon, 20 Jul 2026 15:17:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:a103:b0:3c3:87e1:2637 with SMTP id
 adf61e73a8af0-3c3ad7abaefmr17142768637.22.1784585845672; 
 Mon, 20 Jul 2026 15:17:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cd6e6esm33855000c88.13.2026.07.20.15.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:17:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/2] hw/vfio: restrict to kvm hosts
Date: Mon, 20 Jul 2026 22:17:15 +0000
Message-ID: <20260720221715.27108-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX6GglulYupcWr
 V5D9zNbxPn9gPk27r58Nr685Arj6I+V8bHO2eNkvjDqkhm0u14pkBf/g5Y8UD7SMFzVEmGr5Ouv
 FCEHjJGS8xsBruqkk2mYNLEv+Db3bqM=
X-Proofpoint-GUID: K_JN3pXyjowZVXpaMb__s3N6iqDX3VWM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX530sNRfhf14h
 J5VDnRQDysqftu37QRrqhgcdjn7J2WJoi1Y1AH9zPevHE4W0wNKW7SiFtp38hU6LIXZEnVCSgFA
 bsvjDbaXlbJMm0zl9cvAKo6kw7iW2Zo+22kTnkul+ncRKXlsMDJtoA8vzOmYhe/MLxp7lTatGsB
 3lvkoegxZPLrgBCvrhJwIBmah+Ehx1z5n5wb5YPbotxSQl0xIAr6ixnzbmNnpKbwgh/nGjmvfh8
 0Cu4EPff9mrPTvoI2nigISqCzT6U/mmI03znOpDZhjXcPwSPvqHebWym98tYHliZ8hCV1zF3zNl
 /81Uq3UPmUhU0Kb3bBoNPxucZBXGhwBZxVie6K1mvYQcE/YbZ7uxtGlRSEZ0mp8oLC/O4n5no3d
 NHHGUxwG5Pbso544UH5pKy+LW3n9YpD2SnqvM0+3eQmweNcBJedoa0poAB3GiFZZV4tl0b9dNpe
 vPDRARk8raF7ZPewyuQ==
X-Proofpoint-ORIG-GUID: K_JN3pXyjowZVXpaMb__s3N6iqDX3VWM
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e9e77 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=tdTuOIWcMFB9I10xYYMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200242
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

sparc64, which is one of our linux hosts, does no support kvm, thus
vfio. As a result, it fails to build on this platform.

Thus, limit hw/vfio inclusion to kvm hosts, which provide vfio support.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/vfio/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 27de24e4db1..1329f8a2caa 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -2,26 +2,26 @@
 
 config VFIO
     bool
-    depends on LINUX
+    depends on LINUX && KVM_HOST
 
 config VFIO_PCI
     bool
     default y
     select VFIO
     select EDID
-    depends on LINUX && PCI
+    depends on LINUX && PCI && KVM_HOST
 
 config VFIO_CCW
     bool
     default y
     select VFIO
-    depends on LINUX && S390_CCW_VIRTIO
+    depends on LINUX && S390_CCW_VIRTIO && KVM_HOST
 
 config VFIO_AP
     bool
     default y
     select VFIO
-    depends on LINUX && S390_CCW_VIRTIO
+    depends on LINUX && S390_CCW_VIRTIO && KVM_HOST
 
 config VFIO_IGD
     bool
-- 
2.43.0


