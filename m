Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6974C79F99
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weM-0001VU-Bq; Sat, 05 Sep 2026 16:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weK-0001Ub-Q1
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weI-000621-UM
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbumP3178423
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=3jT0DseUI5EwatZ80Vvgy8INJ0EtOxAZissldaDewnI=; b=iX
 JLx9EFKsDpO30NtYh/SJKm9UtjOUSh4F/nEnb5Z5rH8Vt3BvTlMpXA20OGfjvHkC
 oGxmpI+Kr3PQO3kUUAYFNeHeUZgKUySXchMWkyH9lJc7hrhjgjyLcfGYlldoXeKt
 0e1RQwZ6U0SmWoQLDNVZWP3QkNP+xNgwWB7j6oYwVNt+bYus8Ql2w/f8XMXyMx4z
 VoUFgRmUxbCPHwoDmxRPxVLRKkj3ucagREEiEFrT0DLXpeIDvgzhyTUXfbu6FWy+
 1Koa3xPfFXCFkpPmLGN5fiZYMgzvjGjFC396/+C8H3lgBWVUMElN7MyHPEZEL1mN
 nIUviLaaJVV2uBQwKYfw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggb5va1ky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:06:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso32707315ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638760; x=1789243560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3jT0DseUI5EwatZ80Vvgy8INJ0EtOxAZissldaDewnI=;
 b=csaQeXV9C+Xn01qEt+mF7kCXcxlLJjr0nPPi804zkcnjX42tnPtUqatGbvez016Y24
 49a9/4oSR9m5Ef21BKYsLih7mHxCSOV5g/lq5jYkOqj2qSw/D7cxWRcB0F1845u6kGTe
 fU5o3gI3COtZKde9zZF36WtcuzHMiud7ENwz172e5l9xPwnizrWCBp6VDs+C4JARFUMg
 Q8Je16uVW6tLglVcnLf8+hJB//NOnWIsiphXAL2gewsTkfzE5bfAEvP5IDj7m2WRX6Sr
 vXeaDK/3+OeIuL81ga62jzdwFUPr+6X5zgMmZBpMNp7g/tZM7FjgA+K6YvDqKVym7Kjz
 huaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638760; x=1789243560;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3jT0DseUI5EwatZ80Vvgy8INJ0EtOxAZissldaDewnI=;
 b=D6KrxOzWCTN8VwPM25KtyEJ0j2a47vTWlVkryoVBSmX1zpWEvZBddA+0NEVVPz05bb
 B/wqOiu7pWc+A61F1IgyqYgDPi7Zcf5v0S68daJrSk/s6jWsCLQPkK77CQwc8/FcItZS
 SE7Nw1FaHC6j8HqFR79ro7tJ+ouS/8wwng8hokGHUeyErAmAzabFmv1/ohe9/ASX3o6l
 vnO0hJWceHbjLTAzWQlCPcf0qA0LHzb2uFCp6SKPZiWKKNNQG9r39Ipy/yO6huhCBIJF
 bMEWyNZEJbQ/63uUIPsK3YhBtquvE1/zNuuaK4+IxV0AFPEqdEU04qlaGF9Q5RRlGn7m
 x96Q==
X-Gm-Message-State: AFuF++kX9v6FG6LPhbt+46fBgEYj2HLgjGHEr1MpBohKx4RGuSeJkS+n
 vajPy7xTYx4SrmWs9TGkCNa6Pmbz0BYF8hd/YKm2ipjVakX/47ezePWT6F0MPknXjzh9XXzkuBo
 93m2aeNq+eMwd5KRA76QZ0KZvzx0YZ2Zo4y+OjXCnvB6QZ14aaySORZ+Eq4aCBV3Ruw==
X-Gm-Gg: AYBFou1rBQAgwcPriHrYteWX3nMkPMegf+okd37PZTnysm0nCWfkDxSxx4qh6pn5CmN
 t2iXe9bgQz234+zu7J4PllLNFMfN+P8Okp3Op5G2QkVA9mIiIDtkD1jl2og3C41I6okTNO4yUwk
 gHbS7D1SNMFVjHZ4MP/Jfe7MpJ1Ct1dEwSpfXi410JMhescCAr7Eclts6EUpO8MLpw8inXR8NXV
 IawDMTTjpZ9AAemnZYXedNyp5/ItRCOtrVdUAwWw4IHXA+cd5P84KQtxj4XZrIwVgxme4H8RnBp
 jAeT56kxEUAr7Ny3Ez+TMDUoDrpaA+rFDb+wwZtP/ik40CZaHQQsDmX3htBTWVMl0zWBmcNh3el
 Tz5RBTDpwKPltcyn3QtnNHFxvUKDZx3PIfnkaxGkC7RqFPRU5
