Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S42iXDYj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CHOHPJP3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLinr-0001uI-Rf; Tue, 27 Oct 2026 11:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLinp-0001ty-Pq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLinn-0000hm-TJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RF7t9T2519917
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=; b=S42iXDYjx2ou4Hm3
 4tuI2ss9VuCtfbjNTSOGYoTiJ+Q2lMDsPE98ZUR8EHyXeqqfVCulJhHLoz2hJ+xT
 Zb/YOS1nUjC1T487k94IYFYU2m3A2Be2M9Cno8VAIDgKYx3yvvJdf5zVX7RyV0ve
 XwTfiUoLnNTpwcufvcQ7vNh+T+Bbb3PYuK1vP7v/aeEEl6nJKTjiDFJBQZEYeldo
 c4pvlQ7rGUdH7hgNX4WnDxcDZDX6V6jFPWEk7SgBu0M+gmPcB9B0jYNwaUxqL3Yr
 3fBVeeiU5i1Ag0oXekbX+aW46uJ1Lar8WTqYqsVYQcKJBzQCeBoedVeYIhARgdkA
 0uZxKg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq69hv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:09:17 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-5384e381fbbso4124148b6e.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793113757; x=1793718557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=CHOHPJP3eLLlQsEuYJWZHXtGN4jFc+rQCVVdDOZBzPiUig9eU/GKg/6pHC4EFO++6r
 7XB7zmfLfSs+3aGeKkHSBbZqeY3KyBT+/9RC/KGIbVPCiSuNwVqIGhL2UjQMlHxxcp63
 mEr7zoq2+fwzZ9Z3GBeswIakl6qHVuxD2Hzc/g4G4+sBd+kT7WfenUVBPgF65EvuUbcC
 Oj4AH2BhLpyBhDVzI6VFSrO28oPkGkHXOtDu8j3dT6FiTQeAgEGmpDawnB11rgRzI2fD
 BQNNrD0jnrARuOjZkUUshCIiLPZH9N4NhtWq/wopvy8ygXfPbQCRLzNYKwm2r4Yk8iQL
 UQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113757; x=1793718557;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=RMiY7pzJzDMjnCam29c25EKcWZFKbnQerRr96xyIQgVt7TNEoMlfWdsOUjRqsJW5Xn
 yDSMk/nT/ZzHFuT6lhLgm1iBVRIYxde4RT7Ul8F62OK4VD2TZZB3GZ5upjveT44tfx6T
 yzoApe7mUlqQiXNvRSloLC622RnC5QjjS/6MESzA/V+ym14u+eI6VSddReWPJ/wIkIKu
 2FQ0jVkK0OlgO7RQPK32DbxZyYFRUW9GFXd6BZxYEx5k7k5lao2NgZ1K1Vpd8w6LomfF
 i5bzFEciRurH3Nc/lI/6niTJdybuAy2VrDyrE1qDpfKePQUR7DjdaiNnraKCil0l2Q/R
 gfYg==
X-Gm-Message-State: AFq9FYKRrh3XW0AeA/jTbBuwvrCaTbHU/FugzKly+HLfqgfOWMOuJMpe
 gmQONSCLyuIbCUnmPFRvnDGdFuz22sO1Ob63lKnpCJiAlpvvxOpjr6vMqzNjvgWMsVwuFI5PaI6
 cYvK+8OjSoKQuHrG5i499qXAEGK40rWm5r6dEwdYBOaZZv/HcFCQtvYXXItFZtgmcMg==
X-Gm-Gg: AYBFou3AEiQkGLAD8RV5tvsOBaYq9AO2dNWmQNj7rBSOmcXKTveXIwPIluo5vLVX1qD
 hvrCLN3UvPhU+LRa2x07rrjJajV8SQA3FQYRH0NjHQrHS8yo4GGuuec6xmGIqz5ONZk+R2lAsu7
 8951c6ucEe+TKUeLpERgZMUDSzeBktsvxi1BnfOPrN509IF03/KfIyTof/NsbpMZctaHh0VwPnC
 MkhjfCehAf4vnApvnlCRDdI/QMHNJ6ElXTegOtFy/M45jPOfnH4jlvup+UUqNMCZWofST98CD6u
 E9bn8n+pyvFiYzNpOmU0KwYj3wXJBT406oioVdBAKKVxUbZx7e+SDYjW5CsrPMWu6PYD7YfZJ5l
 aTrZagOMHwsxD3zdiKPOYRxk9Rqor/HWowNDm8P591tlxLcM=
X-Received: by 2002:a05:6808:17a1:b0:54c:7ce7:33ba with SMTP id
 5614622812f47-55c002441efmr6787844b6e.28.1793113756863; 
 Tue, 27 Oct 2026 08:09:16 -0700 (PDT)
X-Received: by 2002:a05:6808:17a1:b0:54c:7ce7:33ba with SMTP id
 5614622812f47-55c002441efmr6787816b6e.28.1793113756413; 
 Tue, 27 Oct 2026 08:09:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c03dc3524sm7673136b6e.0.2026.10.27.08.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:09:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 41/42] hw/intc/hex-l2vic: find the next pending irq a word
 at a time
