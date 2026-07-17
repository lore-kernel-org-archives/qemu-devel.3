Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF444C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2u-00070M-OP; Fri, 17 Jul 2026 15:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2t-0006tc-9Y
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2r-000875-K3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo6Wt2245131
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUAUQQf5qgHBKQNziG8kgNpwG/tVRFOL0DSOzWaTCb4=; b=Knxgvlvt6Xq+pE81
 E2Iq0HW2CywAT+0XqHxYP9NEKQ+xUE58WrolqFT3LvSYTZbd1s2pxwtxYHUCaY2n
 YtayuNAsN6HraxMPUF8asDfkx36vFqNeBK2lUZobej5EMdzhdEpEDbrfz4d10wN2
 z960Iz3eQuhhPXI11DtOKmfviGXjvz1ojR2yU9VQGZEV+u78ZN2tNSeg7bQqFB+n
 5qktOfqF9F45JCnlC2gVP8H53OwwC2l2pzznUds0E09dZrPzHN24R6Vy066acrQC
 V8DA2ZHVqncr7bVOCk8j4pccB7z3HFLHRoCAx+vJ8y23nMZFcl/ITsh4scsUcQeK
 Vvwz0w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pay51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so7227980a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315773; x=1784920573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WUAUQQf5qgHBKQNziG8kgNpwG/tVRFOL0DSOzWaTCb4=;
 b=kiUjEGMMU3VUPn4RyvQRz1dNEoyhtzmFBdwUd64LHZysYYHw/Z8KcPPCxX/06pi1v8
 M0ToSk+QlB6vbE3M/GQsnJl6KdoPQU2fNSJedG8qvDZsQrSAHwzK/TB6QxnLWU+lRaGC
 Y0B5C3lAsjJhaUTdlvTYTNDQJ3/7YtehRgOqqNRUyax5dlQ81Lu8m+6SjLMTYYK5T+MX
 jhLZb7mceByu7r5LOIxgwC0GoTC1QPFDJtQOwJabDJTnWv2XvaMnHvNrSMddbz2irJrG
 izeVLQx722/Mq5ssz+KoLKyRggryOp7FTH7v8pztOLyP90P2NXG9K6QX4R632ICUsoXb
 +Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315773; x=1784920573;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WUAUQQf5qgHBKQNziG8kgNpwG/tVRFOL0DSOzWaTCb4=;
 b=ah+WEns3FsgZ7SbUXgpy9PquRg0vqmRsmbpWDJrlDYRezT8MC3hMNXbWinBkfTb/gR
 2roRY+4Zo5WqIM5prcnTpcMWWKV/qVkwX3gKnrT3xS1JxOfYs561wlEyKDo94D8JUzL8
 TzhlqCp1f7njraXrEU/DhLdyEQM3BlGyNhXLX/XxaqbVQK14AP6BNM2lt9kBF39Lr47C
 x/tihTnkGtP/7WYdDREQf9LkSp/rV54DKXVX6km93PESx+06iI3WhXZ/V8hw2hc+obvM
 Vl9R4ASwPcHkJstKP7PddNjpPdk1DPyj8L7igbl794QrDHNe2Zq01doR0AOge+mbOlQF
 aJLQ==
X-Gm-Message-State: AOJu0YzQtK8KYig0NJ5wDun/inj5ec+saMZ+PKD5FaKAqWUcS6DPaNDN
 hVckcwEMXOeW/hTdzCAYq/7TFGbgnIPMNHlaT3N13gzlv0op5o5pYa8DpFhqmDgow87xmLddUb8
 4ZTucXdEeNabvNPKMfYT1R3Ldtht7DGd/g1++WWjLfoiDMWWwS75hxGCC2Cc3uIx7JA==
X-Gm-Gg: AfdE7cm76XcICqwxFvHvenMXCqgXLSGIojjMC7rrrcZ9SFFyzsteescsuN+utBG4MRg
 rGjnTl3rxOfDxZCe/P3S8vHwz5mmr2rvRrxkeOWKs59/3pgZIfvvz9eKcif0K/HLaqgua2nWaWz
 ayQE80MmLpV8QW24R5OD3x4KnzE8Viux6yIvXJYT8NX7WvWMNcz7rKQr3HS9UW35KJvYFb2vQpm
 M383ULW2QJ5mu6GiwBHheew6xho3mVfT+xaDAOgQn/nqIzjlOxQJBNCvz5qsAD0qPpZWL48p4+u
 YWqx8NrhccZQOM37XFl7VfhOO5nX2pqf9ZyhTUA5spKkgEG+8QWYZT7o7FWHxzP+5QviH8NBaGg
 EvJ5XblL7R04JLFF6uyq+vTn6roUi/VLglLVxVvLuZjc+y0EN
