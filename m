Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A8ECD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXye-0005nW-L1; Tue, 16 Jun 2026 13:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXya-0005kX-DA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:53:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXyY-0002F3-Nh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:53:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH92pQ137683
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iEzqlGeVG++
 epljayNFPZILpELMZV29NwKJ7aYzHw0A=; b=cQili0wMCByxrfBmR9LdbX1yDxF
 2UzqlxRg+SkQoDS/toSTKMH9ZV6FK7oPaBdMbbWkAZpc4pBpVVSw5TJVcsk/oXLC
 c23qZnJPyzSopL/hjeTUj/7sL6kDfoM9Hjcl4lCyFFoVM0dDYHImriYU3eycGIas
 aGLHzFZ8iZ7LR3yL0x43yMB52n4yd+CY2Cc/5V/LiK9KJZOmK9mDiIjXOfjQeQQl
 xbugNnE6AEwVE2/9n2zbfZrPW2/OWzp+tzwSaY2btBq9N4TZCBm5J8qpC+ejUr5a
 i1NL9JL6k3qZgAxGNtR08c9QugYfZVhX0Q9glWnv/Eqw5Fw/xTAUuyew+wA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epay9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:53:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so3303804a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781632404; x=1782237204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEzqlGeVG++epljayNFPZILpELMZV29NwKJ7aYzHw0A=;
 b=TRSV5jP3WAoVJl1Td+X16P3u1IKh/WLnCwKUvQQT0FKuCefxowVrzqFTAxjqsKwhvO
 TF88X7QL4VSkkUnQSqULygF20rMsvdwXvPu1nwzA+UlIsHSdyFCridEJOAs2Ii/L7o4X
 4jau8Nv+2RNzRGmclGNXi78tCRQ0fpsyD2z02a2ww/L5fC738pMgVBUUDEj6U7FqtEB3
 GnuDmUu55vsE0ZI9uronW7CabYPrD5lOMSi4Cb5xRu5MK4ClpMWm4KoHSIiML2HB/0fN
 nwN3mY9OsbRsWO0V6vnijQlPb9W/dQvlOMpwWoORxQMd0iLq64IbLbz54qRXEIhqqQHh
 CG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632404; x=1782237204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iEzqlGeVG++epljayNFPZILpELMZV29NwKJ7aYzHw0A=;
 b=hHjOxybwcpbX6lqg/GGJdWkhbdM/0XDzqSI6Pb84TcRfmqZP1ANDElAraUuXXbRTxB
 EgiABNHK3ipuda7/oqB0v5y0uHtu63GkUKNnLzj9Tz3EDDBFKpypoMD8+w3nfQdKr6hx
 0XnnjGNnfR5Wcgp780YQdYtyQald3BcvsSgnAYq8LtNqwdA0WiRFjgghfT4sHN8A3O2s
 m4dIXtu9V/jAuaD2dq9MyyMp88uxJzcrJRF13jPiPfHZUrCZ+B1ql477EyAzk9yc39Ae
 6AcJeeHCyUMrZmMimxNtFzECUg+SHNJ4Q3NjEwVuD6tc9W7MVz1ZWIiRJdol8xsG0xtd
 KFmg==
X-Gm-Message-State: AOJu0Yz6niMG2M6nP/x4z63t2cPtlKRPJi/T7ryrlIRIn5UFdGUBQGag
 +l6GEhFlLvd0a4UwUAZurNDuzMRpNRqmyAUrnZ+tqHWliJN+56Wg9cQmV0hOhM33swrwWNM1it9
 Wm1hcHJiFKe9//TJPRg4QB7XaLCfdvn0Y8g4C5/ASBVNun42MfH1sBYyE+F4YBgUm77H/
X-Gm-Gg: Acq92OG5keiBktvJ0baex0uIDHAtXIFE+y2qAvpGo6lTMH9RsXvUH5ElbI1+eh+YDQt
 IrWyOBKyc5tAXkcJ1tUC5hNm3RdpqRZUtrU4IyaQ5q3suthywntDMg6vmyGo2sBRt/V9RkW+daq
 qd1VGeUJ+8VXAZMDNnrdgkvDDWU3C/9eXUUmTaxmrMOOs7RQ4ZTyWtSYMqs8XOpXtZxuKtc5hYr
 bXz0lvuO2wXT0eEe7Y6Xra4cBcpyNpfiH707fEf9uzmlQOCYoCj1hXeLOMKzeiFOyinrs9xKOtg
 pfvSpAlN8FoDe5ojBJ1FaQby9Qowztf9/zfwSuUzs3b9/o1tKChE1LEirzMq8+QO2uec6slkwx2
 BngWnqc8Vhx1Lr3sJOPD5vKyehxznyI4t3IfkJHoxjVuIRhUOtLQ3ggPathj1F7K+oONEwYYNZp
 HL6FuUK+k=
