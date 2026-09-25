Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB958C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9I-0004vW-At; Thu, 24 Sep 2026 21:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v95-0004u3-R1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v93-0005rL-Ve
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kulk3751918
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pTASH9Y7ulfhhYlb+7YPIiqsNG15WhLGkg45JN19xoI=; b=RMYUY5S0npoU+AwG
 ZK9NXb3/4KP+QuMMyRWWBUcxHiNjskcitZiZdWIqZHC4DdcHVqOxu17zfeELAQ1F
 OT4rXF+VBiDcL8XK1i2Cv0i4XwfJEa97oWeXdGokmLvmYznkmHdJiLlWSLX6zyCm
 3l77I7Wr3wrSSaHT4B/J4PwPVZxuOdrVfRxdlNG+hDy3dTrT0XJYOFL+ZmmkHobv
 MzcJqCd2ZTED+/dDCDGnzZwp6FE7WlUQu/pELxLSZ5B5v15V5IvbPYEFRKyIUl+8
 x/im9SiBBaMgPlScrmOQssxqZxmw6wU/YDAXZxA4w/e2iJUfYkJe7dKZ5GFaVyHy
 OPj0ww==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8tcme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1392032eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301275; x=1790906075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pTASH9Y7ulfhhYlb+7YPIiqsNG15WhLGkg45JN19xoI=;
 b=MziPdFlQitWF+AOrGW5tJQiFxLFngyKju3htLW7uykFqI/Qd8Hn1Ejez+RygXgHD68
 3gdr5i+za+buOxPD81LKQZkADBlCkWqjHEpZ4y54OyZgCVt/Uyp/kxPkN0xKy1H7m/Sk
 1ZFUcBf77Mz0HLCMVNdiAECPpJ8bOX0Ni30u+UhPX0sjMeI7LczUni82tLi1h9xwOzX1
 hclFK8I34PQFrbCcE+U7hP3oxHU7L4aTjNyruwPAF03Bx3iEjzSwNOhWxKx7KzX3dh7g
 YE4kYx44TGPnGT9sJkNzXAkGRc5sM4NayMOr0KTnUZvZjfj78LHB2uV15OsLm/BmhtA7
 FmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301275; x=1790906075;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pTASH9Y7ulfhhYlb+7YPIiqsNG15WhLGkg45JN19xoI=;
 b=OxUX0Bp/wR4HcS/tVz+v24UJ3IWlOqpvxjR+Oi01NawhvkuWxOZ6CDrbu76djnnG1z
 KTbmZ99IummcmKzFjER4b8O+26vvsWRGvJl8LQL+wZJ2Rmt2SUydDrrgL2lod7/3Lsa7
 wdpD63+ZsY1EPAkH94xiQzvEOCNQpA77oKy/wjzE6Dvp1Hy0LIuIzq1YEFwp+FRLjdqk
 vupbtGFHON3FNnTxztWvaM73ya1MdpX3A5PdsGRWhg3QfdcbwELsullL8+UfptAhFNYE
 LbJHVgYmrfzQ8EBTa4y5SdeXn1BkcyS6vjW1nvZg+sBDogvrWcyPCilZaY1zDnK0KkQs
 M3nw==
X-Gm-Message-State: AFuF++mJJFsjy5Bm0hrsklljgpTwCfbwUAh7APaMnGb7EdqtDkJ1T1XS
 ps9HGs5ZeGxNQvuZqyADopf+FV3jyr9nCwWDl/hCZtNbfGjCDbVGtBqI7Lp6Eo6b8ZclNiyuEoo
 1LM04Ml6iqlE/FkNuwx+tIZLoVQEPyIlh2xNFP8iarkFXt/H6VYw6SIvD/Lmx/nu5cA==
X-Gm-Gg: AYBFou0h7VPOrV1X7B96IO9AV85fqJWacMcJ3Ifxqvn0BLdGKgNvr54B7RuViFeg+mK
 OLwI2oKHRRNWWdrLjRF90AceMGfUVK1KRXoAdPOvAFwkMPi5Pc/LgaeXRPoJM9Rav1P50KMDjVO
 Xd8gLWAPZucrE0ygUCkPih35V7IfxfvXDIY8kHV68jwuxS7mTayK73/HZtOchy5+nC7AY7O15lP
 fXMDaPb5VeQDzbWkqVOMO5/ntSAMuaVkBUVXUhOXRrwJrDR1RfYTgX6ZPN5izPW0zfqHGx9kf1B
 uzSnoW4wMSVAbV2qlpGQDssFleV16sZS4BYHUzQ4+J3xIHcfJaUz6evXOvaFvCivMRnZo6XF8kR
 hqml+6BgFiTNNX7cCDckbreKh65k6dcqgOGnH33sL6LgEJ/o=
X-Received: by 2002:a05:7301:db83:b0:33e:84c3:a056 with SMTP id
 5a478bee46e88-3400210f6a9mr3536973eec.17.1790301274870; 
 Thu, 24 Sep 2026 18:54:34 -0700 (PDT)
