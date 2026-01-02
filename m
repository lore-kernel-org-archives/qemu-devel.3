Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E33FC6162
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 20:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vblVp-0003wl-6k; Fri, 02 Jan 2026 15:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVg-0003sg-5f
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVY-0002Sb-8b
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:26 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6029W1rR1002029
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 20:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=H1awuDDuRO4xS1rj/d0qjR3lR2WrDZbNYkuwBXLjTDc=; b=Rr
 14TI01OgsaPm04LGiEpL5ZDKmspJM/3xg930cloMFC/KM856h/1QqpGAd1vlHsU9
 fisKaSuCeO1YmjlrBpK4stFxoSkUWTfOSyJfteCaRtilhkqFL0y8BU9galPOa+iX
 fFzp9mTboIALWz1YzXfbDOFFZ3cXge6nNGoSUNI5iYsxxeN5LwFe2UtUAKhFIZQD
 yJSLHVf//z7Y+zrsRzqngs2bPV1+4wmPKB3GB3o8bZ8/CvOYMNT3Ax5oEx5vid4m
 IziO7qDQ0GwpcUl/gZ3wDPugWhkZg7IcL5hLHv4DonNmjGtnRArl/PFXzNRntII4
 C17Z77F9P/2vU/ABlB+A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd2bb4se4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 20:12:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b6ce1b57b9cso11614048a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767384740; x=1767989540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1awuDDuRO4xS1rj/d0qjR3lR2WrDZbNYkuwBXLjTDc=;
 b=iB2PFKcV4USJUSb8svL1KK62G6ZSq4AUP65CoeMPYCG9ykCiXDyUklkD1rGTaSEkPP
 BjjH0hl5pejLAHrQQUhylwvH26YXJDLyjmhN35YurwOsA0m4iZ5LbaLQQ4ERZ3ATyYZB
 BVIP6+S23B5UASihyANngNzLrHt5w5LhjoOUmS2je4cJMDBj7uM85aEoSCPvF2cyj/SV
 CdkSKwCIBIK4qJuIaDZB6XufGbzGLyWK23FLgClGlQR7tvArj0Q1Nx32Llbm9eFYbb6t
 2iFYpt70PFOh8yY3yO79nH9UssjmbJtVM5scd8H8jKCEJZKuJnnb4Xtk1PjeytUhFhSN
 ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767384740; x=1767989540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H1awuDDuRO4xS1rj/d0qjR3lR2WrDZbNYkuwBXLjTDc=;
 b=mXlA8RzDJWCbxTNqXe0V8qDAHlJTsLGrXmp5o3BQW00pQESEVcH8n2tCBDqRjjhhts
 Z1FtxokJ1JH2n5CfGKdZJ3eayWPtAsQh5va2XWIZFAaojmqBGOcQJi8sIrMybjdqwr1o
 h+b2fcVIKaSLgSjaUm4qkd0gnIsKUxZB3TffhU/BWJWK89aosfYiZ3FAQUxPrjVYyfwP
 TzYoZRhCIRYec26gLqZO5+IZ1pEnvvYAlsPv0eaBWq5SDlPy/XZKdj8ujSZ6uSC12m+Y
 nkEjXhZ91mfK89zpuEKB31yRFzx7LmiLqlxKbWBthUW8x/JeJwKGvjU2YFq7g1/x351m
 ABJQ==
X-Gm-Message-State: AOJu0YyJV+Do3s3KZz2bvQVG1RuLo9n5MRovS2FCT/+GXxOowu/DQu8A
 sRmyz4lfOIqgejjDBtNBZ8Ce4XB/ey9rxXS8kYVRPVkV5Q4TN1gdQMbQ21Ul6tcrO7hMPw4l1cf
 qL3rVOpID1V8huJjHfV0QTSHAf1fbn5jvuMPH3sUYJjUz7+a0KKy/SAqTtjKIAnxBLg==
