Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA405C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3du-0003DH-ED; Mon, 29 Jun 2026 00:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dY-0002tF-Ot
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dS-0001TD-Ph
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NOc11719481
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=; b=acpyvwFvxBG0lzvp
 7TfNn/ZU4NP24YotvdLTbLxtgZaw78pgKD/5LGN0NbIViwMVVyN3cuS3fEJXozbg
 j/eI42NrGpskt3jVAzmyaHZ5S7dFgjwrRY4VYXNQJjd+S8FEg1YHtPxSqLMKbaal
 vD1t2pCGN3qTcg4e8rE671bF54K4lJdGW8ZL0AmaL6XiPVHW8uPMuEYqnZzivZ5y
 +gmNl8FCnMDIcxodDNzRPdFefGZQX2x2wkpGHPlynXg+MpHCOcQMbu1IV66R+r6g
 xS3rv0DnEm7iii4YXDlrcD9mWZ9EwO8dOGnbgkMZUQAS/nKNBccO1rH360LDmKbP
 VsylTA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf49yk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso2802964eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707416; x=1783312216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=inTG1FswR3SapZ/WT/og9XCPMET2yFeLmtF+um+qYS7jIP1N5qLc9ZZ4n0fSjpWit0
 AUJYQZcbGA3Y4W5mv89b1jBV8qyVptsbDcQuy9OMejEiaYJuT+Tl4RWCrA8ZKKnkDQaL
 eBuUkV+1qDa4c8hewDEjxVrwhtWiGyeG3TArer+OEGj2xdMeaxM0ooCAqjKEHwEsHqk8
 xzbNexqB1pZb3Zo4P5tN4dbeiBRJbSD1yq/K3DSaZkkR2bLWRx1tR3/iFCPtFT0t7AXO
 ASU96A9WRvzvzitvHSQZjYU7hpgWTFtTU23XmbPB9cKfGDvYD+DVgvMJ9YtVn1HB/Z9b
 9YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707416; x=1783312216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=Kw66wiV+/UwtTmbmGO4duNcmh19c8ZCO5XlUmZRX0c5bI9H3wMlE9u1KkHZxuJ944r
 JVx0lhCZ5IqlhuXEONpdFxNca4ERfebLIg15OkHmSD0Eq6DFG4olWA91KbNS0LMoMgbF
 UsImTkead54NVNpo/P1+ydHzAyoMz3xvU46YflWjoM9Qy0rEqRmjn6zgFaa8jMBMDUjo
 5mgWroH2mJx54AxckGbRR+M95RT6ZQ91iRX6FBXNr/Yy98MdfJEVmuLgIb1Cfjsr/SvB
 9/bsgtciepFYLMbWZK09Ef5LKkE0juL+Brc0eFT7++4LchpubDdKMRiJQIKeajjHKUmq
 NWJQ==
X-Gm-Message-State: AOJu0YwldnVv0rgzX4Z4n50b72+45BTBzeGlzQte9/br32DBygIhcm8q
 lLPPIUepicyG4qvyYdMJuNDPvonriKQOh9n+QXu5W04Du74xSPvSIosl7vHfb/LJvF5kaBME+tM
 f8QmwL0frMlbFVAU6Ax6dK1GGbY8KBdPGv7z5yV/BwWA8uejPY+k4zdT2hrdorePvWA==
X-Gm-Gg: AfdE7cmLtcI7d/gu92ba7U8T9bTGhH/vWzmv9e+nVFxQsG15F0jXsGQBdE1CqDnZwiU
 /H4oatzRcZM14ztNS+YEC3EmKXO8Zqn1nwTTIJL8ev4s+7cayRGblB9uwa7TAWdBvrpSm5WGaPV
 8OI5QL0qWj8EgzGKt9qoOmo21/tyOGe9AS1gq++mUxqghaZhKLuZWacp3riVuEj2MY237YOXxUS
 bVYbFgMIqgBtNbdzdnDZbEuLOB/AofsUnqbLFFmsZw6TkPrwN5Z1TyALes0sDUZEJVE+WwLvNIz
 Qo5UYXWLDOKgNPH3eAH/VzL6F5PbTU35UbtoVHCwruHwwl0vp3+407zz442QSVesMhH1SGwujle
 XX2j2Tw3/L7XjaTqGRuIRv4a24FWVkqf7LonVqXuuBg5MVZ8t6vtb7j76dME=
X-Received: by 2002:a05:7301:9f02:b0:30e:d6ca:61a2 with SMTP id
 5a478bee46e88-30ed6ca64bdmr180820eec.35.1782707415903; 
 Sun, 28 Jun 2026 21:30:15 -0700 (PDT)
X-Received: by 2002:a05:7301:9f02:b0:30e:d6ca:61a2 with SMTP id
 5a478bee46e88-30ed6ca64bdmr180795eec.35.1782707415363; 
 Sun, 28 Jun 2026 21:30:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 67/77] target/hexagon: Add support for loadw_phys
Date: Sun, 28 Jun 2026 20:58:20 -0700
Message-Id: <20260629035830.1520296-68-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1S6X7Wk9ZVo7
 qyliZA3oslbi3Opd9E6QlkOY650yi3gOxSJwuLktDPW+zkTkF88DihYkf8AtVcdUJJdnFIK39xP
 vc6UXJoMmNpKfkEYv239kApzdug5Hr0=
