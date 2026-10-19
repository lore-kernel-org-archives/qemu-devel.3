Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87ABCCF2D3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 05:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgJV-0006aj-0G; Mon, 19 Oct 2026 01:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJ7-0006XU-6E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgIm-0001HK-Ew
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:52:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j2Hr1553038
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=D1O5IEq89/eqWsbNTPNVMQ
 O1XsxcAHPSjZ6lnv5SBIE=; b=Jn5/orlQhxmTIOZRlSNqwa30OvLNMSgZH1zjsd
 hmtn7QzK+J9+OzjlKG1Zl/53miE+iozwZSYsoK1B1iYA3g2atVaBSOkdKb7OzjI0
 RaisXWavocPc1InFKr1JERhXqBpZSMW+E5FCX7w9gbqfPghLZ1WA8wZR7FBxOudC
 sxZi+hw9z/5oPP/pMnHG5JML82gS8ZlLHIn826FltENV+kGmSvm5fXeB3DiRnkZL
 uTd2YHPcfUBNAex/6a3yv+Rz5Vi5hEJ3YNinsboPu59uZfKv/DmCS+2d1rVAJlzI
 G7iOLCx2QnLNuAB6hnbI1GDTCj1uBcCfkfr6aLYVuwbSmzrQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur15sw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:52:49 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-18b5ee75447so1097756c88.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792389168; x=1792993968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D1O5IEq89/eqWsbNTPNVMQO1XsxcAHPSjZ6lnv5SBIE=;
 b=g7Es212qTPYuZRQyYjaFDjmVtDjDg4qD8fW/bXfx/ic+5TMcz8B3uHqFDqWWRSbiPE
 44Mu0HY/vVdycDa2/rAXV1losrJbXPGIhfC1vZ5oGakblrDGbxtZhpYYIxouSjVLWN5b
 yD+n4FOXQIwC8DUVL2ts/a3MCJlyzGxAkhV8Q4whw42kQlRiOxkENIttOXeQNjCmspZA
 yL/vFUA6VGruESvoIk5ytSNA2A6A356fW9iepAPNBEAN2ysYpg/3TM97ldGfCKlgow9I
 X7Flid/KOZVLCnlyLdnngLaD7kZCRcqgOQj3sgku+dMY6WOAGLxbUvADkS3bPH0W5C39
 iZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792389168; x=1792993968;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D1O5IEq89/eqWsbNTPNVMQO1XsxcAHPSjZ6lnv5SBIE=;
 b=h1E2dBsrW8IC/zJRigUcJiZyEkB7rrkb1EHb0asWCg5ulObjCFHRLCX+LtCdgKDBOc
 4sFY04Zb41pJz49As6iZVG/14ulb8+MAM98YdL841kJZq5DSU60Dby64IFn0iz6J2SrU
 FGMkZdpR5wr61J/u8p1mA+X+ZHx1VrEzE+nFz6/7hUXL7FMYx/+XydueLvlYdHb367Bq
 DmSQUJ+yjVJyfpIJaa9dEuT92SFKqIkk/699NMCdS0t5McZcXxjM7zNpZiCoNkxRwJvf
 eOAOsNnof+runbO5UD61c8DF9+rFWtqLhjfSfhj0ICIu6s/LHXgcSjy4WqDKcXN2Ch0k
 hNPg==
X-Gm-Message-State: AFq9FYLE6e3zRsz6aZupR+EPa4aSKYzf85D3Wlf9E2plf5X0UWCLZju8
 eonu1VzaHK6G1nwVHtkC9QOZ4lX1T1QFuar6fPYt/LgX2pBz0dEcdBWrZzJS1IczZwIcF+zeEUi
 Q8iLpVp17VWOztU5Ypcx5cQ6IER4HYq+tXtRi9pu9+4Uvo9Pi0qVEanjY01i3vKLGnA==
