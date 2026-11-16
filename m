Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA8606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FOlD9o+W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bp/a+pIF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT66L-0002L8-R0; Mon, 16 Nov 2026 18:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT66K-0002Hh-45
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:27:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT66I-0002ef-Gi
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:27:03 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNR1R3433237
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XOlAif9+UeZJzVKcXQRPB55gCt56fpHNmcBcTHOnQl4=; b=FOlD9o+WvY3DaV2A
 A1FeIawo07P/fb7QknqeqmB8fOIfPkiqeandHSctW3995jaMy4Nzq9RXzC+fHMQo
 ujz8s48ySzodl7F4mEE/9CGSY+Mq0YKVf1LrCbEt1oOY51L7ocWzXA/U+IpNG4Ie
 9i+cTH1aIHBIaiTZeIT7jgIrKo1tKBMC6wZ0VN0lRNfiep/deXUUzZgMS8lzaS2D
 zCaXVDqxJ0dNPGX5IYfLUXPZ7uU/Hsrk/sBpwRQFuxME9RfnYrwKMV12zp5MtE3e
 ljs8ur3mi8eSkae45z0G3f0Ggv3Tuulj1c5naHjFg1blrSVlOs0rZdrpGgUZ7VdW
 FBFAHw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f82gab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:58 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99e0a55e4b4so647580241.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871580; x=1795476380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XOlAif9+UeZJzVKcXQRPB55gCt56fpHNmcBcTHOnQl4=;
 b=bp/a+pIF7R+ivPh0NMa1alMaPMAW0qXsX/nDSXbayMJZcn3lpAJYQS05tbi/Mylsvh
 AwBupZbZfgTNn6YEPi0/BtvbAti+5/BoSBYvwtGCG3exDAr1CjXpJMWVf596d0ZZtENa
 vMgX2GzBVKzwGUqqpA0xtx7qo8x2lysujZSsziQZFlkuImVj97B0NlvkVa2rWYsUwAWv
 7hFhhAPtzZLDIzPxfXReoRfTdm1JovG1gBI2Y/oVh/pFuTYSO3uXt6HWKmJCNmQq0pE1
 8s3UTbOaH4Ni4bUBJvMY4Kp3pp84D/ca2Uo6vEel/8FjrS82ipOOrQ3CJuAlmy1FkUxe
 DMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871580; x=1795476380;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XOlAif9+UeZJzVKcXQRPB55gCt56fpHNmcBcTHOnQl4=;
 b=o3CvEddvYIUypbUQqU4XOy1GU8enIFVHABP1i/bjCqc/X4m/kBzE2zCSQBUFL7wL3/
 cMPH4HkZZaFCnrp5VRYAzbF3oRIRTOFj+3eSRPWGoZOJSn+qlMHWJOFRV2IgR1Qv4qDn
 bUWmWTL7Ey2zj8iudpPPY/nHF+35cgBUC04TqEyhc3mg+s+Oz28gVT+y2Gv9FQ8detqn
 ouVN/f9ilQoGiDDNTvRah6dRN8H+6u2gAeghD5JgnrleThlybKp+mI6crbs1jRDVbnMf
 0IWxlzuBUzNWQ7bCkFsyTuXYXzzZ4wfzZKwINJ2UP0o7b+llZG3MrxhibGqyMoi1Yi5p
 I5UQ==
X-Gm-Message-State: APuU4Z/1get1vxwCf5WnsSgv/exADeA1MdcZIGIMmjm3fpTtCcqXR7z4
 9iwfk+juP0SyEq9ZudYOZZm6rQyg7/B3YXwdBpKK8QsumRf/nf9cLaKDLLd5sc2Z/020QRRk65H
 2JrcgRzOVuLlVTLQRZGGAewmPEpL4VWwRU8KeI3YI3eFSSMAtod7KG1fdL+WL8EdG9A==
X-Gm-Gg: AYBFou1X+66mVtC2haEDdi8FqkpxdvzjE7UFSoFkJyQL0hgqTQcwySaJlbwL7xxgcqJ
 uhKoyJcVUisWQ+BAbrgDFZB1psLklLj3cYRuTXvo9Tik/59Dj+vkhiyTqrEFSOurX5KwDaWiamt
 2XV1O5PMdTAbomOEE/EKw2A+6NFRyqQvqqsc8aIe8OUFA50P6nlGNgzCZu/G1wHM6ytnNtxZuCx
 Vxrm1Px6juCbzd3+TxxShdYCb6w+o3lYrVtH/2xIaOMT+DZ8Esn1CHJ7uOpwGLTA1t5c7MVMmvI
 k0VSmwUL/g02nkbplMYnc/+CNdOtKvPAQ63ja+k7ONfeu2y3w4v9T7ObvHy6Ebobjm/4IslI20U
 CSwxcLIyNxwLcarCJdUGA2wKEvLrJT/mGOun0vgcDowLOi66Q+BdnUP8e6+wMn8w/p1XeeXlq5E
 IxMCsLJDDXhCi4zg==
