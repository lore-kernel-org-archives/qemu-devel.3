Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C76ECD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY9i-00012K-JA; Thu, 11 Jun 2026 01:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8U-0007yd-9d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8R-0004wg-E4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GUEG3846365
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=g3dFm/mCos8tJ7E+m/8STbCKzomjS8d/qOag3MHkEjM=; b=hT
 QzWOQdfeUlmuwCvjGEulgwE0sfeW7pj4HPxhvHVhPZhPMx+K/KJRLy9LvO8TNOhF
 p04XzFdVUoAtOdlWimlmIPy4gkTKGHoi06EIyqmSFV+ML4mlxkuEQ0I8XuYxH9O2
 MJItUp9NMEpj1cc4J8yBW0vNTCMBWGj47JeSoqaWzGBZvK27CeJ7jPiTFHVp1A7B
 Oqm5O/9CmJSyE5X8/nd1aEae+mcuB6IWoYDkQcWzucD1+x343L7b8SZLoEUFe1JX
 W3s04qMaQkZFOOCXb3aic26MsU+sbeBCUjyutx5fOTfDFfXBAU4nNQO7de+C3m+c
 BOasw8tjA2i+OdG9t5Kg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1smf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3074d4102a9so6638722eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156361; x=1781761161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3dFm/mCos8tJ7E+m/8STbCKzomjS8d/qOag3MHkEjM=;
 b=KflDQq0DObyUlb/MPCUdCbVFpt8QheaEDzJrX3Y7rKCm0dMjy+kZsriigpaB8Zho45
 Cz3V9EZ0mKi/c6NLd5Fpp0jekofKsc7yJ/5f3NCm4QVJlb+hpp5gFKz+UWbREzzGnA+n
 jbDdrPq3JMKmKqI5MfE4GVX3VSxPabPvn3IhsfiG0WpbpKXh+bv3DdG6flK+JAw5BESh
 e7GCwfkPZLqWzfnes64QazS9BocFzrjRJRagQ2MUZAzrEizZRMVxEDIEFgFg1o727Plg
 wcPBZhun0DDN22m/5bJYCqtm6BItJLivNCv/tOdDjro6kNo4Ei2zQ+ZCMe1zzVO+rcM/
 /IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156361; x=1781761161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g3dFm/mCos8tJ7E+m/8STbCKzomjS8d/qOag3MHkEjM=;
 b=Cw8AmCO9wxKY62X8cvPCas8KliFvPxuaBltxU02QaC79+ekqP1XF2RZ4ueTqM9uvaD
 tPgAszSjd/T0WU9RYXK0r1lGxg9A4BMxghIJdoDqdjYscdqnA262LTuouXKGT6TuwbPK
 TDK5AmtOtROdnwgO6hk+nwfJlb57iaVULWeNDXmf4paYo0CE00bKLTSwotFYEI1tI4mJ
 hq9p0JcP8Z8kjNKaaEdOTb7Bzx7I6zXySUtEY8TQBm1Ve5XnDursqrHC5kBGQdvSwTpE
 thbgxR9/tmbP69ICVWggiufcpRD7lYvyEDcLLVGP5PooYUWk2xEcYAUtKFq68T3+bIjy
 JDnQ==
X-Gm-Message-State: AOJu0YxuBCRiVt9X+HF9/nlbevD2B9UM9rY7A8caMNPFpHqKEBzjykAD
 wNqs7IqoA8pRDjwT4v2xuZv7R8Gxj9Ads+7pHa99rPlvtKCbDnw65iLwXqXxSNz0yoldo8ya0+P
 un4C9nxAWR6ekry8B55pzFfXlxOXo/HxYdXC+qpEqdMfjg28cPLdRYwo2ZIL5FcAnrA==
