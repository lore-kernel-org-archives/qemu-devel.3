Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0A9F433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTsC-00008t-0F; Thu, 16 Apr 2026 17:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs5-0008WB-Ly
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs4-00011K-3z
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GF1tb64027870
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DeH2wubJHVYpkGei61VcjbWJb/j95FBb/C0QOgjdibs=; b=NH4u7sumtMg33KNi
 KRGAddqGgRGh7AreqQ7ldOrS7ZoCbqrGTCQDy/GFI8U4ZzExvRvSOg+uoyeQGvm4
 9sk1OdMmnHap4Xtjn1LF6+mCmSf66tknhqIEy887S8WkF//oftayifCdmS49OgsQ
 Se5cVn1gaDKyd+xoQBKKZnGmrb+2kF/eV6Be82YCvgbbS/ZB1Y9XSnftrATPu5ao
 szjuz0jkYt/Y9eRkSPOjN+16U/9Du9hWeSuFQo3nepOeKIMSQZi1AnvY520QguB9
 T1rgNu0kkyXcP/BUhH6fD55vRcpZecSckATY7P3RfnVFYsGsyKHoATK2fhQWa34y
 AIcBlg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk227sarw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2d3a617ad90so29782662eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776373409; x=1776978209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeH2wubJHVYpkGei61VcjbWJb/j95FBb/C0QOgjdibs=;
 b=MhyviaxWfD7tAwvqVxOVKTK4cSwr6xBs+9JpKI6UURx4bJ5cB/AirhI6VuIs+fH4Sp
 6MIZIIpyfTgq5DvDyU5NtdfeZ8LLSjEkj4mvfp0St8V7upUQaOZfNk7Ip3RxG7yKhcc4
 XAJJk7nH5vN/OK3xInbFDVDtoX4A2COEhfpPRUp3sk8tPvTebyHcnCjJ0ydCsE535l/o
 inoo9qzaGW8p0xDuREbZdkwmShgt4JTZDlvpOpP+/e52vVCrBbbQDDpiIoXu1xF/X2BD
 NP0a7/tVXMk+KtXEBbSpzBudpF06upCVTfnqLz9XK3sVW1HAbPZFyOn4aot4ySNapdyM
 2vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373409; x=1776978209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DeH2wubJHVYpkGei61VcjbWJb/j95FBb/C0QOgjdibs=;
 b=qNfkwoYoaopwXXBOabaGC6neFO0lLYouMFJXK5+O874UypuI22Hq4OEbhBFuCj4VLC
 FxDFzdokvWS8St/WWvnNuqNUXliZLdOV59XpZl8//R1z8KQJLDs4zHCUlM5sm2xb01iY
 /QW2/mAuSBVmjjo7gFBu8gYlt/5gGc2bTIhWN3IlNs0iAOCAp9UtnP/b/P8WeKYWDe3o
 fTrhV5usTzlspcAAs4ucTTxwuRyrS9VUPx7OwTfeXJ2ec0j3Lq+4VKOdJdFixH2Hl4H0
 ZFadkIhrpPdeF3b+a1KBVqSZouMy0ykVuYCPAgl1+Cv1jnf1GnBmSNUWUL9TwPg4qTdy
 0dfg==
X-Gm-Message-State: AOJu0Yy7ujpu1wmm4idjeI6Wb1uK9NY+DlsdvmAe6RgJ5g0fY15yqguv
 D1mhLh9x5d49O1PEb43mgVxIoTMjhLGjNSHMdBGhlhnGE+C49HoAaVdW+gQbRO+0Vwa3qpr1geM
 6tugBii/iqReyoU50mjqEwtyMUHBfBsuF0haUFQsxhczNZcKu6rgHFZL6CtwFW6CtFQ==
