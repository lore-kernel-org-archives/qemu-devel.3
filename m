Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC500606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eBs4nNVD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jm8FsYda
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTV8K-0000T9-TG; Tue, 17 Nov 2026 21:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTV8G-0000R3-UZ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:10:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTV8F-0007Kb-6V
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:10:44 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMeqF31464782
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 02:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=8o2hU9r5ixu/76NhVL5YCMGVLHEaTuEmdmX
 w8JI01/k=; b=eBs4nNVDwmL7+7T4PuxuQur33ST387aBWY+pZO38S2oIE8cImmi
 Y+r2UhYdxj1fk+5qExg0xZd5D9hfRM7yTDcCKgePbijHf7xf+p8apptIyS2aR+9M
 xpCPCL3YIcfR96SStUNcmghaFB6kl6MhqAWAVAjFtLYLFWP002vdvZdFDxDyRyU+
 d0fxZtx1PO3WtOcR1f/WVI6/xGTZJb7CKQfOaRi/+x9Hr/ZJmlJEZDiXfsjGC4WP
 w/q4HvNocI7rUudGc1d47xRP9CcQLgbIebhq6p6+c50zHN/H2KHl7p+RcgbEl5Dx
 pULY9p4h9eRXVmjvmrWqI2Wh4Ie4jSSy7hw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9gn9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 02:10:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso297131a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794967840; x=1795572640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8o2hU9r5ixu/76NhVL5YCMGVLHEaTuEmdmXw8JI01/k=;
 b=Jm8FsYdauC2JeD0//ExTCIapTDfwhyKZMKXWfOLKSTQEX+mQs1SSPWltWpkX72oPda
 Cr7L+elRJkRenRHJoaPH1x5qcmzxKfatOTprmkFJ6sp1RDDKzDRWn3oTTxSatPvX/8Az
 lbWuD+jAmbUAFbVYGrFMBc8Hf9S/+lECso4IHYYIiDW3GSrCc5CwpUeuZuHR22zQz8aJ
 q7x/hUAO29UgP2h+hnL8i5aT4518pYurYwzvnDvUwL1JXXA1hs8r3WwuhMqzOHROnJlg
 olnnDZrUEHS/YShvs+zlZx5CX1hG8mypmGoHAnA9vcWPcbq8lrqi3him3EJwTKpVLwcM
 lacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794967840; x=1795572640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8o2hU9r5ixu/76NhVL5YCMGVLHEaTuEmdmXw8JI01/k=;
 b=iHIK11ytBaRFM7k5Lvru0mcbg68YhoWPhjp7MezE4jryNU4HwC1+KFyXjE94pdOLPs
 lk6OJyRHXTJKRyO6LR/SKu1zRfrcEwvFp5CFtCv0jGgY9pHBaTMGrof7yBTw4YYGF8Ho
 eSn7u364lmcDnja/4zl/GNR9ji8yRDFIiGaSnHho8uzUC/9QlJAySzig4Yfy0sIt+6zE
 dSlM62Xd55QU8iZMf++luHKALlNx3ubZbgKjAxR2N8BesQLeizR2R9P4pQhh2lU8qVBY
 SX4YK6Q+ow+7cUnF00Gc74TmswFm8R8rn3LUY65i8q4CkunsqXmPRU5ZV9b+DBIJZWVr
 I2Ww==
X-Gm-Message-State: APuU4Z98tnXyggsvIoFtBRV7rzxwE99yGiIUA4K2XYGrYNn/YmDglWll
 7zzDh509yI5LBPWBAVcD9s6KLlttdtmn5JVxru8mQTvNAJXEcbHZ0Jz7kb9ZVwEpE0iHyIoHwsb
 9yia8nVl3uuzcP+1tLUzl3odH5Qfv4tdC0nHwCfWDcR+TNAOolUizniDCHCrpH2A3bA==
