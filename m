Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CC71039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4b5-0000MU-Jc; Fri, 27 Feb 2026 15:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4ac-00080V-6k
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aY-0006ul-Hs
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:32 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIeta5373605
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XruJprU6aeeyyvkA+JkFG2kI3SjO3ayzcX4W88MzOx8=; b=Ac1gNI+np2yxXMaL
 iwdzhTwCsUuMCkXdsscf+rw/Po7cY/xrCDLnNrNIrz35/zECfVzjfc1dH/qHJubo
 fv2fJjZELUWqOFghQHdM+M6VxqwNUIoqz6AeaY8ji+tYtZpZrHmbrPdRlzoZCyJj
 iONeamWRGKkN80yCMPZs58sIxRJ2mNCt+FlbgAlqMDgWWecdZQWZrMG6JhjP7cA4
 IEs6XUK8wxGmE5UhToUkYoUtUkNg3RNy7kDgeO8QWuWF3Y2pZh1IXi2Ayv09NOnl
 aD+Lgy9BZ1focrfy/ITuOz8WgVSjdrNin9oicuvKvurUk/ISd5xGFPZlUgJTu/6R
 Wri75Q==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtravm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:18 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d496d080d8so20115539a34.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224638; x=1772829438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XruJprU6aeeyyvkA+JkFG2kI3SjO3ayzcX4W88MzOx8=;
 b=F574/7x7Sdi6AWjLkWKT7BzuNIOf1M/RvXy1n27FSqVRQKUfufnyVzY/E1kJucHmz6
 rZFZQW2ozvwHURbXFunrzPuA/zZLe/LrGkmRft/gNhUj3fEWDHqnfAziB7VQz5eMBF9k
 oZjtlm2rrAy3rU7/ZLw3c62OW6KSubpVtfmqgzJBtPh8io47cfd6zsggUZd0UP4tP0SM
 3JkIT+QiUjRpr6bKsLI+BdXzBtQsEiajfeGFqpsu27W6zlYl9tzcjwG54uj+VzPasbj+
 dFvgA90dSt/Mp3zcqR/lNlYjaOs9lKzFZQoFd63wGfSnFytwUSV74MgxI9NiPys2Yq1d
 DqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224638; x=1772829438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XruJprU6aeeyyvkA+JkFG2kI3SjO3ayzcX4W88MzOx8=;
 b=L+b9Vg+trRiTpnyGJItulHk1d2N1BXDDzpJG40STVsqgJhd+K4Jd7L1SNfdksk0QRE
 01bVu1zeC1YuiZ5Qts0WMP5QDU6vgc+xc1GHUr0Lzprx3zPoOqEk9BbWdSHksi7SkEIq
 YDgEUNhEgGiY1gM0aBO4feMFTziZAZlla6JZacDetjijpK/amMMSKaCwVaSI4yVZaK7B
 qpnmQrhYoLOUy8weHOk01GeTDc2qn3Xgwat8QSHchSjV7jOBODOTQ8sqawf2VaBiz5no
 f0UFI5sqmtxcasUTu/gei1Aai+Y3RNK4y0PN8dkwnAP0SgJ3ltPy5IdZe9Ft/QbmtUvB
 WOaQ==
X-Gm-Message-State: AOJu0Yxhb7zi7V8M+ZqEoYiy/mH3ROY6DdC5Tq6YhYTBOPJzZSDVy5Vi
 G+w5E4K3dWn7HE3jz+ayYzTAMMLL/WClfMtHml5ClhqKsc/9PqyNkX224/Kk0qIvCA3u9AA4onU
 NnAuxhq59pUaik6AJYxHmV8Mc7ktMgtLg2e6o2XHaFPFp8J5A6BfM8mYQkR/aCFw5XQ==
X-Gm-Gg: ATEYQzwomZyNDHVXmNzoC8L04xkIeDtVDPTAn/LNakNriTEvVC55bSq13n3zr6Z/CaJ
 ljV3x/37luKSr3QHBiPhLI2FquxLzxjaA8/GfUJzYvcH6r0y6gFvodjPJpzDUsbz5DDn4dky79l
 ziAIGvwL5Orh3MrjbuNaoLxDD6v1rkGv7jlT/KZ2VK8j0jk147W/oSnsBviVTiIxSZ7mLU+bJlq
 otosF/Wal7KnLfvdDH7KKtNYB3yKUopodanLtT7twFDY9s0lmtqj7A699eZWql1n5b9tj/Ggo0q
 ON1XNRPIyomM7n6CFNjnnZfMD4aQ+MgPZqO4Ylbidys+dSQOv+l4ZhTIdgtVfSmuyCxf3fSiJqh
 roLh5i5taj+McmR31fC1V6fNbziVvVMTDSrR4bCBFyRyad8PK7jaKnZ0YhaI2W0SUrfSnQg==