X-Gm-Gg: AeBDietWgu1/n95FhWUGsWOJaITI2sUJG2xPh/B72z0MFhoPq7KCgNkm9/Z8OsMitjC
 4+x1jHBQ+NSmeBXOY0KRx9JQcFEMvKDNMQPrN9wkSyjF6pE293AxaZXM3RvNZjzlLHfDO28moFj
 8v2vhCzGDqIaxDCnC1lDUvff4lanpDAh9pW97P/xKWbQDfmxMBLnPw+shc6zm/fxjIBZlfqwfXO
 danyP8/BOuATqDgUtdc8NvoDYm283CIOzYc63r+b+LAkMyspnx0xAK/19K/mhESP7uk+6r98+3o
 6qRDnAEPfdf22NT70b0SE13Ms1tAa2TsJvGMTHdt3XNyGVZ7zCzZ1zWOaTbPzcMOOLAyWg1Cdye
 yxrLqnUkvKkJyiADlYNz8Y3UMWzxFzfMDKK10nopboAxanEnqGg95zSy5C4pz37bOcjCQQwleZG
 6AQ4k7
X-Received: by 2002:a05:7300:6426:b0:2c0:c5e4:605f with SMTP id
 5a478bee46e88-2e2e5bf4b4cmr607692eec.24.1776373409251; 
 Thu, 16 Apr 2026 14:03:29 -0700 (PDT)
X-Received: by 2002:a05:7300:6426:b0:2c0:c5e4:605f with SMTP id
 5a478bee46e88-2e2e5bf4b4cmr607666eec.24.1776373408748; 
 Thu, 16 Apr 2026 14:03:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c90cd7esm11176277eec.13.2026.04.16.14.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 14:03:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 9/9] tests/qtest: Add hexagon boot-serial-test
Date: Thu, 16 Apr 2026 14:03:05 -0700
Message-Id: <20260416210305.2255579-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5OSBTYWx0ZWRfX/Xm2nn1NEGe3
 7ePDD6jHARg9etNDktKXEBw3BeNgj2XASvIjKuCK57eerOpnV8M32VRrKyJxO9sYWSdfWqbt/Gx
 /V2yhzgLxim91EWIAcPXONHtrYkSdz93euU0W/9WWmcFOb5tqPXL4KTDfo3U/+V9wE5wuYKweaY
 FjVUt2prrV8XIiDtLWCv68McwsjSUdo4L7MeeRi+Ne2UcGN1oRIaPvrvgxmySzmONtiR5Swsh87
 lRF3t1EFHCGeN1T2qZVzUd/mtPPjVzLvrAgT7upzAW4bN9tWdMg1FDl+K0t+22Ds4xQwO3nnpe0
 jXF7PK9ouxmvX6QTH2dDOCO0L0y5AYfKSW8a1kSxvSqGdjMyV6fouRjn9d0r5biwjrLLkkAX/if
 A/4y322rEaCDfPoE1p7+qervFbP/uGV05gbWiGn6dZvUdT8bOSyVTiPjvlZr4t4W21D4+YoSxMB
 00LKQSTWGIV0xbwEWWA==
X-Proofpoint-ORIG-GUID: 4MPVNaY0Fr6JPQRtbEUHDYSPWiqFRizu
X-Proofpoint-GUID: 4MPVNaY0Fr6JPQRtbEUHDYSPWiqFRizu
X-Authority-Analysis: v=2.4 cv=Iuoutr/g c=1 sm=1 tr=0 ts=69e14ea2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mx_w8yxdHMTqIFmIFlQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
QHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsrKysrKysr
CiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5YzUwZTcu
LjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMK
KysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQyLDEzIEBA
IHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7CiAgICAg
MHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4MDQgPSBV
U0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFnb25bXSA9
IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyogaW1tZXh0
KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAgICAgICAg
ICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAsIDB4M2Ms
ICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAqLworICAg
IDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4MCA7IExv
b3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7CiAgICAg
Y29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwogICAgIGNv
bnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAgLTE5NCw2
ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAgeyAiYXJt
IiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5lbF9ucmY1
MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAgICAgIHNp
emVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5IH0s
CisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hleGFnb24p
LCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0tZ2l0IGEv
dGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZAppbmRleCBi
ZTRmYTYyN2I1Zi4uYmFhMTE5NTM3MWIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21lc29uLmJ1
aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTAsNiArMjkwLDggQEAgcXRl
c3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBjb25maWdfYWxsX2Rldmlj
ZXMuaGFzX2tleSgnQ09ORklHX1JJU0NWX0lPTU1VJykgPwogICAgWydpb21tdS1yaXNjdi10ZXN0
J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBbJ2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3Nf
dGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9zX3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0
LmMnLAotLSAKMi4zNC4xCgo=

