Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133ECC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3gg-00080O-GL; Mon, 29 Jun 2026 00:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dY-0002tE-ON
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dV-0001Bo-JS
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NJk51780971
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=; b=nEDCzqGciSd+9388
 vYW5H/Is7N6cSb5Nz57OYPkTUwDClEBoijtZPBz5x+eAVOSCMClIN44juKqSqqWz
 c1NZiuORq2BwTUyY8fpHKAFmXUo7c47Qni7DcPT0ShErcbwooDyGgysAMdasKydH
 t4BaRqh9TpkqTxvmeiXRm7UVyzFJOFnQHlcAd0EjjTFwPhzhse/ElZusyNMweKUq
 G/GidoB19XUITSQXu7+meWrHLj+Bw+oagWgz6nW/X5PCXgZ9KAPaTAqwoTBdKb1q
 9/UjTU3EN0YC9LjcwCv+oFZSrQDmkb79Zsjx34RmFlvVQjIOWrEik/1pnBK7SQlG
 1rgiJg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74gjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30e773699d6so1557201eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707409; x=1783312209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=KdOnBOMQj9TFyFnvQNEtwcjebbbPL3Yoki2OKpJpxBQE0tl12js84YKEHE81QMM5Ut
 cV2eVhvJZRdIOkLFbjtSwV0txNiUmr/gcduKn/WlqrUKCl28uTvlbt7pEtH+rJ9r1KWw
 JlGir69K+V1mvAuV6FWDYXHdQbU2unQeAsCDda+kiK4YccXaE68CxLyY0+R6kPUGhise
 jqhkrSBbIW0Sv9WDabG0tSDWcM42nXozF7aHicYFtgxHztHwOTSqv22D3roVJpCCqMtj
 G6OHNEzOmpKKD5MaVuTV/bYlKEwKnHFRE5MMZDKOqbjqm88e9vNodWGeySPuBAyXzBs+
 s7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707409; x=1783312209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=FYwNy3+1bdw+EGkzwlpq9D7oQvuusUi65xQL3r6GOnG8aeQ/Wc0Y6uprfD1kGRXRNg
 Jh6LlJ/Ods6pd+4LrAS34xbGbdfEpqu7oOSAgw6yIJPchmBvCZHIgeiSxkrvFbAHV4ng
 LSUJxE5E0YVyfVH+rbvJeZeX/6INm2zlRy4SESAY4TgJlE5nTFB4YZhqmYLz491eHWzk
 6eOdE5tyIqtvqW5o562iZ9rJJoe+/cyQMBz5FpqckZx6Y3F9zMekn0stnZDokF1oyZDh
 WKfRBaZa5xf+6zLi4x8OxqcYcmoTdYP3LfKGQdHpsVIDhOK5frRsdIhWBVnN4h5sTWXR
 fZrw==
X-Gm-Message-State: AOJu0YxkN1hofCxpeX3rY92NEbsJSY50nk0Sp5uBb4/UqU/niVNT6PFd
 Ik7Bk5HWEbLhpC5Fgp+S1qhSMLq1E2YHLT7yK0rr8VjD13hfN+aBb9fkRSfl/Vqgt/dL54uRYb7
 kibCCpChH9ZxA55Lt/Sk2fg6QKuRk544h7cCXI71J4bpXlks2BVkWfUkznBTbCjot/A==
X-Gm-Gg: AfdE7cm9d8kzlmJOXR2b8Rsa2T85rYp2Qkk/WPUesaGRBWjHAXctbusJpHaQyPZTTBQ
 mbDhKxR+LFteqlu4Nm9MJwZ0igh85ulJ3SopsPIdqPRv3L9uNViXpaGjLcCAtwIzQXwlxqam9Qa
 fOTE1oVXhxre1Nc/eJ5hp0VZnCTFJolibzHoXps6AktvJ3C16lYK31O5REXDeURRmo3YH1x54ay
 iiU+C8s7wXUTzCpc0dlHDDYy0jiE44xaNfRTs7butfu8k1/3bUpqIgtVUgAgmZm+/dHt9WHHUS6
 fNEqlwlxoDnD6I/tIl78bo6NXWnKaOn+7CjUqzh30XD0iNDay7CU2b9mcRMA4M9N6O+cDrLsj4W
 uLCIhOpJtuspPpRluljzNV8G+27hPQw8B+1xVOOmAlnmOJWVfoXyKfMJa+00=
X-Received: by 2002:a05:7300:2312:b0:30c:efc:c399 with SMTP id
 5a478bee46e88-30c8502724fmr14823694eec.35.1782707408704; 
 Sun, 28 Jun 2026 21:30:08 -0700 (PDT)
X-Received: by 2002:a05:7300:2312:b0:30c:efc:c399 with SMTP id
 5a478bee46e88-30c8502724fmr14823671eec.35.1782707408221; 
 Sun, 28 Jun 2026 21:30:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 62/77] target/hexagon: Add implicit sysreg writes
Date: Sun, 28 Jun 2026 20:58:15 -0700
Message-Id: <20260629035830.1520296-63-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX0J9hNzTLGh5h
 k0Uqd4UWxjqU/lPXCi+vR0C+/74ePClPB8pSYwsUVakIm1NACu/ei62U+mJaheqJm4QUmVDJxmY
 stmihXr3U5BjL+OUK3fj3Gd47z5fmtA=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41f4d1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1iMjrSofymDeOXYmkJ3TKTpTHuK18Iq7
X-Proofpoint-ORIG-GUID: 1iMjrSofymDeOXYmkJ3TKTpTHuK18Iq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX/nie1/oJhy3C
 EicpUlQ5z/BedSHOfzKAIquVNaIT6dyYK4bku5n5ZpvRDaxx/o87RaUUXgAgAGy6Kzv0YzcIJkw
 5hq4txDqL1XihnrKSBy/rWvsliD5mr70NU6reXbtRKQ0nCHkakc9amrWTvaBpNzO9/KC2FSiRBn
 3lc6aN2AquX6GnRpZMjOQDtrqsug9vPlMvJBB14h7j9Bfg+hIobuz/wU6+uuxLLftqgl+0mSrq5
 o/27gXtP2btaAJKId6FBORvGkOxhJOV+jRuY+AcU2FRM6K4OkaFsyxLwMEEGo7O5tjwYQpYULtw
 uBQKTHgm/2ivXs/IkENfjqfrHUUGCmtoFHeGSr3JWa4Q5JSr2x2e+SGbGTooI6isx+s9BT8lfaZ
 It/Q3jAINBYeKk8BYrqyf1Bu68IPnjPcTJg1hDWg1D8YSlPS6oZwYYJwAbZVthbhKb8QIfOxLGu
 zanTa8NWXjKu+UEgUpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0YTM1Mzk1OGZmLi5mNTQ1MGNlZDdkZSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNCw2ICs0MjQsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDM2LDYgKzQ0NiwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

