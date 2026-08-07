Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F2C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPO-0000kX-Lm; Fri, 07 Aug 2026 11:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPN-0000jk-J2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPM-0006j6-0z
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677DeDPp1434692
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FLXr4jKptCw9JudIGFNgD3FXGaZMdW/1soL9LsSg2Tg=; b=pF/UZcJKSTIN+xKV
 YmKTcPhHlaataCNjJJO5ZGPzkfi2uyRq155aggetiZbHGTKSH4P63tAVeC5Ap5+h
 pGD8FxiAcHi5qbZ6J3cBvQcgNFEgjMrutOfGahoWeY94wy5Ph0/Bq7pdkACGQIEc
 +W+WF+NecashN3NCiMHEhjRJR01RqWGSolmTjUQYmOWVqMDnb+9PP5ZpazAhYXdP
 3IWnW/GvtIsETVmklYnlArPkVdbIVymjSkXWG/mYuGNLfAHhH1HG5ETWjY6EZJYX
 FFnA8Vz7rpzcqLh92phb7GYo1jOGP7/AirYmfEm1J2LXKMQnM+aSAlIPOkmrVz6w
 w/+Abw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgewge63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so5079220a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116170; x=1786720970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FLXr4jKptCw9JudIGFNgD3FXGaZMdW/1soL9LsSg2Tg=;
 b=jg+r1JgNIXNYBFg6J5/VhI8nlHXX0NlUbVA0LcPQnVBE+uZdg2UT5kr6xTeQVnXjtl
 6OVG82L5KEkY5NRnVQrM5cKbhd8XGrPK7CunZl4WuzWP/wzWr2f2wSVv2nLzPv5ieZKk
 vZ2XiPFJP8FMjZ8Ro4s7POkZDLAkVL3xs1tHHby38NwkKqhcW1hrjprPbg/Kn25uiOdM
 xPfoROJvUAbXxrtNFkdZkDB1Knbt2+PK33wQXLacTILVehQvdvnaMApgEDtJ2DjmkSNK
 YWre5MKbVpJtaZkyxxVSvH8KkVE88LjN8bmvvxFkzvCpxEniXIQQLrEHcTCckCzI6qu6
 Z/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116170; x=1786720970;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLXr4jKptCw9JudIGFNgD3FXGaZMdW/1soL9LsSg2Tg=;
 b=HVAoqjKFkjGSJeZvu9W+OHkbqzUd/dqaLBKvxY3GEDA3pxItUMs0eeZIdwowdPVS2F
 kIcRMdc9Ex1FwIDlbZhoXG1KGpVuCd3x0BlO4qlt6vpYG74EmOCbF39fjDlbAtQdx28j
 3152gIWiFIw3AqBELyD1ZZhpeIm6YCiOFYYHUeOKU1ERp4Nq02RS63OTzJ3pB1sQTMar
 k1YYKepn7LoJHlcFXirHqL23bv8fvk3q7JOt5nON61T+G3M9vCqPaNbrtVm9A8p0jJ6t
 A85hlv9/+lYfzaDqj0v3eNjpWhd7kc8ga2Daffv6ZD8THC7bJWBYFn4tyDPE7ZvFW3XK
 doiA==
X-Gm-Message-State: AOJu0YyPhgvIH25g50mMj0BqWeFIenXDWT1WaBK/dPLfVCbInEMnr+BE
 T8om/Vns/KDheca1ql2jb00Vka+FaSCdUIS7g4iV3gMX4n1jMi/S/j1Fyut+pAoFtaRRFqcggID
 y97RhMS2xUJgzScVQuamo2/rPWJCHF9xV29f8WYLikhSZrRkccD9Z/anu74Kb+fV5GA==
X-Gm-Gg: AR+sD13+RFOKYxBC0I443dsDoUT3t0a2tQfDKb7W3zFT/uOYpF/HfqlU7mccyLCnS8o
 3UFv4Jyz2gWygpbFlcvZjxS/0Mp92lkqTbi5Ig+AQsSL6Yfa+CxvQJD9nYFxa2COMsca3b3zfZ/
 xTKALYNSCNlUhir/VbwgDuKacq2ECsaCLaxQxNpRWsX6uevsnRGGZENKvoLOI0gmpIenhZaxG6K
 x+qZjoq9xt7i4xtOZEdzfOyHYfvT+KbQ1Gmelx0Wsx+G8LcEpd64fL7GgeqaWBbV8V3smf/ZTz2
 FI0csQDlEVaqXuAUJqY3w9it4MHpSRTZ1l7ZuN1xXKpJWsj6aJtqdUlLC+ivYweF0K2bft/IKvd
 ybmRG5MUMi7cvkUSY3RuKKMV82wK8Mlxj8t3hMFtCxUkYczJ3
X-Received: by 2002:a17:90b:4c84:b0:381:c500:b0d1 with SMTP id
 98e67ed59e1d1-39282554a40mr423184a91.20.1786116169928; 
 Fri, 07 Aug 2026 08:22:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4c84:b0:381:c500:b0d1 with SMTP id
 98e67ed59e1d1-39282554a40mr423143a91.20.1786116169378; 
 Fri, 07 Aug 2026 08:22:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 5/7] target/hexagon: add GVec overrides for HVX vector
 average
