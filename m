Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD4AFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0As0-0000mN-8c; Wed, 11 Mar 2026 00:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aro-0000kx-7V
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arm-0008Se-PX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B1YlJD508290
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3wMMATC9kZ28VJVgN1yDUOqgmYsX8TydmzBQouHOOJA=; b=c0BE6aa3475QPcxi
 Yp2/lV5NoU8+U90r8YjGdNJMKm+FkiwHTZmgM2nzQ706EcHfG4Y86FQ2InAryx4n
 7umxZUzj3fHzWDUs9auyv/hmeIMZOHXQs+nkSv6UjjfQw2WROS0PzWW3z57HrnyR
 h2C+rlf4rGcCstUW162hII1JvgOhu2RCUCT4OPl9UnrIpI+4H65TP19l7yrzEiUq
 sp82jmfUUFvEjwHiCNO2FFkYAlmTjmDtyUKMHXtgr3hWFprAUe5ihCqMPtt8PFzC
 pCLK3s1qSontM7fuG5HIYsNyjFV3/GNqiFjL4lXDVcdiO2BmcUBeLl/tT8Ij65Z8
 nTBlEg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppaj4xk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:12 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-415e1ea16b4so88396177fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202092; x=1773806892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wMMATC9kZ28VJVgN1yDUOqgmYsX8TydmzBQouHOOJA=;
 b=dNIeuwJdstU+T5ogsQ1QGY8Rx5+sPv+D0BCIyBJsh//Mi5d6Q/mYGxivgbI6mCBCe7
 4+Y4Zl4t6LC+oWBkU84H6RO8wjgKXffEPO6tC0e5ItY7H1bhgGJXKhN9WFv/kyLlv3Bi
 f48PmuAN82P/aQ/mYuprHkczy7HphzBXFFyaXnmPMlkpXcDW0wr2xVhHyYBu/vA4ygNf
 5bICeSsHbCJdGiPXd2uJ8SLU6aHwdXYyalFlnu7aWRIHxz8eGkeAGBqeLS2jm3CXhTtW
 RdKoouHtJPQkIIyQOoGjwTfx7lhZ+rLfgwlIQzSpcZ1r+8m5GEdaRWL8EkMhsA/wkMlz
 tiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202092; x=1773806892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3wMMATC9kZ28VJVgN1yDUOqgmYsX8TydmzBQouHOOJA=;
 b=QnuI7RIxs561IUf2/xX8HmuEccaMYyOO3HIoq2OB0vBDHD1Ehx4f9EVfAjaknO/T5K
 a3lxFeXjgzP1kPBI6p5bt+hSEqT4t/eNHUX0pbrevFF7HC4dW5xNuPZB6kkojdO5XOjB
 HnOdRLJgELiGq2ygLzxQuNmvUIey5VoHo6TLjt9tK4NME1QoaNjhu1Y/wxHfJai31I2d
 Fbp2ENFE/ayVX8zT+I797x+e/u8fW7Ub9M4EPDxy0HdK8SQWNmsSjGz4RGpt09pYBAad
 0C/OotdyM5ksSvri51iX5jkq2v5G5e7Rb+RGpy8vC9nhagqOSM7lEOFCGqrklMups/mM
 mnVQ==
X-Gm-Message-State: AOJu0Yxy8f6ZZTVPIgAQPydr8vfteNYYKHSsWdBgm6b9Xfq8VjsSbXMl
 nBhTJ6Q7TG4KGq4i+1e/WrTXj/7n1n7qyYbIABt4Rgqoo5kQFvLnFZmg+StLE6EQ8RwH0Vc4k0J
 epuBvoMD6VEZVm9u0jsrcUxah14JfMbiGsV181tkH13K/e3SyCUjuC7GeLMTPb2e8TQ==
X-Gm-Gg: ATEYQzxKzjZ4awv9a38RjjBs4FKjOwKnjIWTZkPA1WKaEP7e9NYnHmi1HAo5b4glTvS
 7r36hs0OYQtquuKgXNPcMvawwmCVgSlwQr9og+aXAZ9w7kg0KGxS1EW0G1w97+HW5PptBA6M+5Q
 zdo/TVQ9T1D8VZ3zsbN+HJDdJA/+2Yz2OIMMGt7IC35DAIU9AhEFbfj9g1V6YtWh2E8sC1LmqrX
 msXzwBQIAA7jixTqQdixUd1Ba4Hcar7emLFtxBsv7HjYT9bfhWb3NF8vgvh1UfwW8sfE9Fky/TM
 rsmRPWNNbgl9cNqyn3nTDaO3K7wpGRC+Q9pTkZJT+a0tWCNDUzFooCHy7yAIyIxCIubvWhuB76o
 35uv/wt2mDq2ncNunRq6QJJHiwGtaZp+T2QodGoJGjawcbhZR6HrpTOxwzB/7c2iEpiVCYw==
X-Received: by 2002:a05:6870:ed93:b0:404:1358:494d with SMTP id
 586e51a60fabf-4177cb39bb6mr830310fac.38.1773202091926; 
 Tue, 10 Mar 2026 21:08:11 -0700 (PDT)
X-Received: by 2002:a05:6870:ed93:b0:404:1358:494d with SMTP id
 586e51a60fabf-4177cb39bb6mr830296fac.38.1773202091472; 
 Tue, 10 Mar 2026 21:08:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 04/32] target/hexagon: Implement modify SSR
