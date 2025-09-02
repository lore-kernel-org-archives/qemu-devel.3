Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0C1CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzf-0006gK-Uc; Mon, 01 Sep 2025 23:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzc-0006f3-AC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzU-0004Q9-Pb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmnG029940
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V07Obdmlm93H9u7fTFgR+cEhr44VBifxtLzfjaaDFAE=; b=aIAIA5B1pkNX53IS
 ge9adld4j8rjnpAEPq0+6ep3jxn4YFMvPM7brX2QWkLZdbxx3FHbc9iUzzLnlv1S
 e5vst2j0LVYRt+6NJZ78SZXTaXHvG/t+mRCE6Z1jDhwXZP1eadc62FANTgSGHnd/
 rxSWM/dWRq5jMoydVEdDQsxB1n8pDcoQG9Lr+3Lf2MDYpIVbHHEo0KBhMkbpdIiK
 My2LxDTeNgdpskR5fBzx0sUfPcC6XdQLTkpXrFfjpwNOyZyrPN3ecSYO0x+vpgAO
 HYj4BFRLrhc9Oes9IE8j9U5wNIRbqZX4R7r2y7lIsAqoZwY2ywjDaflZ8in35/bX
 0QtyJw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xaeb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b47174c8fd2so6498991a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784845; x=1757389645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V07Obdmlm93H9u7fTFgR+cEhr44VBifxtLzfjaaDFAE=;
 b=QOz8LSorsuC2xn3B9kD82w12U4E8tL5gOxk6vWRGla2SZbQ1IfE/JbrnKetns4j8Cn
 e+vs5o9wj7bwpBpfGjuoYwcxOP6SNAkqJZjJWrCwJE7T1R6lj8Vj3WuOV5SOIT80txM7
 PUqR9V829RP7nAmYLlwc2wkpMP1b29KoR8fqLd57GiUOevtEmTkHp9IBxoiQWVeAk+7V
 E29CUMwWvprfU2m7ZazviwGzYO32Y88gjKn0xWyUaRGjn3h4F+vvWJO0DY5LnM45fY8P
 4iUEbyrwKA9VABV40wAp8KuLd+nJcFved4XEoGkv+FrakIhCuS+nMxRDUPwQne+ep939
 iV4A==
X-Gm-Message-State: AOJu0YzLtOcxZJ05slAlgwbitqTAdDJUew3PNu46MjEdQp9RDnT/5uPk
 8yWs8YihgcwcDBWFPjMnK/U/O7aJCD8Ecl5L+lMvMa5xP8424J0+fh7PrPgFDeCW6eBXQfkWn0p
 WFi6oP2pmqKHsfKtZ5UzlqGL2gxMn9CfyBuHgId1StPiUGLyAfMTKMCXQzPP50dTyxKc3
X-Gm-Gg: ASbGnctna5rVmliwOLhC1s/2z2TxmIf5oHxHs1lUOXHNnzIXISqaRNjWmPtjQpXkDZW
 BnaBIkfjkZM4Gdto889Vnp4mHsYG0Ee0O3KuzGI1eAnkbYniUEQw/Ryof42G4ti/UZasVCIjf4V
 Wja8nZWDbGe+aCwCFgMEUeXeGmlMk8fmXvVzzjNozcKUncm6ztzgS2rYVY1Qdz5rCWBeWfpbQIY
 KzUy1gxvfNgpLMXu9+gQU6ENRm+f/RWFHJUn3uJZJWxDROpyMzh5vH8SUTYfjeOp/OdDT0/G2va
 B+scuHons34E47Qt1q8eFHpRzYsxnbbq7Eha0NiWgKVBhBWzFx7srRjAIE8VVKoTscVyHxcS/Pm
 MuIBNGnnMkJQU
X-Received: by 2002:a05:6a20:2449:b0:243:a21c:3730 with SMTP id
 adf61e73a8af0-243d6f036c7mr13723612637.31.1756784845207; 
 Mon, 01 Sep 2025 20:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+spZcw/JPdVnNUB7JZ3X0IZ49YyHtjzgXvlFQXUsuEAn+b9j7wGn+IRSkgR550KSRmKsEaQ==
X-Received: by 2002:a05:6a20:2449:b0:243:a21c:3730 with SMTP id
 adf61e73a8af0-243d6f036c7mr13723579637.31.1756784844771; 
 Mon, 01 Sep 2025 20:47:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 02/40] docs/system: Add hexagon CPU emulation
Date: Mon,  1 Sep 2025 20:46:37 -0700
Message-Id: <20250902034715.1947718-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0v8LZN2a5O9x
 OPyVE+Xmcb8WdiEzLDDK6X9SaZjDrd4YkxZHuPVg0hFdEU59ScoMbR6d6KSxhUMhMlUAJeo9ZjF
 8K91ar/SsN0Q22eF0ATuwhnFts2itr0qrDkeB2U86E1XefR2ZMnepZRm/i5MxxCtHYtztKcs82v
 XjNfdyYoMUqRlhnIh0U0P+matJWlWcelI/KgHIcoHZT39W9zlLr7W4dTn/CwTzkptsZ+9BptdwS
 oJkGHXme9woMPPNsOe/6AE8nZiFhljw/oOhe81Yp/4d0lR30SBqNLwoF3Bl0xjiJ03/ksvqY+3p
 OOx2ZV/q4tZ8nj5yo/0XInVHb1e7iQ6hSvjKtmAeuylFQxH9TGsLtlAeiwU25QQfG9i58szBrNd
 fZ4KpqBW
X-Proofpoint-ORIG-GUID: -ieNxTI5RLn0XQ9cEuxjodd-tuIimjES
X-Proofpoint-GUID: -ieNxTI5RLn0XQ9cEuxjodd-tuIimjES
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b668ce cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
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
 docs/system/hexagon/emulation.rst | 18 ++++++++++++++++++
 docs/system/target-hexagon.rst    |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 docs/system/hexagon/emulation.rst

diff --git a/docs/system/hexagon/emulation.rst b/docs/system/hexagon/emulation.rst
new file mode 100644
index 0000000000..75f46719b9
--- /dev/null
+++ b/docs/system/hexagon/emulation.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _Hexagon Emulation:
+
+Hexagon CPU architecture support
+================================
+
+QEMU's TCG emulation includes support for v65, v66, v67, v68, v69, v71, v73.
+It also has support for the following architecture extensions:
+
+- HVX (Hexagon Vector eXtensions)
+
+For information on the specifics of the HVX extension, please refer
+to the `Qualcomm Hexagon V73 HVX Programmer's Reference Manual
+<https://docs.qualcomm.com/bundle/publicresource/80-N2040-53.pdf>`_.
+
+.. code-block:: bash
+
diff --git a/docs/system/target-hexagon.rst b/docs/system/target-hexagon.rst
index 5f7084a6a0..416b8f7be7 100644
--- a/docs/system/target-hexagon.rst
+++ b/docs/system/target-hexagon.rst
@@ -98,5 +98,6 @@ is not yet implemented in QEMU hexagon.
 Hexagon Features
 ================
 .. toctree::
+   hexagon/emulation
    hexagon/cdsp
 
-- 
2.34.1


