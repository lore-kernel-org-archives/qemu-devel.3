Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C8AC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkRZ4-0008Ek-Kz; Thu, 16 Jul 2026 15:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkRZ2-0008Cd-P9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:16:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkRZ0-0002y5-Sz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:16:08 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSgOI3481375
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FuJtJ2k3T/KZLw+xH9iOVSqK+1drjPQNHXrhqEQohJE=; b=olw+fU3+ho0w64Z1
 hOT534okUDH4cyNqJ3uWb5tMbnt6GZnA+VGCo5kiAfGZMGrLnyxGza+wwYTWDosr
 IznyO3vsomfewE3veINcaH/hr5AnF+Z00JDEBiA4Ce19hzU/t7W10eMltQBrncb+
 S0y9jfmVlamV59GGxmljnMQ9+0D616v6ngxyX3DRg/EeIXoApDi94XVQ0koz/0zZ
 7cNA5PRr44zKej4mi3rDxkvF8rVLRW4htxW45DGZPjGv17Eyb8NhqyypvE2ocOa+
 zoF5dCIxRGV+JzTLwayYWAkRpOpUH1u5UFvvedy854BkHV37KjiI9fXj8wJx6gx1
 upnPQg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf33t9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:16:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88da04b719so3389669a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784229365; x=1784834165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FuJtJ2k3T/KZLw+xH9iOVSqK+1drjPQNHXrhqEQohJE=;
 b=LMQES4Kk7/AGS2gFQtUlr5WM2ueQ9Trgq8w/jxO+BourJABTVxL7XjdbDC+d73Zmnx
 uOZYTwOr21KViivyMtWjDWnS23X8OPpwGYX1/aewN69pmVCJACKuIW/ntLLiIpnMMHvI
 UpyxFIhdqvp/w6KBKymlplCP2wEFeZZNVq2ReYQXYPCYXAadW2pMjuLOtGLHztxxCaXO
 ImQtCD/ZAtT2qLNyfLSpouIFIxRAgEkJkoP3QrEO8+Ineli+/XKxM4SR+tllK/FIPGCk
 9zHX5FWXdJOsnC2TrE28I4s5/AvdccWRtj+YcCU4WZwyBx+fwFpMGt7+L806cXhO1GCT
 Bq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784229365; x=1784834165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FuJtJ2k3T/KZLw+xH9iOVSqK+1drjPQNHXrhqEQohJE=;
 b=eaUdhmZS+6jyl6ARbUMOCMLUd9+A3H4hIBa8PyROObkIC2uTWXhtIBQ3Kkp6l+HUOE
 BcJDnrFNpeyeyRW2eW+68dQEnn4OVAzQIN22g8GBiw/IzUgHElEGKoJUHw8xISjyxUpH
 Sxkqj3iZ9W54I3B32YD553hhbj5RfT9gpU/QFpTdLB8Lucbayt5vlPfBy6ZH5xzoTHAi
 Uat4yH5dFqYpMDupx18OUXkfFlN/j88c0evUImVzra3zdRvaUrfhqOBhV9diWUaOT32g
 KDl1L9sO3s7UNwo67Dr6b5I+rc655wJb16KACh8VXkBFL5jDS2Mauhwdoro4gdxvMWvk
 bQDA==
X-Gm-Message-State: AOJu0YysFzWhyhqX62jQReV6aY/b0VTry9iXxgpKRVRLsVTIXOZf5XNI
 AhXYXUnN3mZ17+RUWzF98a4Tba44I9KKNqt7kodgZDxqKl/c0APlXv/Y5mnta2lWXj/6CqmO4yn
 5vQlddZw9+NPJOnmInh8QqPm1XQy6FW3dg5uPbUdEJj7VFQroLdgrfd4JBXvPOOncrQ==
X-Gm-Gg: AfdE7cl35X3L/PL3B6J47GWn8udsdE8fPpbdqaM6Q96W1xkuUuT/UDOhdOyeWNbVFJr
 hYphHuYUE3z2sXXORPcoPi9kT3HrtC+zjcesfx8KGKxBSZTEZ4HO9Rmta2lPalO82g3g5/cvKk/
 yzm2lQF4Lx05aRYalZSWbrq4eiHhJ8WGe29ilQ6XgVLZHCHxHTfrhaKpn6YRT8zLedDoTd+giHY
 OYk96r+pgw/g1jMWodwv1gr7sCt5s+otfRnHuIvZ4qMSgiA+THYnHZ59iEVbdRHDdaQut2h2lTq
 l1KrxyrJ8hIz4u9hOlaCwnVl38c2Wck9qAxp17rlFxGfp/745PY7r4VuR5q2DHg3lyp0vWJ1nsC
 daytGUbkieeIt5rECJ8PMjsP06pXKCWyzxYCV4N0HCfLwTuvQ