X-Received: by 2002:a05:7301:db83:b0:33e:84c3:a056 with SMTP id
 5a478bee46e88-3400210f6a9mr3536957eec.17.1790301274347; 
 Thu, 24 Sep 2026 18:54:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 01/40] Hexagon (target/hexagon) Move code out of
 gen_start_packet
Date: Thu, 24 Sep 2026 18:53:50 -0700
Message-Id: <20260925015429.2579174-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXy+QH0ME9QQy3
 MsItTm4WG7qBZEYsoFQu2YGypV8iCIrSdOnpKNiQhFjOHWYdi0YvTdkpRcUoGC+Namc3vocR170
 kHb2ACc4YUUE7Vbg/HtOPhj/o832Ljg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX/CYGVD+RSi6c
 tjvTa9h9nSR5n6YlLU/5SDa7J3lRKgXvY44jWUhOBwtfXfN+QNFJERtIf4rBqYwBwwcfMklkTRS
 pT1fxiCgbO6T73FEnSSmE9HGo6DzFMvXZB4q7oFYWQHloAhXnPrPD2uiegoNtSomHaDVhiSdUYh
 otFNnpoQtZy+eXVURMsHmhef0H8EZ5lcytt0woWE8W1L+94NBt9ysKGaKt15BAOxqsm2aDMJDXs
 FXUaFSoEfx0N+SjXiBt0bmqbdDv7uNyAJ1YcC0V/WJwjCqbzAHAS+hhfho8l2Wak2hEIosd797K
 owowjCW+Le/cuE8K/Q5+eYovPSG8hJi5SCM16NFouvDcYSGxdPyCbclihfM+Ouj1ffNzb6emNqv
 zGcvjYMTKa4tp55Cjso5GCy2ik68IezfFiQorHNW57oLdJsStf+1aYkT53/+3gGdqR9fTy9UeEd
 LSWK1IddOI7K8zWhf/A==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab5d45c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=iHxc6FXaTQbeKTJfMfsA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: qUTC7loRKcOe1ZL0RMs_5sdhCiBGWUo4
