Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D81C88E7B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68yX-0003LF-6k; Mon, 14 Sep 2026 11:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x68yI-00035G-Ar
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:51:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x68yE-0003CX-2I
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:51:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0RoB1761290
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=; b=D7q/+9NmbAaRsdQA
 ZzWHrFNJFaVsaPjPxl4xfEOnSxwVAYibw4jOvnU7MwYOLbVbLWwqcw1QOYAcDnjd
 /+VnWq0u1Kyu2EpxlDbMls3tA+SySUW9fbGwmqWDVnr9gT8jb7iyhAHFJQ1fwHvg
 pwQn6yuV1WOqtVHQKk94V6R8VZmjJ+A4z0qVXNcBn0DqYj4I69s0YY+8LcDtSg2B
 Ekk6B6fZAPGC8zzl0BH/sKbwZzeGEewhWX50Amzmfe4Dy1p02o1XoPceXK5paHJZ
 8LvLOuyceixKulZOpv4glGkBtD8PNlanCN5lW/lTBDQxjFu4/vAYv+QWBynAMFaY
 xkCIjA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeex9fs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:51:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4c1fc9ceaso2824996a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401103; x=1790005903; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=Sq1HyuKlQKceZxOm5dpseim6hH0T7LesZhDfdJ0pB5fOt0wgniPblTm6wvKspZ+SO7
 hcoqLnlqb7o2pR8UF184pqQLbHFHnLhC/KIBr9rdp7zDvW1UdRecB4ZMm59nt9KXaK8G
 /Kpxehay1RWPi32wWwYl6iwKPQ2aNhKxOsgqbLHkJnpsrH+UR3nw8dCikKxwgpSuzHPy
 OdiqTkHV77GVAMBsqE+tMio958DZZ9pO34CYHMuVJNqbM0jbvrtvfpQaV/6EX9kQ9B85
 ipZTcTn+UqSezOSHwuQWgLvUnm28OJsD8C0ZoTbFDWWJf7Nep8A11pRH1Q2eE3JwignK
 4DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401103; x=1790005903;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=eJeAxS9yKYuoluS0dpthWfkkgqrVXA6FxjSOeEsfq23nMjvaM3L6jD/p4JKZ3Ie6Ko
 AaEOLU49EyVgDWtA6kjFpnIp61Xh8aIf3AbL3VikCKoKV0Brq51cU6Hk8M0tJ28S/WrH
 gtvRwW/WUVGByAgK9g54FP88s9OA85hWpg/TXvNQFaOi5fNCDDSckWe9i+zzZqnuJi8C
 a46ZKRHhk2ihkClNcTaMYNBSnmvetOPonsfnmT9bT3G89iZIM/KC+x+X4ii5VuyR6v7u
 Mg5B5EusD1IW5ftktrjgWb3EJ3xOv4bTlDgbtZnmbJyrJoZLIcf03D9RMh4VKpBpIPAC
 zl7A==
X-Gm-Message-State: AFuF++koswhsFdDMixqLxkvVuwIYmmPutj/imw6ySuyB+aKxqz5Y7van
 7sVUNazuv7LW68jjPeZK1q7mJgGJdZWhZPA+470LTc2mFpZaYe3BCyTb7NkFXvl8IaMorHPdGRW
 BREOT4FyQF4xU4MCCJlCX9yTq9obAK846LdTP9o5rGSM0dEFpDBOeHAGKClJxo0p/ZA==
X-Gm-Gg: AYBFou0gINWrwQ0ZkRnyJlhelCZkJfwDiRhk6+SB8lOHawqn1NjsJB2zDI/QwXNEdgZ
 LCTVizabLTUQYou/wzoklvnd6J14qF7rnXKXtBdXUD8Ji82aIcwoQ89LcsqRZcsNrya9JV8wt5K
 Sh2l8KFO4VBgr9cHbnXtXz7WM0jBGyOb+SKN5jpHUiTj0O/Ijtro+J8eVz1MNY1t/ZczXYUdv+4
 ivxBmlgRqd6TDXPSMrdQht7oj4wPSn97ABqBPJiTu/buGTO7WcJ73FE3Od605wnrj8Eeiqs1EzP
 ZrRTQBO5wTDhR+QXNppxmq4eBB3xg7JWhzZ/RLmzMtOcGiyB+P+eP9La72g3y0YYsIkK2FhA22Z
 9CYfLi6+ePvGe08HhHsKkjilpbf5bxmsZuzBYKWpNwmI3MjE0
X-Received: by 2002:a17:903:1b63:b0:2bf:7b62:a038 with SMTP id
 d9443c01a7336-2dd6c60db2amr64469485ad.9.1789401102875; 
 Mon, 14 Sep 2026 08:51:42 -0700 (PDT)
X-Received: by 2002:a17:903:1b63:b0:2bf:7b62:a038 with SMTP id
 d9443c01a7336-2dd6c60db2amr64468835ad.9.1789401102311; 
 Mon, 14 Sep 2026 08:51:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfcefb6sm51824605ad.56.2026.09.14.08.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:51:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, marco.liebel@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 4/6] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Mon, 14 Sep 2026 08:51:32 -0700
