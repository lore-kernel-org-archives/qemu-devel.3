Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F412C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUv-0000ze-Ie; Thu, 16 Jul 2026 14:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUt-0000yq-MX
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUr-0001ZL-U7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSlHT3395667
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HRRIAmfrPYR
 cVqXdfY5buNPRm9g4xMiYI2HH29jTpLA=; b=iZG7r2+nXISw1/g90/emXlcwYnO
 jBTPRVwo+RPBSq0mfAHaDDEjwPC+dit5znGY83KFqGGltl5AXp6zY8bohfaQX7O8
 Gzf37we0uuxdaf1S8ca9SkDUivw8E9Qr/JJbzQOoACDLT+snweVmZjpsToWOfYiU
 pOJAnxObdjqlmHtnRBPHX7KNzm9ebDu6bFp/09BoLIDqbvqvBj/wY49Qx6crHzQL
 pz4S1XozS1zChOPiau7va0bNI4j8FAT2h974JeupPCbDmlXJOy1X0upVt35IZaWq
 /FD/SPvbJbCnDCfD1/NZVaqxHm7LG52fobL52t3uNXgR00btkmyvh2eAY5w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19f47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so7907187a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225264; x=1784830064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HRRIAmfrPYRcVqXdfY5buNPRm9g4xMiYI2HH29jTpLA=;
 b=J3eA3fbNVYPA5KzIJHzHGc+zPna0AjPQ6Sr9S3JX9EzGpxYpFZaJJ7FKXJAHt9P0qI
 PwqU4GiJQksjrscb83MLT8d3BUfkd13Oqxk/Eytv4/ibmYm1NkOoai5ExPwR4fUwKXkA
 ozHeYL62+wtkDBJyXuaH3kRRgEEdn/N8ah+Lislc8a2K7QBboPJYOCzpesd12Jl7wKE2
 /6WADdbymBeSy9ltVuabDTajGCUG+Ic6GTRJl1I7m5K7capwbt/1v/zDKvA55ARgewst
 Wvk4HWK+LiFRgf9/bEH96qEuUEPxv4Bqo8W2vHuwnN3LhxzbzVx0YCCDWkOtoKq3DKtF
 PHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225264; x=1784830064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HRRIAmfrPYRcVqXdfY5buNPRm9g4xMiYI2HH29jTpLA=;
 b=GqkNGbh1r5moT65Fbakr6y1feFYFKaL8hqxFm5YwyAUtGDnuIJYyK+ERGeFedVXj8T
 jeRGCgO/n75LJuVOkyraK81vUIsUECBtx5YVd98YzMam5C3TWB5xC/QQ7Zm1WADfBY/T
 K1U/pofldpz2coizb7ANtjorG7rFE9Q+uehASUySqhx/0BuTklr4p0wfTMNiaB+DVA6N
 xfPNOvxLsRBX3InfHqImwG0LahUcVfqDje/0bQgBoko3spDoEIq5GU8vY/BsH3LCty2f
 rU8Owk0eBsW8xNu3J35CalBmMeC0bREZj+Td1vjaFXTfqOLmXOpaYQ3SIj+Geb3/KXxx
 TOjg==
X-Gm-Message-State: AOJu0Yzbl9KuqJDcJNWUyY7JL8uePVwEybt0lbyJCYN7PUNJbZKKYi39
 4vZbaM7O8uMXxyF/l3cp8qMPnW8WElQ+dShkx8ZnrxgtiuC5LnpH84WntLd5wN4PfhGQ3HDCHTH
 B3lLUqbp0//HcgEWHs82xShZxAFV6mRR+7FgZGvlU7tHdyOQ2F3hbs1ztP9tPijcwAQ==
X-Gm-Gg: AfdE7clLptY4EYmZfE+XLT5YNzxbdf/lX45nuX95w0Ozam4vea9guUTic8hTaWHThxz
 /g9BVF32zS+vTUhi80hrMpDv88Aik8xa8GUvAQzR1llh0HLqSj/VFAKREsODFGdmqNVwVcYAAMb
 ckWBR24KJp4twoMnPAeXQOC1Z6MJOgooYAuN8OP7ErULK3O+DFJ7Bc/QNNONlHZwu97LMX7br9R
 85lzQXPNJFNyCfdEu9jButxztR160V3+XsdGa9Kmv/ee/wWgjSdoCXBZuXJ9Qntcdn1iZ7P+ArI
 s1iu9fTMdXO4TpxCi9OtHPeWLZxYFFnTpo4WN9vGr9hvcl9M9XC3feC4+xqHPdCkharieB2WAou
 hj3EP6j/4ibw+gHaA6QvhGAOJfNECXTOVTFPi74WvcDgCfwxfwuxYPYCwWD8pte0=
X-Received: by 2002:a17:90b:2f04:b0:37f:c2a8:ce45 with SMTP id
 98e67ed59e1d1-38e465c6a5emr711001a91.4.1784225263717; 
 Thu, 16 Jul 2026 11:07:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2f04:b0:37f:c2a8:ce45 with SMTP id
 98e67ed59e1d1-38e465c6a5emr710952a91.4.1784225263220; 
 Thu, 16 Jul 2026 11:07:43 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:42 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v2 13/14] python/machine: support routing semihosting output
 to the test console
Date: Thu, 16 Jul 2026 11:06:57 -0700
Message-Id: <c16ea7a7e6c4cd835ffbd63aa9dab62a3a905a7a.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a591df0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=3vhqsrBKo-Q0muh1UiUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXyLXyeGGsexQG
 25DR5yixtcZtXfYLVpjhgJfhVbCjea+w1lDyYIR3XA3Ai4TWwqurXFmerJVCN6vd0XURCtn+1Ss
 C8oR2ftgH/85Pyn7kiSjAd9wxh0nHqeEAqSrTT009jyBLev/1EQ+LAAByn6mJ3HhEXa20x3TOTN
 CAEoI97XGu0Gcn26B74//h8zaq3e95WxXqGPvtnD8wgVsPBH941PaoaiyOP3pZnVEBZTCjD7GJP
 tX4DLAqD79+z6dw3UNUpM5uw0tdi5WDoLEsVSZmbvP/DIchHPPSfPNnA2PIfk6r9zpkUhp6ufLs
 +346Y7iDSW5iTjsVXvZ9uClw08w3ZweavKJvxxR45VCBuqVZ0ltNA3T5pMox8MSSQJBJW32wREk
 ql/sP7oHvTeLKRmKaIVbui/hWWSnBmGgnAg/w9+E/bY3Y1w+4hVFEN9IuLF/EhO3FBUItlaQZA0
 muHcoSkltLnYrs8tEpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXxzf0c0R+TN5d
 0H6599qlZNXY8YXDCJ2YLhUCjVez1K5xCUnU3mPNPsBmeEZENYF7D/e6JFJ+RVg1LTreB6q3NB1
 B5z2lJVctZVHwaExunYw3DNhfOZfy1Q=
X-Proofpoint-GUID: zLxFi04mRYVYdnOUAmKfZx5x0vFyq9Io
X-Proofpoint-ORIG-GUID: zLxFi04mRYVYdnOUAmKfZx5x0vFyq9Io
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160185
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


