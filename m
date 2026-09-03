Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFDBC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cbx-0000Ws-ST; Thu, 03 Sep 2026 14:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbu-0000WN-Jn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbs-0000WO-HB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3VB11430689
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R/E8NuxeMThFG5rhE1lylHV+6HZ4sRuwvcXbY/Olf/Y=; b=GTBqMGxw5fEevG6Z
 mInxNEPt3VKuZPU3OBk/jQGT77NKcMljQHpok33JMMT8mYUJ67AMM1L7YHUQHxIC
 E7zFaztvwF8Kbn/HTQvYV37vultgYMhuiWXBdb5CK9baX3wp2XCMh0vYFEUwCFXS
 h6M7uVu63y/fmOpJX7xX+tGCHZOn3cMnjwVmKBujd71fQo/kZZ8wAze4l8WetZ6A
 WHcfVuO8za04W3h/2yFIoc1CGbDlZ0nJe+V/s5MhmJgNgpLVmxKzZjHuyzfApVXg
 /t4tId9Y/7CyTYSc/2t0sjsSMVugmzxTR8QuSKGpV1iss4bDZU8bwzwuX0XKHUXT
 SR59Nw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4kkup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so299403a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461786; x=1789066586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R/E8NuxeMThFG5rhE1lylHV+6HZ4sRuwvcXbY/Olf/Y=;
 b=LuxflqNjel9LITIwUD6HffgC0+5Y6ZA2AT3TsuYLuMKwCl2AgEZONR3zy79D9MC7TX
 5K5oLljxhXIAv+ZlrvIVdRFYLsGhUfPVcvjyttcJJkCJyhgZeCBrt1LwAqx+u1iEmpZl
 7NpNXTJTl/FnxT8ptmAt1pczCPakQZ28WR7ba/N+Z7HJJ6rbpOPcJA6zLUixtat+qD9j
 yy0mTUCQyWp3koZlAQ6ae5yLTVdkb3x036gAnE2GvlECvDxlEloIUF9R24mTfzJqFZcI
 WBpSSXYGWSKhrsWr7MroJO96/zyqn67JU42s/TNnyt0rJpgbiu4E2pJ8mWyKHNWzSspQ
 IGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461786; x=1789066586;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R/E8NuxeMThFG5rhE1lylHV+6HZ4sRuwvcXbY/Olf/Y=;
 b=R/NSx8X/w4qzlQXhHg06ZISMHK4NXCLNDfl9hwK4zvdK4NO6eY0phhzr/NcFVjoMS1
 d2o7lvUQt5r+z3QIU5rAGp461xbE4hJELBDIVF/iy8hyNGY+/rz28kBHHGeQjJGFPk5u
 l+2/KGRwzXM+xBUan8DBIcjia+EX05nw55jk8O2TsjCzT0YtEHhaNd+T6ujhitGF9OtP
 KwfbAse2SQXNzQOCXnXz+ymOs1ji0mw8l66dURiUtv+Z4f+LFA2eQdLxK7OZwOKhl3pe
 dQrNZOm0crZMVruXz7GrNA4uve39b0KcHE8ConbcebW/RtRhHbIH/fjDXF8iDBstEpYu
 WhpQ==
X-Gm-Message-State: AFuF++mmowTq/rsyF9gLrKy7Ip43esyT7zP+dJ5GohLe1APuZHltYL0w
 vjoTBdhh9LfnIBaiddNPwyEKX/hPBmOLodqeGvTm/VWu8Nm4z1mBnRfwYV1Erz5bSpfBW6Txwg3
 RBxyj/qVVW8wI0obnBuzc8hTi+rCGbRF/nZ3gb/8ZVLjsPgxGf/SaBI5Azx7h7rgiYg==
X-Gm-Gg: AYBFou3bKEDXCi8rgMeC/LAn9m0U4bU9bzPxMbiRz/rW4SmuJzcvHm6FX6HjzUzJ/GP
 17MBCQe16MOQPC1fGBavfCv2kqdjzc+HnanfS1Rwn6Vz/0iFBkZhXMwo4Tt8cxd+MXWn5g8bOuD
 scmvku9mMyaN6FhbpAEHF78LXXvgSuY/Mn/stmAf/Mivv4qvdUUdxkve6GI9LzoFuUKbDLwYpJ/
 LDKMQGsCBZqe19EzmYkhZB3OOIVzNt0OS5B2iks4gV0VctxekVJsLm/UbnZfonJ2/Ama9mjvcMU
 fQ3J3lfsYTf89fo8HvYNzxNeM6zTlL3NhJfYOx5TaiMJsMV5WRgYRA4diAbnCQd4hDAShgqbix/
 lyn/RhvmDXhdPi4wnlorhe7pujJsvoIxM/rh/UY4cmZ2g+8/C
X-Received: by 2002:a17:90b:224c:b0:398:9bd4:d15 with SMTP id
 98e67ed59e1d1-39b26245d08mr812294a91.20.1788461786141; 
 Thu, 03 Sep 2026 11:56:26 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:398:9bd4:d15 with SMTP id
 98e67ed59e1d1-39b26245d08mr812228a91.20.1788461785688; 
 Thu, 03 Sep 2026 11:56:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/8] hw/hexagon: register the V68N_1024 machine
