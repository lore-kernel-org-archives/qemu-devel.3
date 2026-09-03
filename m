Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFB1C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cc1-0000Y6-O5; Thu, 03 Sep 2026 14:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbx-0000Wr-9m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cbv-0000XV-Pf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3Xoh1430734
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c9Y33S8+DlTZLFkzQFnhyhQh/oRpjTzJe5j/x1P4Fbc=; b=R1hWC1dqiVms/I3w
 mzKQbqyfw0QDvTYNnCJzxCtqmW1IIbrTLXVAgc8CG9K9WZd4xK6DqrqIG6NQ0sES
 3pvGGO6Ri8r9x4J7JS47iyl5yrspMJ7eQjljRRjdjrE+C8mIk2Hc7Dy4aDDOUlVi
 yMErYe3nBAtx+gyAhUjF+xFD1whXvzgn1kXck6X662JK+jaSlmnQZ2DAOSJfz/oE
 E66qIaRtWm8JK3U0jA8TQmLRzLxM87e1G1jJh2snlC3FmYlMeSiZaZoOLfI2zbP4
 FrGnplL3brTqLvgLV0eDipDZEFYbE219CVkMT1/pFRDCEjiajabwPhCH/lrexGww
 ViDJpQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4kkux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so198746a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461790; x=1789066590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c9Y33S8+DlTZLFkzQFnhyhQh/oRpjTzJe5j/x1P4Fbc=;
 b=hlKK4u1RwSVyqYn3oL5Fxh+GO3Ow+s1iT63wc/JiT2yP3GJMKMOzaw2WOPXLqVoise
 JK+ug63UdxsfcYPdwxoqN0JNFgYkZtBlbEkMlbyO/sqXdvd1vrW3wucZsxX6yQaY1PtT
 IZNP3vXtSF1iushi5lByiHWvwUElakGunIoh6RxnxlaL5kTuh34+e58FMOYdOvUyOFDU
 qRqN46A8mQTnAq3lexW4aS0XAPrcKuNZE4Zz4KjeFOy/4tcTu55Is6waj2meGglenAY+
 va0GbtQ+awgwyScQ95+nNQqnFcNxgAqCXGteGHcEayjmwwsHKKrGyha3+HpVFj8si71+
 M69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461790; x=1789066590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c9Y33S8+DlTZLFkzQFnhyhQh/oRpjTzJe5j/x1P4Fbc=;
 b=VC2Tp+raFyl4niM9k/ntIdOAeEHUdTXHnKmr1yXOmkaJl4UQ0P/BnxsKMHmfzg2f1j
 CIipLDwmQja67cZo1A16MqhipqQugCpN4wz9BNFNoJAg1sFe02zkXaFlrUZrABVHyx0q
 MjGOTSYkFDwcQ93MZo1UU1Tfk9zlD5DhlCbgvNR0qn7gJxl9U5/SphbYn6raSf4UpcT8
 8zM3cDrz/06KMfiUjtP/JOKAasnehV73XcRUaCXwWCjNsQ6mSB9Vlh1MyJs2VdcrYfnz
 PmySBW+x6OCD1i4yqlWmjq7yNEXMPBqV/+fUwzaTIKdOezGvDTKczeZZvkCK5doOxdYJ
 qkog==
X-Gm-Message-State: AFuF++mK73UWki085XGdSAHHXY57ZEpSV/ok7pS36n19gb89JH9I2XfF
 w0FQ4JXFdHJWzSaywnhdZG4U8qdrM6c14yihlWXCPT3hj5Fd+2pEMddTV2ZKHGKGdtm6dUrXhiR
 fVZ8mmeWMS54gwK7qf8CVSkUj//2tqE1vaoNp7iouMuSxPmGDcxgQF7dfkso5v4y3NA==
X-Gm-Gg: AYBFou1sG1ph+1TTNRIUdJFMXbrYst0QMl8/B+vUg9lFTtpuxuHhG/qPiKB5xaUo2+0
 D9fsoUDEpWmUNQv7Ic1pZGRw5oFBKVtTZLAOsQ147T0WFTIvI0AB5QJVBZdBW9sr0rTpy7v7Xi5
 keFW9ZFOwsSrcPhbqgYugfCXsA9ESx0g67OB9LhTiukNggYC+fdlCXupAM2CO6f1I111PgJETTA
 xpjIlHvE5lAm4FI9Fr8WduOEGnyrMYYNjqIjURbpFVMFttfeMYOaKMZbnhkkgG8wfMqBoLBp3zw
 G3w+L2rhePVz/YHZdAwbHUwuXIQDUyLLIT9K+FOkoWGqnDP0HuPuf4FNzx3J45V7TZioelQGPqU
 gcsANK9B7nwtKKnlNqmFiIMbjV1Eayc7+hv8nm9wRWj/y4klR
