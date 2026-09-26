Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1C9C9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 19:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAY04-0001M0-MV; Sat, 26 Sep 2026 15:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzw-0001Jp-V7
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzu-0005rG-VP
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQj61329839
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=urX9KNUtS6Vb0ez98on+IA
 UFTKAIfQN9mrnQVDdIW5o=; b=eYqi3v5naXUl3Bk/O6IwUGBS7j2J+9tROEtpTx
 hbKNU2krtHM3WGd2IOVQYoBBNr2stUabEwYgUxUVoeEfdaqmsxnBkLvYZxwLMTss
 vE4sODLcjvOEFdwD8Gi9UlOtk8ZRqgmKNo7HjrQvfe8+RYiZ4LF/OprZ3v2WuGBX
 54jNgKUL3jiKPCJwDA4mYPRMvHy6hOx/7LlWaxqYnH6EByKBHlkJDtODru0rHZJH
 UY2YQwfl6npQAtterc+ZUGFQZ+VWcc64kWB9yzw5CJy89ZI9RaD4dCy7r7DDGjD0
 32wkLiBE3drp3uNdt4QJ6MFnfP+iZO/ntktZzEIVZULWobdg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50s9r1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3441e2b3fc3so102040eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790450622; x=1791055422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=urX9KNUtS6Vb0ez98on+IAUFTKAIfQN9mrnQVDdIW5o=;
 b=YYCKNIKSZAvDTVU9KZbCoi6Uk4HcN+KqHX15yzIgvv2JxyGyw1pA8mhKlozRjfFuw6
 mLiACXJ+KzlQv3P861rA5cWYtzcdQo9mEdpWnathDsayxgj+PXf+niww2S9h4d+xq1zl
 n1jQ7zNm65bwppWcqSTo3sKpyQE+cr/LW6YSxz+pwMfjkZxnjN3KYOA/TB6r//ffOJ2q
 M1xH5361HcflyPuzeGxFuGYyZr1U2hbhStnyMeOzoADu0szfFdkgOISXptIuCTgorYyj
 PcSmyHitDzHxg90fq/c/lnmUrUkdsJPatO3kD1JNkjDLUEiQa660u4uc3TTch38QAtKS
 Udxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790450622; x=1791055422;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=urX9KNUtS6Vb0ez98on+IAUFTKAIfQN9mrnQVDdIW5o=;
 b=AFSgeoY3EkP/Q+a3Y4/GSczfRgmYposKWkisVz4dYrn71iiH+Wd04I59FiJkM914Ni
 nPYGAsoODcB83c0eWDcqpK27W9AjL+msOcQAdkpT+R4i/1HKrmQ0w7YT8euxO7AbztqC
 fij7JXHfB/fLibDobFBzxzqA7HRm/9XFCK8ctWCWnGtP/kYTfUWH4Yno29BqUmNFxcsE
 lMkSV2TQVeYidw3nA10Vfap3wtxgk1/4RVPLJklzR3c/fTMfXKjwsqtwzHYXsc586L1a
 rA8xDcesWvyBPwwEQH5Zc6W7r7EqjRW1tKpltb+7KXpB2ZEK/PYqaalW37Xa8FgA9yeo
 uXoQ==
X-Gm-Message-State: AFuF++lyadl+fKYnndivYVQ4shLybwJ3eGb8v2WEhfIpKfWo+zggMyNf
 3HjDCUK264xQlAQ6cGasQfcoON6KOMCyoMGXGAbiBG0yT8AoEObMC0U+AszbGdBqsJ1ewbkIoSF
 PIEqyPQt1YRedBJA79OOXHcF5N+cd96X3tC0P5h6JkQRqmErGiWhBF0Q72L+K+qo5GA==
X-Gm-Gg: AYBFou0XgXl+KqZdxSc/vimrlbizisO2aQPfwiozcej2ld9ll88hv9dvEZ9VY1BAJHr
 vDWtWIp6pwL3hMKUeG16BlWZqVRbd+4GVhHd7qBwYTfbPMKqjRO2vO+A3CrgAHmZtqbpeFucusK
 pIsWnOOc8lIfkUCa4xYXF7ED2eshcmrvy1iJPT4Fe1mvhosn2diIicEO0EtZ4s0GboFnYY2RcMa
 hki5lwjUoz0ZYOUn/Uhr/bpx0n4WHVcsQjuT7ktRaAegPlVbsWRhWGjw3MdUUJHhemADWJcYTVd
 ZF5zN3dKRUnooDhwCXa3B3Ep3sMYbaa6PacvLAqT23dqijgjCXZQkp3eXsA3f6Wh4uF/FvjAteH
 ZL3hACrOQf1ayV7Djkzv9ODJQwcJi4Ldi5UQCckqlyYfKEBc=