X-Received: by 2002:a17:902:f644:b0:2da:dcd8:713d with SMTP id
 d9443c01a7336-2db126295cfmr209653485ad.15.1788638760401; 
 Sat, 05 Sep 2026 13:06:00 -0700 (PDT)
X-Received: by 2002:a17:902:f644:b0:2da:dcd8:713d with SMTP id
 d9443c01a7336-2db126295cfmr209653035ad.15.1788638760016; 
 Sat, 05 Sep 2026 13:06:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:05:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/9] hw/intc: name the L2VIC edge trigger check
Date: Sat,  5 Sep 2026 13:05:45 -0700
Message-Id: <20260905200550.2009799-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: _gg1Kz8f4toczt4--wte1nwiWGgQOc0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX/WMFCyF1SpyV
 +SErRMO3dNS9QKWgWEwn9xdGiAh139urA1sD75Q6rBiwW8Lap9Kf9sHzw6QOZPUt3pXtnne1wxl
 2kTVKI0jbNzs7BFABFyVYQ2LW+0KDtAD+dg/lKKeKsMNQJvzTbU22dH24vHxK+Dm8qL40MVWe5W
 7oc9QQDBXmGMTCZU2i5fJvL3U2h25/rI+f1f1IISwbnyYuX7fNzISYADFpeDIx9EBY8ikZkMNCw
 WewyvEyFLmbbI+SKmZcalEnomdKEIrlRUHvZWXjvFZzxXVRS3L+FdEd6fmWxw7hmQdNQ/td9/O0
 8YNvADybYl1J0mN52m5hTsugQFPqr1xeH+fB8wzGCVlnpJpTeoiHPW0jZ3vukPEUoMRf5eSuj2j
 T+SjyMbRv8rWdc1GKr0MXUJL1C85PIQrxaV/sXNgahHbpmlRFDEJDzyTR3Mdnlf2yuhZGfmxyKA
 jNepq0aHPqkEuTKiBxg==
