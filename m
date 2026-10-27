Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59730606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eJSEnTyU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klPIGFhQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLYNC-0004uR-Qr; Tue, 27 Oct 2026 00:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLYN3-0004tX-8P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:01:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLYMw-00030b-Cl
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:01:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F8Rt867555
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=; b=eJSEnTyUkDWohbvi
 7f/YYt0fHDsN5rnJ26pYGpDEP8IRYXEfT4mIENfZ4+ycDMIe3DQYe0fpuSvuNnYj
 YUOzUGEcqEM+iJW54dVTK0hoXb7TQOzDTiM683jLUbQ+e8gJnFaYNu06B4xPlGxz
 ASDf14lc/ilzleTj9XBZvvFFCcZvzLd2yQ6IvoTu4UKxP1GinBYs/QzIRbgGbKVc
 7BDiTK/jl0kMMSaAFIcP2XuyQCpsK3YXnWZ2juiTWbrAHzLV3epEDXgSHBTw4O2z
 iCHz6ja7TWCykTIQOsz3WrsmnroDckdy+fH8FM5xOvsvbIh21OxK0PQwOtue0nkw
 dgtVlQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xu0gs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:00:59 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-83c2311eb1dso6664390a34.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793073658; x=1793678458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=klPIGFhQPIWWSOQgA7+oXYMQyvpdUZrh6yP63twGKMNHiJmVGvzgYEJQ7ufw023A0N
 rMIC5uvZaEe1niNDQ8Cxd5HEpTfPTdiLoeJT7hxXW+MAVeZGiacxkWm3bITOXI/ilnYP
 rUQYhtcdrRUqqNQJqQOBLbaaiiXdrMXsrEHZBqSzMzvpTefoxyupvtIwnjvTrE4yAsO7
 a6tgzZDD/mf2RYdxwtcxBvoxRbz9l7mcTMG6PWYKvBZwgiD7eAIbo3lTQFXnCIvodxD0
 tEUzOhOuO0hk3FkuChaWW07VEeM1YfdaGRd2O+35n96/P/e0ZJtl9iDk4EgHCyTpZJzl
 atFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793073658; x=1793678458;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=ayKTL2cmX/paM/MxwLJ7AWCKyt19clXZKSvhmIFXawQf5YgOUwRmDJoeyYKS1ya6SM
 F7+yJBIoAKCN3QtyIMU1VvqhBjPf4ARsVtobfWoe4jhzDaopQz7tqfJhVfu4vI4PKenl
 KwBQgT7MkTZOJco/9Ujo0IlOXUeIGF1hJCTDBO1gNpQvH9LaVz6QesGL8w1abXcgLCEA
 U21siFQBUvZXEndsCQAdIzPhGQ/3GQNiPRW9DK0WIM66gOVYIWbSeIAIN7vEYzm93C6d
 6ZmGRYSrinwEbj1XnTDRa8mDVN9gULjMMFv4jyk1r/mnBTS/Qdj/+EBatpEkACdegqB8
 JJWQ==
X-Gm-Message-State: AFq9FYLNu/BzshTaUQupd8LebPBSaK1UyGmSbDKCybvlDRcbt+eZB/KD
 +n9ASPtndQtLW7fbaDmy2pP6vYjWpOaMbiUdI6D/jG6NnSGWTKbxWNH66YoDXmKHfQ4BIh60R1q
 ub9kn0YdWG1qKNKSGG9HKPgFJE5I/kCaYDMawxXfBaxd4umvwLTJcD/6p7cSBjgxc1A==
X-Gm-Gg: AYBFou0k5IkTKERVKYLVYXP8SIEbV+M3Y0Wls7J4PMjlYDe+/yuHGd0X+st8aGVPc/g
 M+XuDCxy2+RxsfqDA4QgXTcjPKflerkLkzmGuMZmmmpPzkruWKKsm0GhAIkf/t0uPQDFzA36Uqw
 L0aWXFHonPcuhshdVyZHLtNK9seg6sSRe0Fq5nBoT9gJjExn/bphEW+quKHWDhF9m2tdyrd3phL
 hjOWhdkadATxHQ0Uhf2FK+dNfSlTIq3BsI7hFgWHwUPPpwdO4G9ieMd9urvCh/v+NcJSiXUbMQb
 Mu/SiF98N58NvTRx7HV4ZDShu76Md8LaapVvO2RfdnrH4a7zzAA+gO6D056n9GjzFELAxmVI3Kr
 kXQ9NDfCVPzFGbP3JxBdtHNQpgQyvlhcohhyVcSB5O28uMYw=
X-Received: by 2002:a05:6830:44a3:b0:81c:a8c5:633c with SMTP id
 46e09a7af769-850fde2c9ccmr7299910a34.17.1793073658571; 
 Mon, 26 Oct 2026 21:00:58 -0700 (PDT)