X-Gm-Gg: AYBFou0fCJL80XayQ+6ImcWutniRPXVL2EUOiYLPrbRkPD3SevHhETYtj+WON6MuSlS
 ZA8l5rQAyzVqJExe54XBwkp1i7JduOIU6DXiJGmRlUZPxANY2zRx6KinZQxX6fN3zVLZNjmD4At
 gwaTAMAY6toXcVymNqMr8Stwyc1aKRSUHRaPL80JTMwWnpSdpuYW5tXZXqFLLmDGoYf+Ch1thTw
 bJMPw+gwgUwFhV/IvqpIZn5tB19BqmQ1JHD8HTaLmeDgQqRiYeQ1VtJECFFIgvV6eqxf0p65fyD
 hQqWVQQAuEXyv8WmIYrKb3r5jGZ6k14ViyUMy2tIJoU8rP7dQXmKtH+DTxJLTRRYGfn/whIxKm6
 +MlY3tLrw1aBTnbUkUzCzQf9+5WyvpsajhRjNVlQyqgyOFjA=
X-Received: by 2002:a05:7022:ebc4:b0:14a:fe37:cdf0 with SMTP id
 a92af1059eb24-18514bfa955mr13673552c88.45.1792389168038; 
 Sun, 18 Oct 2026 22:52:48 -0700 (PDT)
X-Received: by 2002:a05:7022:ebc4:b0:14a:fe37:cdf0 with SMTP id
 a92af1059eb24-18514bfa955mr13673518c88.45.1792389167338; 
 Sun, 18 Oct 2026 22:52:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm25672781c88.15.2026.10.18.22.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:52:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 00/14] Hexagon: Add real SoC-style machines
Date: Sun, 18 Oct 2026 22:52:31 -0700
Message-Id: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfXy9l/ZnRC9kHM
 cyA5m8mQget2Qh7myXitjsUnMwoUNXXUiQlx1gj6ASq6UJIwDb/aoNE2gfwB4YhBIgRUtkBPDR4
 2hugtYS84tAwoOlpGh0Yn/CycoJPr0c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX8f5kKGnUqy31
 qdnPJoQH6mtjd8Z5vKai07TpA4CJrr8c2hPGIa8tcZAzWkRM1kvPwrM6yhVzLNCr0v+TgnEQi6C
 iqjznXmYS88vo660QiPmOW+VzBNy8/g2ZgIREp/V5zUoRY/46IYEimoOQnJcLSYZ4T5fcZgsRPt
 fDseWJFvanL5qt2ES72m49qVzxjbhD1zIko0dh+e6X7mSXXxaTLxLGrgpZEh02nXZlELADEY3hs
 kCmybnG4b+0JskA+iUrPPea4FPJCQV+bjlNrfwAfAI4/7/14olYTRTsErxq4ZR4zXJdtn08vMOp
 wRkQ8hXnGWLVlFdmStu7GYgkb5cgWnQ+/bzs3FOHhC96vTwDQH0oldzWeRjtg8fIoXjk1OyrNfy
 8/rOl3dLCk+19kr3zrB1OM6L7BXuFLXash1QQTh/NKQNM+PBethPy3lelnclICa7dOfLq41+f7k
 Ea+q6uCN3WzReZw4wwA==
X-Proofpoint-ORIG-GUID: J93chDlpA05O4U0rpha0UbMtPPaN4eYX
X-Proofpoint-GUID: J93chDlpA05O4U0rpha0UbMtPPaN4eYX
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5b031 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=I9lFEJs5wUmPObltlfMA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190023
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