Date: Tue, 10 Mar 2026 21:07:30 -0700
Message-Id: <20260311040758.1068731-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: y8YyCLRb4C6loqOdPaN2o5vuoLbiZKE7
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0eaac cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGsuWRCw0nJDj9UV2E4A:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX8+JT6DdADX5K
 tR0/HxBvZYui8Ld7VVU5lRuiYVt7q/sJk2rl0foiyc5w/QgbFkIAmZdjc3eAiHrVeBnIek1j+mb
 fbbOlridDlEypniotucXdMcJveAih7MAQC5PmIeL2EOPIB0dWQjWBvuR8lFCsD9n8h0G6QinUbY
 GQVN7I662vCftAU//8aDL7lF4O4LelOEdqssOHACey6CazwJjeZ+/pXYbges3udnAY5H7q6OOOl
 dU428VNINm35Nh5DXB/Ki+dXBWQ+2Hroj1VkY4oKk62fYyNhocaoCgEFaJWZkCbC/a66VHbG52n
 aNdZwy/P37gxDXNTWP4UkJHaElFiw5Qvyn8vs/ozDBU5exSE7vj1Zre3zS7IVT1rfF1GhQAfkSR
 YT9/0CUfJVL6kQULxHLqeLZFssr9zS+WYxBnwTVNwTy445+u6zBSc1UxQwYxEZzEujGdpfyuj8C
 WH+vTFMUy9sur0agLtg==
X-Proofpoint-ORIG-GUID: y8YyCLRb4C6loqOdPaN2o5vuoLbiZKE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgcGVyLXZDUFUgU3lzdGVt
IFN0YXR1cyBSZWdpc3RlciBjb250cm9scyBtYW55IG1vZGFsIGJlaGF2aW9ycyBvZiB0aGUKc3lz
dGVtIGFyY2hpdGVjdHVyZS4gIFdoZW4gdGhlIFNTUiBpcyB1cGRhdGVkLCB3ZSB0cmlnZ2VyIHRo
ZSBuZWNlc3NhcnkKZWZmZWN0cyBmb3IgaW50ZXJydXB0cywgcHJpdmlsZWdlL01NVSwgYW5kIEhW
WCBjb250ZXh0IG1hcHBpbmcuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgMzMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMzIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRleCBjMjUxNzkwZTVh
NS4uYzczNzVkZTM5ZjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTEwLDYgKzEwLDkgQEAKICNpbmNs
dWRlICJzeXN0ZW0vY3B1cy5oIgogI2luY2x1ZGUgImh3L2NvcmUvYm9hcmRzLmgiCiAjaW5jbHVk
ZSAiaHcvaGV4YWdvbi9oZXhhZ29uLmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2ds
b2JhbHJlZy5oIgorI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4X21t
dS5oIgogI2luY2x1ZGUgInN5c3RlbS9ydW5zdGF0ZS5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWlu
dGVycnVwdC5oIgogI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2UuaCIKQEAgLTYyLDcgKzY1LDM1
IEBAIHZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudChDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDY0X3QgY3ljbGVzKQogCiB2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCiB7Ci0gICAgZ19hc3NlcnRf
bm90X3JlYWNoZWQoKTsKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgYm9vbCBv
bGRfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgb2xkKTsKKyAgICBib29sIG9sZF9VTSA9IEdF
VF9TU1JfRklFTEQoU1NSX1VNLCBvbGQpOworICAgIGJvb2wgb2xkX0dNID0gR0VUX1NTUl9GSUVM
RChTU1JfR00sIG9sZCk7CisgICAgYm9vbCBvbGRfSUUgPSBHRVRfU1NSX0ZJRUxEKFNTUl9JRSwg
b2xkKTsKKyAgICBib29sIG5ld19FWCA9IEdFVF9TU1JfRklFTEQoU1NSX0VYLCBuZXcpOworICAg
IGJvb2wgbmV3X1VNID0gR0VUX1NTUl9GSUVMRChTU1JfVU0sIG5ldyk7CisgICAgYm9vbCBuZXdf
R00gPSBHRVRfU1NSX0ZJRUxEKFNTUl9HTSwgbmV3KTsKKyAgICBib29sIG5ld19JRSA9IEdFVF9T
U1JfRklFTEQoU1NSX0lFLCBuZXcpOworCisgICAgaWYgKChvbGRfRVggIT0gbmV3X0VYKSB8fAor
ICAgICAgICAob2xkX1VNICE9IG5ld19VTSkgfHwKKyAgICAgICAgKG9sZF9HTSAhPSBuZXdfR00p
KSB7CisgICAgICAgIGhleF9tbXVfbW9kZV9jaGFuZ2UoZW52KTsKKyAgICB9CisKKyAgICB1aW50
OF90IG9sZF9hc2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgb2xkKTsKKyAgICB1aW50OF90
IG5ld19hc2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgbmV3KTsKKyAgICBpZiAobmV3X2Fz
aWQgIT0gb2xkX2FzaWQpIHsKKyAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwor
ICAgICAgICB0bGJfZmx1c2goY3MpOworICAgIH0KKworICAgIC8qIFNlZSBpZiB0aGUgaW50ZXJy
dXB0cyBoYXZlIGJlZW4gZW5hYmxlZCBvciB3ZSBoYXZlIGV4aXRlZCBFWCBtb2RlICovCisgICAg
aWYgKChuZXdfSUUgJiYgIW9sZF9JRSkgfHwKKyAgICAgICAgKCFuZXdfRVggJiYgb2xkX0VYKSkg
eworICAgICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShlbnYpOworICAgIH0KIH0KIAogdm9pZCBj
bGVhcl93YWl0X21vZGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCi0tIAoyLjM0LjEKCg==

