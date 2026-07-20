Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1CCC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0j-0000B6-9R; Mon, 20 Jul 2026 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzm-00089H-He
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzk-0002zl-5Z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6cPb2962635
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HRRIAmfrPYR
 cVqXdfY5buNPRm9g4xMiYI2HH29jTpLA=; b=SjOxo6N+njiYHcNo7WBhueaXdY5
 Qpjn9M1w3/Ppo/C1KhNvPCPWJpKQuTcHawz9obiMuC+gTA7eeumv/xt+0FLYy9j4
 iQxg8ggIhaYzYpm6A+sHups7D3Gg5TmOipNnz/ImLt2f/LMM/vZzbiP9pjolqVRV
 elevoFfY2hTrrS97XiUUSMeewKU9lfm0vLXBWkNvtzo/nc0H5EZ2FwUnEOaUhCQg
 5wz2K8zo+51Y4ennzKrKyipv2W7UgK4O1/cQtauRPecc+3sWqoGyQJqn3V3B/YOg
 snwg2Ni3C0WaKK521Btlids1aAhAwmQbD9zum5I64+B48ZmtKwuLbVfd1MQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y2789-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so15705917a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569284; x=1785174084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HRRIAmfrPYRcVqXdfY5buNPRm9g4xMiYI2HH29jTpLA=;
 b=CrW61kIB4GkquY3Po8kVuzMAAGTqTR9J7amLs8fh9REUiqP2IJ+pv2jyrLuS5L0PiZ
 oed7Qh9UgP5rKwtP2ltOimpF+tCAkP8Qyxdc3tAu23iJBWTIyb6Mm5XpslSnzBzSgZ3e
 3HlbzRL9VPIGcm3N7IRXsfBhNEelM92WLMYpzBT1Y2MYvluPRIBVvIBgZu3haWI/F7VL
 GZX5M4loQw5XzS/H0wMfWsvLjK/BSXfA3UI7CqUdu6g4xFD6CzKmAjYZ3VFqujEyF5/A
 V9pSunYEBOGglddt3IZ9UwuilH6Tyfh2WjpQfXP3DH6egCLfbgpug92I27D+EvHVGVjM
 ibJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569284; x=1785174084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HRRIAmfrPYRcVqXdfY5buNPRm9g4xMiYI2HH29jTpLA=;
 b=OI3XHFaXChvjkDFW8peEMBS41Q6GydkBSCZx1nTCROL9rGbSUj2+iuP2BiveoLjtiJ
 OInR8bl0GGTB5zXEnoacROmgROceyvBJZdpBrQBGmIleLT2svlTnFK2FGztQtPprhk8J
 6o0vf/C5LyWxHeYoShzawY2Q6HUb6gPfTCarUNDCirOgrCUG+PjRLQCg9wBtnTVj3+ri
 8hLohS1ic7iiUNMhmSvC60k6KLsjVI+mVEtPTRj91sDi28o8Jhu4YnVcGxYdQ10ziBUS
 5VKKBBfB+V9DE0H0yTu+YItpXKQoNDN5loMnzqwrV0fRtBcJ9GkpDpaqTOawHoprHnrX
 hKHA==
X-Gm-Message-State: AOJu0YyVazIRYPo5rlJ0WrC7wBL9VGG1Fjtr9Q3OEJqxdNPpi4jREH06
 T+hbOUNhwiOKvm3EJzc8CDfP1RRgyc3/ONP2tt+JqJ0YovzMyYVfzeB79R6BRm+Jy8HS8NViViI
 VB/fL2Y+AFdizbClFyyXgd2xMu4zYmGZgp2bl37S7N3kkq5B3kY0Mi8ppGm8/A1Dx9g==
X-Gm-Gg: AfdE7ckE81vx6nPIuv6JIaOLn9pf20Kzrn0QoVESUCESjNYXczNV2vXnapun/A4XLX1
 gLW4WwzLLguXUEwrU6sbU1D/boLzAqmphUw+7hWxKmZdZ1ppVE+Ciy9BLDr89NhA7AZCq8KRzzw
 vkE9iktjDffKBSAa2Ue0TFpYvmZd+lrKv1hlcfTAfEq9Z0IpFam5bYHWV94iUjC4lE+EbdPUJhI
 b/Tj7LcfC7i3HGgvbUtsr4xtz0oktE1V48WYd88k99tF3Gny6UFyl/k2VUMboNOmLsUPf3yiuO0
 GGbtacHsJJ+4hHIHiHw5g0Nqw1LHKpOux4NjkdqgEZmZyibmPa4aCJfH13mV6BXByfln83ndoLw
 ynaw5MIGn+znE0qZpJFcijaqNi7WleV11YEWXZvzxBx3imN3eqQefJwZr+porcMg=
X-Received: by 2002:a05:6a21:9d84:b0:3c3:a5e4:9141 with SMTP id
 adf61e73a8af0-3c3ad66b6c2mr16011414637.18.1784569283809; 
 Mon, 20 Jul 2026 10:41:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:9d84:b0:3c3:a5e4:9141 with SMTP id
 adf61e73a8af0-3c3ad66b6c2mr16011383637.18.1784569283357; 
 Mon, 20 Jul 2026 10:41:23 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:22 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 12/13] python/machine: support routing semihosting output
 to the test console
Date: Mon, 20 Jul 2026 10:41:08 -0700
Message-Id: <6d1f197c4ac837afab013a4de43b64dc9e3ffbcf.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX1OM0OINq+XX5
 F4K3pgeJqwY5/Xfi9M6Hepv0BpSTMUhzmjemFmuh4KH65JqW+T/VkbfeyWigCtx3sb5znoEy1T6
 1sd9bLzZO99nW9FmNPAV/T9x10iK4Fk=
X-Proofpoint-GUID: O15Eb54bpzxgPW2aA1u7xOUOm2Y3phCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfXxV36Q54Qi9RB
 Dmargrjy4LEDwMFz/D00qxjLOOP6Z9TKAI/o6iEQgWPnEdqoDp0b+AS/8R2rrgZakdy8u0SrjWF
 3rPxJPyW/5yI06WGbpGe/nOTqz00o49V2IHKvm5b3CcdnzDVbQzfgmAGxWkwrvM1m0NihqgOcaB
 Fhkbfyow9uZUqHQjlKW2DpVD3zenjaK55G6fqsuXcZFMOLboppSmRuD9HY5BZoR75ZhSNygRrzo
 Le97+Ax8N9WCvsbDyuLYsVqq2l1Zmo+Fj5aPzktLrIBpY54yXSwP2tUtRDDgFAN87eja4lbZJyh
 lNkreWxBnqIIBOWAF0Lm8ptvCwzZitUsST6V4rdmstGz5DWX4JXFuvi2e2uS2V8qsFVYjhldaUX
 Qcs4wc89VY+QUgfN9d5p2P2ddtvsBY9F9EEmU1YeNMJYzvlKGqXlgA2Ss2W/xLPbVu30IvOJgq+
 868qhSiYJgVplDYbdqw==
X-Proofpoint-ORIG-GUID: O15Eb54bpzxgPW2aA1u7xOUOm2Y3phCQ
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e5dc4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3vhqsrBKo-Q0muh1UiUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