UHJldmlvdXNseSB3ZSBhZGRlZCBzeW50aGV0aWMgbWFjaGluZXMgaW50ZW5kZWQgZm9yIGNvbXBh
dGliaWxpdHkgd2l0aApwcm9ncmFtcyBjcmVhdGVkIGJ5IHRoZSBIZXhhZ29uIFNESy4gIFRoZXNl
IHNpbXBsZSBjb25maWd1cmF0aW9ucyBoYXZlIGEKbWVtb3J5L2lycSBtYXAgdGhhdCBkb2Vzbid0
IG1hdGNoIGFueSByZWFsIGNoaXBzLCBhbmQgdGhleSBhcmUgbGltaXRlZAp0byBhbiBpbnRlcnJ1
cHQgY29udHJvbGxlciBhbmQgYSB0aW1lciBkZXZpY2UuCgpIZXJlIHdlIGFkZCBEU1AgbWFjaGlu
ZXMgdGhhdCByZWZsZWN0IHJlYWwtd29ybGQgZGV2aWNlcyBhbmQgcnVuIHNvbWUgb2YKdGhlIGNv
bW1lcmNpYWwgZmlybXdhcmUgdG8gdGVzdCBpdC4gIE5vdGUgdGhhdCBmb3Igbm93IHRoZSBib290
IHdpbGwgbm90CnByb2dyZXNzIG11Y2ggYmV5b25kIHRoZSBpbml0aWFsIGtlcm5lbCBib290LiAg
RGVwZW5kZW5jaWVzIG9uIG90aGVyCnlldC10by1iZS1tb2RlbGVkIGRldmljZXMgYXJlIHByZXZl
bnRpbmcgdGhlIGZpcm13YXJlIGZyb20gY29taW5nIHVwIGZ1bGx5CnRvIGEgc3RlYWR5L2lkbGUg
c3RhdGUuCgpCcmlhbiBDYWluICgxNCk6CiAgSGV4YWdvbjogYWRkIHY4NSBDUFUgbW9kZWwKICBo
dy9oZXhhZ29uOiBsZXQgYSBtYWNoaW5lIHBsYWNlIGl0cyBERFIKICBody9oZXhhZ29uOiBpbnRy
b2R1Y2UgaGV4LWJvYXJkIGFic3RyYWN0aW9uCiAgaHcvaGV4YWdvbjogY29udmVydCB2aXJ0IGJv
YXJkIHRvIGhleC1ib2FyZAogIGh3L21pc2M6IGFkZCB0aGUgUURTUDZTUyBQTEwsIFJDRwogIGh3
L2hleGFnb246IGFkZCB0aGUgUUNTNjQ5MCBDRFNQIG1hY2hpbmUKICBody9oZXhhZ29uOiBhZGQg
dGhlIFNBODc3NVAgQ0RTUCBtYWNoaW5lCiAgaHcvaGV4YWdvbjogYWRkIHRoZSBTQzg0ODBYUCBO
U1AwIG1hY2hpbmUKICBody9oZXhhZ29uOiBhZGQgdGhlIFNBODc5N1AgTlNQMCBtYWNoaW5lCiAg
aHcvaGV4YWdvbjogYWRkIHRoZSBTTTg5NzUgTlNQIG1hY2hpbmUKICBody9oZXhhZ29uOiBhZGQg
djc5TkExIG1hY2hpbmUKICBody9oZXhhZ29uOiBhZGQgc3Vic3lzdGVtLWJhc2UgcHJvcGVydHkK
ICB0YXJnZXQvaGV4YWdvbjogZml4IHRoZSBhbGxvY2ZyYW1lIGZyYW1la2V5CiAgdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uOiBib290IERTUCBmaXJtd2FyZQoKIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2Vt
dWxhdGlvbi5yc3QgICAgICAgICAgICAgfCAgIDIgKy0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXgt
Ym9hcmQuaCAgICAgICAgICAgICAgICB8ICA2NSArKysKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhh
Z29uLmggICAgICAgICAgICAgICAgICB8ICAxMCArCiBpbmNsdWRlL2h3L2hleGFnb24vcWNvbV9k
c3AuaCAgICAgICAgICAgICAgICAgfCAgODEgKysrKwogaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQu
aCAgICAgICAgICAgICAgICAgICAgIHwgICA2IC0KIGluY2x1ZGUvaHcvbWlzYy9xY29tLXFkc3A2
c3MtY2xrLmggICAgICAgICAgICB8ICAxNSArCiB0YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAg
ICAgICAgICAgICAgICAgICAgfCAgIDQgKwogaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19xY3M2NDkw
X2Nkc3AuaC5pbmMgICAgIHwgIDY1ICsrKwogaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVf
Y2RzcDAuaC5pbmMgICAgIHwgICA2ICstCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc5N3Bf
bnNwMC5oLmluYyAgICAgfCAgNTYgKysrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NjODQ4MHhw
X25zcDAuaC5pbmMgICAgfCAgNTIgKysrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NtODk3NV9u
c3AuaC5pbmMgICAgICAgfCAgNTUgKysrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEu
aC5pbmMgICAgICAgICAgfCAgMzQgKysKIGh3L2hleGFnb24vaGV4LWJvYXJkLmMgICAgICAgICAg
ICAgICAgICAgICAgICB8IDI2NSArKysrKysrKysrKysKIGh3L2hleGFnb24vaGV4LXN1YnN5cy5j
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5j
ICAgICAgICAgICAgICAgICAgICAgIHwgIDg0ICsrKy0KIGh3L2hleGFnb24vcWNvbV9kc3AuYyAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDM5OSArKysrKysrKysrKysrKysrKysKIGh3L2hleGFn
b24vcWNzNjQ5MF9jZHNwLmMgICAgICAgICAgICAgICAgICAgICB8ICA2NCArKysKIGh3L2hleGFn
b24vc2E4Nzc1cF9jZHNwLmMgICAgICAgICAgICAgICAgICAgICB8ICA1OSArKysKIGh3L2hleGFn
b24vc2E4Nzk3cF9uc3AwLmMgICAgICAgICAgICAgICAgICAgICB8ICA2OCArKysKIGh3L2hleGFn
b24vc2M4NDgweHBfbnNwMC5jICAgICAgICAgICAgICAgICAgICB8ICA5MCArKysrCiBody9oZXhh
Z29uL3NtODk3NV9uc3AuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxMDIgKysrKysKIGh3L2hl
eGFnb24vdmlydC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDMwOSArKy0tLS0tLS0t
LS0tLQogaHcvbWlzYy9xY29tLXFkc3A2c3MtY2xrLmMgICAgICAgICAgICAgICAgICAgIHwgMjA4
ICsrKysrKysrKwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICAgICAgICAgICAgICAg
IHwgICA0ICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jICAgfCAg
IDIgKy0KIHRlc3RzL3F0ZXN0L2hleGFnb24tY29uZmlnLXRlc3QuYyAgICAgICAgICAgICB8ICA3
OCArKysrCiB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgfCAg
MTAgKwogdGVzdHMvcXRlc3QvcWNvbS1kc3AtdGVzdC5jICAgICAgICAgICAgICAgICAgIHwgMTEz
ICsrKysrCiB0ZXN0cy9xdGVzdC9xY3QtcXRpbWVyLXRlc3QuYyAgICAgICAgICAgICAgICAgfCAg
MTAgKwogdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYyAgICAgICAgICAgICAgICAgIHwgIDY3
ICsrKwogaHcvaGV4YWdvbi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ4
ICsrLQogaHcvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3
ICsKIGh3L21pc2MvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyAr
CiBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwog
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgIHwgICAyICsKIC4u
Li9oZXhhZ29uL3Rlc3RfcWNvbV9kc3BfZmlybXdhcmUucHkgICAgICAgICB8ICA4OSArKysrCiB0
ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0KIHRl
c3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICB8ICAgMSArCiA0MSBm
aWxlcyBjaGFuZ2VkLCAyMjU0IGluc2VydGlvbnMoKyksIDI5OCBkZWxldGlvbnMoLSkKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vaGV4LWJvYXJkLmgKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vcWNvbV9kc3AuaAogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvaHcvbWlzYy9xY29tLXFkc3A2c3MtY2xrLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBo
dy9oZXhhZ29uL21hY2hpbmVfY2ZnX3FjczY0OTBfY2RzcC5oLmluYwogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzk3cF9uc3AwLmguaW5jCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYzg0ODB4cF9uc3AwLmguaW5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zbTg5NzVfbnNwLmguaW5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NzluYV8xLmguaW5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2hleGFnb24vcWNvbV9kc3AuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24v
cWNzNjQ5MF9jZHNwLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3NhODc3NXBfY2Rz
cC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9zYTg3OTdwX25zcDAuYwogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vc2M4NDgweHBfbnNwMC5jCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaHcvaGV4YWdvbi9zbTg5NzVfbnNwLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Fj
b20tcWRzcDZzcy1jbGsuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2hleGFnb24t
Y29uZmlnLXRlc3QuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L3Fjb20tZHNwLXRl
c3QuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKIGNy
ZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9xY29tX2RzcF9m
aXJtd2FyZS5weQoKLS0gCjIuMzQuMQoK

