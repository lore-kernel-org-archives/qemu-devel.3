Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E28CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 05:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbX6C-0007KJ-8b; Mon, 22 Jun 2026 01:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbX67-0007K2-Gp
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 01:21:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbX65-00076P-I5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 01:21:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M59Uft3850880
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 05:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=lTKh+mG/xcQ1yhy7EEvNBk
 LBq3AA/NhfPOCilESLCW8=; b=oZ8GYXNzGvrnRkHAR5nAknbGSD8uiYqgCUc3W9
 YIwWsniEdSNH9B3tRTBxLcY1gsmhyc2DLeSSh70ZVR0N42G3Bf7BfXIjaz7VsDzK
 SfBETfS2TSVS2b5rQQv6qD9ankIx/IyqdXBbNeVIhSNaAlaQd46KiJgFgKGUEnt9
 09/Pw1czI0Zz84s03l/uQ/LYwgMa7QPs+Mz7TAxU5+e7dPDuRIgMkEJ1b3Yi8aEa
 VV+925GXB2pUYENOGeTf9tFtA6h0l6PwZOT/JJrDcynwIV5emwm8qOqIYfmndL02
 vhBW9cnQQ0mdLdutrNeDHG45LSO5InUdU+XXyESCSwgFY5ng==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm584p5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 05:21:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso2140453c88.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782105682; x=1782710482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lTKh+mG/xcQ1yhy7EEvNBkLBq3AA/NhfPOCilESLCW8=;
 b=L4QxvSK0TY2NIXpz9+tZnAAnHA8DSXGgqYSkPn02Lt/ES74Iu7fNZOcRbfXvHjkVRC
 qc6sLas24V/FuP08iYjlljR41iNuamiorXLzXbzyc41E+NC++rABdjdp1KL8gmatMaaK
 kfcfjZWexzUCL4m73KOQyyHggBwKwEXR3qT45vPHQKnB/ldq42QQjc6lOARZ8lS7hPcc
 7YDuxjsXrCYS9elCUfVx41EP8LHSS/NuycJ/q/qniN0oIpSDnrprcetHNyZfevZTG6BX
 DMc9b+a3qN77zr/zQ2McZNgpbp11I5UckSsRecSxVv9W26Y+KlilatxsYVTFBLHCjl0V
 ZUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782105682; x=1782710482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTKh+mG/xcQ1yhy7EEvNBkLBq3AA/NhfPOCilESLCW8=;
 b=hh6vLFMGe3lzX/0XihFOc/yy/TNGSi8f+h5lconlshgUnxwgCoDaOL086G19hdGfPo
 h1c9Pb/29nQqi5PZVso0UWfhc6XGu/y7XZqPEIomaziLOJ1i7lgB2wMJ7/QLlJcyqy2d
 zrjKLp2lwSoPyqSsHM4PrH2AWktbaIj4EzsIDE5qifE5ry6ULRARCM3bRb/M7OOcXYm2
 +/75jNbb1xoXiMd3ws5LOQOjp3uoAtW2E6rnmhIZ6lronTmBhaeeaB/MdCoi5hknHYkx
 xUF+wqSkPTp1HQo9mIsfT/4ymA4eWVadZPDpoqU8T0izBOc6yc9OAr1GEpn6aNnF+Zqq
 Mr7Q==
X-Gm-Message-State: AOJu0YypsVKZEEaEOYg2/osHBLpPQbudLWVO+jji1l+d4bsN0CzUPU+J
 18zZ7TCh5xvUheRg4HZtRSwBsP4IgHPt9hBShtAK52hF7tsBya5b8aehhPMm6IaLXg+BwoNv6Mn
 qIbSIKp2x3jd2pdAPhb96qBZdVSSVn2QIzcZYD+HaPZJdFhI2UshZZ+O51q8Ldj+pig==
X-Gm-Gg: AfdE7cn18hfV7QXjLesD1EJlZwVYpdVOSD4tFQKDIy6GHn938il0gkfW0o9ykkCcB1c
 JH3E3HLxLcO7UPszENtLam8lhs3f6efqv9ju3ieZ3FhJPfAuF7yHWznnZ6wcc3WYJKkm17XMs6M
 a7cCdPHM9sHbSEH1Q8ZNab/zIjF9iyOfZSMEmMV2TSiDszXmN3jk+b0uS76+2Lyls/d9pq2oEYa
 S9Wu6/4FQPGr50eu41X8DRyDJwLy3YfwmGivfxRWzx8ypDp1Ih3NREJheeygqFT8gTMt+BfElJx
 hfzjXsibrV/d7n8tL3tTyIEhcpZuiX66SUOaUjBNldcvy8DjdP5MDU7u+ZadRmnWqXDLMACvjZx
 aLfou0M2/rCvyqC6dZ/1s1iGAkJKW9xa47kbU1B32OdCSIMOOCNnTjAz0dtE=
X-Received: by 2002:a05:7022:101:b0:12d:ff1b:92f5 with SMTP id
 a92af1059eb24-139a504ea4fmr8137154c88.28.1782105681967; 
 Sun, 21 Jun 2026 22:21:21 -0700 (PDT)
X-Received: by 2002:a05:7022:101:b0:12d:ff1b:92f5 with SMTP id
 a92af1059eb24-139a504ea4fmr8137143c88.28.1782105681486; 
 Sun, 21 Jun 2026 22:21:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcb7aabsm8028933c88.5.2026.06.21.22.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 22:21:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng,
 ale@rev.ng
