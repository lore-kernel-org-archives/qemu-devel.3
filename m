Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F2FCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4qw-0007LP-G3; Wed, 14 Oct 2026 15:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH4qk-0007EA-1g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:41:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH4qh-0001XM-MF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:41:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJsQ152402
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OhekwcziehrPI7i2xiNTtyBVLCqBl5M6SAweFoLXErs=; b=lE1eXFR9WrBFp3yB
 y741rUu3kWYK5FVydP8kCaPvbuKPMuefnHfTYMJog+RCHod8bJ4EpEllbbqLl4g8
 jHB8iwuFXhXt0TRmrzBHqT98z61MUUmeIb9uFf4io5t7zzPlaMaA44vMaMQWZ1Fa
 zYnAk0ubm/2OyYxCITfZspnYI2HC5kdhvkoTD7E7ZfjRzc9jAy0fC4KzZ8kxeWcn
 dE2hNGDhlG4fnNnoFP5bKqpoP7mZ3/KIZM4b2pOGy43HDV8CnzN0gb+4k+97wL0+
 8RMVx9S+EJ41ZugrbYivcfsoVgPzpdc83EcqW/EaxomjvkHBW/g67LeJGoGMEB62
 09MWTA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aejc4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:41:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so9200354eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006874; x=1792611674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OhekwcziehrPI7i2xiNTtyBVLCqBl5M6SAweFoLXErs=;
 b=DywVWHV8GCI5ccJOIkm5gZek+pSb8trqjCzXiWLV1RYzPr/E47/60Yd9Gd5jOolnif
 JB/qXzUY/TyZImZa8Ouhtf3fEMEelhPXnjRRLbAeux+49RjiMrco2b5sDo9qe7yCKClL
 MaX+3i0fhqmgrHz8n5Npmr4fQp2VEpxPOKyHHx+pXlHUiQfJ+H0v3PrxmMS518EBl0bR
 S2SW1yjOElRyoekSt0HSmtnm5ksFOEQ1VDCH/+Tldm1BJM7aeFg/HlTgzL+yWBlzF1x2
 VVEtZPhNq9xUyfBa4gdum15u6c0sacic1n/zxJH+AcIPHE/ZLsTKjJnXirx7i4SSYfwz
 hq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006874; x=1792611674;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhekwcziehrPI7i2xiNTtyBVLCqBl5M6SAweFoLXErs=;
 b=mER0WgJLro952aM2emEt4ssqprjlG5p1aXcQduNW7hPuEpEvulBuIcOyCeI0gI8UnU
 QD3b34w0Lsy96E2otrsHrKkRQZn1o6jJKxYlaFfQxDbAI05abnKLCdhyDipnTz1yE0qz
 22u98rfu/Q0eAqH736M+Covoakwj2HMGqLJkHao/99KVsRixZNl/GrHYTG6gtklv6NWq
 ilUGisLLCoIVfXqYw8scAVqFY+PyihnCAKTVovqsppOApWF3tM6JYbnQFn+BYrjjeEcA
 RIGnN944JuKp6u01RKYYORqTJjqCQiAahrARMM6+8YTJdzNvCQXv3OSUafRKYpUtfMjF
 G9TQ==
X-Gm-Message-State: AFq9FYI1/3LlpfKU2czGDEx0eseUGljNMDIz7PhAMdjZfn2Z0jkM/34N
 Qfg/5gxDhhchEeiiWvB0mfFZ59hoJzSgjnsyYkGdPwSIzxcRMDc4m2rWcdNEsu21CpzzmEu8EAR
 sZTABTD4xKbvFOhjYT37wdeSUzUKIRaYvaWj0mjpuTyOyQ8fcW00oSnH/Bbux9x/eEA==
X-Gm-Gg: AYBFou3UMatG5prZzlfeE3uHGnayRNeGOO5wlxAgL/Qc8rXjcoLLeERg75mtDeruv7S
 3C2I2tG7LG9ZSM6VMggg2njUUkYOoNj3jqpExUinFnI1/oFdMYTpsyLeVTD+ZFE2k22Pep4cRjG
 l9I2hoYmjV3RI3JRRJq3Y0GG5EeVQLmTwr40W516ZcI5UgFX9QpiC0lUcDCXD+jBrcoq38/yw5V
 37b217A0fwvJ78/6XFKqmdnkGlk+NcmWj2zJWCT4hbnE25INXJ6Fqz8VhG+ir2Vq0sVHWZFuBKJ
 KIW3PWjg1q5y4D5TZqA47pB9ySAg1mIPGtA1JsztJKIzuV6qiTWhx8zRAHMBq6Wjmqp+4jatU7C
 Q+QQ3+DALHURvk1EB1ZqBv4Os/G6mz8pcDLPxod6tDhyeROmR