X-Received: by 2002:a17:90b:2f87:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-39b260fe42amr918261a91.5.1788461789777; 
 Thu, 03 Sep 2026 11:56:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2f87:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-39b260fe42amr918200a91.5.1788461789283; 
 Thu, 03 Sep 2026 11:56:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/8] target/hexagon: kick vCPU when re-asserting interrupts
Date: Thu,  3 Sep 2026 11:56:17 -0700
Message-Id: <20260903185622.3234171-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99c2de cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_cPWo3-z87wpK2aiiYgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: upLuo6hPRcahTSdwgZBHj4danNmNvgOQ
X-Proofpoint-ORIG-GUID: upLuo6hPRcahTSdwgZBHj4danNmNvgOQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX/I74Gcwp73zr
 6foiEKfCXe1Jth7goflRgYrRJl76t87zjLQHD+ObuhOtB6IV6YOjywIbLWywhKZLGIacgLRl7Op
 NOc8cQKPNew9mF/6Vruy0q9DMtepQoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX2Kfobxq2MRCo
 +MYli5iKfpMPn8FA8KCJIFAiyPxrGbDwbGsPXPVb9yYf8PWnj9M+jWzPHWVTiG5u3jPEakwEgeG
 1uJdQQTQbHeU+X1STpN/5gBq7pPexYBZC1VEX/qTtFw1gVCAlG1dBY4mQSwB6A9sHvlE4+K/itG
 5jWgMjBTA/FugkKK8N64vmJuUA5BL6j+eUewG3DdBOB7Sn0QT49m60Eq1OcU37XrjwMRAYlEAdS
 ZMbYL59HZ9qjdF/mZvDORtlPhjx7BR0gmPk92HPUgDtzd3oJdc91rATQpvoUuepV17pbXpt6zTH
 ASVwlOk27k3v0xmo7GmKIiX7Vo2QBvEMHGOXk/pj/PDTmuf6WTF0BRwGyCo5Ll4FHhuEk1p4903
 xbom2Pu7bozYDheEW9zC86kqC/3/Cj7FO+OepkFRpiDbiD+EONEhbGZmo7bjXv4cCu/koeTLVj8
 OwmvKjyoGph04bixL0Q==
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

aGV4X2ludGVycnVwdF91cGRhdGUoKSB1c2VkIGNwdV9yZXN1bWUoKSB0byBtYWtlIGEgaGFsdGVk
IHZDUFUgbm90aWNlIGEKbmV3bHkgcGVuZGluZyBpbnRlcnJ1cHQuICBjcHVfcmVzdW1lKCkgaXMg
bWVhbnQgZm9yIGEgdkNQVSBzdG9wcGVkIGJ5IHRoZQp2bS1zdGF0ZSBtYWNoaW5lcnk6IGJlc2lk
ZXMga2lja2luZyB0aGUgdGhyZWFkIGl0IGNsZWFycyBjcHUtPnN0b3AgYW5kCmNwdS0+c3RvcHBl
ZCwgYW5kIHJlc2V0cyBleGNlcHRpb25faW5kZXggdG8gLTEuICBDbGVhcmluZyB0aGUgc3RvcCBm
bGFncwpjYW4gdW5kbyBhIHBhdXNlIHJlcXVlc3RlZCB2aWEgdGhlIG1vbml0b3Igb3IgYnkgbWln
cmF0aW9uLCBhbmQgcmVzZXR0aW5nCmV4Y2VwdGlvbl9pbmRleCBkaXNjYXJkcyBhbiBleGNlcHRp
b24gdGhlIHZDUFUgaGFkIGFscmVhZHkgbGF0Y2hlZC4KCk9ubHkgdGhlIGtpY2sgaXMgd2FudGVk
IGhlcmUsIHNvIGNhbGwgcWVtdV9jcHVfa2ljaygpIGRpcmVjdGx5LgoKU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhh
Z29uL2hleF9pbnRlcnJ1cHRzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJy
dXB0cy5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYwppbmRleCA3ZGRlMTI5NGIy
ZS4uMmIyODM0YWY5NWYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRz
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYwpAQCAtNDQxLDcgKzQ0MSw3
IEBAIHZvaWQgaGV4X2ludGVycnVwdF91cGRhdGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAg
ICAgICAgICBjb25zdCBpbnQgZXhlX21vZGUgPSBnZXRfZXhlX21vZGUoaGV4X2Vudik7CiAgICAg
ICAgICAgICBpZiAoZXhlX21vZGUgIT0gSEVYX0VYRV9NT0RFX09GRikgewogICAgICAgICAgICAg
ICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfU1dJKTsKLSAgICAgICAgICAgICAg
ICBjcHVfcmVzdW1lKGNzKTsKKyAgICAgICAgICAgICAgICBxZW11X2NwdV9raWNrKGNzKTsKICAg
ICAgICAgICAgIH0KICAgICAgICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

