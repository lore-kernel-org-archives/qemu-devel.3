Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E861C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc83-0000Uz-N7; Sun, 16 Aug 2026 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc81-0000S5-QB
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc80-0000d9-DD
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDknKW3532396
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pjqjEaxVB/QtFB2VMgo2UyEK8yOL34JHeDLHC/YsL7k=; b=Fvy77fYtb6gUgv6t
 a1a9irisdTHVLbVY/5WTYxWcpmi+zTese5zCm91G1nHMf7ghBXri6HDxeZ7rqy3q
 SOSp6yh5mPftM5XJySbd4vr+k3DMgvzgw/Ou021L5yTyHRa+aidKCKJ5RbxSxW1C
 T5Y4lIYlsO5YEHq1XPKZLNy2JUPZ2eoxlqFpUzT6lfBMrJs4UNScJ9L5UM+KldsP
 GzDCTr+ohvmfiVsOgljUehdtKD5vvM+iz8qO7uozGwa4ogdWa3Zatiue8etMXdVI
 kTQS5Yu8X/DOCFIoH6/0vVQo8T4OfC0Un7jek08Txs8qicgOENLY1eeO0dV8mvE0
 NT5Qbg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf3md9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso45089361cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891583; x=1787496383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjqjEaxVB/QtFB2VMgo2UyEK8yOL34JHeDLHC/YsL7k=;
 b=cqg/U7xvNNK36IbisE9aWilrvia6h6tKvM3LjdBZl57jEQmd1OjXHa7haMBKsnad4w
 mAVJV3mbOZ5BQIOL4G6ZckhaAZVuRaICyRsOm9LXqzCi62D+89hn2MCf/wxaYJ5d/+eO
 TWIEzS+IvaF/XMq/VHr4p/S11mQSSYf9P2Tf3LdTgHFmsT6mXJCEkRrz6unIyJiQn2Nl
 o7ltwIpjHJmaLdxyEP0gXJeKN78e7Qh8Ke3uxRSbjsVQdehBgfSIpGRfqxxr2uYrRXgi
 6CbVi3SPhj80+nDnpaa6yl+I5KpKn4bX6pHhKerQoGQCCzqjWpltAJPFTrj/qRbAWKWp
 Zv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891583; x=1787496383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjqjEaxVB/QtFB2VMgo2UyEK8yOL34JHeDLHC/YsL7k=;
 b=JFBwEHYt4m3E1JAYti7bFhLk1uyNlhA1amQsm5UDkIDn0Px+aHC59BcEhIVem9wQli
 DZnNgwau1ri67IzEmzhVEpshGwDm7qVU/53Y3vD8+/86yFCXr8Mh+BIIOQyQqPnCjpLw
 Z57fdNvmc87KhN4fm5jHOB7BWe7HfQIJWwRLPtwX/yQWVpDesMl6xwJHwwlckJY3qyhF
 tH2oaY4YnDI1BIojJIMbx+yLHZXQpJ/X3RUrkDwMv6P6X6xIY5JVFPQVpRbLJkc/tsZt
 R1iXbszAd4Bl3oyDYg8hmgPXjdV1wcytlSe91iqepiEw/FyUJzoQbgC+sF7OQ3i8SWOu
 fx5Q==
X-Gm-Message-State: AOJu0YwEwiorbWEy3mey7eEFOJAwZt1WEE8NX+gm/noHdBIug8F2hsod
 QssWHBWtrNnxIUbSeXz051j9t5XMUJiOGauB+RwHVgiLmKrcbpBWqi6Bu1R2fN1Q0olpoR9vDi0
 zmsPYyew1e6eCtxvN0V+CHRkvgCIr1Lt63bForXID/O3yZuc0wbwOJV7MhISeymrfBg==
