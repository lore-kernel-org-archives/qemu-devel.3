Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA0CC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49VQ-0006ye-PC; Wed, 09 Sep 2026 00:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VO-0006xL-PD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VM-0003sH-Nd
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688MgMTI482354
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=S0j3GjBxpBHNNl1Gqm8tka
 BiqAYYZX8TJJX+7UUeT9Y=; b=ixDfLxIP4ZgjoSddCzntDC+APU2/B8bRWiPdol
 TWCyxyL7jq+0kWMq/4FivkCoUQ+HjkZaX09yEXWf2jRunC6MfUbWnF2yR4erQjCj
 SbTloeVbvh4Itw7L6xR1SM0Ppyg9Aj5OxLASxNXB7DAZKiOAhfMJNCIBuCdvLYBs
 UACywDTMzAJWTBIG7OVnZy9gDGPt/PJyL4bx5ntJ86nmNzoEStoFK6UsB7RKNFd9
 PR+HZz7TbZS+/CivkjL2G9hW0BfbD1rPqxUdAebdh5s5UWV9OBlD8t8ZVbkifCRI
 KboUbUdiWVIrzmLDN3j56evg+nyHTw7sidbgOk36lYZgGX9w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqf1j00x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968dfff779so7375200a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926506; x=1789531306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S0j3GjBxpBHNNl1Gqm8tkaBiqAYYZX8TJJX+7UUeT9Y=;
 b=TcsjdhPfEdZKo8bcjqygCvfyxnPH0oNHEgOijj39lMi+1+woHjY+iDlv4fCkemjRMT
 3lCTDOGg94vI95dtBeNR7ImMGLQy+qWCQPv3CNx5ysOowUzxYSt/z9jxRY4g6HKaerSS
 j1h7ozIrK+tEeqBNa9ymFV+S9rkdLQ6JdEwGFclYIGAu7qTvAVlsGY05cgrp2KQwdNxB
 dqQASbZdegban15AnD1ZKS9dyLNMA1dh9P8muEJG17MrcmYJcSSU2zox4gWvPEDvsiml
 RjS8pN/OH/DfSb0o0mVIX7NWgW184V2d0m6s3vHFZGA/ktmT2xgybmEpjqIjm5hqvwm2
 n4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926506; x=1789531306;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S0j3GjBxpBHNNl1Gqm8tkaBiqAYYZX8TJJX+7UUeT9Y=;
 b=cFNCVMfLLnetAYZ9xJZ/WnbOckP97xHRV0PDa0qsLgZwClkLB7MTWvGx5y9FXMeMJL
 LSvJ9x/A16/PkziMKcQfcZnvSxnkKBNnTy/dIL9PskCc6o4bqmMbAQ90T9gc+iiCXO/E
 Z3A6XZ/DUlQ6HcrRPl4Xmydgi8sabByKS2pag0QfVM1JmAtAjwEckh8pBWqKYy84XL3s
 skJ4xznQ4PFNZO6yFfLw0d6WRjFV2inFrHsPYt2nTnOLYrW29K7+ICMqd6YLl0i43vdG
 1EOSecF5joo+6NxGU1sdSwTqDJnMHZD94MPLlqlK3JOAsk4IT5Wyu0Fz5T6auYJr2Jzv
 kc3A==
X-Gm-Message-State: AFuF++k6bpnKO8q1XYiKRVTMe6Aba8eHeOFlEH4ELalUywvsYSaZN1p+
 s7qTrNRprym7vbWEkRI1e9SbHxBnPBn2eyvSLydqyAb2DUmDG3YB48aAZOrSWzzThRee0U7GGok
 /EO3TwHBJmA1Dw0S2xBNplBnlqnznyy3zDF8EQBhoEiGG8/9kXh/P5sWU1ZMVmZRUFQ==
