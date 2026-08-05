Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A608AC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrerB-0005uK-Tk; Wed, 05 Aug 2026 12:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer4-0005se-WC
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer3-00035B-ML
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FV8Ji3082854
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GKMvAhaQ/j+yWyT2ELEVQBI+b2PeJr41qXA9G2/sLVo=; b=e//BApmHJ3exwOv0
 6EO0cBcI3r7hwhkrb7rhsriCn/sEgkDdehAS30mo8nBxN0Ghldmt3O6M/JonJrf2
 E8anm9q3THOhFLcbvsefDfnoEe1PrE/fnk859WGQTEKYWlV1bvqo/kzicHuwN2Hc
 OfeCywRc4gq1ze0oSrV/+MPU9r3Dk9427a1+Bxzb6XH53vGQ/yyfn9FrYhP/8+ha
 EcckyAaU8aDVR5QkzY162Ix1psD6RHbb42vFgne9oiBMWQFWCVbC9iqR+xoz8Axt
 NdJ6zYJKf56CadHNyxh7wAd0bDWYBUVseDxoh2/ZMhZ386aLY9bfIWGWUu9wT64n
 mWkPyg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x9s3t5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so1054533a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948752; x=1786553552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GKMvAhaQ/j+yWyT2ELEVQBI+b2PeJr41qXA9G2/sLVo=;
 b=PqZsL1jGGtyrzz6W2Cryd4Se2BW9hwLYohJ8kLOWQxMRDPy8vAmakTZ92DbI0GOxHl
 c/KfzJtdXPXcpG/aH4v73+CdGFksVs9+WR2MukY1eGC7JaLPN/MssiO9KMx4hZx6BrO/
 9T78/O9yHwq4h/TdrF7J7g42yyBuv2s8xBGxCoQEXHf1PlKh0kjCbqwt4IjSzlMKSWiF
 1ebPBSkMA6OFxXb5dloPPS7lMIUmlaq55JbYqSf6rlZnCuLMrvW2/AGkd1/Q6iQyq/oe
 rqJSZBbczL7+cCufZ1ZwUmzofxoFYHBPucbjp6MpClFjSjwNXqQkBv5VXfeIdbfFea03
 WXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948752; x=1786553552;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GKMvAhaQ/j+yWyT2ELEVQBI+b2PeJr41qXA9G2/sLVo=;
 b=KTY4liGp0aQBdTyhADw9Rc1P0RKcFENsHkRJJ4HK5Wm0JfksEK/+eH1jtITG7+j+oN
 cHw9MCsWWoYpoW9gPNqFExzwWNMHDNgXMhqpkCwuGj/jAGSMdnyNr0YGiay81q+nz864
 NefPFa81APiJmAbOBV+DzlJSulwFj+kTRtfL+dd1DUl7UlVeq6qYkaU5VkCrgco+7qPH
 GzmnWLOtNQYLyBrYoZpJOqXXo/IV/bVYnWEAu3fYOgP9c5M5uDwZRY78bWM4NA7JoSjn
 /RTVV56WPIuPdHFVogv4+sS0BIAYaHN2Lq8RAw8pQEZtlU6N7oOWuOLN9t8LIZ0dJBs8
 jPCg==
X-Gm-Message-State: AOJu0Yyln4VeP65JAGujlJcJrgumn9ZDnQXSMiTMiCTq7QSJOa/gJjDr
 xT+zX6TakoSDQO4BExYRWIYXKyCQ1Umgv+A2YFW8aBGi1fmiFQJ+DRD/zWHp4n35GxmmmTEiKxT
 pawCnG9DJq2dFnKxonlohSrLOMs4m17E0+pIniwGIOIxTFJ5us+MdTYfulhbB6wZfhQ==
