Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C09C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9m-0008IJ-Ta; Tue, 18 Aug 2026 21:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9l-0008Hv-68
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9j-0008Bx-GM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkhn43326187
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KeSI/zwFC3K382axD8qAUD
 l5JKULXNvIWdPTu1y41Cs=; b=QcM9PExefHxAGagPk0e5robAUo3xgHriNr84gl
 kpYFZy1JrCB+p3WEeGE3zA5FdX6P8PNrmCtXAgAz4ZnNBxho3QFMLnrGaEqrCvxb
 0z1lcrASqo2Lu6l9JyGSdWWLsdczVNXRd/hEpWB1WS85mNWWfMjBcOmm5LqaNmvy
 41dkqt1+tCR42aLpPwbFj+ilijBtXggEaJLk6twWm5QAbqagDupyaO/kNs9R7zvu
 IK+Wdb7+b37DKWec+C+0peq0MpOJeE6HVJxic/w0b8HhZHN5hHGHVEdeTSxpiBK1
 wAE2QddEoYMZ1qnarrCxNNaAZ8908b4IiU8CGbfKdPFw+Vtg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfprq89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so463680a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103107; x=1787707907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KeSI/zwFC3K382axD8qAUDl5JKULXNvIWdPTu1y41Cs=;
 b=KCoYpUt37Cb45vHxjW3L42nv11LO3qnrXhdv4ocnyMJMEE0DsDJPJQzCw4WawtRjDw
 q0yjiSmAjogLPrZU1YHx70+rgon6UHiqbe7yGVWAamvq7hBdASJbnvvloORSvag1yUot
 p4WdFPHLLi5UftIBbszVRU0t1QHD+7TxQMpwLjDnvjnK+0u2DbvKbNIqDJLRjForZe+B
 AC9fOmkYHQbqaehMxCbKFwcKADXmRS+t38M4UwLlm+2+axFcuj7rZXlybLp4rzbo7Yip
 3UuMfC7AUvFFSvA8ZugpWJvxhFVZMJAC+jktqYQf34Ge5/jGqxsBkA+4733g3zMwM3qd
 +pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103107; x=1787707907;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KeSI/zwFC3K382axD8qAUDl5JKULXNvIWdPTu1y41Cs=;
 b=X+W1hv+rCGRxnq3zlcCjbFFqTVbGGXFJErcoaCtjOfZs3xSYItHPYdqlGS7lAwaz3k
 S5dtnwH5hWSBZrV67Y4hbi3AC6woOOU9o9uTF4l1i2tDUDB5USVEVLNAb4Lg9BGPTKzn
 YSSLPIFT+vDekNyCtvdaY1mvMZB+ump2cHIPoNFy2Blzoillt1+S17e/FoDFSJ1Lj9cD
 vVS2cgV7m0Zz6RqeRcb9Fx4dx/ybMt3I9IFbCYstXTDGnmYfxQAfQhMLVqxS9Ltas419
 73dvFUINn+ttz26e9iBN1p1HwAQtUEXCL+7dVU+FFHrR8kDYAK1j/L8/tj4V6yJB2Ux0
 e0iQ==
X-Gm-Message-State: AOJu0Yz0Ob5P26pVyMzzL80jjUI6yMJYXklgvLZ4BKVriJW2rRcSk6CM
 HmoDDj5x5qC+68KYKaG3/VQD1g9KOiMbc7eowfK7uz5Kc7kzQvXuOAROimw0SymR7J50LgcS3qF
 EQQYAFdLoP0I36eq99DDcG9Ek1FvYAloav1+laT9gL+Dg016Ea4FA2mR0cKYV6saXzg==