X-Gm-Gg: AYBFou0fYcf1mj09xuMdFLK+oT4zBnt6lNxV2plRtBwA3pxyzrTi3LrFQRixzOPPPCf
 8Q7QjtgyTvHKWTZU+vQPmFhr+pGo0yTkoV08h7lWRFet+vdoo0hjUusQzl805nZmAqm5x9h2qni
 khuEvFwWLKt4t9Z33gLAUswj8Z1P6ZE5NAkwrsrnlg2Z+FV2Z4vfQ4DyRULLOO3Gsk3M6t3SR7n
 zS4m5xuMeXoGsF49qZmZgfdwrQ5mxTkt5dseC4WHB2ZisViMdei9x3nuGAVtUmEyJR9+xxLAQ1z
 XklwHA0sWxP/EmC1VPr4oh+k7y/JP4NBIVWziSpUxxQuKNQeEI1/YML2h9uJbHFuX+gzFyouam4
 xxcFaGENdyYwChZ/zVIVWQKZDMtABveS6VMjyu5DImYYFvpPg
X-Received: by 2002:a17:90b:28ce:b0:398:a649:8fa3 with SMTP id
 98e67ed59e1d1-39b08799871mr39868957a91.23.1788926501124; 
 Tue, 08 Sep 2026 21:01:41 -0700 (PDT)
X-Received: by 2002:a17:90b:28ce:b0:398:a649:8fa3 with SMTP id
 98e67ed59e1d1-39b08799871mr39868904a91.23.1788926500567; 
 Tue, 08 Sep 2026 21:01:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 0/9] hexagon: Add scalar v75=>v81 support
Date: Tue,  8 Sep 2026 21:01:28 -0700
Message-Id: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX6QNCSz4i0io6
 skNgsD/Xnpq8laRZs+nKIr/KTpDWlOPZ5+It/vl5Teb7RRYMaawL9WafsxYbRAO9qaBDcz2k8nt
 zAVZXkIkwy0z5h1S/8zQEo846kHO80BpVwyMoI3rCFMu7dcC1Ewq2n5G7yMozxM1KViGE71Ydyh
 HPepafAhAJx26oVUjrL6O/AfPJf8ALGRTiQHkagfjkN+prSX4Lvfmru37OsOA9eF9TqHgCLVQZD
 c6R7ZFmq9jixMumGKaE5Obfuf1it+5pO8sY4u2EKigLjzxmXAL111ckNc7SElo5SJCy9E39xco0
 NaRozv7NkRKGQagASVILaZ2jf9hMCTq3bNfRw3RB4UM3te0BU7NfLaKbIVdvI9y+gePY2+Tgmmf
 y4sf/UCgRwk2SaRvGWJ6/V8btzE39T4jXBlBfL5rUE+DmkjxY811d4tcTagWfnoSVldRuh7Kt0Q
 +eCHRSd3nzL9nFxV2tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX+2D3b9INutzf
 SGtZBYVprVvbDmr5gC2tjhDYqPpS14+6d18Pc1CAAcEtr6cYxStFky5ng+ns6Yotyypr3ihLHKh
 wKBiby8sF97iV9X7oFWfnDsH72nF3JI=