X-Gm-Gg: AY/fxX59eAPwV9x+8Tm1/DUuPnWhqIPbEFCp/8AnanooJtKGm3XN4t8BpGOMg2qvBCY
 43/5sb1iogd83DKr3yVsXDlCOa1AXG1ewIMdMBpurLXYrGcv5zIz6hFZST945Mm/8bhl+7eQlyO
 fWiqgWT+LfzCmKHQIbFJSfKByJb9fwau82qC3xEHsRhL+0mQ3alGuxRRBebIME92vtBtsbY0YTn
 rwgCpxf/Va1+KVImB7s7fS3v3CiDOhDDNaXAsSoryaVH51qQcRpVMHAzFrFY1inFdsfRZmYo+U1
 XclEqhVQ0VVjXbpmIspidutTzvrwBpYBwMItIUnRuW3qB9/OxxdVSOMFFmcXpD4diflHEgt6EB5
 p9+jWdU+k3UUKqcxhKP/60AH5xleC2iTDc8Io8lypavMWRrVypwzf4f+uMg==
X-Received: by 2002:a05:7301:6f0e:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2b05ebb63famr27128741eec.4.1767384740011; 
 Fri, 02 Jan 2026 12:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL/1B5D85Xmisuu8eA175iOmwM56xct78YfP3tSt1egfH+ZZZ837X1p3ETDkd8pOdXxSiumw==
X-Received: by 2002:a05:7301:6f0e:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2b05ebb63famr27128730eec.4.1767384739478; 
 Fri, 02 Jan 2026 12:12:19 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42e7esm1794621eec.22.2026.01.02.12.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 12:12:19 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