X-Gm-Gg: AR+sD12RQwjr+9xDFFTuphTUgKSynTulbCiL/78QouHQQhJ5bYvbAgFPKOWvuUJPphj
 8XfnZsYXTZJZlau+aVPT0cvQ8+rX80IjoxHEmD6ygTKgVuo66kVZUgol/CWVNCVwegJURU28rF8
 7N38RthgJKIkDwGMqXuw4HTkwtWjjtS5mgchtAkHLZLQ6DUJ3N9RcHFUD1I6c05dLtKOIj7xglr
 yu82u53rk7dT1w5KGimXfNIbixbvZR0uVW7Pold1HnGMCeicm716f8YItuxbnCPAdVX+iupmE0n
 bJn9HFVmOlY+UvbMXam5dufMdygrSvej1AkIQzegzKnuJKopc96wxZZQNauj1jfb+usSDw/Oegw
 vKf4/4yc/3e7XLM0ITRTOSekt7xZ5RVQDlnIYgmj9uxcj3rW+
X-Received: by 2002:a17:90a:d408:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3957f8b2a07mr1864660a91.8.1787103107196; 
 Tue, 18 Aug 2026 18:31:47 -0700 (PDT)
X-Received: by 2002:a17:90a:d408:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3957f8b2a07mr1864570a91.8.1787103106640; 
 Tue, 18 Aug 2026 18:31:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 00/11] Hexagon: exception, interrupt, system reg fixes
Date: Tue, 18 Aug 2026 18:31:33 -0700
Message-Id: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: dxPVF15dLOVYNWvdnzPuANcdx7-47H0U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX+YBV4eJj1VSj
 7iI2b/BIzclf16Ei2Lhq+oeuCAhKs9wdSWrf2F0ex9oYX78BfifHo1piRXzdWVvzoFPM/0Y85Bf
 LVT7E3X0LdKFoKCHqDtU2bNGVPNWn3dskjECLWf6jgeyKfD6JeuPZaJs0zE19XWRN+2Y22xMr1o
 tLifqMOBe1/HzM1AhWKXF7MSce5iqRc67pcia6MyKWwbeU2EycqI2dea+Klqb0W9YZ/1LleFfvG
 KwYZozg6SMaolVDOq5CwmgedDST/kZaYwSUSy6vMtzR47SvgiafVpqhxmKuOlzxHIlUuw8T7lAo
 eaaKokQuNSTXw39rFvKckTMkyLtmytJ/dGp4qPXmAtkEnMztggHYBMgUutEQU3ShULUsumPUjSy
 IDwNzH4WfI9znEezi4utSWSPi377AgbEf6CK+oOrlDab+oG6hZVjb1zGAAOkl5kOrJvhhmmtAJM
 P3AsZ2L/WbBqxU0tfYQ==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a850784 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=-t2gi_CsGC9hvwCbGDEA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: dxPVF15dLOVYNWvdnzPuANcdx7-47H0U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX/zzGnbMswAq5
 hUk6wKIe+r6jBPl7vKEV3zrkLBE8u+Iy2DbZbracYliAeDj5M0x1uKYx+hxvXyLsoehIUEjfxWl
 T/t9IlT9gEUjtMnVrt88na0SubsJpiY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
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