X-Received: by 2002:a05:693c:66c1:20b0:351:1b85:e139 with SMTP id
 5a478bee46e88-3537e0cefcdmr23508420eec.23.1792006873854; 
 Wed, 14 Oct 2026 12:41:13 -0700 (PDT)
X-Received: by 2002:a05:693c:66c1:20b0:351:1b85:e139 with SMTP id
 5a478bee46e88-3537e0cefcdmr23508396eec.23.1792006873337; 
 Wed, 14 Oct 2026 12:41:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm57393658eec.26.2026.10.14.12.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:41:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 4/4] exec: correct translator_io_start documentation
Date: Wed, 14 Oct 2026 12:41:06 -0700
Message-Id: <20261014194106.3205338-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014194106.3205338-1-brian.cain@oss.qualcomm.com>
References: <20261014194106.3205338-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: x3tJiQiBLe5JNeFAyh4yosk_LZaY47Ny
X-Proofpoint-GUID: x3tJiQiBLe5JNeFAyh4yosk_LZaY47Ny
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXzIMAGiUZDtWW
 sNh5WiSfJWBb9dLFXNFuk5FVMcqBin9ySRVdV0rjZTxkY03Do9nyVONVk90fHWvjxdZuBk767TY
 HA96MlSbU4xqv6HsVGaSeDVKZR1wUDQ=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfdada cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=g8hvdXb3kVhzYHBvyzQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX0Dw0EGZuMiy9
 LB5bBFFyVE0+YG//UFIGvxSdFxE/SEwYh5RSUi15As60rMn/y285XqYnaaTr4usZRxFrhxQcvGx
 EYPsh9G9crBf8K+NAt8jygNJC1L7M9MwrYMpMe3dcu0buy5O0kfvHRY+2Fmi/+gjCxtr5VsUvxk
 iewqi+7ZmOqBpp5zM5lU8/atThCZs/yy4z6bJO327nruAHGtK/pZTpvFWUTSQzCEtnz/okbfL2M
 UKMrgZFCxan+jRKHF72PdqUv+SMuZ9kVHqcxzL5+Po8dEJJmRxLuUa6nXp2pjQsh0JUXfvarXOZ
 hzHhnCa6XidlDyxGT6pyTL/6s/gZ3n+j01pxbBdijV4Ca0uqaS6xzhFX9aqKHBR9D1OBD4uBNra
 gDrEilVVc9bcUWWD99GnWyUf/Q1iwf/s6GzVLu8SiMMnFc1ZVKl3amRFxCOpkomwBQ6GnjMC4Cd
 AdLEg8Ff5WUUOY0XUNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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
LS0KIGluY2x1ZGUvZXhlYy90cmFuc2xhdG9yLmggfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhl
Yy90cmFuc2xhdG9yLmggYi9pbmNsdWRlL2V4ZWMvdHJhbnNsYXRvci5oCmluZGV4IDEwNGU2ZDRm
MzYxLi40ZTZlNDI0ZTdjZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9leGVjL3RyYW5zbGF0b3IuaAor
KysgYi9pbmNsdWRlL2V4ZWMvdHJhbnNsYXRvci5oCkBAIC0xNjgsOSArMTY4LDggQEAgYm9vbCB0
cmFuc2xhdG9yX3VzZV9nb3RvX3RiKERpc2FzQ29udGV4dEJhc2UgKmRiLCB2YWRkciBkZXN0KTsK
ICAqIHRyYW5zbGF0b3JfaW9fc3RhcnQKICAqIEBkYjogRGlzYXNzZW1ibHkgY29udGV4dAogICoK
LSAqIElmIGljb3VudCBpcyBlbmFibGVkLCBzZXQgY3B1LT5jYW5fZG9faW8sIGFkanVzdCBkYi0+
aXNfam1wIHRvCi0gKiBESVNBU19UT09fTUFOWSBpZiBpdCBpcyBzdGlsbCBESVNBU19ORVhULCBh
bmQgcmV0dXJuIHRydWUuCi0gKiBPdGhlcndpc2UgcmV0dXJuIGZhbHNlLgorICogQWRqdXN0IGRi
LT5pc19qbXAgdG8gRElTQVNfVE9PX01BTlkgaWYgaXQgaXMgc3RpbGwgRElTQVNfTkVYVCBhbmQg
cmV0dXJuCisgKiB0cnVlLiAgVGhlIGluc3RydWN0aW9uIHdpbGwgdGhlbiBiZSB0aGUgbGFzdCBp
bnN0cnVjdGlvbiBpbiB0aGUgVEIuCiAgKi8KIGJvb2wgdHJhbnNsYXRvcl9pb19zdGFydChEaXNh
c0NvbnRleHRCYXNlICpkYik7CiAKLS0gCjIuMzQuMQoK

