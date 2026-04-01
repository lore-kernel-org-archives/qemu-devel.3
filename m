Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B7610F6FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUl-00014J-45; Wed, 01 Apr 2026 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUU-0000q6-Kt
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUT-00086Q-5d
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CTJVj1285924
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pKqI6/6w8auvuZzpUaRDsKPpNshETe3zqMoFX1J9MWU=; b=OMFngF1WG8M/HoQF
 DV6RntR6du2nfKo+bkerk9t1WJh2VZqt5qnoIryGIy7GyvCTG5a3yx7wLI5NciyA
 nQ32dCfY403suTa/4UQclaUqr0N8GXo22A5TZv4/+TF6asErgAtrTThdx71b+mFL
 Jcvhx61c/MqjUiZTpaP5/rcbt2gQtTwklsEOAU90prDMSIJOY6ydLhjj38Qxkzol
 RKJe4pqMac0wlGBvfc2rxaFhQ8dGTJVoWsWLsEMx5jo57yWLejx3Qin8hR/Ec8b9
 SGeJAIFOqYLMBLILrLwXTX+It/zSret6p3RV3Ocsn6oRhI0gjRZIGLqXUtyYv5OQ
 tKGuow==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t2wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so6985492eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057291; x=1775662091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKqI6/6w8auvuZzpUaRDsKPpNshETe3zqMoFX1J9MWU=;
 b=Ttaqy1XtzJJBtqoEaTzK46mBYHzSUmZ4zd9ucBXRALCoIfVQ5n5SAP+DS/vgXBPMrh
 /nZ55LSCx2Jx48jNAsVS/WkAeDu+C9VIcHFVdLrjOviv5tRiAlH6qDoexuIRtbsewtZI
 EwCSJ/fAofk6ETAq9J8M/ueqniYJ5NUpaOtiVH7IN1ryEaBDvRWHRzBnLnzDq0V5A4Up
 daY27ZI/kHa5sQb55kNa9M7+31Yz5QSuzI6fOefuj1OS6+GQlZQPSVn4TTKb1zQf6C4y
 Gy2fz6iOO8ZlCSRt+UzoQULAPQLb3m0s2B4ZXQILXmAmeGRSu1eWmEaR9PiSD8HOgcdB
 6GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057291; x=1775662091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pKqI6/6w8auvuZzpUaRDsKPpNshETe3zqMoFX1J9MWU=;
 b=gAWrf5LWsofHErTUXiunluTFfFo2RY4fm87FysoY+eukrtDuT3Mq7WvuLIQteLZ8gC
 dHyWugaIeMuJzgim8l9TM8nda0S/yIQbi9RIgYnuU6ehcSvO74Axq3usebpbfazyk6G3
 02GjmtzBMQiM+c0o4O6EzygFV8upIA721HKBPVjau6OAhN9XRuV+qmuss+YH+AMMmvoS
 7phXDIKgf6QBHmkCNDf53ekXR2E87TC1GjMJETCd57eX9sYZSOzIjdD2J/7HyZscsYii
 K/PLh9ylg2y9kQr+y6/SbbNrVdHpJciF0upSTO6X9aw+GyBtwKSRBT5snNNRUFLGE0Vf
 grlw==
X-Gm-Message-State: AOJu0Ywi1azCHTzw4HwdtOUQsuSNW7F9zar7VTQEoLXkYCzdmq3vh70s
 IqG/7y7Umw94YMu5vZRJjFyLnqYqgb6LsmI3DYKil3s5Cw0dB+FAE6CCqcQYUwPAIsgrqmztlK0
 tsrLilmG0vobZajc86/mgtP5m14vcKWMw2lwpzzH8MCAboyvtAN6up7x+nCSgtSiFHA==
X-Gm-Gg: ATEYQzw1/CjJbbhALaz8CR3X10uS3LdhHzMkrt5oQZ7mx1gxr0qa2gK8ZU31SJqIf23
 3e5tKnHeAwDzYlFeqx3PoEJPxLh+7F3YwMkWvPmYLzfyrOOSnR1bmA06bAE5PXna5S5A5KTJI6+
 x+e8RB+S2lkWi9TqwSMfCYwZASR/FLLecCWvKUZYqtNSL8Kj/os0s8hPqSZkuItbSBYWqPgf1As
 rbs+KQVsJfKD3q23o3ilVG/nXhLydmQGXvo0UgHJsESZmC50EKTCl8Wb0tqxmSNrQuCzXBWKn+m
 2VBkLixssbMYmHglkSJKpRezVczd6CqDFM5Qra7r/nSowsvtCpmXUwxEggbkrLyzoVPgytnTtTa
 w1Ytt6W6fZiT1wyVg2/PBx3lw/p+SzVhuD9LzfyM/h/LQuVXvAcCbDtKnU6C9hAXUlC+0XA==