X-Received: by 2002:a17:90b:250f:b0:38e:4b60:e01 with SMTP id
 98e67ed59e1d1-38e4b602953mr2850212a91.12.1784315773133; 
 Fri, 17 Jul 2026 12:16:13 -0700 (PDT)
X-Received: by 2002:a17:90b:250f:b0:38e:4b60:e01 with SMTP id
 98e67ed59e1d1-38e4b602953mr2850177a91.12.1784315772651; 
 Fri, 17 Jul 2026 12:16:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:16:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/12] tests/functional/hexagon: add arch_tests functional test
Date: Fri, 17 Jul 2026 12:15:47 -0700
Message-Id: <20260717191547.920048-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: I2IGykUbxc_51efvUnJY79KLSTPFux-r
X-Proofpoint-ORIG-GUID: I2IGykUbxc_51efvUnJY79KLSTPFux-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX5yNfkbgnhmbf
 eJ6eNnh7l6+KTl1DoTSubkYHtf9XXavLxRYBNFQuWdVxIM0W9335KNUZNU6674BwHzEbUSLTHZN
 DoiYJPflahYtOq3re4wcmxR64rBeMfzBr1kHd5Yf136r9ogUpV7iDONP9ewE5daQ09C9pBfT7qu
 bfwnDSAuhjHcJlPNjx92CGZE08AxCghi9VPFL/C0RO8HZRf3rW+gpWy0SwdbzV68HFQJhjonQLt
 8DjQF79efKywVsejMiFccKnZGfmwabDMo5XK1NlgPWRJREZ19pvIycVidpfVlYRBZxWW70ls/TC
 JP4JLThcHtLptP22nIrLB5XN8ztYPazjjv802GfUlZrAXIUmgjhE8XpsTuts1D3EOCyaF1HbwrT
 B00XHoO9/E7GLO362apr6h87609lJldE4dz+dEJVFAG0APu+PZv5kn8/xrswnQ7kBThzOvVi5i6
 kx9llAalTs02HTv9Y0g==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a7f7e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=kSmQlivvWz0e5I5yAQ8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX/SpVKA+meuF/
 F4ybATgsAK/rIlBJP5gd9D+v4/pUsdVGCGxLHqPIvVyc5WzyHlgbxoyQqEgDfw+pzXJvrwuhhja
 ZiZZb57qm9wJHEm4vIas/OghNqw6aSo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