X-Gm-Gg: Acq92OGAFCcerx2SqA0isTZ22Xap/3FXLaWC4NV0WKacPyE3kasSTloH9J1S84gGJtR
 iuERvLOYbWW7XVRx2FcLEwf0MAilNy/2mZICoLQfX1gZW/Xzij2mGI61hGkNr9e8kIhZrEeuxhc
 9PVyuMeBvW0YhqWtbShgM4n2vsVHph7LWe+sdDd8xGKk6gj6ysET2it77Y5Qh356OAEpG+Tzq3O
 +1OXcZAyMSWR8L4FkszefLaZuvP+Hohlr1Sfm09JOh0PLeGuDy4j7BVyOxHxrnlNcrx6douNDFT
 P46kYgVwxuOwnpYiOZGRFHw2jMXr0gZjJ7RCSsE9paYxHMO7jDGtGEiO5ybC+zhJA+cUlf0msOA
 76xVuEVMTlvARgsvBG/nXTPytTRFx2fuij50qiR1Vq3kIngTULOIrjkJaPCInOa6xrX0pDGF8d2
 UMtDci
X-Received: by 2002:a05:7300:fb94:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-30804a39a05mr1070935eec.24.1781156360917; 
 Wed, 10 Jun 2026 22:39:20 -0700 (PDT)
X-Received: by 2002:a05:7300:fb94:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-30804a39a05mr1070909eec.24.1781156360248; 
 Wed, 10 Jun 2026 22:39:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a9fesm735778eec.16.2026.06.10.22.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:39:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7] tests/qtest: Add hexagon boot-serial-test
Date: Wed, 10 Jun 2026 22:39:02 -0700
Message-Id: <20260611053902.3927367-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
References: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a2a4a0a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BD0QnzRTZ9sOGqrEtmGbBcXHEepQESBW
X-Proofpoint-GUID: BD0QnzRTZ9sOGqrEtmGbBcXHEepQESBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX+f2UVKdJ02mg
 jtcX4BgMV7IHjyxNmuZShzMQGwLqq9xUizYh7EDcLxwSEkLR6i9LMk1pCoixYwIikhHkxhrOuol
 CZ2KOdfOUuHs4x0xTPOUw706Dnsxv19ewfU4xwG1Q8wqF6MjDwTrJovc2o8iaEgMurRzZlCOR9r
 yFuoB2/CHyrX2TYL1/NM0mo9m/WJQ0HrgSW7oz0ERwalKf9r9YOV9X9w/WBvKifH7KGgmDvYMSk
 y5E+atl42gCw7Yv/ytOa1l0c+BoRTme10x1FfCEUKDRDNbrotKuTtPeimlyBpGMcYYhZo7n18z/
 O5UrgB9rRoGAmtLXv5vq8XcNJb6Qs5KHqAw9b9vR3WXRnpke+G1wnhIzAF24P9ryrcnPOBf3Ggw
 6o9kV4CtJmYk7owA5fUAf5z0AvAE/cz7AUUedswuyuvtWu687g5LnoVZ6RuBdbfqJpu8StDscLM
 OogebqvvCV2Lnd1grog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfXxU7xlBYChJSk
 X+uPUCvrspYvVbX0txvI0ZNbAxQCNBJKFMgSisbeMqzuD2oNm9DvXdg3e0E9gcZK0trxJQZAXZX
 zlDH/2SLXqLKzN/J0RSATDTsx06ibFg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110053
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsr
KysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5
YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQy
LDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7
CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4
MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFn
b25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyog
aW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAg
ICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAs
IDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAq
LworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4
MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7
CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwog
ICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAg
LTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAg
eyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5l
bF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAg
ICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292
ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hl
eGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApp
bmRleCA0NWVhNDk3ZmE1Zi4uZDNjOTUyMzZkNTAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTMsNiArMjkzLDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBjb25maWdfYWxs
X2RldmljZXMuaGFzX2tleSgnQ09ORklHX1JJU0NWX0lPTU1VJykgPwogICAgWydpb21tdS1yaXNj
di10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBbJ2Jvb3Qtc2VyaWFsLXRlc3QnXQor
CiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9zX3Rlc3Rfc3MuYWRkKAogICAnYWM5
Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