X-Received: by 2002:a05:6a21:3990:b0:3c3:90de:60e9 with SMTP id
 adf61e73a8af0-3c3a5e95214mr442639637.62.1784229364580; 
 Thu, 16 Jul 2026 12:16:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:3990:b0:3c3:90de:60e9 with SMTP id
 adf61e73a8af0-3c3a5e95214mr442609637.62.1784229364054; 
 Thu, 16 Jul 2026 12:16:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4344b8bsm13143885c88.13.2026.07.16.12.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:16:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 3/3] tests/functional/hexagon: add arch_tests functional
 test
Date: Thu, 16 Jul 2026 12:15:55 -0700
Message-Id: <20260716191555.3397687-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716191555.3397687-1-brian.cain@oss.qualcomm.com>
References: <20260716191555.3397687-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Wr78KT7bSeJ7GyTognE3MbXiWaWWXm9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfXwmzB6YF7fghJ
 KFJhacqDKAxykz+GieSWAIhdnkw2qHAaJhj+1dY7uENhLLkqDgssJsauhEbiI8axZIlqje3D9cy
 ZUkLFUf447i/re6RCPbgFdE7J67OkwU7qol8HnFx7YVnhAS/O1YIEvwH1OkCl/uFnNgotFxPNaf
 CK4pafL9IPJAHrdcd60CsK4klUz671ejMMVmIoCrwSIJ1S2XxaTQdBlA7ks+AuNQDiBqtRu6PlV
 NZZroei5M7jLuJyBg+s5+ZI0Xaq8sKdWpPADbjGuwhgOm0Pd3jfhcOOeAb6jXyuHEBJbEMuPP9x
 CGWE6x6kztos7ukBGOQn14A5Yt8RGxi80WJTZmi7lXvyrOlpJGTw8jGC8Nw9j5TiebXDeUlzhVO
 0yh87NVv7UlUtqHa+93b5pb3l5vbo8PqD0Azikn6ecA8XflyzjfyJcN+3Tnsdo4X6C9A7I0z0Rf
 ZFv4vA60CGCFQxCkQlw==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a592df5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=Izxiw1ZzzRUUhZzyMRkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Wr78KT7bSeJ7GyTognE3MbXiWaWWXm9T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX080OOfnR+PKO
 4pI/OFhXBDMcN/3sdNS7sr3rBCcS2PDVXLi0fqWVklFcxzQP2+bVnyOznMqS4ZiMkZhSBkojZ51
 E0IA8kMKhZ84BuhpOzc5gmO2OOYXnbI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160197
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