X-Received: by 2002:a05:701b:418e:20b0:147:9ad0:cf25 with SMTP id
 a92af1059eb24-1479ad0d354mr2354473c88.46.1790450621281; 
 Sat, 26 Sep 2026 12:23:41 -0700 (PDT)
X-Received: by 2002:a05:701b:418e:20b0:147:9ad0:cf25 with SMTP id
 a92af1059eb24-1479ad0d354mr2354418c88.46.1790450620139; 
 Sat, 26 Sep 2026 12:23:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb6b9sm13526271c88.1.2026.09.26.12.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 12:23:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com
Subject: [PATCH 00/10] Hexagon: Add HVX floating point
Date: Sat, 26 Sep 2026 12:23:28 -0700
Message-Id: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfXwe9w2/P5koB9
 ICFJpQ5MMU7JlnyR+LPet1QznEZ5WAzBZ5ARgIWfQKvgrJ0kwf9WWF/rmxdwcwucZfI7SVkfRTn
 gAgJx1UIEm7rmUPpt9NTDijymREvHww=
X-Proofpoint-ORIG-GUID: cJRurq74BkGiGqMqHxbMYFEG9kMtLImw
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab81bbe cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ZtJshCMQQmV4bhcw92QA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfXyBBrGrXSST5T
 el0VrwNA6qImycyy86/PTqWreUTcnWZPovaczCBfhcug2agb6KcHJdHjAScThoieG3No5EREZtu
 0117U02n6k2InI74TG1DcUo9IrSeNF27C1vzpHI4Ss56fzvAg40IkqIUxJFYFdoxUOYBx/gihsS
 kzFYgVz80nL20UZtt3GoGDxp4niwt3Crq8kstouiT0VX7oG/n0lR0WsE7ghfk3DxbIp3jw5QSBw
 A+CrfE+BsLZGLxIsPtEy5Qjn7Hr9YlQk+LHBh+zhQqeK28Ba/0zUCHlayz6wtFIUqfYlyfU1zVF
 I0KqQSnbPcBR+2z39GB9kUNYlnFq17NlfB7udTRpSEZqV2pj30axspiipMOI2gVEPL2QULfjmid
 ZqNMGh22f6aCksOmIncpsSwZB6h8Fl358I0fw2RgwJlSk4FZ+yOIdIjHvY7nx0sf2OUfV9IA6VY
 ON8Y9LupvA4yNgigsPQ==
X-Proofpoint-GUID: cJRurq74BkGiGqMqHxbMYFEG9kMtLImw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260077
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

