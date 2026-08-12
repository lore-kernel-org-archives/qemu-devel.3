Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE1C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Tm-00074y-DH; Wed, 12 Aug 2026 02:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tk-00074Q-Uq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Ti-0003n2-V3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62e0T2948897
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=2TDWanm7s5saDWID0dlBmKuXPvzhlMSOUqamjpo0QYE=; b=Qt
 jI+rjDWxYmjMWYherhUwtCtpikWjCeReZyUogdXiblHEFm07ZHxIG9/yBwOn/XDE
 wWtDux90mTZzOCObFFTvO9rnQ7bfUrqny2Rr/J0slbMjz+ETyM7H3MqXHKImZHeZ
 BhIg0X4By+vjVJjy2NzYndaaXRNdo8WpKpun72ECrHFPX/96ueWzQD/1Xt/boaWK
 NcOpTfY1wOZuyybirIwNNvnke2PkH/pqYGLu40tINyVZIdmeyem6af1bi6IjS8Ym
 kp5k4xqU/04rcbPGwYEihitRfv9jd8DvGtPnznnzikRCUEYGFiKy3Vg78NUzO7sX
 onEiHza809+Xlnjkr7yA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2rf1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-392cf18db8eso920831a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516217; x=1787121017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2TDWanm7s5saDWID0dlBmKuXPvzhlMSOUqamjpo0QYE=;
 b=gdxALc4cAnRrVZ71QmgseuaEWktNco0yBRpkKqMCpzqJP7Wi/XjgDFdhYiFgzq+kBg
 iEjcRdbpPzYiEwzh4vq9sQHkxMa+ubWR0OPBnet2Qe80TSf6ShmSl0XPzO/aXrbjzIrb
 l9cKIWoDRR6EmAmH5gy+Ewosqgeag10gKgn6zetv27j3dWIJ/DMQCiYNijV2K7pz8EdR
 lQf6q1W/RARIQxOvBObEMnBrmXe57jXHeLsQHJfP+F8caUCJKdgscziu17LSvfuufX9/
 AyhFbkIcitzzoVXPrWKbHiK3/6qkC0WqJ7j3UvFd/bskEbtdjKWAT3/Lz2prA9DRpeTY
 jSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516217; x=1787121017;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2TDWanm7s5saDWID0dlBmKuXPvzhlMSOUqamjpo0QYE=;
 b=hRByiFfzkj2FqXu8p1sDO8D52SrmroiyefliOb0KB3kbY2hBejJDn6vBy7cM2fa2Aa
 FoU/pVjHOnoeMcYoXzcM0lsfGhjn3gWGfA+zldOyN2qtiMEXabp5IE3EtKiFu6eb9pi6
 DfyKdY8EWAnwWJ9X1C39x0QZZjxLLw2ecIJZNbcuIsLWjzxX0mGZg4roRswa9hun1G7t
 2Q8y/NY8G5Bm9lJOPflABp6DawwIOz7y66kr8yNaFYMvJJfDJSuN1BFA688AUQcVSJAv
 ubCfXfkrvldW3O67FrFhZZciNMfrzAVxiEeMQWqpiZs0co06qG0+2u6OjtUNqtD8/RP/
 rCrg==
X-Gm-Message-State: AOJu0Yy7OitA4DgeIZuO9tJXmVP/96EmE3TVgg8f0zyvSXakN7w77ovB
 N7eqb7yaNXroCnmoVGbE/Q9y2wBF7WOE2/9Q1P4gjaXvXUK3RriUAuBCZ5g5JwXhobBjB40fJA1
 54HID/xoQkpClecytv6yfbdszzZZ3+YtjOeChQ3Y5kUqny2WNPEgZ/qM1vGQzrrc5dQ==
X-Gm-Gg: AR+sD12amf53B3g4eqcL95BDq32M/piyjqLejrT/ePa4om0qpYbKlJ7GMGfwUpIBsoX
 ojSn0ASjneJOnSNGV3w6zqgffqjyd3VX0ZQ4kWf62GsxUMspZ9yFCCpuysCI3sMOL8YAhFwh/6c
 +P1xMVIcD8b9qb4h7mySTDVXJ8D/sVXBy6H1Kqz908KC4OU7pSBcBZNmbn7SyLN0vvc6tiyRQ8p
 sUAYBOQVbX4hF4Y+7qAQq9VB2mlcgpQxGikYu4xR+fhUiZ2okFlC7xnZL1kVqeDwXdKO7LVEsLg
 kTvp4tFRyWurEUFpbduZX1iYZoXHaqLf80y6QO9qR6ImSEXvp0/IHzoaD5nhQLAxam0xSCjryZ1
 oU/JqwBM4Rkna4aqRGoy9MfUTudPVlAe0x1luDJOeINFN1mx9