X-Proofpoint-GUID: _J50a2f4dUGPhcQuBKxi4p785McozkEi
X-Authority-Analysis: v=2.4 cv=JY2Ma0KV c=1 sm=1 tr=0 ts=6aa0da2b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gD3tZv0wunvMzOH22o0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: _J50a2f4dUGPhcQuBKxi4p785McozkEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBzY2FsYXIgb3Bjb2RlcyBmcm9tIHY3NSB0aHJvdWdoIHY4MSwg
YW5kCnY4MSBtYWNoaW5lcyB0byBnbyBhbG9uZyB3aXRoIHRob3NlLgoKQWRkZWQgaW4gdjI6Ci0g
d2lkZW5lZCBpbnRlcnJ1cHQvQ1BVIG1hc2tzIGZvciB2ODEKLSBleHBhbmRlZCBnbG9iYWwgc3lz
dGVtIHJlZ3MgZm9yIHY4MQotIG1vdmVkICdzaW0nIG1hY2hpbmUgYWxpYXMgdG8gdjgxcWFfMQot
IHRlc3QgY2FzZSB0byBjb3ZlciB3aWRlciB2ODEgaW50ZXJydXB0IG1hc2tzCgp2MTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkwODEzMzUxMi4yMzUzOTU3LTEtYnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoOSk6CiAgdGFyZ2V0L2hleGFn
b246IGFkZCB0aGUgdjc1LCB2NzkgYW5kIHY4MSBDUFUgbW9kZWxzCiAgdGFyZ2V0L2hleGFnb246
IGFkZCB0aGUgdjczIEoyX3VucGF1c2Ugc2NhbGFyIGluc3RydWN0aW9uCiAgdGFyZ2V0L2hleGFn
b246IGFkZCB0aGUgdjc5IGluc3RydWN0aW9ucwogIHRhcmdldC9oZXhhZ29uOiBhZGQgWTJfdGxi
cHAgYXMgdW5pbXBsZW1lbnRlZAogIGh3L2hleGFnb246IGFkZCB0aGUgVjgxREdCXzEgYW5kIFY4
MVFBXzEgbWFjaGluZXMKICBody9oZXhhZ29uOiBtb3ZlICJzaW0iIGFsaWFzIHRvICJWODFRQV8x
IgogIHRhcmdldC9oZXhhZ29uOiB3aWRlbiB2ODEgQ1BVIG1hc2tzCiAgdGFyZ2V0L2hleGFnb246
IGFkZCB2ODEgaW50ZXJydXB0IHJlZ2lzdGVycwogIHRlc3RzL2Z1bmN0aW9uYWw6IGNvdmVyIHY4
MSBzeXN0ZW0gcmVnaXN0ZXJzCgogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCAgICAgICAg
ICAgICAgICB8ICAxMSArKwogdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oICAgICAgICAgICAgICAg
ICAgICB8ICAgNiArCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAg
IHwgICA0ICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oICAgICAgICAgICAgICAgICAgIHwg
IDQyICsrKysrKwogdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oICAgICAgICAgICAgICAgICB8
ICAxMSArLQogaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYyAgICAgICB8ICA3
MyArKysrKysrKysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjgxcWFfMS5oLmluYyAgICAgICAg
fCAgNzMgKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyAgICAgICAg
ICAgIHwgICAzICsKIHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jICAgICAgICAg
fCAgMTAgKy0KIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgICAgICAgICAgICAgICAgfCAg
NDggKysrKystCiBody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMgICAgICAgICAgICAgIHwg
IDEwICsrCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jICAgICAgICAgICAgICAgIHwgICA2
ICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKy0K
IHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgMTUgKy0KIHRh
cmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICAgICAgfCAgIDggKy0KIHRhcmdl
dC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgICAgICAgICAgICAgfCAxNDEgKysrKysrKysrKysr
LS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDU4
ICsrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwg
ICA4ICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMgICAgICAgIHwgIDMy
ICsrKy0KIHRlc3RzL3RjZy9oZXhhZ29uL3Y3M19zY2FsYXIuYyAgICAgICAgICAgICAgfCAgIDcg
KwogdGVzdHMvdGNnL2hleGFnb24vdjc5X3NjYWxhci5jICAgICAgICAgICAgICB8IDE1NyArKysr
KysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jICAgICAg
ICAgICB8ICAzMCArKystCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmICAg
ICAgIHwgIDIxICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICAgICAg
ICB8ICAyMSArKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmICAgICAgICAg
fCAgIDcgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8ICAy
MSArKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgIDEg
KwogMjcgZmlsZXMgY2hhbmdlZCwgNzUyIGluc2VydGlvbnMoKyksIDg2IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjgxZGdiXzEuaC5pbmMK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y4MXFhXzEuaC5pbmMK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi92Nzlfc2NhbGFyLmMKCi0tIAoy
LjM0LjEKCg==

