Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WDkNC7Gp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YEpzIy1P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHXk-00013R-J7; Mon, 09 Nov 2026 00:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQHXd-00012m-40
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:03:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQHXY-0003Py-Ta
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:03:35 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93K80q3254209
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/kTVzxDjxCnfI8XTuoqxP2
 8wy77w8CWRJDHNF0LD43I=; b=WDkNC7GpbJPGp1moNjDFSS99X/UpYswUjkwd6B
 yW810xCr7B2fmOckCJn+5ekjLTVkLFpIxer0A436QrpstCRTolEQwKhCsmwPtQxK
 Nr/jQ1Sfga0EVYxaWEMSj0mgPYQAMSKHxY4mYNAw1t02zHt5E2KhmD1jFXS8Cqrl
 tLwUKlI2Bdw4LCca6cv8vzXniaKFY0wJTbc86n/x0sZtSlIUrfdp2zOOYHP5qFYA
 j97jXL+IxSX1jAaTR8aaEhPM0arvR/gn+UdkPLyyXa6I5Idqj4KeU+RVP59Ee1Fs
 jrKdpuXN7LC2JL2lBMJ/zLsF9gHUUXqj8yHsKX8rgqvroBbg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hssbnw5wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:03:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1363704eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794200610; x=1794805410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/kTVzxDjxCnfI8XTuoqxP28wy77w8CWRJDHNF0LD43I=;
 b=YEpzIy1PRJbB6uq7g/wxU3NLfXvEQU93C/gihPKGpZDZph2lcyhpcktNkaoU8AXXZt
 xBTRNYwt6kJxl3fRCjt/7jKhvy06qioETB1UWNVfpuSREFTi4YxcKXIJFCGq/kwVa+4p
 8Z5RKiAwtzOf0dCzUxJJhI2aCZmFdTwbxIWja73kDNdJLpdr0GeGfyT+H2/mnK5q1Id7
 KDZEdfqPNdUvqCblj1FtlGux5jiXYz17Z2n0G8AcitrPB5ihlmTxfRx8FEjOWIBNPK5M
 N31TAYdBuVGFjDPxiS4CTCcXuuxMdLwB5vuhWGxh+LIMq6QncW/CuLQgpD7aiEbKa48W
 EZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794200610; x=1794805410;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/kTVzxDjxCnfI8XTuoqxP28wy77w8CWRJDHNF0LD43I=;
 b=DwMzgfnKKfICfJ2vQviyLBeYavxH4hxVN5Po1bicTl9JkUlLJSYMqyodtnzDKxv0qJ
 Z5MLLwlUjkK3+VABJRBNK7dTLp55dnZH2l5H7xTVLsptrtmy6opPxdYYxjVeLwpL33+X
 gaMjcyjV3oynSkZ0zp3vLUt8GjzB9uD9c7NZVAG1wWhic9xaYTyYgtn5Z2UlfT8sU+tq
 Kd0RATtsdDZaUkrdYg0qbFJiAWMgWG8xtd7cbj7I0Vm94B4Rnx4UYz+WvZO9a7ZVxZE9
 nD3BTcop66TYR5kPJRpuEFvyA3X9n4Z8Rx2qGmI1zcjUvuFsjO43B3EojvLQh3dnmr0t
 acOg==
X-Gm-Message-State: APuU4Z/SPkwMwr91PQpoevqtT4HWGsZNA3TESQ+hEqMk1I6u+G8kwU7v
 5WqVAECHBcb3550aoLXwoCqQ4gdLje9C1XjwoWx4pwGXe/mfG7y20HYea0bqA9HYJQ6XVe0kI2U
 xZUxU/WbwYz52/t/HDz0tIOYyBoKQSZcHFOlvStCw9it4JPqVV0xeZniVVbErBEzaIA==
X-Gm-Gg: AYBFou05cltQkb2wiAX749Xevn1Su0fmcRQmxgTeHnH3+yxG1hkVa/WMMGcWl6qU0C5
 n0ljb/aW/PDYwU2mrt7RZkvYDqKsHAKuEyWE+S9Xw+cbKmk4cDJbtrXGE6rw0dUVOi/EI42JoaV
 idFFv1unod/9yKyzNnWpf4iwi+7DV69aCKdXbUpOVVlh9CsBggHVt6mawuyAKI/UR9Fj/b5lzGi
 +HreX6c9R6TyXNwl5R9gN8g7D3xzmT7tJTMyD+OYMbRVv8ugyTIze32sHtX/I1kAHC9o64qro67
 U7QIfccAEodhZE7xKCR0c4qp6DNruLA2Nw761XNl/YPIkLFrIRKDl/tpsRYA90iD0/bXX4MersZ
 BXIto3boS4LToBvsGNhf4wvFJjZ2c4UZZRPiRXZ2rD7O9tM283zhTKaeDuVscRpCOQ8u6df+BXz
 f/ev9fjRt08rZiyHWL94s7CA==