X-Received: by 2002:a17:90b:52cc:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-39301663b84mr3102881a91.16.1786516216487; 
 Tue, 11 Aug 2026 23:30:16 -0700 (PDT)
X-Received: by 2002:a17:90b:52cc:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-39301663b84mr3102539a91.16.1786516213806; 
 Tue, 11 Aug 2026 23:30:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 08/41] hw/hexagon: extract get_reg_value/set_reg_value stubs in
 globalreg
Date: Tue, 11 Aug 2026 23:28:59 -0700
Message-Id: <20260812062932.543840-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c12f9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9smrWREWR_s8Awy1JTMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vkRWlr7vPuQrmWKr6-B8xGqK8aPSHNFk
X-Proofpoint-GUID: vkRWlr7vPuQrmWKr6-B8xGqK8aPSHNFk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX7m8j7YHXWJgn
 uKQXf6euH8MAcOUwhMM5E6tUmIv8z/DwiYHJMGT4QNHAAv+S1annLlcRJAYT770elvrchMNjWEx
 /10f3jEWzls0RaTEDAlUsWjx3WK/quA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX+m4YLnpiK7LA
 0WBjStM44BwNGsonv3AS4e2pAzx64RbU4hGHsVn4a4d4LhCekSnviAu8RSVZHBSzcU2yy8OheTJ
 psfUXd1OzBV/mBMxe6hsLZxDxrkGwlfUUZcG23uTSbvBmqpv0byMxNVPPrvZTI6C9mMJviu4EyE
 IGXtXKQ3H+axB1Nbr93rfzvJGSwD+/5bObwkLWsP0asYGUsaK4vA8l4XvKkfWk5fFVWuIX+pJI5
 8QShM6q89N/ukkmbJ4ujH7kJ1VNQywV+VaIydtHcBDf2XnN9k6IX1ciwWonz2l1gpfTDkRuc22H
 3HUpolk6WTEktvf9TO0xib0tLxDTxA2xo/peKu07vmwQWHc1q2XopzhkniEsPKzu9cL/O6eSHpz
 BUaYw4xvkHKk7e3h3LsQLhe9+xIIpKEC/+mCnbJr6J50HqX4qcCasrpCuk4GXECbDMn30SYzFPw
 nQ/Y+QyPo9cML3lxakQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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