Date: Tue, 27 Oct 2026 07:37:20 -0700
Message-Id: <20261027143721.4125584-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0be9d cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XWoxCBOuUWUKfCXQB-IA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: _NV-O1GvzZ7Dqah2YewaG0-G3tiQfhvb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfX/fn+zQP1YHMs
 2akP4fptha8mMziCMkffeKyi5AXx4CM/Wvx4xvJi5Hl8+YdTt8u6FHN5i0D9aja3Pl9tUAX2XZb
 phmojpSY10/v60k0Rx+rHzpZ+kIfp00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfXyOizecxzmjbM
 +6qABMglGkQ7zxqh5H88ptkQ12MgUlXnX0axHxsMVg33qfmcHEezh0HT4BHRt+0lpPpqoYapf5d
 K+uCqSGzASjmLrFlGGO4SCJgaujlJUCRlR9jtH16nPvOiipv+n8hRECftulUda/f3zgEbIcl9hF
 YSXYQDgqhNXfhMymXOpdDcauEiaYmFBz8LANNmcDSzcE7GjD1msDfZC00VT5gKsdRWk1DiFrSbF
 lA4p4j4lk0UmSFgycZcT31DNJSolhvYTNRBiRvxd6MEoj6CqMlZmn1tRONYY+PdaUGxV1KmUf0m
 gk5HQiJylaMTNV++a/ay6I62a+80SRpk5MIimWM7KnxzyU65Yv2XId71uBV4H/ckBUwbSmf+PZc
 fkgrn144QxsvpNv52oW9+9qbDa1nXJgo5usTdl1kQdR+EnunfMeBseA4hoRb1+yKIGclsu/eStr
 W8vOWdnyhZJPTlnP3hQ==
X-Proofpoint-ORIG-GUID: _NV-O1GvzZ7Dqah2YewaG0-G3tiQfhvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

bDJ2aWNfdXBkYXRlX2FsbCgpIGNhbGxlZCBsMnZpY191cGRhdGUoKSBmb3IgZWFjaCBvZiB0aGUg
MTAyNCBpcnFzLCBhbmQKZXZlcnkgY2FsbCByZXNjYW5uZWQgYWxsIG9mIGludF9zdGF0dXMgZm9y
IGFuIGFjdGl2ZSB2aWQuICBjaWFkIHJ1bnMgaXQKb24gZWFjaCBpbnRlcnJ1cHQgcmV0dXJuLCBz
byB0aGlzIHdhcyBhIGhvdCBmdW5jdGlvbiBmb3IgYW4gT1MgYm9vdC4KCkNoZWNrIG9uY2Ugd2hl
dGhlciBhIHZpZCBpcyBhY3RpdmUsIHRoZW4gZGVsaXZlciB0aGUgbG93ZXN0IGlycSB0aGF0IGlz
CmJvdGggcGVuZGluZyBhbmQgZW5hYmxlZCBieSBzY2FubmluZyBpbnRfcGVuZGluZyAmIGludF9l
bmFibGUgYSB3b3JkIGF0CmEgdGltZS4gIFRoZSBkZWxpdmVyZWQgaXJxIGlzIHVuY2hhbmdlZC4K
ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTcgKysrKysrKysrKysrKystLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hleC1sMnZpYy5jCmluZGV4IGI3
M2VjYjgyMWU0Li4yMzM1MjM2ZjgzNyAxMDA2NDQKLS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYwor
KysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC0yOTAsOSArMjkwLDIwIEBAIHN0YXRpYyBib29s
IGwydmljX3VwZGF0ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBs
MnZpY191cGRhdGVfYWxsKEhleEwyVklDU3RhdGUgKnMpCiB7Ci0gICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBMMlZJQ19JTlRFUlJVUFRfTUFYOyBpKyspIHsKLSAgICAgICAgaWYgKGwydmljX3VwZGF0
ZShzLCBpKSkgewotICAgICAgICAgICAgLyogb25jZSB2aWQgaXMgYWN0aXZlLCBuby1vbmUgZWxz
ZSBjYW4gc2V0IGl0IHVudGlsIGNpYWQgKi8KKyAgICAvKiBvbmNlIHZpZCBpcyBhY3RpdmUsIG5v
LW9uZSBlbHNlIGNhbiBzZXQgaXQgdW50aWwgY2lhZCAqLworICAgIGlmICh2aWRfYWN0aXZlKHMp
KSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICAvKgorICAgICAqIFF1aWNrbHkgZmlu
ZCBsb3dlc3QtbnVtYmVyZWQgaXJxIHJlYWR5IGJ5IHNjYW5uaW5nIHRoZWlyIHN0YXR1c2VzCisg
ICAgICogcmFuZ2UgYnkgcmFuZ2UgaW5zdGVhZCBvZiBvbmUgYnkgb25lLgorICAgICAqLworICAg
IGZvciAoaW50IHNsaWNlID0gMDsgc2xpY2UgPCBTTElDRV9NQVg7IHNsaWNlKyspIHsKKyAgICAg
ICAgdWludDMyX3QgcmVhZHkgPSBzLT5pbnRfcGVuZGluZ1tzbGljZV0gJiBzLT5pbnRfZW5hYmxl
W3NsaWNlXTsKKworICAgICAgICBpZiAocmVhZHkpIHsKKyAgICAgICAgICAgIGwydmljX3VwZGF0
ZShzLCBzbGljZSAqIDMyICsgY3R6MzIocmVhZHkpKTsKICAgICAgICAgICAgIHJldHVybjsKICAg
ICAgICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