Q2hhbmdlcyB0byBhZGRyZXNzIHNvbWUgdGVzdCBjYXNlczoKLSB1c2VyL3N5c3RlbSBtb2RlIGV4
Y2VwdGlvbiBjb25zb2xpZGF0aW9uCi0gRGlyZWN0LXRvLUd1ZXN0IGludGVycnVwdCBkZWxpdmVy
eQotIGludGVycnVwdCBtYXNrIHdyaXRlcywgdGxiIHByb2JlIGV4Y2VwdGlvbgotIGwydmljIGVk
Z2UtdHJpZ2dlciBjbGVhciBvbiBkZWFzc2VydAotIG1hcCBhcmNoaXRlY3R1cmFsIHRpbWVyIHJl
Z3MgdG8gY2xvY2sKCkJyaWFuIENhaW4gKDEwKToKICB0YXJnZXQvaGV4YWdvbjogYWxpZ24gZXhj
ZXB0aW9ucyBmb3IgdXNlci9zeXNlbXUKICB0ZXN0cy90Y2cvaGV4YWdvbjogY2hlY2sgcHJpdiBp
bnN0cnVjdGlvbnMgcmFpc2UgU0lHSUxMCiAgdGFyZ2V0L2hleGFnb246IGd1YXJkIHdyaXRlcyB0
byB1bmltcGxlbWVudGVkIGd1ZXN0IHJlZ2lzdGVycwogIHRhcmdldC9oZXhhZ29uOiB0YWtlIEJR
TCB3aGVuIHJlYWRpbmcgdGhlIHN5c3RlbSBwY3ljbGUgY291bnQKICB0YXJnZXQvaGV4YWdvbjog
Z2F0ZSBHUENZQ0xFIGd1ZXN0IHJlZ2lzdGVyIHJlYWRzIG9uIFNTUjpDRQogIHRhcmdldC9oZXhh
Z29uOiByZWFkIFVUSU1FUkxPL1VUSU1FUkhJIGZyb20gdGhlIGdsb2JhbCB0aW1lcgogIHRhcmdl
dC9oZXhhZ29uOiByYWlzZSBpbXByZWNpc2UgZXhjZXB0aW9uIG9uIG11bHRpLVRMQiBtYXRjaAog
IHRhcmdldC9oZXhhZ29uOiBpbXBsZW1lbnQgZGlyZWN0LXRvLWd1ZXN0IGludGVycnVwdCBkZWxp
dmVyeQogIHRhcmdldC9oZXhhZ29uOiBmaXggaWFzc2lnbntyLHd9IHRvIGNvdmVyIGFsbCB0aHJl
YWRzCiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiB1cGRhdGUgdG8gdjAuMi4xMiwKICAgICt0
ZXN0X3tpbnRlcnJ1cHRzLHN5c19yZWdzfQoKU2lkIE1hbm5pbmcgKDEpOgogIGh3L2ludGM6IGNs
ZWFyIHBlbmRpbmcgYml0IG9uIGwydmljIGRlLWFzc2VydGlvbgoKIGluY2x1ZGUvaHcvaGV4YWdv
bi9oZXhhZ29uX3RsYi5oICAgICAgICAgICAgfCAgMyArLQogdGFyZ2V0L2hleGFnb24vY3B1Lmgg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAg
ICAgICAgICAgICAgICAgICAgfCAgNCArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAg
ICAgICAgICAgICAgIHwgIDkgKystCiB0YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmlu
YyAgICAgICAgIHwgIDcgKysKIGh3L2hleGFnb24vaGV4YWdvbl90bGIuYyAgICAgICAgICAgICAg
ICAgICAgfCAgNSArLQogaHcvaW50Yy9oZXgtbDJ2aWMuYyAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyICsKIGxpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jICAgICAgICAgICAgICAgfCAz
MCArKystLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwg
MTUgKysrLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICAgICAgICAgICAgICB8IDEy
ICsrLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgICB8IDI5ICsr
KysrKysKIHRhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgICAgICAgICAgICAgfCA4NyAr
KysrKysrKysrKysrKysrKysrLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICAgICAgICAg
ICAgICAgICAgfCAgNSArLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAg
ICAgICB8IDM3ICsrKysrKysrLQogdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jICAgICAgICAgICAg
ICAgICAgICB8ICA1ICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAg
ICAgIHwgNzIgKysrKysrKystLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAg
ICAgICAgICAgICAgICAgfCA1NiArKysrKysrKy0tLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9wcml2
aWxlZ2VkLWluc24uYyAgICAgICAgIHwgNzkgKysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNn
L2hleGFnb24vcmVnX211dC5jICAgICAgICAgICAgICAgICB8IDExICsrLQogdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8IDE4ICsrKystCiB0ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgMTIgKystCiB0ZXN0cy90Y2cvaGV4YWdv
bi9NYWtlZmlsZS50YXJnZXQgICAgICAgICAgIHwgIDEgKwogMjIgZmlsZXMgY2hhbmdlZCwgMzky
IGluc2VydGlvbnMoKyksIDEwOCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90Y2cvaGV4YWdvbi9wcml2aWxlZ2VkLWluc24uYwoKLS0gCjIuMzQuMQoK