Subject: [PATCH] target/hexagon: use cmd_array() instead of get_id()
Date: Sun, 21 Jun 2026 22:21:20 -0700
Message-Id: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: oE5Kb6ZvbPnNfLiEXuJLj_zLMge5Fv2U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA0OSBTYWx0ZWRfX8SxY02xKyllo
 vnL2QCA9orRlwgm7Tr31FhQ+YN0by54FNz3rU06HmXhXhY9NkjdtsPLIuQDYdB3vSYnAtZjEs5f
 k+yOhCdFvxZVmoF96gQTjMTNif+BRVc=
X-Proofpoint-GUID: oE5Kb6ZvbPnNfLiEXuJLj_zLMge5Fv2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA0OSBTYWx0ZWRfX+tzzIPmoPBAU
 b060rv/A4JT6AnXGgS/cRlrs14qXaGVVYOjRW0OqVZFbW7IvCXS7BBvWxFai9HGcXuqo+0ifD/5
 7RtCuXdnLTRNvjZ09fgH6vLwqbhQpFNSGPP99DX0zqn+nhXUMrH8mT6QgVOTRHbKxKc/m8nJAo7
 yooMOP0GulMa3s7IKTfAMt8DqQb1JVvNdEgbLmUZR/WYZm79oOD9MPzTZWBIYz8pRyrJAVoE7Nv
 fbYIZE/silB0mPwixc19+qrm4EsDvccela319BSqARcev7rjRLpkeN8P9yhQo4zKskIRY2hvZH5
 69tvnulcwownkyEUI//25257C0SrRlYSYXDIb0aq06D/pnV5fxS/ytg8BLGhVS44ngGymB4xe/J
 2QJLno7LafDp8xocEwvQffzW4aCaoJC05pFwFkYtRSAAZG5K26mp1c8ch67gacX441pDpKSt3vv
 QBi7R5Fk3BdeUUjaJIw==
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a38c652 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=SrZkeIdwbWuKvdoqoQQA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Z2V0X2lkKCkgcmV0dXJucyB0aGUgY29tcGlsZXIncyBzaG9ydCBuYW1lIG5vdCBhIHByb2dyYW0u
ClBhc3NpbmcgaXQgZGlyZWN0bHkgYXMgdGhlIGNvbW1hbmQgZm9yIHRoZSBpZGVmLXBhcnNlciBw
cmVwcm9jZXNzaW5nCmN1c3RvbV90YXJnZXQgaGFwcGVuZWQgdG8gd29yayBmb3IgbmF0aXZlIGdj
Yy9jbGFuZyBidWlsZHMgYnV0CmJyZWFrcyB1bmRlciBjcm9zcyBjb21waWxlcnMgc3VjaCBhcyBl
bWNjIG9yIGFueSBjY2FjaGUtd3JhcHBlZCBjb21waWxlci4KCkxpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FKU1AwUVd6UUVnb1lNQ2daWCs5akN2clY2TzNScW5BK2Rm
MURwVDJSNk1adlZYaU5nQG1haWwuZ21haWwuY29tLwpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vbWVzb24u
YnVpbGQgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQv
aGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBkMTY5Y2Y3MWIyZi4uZmYyMmI0ZTQ3MDYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21l
c29uLmJ1aWxkCkBAIC0yNzAsMTMgKzI3MCwxMyBAQCBpZiBpZGVmX3BhcnNlcl9lbmFibGVkIGFu
ZCAnaGV4YWdvbi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycwogICAgICAgICBjb21tYW5kOiBb
cHl0aG9uLCBmaWxlcygnZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5JyksIHNlbWFudGljc19nZW5l
cmF0ZWQsICdAT1VUUFVUQCddLAogICAgICkKIAotICAgIGNvbXBpbGVyID0gbWVzb24uZ2V0X2Nv
bXBpbGVyKCdjJykuZ2V0X2lkKCkKKyAgICBjb21waWxlciA9IG1lc29uLmdldF9jb21waWxlcign
YycpLmNtZF9hcnJheSgpCiAgICAgcHJlcHJvY2Vzc2VkX2lkZWZfcGFyc2VyX2lucHV0X2dlbmVy
YXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1dC5wcmVwcm9j
ZXNzZWQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6ICdpZGVmX3BhcnNlcl9pbnB1dC5wcmVwcm9j
ZXNzZWQuaC5pbmMnLAogICAgICAgICBpbnB1dDogaWRlZl9wYXJzZXJfaW5wdXRfZ2VuZXJhdGVk
LAogICAgICAgICBkZXBlbmRfZmlsZXM6IFtpZGVmX3BhcnNlcl9kaXIgLyAnbWFjcm9zLmguaW5j
J10sCi0gICAgICAgIGNvbW1hbmQ6IFtjb21waWxlciwgJy14JywgJ2MnLCAnLUUnLCAnLUknLCBp
ZGVmX3BhcnNlcl9kaXIsICctbycsICdAT1VUUFVUQCcsICdASU5QVVRAJ10sCisgICAgICAgIGNv
bW1hbmQ6IGNvbXBpbGVyICsgWycteCcsICdjJywgJy1FJywgJy1JJywgaWRlZl9wYXJzZXJfZGly
LCAnLW8nLCAnQE9VVFBVVEAnLCAnQElOUFVUQCddLAogICAgICkKIAogICAgIGZsZXggPSBnZW5l
cmF0b3IoCi0tIAoyLjM0LjEKCg==