X-Received: by 2002:a05:6830:44a3:b0:81c:a8c5:633c with SMTP id
 46e09a7af769-850fde2c9ccmr7299886a34.17.1793073658061; 
 Mon, 26 Oct 2026 21:00:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fbb25f59sm9489121a34.20.2026.10.26.21.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 21:00:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 40/41] target/hexagon: only flush the softtlb when SSR.ASID
 changes
Date: Mon, 26 Oct 2026 20:29:26 -0700
Message-Id: <20261027032927.3055166-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JLUnhncFAIjPYVbrBgcG4Hd4HLXbnsoH
X-Proofpoint-GUID: JLUnhncFAIjPYVbrBgcG4Hd4HLXbnsoH
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae021fb cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=03mWCbMf3N1Ipu_5KecA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxNSBTYWx0ZWRfXyGA8NOR8CMNI
 y6NGCnh1Xq0TvnnY7YP2oVgWnqBezgyeugP2gt4WpEM3UrV+vP9OeMLKNvpL6zzDZ8yuBcIsnpn
 4baOafqcjxRwr4mqwL+8nJE3YQe91LN+n+rqw/+ktwRKRAKDeIVwi/VyOllKpL0VxWtsSAk/4H+
 cqwrRAaSePpxYXRBtaYEVPPnZP+2B7Cxd8rcX0rpoenJrSQTGUsviktbyytEdU5ITeJO9cQFnba
 DomQ3lJ2l1at2HdGQmBkkYaoW7Jczoh6VKPRYrvTB9x27pf1mgKdk5OtebnOZrZB20bsTZxB1+g
 H2jsvJav3X3uSRFtm1l8NFVoTNotYdb+Dd0BkEnwivyF7dH+J7yaSh+MsgOEbNPNB2UYeXs1AeA
 yNQkkpwCnHOyvmF80kV4LCayX5hQjthy4Ssk1n+21VE0T01m0h6QyVx4K4K+hcK1J3Nhojo/Fds
 KphUp778a+wQXkR/mjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxNSBTYWx0ZWRfX59BN23TI/Qt8
 6Z8QfvpsQywFsd37BaGmdZOwFkpfRyw/3+8XHqfLX7fRTglsoH+c018hiXKWvjibbkDEgCzXm5X
 W074tAqiF6f0fKbhpYRJbMfJ9VUfEW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270015
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aGV4YWdvbl9tb2RpZnlfc3NyKCkgZmx1c2hlZCB0aGUgc29mdHRsYiBvbiBhbnkgY2hhbmdlIHRv
IFNTUi5FWCwgVU0sIEdNLApvciBBU0lELCBidXQgb25seSBBU0lEIGFmZmVjdHMgdHJhbnNsYXRp
b24uICBFWC9VTS9HTSBqdXN0IHBpY2sgdGhlIG1vZGUsCndoaWNoIGlzIGFscmVhZHkgY2FwdHVy
ZWQgaW4gbW11X2lkeC4KCkVYIHRvZ2dsZXMgb24gZXZlcnkgZXhjZXB0aW9uIGVudHJ5L3J0ZSwg
c28gdGhlIGZsdXNoIGNyZWF0ZWQgYSBmZWVkYmFjawpsb29wIHdoZXJlIGEgVExCIG1pc3Mgd2lw
ZWQgdGhlIHNvZnR0bGIgYW5kIGd1YXJhbnRlZWQgdGhlIG5leHQgYWNjZXNzZXMKbWlzc2VkIHRv
by4KClJlbmFtZSBoZXhfbW11X21vZGVfY2hhbmdlKCkgdG8gaGV4X21tdV9hc2lkX2NoYW5nZSgp
IHRvIG1hdGNoIHdoYXQgbm93CnRyaWdnZXJzIGl0LCBhbmQgbmFycm93IGl0IHRvIHRoaXMgdGhy
ZWFkJ3MgbW11IGluZGljZXM6IHRoZSBBU0lEIGxpdmVzIGluCnRoZSB0aHJlYWQncyBwcml2YXRl
IFNTUiwgc28gb3RoZXIgQ1BVcyBhcmUgdW5hZmZlY3RlZC4KClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
IHwgMTcgKysrLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICB8ICA3
ICsrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmggYi90YXJnZXQvaGV4YWdv
bi9oZXhfbW11LmgKaW5kZXggMGM0OTQwNDQ0OGMuLjliNmVhNWI5NjdiIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZXhfbW11LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oCkBA
IC0xNyw3ICsxNyw3IEBAIGV4dGVybiB2b2lkIGhleF90bGJfaW52YWxpZGF0ZV9hc2lkKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBhc2lkKTsKIGV4dGVybiB1aW50MzJfdCBoZXhfdGxi
X2xvb2t1cChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3NyLCB1aW50MzJfdCBWQSk7
CiBleHRlcm4gdm9pZCBoZXhfbW11X29uKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIGV4dGVybiB2
b2lkIGhleF9tbXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KTsKLWV4dGVybiB2b2lkIGhleF9t
bXVfbW9kZV9jaGFuZ2UoQ1BVSGV4YWdvblN0YXRlICplbnYpOworZXh0ZXJuIHZvaWQgaGV4X21t
dV9hc2lkX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiBleHRlcm4gYm9vbCBoZXhfdGxi
X2ZpbmRfbWF0Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGh3YWRkciAq
UEEsIGludCAqcHJvdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAq
c2l6ZSwgaW50MzJfdCAqZXhjcCwgaW50IG1tdV9pZHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDkx
OWZjYmM3Yzk3Li5iYWZmZTZiYmFhOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hl
bHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTkyLDI3ICsxOTIs
MTcgQEAgdW5zaWduZWQgaGV4YWdvbl9odnhfc2VsZWN0X2NvbnRleHQoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHVpbnQzMl90IHNzcikKIAogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewotICAgIGJvb2wgb2xk
X0VYLCBvbGRfVU0sIG9sZF9HTSwgb2xkX0lFOwotICAgIGJvb2wgbmV3X0VYLCBuZXdfVU0sIG5l
d19HTSwgbmV3X0lFOworICAgIGJvb2wgb2xkX0VYLCBvbGRfSUU7CisgICAgYm9vbCBuZXdfRVgs
IG5ld19JRTsKICAgICB1aW50OF90IG9sZF9hc2lkLCBuZXdfYXNpZDsKIAogICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CiAKICAgICBvbGRfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgb2xk
KTsKLSAgICBvbGRfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgb2xkKTsKLSAgICBvbGRfR00g
PSBHRVRfU1NSX0ZJRUxEKFNTUl9HTSwgb2xkKTsKICAgICBvbGRfSUUgPSBHRVRfU1NSX0ZJRUxE
KFNTUl9JRSwgb2xkKTsKICAgICBuZXdfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgbmV3KTsK
LSAgICBuZXdfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgbmV3KTsKLSAgICBuZXdfR00gPSBH
RVRfU1NSX0ZJRUxEKFNTUl9HTSwgbmV3KTsKICAgICBuZXdfSUUgPSBHRVRfU1NSX0ZJRUxEKFNT
Ul9JRSwgbmV3KTsKIAotICAgIGlmICgob2xkX0VYICE9IG5ld19FWCkgfHwKLSAgICAgICAgKG9s
ZF9VTSAhPSBuZXdfVU0pIHx8Ci0gICAgICAgIChvbGRfR00gIT0gbmV3X0dNKSkgewotICAgICAg
ICBoZXhfbW11X21vZGVfY2hhbmdlKGVudik7Ci0gICAgfQotCiAgICAgYm9vbCB4YV9jaGFuZ2Vk
ID0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG5ldykgIT0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG9s
ZCk7CiAgICAgYm9vbCB4ZV9jaGFuZ2VkID0gR0VUX1NTUl9GSUVMRChTU1JfWEUsIG5ldykgIT0g
R0VUX1NTUl9GSUVMRChTU1JfWEUsIG9sZCk7CiAKQEAgLTIyOCw4ICsyMTgsNyBAQCB2b2lkIGhl
eGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50
MzJfdCBvbGQpCiAgICAgb2xkX2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBvbGQpOwog
ICAgIG5ld19hc2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgbmV3KTsKICAgICBpZiAobmV3
X2FzaWQgIT0gb2xkX2FzaWQpIHsKLSAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYp
OwotICAgICAgICB0bGJfZmx1c2goY3MpOworICAgICAgICBoZXhfbW11X2FzaWRfY2hhbmdlKGVu
dik7CiAgICAgfQogCiAgICAgLyogU2VlIGlmIHRoZSBpbnRlcnJ1cHRzIGhhdmUgYmVlbiBlbmFi
bGVkIG9yIHdlIGhhdmUgZXhpdGVkIEVYIG1vZGUgKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2hleF9tbXUuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCAyZTBlNGFiNzA1
Yi4uOWEwZTI5YWUyMTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKQEAgLTczLDExICs3MywxMiBAQCB2b2lkIGhleF9t
bXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgIHRsYl9mbHVzaChjcyk7CiB9CiAKLXZv
aWQgaGV4X21tdV9tb2RlX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3ZvaWQgaGV4X21t
dV9hc2lkX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBxZW11X2xvZ19tYXNr
KENQVV9MT0dfTU1VLCAiSGV4YWdvbiBtb2RlIGNoYW5nZSFcbiIpOwogICAgIENQVVN0YXRlICpj
cyA9IGVudl9jcHUoZW52KTsKLSAgICB0bGJfZmx1c2goY3MpOworCisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX01NVSwgIkhleGFnb24gQVNJRCBjaGFuZ2UhXG4iKTsKKyAgICB0bGJfZmx1c2hf
YnlfbW11aWR4KGNzLCBNTVVfSURYX0FMTCk7CiB9CiAKIGJvb2wgaGV4X3RsYl9maW5kX21hdGNo
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwKLS0gCjIuMzQuMQoK