Date: Fri,  2 Jan 2026 12:11:57 -0800
Message-Id: <20260102201205.2050363-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
References: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: yU8dSmDE66KnKgd6qQV6dRaVruoFfz5L
X-Proofpoint-ORIG-GUID: yU8dSmDE66KnKgd6qQV6dRaVruoFfz5L
X-Authority-Analysis: v=2.4 cv=dMKrWeZb c=1 sm=1 tr=0 ts=695826a5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=DeRzdpBI32YyQvUjPIcA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MSBTYWx0ZWRfX125Ly3+g9c+I
 TBEf2qh5J30qBFVRxDxeReXvVS68v3WbE7rZefT0khzeZWUwXWu/Hl7VYt2osane4196USFkyRJ
 XwDN3gAAgXIOU91gzsaf/HdicfkonKIsA2qzexf6JIbIKEfPOYoj7nD65xg92FDupcAEWTy4aTI
 7cGkGdefipC17XZouL/25ltl11BvrRfnxlcWbR/wEmZtBrXY4cMHPHxqXy9BAb/3O1XWH4+WSw+
 xRqXoE1YMwuL3Yih3Hp8Qwe1Y1xXZxeUOoLmCD01ls8f7YhXD+PIJ5QhF4xF7iOt/mr/t1ll0nj
 PKQ1fIDSwtX9yAzUfmrUs+9Bhok/QrL63wX4ZhSYWkSIZSQ9njvDLMC9dCsXFdy50Ss743cejcK
 kkj1PD8EazWV2zKQcQuGDJRhrN6s5X9EA1HUM/wxpgtLZu7xE6RnNBJffJaXbUzfFWKd0SxfJZ9
 4/KPZFrwPzURCP76BZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020181
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClRoaXMgY2Fu
IGVhc2lseSBiZSBkb25lIGluIEMgd2l0aCBvcGNvZGVzX2RlZl9nZW5lcmF0ZWQuaC5pbmMKCk5v
dGUgdGhhdCBnZW5fdGNnX2Z1bmNfdGFibGUucHkgaGFzIHNvbWUgbG9naWMgdG8gc2tpcCBpbnN0
cnVjdGlvbnMuCkhvd2V2ZXIsIHRoZXJlIGFyZW4ndCBhbnkgaW5zdHJ1Y3Rpb25zIGN1cnJlbnRs
eSBpbiB0aGUgY29kZSB0aGF0IHdvdWxkCmJlIHNraXBwZWQgYnkgdGhpcyBsb2dpYy4gIFNvLCBp
dCBpcyBzYWZlIHRvIGJhc2UgdGhlIHRhYmxlIG9uIHRoZQpjb21wbGV0ZSBvcGNvZGVzIHRhYmxl
LgoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNv
bT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
VGVzdGVkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClJldmll
d2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgfCAgNiArKy0KIHRhcmdldC9oZXhh
Z29uL1JFQURNRSAgICAgICAgICAgICAgICB8ICAxIC0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2df
ZnVuY190YWJsZS5weSB8IDY2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICB8IDEwIC0tLS0tCiA0IGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNzggZGVsZXRpb25zKC0pCiBkZWxldGUgbW9kZSAxMDA3NTUgdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jX3RhYmxlLnB5CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwppbmRleCBjZWNhZWNlNGFl
Li40NDVkZThkYjYwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMTQ1NCw0ICsxNDU0LDggQEAgdm9pZCBnZW5fYWRk
X3NhdF9pNjQoRGlzYXNDb250ZXh0ICpjdHgsIFRDR3ZfaTY0IHJldCwgVENHdl9pNjQgYSwgVENH
dl9pNjQgYikKIH0KIAogI2luY2x1ZGUgInRjZ19mdW5jc19nZW5lcmF0ZWQuYy5pbmMiCi0jaW5j
bHVkZSAidGNnX2Z1bmNfdGFibGVfZ2VuZXJhdGVkLmMuaW5jIgorY29uc3QgU2VtYW50aWNJbnNu
IG9wY29kZV9nZW5wdHJbWFhfTEFTVF9PUENPREVdID0geworI2RlZmluZSBPUENPREUoWCkgICAg
W1hdID0gZ2VuZXJhdGVfIyNYCisjaW5jbHVkZSAib3Bjb2Rlc19kZWZfZ2VuZXJhdGVkLmguaW5j
IgorI3VuZGVmIE9QQ09ERQorfTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL1JFQURNRSBi
L3RhcmdldC9oZXhhZ29uL1JFQURNRQppbmRleCBjYTYxN2UzMzY0Li41YWYyOThlM2VkIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9SRUFETUUKKysrIGIvdGFyZ2V0L2hleGFnb24vUkVBRE1F
CkBAIC00Nyw3ICs0Nyw2IEBAIGhlYWRlciBmaWxlcyBpbiA8QlVJTERfRElSPi90YXJnZXQvaGV4
YWdvbgogICAgICAgICBnZW5fb3BfYXR0cmlicy5weSAgICAgICAgICAgICAgIC0+IG9wX2F0dHJp
YnNfZ2VuZXJhdGVkLmguaW5jCiAgICAgICAgIGdlbl9oZWxwZXJfcHJvdG9zLnB5ICAgICAgICAg
ICAgLT4gaGVscGVyX3Byb3Rvc19nZW5lcmF0ZWQuaC5pbmMKICAgICAgICAgZ2VuX3RjZ19mdW5j
cy5weSAgICAgICAgICAgICAgICAtPiB0Y2dfZnVuY3NfZ2VuZXJhdGVkLmMuaW5jCi0gICAgICAg
IGdlbl90Y2dfZnVuY190YWJsZS5weSAgICAgICAgICAgLT4gdGNnX2Z1bmNfdGFibGVfZ2VuZXJh
dGVkLmMuaW5jCiAgICAgICAgIGdlbl9oZWxwZXJfZnVuY3MucHkgICAgICAgICAgICAgLT4gaGVs
cGVyX2Z1bmNzX2dlbmVyYXRlZC5jLmluYwogICAgICAgICBnZW5faWRlZl9wYXJzZXJfZnVuY3Mu
cHkgICAgICAgIC0+IGlkZWZfcGFyc2VyX2lucHV0LmgKICAgICAgICAgZ2VuX2FuYWx5emVfZnVu
Y3MucHkgICAgICAgICAgICAtPiBhbmFseXplX2Z1bmNzX2dlbmVyYXRlZC5jLmluYwpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jX3RhYmxlLnB5IGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19mdW5jX3RhYmxlLnB5CmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDc1NQppbmRleCAy
OTlhMzliMWFhLi4wMDAwMDAwMDAwCi0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY190
YWJsZS5weQorKysgL2Rldi9udWxsCkBAIC0xLDY2ICswLDAgQEAKLSMhL3Vzci9iaW4vZW52IHB5
dGhvbjMKLQotIyMKLSMjICBDb3B5cmlnaHQoYykgMjAxOS0yMDI0IFF1YWxjb21tIElubm92YXRp
b24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCi0jIwotIyMgIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
Ci0jIyAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkKLSMjICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRo
ZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgotIyMgIChhdCB5b3VyIG9wdGlvbikgYW55
IGxhdGVyIHZlcnNpb24uCi0jIwotIyMgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAotIyMgIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCi0jIyAgTUVSQ0hBTlRB
QklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQotIyMg
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCi0jIwotIyMgIFlv
dSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlCi0jIyAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8v
d3d3LmdudS5vcmcvbGljZW5zZXMvPi4KLSMjCi0KLWltcG9ydCBzeXMKLWltcG9ydCByZQotaW1w
b3J0IHN0cmluZwotaW1wb3J0IGhleF9jb21tb24KLWltcG9ydCBhcmdwYXJzZQotCi0KLWRlZiBt
YWluKCk6Ci0gICAgcGFyc2VyID0gYXJncGFyc2UuQXJndW1lbnRQYXJzZXIoCi0gICAgICAgICJF
bWl0IG9wYXF1ZSBtYWNybyBjYWxscyB3aXRoIGluc3RydWN0aW9uIHNlbWFudGljcyIKLSAgICAp
Ci0gICAgcGFyc2VyLmFkZF9hcmd1bWVudCgic2VtYW50aWNzIiwgaGVscD0ic2VtYW50aWNzIGZp
bGUiKQotICAgIHBhcnNlci5hZGRfYXJndW1lbnQoIm91dCIsIGhlbHA9Im91dHB1dCBmaWxlIikK
LSAgICBhcmdzID0gcGFyc2VyLnBhcnNlX2FyZ3MoKQotICAgIGhleF9jb21tb24ucmVhZF9zZW1h
bnRpY3NfZmlsZShhcmdzLnNlbWFudGljcykKLSAgICBoZXhfY29tbW9uLmNhbGN1bGF0ZV9hdHRy
aWJzKCkKLSAgICB0YWdyZWdzID0gaGV4X2NvbW1vbi5nZXRfdGFncmVncygpCi0gICAgdGFnaW1t
cyA9IGhleF9jb21tb24uZ2V0X3RhZ2ltbXMoKQotCi0gICAgd2l0aCBvcGVuKGFyZ3Mub3V0LCAi
dyIpIGFzIGY6Ci0gICAgICAgIGYud3JpdGUoIiNpZm5kZWYgSEVYQUdPTl9GVU5DX1RBQkxFX0hc
biIpCi0gICAgICAgIGYud3JpdGUoIiNkZWZpbmUgSEVYQUdPTl9GVU5DX1RBQkxFX0hcblxuIikK
LQotICAgICAgICBmLndyaXRlKCJjb25zdCBTZW1hbnRpY0luc24gb3Bjb2RlX2dlbnB0cltYWF9M
QVNUX09QQ09ERV0gPSB7XG4iKQotICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoK
LSAgICAgICAgICAgICMjIFNraXAgdGhlIHByaXYgaW5zdHJ1Y3Rpb25zCi0gICAgICAgICAgICBp
ZiAiQV9QUklWIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAgICAg
ICBjb250aW51ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZ3Vlc3QgaW5zdHJ1Y3Rpb25zCi0g
ICAgICAgICAgICBpZiAiQV9HVUVTVCIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106Ci0g
ICAgICAgICAgICAgICAgY29udGludWUKLSAgICAgICAgICAgICMjIFNraXAgdGhlIGRpYWcgaW5z
dHJ1Y3Rpb25zCi0gICAgICAgICAgICBpZiB0YWcgPT0gIlk2X2RpYWciOgotICAgICAgICAgICAg
ICAgIGNvbnRpbnVlCi0gICAgICAgICAgICBpZiB0YWcgPT0gIlk2X2RpYWcwIjoKLSAgICAgICAg
ICAgICAgICBjb250aW51ZQotICAgICAgICAgICAgaWYgdGFnID09ICJZNl9kaWFnMSI6Ci0gICAg
ICAgICAgICAgICAgY29udGludWUKLQotICAgICAgICAgICAgZi53cml0ZShmIiAgICBbe3RhZ31d
ID0gZ2VuZXJhdGVfe3RhZ30sXG4iKQotICAgICAgICBmLndyaXRlKCJ9O1xuXG4iKQotCi0gICAg
ICAgIGYud3JpdGUoIiNlbmRpZiAgICAvKiBIRVhBR09OX0ZVTkNfVEFCTEVfSCAqL1xuIikKLQot
Ci1pZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgotICAgIG1haW4oKQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRl
eCBkMjY3ODdhOWI5Li5kMTY5Y2Y3MWIyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tZXNv
bi5idWlsZAorKysgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNDEsMjAgKzQxLDEw
IEBAIGhleGFnb25fc3MuYWRkKHNlbWFudGljc19nZW5lcmF0ZWQpCiAjCiAjIFN0ZXAgMgogIyBX
ZSB1c2UgUHl0aG9uIHNjcmlwdHMgdG8gZ2VuZXJhdGUgdGhlIGZvbGxvd2luZyBmaWxlcwotIyAg
ICAgdGNnX2Z1bmNfdGFibGVfZ2VuZXJhdGVkLmMuaW5jCiAjICAgICBwcmludGluc25fZ2VuZXJh
dGVkLmguaW5jCiAjICAgICBvcF9hdHRyaWJzX2dlbmVyYXRlZC5oLmluYwogIyAgICAgb3Bjb2Rl
c19kZWZfZ2VuZXJhdGVkLmguaW5jCiAjCi10Y2dfZnVuY190YWJsZV9nZW5lcmF0ZWQgPSBjdXN0
b21fdGFyZ2V0KAotICAgICd0Y2dfZnVuY190YWJsZV9nZW5lcmF0ZWQuYy5pbmMnLAotICAgIG91
dHB1dDogJ3RjZ19mdW5jX3RhYmxlX2dlbmVyYXRlZC5jLmluYycsCi0gICAgZGVwZW5kczogW3Nl
bWFudGljc19nZW5lcmF0ZWRdLAotICAgIGRlcGVuZF9maWxlczogW2hleF9jb21tb25fcHldLAot
ICAgIGNvbW1hbmQ6IFtweXRob24sIGZpbGVzKCdnZW5fdGNnX2Z1bmNfdGFibGUucHknKSwgc2Vt
YW50aWNzX2dlbmVyYXRlZCwgJ0BPVVRQVVRAJ10sCi0pCi1oZXhhZ29uX3NzLmFkZCh0Y2dfZnVu
Y190YWJsZV9nZW5lcmF0ZWQpCi0KIHByaW50aW5zbl9nZW5lcmF0ZWQgPSBjdXN0b21fdGFyZ2V0
KAogICAgICdwcmludGluc25fZ2VuZXJhdGVkLmguaW5jJywKICAgICBvdXRwdXQ6ICdwcmludGlu
c25fZ2VuZXJhdGVkLmguaW5jJywKLS0gCjIuMzQuMQoK

