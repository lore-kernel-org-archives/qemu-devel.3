Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E1606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DYQfSG9v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q0eZXqj1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrH-00047C-BT; Tue, 27 Oct 2026 15:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqW-000385-7k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqU-0002OI-On
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHSiC2945866
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9KU08PS/7KfI/b/b6CZXjb69XBndLwgQXJZX4cCER6E=; b=DYQfSG9vP5JvBZHa
 43DgylTEXH6R0ahGLf8IPQKKhGYQGLCG4iUe/8DOXai/V2d/BY04GCfS95XWuOEQ
 KYZImcA2Pdzv7q03zOuuX1qS460Wb9ehJpCcsOoaFTrqS5jOHK2rwF9kSX5ohJ2m
 cPvijdSCINmZUDwNc6eCpWkee965GZzvUAgjSsr8HmQGkHb0oQ9PjnRtovKZ3aM3
 UCzQicivMw9zaZBJMx+dN9KtoPOftJ5KYN7UOx8/x57DH9PxamGF0ozfRJP8GD1e
 OyLdDqMQsevaq8Nf7JlDowUphEhWABjHL2lNaMH2v5/EMx3y8qIKxxb2shc++yRs
 57DW/w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6apnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ce7a85f04so27825585a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129309; x=1793734109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9KU08PS/7KfI/b/b6CZXjb69XBndLwgQXJZX4cCER6E=;
 b=Q0eZXqj1XJRN6d32Z5J12hdC0DMHAm1EjrW6Ot+2W6Ro8vr6GQaJX5snRNHdstoRaH
 Icp9dTYwrI/WZ8YXiu513H54fv24XoI6fdlIod7YsHQPXkTnQSvm3oX3prAnWaDJwUxy
 ApYY2A6KYDUmIpu/XB5LalvTVmuFUh7/dgoxzkFiJOU63i44JNiBwuw4OfnNIhgLpMMw
 U0ThNrgbEacaDV9RUHcvcUklZmr88rNRBYo1k3A3IV9+LeRXhfPEDmd0j9VrNvMvjvQS
 9/xxtseO6a0j1x0nlq1MCcujvHouzyj4OGQ8F3+gOluv/xbaXVInQI4NdFPgJ7mldBJ2
 TR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129309; x=1793734109;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9KU08PS/7KfI/b/b6CZXjb69XBndLwgQXJZX4cCER6E=;
 b=Jnq4wV+pUSkj8nOveXnobOjVFBFfWkcfdHIW07BMxWIRTwIy/pABqEjto+RbO8qXkp
 6mCSWLn2F+ezuwFKUlFmJW+yYWrc55Zzt5iazAWoV/L7vQ9tLH6z7VTu3gLNCHQ+iAXQ
 kV7UqQGCR57Wx5x7KZc0z1L8Roj10VuAmW8ylucDfBv8ubxC3fLF/CvqduKANWVNoLon
 XjytK9CvKrkK0BYPJArzN+35MFqPQohVIJhanBo7QA2VsJi7Q2PBf6DbyqK4wLwpmsg5
 34znwCxMj2PM+0rbetV/s/safmfR/w0jlSOx3OMU4Bt5bV9FUZxdVs/e8SLtXTOL9DFE
 wevg==
X-Gm-Message-State: AFq9FYJlcpM0v4znD/aBWXCziNLcBpgPpPILRL8Kb3l2DtQU2yJNC3iK
 S/tAgmgJ8Hd7Xdajiw5wio4jOweQNATThfbx+hlkAYgBT1FFbZfz4z3uFd2lLYmpiB8RZIhe+y8
 QmehiuEfjS3wosUmOdTeRyM8b17e/DMLSysLiybKANYwNXkPOwTXhvwuBmAK+OLkucQ==