X-Received: by 2002:a05:7301:fa0d:b0:2c4:a862:2372 with SMTP id
 5a478bee46e88-2c931165e5fmr2058705eec.9.1775057290661; 
 Wed, 01 Apr 2026 08:28:10 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0d:b0:2c4:a862:2372 with SMTP id
 5a478bee46e88-2c931165e5fmr2058676eec.9.1775057290137; 
 Wed, 01 Apr 2026 08:28:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 27/37] target/hexagon: Add TCG overrides for thread ctl
Date: Wed,  1 Apr 2026 08:26:47 -0700
Message-Id: <20260401152657.314902-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd3992 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8FnppmVfI74T_ljyO2pb0m6xGhR1nO3O
X-Proofpoint-GUID: 8FnppmVfI74T_ljyO2pb0m6xGhR1nO3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfXz60awt4tObeC
 abVOHPANy6myqV9+/UDXEiovPW2TuUAYgKSQWbjvjzEl98BsJybTGMH6kbYCNzNXgEYHvL1tPwA
 kukoSCqVB1uNqHx0YAkJw7UIVcX90TozGnwIXYuEU98oUy/2joySw9Lj1Pn6sEAhOTlINQuUZlO
 6ph4GBpah96tm60S02tF8q68X+tEQkRDjWYyuU3994DpAsKigjK6VRrL5jNrEjHMk3+McKMAbEc
 2T/FpxNYAzz1vRMYL/XtPxQQjdojBat7OjBM4jqB7prqUOF085y6K14safBYqsAOkWb5Kx41hIu
 MKrhGQLYh+3F54PWu+sr2Uh0FrG8XwYAF83NABLGlWWQ8K8lHRljznIi5nmRXQQinaXogeilIFW
 HYO86QGiqlwzj8NMD0vkXyK6vR4S3V4rwx/mwedRRWIHP2MF6CaysZPAzcMAEWPLP8/17T6NDFa
 PcxVReNmhdMjNoRF+pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgoKUmV2aWV3ZWQt
Ynk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMTggKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaCAgICAgIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCBjYzcyY2E4NmRiOC4uNzM5ZTk1ZWE2MGIgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19zeXMuaApAQCAtNjIsNCArNjIsMjIgQEAKICAgICAgICAgdGNnX2dlbl9leHRy
aF9pNjRfaTMyKGN0eC0+dF9zcmVnX25ld192YWx1ZVtIRVhfU1JFR19TR1AxXSwgdG1wKTsgXAog
ICAgIH0gd2hpbGUgKDApCiAKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfd2FpdChTSE9SVENPREUpIFwK
KyAgICBkbyB7IFwKKyAgICAgICAgUnNWID0gUnNWOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2Fp
dCh0Y2dfZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QtPnBjKSk7IFwKKyAgICB9IHdoaWxl
ICgwKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX3Jlc3VtZShTSE9SVENPREUpIFwKKyAgICBnZW5f
aGVscGVyX3Jlc3VtZSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfc3RhcnQo
U0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9zdGFydCh0Y2dfZW52LCBSc1YpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfWTJfc3RvcChTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgUnNW
ID0gUnNWOyBcCisgICAgICAgIGdlbl9oZWxwZXJfc3RvcCh0Y2dfZW52KTsgXAorICAgIH0gd2hp
bGUgKDApCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCA5NTUyODcxMzNlNC4uNjgyZjBjNmMyNmUgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
bHBlci5oCkBAIC0xMjMsNCArMTIzLDggQEAgREVGX0hFTFBFUl8yKGdyZWdfcmVhZCwgaTMyLCBl
bnYsIGkzMikKIERFRl9IRUxQRVJfMihncmVnX3JlYWRfcGFpciwgaTY0LCBlbnYsIGkzMikKIERF
Rl9IRUxQRVJfMyhzcmVnX3dyaXRlX21hc2tlZCwgdm9pZCwgZW52LCBpMzIsIGkzMikKIERFRl9I
RUxQRVJfMyhzZXRwcmlvLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hFTFBFUl8yKHN0YXJ0
LCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMShzdG9wLCB2b2lkLCBlbnYpCitERUZfSEVM
UEVSXzIod2FpdCwgdm9pZCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIocmVzdW1lLCB2b2lkLCBl
bnYsIGkzMikKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
Yi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBlZTI4MmU2NmU4Ni4uZGEwMGRmZDY1
YzMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDE5LDYgKzE0MTksMjYgQEAgdWludDMyX3QgSEVMUEVS
KGlhc3NpZ25yKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CiB9CiAKK3ZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgaW1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsK
K30KKwordm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgZ19h
c3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihyZXN1bWUpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCBtYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKIHVpbnQzMl90IEhF
TFBFUihnZXRpbWFzaykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCkKIHsKICAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