SFZYIGZsb2F0aW5nIHBvaW50IChha2EgUUZsb2F0KSBpcyBhIGZsb2F0IHJlcHJlc2VudGF0aW9u
IHRoYXQgY2FuIGJlIHVzZWQKYXMgYW4gYWx0ZXJuYXRpdmUgdG8gSUVFRSBmbG9hdGluZy1wb2lu
dC4gIFRoZSBjb252ZW50aW9uYWwgdXNlIGNhc2UgaXMgZm9yCmxvYWRzL3N0b3JlcyB0byB1c2Ug
SUVFRSBzaW5nbGUvaGFsZiBwcmVjaXNpb24gYW5kIGNvbXB1dGF0aW9uIGxvY2FsIHRvIHRoZQpE
U1AgdXNlcyBxZmxvYXQuCgpBbHNvOiBleHRlbmRlZC1xZmxvYXQgc2VtYW50aWNzIGFyZSBwcm92
aWRlZCBmb3Igdjc5IGFuZCBsYXRlci4KCkJyaWFuIENhaW4gKDEwKToKICB0YXJnZXQvaGV4YWdv
bjogQWxsb3cgdGVtcG9yYXJ5IEhWWCB3cml0ZSBhbmQgZnV0dXJlIHdyaXRlCiAgdGVzdHMvdGNn
L2hleGFnb246IENvdmVyIEhWWCB2ZWN0b3Igd3JpdGUgY29uZmxpY3RzCiAgdGFyZ2V0L2hleGFn
b246IGFkZCB2ODEgSFZYIGNvbXBhcmUsIGFsaWduLCBhbmQgY29udmVydCBpbnN0cnVjdGlvbnMK
ICB0YXJnZXQvaGV4YWdvbjogZml4IFY2X3ZjbW92IHJlc2VydmVkLWJpdCBlbmNvZGluZwogIHRh
cmdldC9oZXhhZ29uOiB1c2UgdmVjdG9yIHBheWxvYWQgc2l6ZSBmb3IgSFZYIG9wZXJhdGlvbnMK
ICB0YXJnZXQvaGV4YWdvbjogcmVzZXJ2ZSBpbnRlcm5hbCBIVlggdmVjdG9yIHN0YXRlIGZvciBR
RmxvYXQKICB0YXJnZXQvaGV4YWdvbjogYWRkIHRoZSBRRmxvYXQgbG9naWMKICB0YXJnZXQvaGV4
YWdvbjogc2VsZWN0IFFGbG9hdCBpbnN0IHNlbWFudGljcyBieSByZXYKICBsaW51eC11c2VyL2hl
eGFnb246IGFkZCB2NzUtdjgxIEhXQ0FQcwogIHRlc3RzL3RjZy9oZXhhZ29uOiBhZGQgdjgxLCBl
eHQtUUZsb2F0IHRlc3RzCgogZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0ICAgICAg
ICAgICAgfCAgIDggKy0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggICAgICAgICAgICAg
ICAgIHwgMjQyICsrKy0tLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X2llZWVfZnAuaCAgICAg
ICAgICAgfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgICAg
ICAgfCAxMTkgKystCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9tbXZlYy5oICAgICAgICAgICAgICAg
ICB8ICA5MCArLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvbW12ZWNfcWZsb2F0LmggICAgICAgICAg
fCAxMzMgKysrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAgICB8
ICAxMyArLQogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgICAgICAgICAgfCAg
IDIgKwogaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMgICAgICAgICAgICAgfCAgIDUg
KwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICAgICAgICAgICAgICAgfCAgIDkgKwog
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTggKy0KIHRh
cmdldC9oZXhhZ29uL21tdmVjL2h2eF9pZWVlX2ZwLmMgICAgICAgICAgIHwgIDE1ICsKIHRhcmdl
dC9oZXhhZ29uL21tdmVjL2h2eF9xZmxvYXQuYyAgICAgICAgICAgIHwgODMxICsrKysrKysrKysr
KysrKysrKysKIHRhcmdldC9oZXhhZ29uL21tdmVjL3N5c3RlbV9leHRfbW12ZWMuYyAgICAgIHwg
ICA4ICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgICB8ICAz
NCArLQogdGVzdHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dhdGluZy5jICAgICAgICAgfCAgMTIg
Ky0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9leHQuYyAgICAgICAgICAgICAgICAgIHwgMjIyICsr
KysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYyAgICAgICAgICB8ICA5OCAr
KysKIHRlc3RzL3RjZy9oZXhhZ29uL3FmbG9hdF92ODEuYyAgICAgICAgICAgICAgIHwgMTE5ICsr
KwogdGVzdHMvdGNnL2hleGFnb24vdjgxX2h2eC5jICAgICAgICAgICAgICAgICAgfCAyMjAgKysr
KysKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYyAgICAgICAgICAgIHwgIDU0ICsr
CiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAgICAgICAgICB8ICAyOSArCiB0
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiB8ICA2MyArLQogdGFy
Z2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZXh0LmlkZWYgICAgICAgfCAyMzYgKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0ZXN0
cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICB8ICAyNSArCiAyNiBmaWxl
cyBjaGFuZ2VkLCAyNDE3IGluc2VydGlvbnMoKyksIDE5MSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9tbXZlYy9tbXZlY19xZmxvYXQuaAogY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL21tdmVjL2h2eF9xZmxvYXQuYwogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9leHQuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3RjZy9oZXhhZ29uL3FmbG9hdF92ODEuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Rj
Zy9oZXhhZ29uL3Y4MV9odnguYwoKLS0gCjIuMzQuMQoK