QWRkIG5ldyB0ZXN0IGNhc2VzIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzIHRvIGV4ZXJjaXNlIGV4
Y2VwdGlvbnMsCmd1ZXN0IG1vZGUuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9t
ZXNvbi5idWlsZCAgICAgICAgfCAgNSArKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
YXJjaF90ZXN0cy5weSB8IDU3ICsrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvZnVuY3Rpb25h
bC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICB8ICAxICsKIDQgZmlsZXMgY2hhbmdlZCwgNjQg
aW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi9tZXNvbi5idWlsZAogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X2FyY2hfdGVzdHMucHkKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTCmluZGV4IGVjNTZlNWM1NTc3Li43NGZjNDNmNWYyMCAxMDA2NDQKLS0tIGEvTUFJTlRBSU5F
UlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTEzNTcsNiArMTM1Nyw3IEBAIEY6IGh3L2hleGFnb24v
CiBGOiBpbmNsdWRlL2h3L2hleGFnb24vCiBGOiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0
bW11L2RlZmF1bHQubWFrCiBGOiBkb2NzL3N5c3RlbS9oZXhhZ29uLworRjogdGVzdHMvZnVuY3Rp
b25hbC9oZXhhZ29uLwogRjogZG9jcy9kZXZlbC9oZXhhZ29uLXN5cy5yc3QKIAogTG9vbmdBcmNo
IE1hY2hpbmVzCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVp
bGQgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjJiNWExYThmMjY0Ci0tLSAvZGV2L251bGwKKysrIGIv
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0wLDAgKzEsNSBAQAorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorCit0ZXN0c19oZXhhZ29u
X3N5c3RlbV90aG9yb3VnaCA9IFsKKyAgJ2FyY2hfdGVzdHMnLAorXQpkaWZmIC0tZ2l0IGEvdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXgg
MDAwMDAwMDAwMDAuLjU0YTE0MTJjNTk3Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVuY3Rp
b25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMCwwICsxLDU3IEBACisjIS91c3Iv
YmluL2VudiBweXRob24zCisjCisjIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVz
LCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorIworIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitmcm9tIHFlbXVfdGVzdCBpbXBvcnQgUWVtdVN5c3Rl
bVRlc3QsIEFzc2V0Citmcm9tIHFlbXVfdGVzdC5jbWQgaW1wb3J0IHdhaXRfZm9yX2NvbnNvbGVf
cGF0dGVybgorCisKK2NsYXNzIEFyY2hUZXN0c1VhcnQoUWVtdVN5c3RlbVRlc3QpOgorICAgICIi
IgorICAgIEhleGFnb24gYXJjaGl0ZWN0dXJlIHZlcmlmaWNhdGlvbiB0ZXN0cworCisgICAgVGhl
c2UgYXJlIGJhcmUtbWV0YWwgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMgdGhhdCBleGVy
Y2lzZQorICAgIHN5c3RlbSBmdW5jdGlvbmFsaXR5LgorCisgICAgVGVzdHMgb3V0cHV0IHJlc3Vs
dHMgdmlhIFVBUlQuCisgICAgIiIiCisgICAgdGltZW91dCA9IDYwCisKKyAgICBBU1NFVF9UQVJC
QUxMID0gQXNzZXQoCisgICAgICAgICJodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1o
ZXhhZ29uLXRlc3RpbmcvcmVsZWFzZXMvIgorICAgICAgICAiZG93bmxvYWQvdjAuMi41L2FyY2hf
dGVzdHNfdWFydC50YXIuZ3oiLAorICAgICAgICAiZWRiNGYzN2I4NzdhM2E3MmEwZTEwOTIwNDc3
NDU4YTQzYjQwMDQ1ZDM0Mzk4ZmVlOGNiNzYzZmVmZDM0MmY0ZiIsCisgICAgKQorCisgICAgZGVm
IHJ1bl91YXJ0X3Rlc3Qoc2VsZiwgdGVzdF9uYW1lOiBzdHIsCisgICAgICAgICAgICAgICAgICAg
ICAgbWFjaGluZTogc3RyID0gInZpcnQiKSAtPiBOb25lOgorICAgICAgICAiIiIKKyAgICAgICAg
UnVuIGFuIGFyY2ggdGVzdCBiaW5hcnkgYW5kIHZlcmlmeSBQQVNTIHZpYSBVQVJUIGNvbnNvbGUg
b3V0cHV0LgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQor
ICAgICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChzZWxmLkFTU0VUX1RBUkJBTEwpCisgICAgICAg
IHRhcmdldF9iaW4gPSBzZWxmLnNjcmF0Y2hfZmlsZSgnYXJjaF90ZXN0c191YXJ0X3BhY2thZ2Un
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnYmluJywgdGVzdF9uYW1l
KQorICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xlKCkKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJn
KCItZGlzcGxheSIsICJub25lIikKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCIta2VybmVsIiwg
dGFyZ2V0X2JpbikKKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQorICAgICAgICB3YWl0X2Zvcl9j
b25zb2xlX3BhdHRlcm4oc2VsZiwgIlBBU1MiKQorCisgICAgZGVmIHRlc3RfZXhjZXB0aW9ucyhz
ZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0cyBleGNlcHRpb24gZGVsaXZlcnkgZm9yIHRy
YXAgaW5zdHJ1Y3Rpb25zLCBwcml2aWxlZ2UKKyAgICAgICAgdmlvbGF0aW9ucywgYW5kIHZlcmlm
aWVzIFNTUiBjYXVzZSBjb2RlcyBhbmQgRUxSIHZhbHVlcy4KKyAgICAgICAgIiIiCisgICAgICAg
IHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9leGNlcHRpb25zIikKKworICAgIGRlZiB0ZXN0X2d1
ZXN0X21vZGUoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgZ3Vlc3QgbW9kZSBlbnRy
eS9leGl0IHZpYSBDQ1IgY29uZmlndXJhdGlvbiwgdmVyaWZ5aW5nCisgICAgICAgIEdTUiBmaWVs
ZHMsIEdFTFIsIGFuZCBndWVzdCBldmVudCB2ZWN0b3IgdGFibGUgZGlzcGF0Y2guCisgICAgICAg
ICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZ3Vlc3RfbW9kZSIpCisKKwor
aWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKKyAgICBRZW11U3lzdGVtVGVzdC5tYWluKCkKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQgYi90ZXN0cy9mdW5jdGlvbmFs
L21lc29uLmJ1aWxkCmluZGV4IGMxNTgxOTdjNGI3Li5jNzM2MmRkMDBlZiAxMDA2NDQKLS0tIGEv
dGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZAorKysgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29u
LmJ1aWxkCkBAIC0xNCw2ICsxNCw3IEBAIHN1YmRpcignYWFyY2g2NCcpCiBzdWJkaXIoJ2FscGhh
JykKIHN1YmRpcignYXJtJykKIHN1YmRpcignYXZyJykKK3N1YmRpcignaGV4YWdvbicpCiBzdWJk
aXIoJ2hwcGEnKQogc3ViZGlyKCdpMzg2JykKIHN1YmRpcignbG9vbmdhcmNoNjQnKQotLSAKMi4z
NC4xCgo=