Date: Fri,  7 Aug 2026 08:22:39 -0700
Message-Id: <20260807152241.1576334-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX3eTS5LkrO+w8
 TPhOdWa3EWf+03e2yJNEfMhccrTmPECabM/IfsLLHt2GiyWH/xpWwQCHexwjR/1q7Jx2JWkGJd0
 m0hPqMBq5iXuC0a7gMVqaQ9EOGItpOU=
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a75f84b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=5fOnMlAeMDB701wdRugA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: PsyriCkUM9DSvGvT9_ajD1j-2TzT9hbI
X-Proofpoint-ORIG-GUID: PsyriCkUM9DSvGvT9_ajD1j-2TzT9hbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX/P5nWJ6SOOIu
 tZ/hE8n8xNxiz9z15OpRsZxyWaUEfXSmAWfQEvyr50QJV698KqvvpPZvqIQy9xMhx7G4bN8Y7fQ
 U5amVwc42jz6tq0PiwW4dtX8S53vKAQ9yUzkngohYMRJqK4UaY5HPu02zHgljvsvG4Md+6iV/7z
 aPnFA42pCo++HBlNZWtAoS0z/BRCVFn33J4+69z6OoJ+p0v8LF1awjhCe23xQ0eRFAWkREhn5yQ
 RN3mDhapmgboYpnpq3RSJ4ivrk6NoCk7+ry9G3tc97JFaBsVKfQ8R8q5M9+UcMaiFg7n6bQ4EEN
 vM1iDhAXbQHuQjuoBNLOuJ5x/UWS3QjheaVEZflcQSChNsQrhvUgWWTMzjhFzgxYWVwZKJq0Mth
 7vd0/j4DQhNCGzgN04q8DkEheDE9mU75H8XhL/dAwIIQgCvV+de0wO1x5RlG0GRH+9uSY7i61n+
 hpZgOvEs1VoDc8UOMtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070119
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgNjIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnX2h2eC5oCmluZGV4IGNiZjg0YThjYWVlLi4yYTM0MmNkZWU2OSAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNn
X2h2eC5oCkBAIC0zNDIsNiArMzQyLDY4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhp
c3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgIGdlbl9ndmVjX3NhYnNkaWZmKE1PXzMyLCBW
ZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCiAgICAgICAgICAgICAgICAgICAgICBWRUNUT1Jf
U0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQogCisjZGVmaW5lIGZHRU5fVENHX1ZFQ19BVkco
VkVDRSwgU0hJRlRfRk4pIFwKKyAgICBkbyB7IFwKKyAgICAgICAgaW50cHRyX3QgdG1wb2ZmID0g
b2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB2dG1wKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNf
YW5kKE1PXzY0LCB0bXBvZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgICAgICB0
Y2dfZ2VuX2d2ZWNfeG9yKE1PXzY0LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAg
ICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7
IFwKKyAgICAgICAgU0hJRlRfRk4oVkVDRSwgVmRWX29mZiwgVmRWX29mZiwgMSwgXAorICAgICAg
ICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgICAg
ICB0Y2dfZ2VuX2d2ZWNfYWRkKFZFQ0UsIFZkVl9vZmYsIHRtcG9mZiwgVmRWX29mZiwgXAorICAg
ICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUp
OyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YXZndWIoU0hPUlRD
T0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWRyhNT184LCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKwor
I2RlZmluZSBmR0VOX1RDR19WNl92YXZndWgoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVD
X0FWRyhNT18xNiwgdGNnX2dlbl9ndmVjX3NocmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2
Z3V3KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fMzIsIHRjZ19nZW5fZ3Zl
Y19zaHJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhdmdiKFNIT1JUQ09ERSkgXAorICAgIGZH
RU5fVENHX1ZFQ19BVkcoTU9fOCwgdGNnX2dlbl9ndmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9U
Q0dfVjZfdmF2Z2goU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWRyhNT18xNiwgdGNn
X2dlbl9ndmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3coU0hPUlRDT0RFKSBc
CisgICAgZkdFTl9UQ0dfVkVDX0FWRyhNT18zMiwgdGNnX2dlbl9ndmVjX3NhcmkpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVkVDX0FWR1JORChWRUNFLCBTSElGVF9GTikgXAorICAgIGRvIHsgXAorICAg
ICAgICBpbnRwdHJfdCB0bXBvZmYgPSBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZ0bXApOyBc
CisgICAgICAgIHRjZ19nZW5fZ3ZlY19vcihNT182NCwgdG1wb2ZmLCBWdVZfb2ZmLCBWdlZfb2Zm
LCBcCisgICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0la
RV9CWVRFKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfeG9yKE1PXzY0LCBWZFZfb2ZmLCBWdVZf
b2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllU
RSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgU0hJRlRfRk4oVkVDRSwgVmRWX29mZiwg
VmRWX29mZiwgMSwgXAorICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1Jf
U0laRV9CWVRFKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfc3ViKFZFQ0UsIFZkVl9vZmYsIHRt
cG9mZiwgVmRWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZ
VEUsIFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBmR0VO
X1RDR19WNl92YXZndWJybmQoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWR1JORChN
T184LCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YXZndWhybmQo
U0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWR1JORChNT18xNiwgdGNnX2dlbl9ndmVj
X3NocmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3V3cm5kKFNIT1JUQ09ERSkgXAorICAg
IGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zaHJpKQorCisjZGVmaW5l
IGZHRU5fVENHX1Y2X3Zhdmdicm5kKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdS
TkQoTU9fOCwgdGNnX2dlbl9ndmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z2hy
bmQoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfVkVDX0FWR1JORChNT18xNiwgdGNnX2dlbl9n
dmVjX3NhcmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3dybmQoU0hPUlRDT0RFKSBcCisg
ICAgZkdFTl9UQ0dfVkVDX0FWR1JORChNT18zMiwgdGNnX2dlbl9ndmVjX3NhcmkpCisKIC8qIFZl
Y3RvciBzaGlmdCByaWdodCAtIHZhcmlvdXMgZm9ybXMgKi8KICNkZWZpbmUgZkdFTl9UQ0dfVjZf
dmFzcmgoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCi0tIAoyLjM0LjEKCg==