X-Gm-Gg: AYBFou1+aSeoKzmKCGDma8b6Ar1EqY2m9IrixjBZuwEJYqm/5lviqvQnuoT8M14QTAj
 8jimg4MUDkHudPKGBq/SPGsJPEt41ZxIEvxCO1UideiOjR3Og9WkI78piy9s4l9dDRFbBFSGEG+
 Wqe0pVZ29PJQL8MzkNrt0WJbjyXpoxc45Kjs8ArZbeubgLpTs86BFd14ScnsX7SMdFbGHNTBAjW
 t9UqdZXQvGDmrjpc0X59V9GNjsr5eF1LDyrZhjYReF1NIq2/QvFcCd6rGXOcNW8l86iHh0Cf2Xt
 ValR54FqvT7ytP9ykvBn6cM1IKaOlAre2AWr8wcC7kNe9H68eWZ6SUHBA8NZckT8Wy1ZytaCNaD
 JROi2KQ9ov1Z3x8wqW0DtmOuf1WRXvtUKFtftv6COsozUOcV81KWnGOlv
X-Received: by 2002:a05:620a:6887:b0:939:6dfa:48fd with SMTP id
 af79cd13be357-940ef96543fmr1659258985a.51.1793129309246; 
 Tue, 27 Oct 2026 12:28:29 -0700 (PDT)
X-Received: by 2002:a05:620a:6887:b0:939:6dfa:48fd with SMTP id
 af79cd13be357-940ef96543fmr1659255785a.51.1793129308718; 
 Tue, 27 Oct 2026 12:28:28 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c021080sm2980055e9.2.2026.10.27.12.28.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/59] hw/usb/imx-usb-phy: Avoid casting from void *
Date: Tue, 27 Oct 2026 20:23:23 +0100
Message-ID: <20261027192341.9197-43-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0fb5d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KWf96nYnDwajBr6vBR0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 44al81Zz0ag6QjIroHeCN4bUkblIenT1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1ETr7TSBYtli
 /iEYUkqfbotSPMGbm9e7ts0sY/hgaDwGLddMg07N752G1cu8jAl2psgj5kBwQ+PwFkdmbO2UDLC
 jULRE7vVuMTAo69hKEodLSp9NwOsLeE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX2ajBi2SQhjl6
 CTSmJveO23oHInLh8e+AzN2nDSz/uOXBu4OR1CHELhrIkC6Q2KpmBtCD7JrvclcVavdsiVG4tnm
 VFMdlzOL5RJxDulb+l3sUT3abEURMCoAXeZPgn2jmkQ7fzGRHxHYHEpzBmB1IhWgmD8rFnywrCb
 UaL2jAsEzU8Gm89+UsQmdG5okcE9qzI3gyp2kgxSy2//tQvUY/zN8Z/2N3QISu+EFPp20d8jK/X
 QhX6kUYY9T2lkaUHbDw4KzEu1QqywQIk+10TnzGquY1yhyJHWzQjyn/Ua894ZY5fj7Ln14A7jnL
 D/ug19txL/zRifKuuF+k0YajT8bMlharCKxp71VpBM1+5oqC+r/+R9YbZ1z2fMzIqhb3QlwqLmD
 xKb+P6bcQjO8nDkyVAStfmXkyqawvApfyhe+eS1yzLKIPFPXkYvH8LiBa2s/eBHJ2dtHfi3clCI
 +weHTGtRqlK79dMqnSg==
X-Proofpoint-ORIG-GUID: 44al81Zz0ag6QjIroHeCN4bUkblIenT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-40-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/imx-usb-phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/imx-usb-phy.c b/hw/usb/imx-usb-phy.c
index c25566d0fae1..2b2913c38751 100644
--- a/hw/usb/imx-usb-phy.c
+++ b/hw/usb/imx-usb-phy.c
@@ -49,7 +49,7 @@ static void imx_usbphy_reset(DeviceState *dev)
 
 static uint64_t imx_usbphy_read(void *opaque, hwaddr offset, unsigned size)
 {
-    IMXUSBPHYState *s = (IMXUSBPHYState *)opaque;
+    IMXUSBPHYState *s = opaque;
     uint32_t index = offset >> 2;
     uint32_t value;
 
@@ -108,7 +108,7 @@ static uint64_t imx_usbphy_read(void *opaque, hwaddr offset, unsigned size)
 static void imx_usbphy_write(void *opaque, hwaddr offset, uint64_t value,
                              unsigned size)
 {
-    IMXUSBPHYState *s = (IMXUSBPHYState *)opaque;
+    IMXUSBPHYState *s = opaque;
     uint32_t index = offset >> 2;
 
     switch (index) {
-- 
2.55.0


