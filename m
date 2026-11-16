Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F3606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FryXovxg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q1Dy6d7K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT64T-0006Gp-RZ; Mon, 16 Nov 2026 18:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64R-0006AD-UQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64Q-0003v0-1y
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:07 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfIqq2729026
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0faTrUYl0SqB5qbhpyP6a1rrxhDV2JCQfFcWbpB8ri8=; b=FryXovxg4O0T0Qhr
 gLt06DPrtiRGuPFNXpiBIaGZt2KEXMgw4v54fxASR29VsIcacIG74L160aahOOC5
 iVH471gY+1Oku33M6CTFYe7suHXV5NAEpuqqPBPyGQsWheTQdJEvah3VwFPIpQND
 i7MJgvft2BMtZlUxPcn6fIJMXv+sYZtMOolkzGiT9yIwz7q0Gw9rp6UYtgVYmveQ
 fdq02ZYVVp5pjBi7ek8r26m6YLRpHZfvyoy7jTu00XO6KANavOI0RjaJ3B34jk5B
 FffxKMxs1rjXOhV1vURUWf/No6LjMRXh7FAkHLLJuDogEzvcvYvEiTQ17/4D8vrz
 bZte+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regv1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94975041698so90357285a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871504; x=1795476304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0faTrUYl0SqB5qbhpyP6a1rrxhDV2JCQfFcWbpB8ri8=;
 b=Q1Dy6d7KjRkMiZNABLkvicCXpke9mNlAuOZOts/DJHL094nkmbK7eH7kWYXldoD6kD
 V63LZo579ZQZRDyjHYWw21eQU7TJFnvsXSKpLw9ot/mLr2WgUYZOqKRWVAKd9At+u1Xi
 +Eps/LELj8Mt9XfMyTziXP3hJhq8pnrbAbYYZ5JbyH96tdo0m01965GFL3HL9JAlf+r/
 wmio/dICfqKz2emZzG4HBBV7ILiiMd5i7jnm0iV4WSOKoufoWQw2ms5IxIWYuGBRgZml
 VvcIszX2rvSF9+lniVmqPLGzBn1hgDAFIUFK6vnKp4Q+iGLn7TFyN2clk1+q94pWGNPd
 nj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871504; x=1795476304;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0faTrUYl0SqB5qbhpyP6a1rrxhDV2JCQfFcWbpB8ri8=;
 b=YcpnmkvWthfTm6hXIn4+zSgNj+uFMM0+PH7FdmizCHIANQ/rQB6QSgBYCjLNkmIMYX
 nV51vMOzfvJXBWl1zwyi2zrpxGz3tan1SMrj0lSY1OvX7GM49GiNUW3wyIfwgKIil3W7
 Gh76RwOigo/ZPvY8McJLp2JFgaIcM6C5TWbl+hVJKElciJsJu5Z8NSlyJTfJsAdzltJ0
 wtGIRaak0q4+bfneRYSy22SuDfk4bB3B/LRklkqYwpBmoE3ik6smfkJguP/dJQqVMuxQ
 /2uveZ77wc3Z/Yi3F8m/038PuCNDgJwTfUucTPfwU6HFXCmL+6NpPTpV3JI0n8ymg9RD
 rEYQ==
X-Gm-Message-State: APuU4Z9J1bKHQnokAwIEy++0v9z4l1zKrBhucK7ixrU4j1A5NsFlFprt
 GBNt/ntBJbyGv7FNKpvF6hvyrCTrp9iwiF64nFe0jspdroWJHmSrvpj20hi+SzG1MqOkRxFOGOe
 Jfhxf5nE6JLuOVOcW9LDweZSJfu/0X5s3S14+rtRx5PGh6FQXuHosSz8jfiQNq+iG5g==