X-Proofpoint-ORIG-GUID: qUTC7loRKcOe1ZL0RMs_5sdhCiBGWUo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCk1vdmUgY2xl
YXJfcGt0X2N0eCBhbmQgYW5hbHl6ZV9wYWNrZXQgb3V0IG9mIGdlbl9zdGFydF9wYWNrZXQKUHJl
Y3Vyc29yIHRvIGFkZGluZyBwYWNrZXQgdmFsaWRpdHkgY2hlY2tzIHRvIGFuYWx5emVfcGFja2V0
CgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpS
ZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4K
U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxOSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGZkMWRlODc0MDVjLi4yOWUwMmQ4Y2M5ZSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTU2NCwyOCArNTY0LDEzIEBAIHN0YXRpYyB2b2lkIG1hcmtfaW1w
bGljaXRfd3JpdGVzKERpc2FzQ29udGV4dCAqY3R4KQogICAgIG1hcmtfaW1wbGljaXRfcHJlZF93
cml0ZXMoY3R4KTsKIH0KIAotc3RhdGljIHZvaWQgYW5hbHl6ZV9wYWNrZXQoRGlzYXNDb250ZXh0
ICpjdHgpCi17Ci0gICAgY3R4LT5yZWFkX2FmdGVyX3dyaXRlID0gZmFsc2U7Ci0gICAgY3R4LT5o
YXNfaHZ4X292ZXJsYXAgPSBmYWxzZTsKLSAgICBmb3IgKGludCBpID0gMDsgaSA8IGN0eC0+cGt0
Lm51bV9pbnNuczsgaSsrKSB7Ci0gICAgICAgIEluc24gKmluc24gPSAmY3R4LT5wa3QuaW5zbltp
XTsKLSAgICAgICAgY3R4LT5pbnNuID0gaW5zbjsKLSAgICAgICAgaWYgKG9wY29kZV9hbmFseXpl
W2luc24tPm9wY29kZV0pIHsKLSAgICAgICAgICAgIG9wY29kZV9hbmFseXplW2luc24tPm9wY29k
ZV0oY3R4KTsKLSAgICAgICAgfQotICAgIH0KLQotICAgIGN0eC0+bmVlZF9jb21taXQgPSBuZWVk
X2NvbW1pdChjdHgpOwotfQotCi1zdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2FzQ29u
dGV4dCAqY3R4KQorLyogQ2xlYXIgb3V0IHRoZSBkaXNhc3NlbWJseSBjb250ZXh0ICovCitzdGF0
aWMgdm9pZCBjbGVhcl9wa3RfY3R4KERpc2FzQ29udGV4dCAqY3R4KQogewogICAgIFBhY2tldCAq
cGt0ID0gJmN0eC0+cGt0OwogICAgIHRhcmdldF91bG9uZyBuZXh0X1BDID0gY3R4LT5iYXNlLnBj
X25leHQgKyBwa3QtPmVuY29kX3BrdF9zaXplX2luX2J5dGVzOwogICAgIGludCBpOwogCi0gICAg
LyogQ2xlYXIgb3V0IHRoZSBkaXNhc3NlbWJseSBjb250ZXh0ICovCiAgICAgY3R4LT5uZXh0X1BD
ID0gbmV4dF9QQzsKICAgICBjdHgtPnJlZ19sb2dfaWR4ID0gMDsKICAgICBiaXRtYXBfemVybyhj
dHgtPnJlZ3Nfd3JpdHRlbiwgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKTsKQEAgLTYxOCw4ICs2MDMs
MjYgQEAgc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAg
ICBmb3IgKGkgPSAwOyBpIDwgTlVNX1BSRUdTOyBpKyspIHsKICAgICAgICAgY3R4LT5uZXdfcHJl
ZF92YWx1ZVtpXSA9IE5VTEw7CiAgICAgfQorfQogCi0gICAgYW5hbHl6ZV9wYWNrZXQoY3R4KTsK
K3N0YXRpYyB2b2lkIGFuYWx5emVfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQoreworICAgIGN0
eC0+cmVhZF9hZnRlcl93cml0ZSA9IGZhbHNlOworICAgIGN0eC0+aGFzX2h2eF9vdmVybGFwID0g
ZmFsc2U7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBjdHgtPnBrdC5udW1faW5zbnM7IGkrKykg
eworICAgICAgICBJbnNuICppbnNuID0gJmN0eC0+cGt0Lmluc25baV07CisgICAgICAgIGN0eC0+
aW5zbiA9IGluc247CisgICAgICAgIGlmIChvcGNvZGVfYW5hbHl6ZVtpbnNuLT5vcGNvZGVdKSB7
CisgICAgICAgICAgICBvcGNvZGVfYW5hbHl6ZVtpbnNuLT5vcGNvZGVdKGN0eCk7CisgICAgICAg
IH0KKyAgICB9CisKKyAgICBjdHgtPm5lZWRfY29tbWl0ID0gbmVlZF9jb21taXQoY3R4KTsKK30K
Kworc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKK3sKKyAg
ICBpbnQgaTsKIAogICAgIC8qCiAgICAgICogcHJlZ3Nfd3JpdHRlbiBpcyB1c2VkIGJvdGggaW4g
dGhlIGFuYWx5emUgcGhhc2UgYXMgd2VsbCBhcyB0aGUgY29kZQpAQCAtNjYxLDcgKzY2NCw3IEBA
IHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4
LT5wa3RfZW5kc190YiA9IHBrdF9lbmRzX3RiKCZjdHgtPnBrdCk7CiAgICAgY3R4LT5uZWVkX25l
eHRfcGMgPSBuZWVkX25leHRfUEMoY3R4KTsKICAgICBpZiAoY3R4LT5uZWVkX25leHRfcGMpIHsK
LSAgICAgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9uZXh0X1BDLCBuZXh0X1BDKTsKKyAgICAgICAg
dGNnX2dlbl9tb3ZpX3RsKGhleF9uZXh0X1BDLCBjdHgtPm5leHRfUEMpOwogICAgIH0KIAogICAg
IC8qIFByZWxvYWQgdGhlIHByZWRpY2F0ZWQgcmVnaXN0ZXJzIGludG8gZ2V0X3Jlc3VsdF9ncHIo
Y3R4LCBpKSAqLwpAQCAtMTIwMyw2ICsxMjA2LDEwIEBAIHN0YXRpYyB2b2lkIGRlY29kZV9hbmRf
dHJhbnNsYXRlX3BhY2tldChDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgp
CiAgICAgd29yZHNfcmVhZCA9IGRlY29kZV9wYWNrZXQoY3R4LCBud29yZHMsIHdvcmRzLCAmY3R4
LT5wa3QsIGZhbHNlKTsKICAgICBpZiAod29yZHNfcmVhZCA+IDApIHsKICAgICAgICAgY3R4LT5w
a3QucGMgPSBjdHgtPmJhc2UucGNfbmV4dDsKKworICAgICAgICBjbGVhcl9wa3RfY3R4KGN0eCk7
CisgICAgICAgIGFuYWx5emVfcGFja2V0KGN0eCk7CisKICAgICAgICAgaWYgKGN0eC0+cGt0LnBr
dF9oYXNfd3JpdGVfY29uZmxpY3QpIHsKICAgICAgICAgICAgIGdlbl9leGNlcHRpb25fZGVjb2Rl
X2ZhaWwoY3R4LCB3b3Jkc19yZWFkLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBIRVhfQ0FVU0VfUkVHX1dSSVRFX0NPTkZMSUNUKTsKLS0gCjIuMzQuMQoK

