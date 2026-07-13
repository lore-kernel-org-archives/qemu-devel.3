Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F881C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwW-0005mT-JR; Mon, 13 Jul 2026 16:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwU-0005lG-MD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwT-0006Sp-93
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9Hjm2470641
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FrqABwceldd
 9k7KFygIJuTNC7prlCBF8KUlijNOImFU=; b=U4dFjO7WWVYyY5pR1XIEyR/TUKk
 370Rc3myxK1gadcCFcZVqAyfITCm8EZ4jPYkjs7Ii95eyx1oXypFiTZ6rredb+Em
 NhNiatRev318b7a2h6yTPkHjKTUDjrTkP8K+xGXtQePAezK2OqtbpPs8mq+19ToL
 UtUveINwBfitNYpGIALuXc9n5kTCptMXVYqssDMdmxYs2RKM6+cldUF1+TRiS3Pc
 UqojWNwJcPHpexrvNQ3akj7/YyLnmkpdptMYhm89Q7ayCgJrpWkT5/KBEUqoIlvA
 XDYCsOdHR1zBEpeVllbdXqnfddjRqgGjLBXANaBYF55y0nqiSEnrwndrEDw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jrmf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso169121a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973261; x=1784578061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FrqABwceldd9k7KFygIJuTNC7prlCBF8KUlijNOImFU=;
 b=g7rlT0VtjbwGJtUt+CubePJiFpAofV3uRUpzkf8AXL1+V03g4A34uM0tfXrq6p3/W6
 to0aS9DA9MOtUZnTHBm9X8Xld9cx+2dmw8j81gvNV4uHJr5HzwbiS3TEobPiT3XPf8ER
 EbPYUK8Hd5/3RMwRpyyY2H4wGBbW2vXhxAhwmko8oABKEy6v0y/8twxOMqrhsktE5Jfa
 akBRusy2uUXvVlLzPl9tNMJ0qxsnV7BICTSh4aWXgqMcPWkxavw+W0T6Qwn4fXivQGkF
 H2Gyi9zSe1TXqutbPMZzcqetL0oKD5SkWiD59KP5V0SnFv8Pz+lYRFVP98usWcT8w3bZ
 BOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973261; x=1784578061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FrqABwceldd9k7KFygIJuTNC7prlCBF8KUlijNOImFU=;
 b=EnwFcvmq+9PwdJMN2YsCGDC2J+8FkvhnYgDrUoqvcQ/wlIe4cZBwDLuAj0RRHixu1w
 yAlLkXBkMB/2B/CAgwpY1z65WeEaGe0mA9iqvaTdDqIhjVjArKKr3vRDRZBUtpGQ3aQ0
 CcjRw/y4KlhccrY3GuwBIHR09EzggFiOg4EeTm8XfSa0zpNDNkRd3YDNMfT9w9U5hO9Y
 O+sN4/C/SsSfEzyWPGz3pEnEM0EpV4YepgvAlLYieoFftcXFLv/mN6vpwQ6UDT1vbLnz
 3aG1pNivd2maDVLH9gWpQIsUdHJd7618pz4FBgvmvgss5ms45OpWi7Wq6WvHOuD+95WA
 yfug==
X-Gm-Message-State: AOJu0YwFXUIqic4IK0w0QmO6TxM3tN1oTvPEFsqx/cOaHwMK1NvMtSHt
 oaEtOKLKU74duVtMY1WbhYtxWxz0KcrVxwCfdwF76OyVLoMy6yq16+bDkFg/DE4c8ORlG/110zF
 LfzsqrR230FGabExAhra8mjOIXsypj0nqC9UFE6Z2seTAkNflk8PYE6Ai2V1Y0qCySGB9
X-Gm-Gg: AfdE7cmKEA17IrNb+BAwoE1wOnlHhKMC9aaKJ81kW4u7kfVcfRO5pV4tpuikJcgMtwT
 Jhx2JW0qxnA6M312keZ+6766CFWSU8XGeGhDDDniTmwmRpInh+sTritCTGdRToqqgCYD62JlSPb
 E68q/zDub/RGV7hmZA/8RuMuvKk3B3V9chaKwRxW3S94fFQF+EhPJ9wR4UHr1zroiEJ9Cr5Bxo2
 XnoRV4H6USa7ZnDgUaq4djHGwjoQl7IzNrRpj+tM3anSP0zWjBsIJzCRdNZMrAyCqYsGDzXNgMx
 e0v1lEitlpAUZY8xYGDRd5etVwm+W9AjDWXeYcfhzg/iBP3IJRxVNJiDk1igaVWOyN7SuOVXhOg
 jtBHx1wL6rlEAHgnSlw3xOceYHaRlBOwCG3PDBsyulPwJbrjuK7JupSLDYinMnpvfty7n6lNsDQ
 ==