QWRkIG5ldyB0ZXN0IGNhc2VzIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzIHRvIGV4ZXJjaXNlIGV4
Y2VwdGlvbnMsCmd1ZXN0IG1vZGUuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxICsKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWls
ZCAgICAgICAgfCAgNSArKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0
cy5weSB8IDU3ICsrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICB8ICAxICsKIDQgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9u
cygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5i
dWlsZAogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2Fy
Y2hfdGVzdHMucHkKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4
IDYxNzFjYzc0OTQwLi5hODdjNWVkMjNkMSAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIv
TUFJTlRBSU5FUlMKQEAgLTEzNTcsNiArMTM1Nyw3IEBAIEY6IGh3L2hleGFnb24vCiBGOiBpbmNs
dWRlL2h3L2hleGFnb24vCiBGOiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1
bHQubWFrCiBGOiBkb2NzL3N5c3RlbS9oZXhhZ29uLworRjogdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uLwogRjogZG9jcy9kZXZlbC9oZXhhZ29uLXN5cy5yc3QKIAogTG9vbmdBcmNoIE1hY2hpbmVz
CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgYi90ZXN0
cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMDAwMDAuLjJiNWExYThmMjY0Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0wLDAgKzEsNSBAQAorIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCit0ZXN0c19oZXhhZ29uX3N5c3RlbV90
aG9yb3VnaCA9IFsKKyAgJ2FyY2hfdGVzdHMnLAorXQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rp
b25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X2FyY2hfdGVzdHMucHkKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAwMDAw
MDAuLjU0YTE0MTJjNTk3Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMCwwICsxLDU3IEBACisjIS91c3IvYmluL2VudiBw
eXRob24zCisjCisjIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFu
ZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorIworIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcgorCitmcm9tIHFlbXVfdGVzdCBpbXBvcnQgUWVtdVN5c3RlbVRlc3QsIEFz
c2V0Citmcm9tIHFlbXVfdGVzdC5jbWQgaW1wb3J0IHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybgor
CisKK2NsYXNzIEFyY2hUZXN0c1VhcnQoUWVtdVN5c3RlbVRlc3QpOgorICAgICIiIgorICAgIEhl
eGFnb24gYXJjaGl0ZWN0dXJlIHZlcmlmaWNhdGlvbiB0ZXN0cworCisgICAgVGhlc2UgYXJlIGJh
cmUtbWV0YWwgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMgdGhhdCBleGVyY2lzZQorICAg
IHN5c3RlbSBmdW5jdGlvbmFsaXR5LgorCisgICAgVGVzdHMgb3V0cHV0IHJlc3VsdHMgdmlhIFVB
UlQuCisgICAgIiIiCisgICAgdGltZW91dCA9IDYwCisKKyAgICBBU1NFVF9UQVJCQUxMID0gQXNz
ZXQoCisgICAgICAgICJodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1oZXhhZ29uLXRl
c3RpbmcvcmVsZWFzZXMvIgorICAgICAgICAiZG93bmxvYWQvdjAuMi41L2FyY2hfdGVzdHNfdWFy
dC50YXIuZ3oiLAorICAgICAgICAiZWRiNGYzN2I4NzdhM2E3MmEwZTEwOTIwNDc3NDU4YTQzYjQw
MDQ1ZDM0Mzk4ZmVlOGNiNzYzZmVmZDM0MmY0ZiIsCisgICAgKQorCisgICAgZGVmIHJ1bl91YXJ0
X3Rlc3Qoc2VsZiwgdGVzdF9uYW1lOiBzdHIsCisgICAgICAgICAgICAgICAgICAgICAgbWFjaGlu
ZTogc3RyID0gInZpcnQiKSAtPiBOb25lOgorICAgICAgICAiIiIKKyAgICAgICAgUnVuIGFuIGFy
Y2ggdGVzdCBiaW5hcnkgYW5kIHZlcmlmeSBQQVNTIHZpYSBVQVJUIGNvbnNvbGUgb3V0cHV0Lgor
ICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQorICAgICAgICBz
ZWxmLmFyY2hpdmVfZXh0cmFjdChzZWxmLkFTU0VUX1RBUkJBTEwpCisgICAgICAgIHRhcmdldF9i
aW4gPSBzZWxmLnNjcmF0Y2hfZmlsZSgnYXJjaF90ZXN0c191YXJ0X3BhY2thZ2UnLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnYmluJywgdGVzdF9uYW1lKQorICAgICAg
ICBzZWxmLnZtLnNldF9jb25zb2xlKCkKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCItZGlzcGxh
eSIsICJub25lIikKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCIta2VybmVsIiwgdGFyZ2V0X2Jp
bikKKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQorICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3Bh
dHRlcm4oc2VsZiwgIlBBU1MiKQorCisgICAgZGVmIHRlc3RfZXhjZXB0aW9ucyhzZWxmKSAtPiBO
b25lOgorICAgICAgICAiIiJUZXN0cyBleGNlcHRpb24gZGVsaXZlcnkgZm9yIHRyYXAgaW5zdHJ1
Y3Rpb25zLCBwcml2aWxlZ2UKKyAgICAgICAgdmlvbGF0aW9ucywgYW5kIHZlcmlmaWVzIFNTUiBj
YXVzZSBjb2RlcyBhbmQgRUxSIHZhbHVlcy4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVu
X3VhcnRfdGVzdCgidGVzdF9leGNlcHRpb25zIikKKworICAgIGRlZiB0ZXN0X2d1ZXN0X21vZGUo
c2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgZ3Vlc3QgbW9kZSBlbnRyeS9leGl0IHZp
YSBDQ1IgY29uZmlndXJhdGlvbiwgdmVyaWZ5aW5nCisgICAgICAgIEdTUiBmaWVsZHMsIEdFTFIs
IGFuZCBndWVzdCBldmVudCB2ZWN0b3IgdGFibGUgZGlzcGF0Y2guCisgICAgICAgICIiIgorICAg
ICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZ3Vlc3RfbW9kZSIpCisKKworaWYgX19uYW1l
X18gPT0gIl9fbWFpbl9fIjoKKyAgICBRZW11U3lzdGVtVGVzdC5tYWluKCkKZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1
aWxkCmluZGV4IGMxNTgxOTdjNGI3Li5jNzM2MmRkMDBlZiAxMDA2NDQKLS0tIGEvdGVzdHMvZnVu
Y3Rpb25hbC9tZXNvbi5idWlsZAorKysgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkCkBA
IC0xNCw2ICsxNCw3IEBAIHN1YmRpcignYWFyY2g2NCcpCiBzdWJkaXIoJ2FscGhhJykKIHN1YmRp
cignYXJtJykKIHN1YmRpcignYXZyJykKK3N1YmRpcignaGV4YWdvbicpCiBzdWJkaXIoJ2hwcGEn
KQogc3ViZGlyKCdpMzg2JykKIHN1YmRpcignbG9vbmdhcmNoNjQnKQotLSAKMi4zNC4xCgo=