X-Received: by 2002:a05:687c:20ea:b0:409:6862:abad with SMTP id
 586e51a60fabf-41626e8a9b6mr2507524fac.20.1772224637933; 
 Fri, 27 Feb 2026 12:37:17 -0800 (PST)
X-Received: by 2002:a05:687c:20ea:b0:409:6862:abad with SMTP id
 586e51a60fabf-41626e8a9b6mr2507509fac.20.1772224637522; 
 Fri, 27 Feb 2026 12:37:17 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 35/37] target/hexagon: Add clear_wait_mode() definition
Date: Fri, 27 Feb 2026 12:36:25 -0800
Message-Id: <20260227203627.932864-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a2007e cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=InO9qlFFT13rIqmD9gwA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QvUSdq0ZoNLKxkwvrUTFU1QR3d8Zc_5-
X-Proofpoint-ORIG-GUID: QvUSdq0ZoNLKxkwvrUTFU1QR3d8Zc_5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5X4vi6UPl5cA
 ARIZza0UcClvPtsOoweSk9QjubWfw97qT1FbMLB7oigkt9LdYCDTncUfPTWxoLV2MtZJbHywSoQ
 SINrq4Y+zLD4cBCI52VeqqaO8e+rU8wZtMJs86EPpFasErZaL7SPlVZaq6zhFaakaMZ0xMBboI7
 8TzPWQknfxPxai6ya+uRZPmGiHQ3yQvT0XPfFZo4jGGvG2lzKMSPf+CPrAattd5ShIjB/iIotPW
 dJwyHSt07h6pJQ8ATZL3bZd3mT6wGYgStdFrmBQInWl45NlmiakegugURD+nwd1m9RniZm1XR1c
 s0xW9udU0MHAVoGHHI7DI+8c2rVJVy50cWJhB+j5ivsZtzs43o+ptlNT8j6D3YMO8bJx/yLw0rd
 8MZeIz2ls2ufk3k6yCMxOL4FHMR8xdz1JWCkp90Xw7JoZI3enWBTXGvEQJUTHvsINWlztRJuHMP
 dIyTq3lEpBoVsNLi6rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyB8IDEzICsrKysr
KysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIu
aAppbmRleCA5NTkyOGZjZDA2MC4uMzBhMzIwNTk1N2EgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKQEAgLTE2
LDYgKzE2LDcgQEAgdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QpOwogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2Nv
dW50X2hpZ2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90KTsKIHZvaWQgaGV4YWdvbl9t
b2RpZnlfc3NyKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9s
ZCk7CiBpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQgY2xlYXJf
d2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogc3RhdGljIGlubGluZSB2b2lkIGFy
Y2hfc2V0X3RocmVhZF9yZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZhbCkKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9o
ZWxwZXIuYwppbmRleCBjYWI0MGIzNmNkYy4uYjZlY2U3ODVhZGIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2NwdV9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMK
QEAgLTcxLDYgKzcxLDE5IEBAIHZvaWQgaGV4YWdvbl9tb2RpZnlfc3NyKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKICAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOwogfQogCit2b2lkIGNsZWFyX3dhaXRfbW9kZShDUFVIZXhhZ29uU3RhdGUgKmVudikK
K3sKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgSGV4YWdvbkNQVSAqY3B1ID0g
ZW52X2FyY2hjcHUoZW52KTsKKyAgICBpZiAoY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIGNv
bnN0IHVpbnQzMl90IG1vZGVjdGwgPSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdf
TU9ERUNUTCk7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF93YWl0X21hc2sgPSBHRVRfRklFTEQo
TU9ERUNUTF9XLCBtb2RlY3RsKTsKKyAgICAgICAgdGhyZWFkX3dhaXRfbWFzayAmPSB+KDB4MSA8
PCBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVH
X01PREVDVEwsIE1PREVDVExfVywgdGhyZWFkX3dhaXRfbWFzayk7CisgICAgfQorfQorCiBpbnQg
Z2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KQogewogICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7Ci0tIAoyLjM0LjEKCg==