Date: Thu,  3 Sep 2026 11:56:15 -0700
Message-Id: <20260903185622.3234171-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99c2db cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LGeOnwBDO1WtItRKohQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Mkyofw-PyKNlqXQZFg4TcGl7cwlyGFlO
X-Proofpoint-ORIG-GUID: Mkyofw-PyKNlqXQZFg4TcGl7cwlyGFlO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXyYGPQs7qecEm
 0FHE4EvlfLB0CWyI/wvwKXHaeDNK96fzDuWj2k3fNyAOEkEkUvE1yTn4SGfCoEGlCXCJqLbR+F1
 qqdSYUQg2WbBjhhs3dPZ81ZKBRAXCcg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX0zcYGYrOu7nW
 A5bj7qhjNww03//P9l9QtI1RehXheyIh2hxZYaevzZjbQFReNPh/AyPIIIrTwlQAvEqm7EvVs+P
 fzjMgND4kAeTglN4MRBKQUeXH+Vov7u36LaBLCIrmFEnI0Y+SXB5XzkVaFJPiDsknRuPP7T5hyP
 5duFA9snjho+ikWWDOTLMAZZWxbcwjnk0Vp+Q1OSgrMP/jo+FAsVufsJIdgopGhGpiNc38W9xvn
 fHxzruQMqc3m1nXre58YBl7h4GdFxjoEHGCKa37VnxGXfVfASDoqzvgDUpQyQZT3jhpCNw/KLoJ
 4IX6xYEBRMmJEdcwXVH3D/dwWkJ9rY/+uWabBpve/zTddP1KQ+2w5Bud4fFJjblAAq9YQYoneKV
 d/HenZ6BKAy6TtgGrEjKTQ3HxchR2BLf0GmhLU1R0rVa6p2tl2MUPVjgqZ2epz+IAyfOBP+s3o4
 /0fS0CNDxq9y7FgnMhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhpcyBEU1AgZGVmaW5pdGlvbiBmaWxlIHdhcyBwcmVzZW50IGJ1dCBub3QgcmVmZXJlbmNlZC4g
IEFsc286IGFkZCBhCidzaW0nIGFsaWFzIGZvciB0aGlzIG1hY2hpbmUgdG8gaW5kaWNhdGUgYSBy
ZWNlbnQgbWFjaGluZSB3aXRoCm1lbW9yeS1tYXAgcmVzZW1ibGluZyB0aGF0IHVzZWQgYnkgJ2hl
eGFnb24tc2ltJy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgfCAyMyArKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMK
aW5kZXggNWIyYjZlMzEyYjYuLmZmMTEwMjM0YjA5IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0yOSw2ICsyOSw3
IEBACiAjaW5jbHVkZSAic2VtaWhvc3Rpbmcvc2VtaWhvc3QuaCIKIAogI2luY2x1ZGUgIm1hY2hp
bmVfY2ZnX3Y2NmdfMTAyNC5oLmluYyIKKyNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjhuXzEwMjQu
aC5pbmMiCiAKICNkZWZpbmUgVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FICJoZXhhZ29uLWRzcC1t
YWNoaW5lIgogT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSGV4YWdvbkRzcE1hY2hpbmVTdGF0
ZSwgSEVYQUdPTl9EU1BfTUFDSElORSkKQEAgLTE4MSw2ICsxODIsMjMgQEAgc3RhdGljIHZvaWQg
djY2Z18xMDI0X2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkICpkYXRhKQogICAgIG1j
LT5kZWZhdWx0X2NwdXMgPSA0OwogfQogCitzdGF0aWMgdm9pZCB2NjhuXzEwMjRfY29uZmlnX2lu
aXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQoreworICAgIGhleGFnb25fY29tbW9uX2luaXQobWFj
aGluZSwgdjY4X3JldiwgJnY2OG5fMTAyNCk7Cit9CisKK3N0YXRpYyB2b2lkIHY2OG5fMTAyNF9p
bml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKK3sKKyAgICBNYWNoaW5lQ2xh
c3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7CisKKyAgICBtYy0+ZGVzYyA9ICJIZXhhZ29uIFY2
OE5fMTAyNCI7CisgICAgbWMtPmFsaWFzID0gInNpbSI7CisgICAgbWMtPmluaXQgPSB2NjhuXzEw
MjRfY29uZmlnX2luaXQ7CisgICAgaW5pdF9tYyhtYyk7CisgICAgbWMtPmRlZmF1bHRfY3B1X3R5
cGUgPSBUWVBFX0hFWEFHT05fQ1BVX1Y2ODsKKyAgICBtYy0+ZGVmYXVsdF9jcHVzID0gNjsKK30K
Kwogc3RhdGljIGNvbnN0IFR5cGVJbmZvIGhleGFnb25fbWFjaGluZV90eXBlc1tdID0gewogICAg
IHsKICAgICAgICAgLm5hbWUgPSBUWVBFX0hFWEFHT05fQ09NTU9OX01BQ0hJTkUsCkBAIC0xOTks
NiArMjE3LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX21hY2hpbmVfdHlwZXNb
XSA9IHsKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1BfTUFDSElORSwKICAgICAg
ICAgLmNsYXNzX2luaXQgPSB2NjZnXzEwMjRfaW5pdCwKICAgICB9LAorICAgIHsKKyAgICAgICAg
Lm5hbWUgPSBNQUNISU5FX1RZUEVfTkFNRSgiVjY4Tl8xMDI0IiksCisgICAgICAgIC5wYXJlbnQg
PSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCisgICAgICAgIC5jbGFzc19pbml0ID0gdjY4bl8x
MDI0X2luaXQsCisgICAgfSwKIH07CiAKIERFRklORV9UWVBFUyhoZXhhZ29uX21hY2hpbmVfdHlw
ZXMpCi0tIAoyLjM0LjEKCg==