X-Gm-Gg: AZFdTZcT8O/dz+i5PK5SVM5DClRf67Xo60Lq2jfkLnSWYguFsBV91cJVTBI4ZusN4kV
 UsDKzezIGfX4ZPeLLk4xQQYoG3HQzMbW0Zv90q4Tp6TN/KYpQzGH+KO8nd8xsyqCEiX46wmg7sT
 mQlLUTvxn3Ltp5EZVjrkiWxyvTgRlAGN7NgjdiIwQXKYyMoW5LetOpsOqd1fUtUe+Pp7QVZi0Xw
 nHQoLYcVwVGHzO7TsSapLRl4ok8xyVIWQqATBefcgpjuvOL3KeecSl7AdF2TJE6wSAx/5pJR2xB
 lk7c+xM6y6DstnIKm3WD5D1qZsm0e2+wNcxYjp3jeSZxyTalOMfuLpApxzn8hIXPsf3ANXaRcA+
 VIydoOTomoxU57oisbjpwydBKEG6tANCH2EKySacOoIvfz72KjtT7ouMUS/bXnSj6A0HxkH7qMi
 kGvgO4mkhp8bF7ODAzW8ZY+R2r9IPfHlnHOwcn
X-Received: by 2002:a17:90b:55c7:b0:3b1:83d4:5d33 with SMTP id
 98e67ed59e1d1-3b3d07c2924mr1227454a91.60.1794967835529; 
 Tue, 17 Nov 2026 18:10:35 -0800 (PST)
X-Received: by 2002:a17:90b:55c7:b0:3b1:83d4:5d33 with SMTP id
 98e67ed59e1d1-3b3d07c2924mr1227435a91.60.1794967835027; 
 Tue, 17 Nov 2026 18:10:35 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac2b5ec6sm6635470a91.10.2026.11.17.18.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 18:10:34 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] contrib/plugins/uftrace_symbols.py: ignore warning reported
 by llvm-addr2line
Date: Tue, 17 Nov 2026 19:10:20 -0700
Message-ID: <20261118021020.1253822-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QenzLcbv c=1 sm=1 tr=0 ts=6afd0920 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4uSdFgqm0Hs0aUViYFAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 9pIxANaDc_fQhnoSwZJ1sUP4b2pITY74
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwOCBTYWx0ZWRfX5rJTPzbCU9KN
 WkTI0/vtoK5SJUmRPZFevvXI3/FXC7jm7MooIHsfIUUgKHBNCoCuiI/JZlWctB+5VvIXnzASnS6
 XksjWMGitmoFxKKPURh8vXD5SOElIDac3c6G/RFSyA08Vl7sO6iTeJ3+/jNIrKetz8MNFUJDEht
 cMnUj0PpkJZdxSZLywl1R4SrOVFnTGav9t35IV/Sx2heq6laiPjDbo2Vps3rY+zmPXpRbdgHult
 wEg5/mjp4YDXSdDgZhiE9Mh5fFMy7ixos0Ww4FRxC1jikBQbmTHZ/dXxmhq5kDZI6lNqs+0Y6vp
 0Y+XPeT/Csy8QMLdt9ZGFGFO1P9JiSgaWLVNT+XvW3AOEEOErMeDZ19ehyPymLoLk5CJdRY6o86
 +uOLv+yEc20GaEEeII0dXARhRnUUs1WpCLUyXlC3AFiF6cyqXDDm1jeBJaHEVJCj7Rg30qQTwjI
 VNteokWGjHsA0F8v8zw==
X-Proofpoint-GUID: 9pIxANaDc_fQhnoSwZJ1sUP4b2pITY74
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwOCBTYWx0ZWRfX9Ufvb0KDhD7o
 rSbb5aLmOPxdo7zUtioKYWOfmbHWM1xjagnfGnIcrDqlMY8OXezx8H2PCZbUBVqo9s3CUtOo8Wf
 +NbBCgIP/Gbfy6a9HEvmcxK/ykzmNpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180008
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

When trying to trace a riscv64 stack, addr2line reported warning on
stdout when symbolizing addresses:
warning: address range table at offset 0x8a0 has a premature terminator entry at offset 0x9c0
warning: address range table at offset 0x1700 has a premature terminator entry at offset 0x1750

Ignore any warning, similar to the error we ignored previously.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 9f0095e73b9..2b931c49a83 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -63,7 +63,8 @@ def find_symbols_locations(elf_file, symbols):
     out = out.strip().split('\n')
     # filter out some addr2line error messages
     skip_err='addr2line: DWARF error: mangled line number section (bad file number)'
-    out = [src for src in out if src != skip_err]
+    out = [src for src in out
+           if src != skip_err and not src.startswith('warning:')]
     assert len(out) == len(symbols)
     for i in range(len(symbols)):
         s = symbols[i]
-- 
2.47.3