X-Received: by 2002:a05:6102:605c:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7d64d7047c7mr3012486137.10.1794871580252; 
 Mon, 16 Nov 2026 15:26:20 -0800 (PST)
X-Received: by 2002:a05:6102:605c:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7d64d7047c7mr3012482137.10.1794871579631; 
 Mon, 16 Nov 2026 15:26:19 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7839c5c3sm22887905e9.12.2026.11.16.15.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:26:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/22] hw/xen: Mark legacy Xen backends as hotpluggable
Date: Tue, 17 Nov 2026 00:23:34 +0100
Message-ID: <20261116232335.31593-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX6gUq1ggnuVre
 7lQfoNM4r84Gjt8Fe5hE2maUPdUoHabGos4EOlYy3d2gcixZFn54i3PUbAktCVoJAJ+rUr5dHuh
 APcfAURFN/CVId/ZdxXKxAOrO4pjsDGLkSHJsoN3SoUgd3T5/mLn8pZEavMvnnbf1en8mf33xrV
 iWJfMbalw2ED4JU//SRjDFeeNJcFjpi4iX07sXN+LJZJJqXttDFrjqPGckQzlcH6LMHa24kd6YI
 nlflRsEWv0QP3rSFKtuwBKz/z0s6tDtt/p6uVrxJg8HSN+zpm0mp2MNAB7sL/UiBGmwrUhkC6od
 O9hTxZiC/mOBmdI4V1c118aa00+4SRcl+vzYtsyRPMWWHEc6sQBcYNOXaa21Wb5y0jXZa+FMa4z
 XTb1B/PK/lNtbV8kyYHSf1ME7jMNAPpkYNAw2K1LoD5pWe3K4Wqo1TVJxseKs9coF3ZmPhx98QK
 QBdv95f092w2xxPLOkw==
X-Proofpoint-GUID: sJTgeHmoCflxgNmD9SJIMPKS5d67t5sD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX3y0sRiW0L3Kh
 eh0pjzOBEmmaKOsfhZDg23sIEWBQRW1InS5SHE+2nAjWUfOH7xhsurbjbAiFzezzeTDnoal9k0s
 Z7wOtwC5Cg5XLtv7cxJe69az6EY6lIA=
X-Proofpoint-ORIG-GUID: sJTgeHmoCflxgNmD9SJIMPKS5d67t5sD
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb9145 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GyTj49Ovo5v0flL5NPUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

From: Peng Fan <peng.fan@nxp.com>

Commit 250e797ceada ("hw/xen: Have legacy Xen backend inherit from
DYNAMIC_SYS_BUS_DEVICE") changed TYPE_XENBACKEND to inherit from
TYPE_DYNAMIC_SYS_BUS_DEVICE, whose class sets hotpluggable = false.

Legacy Xen backends are created from xenstore at runtime, after the
machine is ready, so device_initfn() marks them as hotplugged. The new
class setting makes device_set_realized() reject them with:

  Device 'xen-backend' does not support hotplugging

Since xen_be_get_xendev() realizes the device with &error_fatal, QEMU
then exits. For example, "xl usbdev-attach" triggers this when the qusb
backend is created dynamically, killing the guest. The same flag also
causes qdev_unplug() to ignore these devices.

Override hotpluggable in xendev_class_init() to restore the behavior
before the offending commit.

Fixes: 250e797ceada ("hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Julian Vetter <julian.vetter@vates.tech>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20261116-qemu-xen-usb-v1-1-bff36d5b646b@nxp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/xen/xen-legacy-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 7977b527127b..bf4396c9460d 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -640,6 +640,13 @@ static void xendev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /*
+     * Legacy Xen backends are created and destroyed dynamically from
+     * xenstore at runtime, after the machine has been initialized.
+     * TYPE_DYNAMIC_SYS_BUS_DEVICE marks devices as not hotpluggable,
+     * so override that here.
+     */
+    dc->hotpluggable = true;
     dc->bus_type = TYPE_XENSYSBUS;
 }
 
-- 
2.55.0