X-Gm-Gg: AR+sD1276IEnO59Qk1zWnXZEco3ocymfVvmmACuwKHq6F+xbMC7e9YN48uIIVuivIXH
 6AlvbZznRwow9mg4ahPYcEdD9F9ppm1jgJ6zusOJYraImFuuN/Km2E1mVdsIRilpK2BZirWFlTi
 BTTl9k4s3QdpvLtjAK3XMR9M53tceia/qxoW7CsE7u1b+aGNgTABfmQOevlrQGXANHNrAMLwXri
 6aIDbG7w/2hlQLOw8Wj0v5scAU3QJXQ0xQM6J8p4Xo/EXD0zMGBnH0pn/an0Jjmnp8kYr9kcAdw
 7dnoNl9hsUc2+l+5NojJUf+kZRSxHJH5XMILKxXdPQdHMc+dU/k7eSZ8ZPowHKbc0RH4uopWoUX
 OhSjZdDj55WuVR1pw8OfvjZQMXLQJ61WMQ49ylz8j8HU66W6F
X-Received: by 2002:a17:90b:4b87:b0:38e:85fb:71b9 with SMTP id
 98e67ed59e1d1-3903c538254mr7556524a91.4.1785948751698; 
 Wed, 05 Aug 2026 09:52:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4b87:b0:38e:85fb:71b9 with SMTP id
 98e67ed59e1d1-3903c538254mr7556477a91.4.1785948751276; 
 Wed, 05 Aug 2026 09:52:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 3/6] target/hexagon: add GVec override for HVX vmpyih multiply
Date: Wed,  5 Aug 2026 09:52:22 -0700
Message-Id: <20260805165225.3117924-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX+0blbmA6H/3u
 O6t06on50npOXr7WE2jSQHjWfPbSuI+08w6zDCB3hDTBPW/z4Quc0QzchSddVfuBpZmRKTjCHYy
 4p/EtpBUSiljNOV5pgA4f3AvS3LefeeFyy8tLLyl63sLNxWIcOBzUes1RxERE1fUe1A/iJghYV2
 aN5HjtMSi4mb0Bo8JENrMMsXb7KzvuXS/utNN0NifnK75SbThDdgOV6xOLIh6T/OChf4/yXgYUW
 uEvHDPxtR5+OGLU60f+HfTHjoZjTM8R4QCJFZZKXAtERC2PooyDCQ873fPwapCCZO5yYHK6Dmgc
 PzhMu8tUmquACtdQpA0QCB13BdG0o1UzhRkiAZgqpTGUzAkdCxSxNoBU0KB8q0ygo5wRrTR4QAz
 EKVaJfrT3d+bDGsFW6UyeptGDJFFoHufMgQfOjSDHyJsMgpCW25kr6FxLfV6XdfkAKk2SR/Fu1/
 kklmJ4+6wUNes1LoIJg==
X-Proofpoint-ORIG-GUID: ZvZ0QFyD5WfMdXxUSdOSV7xOZ8xOHEOd
X-Authority-Analysis: v=2.4 cv=BMqDalQG c=1 sm=1 tr=0 ts=6a736a50 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=DKyBas4HSA1QlpYNAqsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: ZvZ0QFyD5WfMdXxUSdOSV7xOZ8xOHEOd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX3xzx/zY7SsLC
 iFik9JzHYTJGkQEli2a7lkcnlojppGZHFNaonx7SXKzhufGEIzTeIo7cdCAzu+SSrnZRNPW5cvn
 k2gnFSfoXh/D2MUJfYny8Eyo3xh/GeI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050138
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19o
dnguaCBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgKaW5kZXggNDNhMGYzNThmMDAuLmY4
NDNmZTRlMmUxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgKQEAgLTMyNyw2ICszMjcsMTEgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGFzc2VydF92aGlzdF90bXAoRGlzYXNDb250ZXh0ICpjdHgpCiAKICNkZWZp
bmUgZkdFTl9UQ0dfVjZfdnN1YnV3c2F0X2R2KFNIT1JUQ09ERSkgXAogICAgIGZHRU5fVENHX1BB
SVJfQUREU1VCKHVzc3ViLCBNT18zMiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKwor
I2RlZmluZSBmR0VOX1RDR19WNl92bXB5aWgoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVj
X211bChNT18xNiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAg
ICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKwogLyogVmVjdG9yIHNo
aWZ0IHJpZ2h0IC0gdmFyaW91cyBmb3JtcyAqLwogI2RlZmluZSBmR0VOX1RDR19WNl92YXNyaChT
SE9SVENPREUpIFwKICAgICBkbyB7IFwKLS0gCjIuMzQuMQoK