X-Gm-Gg: AYBFou05rU1U7JbZEl8+d91lk9L94M041LsOiwBPyEsw8uORJRPehZBYnpFsLylU+P6
 RUA07WCjqMwjg4LakzxQmMWEhOyorwGNh5gSAI0klMczBtk3QwDkYqxXuqu5LtyiseuTHXMzLFf
 8rvlHoSq3Maf6xvVwQeofcEZSVTFNdWW+VWMlkazghiwgDaOEYweVlZnS7xnf9g8JQs3ZfemJNZ
 KbXAWXPfNqhd/82zHzJzMv7z00XbjIG7xCKMb1PbDbnh4fpHbRc9rKXTgp0OtxyPnecZ6o+YEMy
 P0Y8ffUCtTiAsMtvHYhGyGKGNPLuy+JDl7heVyqsLonxuY7T2E0blZjlKSw9jl2F8Ibp06ybcEA
 dwOqkDkG/raa0tSlLT/DpeIbJoN48dpKzGeiT+ORBdvzlde5A1mv+DGbMP9rb7AgWRpnWHEU9Kd
 qDgME/MKJqbn+zHA==
X-Received: by 2002:a05:620a:880c:b0:949:6663:d1eb with SMTP id
 af79cd13be357-9498b8edfcemr170986985a.21.1794871503723; 
 Mon, 16 Nov 2026 15:25:03 -0800 (PST)
X-Received: by 2002:a05:620a:880c:b0:949:6663:d1eb with SMTP id
 af79cd13be357-9498b8edfcemr170983685a.21.1794871503252; 
 Mon, 16 Nov 2026 15:25:03 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm43940055f8f.7.2026.11.16.15.25.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/22] build: update CONFIG_PVPANIC
Date: Tue, 17 Nov 2026 00:23:24 +0100
Message-ID: <20261116232335.31593-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX+JpXx1zr0Rqk
 PIOhZhuakmekviU3VZyvCFXx/iDWtvEDIdQ4PAziJQIXFEfzfirM/s3wWxkT4I/l4jPNyNaycfj
 SgzlQREksk5njV/eCUMc3FMFujBXia4=
X-Proofpoint-ORIG-GUID: oGPigVYTd3kVE4Q5xGOnvXqqDBLxiqVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXyBDKf3Ab+XJo
 guuVUTL8aRDe4ODpwa1Oi0D7AT5wCSptSmuEgLjT/5vX+iq/F1CAB9m1ypB6obKBHaK9J8+3DoI
 ET0Djydh94vNu1DNjE1T7drePq5IESh4c7APAj9/73/MK3/POZ3sOWjH+9+cgXMoe0eEEdY1idm
 cZNIqrx6p5UeWCEKzgGtO9VrbVshVFmpnovOpPpQkhdUSEFm2L6ExQIxK8pSlMTC2/R80Mj6yAz
 DHIsyLTnYLbx3AMZOzFRgqFUSFkDI3h2pwNBQaGSkqy2SFyIPE07M5dq/wLJrhLJAn74yte7vY+
 LAQaKZFu67n9oloqBuHTCXpqGttuGyenfJFfWcHoikds3+SZgxmgi0nKEwnVbiVpS8li49mkHca
 +8A94fAeQHStRm6u8p/Y0m4Kt2YYoG9rN3gcmFMykmE4m+JTt8mA/5MKWKpmnmzAwwTreN7ZBBx
 IUO6/+34zav7sGlhkXQ==
X-Proofpoint-GUID: oGPigVYTd3kVE4Q5xGOnvXqqDBLxiqVo
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb90d0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AYmAHwb26JlU27TCzWMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: John Snow <jsnow@redhat.com>

The symbol for CONFIG_PVPANIC has been changed, update the dummy
config file to reference the new names.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261109183605.3210043-3-jsnow@redhat.com>
Fixes: 677726ef1ebc ("hw/misc/pvpanic: split-out generic and bus dependent code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 configs/devices/i386-softmmu/default.mak | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index b935ee613329..96716e30b9b0 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -14,7 +14,10 @@
 #CONFIG_PCI_IPMI_BT=n
 #CONFIG_IPMI_SSIF=n
 #CONFIG_PCI_DEVICES=n
-#CONFIG_PVPANIC=n
+#CONFIG_PVPANIC_COMMON=n
+#CONFIG_PVPANIC_ISA=n
+#CONFIG_PVPANIC_PCI=n
+#CONFIG_PVPANIC_MMIO=n
 #CONFIG_QXL=n
 #CONFIG_SEV=n
 #CONFIG_TDX=n
-- 
2.55.0