X-Authority-Analysis: v=2.4 cv=UO3t2ify c=1 sm=1 tr=0 ts=6a9c7629 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-YUP4bkCidU9H1Stq4YA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: _gg1Kz8f4toczt4--wte1nwiWGgQOc0n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX14iaMovU79xs
 bV3ENrtod6t2hypFP/3/oxNDlLbkxf0FVxgSEqP81GvAyuF5pf2eNtH6en74KGidXCZXfEFURR7
 nEgo+Hr75oGt0J2r3J16YI9gziLfOhY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050223
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

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9jM2YyZjRlMi03OWU5LTRi
M2YtOGJhZS04OGM2NjlhMzRjMGJAb3NzLnF1YWxjb21tLmNvbS8KU3VnZ2VzdGVkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTMgKysrKysrKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9p
bnRjL2hleC1sMnZpYy5jIGIvaHcvaW50Yy9oZXgtbDJ2aWMuYwppbmRleCBhOTg2ZjBiZGYzNS4u
NzM2ZjFiZTNiMWQgMTAwNjQ0Ci0tLSBhL2h3L2ludGMvaGV4LWwydmljLmMKKysrIGIvaHcvaW50
Yy9oZXgtbDJ2aWMuYwpAQCAtOTIsNyArOTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZJQ1N0
YXRlIHsKICAgICBERUNMQVJFX0JJVE1BUDMyKGludF9wZW5kaW5nLCBMMlZJQ19JTlRFUlJVUFRf
TUFYKTsKICAgICAvKiBXaGljaCBlbmFibGVkIGludGVycnVwdCBpcyBhY3RpdmUgKi8KICAgICBE
RUNMQVJFX0JJVE1BUDMyKGludF9zdGF0dXMsIEwyVklDX0lOVEVSUlVQVF9NQVgpOwotICAgIC8q
IEVkZ2Ugb3IgTGV2ZWwgaW50ZXJydXB0ICovCisgICAgLyogMSBmb3IgZWRnZS10cmlnZ2VyZWQs
IDAgZm9yIGxldmVsLXRyaWdnZXJlZCAqLwogICAgIERFQ0xBUkVfQklUTUFQMzIoaW50X3R5cGUs
IEwyVklDX0lOVEVSUlVQVF9NQVgpOwogICAgIERFQ0xBUkVfQklUTUFQMzIoaW50X2dyb3VwX25b
NF0sIEwyVklDX0lOVEVSUlVQVF9NQVgpOwogICAgIHFlbXVfaXJxIGlycVs4XTsKQEAgLTI0OSw2
ICsyNDksMTEgQEAgc3RhdGljIGlubGluZSBib29sIHZpZF9hY3RpdmUoSGV4TDJWSUNTdGF0ZSAq
cykKICAgICByZXR1cm4gYWN0aXZlX2lycSAhPSBzaXplOwogfQogCitzdGF0aWMgYm9vbCBlZGdl
X3RyaWdnZXJlZF9pcnEoSGV4TDJWSUNTdGF0ZSAqcywgaW50IGlycSkKK3sKKyAgICByZXR1cm4g
dGVzdF9iaXQzMihpcnEsIHMtPmludF90eXBlKTsKK30KKwogc3RhdGljIGJvb2wgbDJ2aWNfdXBk
YXRlKEhleEwyVklDU3RhdGUgKnMsIGludCBpcnEpCiB7CiAgICAgYm9vbCBwZW5kaW5nOwpAQCAt
MjcwLDcgKzI3NSw3IEBAIHN0YXRpYyBib29sIGwydmljX3VwZGF0ZShIZXhMMlZJQ1N0YXRlICpz
LCBpbnQgaXJxKQogICAgICAgICAgKiBlbmFibGUgYml0IHNldCBhY3Jvc3MgZGVsaXZlcmllcyAt
LSB0aGUgZmlybXdhcmUgZW5hYmxlcyBvbmNlCiAgICAgICAgICAqIGFuZCBleHBlY3RzIHRoZSBp
bnRlcnJ1cHQgdG8gcmVtYWluIGVuYWJsZWQuCiAgICAgICAgICAqLwotICAgICAgICBpZiAodGVz
dF9iaXQzMihpcnEsIHMtPmludF90eXBlKSkgeworICAgICAgICBpZiAoZWRnZV90cmlnZ2VyZWRf
aXJxKHMsIGlycSkpIHsKICAgICAgICAgICAgIGNsZWFyX2JpdDMyKGlycSwgcy0+aW50X2VuYWJs
ZSk7CiAgICAgICAgIH0KICAgICAgICAgcy0+dmlkID0gaXJxOwpAQCAtMjk5LDcgKzMwNCw3IEBA
IHN0YXRpYyB2b2lkIGwydmljX3NldF9pcnEodm9pZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQgbGV2
ZWwpCiAKICAgICBpZiAobGV2ZWwpIHsKICAgICAgICAgc2V0X2JpdDMyKGlycSwgcy0+aW50X3Bl
bmRpbmcpOwotICAgIH0gZWxzZSBpZiAoIXRlc3RfYml0MzIoaXJxLCBzLT5pbnRfdHlwZSkpIHsK
KyAgICB9IGVsc2UgaWYgKCFlZGdlX3RyaWdnZXJlZF9pcnEocywgaXJxKSkgewogICAgICAgICBj
bGVhcl9iaXQzMihpcnEsIHMtPmludF9wZW5kaW5nKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRl
KHMsIGlycSk7CkBAIC0zMjgsNyArMzMzLDcgQEAgc3RhdGljIHZvaWQgbDJ2aWNfd3JpdGUodm9p
ZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LCB1aW50NjRfdCB2YWwsCiAgICAgICAgIHdoaWxlICgo
Yml0ID0gY3R6MzIoYml0cykpIDwgMzIpIHsKICAgICAgICAgICAgIGludCBpcnEgPSBiYXNlX2ly
cSArIGJpdDsKIAotICAgICAgICAgICAgaWYgKHRlc3RfYml0MzIoaXJxLCBzLT5pbnRfdHlwZSkp
IHsKKyAgICAgICAgICAgIGlmIChlZGdlX3RyaWdnZXJlZF9pcnEocywgaXJxKSkgewogICAgICAg
ICAgICAgICAgIHNldF9iaXQzMihpcnEsIHMtPmludF9wZW5kaW5nKTsKICAgICAgICAgICAgIH0K
ICAgICAgICAgICAgIGJpdHMgJj0gfigxdSA8PCBiaXQpOwotLSAKMi4zNC4xCgo=