X-Proofpoint-GUID: 3vHDSdg9hwAKeoS9CfJqL4AJSjAzaPHu
X-Proofpoint-ORIG-GUID: 3vHDSdg9hwAKeoS9CfJqL4AJSjAzaPHu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+FUA5LXUp+ak
 eMeccB9f8xRiF2uc8rNIHqwLLVLW7Sv7jlYAgs2vQYECbUf1SVxGnLBicsz2nTTnMsN7wpWG1zI
 a6H7i4BhPY1FqAjRtCySwnWLqF+OmDw8fZALc895oHqGFkdhpDFE/GYKdYLvjrvN4GYy4FW/zKy
 M99Ic5Bs+leitpD442hZSlEtFRp27CQi8AelQKzStOWbqEThbnVb954tIyKjk+4hp8cX+XHeCuo
 /J2ut1mfzeoIH4HK+u5vQLxergV6OeCFdNKDrMUnEQL6TJUBShl6GjvENkb0JXViyJ3q5DiNRGv
 dDh2tSTE8gkOtWt8Msb1bpn7P2nyMxPUUIEPf7P6ZIcXedX43T+TOu6DYEfoWimWv05RjgtFr4i
 aBALSz9K6/RUKO3r8beV4vOJdbLWhktGU4BIZx0KLZe/sr1pDSElIMfbJfrSFaXOHeUm6IssCCK
 q347tathqx4+4Ul+yLg==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41f4d8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5j
b2RlX3BwLmRlZiB8IDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CmluZGV4IGFjYWFhM2M5NDRhLi5kOTFhNjUzYzNkNCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjQsNiArMjY0LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDA0ZTkxMWY1OWM4Li4xYzY0NDk1ZDUxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9lbmNvZGVfcHAuZGVmCkBAIC0zODQsNiArMzg0LDcgQEAgREVGX0VOQzMyKEw0X3JldHVybl9m
bmV3X3BudCwgSUNMQVNTX0xEIiAwMTEgMCAwMDAgc3Nzc3MgUFAxMDEwdnYgLS0tZGRkZGQiKQog
CiAvKiogTG9hZCBBY3F1aXJlIFN0b3JlIFJlbGVhc2UgRW5jb2RpbmcgKiovCiAKK0RFRl9FTkMz
MihMNF9sb2Fkd19waHlzLCAgICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMXR0dHR0
IC0wMGRkZGRkIikKIERFRl9FTkMzMihMMl9sb2Fkd19sb2NrZWQsICAgIElDTEFTU19MRCIgMDAx
IDAgMDAwIHNzc3NzIFBQMDAwLS0tIDAwMGRkZGRkIikKIERFRl9FTkMzMihMNF9sb2FkZF9sb2Nr
ZWQsICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMDEwLS0tIDAwMGRkZGRkIikKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCmluZGV4IDUzMTk4MTc2YTk5Li40ZTFlNWQ1MzI2ZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZgpAQCAtMjAzLDYgKzIwMyw5IEBAIFE2SU5TTihT
Ml9zdG9yZXdfbG9ja2VkLCJtZW13X2xvY2tlZChSczMyLFBkNCk9UnQzMiIsIEFUVFJJQlMoQV9S
RUdXUlNJWkVfNEIsQV9NCiBRNklOU04oTDRfbG9hZGRfbG9ja2VkLCJSZGQzMj1tZW1kX2xvY2tl
ZChSczMyKSIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1TSVpFXzhCLEFfTE9BRCxBX1JF
U1RSSUNUX1NMT1QwT05MWSxBX1JFU1RSSUNUX1BBQ0tFVF9BWE9LLEFfTk9URV9BWE9LKSwgIkxv
YWQgZG91YmxlIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZkxPQURfTE9DS0VEKDEsOCx1
LEVBLFJkZFYpIH0pCiAKK1E2SU5TTihMNF9sb2Fkd19waHlzLCJSZDMyPW1lbXdfcGh5cyhSczMy
LFJ0MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV80QixBX1BSSVYsQV9SRVNUUklDVF9TTE9UME9O
TFksQV9OT1RFX1BSSVYsQV9NRU1TSVpFXzRCLEFfTE9BRCxBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJMb2FkIHdvcmQgZnJvbSBwaHlzaWNhbCBhZGRyZXNzIiwKK3sgZkxP
QURfUEhZUygxLDQsdSxSc1YsUnRWLFJkVik7IH0pCisKIFE2SU5TTihTNF9zdG9yZWRfbG9ja2Vk
LCJtZW1kX2xvY2tlZChSczMyLFBkNCk9UnR0MzIiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzhCLEFf
TUVNU0laRV84QixBX1NUT1JFLEFfUkVTVFJJQ1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VU
X0FYT0ssQV9OT1RFX0FYT0ssQV9SRVNUUklDVF9MQVRFUFJFRCxBX05PVEVfTEFURVBSRUQpLCAi
U3RvcmUgd29yZCB3aXRoIGxvY2siLAogeyBmRUFfUkVHKFJzVik7IGZTVE9SRV9MT0NLRUQoMSw4
LEVBLFJ0dFYsUGRWKSB9KQogCi0tIAoyLjM0LjEKCg==

