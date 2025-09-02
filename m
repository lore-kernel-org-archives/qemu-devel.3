Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87F9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0S-0007Ic-S2; Mon, 01 Sep 2025 23:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI00-0006sN-TD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzz-0004VT-BZ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RpH6030092
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PB+gsVFwzwf7f11qN6KVA/bDQe2E2WJjPpsFSFYXm+w=; b=AM5gxpfgb0xOMbLX
 uYAxmZX2+F7gkY1R+QeXoPJFhPA/7NLSPsekmLBgd2tnuUf51YCM44aYjdGy8j8U
 Iv70QzITRv5z45cKt0VfTWSgjyM7P2RDXZDfA675qVDZV/EjE+q9Tur5zw/HOx+z
 oMXxgW3hxk/lvicw9NCojsFjJv8jBOmhozKPmAOEbKoSYeQgtNTZCkWu/HFHvhJC
 yI+ZByeXKAYZRksmTVrJlEPdpix2010M6Di2r+tv/YNNH8iKaCzgaZVi9imoGYL2
 wFsWLOtnouzuLZpNqVYxf5BWk/j5g4OkEfcxYvw3EAAY00AeMy8s/HdU0Ny8P551
 VBE9VQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xafs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24aa016751cso22352635ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784874; x=1757389674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PB+gsVFwzwf7f11qN6KVA/bDQe2E2WJjPpsFSFYXm+w=;
 b=Aw+L+E23dNDU3jCUSWEwXE3bf8JwONYUbstRY7/HrqQ6XqzQShsm8C31xBa5QvB6FZ
 3nEjcdedd1o/a/tWKuukx8KqGi/XdsfW39nJFCWf1oBA3GKdCmYx00ZHDdGQ4S6EcEOR
 3IU8vK7eRk5Zs8xUWnh6LI1BTEfvZ29assJXnnK3REiNmO56TXBz5I2KO+LyMqsx+Mji
 a87+up2uCZ3xEyKfXmbnK0Jm7x+SxSbv8a69YJ+bIP9hkI2JaZnacaktn0NPG9uo0QJ7
 eoS4LzdGmKJPyKlIJR3ysPuJK1m23SY37ri1k05qYDIZ+uzXSAqcyEx1dlFVEFflJgIb
 PEDQ==
X-Gm-Message-State: AOJu0Yy9jUNBjXoUmgNwIcOYrOTF5wJqF4wD9zSZxZr0bYphn+bO9kDk
 byWv0mncQUk4DwmcLbfTa/acqeqS5j1PVQFGgplzQDFnMZ3jT4TAylK/FiGsuFmSQil/7T51DAy
 HDYY8F2b9Wpt/ySTWuI0zgFkkyo180GDedWD4HqusoDHB3dDLWY8CH6YU95n7rn0L8CVX
X-Gm-Gg: ASbGncvy4V+FHyGNW2rTvl8EIQHWQuuE1VK4mOeuLxCabIn/VmdOAR59H+/PkIzznDI
 s9ENgvw2CIvVMkov4l2rr11yPAsaKCwNbPH0uKuyTksqj3JGG6jQT4NIpbA/euFSvHGxZ66I788
 xLFD1lWQWCu6QX95G6+ZsWVAomL2LOmtcC8z1cHQ7C7ILXKqX0bmJPO3/e47LQZxl4I5cmTus+1
 /DxHQLnbdtJAAz/zIBe86kcLgN30fu0RM00uww45ot2VXQVDPRGHfHfVeNOzKPX/i8gzxsBLLkf
 dkRMkGs/3HFTYf7fLTnlnSxGcK/4CLhoplsY2XFMfZnTUHsqE2J8XMTVkKC3Kz0wctXvC+uhht/
 ndWEObJPoUEIc
X-Received: by 2002:a17:903:37c5:b0:242:9bc4:f1ca with SMTP id
 d9443c01a7336-24944b71133mr123343435ad.57.1756784874270; 
 Mon, 01 Sep 2025 20:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYVxy52nLzOa6kG05xi5B4iH3idKqKb5U3JTGrqga52K9FMrwDB9PP1DuEIWxPrKUkFg0zFA==
X-Received: by 2002:a17:903:37c5:b0:242:9bc4:f1ca with SMTP id
 d9443c01a7336-24944b71133mr123343145ad.57.1756784873814; 
 Mon, 01 Sep 2025 20:47:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 27/40] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Mon,  1 Sep 2025 20:47:02 -0700
Message-Id: <20250902034715.1947718-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7vPFSNEdKcg6
 m+Iq/l+Z99O40poBAWtK3OyRGdjNNW3m77oMX4nNQAXjHCpzvC2pPPJfU9tzZMIRixQ1+u0P8jE
 rdjqrekLsS1EnUKM3IPngw3xXC2nr+GySnsutuAhWOBmRYca1b+avrUZNWS8+yMjkurDExLZm/g
 YK9OqEZBsrbJ7l7zj7j9x5QFbzX8xPZq/Jkl1Zyxhn1GdpZM8tz/x3prWA33lTQZBioxI8HRwCE
 vmwcT+Dm+aiPwVeLMGN1C9CFlLcHwQs7YYedYqnhhXDWp/YQIBNhkUSbgfhwk9knY9gZXDujF5h
 mkQr2sMWPNTHR85bVsfA+rIPiA/IAcvD3/lxtqAyKS7GT9pCbxvpcB7l6Ko+xgzIJtqbZ1UkRCc
 bcuKzqBU
X-Proofpoint-ORIG-GUID: n3UFclAPfxLTfP-zYAWvT5fJHhpXC_g8
X-Proofpoint-GUID: n3UFclAPfxLTfP-zYAWvT5fJHhpXC_g8
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b668eb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XEQhwl2E1R9O8uVTZxoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 009b71f8e6..39451e6d88 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -129,8 +129,11 @@ def calculate_attribs():
     add_qemu_macro_attrib("fTRAP", "A_IMPLICIT_READS_PC")
     add_qemu_macro_attrib("fSET_OVERFLOW", "A_IMPLICIT_WRITES_USR")
     add_qemu_macro_attrib("fSET_LPCFG", "A_IMPLICIT_WRITES_USR")
+    add_qemu_macro_attrib("fCLEAR_RTE_EX", "A_IMPLICIT_WRITES_SSR")
     add_qemu_macro_attrib("fLOAD", "A_SCALAR_LOAD")
     add_qemu_macro_attrib("fSTORE", "A_SCALAR_STORE")
+    add_qemu_macro_attrib("fSET_K0_LOCK", "A_IMPLICIT_READS_PC")
+    add_qemu_macro_attrib("fSET_TLB_LOCK", "A_IMPLICIT_READS_PC")
     add_qemu_macro_attrib('fLSBNEW0', 'A_IMPLICIT_READS_P0')
     add_qemu_macro_attrib('fLSBNEW0NOT', 'A_IMPLICIT_READS_P0')
     add_qemu_macro_attrib('fREAD_P0', 'A_IMPLICIT_READS_P0')
-- 
2.34.1