Um91dGUgdGhlIGdsb2JhbHJlZyByZWFkL3dyaXRlIGFjY2Vzc29ycyB0aHJvdWdoIG5ldwpnZXRf
cmVnX3ZhbHVlKCkvc2V0X3JlZ192YWx1ZSgpIGhlbHBlcnMgaW5zdGVhZCBvZiB0b3VjaGluZwpz
LT5yZWdzW3JlZ10gZGlyZWN0bHkuCgpUaGlzIHdpbGwgYmUgZXhwbG9pdGVkIGJ5IGEgc3Vic2Vx
dWVudCBwYXRjaCB0aGF0IHJlZGlyZWN0cyBWSUQvVklEMQphY2Nlc3NlcyB0byB0aGUgTDJWSUMu
CgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNv
bW0uY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA2
MDQyNzIzLjM3ODUzNjktOS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFn
b24vaGV4YWdvbl9nbG9iYWxyZWcuYyB8IDIzICsrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZ2xv
YmFscmVnLmMKaW5kZXggYjVlNTkxMzUwN2UuLjEwNTQ3NTIxOWFiIDEwMDY0NAotLS0gYS9ody9o
ZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5jCkBAIC0xMzUsNiArMTM1LDE3IEBAIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgYXBwbHlf
d3JpdGVfbWFzayh1aW50MzJfdCBuZXdfdmFsLCB1aW50MzJfdCBjdXJfdmFsLAogICAgIHJldHVy
biBuZXdfdmFsOwogfQogCitzdGF0aWMgdWludDMyX3QgZ2V0X3JlZ192YWx1ZShIZXhhZ29uR2xv
YmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZykKK3sKKyAgICByZXR1cm4gcy0+cmVnc1tyZWdd
OworfQorCitzdGF0aWMgdm9pZCBzZXRfcmVnX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAq
cywgdWludDMyX3QgcmVnLAorICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1
ZSkKK3sKKyAgICBzLT5yZWdzW3JlZ10gPSB2YWx1ZTsKK30KKwogdWludDMyX3QgaGV4YWdvbl9n
bG9iYWxyZWdfcmVhZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgaHRpZCkKIHsKQEAgLTE0Niw3
ICsxNTcsNyBAQCB1aW50MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKEhleGFnb25HbG9iYWxS
ZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgIGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7
CiAgICAgZ19hc3NlcnQocmVnID49IEhFWF9TUkVHX0dMQl9TVEFSVCk7CiAKLSAgICB2YWx1ZSA9
IHMtPnJlZ3NbcmVnXTsKKyAgICB2YWx1ZSA9IGdldF9yZWdfdmFsdWUocywgcmVnKTsKIAogICAg
IHRyYWNlX2hleGFnb25fZ2xvYmFscmVnX3JlYWQoaHRpZCwgZ2V0X3NyZWdfbmFtZShyZWcpLCB2
YWx1ZSk7CiAgICAgcmV0dXJuIHZhbHVlOwpAQCAtMTYwLDcgKzE3MSw3IEBAIHZvaWQgaGV4YWdv
bl9nbG9iYWxyZWdfd3JpdGUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcs
CiAgICAgfQogICAgIGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7CiAgICAgZ19hc3NlcnQocmVn
ID49IEhFWF9TUkVHX0dMQl9TVEFSVCk7Ci0gICAgcy0+cmVnc1tyZWddID0gdmFsdWU7CisgICAg
c2V0X3JlZ192YWx1ZShzLCByZWcsIHZhbHVlKTsKICAgICB0cmFjZV9oZXhhZ29uX2dsb2JhbHJl
Z193cml0ZShodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKIH0KIApAQCAtMTY4LDYg
KzE3OSw3IEBAIHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVnX21hc2tlZF92YWx1ZShIZXhhZ29u
R2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1ZSkKIHsKICAgICB1aW50MzJfdCByZWdfbWFz
azsKKyAgICB1aW50MzJfdCBjdXJfdmFsOwogCiAgICAgaWYgKCFzKSB7CiAgICAgICAgIHJldHVy
biB2YWx1ZTsKQEAgLTE3NSw5ICsxODcsMTAgQEAgdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdf
bWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAg
IGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7CiAgICAgZ19hc3NlcnQocmVnID49IEhFWF9TUkVH
X0dMQl9TVEFSVCk7CiAgICAgcmVnX21hc2sgPSBnbG9iYWxfc3JlZ19pbW11dF9tYXNrc1tyZWdd
OworICAgIGN1cl92YWwgPSBnZXRfcmVnX3ZhbHVlKHMsIHJlZyk7CiAgICAgcmV0dXJuIHJlZ19t
YXNrID09IElNTVVUQUJMRSA/Ci0gICAgICAgICAgICBzLT5yZWdzW3JlZ10gOgotICAgICAgICAg
ICAgYXBwbHlfd3JpdGVfbWFzayh2YWx1ZSwgcy0+cmVnc1tyZWddLCByZWdfbWFzayk7CisgICAg
ICAgICAgICBjdXJfdmFsIDoKKyAgICAgICAgICAgIGFwcGx5X3dyaXRlX21hc2sodmFsdWUsIGN1
cl92YWwsIHJlZ19tYXNrKTsKIH0KIAogdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZV9tYXNr
ZWQoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCkBAIC0xODYsNyArMTk5
LDcgQEAgdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZV9tYXNrZWQoSGV4YWdvbkdsb2JhbFJl
Z1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAgICAgaWYgKCFzKSB7CiAgICAgICAgIHJldHVybjsK
ICAgICB9Ci0gICAgcy0+cmVnc1tyZWddID0gaGV4YWdvbl9nbG9iYWxyZWdfbWFza2VkX3ZhbHVl
KHMsIHJlZywgdmFsdWUpOworICAgIHNldF9yZWdfdmFsdWUocywgcmVnLCBoZXhhZ29uX2dsb2Jh
bHJlZ19tYXNrZWRfdmFsdWUocywgcmVnLCB2YWx1ZSkpOwogfQogCiB1aW50NjRfdCBoZXhhZ29u
X2dsb2JhbHJlZ19nZXRfcGN5Y2xlX2Jhc2UoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzKQotLSAK
Mi4zNC4xCgo=