Message-Id: <20260914155134.2191912-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914155134.2191912-1-brian.cain@oss.qualcomm.com>
References: <20260914155134.2191912-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfXyF60ElTnR9gZ
 9fZ9LVUdC66KdUlAXOttSnrHKPoadiqOMfcSkZFBnpvMbbAathX4QU/sVsSOzxQL+cUzzTMQMq2
 hmFz5qRkPTqAsCATlyVYREVtfIt/lP8zLPllfh0UAi3rrweX9KVQsOWvKDf2pfrZtP04EsXor6z
 WXkG+/Pt4dPb75m/6NeYIaC55HQyGCI1rzLgrZ4fyLvfZTO1XMl//VXyHDYw/L83pIbjsJSFVCI
 /+4scohjfwMGwkgfXHe4tAQkOruSTSkykvzaNcESuWNzocIb9wLwpZs+/7jVm2UAw5Vj06nVmMT
 wBxoIW9XFVMi0PqAaboH4leTRsTHg5dhq/rnPpax5DHjkVW3Ph/PDLnONO/XG65QghB44z0Bntv
 UXZMqoe6chA5A4nQE8in7WXmuC1n2jFZyEJF3w4nUb+URDbEUUsQcTFgdr7xEZDVxmMc5NIL7xp
 8bCaNJQyi/gO76H+0KA==
X-Proofpoint-GUID: hLOorAxI1CEGdaFpTaLezaZW2YOXEZdJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX5EH3XX5/5Hnp
 PTFE1chHF6JooVZvDcLwykqbOdjlIiwrzToc0GTQg05c+tAiw2+TKgyGkNjT0rOv4Rhg2J21AX5
 4R2mWUcKVn57MIpZrRodKJ2+sReE3p0=
X-Proofpoint-ORIG-GUID: hLOorAxI1CEGdaFpTaLezaZW2YOXEZdJ
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa81813 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140226
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

U1NSOlhFIGdhdGVzIGFjY2VzcyB0byB0aGUgSFZYIGNvcHJvY2Vzc29yOiBleGVjdXRpbmcgYW4g
SFZYIGluc3RydWN0aW9uCndoaWxlIGl0IGlzIGNsZWFyIG11c3QgcmFpc2UgYSBwcmVjaXNlIGV4
Y2VwdGlvbiB3aXRoIGNhdXNlIDB4MTYsCk5PX0NPUFJPQ19FTkFCTEUuCgpDYXJyeSBTU1I6WEUg
aW4gYSBUQiBmbGFnIGFuZCBlbWl0IHRoZSBleGNlcHRpb24gZm9yIHRoZQpmaXJzdCBIVlggcGFj
a2V0IG9mIGEgVEIgd2hlbiB0aGUgY29wcm9jZXNzb3IgaXMgZGlzYWJsZWQuCgpSZXZpZXdlZC1i
eTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5oICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgg
fCAgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgfCAgMiArKwogdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMgfCAxMSArKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4
YWdvbi9jcHUuaAppbmRleCBiMTUzMzY4MGJkNy4uOTdmNjg5ZmRhMjIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMDcsNiAr
MjA3LDcgQEAgc3RydWN0IEFyY2hDUFUgewogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1As
IDAsIDEpCiBGSUVMRChUQl9GTEFHUywgTU1VX0lOREVYLCAxLCAzKQogRklFTEQoVEJfRkxBR1Ms
IFBDWUNMRV9FTkFCTEVELCA0LCAxKQorRklFTEQoVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxF
RCwgNSwgMSkKIAogR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihD
UFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBkODYyODM4M2Yx
ZC4uYjg3YTJiMjBlMmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04OSw2ICs4OSw4IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOworICAgIGJvb2wgaHZ4X2NvcHJv
Y19lbmFibGVkOworICAgIGJvb2wgaHZ4X2NoZWNrX2VtaXR0ZWQ7CiAgICAgdWludDMyX3QgbnVt
X2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGZhZDUyNmNjZmI1Li4xOTQ4NmUwZjc0
MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTM0MCw2ICszNDAsOCBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dl
dF90Yl9jcHVfc3RhdGUoQ1BVU3RhdGUgKmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIo
aGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1X21tdV9pbmRleChlbnZfY3B1KGVudiksIGZhbHNlKSk7CiAgICAgaGV4X2ZsYWdzID0g
RklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwgMSk7CisgICAg
aGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VO
QUJMRUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwg
ZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOwogI2Vsc2UKICAgICBoZXhfZmxhZ3MgPSBGSUVM
RF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwgTU1VX1VTRVJfSURYKTsKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwppbmRleCBmZDFkZTg3NDA1Yy4uMGNiM2RiZTU0MjAgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCkBAIC03MjAsNiArNzIwLDE0IEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQo
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAgICBpID0gZmluZF9uZXh0X2JpdChjdHgtPnBy
ZWRpY2F0ZWRfdG1wX3ZyZWdzLCBOVU1fVlJFR1MsIGkgKyAxKTsKICAgICAgICAgfQogICAgIH0K
KworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGN0eC0+cGt0LnBrdF9oYXNfaHZ4
ICYmICFjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5odnhfY2hlY2tf
ZW1pdHRlZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NBVVNFX05PX0NP
UFJPQ19FTkFCTEUsIGN0eC0+cGt0LnBjKTsKKyAgICAgICAgY3R4LT5odnhfY2hlY2tfZW1pdHRl
ZCA9IHRydWU7CisgICAgfQorI2VuZGlmCiB9CiAKIGJvb2wgaXNfZ2F0aGVyX3N0b3JlX2luc24o
RGlzYXNDb250ZXh0ICpjdHgpCkBAIC0xMjM5LDYgKzEyNDcsOSBAQCBzdGF0aWMgdm9pZCBoZXhh
Z29uX3RyX2luaXRfZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgtPm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+
cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9F
TkFCTEVEKTsKKyAgICBjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCA9CisgICAgICAgIEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVEKTsKKyAgICBjdHgtPmh2
eF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5kaWYKIH0KIAotLSAKMi4zNC4xCgo=