X-Received: by 2002:a05:6a20:734e:b0:398:6ea8:21f7 with SMTP id
 adf61e73a8af0-3b8b624bb73mr472898637.15.1781632404078; 
 Tue, 16 Jun 2026 10:53:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:398:6ea8:21f7 with SMTP id
 adf61e73a8af0-3b8b624bb73mr472869637.15.1781632403638; 
 Tue, 16 Jun 2026 10:53:23 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14537865b3a.54.2026.06.16.10.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 10:53:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] add a note on -shim to direct kernel boot docs
Date: Tue, 16 Jun 2026 10:53:16 -0700
Message-ID: <20260616175316.264758-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616175316.264758-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616175316.264758-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a318d95 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=wLZQiVpf1cABdgcX:21 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=t5O8Ea2x4ZgTwSGeemQA:9 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX3LRvHECA/sNn
 h4x3xaHiFs1OKheC5ZoSvX++mWtmcNLrY7eReaXi5ZGOlJ+pMfL0PizFOWcmiK84DkiuVd7/b6F
 uiM4tmc/Sw4W1X8FwmJMeKVjWFFO97k=
X-Proofpoint-ORIG-GUID: eP_Zqn4eSwCs0BKQmxfcExvXbhFj9_Px
X-Proofpoint-GUID: eP_Zqn4eSwCs0BKQmxfcExvXbhFj9_Px
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX5xvgubs16cTP
 ovd44QAZmC71y4EZXhyO4kDKbVKMSn8cVoiS7PMsZheHKE+l2DqrJ8LGzEN8qmzJetQ630ROVgJ
 CnP3sNMk4r8d2u2fA4e704pSSl5z/6VVBYPVPcl/CRp0DyOoQMsd92lEPcI392aXuucUZ8KEHm1
 pugypRxKof2r4rLj5VHibs2x54iZftwB59hu/P1GZN+8AAp9Nn3FwHncZdO66w/rm0UdBDfSpIY
 dKT679ZL/81o00O6WgIRvoZeIDyk97/RrBiUXn4O/qDrMZlt/44MRDAzhSZk8UuzVBz47aQRK5B
 qD2r/MTouaBH80RWYHH6qtYBi917UADf2tYgPXdrsCYYqxTO901E5U4Ar3CJ5AEBGfpkFKGzHXm
 XNoaNgpMOW7ur2P58jIRIQoYUOQMFsXMPx0bDwrNyxBUkY5FqZJtAFDohdGUfDA9HXwm1QrfIDv
 a3uPZ+bStGLeE1P2+6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160183
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

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260612161707.158029-1-kraxel@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/system/linuxboot.rst | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index f7573ab80aa..b0fd168bad1 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -1,4 +1,4 @@
-.. _direct_005flinux_005fboot:
+k.. _direct_005flinux_005fboot0
 
 Direct Linux Boot
 -----------------
@@ -17,6 +17,23 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
 give the kernel command line arguments. The ``-initrd`` option can be
 used to provide an INITRD image.
 
+The ``-shim`` option specifies the ``shim.efi`` binary.  This is needed
+when you are booting UEFI firmware and using the ``-kernel`` option to
+tell UEFI to boot a specific kernel image, and the UEFI firmware you
+are booting has UEFI secure boot enabled.
+
+When this option is specified, the guest UEFI firmware will first
+load, verify and run the shim binary, which is typically signed by
+Microsoft so the firmware accepts it.  The shim binary in turn will
+load and verify the Linux kernel.  The kernel is typically signed by
+the distro and the certificates needed to verify them are compiled
+into the shim binary, so shim and kernel must come from the same Linux
+distribution.
+
+Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
+distro install media.  You might find a second shim copy in the
+``EFI/$distro/`` directory.
+
 If you do not need graphical output, you can disable it and redirect the
 virtual serial port and the QEMU monitor to the console with the
 ``-nographic`` option. The typical command line is:
-- 
2.47.3