X-Gm-Gg: AR+sD1094PyMz57QiSMuPj6oFYGi32yzXIbcg9MjttNfQzjUpbMr4SJ+enyJECvsb+z
 JLnSrCvAeh7aTOf6Em6tkzSt8evNJPdsWiOH38U+/BVGIrh/2ZvNB2cnRPpfnReKwp/IYUYO/gY
 Cd7C59Ca4IELLHYOKs8iaZC/M/pxHEj3SC0xpt9T9UCu+j4wWID/HG2qsc3wms3seSsjVpQ/Ny5
 V5LECWNoyYtcd9Pm6M+VEzDmkKhMyDt0v+02+c7x5Mtd5cP0JQvTLv55/59R9sDq1g14sqFvNW9
 pC6G8UoDbpPu6+/r4ljgdjyqfBci1wvoiN5tQ83rK6bYnDJ8AN07NcZ2wXdav4tzr+bDmxN4c2s
 dM7BXM8xSlFH1kYjKwv7T297UuC2iXTU5TIopF5AoBQ==
X-Received: by 2002:ac8:6546:0:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52d8530dbb8mr222684711cf.8.1786891582004; 
 Sun, 16 Aug 2026 07:46:22 -0700 (PDT)
X-Received: by 2002:ac8:6546:0:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52d8530dbb8mr222684431cf.8.1786891581619; 
 Sun, 16 Aug 2026 07:46:21 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996113beesm49816055e9.11.2026.08.16.07.46.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/56] qdev: Make qdev_is_realized() take a const DeviceState *
Date: Sun, 16 Aug 2026 16:45:02 +0200
Message-ID: <20260816144556.69009-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a81cd3f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Xuiavk7DDv2jdHKTz3wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GdPDKxgppUDeriJowm92Se_vm5uxKJ0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXwJMuveqi0sE0
 TQYT41jdArwvbtJ2NzVJfN0r0IIBT9eWuZaEaYfc+E3X8F8ZZE2c3lVJUZEpoMLEgatrfJc9GrX
 rDCNmgBT5tm8hc5XyXi7Zqs18QALC4kJXJm1NPN1/8mSIu4AguQ7SzgusT/03Yd3LjZYQMPfO+N
 vx2UZtWg6xQZRFmSTUFmrWoh0Tv8U1sACa4vq9TA2DicFGofdHVMvms4RwMTUPgijsDTf5+vmMn
 eHPcMZu2yxrCQhV/XmWMOohXmCPsU7Qtr53asw/TxiYiOoBSdJ8e8lSJ1teOarOuEmhqPz93Dy5
 TmOYWMvKiA1/pvds/rdgrFy6VGoJlzfkGyPaYYn+LbHSbmUHwZgApnTp8GD69zp3n/r8KbrSPmM
 kDla0RXoTwv1s79/rIM9hhJOYbcx+YfEcIIKPmdGAyv6Qolg0rmVbkPiEvguWGB4m3R0bS7TOOe
 mqXdQ9mPAvodeveBALQ==
X-Proofpoint-ORIG-GUID: GdPDKxgppUDeriJowm92Se_vm5uxKJ0F
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX538lrCnfWbRw
 Yd/h1r20VgYZgPhsRXJEVysl72FQm7B8SivrjeOm4ShLDrO14BHRF1NjlPjevl4t81IePrVZPMd
 iCdY9FD2PlBbhzCF1se6OXkrW74m5Xo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

qdev_is_realized() only reads DeviceState. Make its parameter const so a
later caller with a const DeviceState * can use it.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-2-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/core/qdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e1476223411..37f7d335519 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -437,7 +437,7 @@ DeviceState *qdev_try_new(const char *name);
  * Context: May be called outside big qemu lock.
  * Return: true if the device has been fully constructed, false otherwise.
  */
-static inline bool qdev_is_realized(DeviceState *dev)
+static inline bool qdev_is_realized(const DeviceState *dev)
 {
     return qatomic_load_acquire(&dev->realized);
 }
-- 
2.53.0