X-Received: by 2002:a17:90b:54c4:b0:37d:f7fe:4bbc with SMTP id
 98e67ed59e1d1-38dc7779e2bmr10121682a91.21.1783973261392; 
 Mon, 13 Jul 2026 13:07:41 -0700 (PDT)
X-Received: by 2002:a17:90b:54c4:b0:37d:f7fe:4bbc with SMTP id
 98e67ed59e1d1-38dc7779e2bmr10121654a91.21.1783973261002; 
 Mon, 13 Jul 2026 13:07:41 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:40 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 13/14] python/machine: support routing semihosting output to
 the test console
Date: Mon, 13 Jul 2026 13:07:21 -0700
Message-Id: <c366abf87494e1ccb10435028a9aeb0fb8362dfe.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RCGRrUrSSwle9jVJlJqSlPsxUEcxgZOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXyhJ86qj7GjT2
 QxWeKbfbVxhUOWy1rLq+/ZfeDZe9Mit4fr1UjgFW66aY1C8iVXWiHFW34rXzD69Jz9uENuW7yKr
 Gc1T97TQnZTHlNSkRcz4jRhcqp6ks5qSEYV1Fp+LBGXqTgyDlwSRxFRcXDQYgtNEh1w6RNooQsB
 ye4pgyDLWtk+DPPStTmCv1I0EwhN1s8KFpj8nlhsGFm9t8tw2nWmnM/RmH0y3VCpZMQzTTXePBY
 6V4yjf9yTcmmGlpnMwZaEz+FmRLxZWcWuvq3ElFSu1E2gex+APNkONa4vDr1UwXmlgantI4TA+Z
 CYJN4Tlu/MZbcsDCbHT5PlTZo5/7VYJ2FPgkc2xhlRN2wtIT1WiywPW21qhkrgaZK4cOJTHRDPH
 yr5ofjJfXburn/OC/eCfkx0IS84sTIiyXa5VLnCaBy4+6bevuMbYMExXVWdADXQ+fm06ECOKKBN
 vmFH8M7adOtmfHRnzCw==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a55458e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=3vhqsrBKo-Q0muh1UiUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: RCGRrUrSSwle9jVJlJqSlPsxUEcxgZOi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX2M3ztfatPYR7
 yKuSVJbIwh7Mgk+vio5XWLTrErUeTYrQ+7pV/l3QasnUjtOZP5Iu3Vr6lSaaiiaeYfjBbHVwVi9
 NpBACCUIVXB/bNKrUR3jFWzYILTpEkI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The hexagon semihosting systests will wait for output on the semihosting
console.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 python/qemu/machine/machine.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index bfb59d4c0bf..39375065558 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -186,6 +186,7 @@ def __init__(self,
         self._console_index = 0
         self._console_set = False
         self._console_device_type: Optional[str] = None
+        self._console_semihosting = False
         self._console_socket: Optional[socket.socket] = None
         self._console_file: Optional[socket.SocketIO] = None
         self._remove_files: List[str] = []
@@ -321,7 +322,10 @@ def _console_args(self, interactive: bool = False) -> List[str]:
             fd = self._cons_sock_pair[0].fileno()
             chardev = f"socket,id=console,fd={fd}"
             args.extend(['-chardev', chardev])
-            if self._console_device_type is None:
+            if self._console_semihosting:
+                args.extend(['-semihosting-config',
+                             'enable=on,chardev=console'])
+            elif self._console_device_type is None:
                 args.extend(['-serial', 'chardev:console'])
             else:
                 device = '%s,chardev=console' % self._console_device_type
@@ -892,7 +896,8 @@ def set_machine(self, machine_type: str) -> None:
 
     def set_console(self,
                     device_type: Optional[str] = None,
-                    console_index: int = 0) -> None:
+                    console_index: int = 0,
+                    semihosting: bool = False) -> None:
         """
         Sets the device type for a console device
 
@@ -921,6 +926,7 @@ def set_console(self,
         self._console_set = True
         self._console_device_type = device_type
         self._console_index = console_index
+        self._console_semihosting = semihosting
 
     @property
     def console_socket(self) -> socket.socket:
-- 
2.37.2