X-Received: by 2002:a05:7300:51e1:b0:36a:6d52:e16c with SMTP id
 5a478bee46e88-372560392demr6881745eec.12.1794200609812; 
 Sun, 08 Nov 2026 21:03:29 -0800 (PST)
X-Received: by 2002:a05:7300:51e1:b0:36a:6d52:e16c with SMTP id
 5a478bee46e88-372560392demr6881713eec.12.1794200609310; 
 Sun, 08 Nov 2026 21:03:29 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265c0701csm10119520eec.13.2026.11.08.21.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:03:28 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/3] Hexagon: Fix virt boot
Date: Sun,  8 Nov 2026 21:03:24 -0800
Message-Id: <20261109050327.1475448-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: cI4vAy9vilaC_t0HWhAij-M_uJRhsQEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxOSBTYWx0ZWRfX6t3DAcbZPSwg
 /bKXgr25bsVKvPKEciUt8ubzEHhh5e76SxpLJTW0m0GBU0iGpLjQlNQPuGmO0WyAwNzjsfhU6Pu
 5R5F5ReVByb4h3klA1uCwFVgZvGNthYIZWW/ZaBeZNMWykaWl8oQwtlXZdDvS0SF3J6fq896p27
 wDmO3Z2bVNIMQDIFESN1+TTQ6P1BRNpXyY6SaYKBrvrFNoR1pYsDe5BI8YKcySPKOgnrwys0Me+
 /twG1ea0g/EUYhzCPziGGEsSYBnJ/udCP8OvAunja/SDhGfc3qSDy3kYdfgqAZH+Qii4zuq2xSl
 RZOXDUYxzsAP32ixjr/y+iRxUXzLU0dwZQNOOLcAwY7WYQI63C2s8c12yyd7I4UGbbndL4OYEfD
 1cg+hjFCoqpKFXaPhYxgUI5RAYOAVYTf8+gbNXYw1haT5E/qqcxgtmrzYf3xJ4qF+hIM+7lig1K
 2xRLr0be9QqnX/Jt/tQ==
X-Proofpoint-ORIG-GUID: cI4vAy9vilaC_t0HWhAij-M_uJRhsQEw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxOSBTYWx0ZWRfX27vgBR2ziKnL
 gFXFRP5ZngZfaBUVUyAUaoYkZi1eowrXBJR6wCiaCuJYRWMpsvEzH7+lIX4/ooA3n+HrSEGjIDP
 SLs0eJM3Mv8MDXleIyJsMAU1QIvhtrU=
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6af15423 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=23kEkXr_GDp0iaskoDcA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090019
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIHZpcnQgbWFjaGluZSAtYmlvcyBvcHRpb24gZGlkbid0IHdvcmsgZm9yIGgyIGxvYWRsaW51
eC4gIFJlZmFjdG9yIHZpcnQKdG8gdXNlIHRoZSBsb2dpYyBpbiBoZXgtYm9hcmQgd2hpY2ggd29y
a3MgZm9yIGxvYWRsaW51eCBib290cyBvbiB0aGUgbWFjaGluZXMKd2hpY2ggdXNlIGhleC1ib2Fy
ZC4KCkJyaWFuIENhaW4gKDMpOgogIGh3L2hleGFnb246IHNoYXJlIHRoZSBIZXhhZ29uIFZNIGd1
ZXN0IGJvb3QgY29kZQogIGh3L2hleGFnb24vdmlydDogZml4IGZpcm13YXJlIGJvb3QKICBody9o
ZXhhZ29uOiBmaXggRkRUIGFkZHJlc3MgYW5kIHNpemUgY2VsbHMKCiBpbmNsdWRlL2h3L2hleGFn
b24vaGV4LWJvYXJkLmggfCAgMzUgKysrKysrKwogaHcvaGV4YWdvbi9oZXgtYm9hcmQuYyAgICAg
ICAgIHwgMTUxICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIGh3L2hleGFnb24vcWNvbV9k
c3AuYyAgICAgICAgICB8IDE3OCArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGh3
L2hleGFnb24vdmlydC5jICAgICAgICAgICAgICB8ICA3OSArKysrKysrKysrKystLS0KIHRlc3Rz
L3F0ZXN0L2Jvb3Qtc2VyaWFsLXRlc3QuYyB8ICAgNSArLQogNSBmaWxlcyBjaGFuZ2VkLCAyNjEg
aW5zZXJ0aW9ucygrKSwgMTg3IGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

