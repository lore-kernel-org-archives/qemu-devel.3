Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E38CDB46B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifP-0003qP-OT; Fri, 19 Jun 2026 19:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifN-0003p6-GL
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifL-0007Q9-Fz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYSNH1337254
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jw9yZ1Fa+tyKZPk60MTE6s7LkPtVtmumQCTRRtdnjUc=; b=Kg+NvDuYJU/+KRGP
 ixR5iYdBbPXQOD3OjXqZySMOj2J2jVQE/KTOGRpmH/i7aIO8P5SDNkCgh1n9wPbj
 edqJ64lSYs02BBoxNL7Sg2DTk4JjE2ZnMagtuQjXI+EK9kFweHUkTt1ZNlr4cNWW
 ETTuc5ZH0Okx3xJKvpH3OigejidpqzO6Itxfd0HRC+phh2vIsgk03mor2bMK55jm
 ISzWpT+5dQi/tdIFSU95s3BMV6jyRQXm6TL7d0IojH9M5+KWo4sKffKXGep1hugI
 ysor63olHjwJYlQSZT4b5i6fX2mDNZ1GPnWsPJlmjoRDaKWcTU41zDO8wLCuCBw8
 HkbNJg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67579q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so3821801eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911825; x=1782516625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jw9yZ1Fa+tyKZPk60MTE6s7LkPtVtmumQCTRRtdnjUc=;
 b=OGyu0Ut0Ng0b3oZ/xoZwrLIX5/PCthzy3zfm9q7mTRD0FdapKjzMxl0TrNnwyhIFY6
 DTmIP7aPlYE+3tbAHy7h4m9r3sa7MRNEasltCBu0RhdaR8QMeIBqCqkg5Zq8I1mw2c79
 jrkjuntF2DzSIpelRcznqBz8jOj32BPSQTNQ3RjqQBC8nRRaw352jLkIxxS4Lo9qWIy9
 2TkvhJ/7S//5yo1FUsqRTu9oEDtymLNC13mB+X7gSPNR29YGjqLpy6I9ddym++h4OfDK
 zW0uRAOYiBLIJ8fwCxar+UimY5s5lZc1tFEhoCtKdHLw/ELSxRoa4yfUQs504mFMiWi6
 K5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911825; x=1782516625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jw9yZ1Fa+tyKZPk60MTE6s7LkPtVtmumQCTRRtdnjUc=;
 b=crBd7YRTRrmF/g1PB7uKyzkR+I4ipvpmyF8d3VPCki5eAsv/FSVPR39amSW+LwMvwd
 amFll1YDm0VFijW2y5gjIlcobMgmCr5JpQjRrLHV3p2TrlYtR9TlGiA3NVMn2m8DepJC
 YEyjnEEWoTFapnXwZl8wa8bUn94lg5tUHR1+gdxHyX4ns/XveNPdVaduIW4op8T2Lbo4
 IyWCZybuE+j9kCdAYBE+xIjmtu4TK8+1CancGQKSZd/+X+yCvapL4EBtTzvNJKMMO8Kd
 D4nVrcx8mJoDRty+w/14EW+JL740lLxbtZfD1GBxXXIHc3AZzRItzel7iSCmqw+0ASaN
 /L7w==
X-Gm-Message-State: AOJu0YxEJ3r1Ojg9++gF9ksjWeRBR2fB80o9R4VhgCoIlrvgXXI6/D6V
 ymiUugJRn3JdxviKa7fWArSSRo40idcZUuQWICeWPgE0t74lzIZY/ym7oTX7bZOyCEZOQulydgP
 b9/IuisYq/rM3w/DncgqLfU3eazk0cz8Bvu/CgZPhq8QhbFY2AWSorXYaMXcbH59FaA==
X-Gm-Gg: AfdE7clBrOpkaNv+bVaT74qOqKzH4cr7ZMRtiCBow8mqvcXz1RHMIt55Y6AIxzmERwe
 mxSFN6pXxCyMquQs07UuDITUDNMQEPpP491kAfYO/etZgzBOkZ7hFA8/z+lSZeORwAFpzOrjklj
 mAFgvCOYuxkUDHgZAIBwd6RLnm1ZoZnJD13a59LCQm/X6beUfUTQcnNaHryTwfSD68QUh7HYI5P
 5T45v5qI+a+4NHrgt2YURKqsNpA1dwEGTCmceokv2gLUh2ZAW9dlPUPJ7Gho+I6IkxsJTb8KP9M
 Ky727LCqNUGyPaI/XUKGlcXGFLN2b9puMg+KZpF5kqUlASOjfqI1wHOQwDHQmYaVCubXig9IWg0
 mac2/QULltWrU/+OeLA9QHIKG21rywOQjm17ESVegnCvV8jXCkLD5u9pacL8=
X-Received: by 2002:a05:7300:8c2c:b0:304:6448:dfea with SMTP id
 5a478bee46e88-30c07076582mr3504241eec.33.1781911825338; 
 Fri, 19 Jun 2026 16:30:25 -0700 (PDT)
X-Received: by 2002:a05:7300:8c2c:b0:304:6448:dfea with SMTP id
 5a478bee46e88-30c07076582mr3504217eec.33.1781911824717; 
 Fri, 19 Jun 2026 16:30:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 48/74] target/hexagon: Implement hexagon_tlb_fill()
Date: Fri, 19 Jun 2026 15:58:45 -0700
Message-Id: <20260619225911.159473-49-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: rG3wJOdRauA-aBzml620QTPUIPzLRbB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXyuJ5/3gLF+VY
 SYtwdbcSWrYmM0xMv/Spm7TWU/xEp3ibe6tyicgKo9yzBNFEcPLgxzlYqG4KgH9ijrApMvd827s
 p00R5JxIBSIt5RCKDplbnH2g9ubYKYgn4ZWyX76KWnavc0jymtS4aCiWMolJ1Zkj9lIwIjd5F6Z
 M72oHrCqL/K6Vk0NmTBnjq04gR7kQvFR3lWbBbFx9owOr+dFqRkZ9j78rZ39BFCm8c+ZFz4FyS4
 z9KJl4IfP74HZZyKS5ruL8vKe0OA1rOluAGu/MTdqWiXdnWBQv708wprfRfGGctM4ESkkCtiowh
 zn8wh/wxbdHg73q7w76Ifu3fTF6RzHSRQY+SiQSbKzPTyIvNaGcD1jrJDPRRmnIubLRdXZsE9p/
 c4KJvB1k8+sKjSCkt/tzdzWvHi7rMXovAptovtMDzpIZRrt45SEr6k1OPRpJlbDcZfbydOhVzCK
 gMaUtB6LWqx1NeTKDnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX8Xj3gwz7SNqO
 c9ucAVJVfe5fEOCBP+wE3FAwOAF6p6/nYJWUribHE04Oca15aoOQuDurshhVuy8ScL69mY1biR6
 Py8NeTLYQc1vJns8D2JcskHGJsNXFYk=
X-Proofpoint-GUID: rG3wJOdRauA-aBzml620QTPUIPzLRbB9
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d112 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yz7b9sy1sBSXNk6fZdQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMTM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZWRkZTRiMWRiODQuLjRlNWEy
NTc0NGExIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuYwpAQCAtMzgsNiArMzgsOSBAQAogI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgi
CiAjaW5jbHVkZSAiaGV4X2ludGVycnVwdHMuaCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1
cHQuaCIKKyNpbmNsdWRlICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIgorI2luY2x1ZGUgImV4ZWMv
dGFyZ2V0X3BhZ2UuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgi
CiAjZW5kaWYKIAogc3RhdGljIE9iamVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1l
KGNvbnN0IGNoYXIgKmNwdV9tb2RlbCkKQEAgLTQ3NSw2ICs0NzgsMTM4IEBAIHN0YXRpYyB2b2lk
IGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpvYmopCiB9CiAKICNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQorc3RhdGljIGJvb2wgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIGh3YWRkciAqcGh5cywgaW50ICpwcm90LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgKnNpemUsIGludDMyX3QgKmV4Y3AsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBhZGRyZXNzLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1tdV9pZHgpCisKK3sKKyAg
ICBpZiAoaGV4YWdvbl9jcHVfbW11X2VuYWJsZWQoZW52KSkgeworICAgICAgICByZXR1cm4gaGV4
X3RsYl9maW5kX21hdGNoKGVudiwgYWRkcmVzcywgYWNjZXNzX3R5cGUsIHBoeXMsIHByb3QsIHNp
emUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhjcCwgbW11X2lkeCk7Cisg
ICAgfSBlbHNlIHsKKyAgICAgICAgKnBoeXMgPSBhZGRyZXNzICYgMHhGRkZGRkZGRjsKKyAgICAg
ICAgKnByb3QgPSBQQUdFX1ZBTElEIHwgUEFHRV9SRUFEIHwgUEFHRV9XUklURSB8IFBBR0VfRVhF
QzsKKyAgICAgICAgKnNpemUgPSBUQVJHRVRfUEFHRV9TSVpFOworICAgICAgICByZXR1cm4gdHJ1
ZTsKKyAgICB9Cit9CisKKy8qIHFlbXUgc2VlbXMgdG8gb25seSB3YW50IHRvIGtub3cgYWJvdXQg
VEFSR0VUX1BBR0VfU0laRSBwYWdlcyAqLworc3RhdGljIHZvaWQgZmluZF9xZW11X3N1YnBhZ2Uo
dmFkZHIgKmFkZHIsIGh3YWRkciAqcGh5cywgdWludDY0X3QgcGFnZV9zaXplKQoreworICAgIHZh
ZGRyIHBhZ2Vfc3RhcnQgPSAqYWRkciAmIH4oKHZhZGRyKShwYWdlX3NpemUgLSAxKSk7CisgICAg
dmFkZHIgb2Zmc2V0ID0gKCgqYWRkciAtIHBhZ2Vfc3RhcnQpIC8gVEFSR0VUX1BBR0VfU0laRSkg
KiBUQVJHRVRfUEFHRV9TSVpFOworICAgICphZGRyID0gcGFnZV9zdGFydCArIG9mZnNldDsKKyAg
ICAqcGh5cyArPSBvZmZzZXQ7Cit9CisKKworI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJh
ZGEKKworc3RhdGljIHZvaWQgc2V0X2JhZHZhX3JlZ3MoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IFZBLCBpbnQgc2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vz
c1R5cGUgYWNjZXNzX3R5cGUpCit7CisgICAgZW52LT50X3NyZWdbSEVYX1NSRUdfQkFEVkFdID0g
VkE7CisKKyAgICBpZiAoYWNjZXNzX3R5cGUgPT0gTU1VX0lOU1RfRkVUQ0ggfHwgc2xvdCA9PSAw
KSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JBRFZBMF0gPSBWQTsKKyAgICAgICAg
ZW52LT50X3NyZWdbSEVYX1NSRUdfQkFEVkExXSA9IElOVkFMSURfQkFEVkE7CisgICAgICAgIFNF
VF9TU1JfRklFTEQoZW52LCBTU1JfVjAsIDEpOworICAgICAgICBTRVRfU1NSX0ZJRUxEKGVudiwg
U1NSX1YxLCAwKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9CVlMsIDApOworICAg
IH0gZWxzZSBpZiAoc2xvdCA9PSAxKSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JB
RFZBMF0gPSBJTlZBTElEX0JBRFZBOworICAgICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19CQURW
QTFdID0gVkE7CisgICAgICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfVjAsIDApOworICAgICAg
ICBTRVRfU1NSX0ZJRUxEKGVudiwgU1NSX1YxLCAxKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChl
bnYsIFNTUl9CVlMsIDEpOworICAgIH0gZWxzZSB7CisgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFj
aGVkKCk7CisgICAgfQorfQorCitzdGF0aWMgdm9pZCByYWlzZV90bGJtaXNzX2V4Y2VwdGlvbihD
UFVTdGF0ZSAqY3MsIHVpbnQzMl90IFZBLCBpbnQgc2xvdCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUpCit7CisgICAgQ1BVSGV4
YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKworICAgIHNldF9iYWR2YV9yZWdzKGVudiwg
VkEsIHNsb3QsIGFjY2Vzc190eXBlKTsKKworICAgIHN3aXRjaCAoYWNjZXNzX3R5cGUpIHsKKyAg
ICBjYXNlIE1NVV9JTlNUX0ZFVENIOgorICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVY
X0VWRU5UX1RMQl9NSVNTX1g7CisgICAgICAgIGlmICgoVkEgJiB+VEFSR0VUX1BBR0VfTUFTSykg
PT0gMCkgeworICAgICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1JU1NY
X0NBVVNFX05FWFRQQUdFOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgZW52LT5jYXVz
ZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1JU1NYX0NBVVNFX05PUk1BTDsKKyAgICAgICAgfQorICAg
ICAgICBicmVhazsKKyAgICBjYXNlIE1NVV9EQVRBX0xPQUQ6CisgICAgICAgIGNzLT5leGNlcHRp
b25faW5kZXggPSBIRVhfRVZFTlRfVExCX01JU1NfUlc7CisgICAgICAgIGVudi0+Y2F1c2VfY29k
ZSA9IEhFWF9DQVVTRV9UTEJNSVNTUldfQ0FVU0VfUkVBRDsKKyAgICAgICAgYnJlYWs7CisgICAg
Y2FzZSBNTVVfREFUQV9TVE9SRToKKyAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhFWF9F
VkVOVF9UTEJfTUlTU19SVzsKKyAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNFX1RM
Qk1JU1NSV19DQVVTRV9XUklURTsKKyAgICAgICAgYnJlYWs7CisgICAgfQorfQorCitzdGF0aWMg
dm9pZCByYWlzZV9wZXJtX2V4Y2VwdGlvbihDUFVTdGF0ZSAqY3MsIHVpbnQzMl90IFZBLCBpbnQg
c2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNj
ZXNzX3R5cGUsIGludDMyX3QgZXhjcCkKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNw
dV9lbnYoY3MpOworCisgICAgc2V0X2JhZHZhX3JlZ3MoZW52LCBWQSwgc2xvdCwgYWNjZXNzX3R5
cGUpOworICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNwOworfQorCitzdGF0aWMgY29uc3Qg
Y2hhciAqYWNjZXNzX3R5cGVfbmFtZXNbXSA9IHsgIk1NVV9EQVRBX0xPQUQgIiwgIk1NVV9EQVRB
X1NUT1JFIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTU1V
X0lOU1RfRkVUQ0giIH07CisKK3N0YXRpYyBjb25zdCBjaGFyICptbXVfaWR4X25hbWVzW10gPSB7
ICJNTVVfVVNFUl9JRFgiLCAiTU1VX0dVRVNUX0lEWCIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiTU1VX0tFUk5FTF9JRFgiIH07CisKK3N0YXRpYyBib29sIGhleGFn
b25fdGxiX2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1t
dV9pZHgsIGJvb2wgcHJvYmUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCByZXRhZGRyKQoreworICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7Cisg
ICAgaW50IHNsb3QgPSAwOworICAgIGh3YWRkciBwaHlzOworICAgIGludCBwcm90ID0gMDsKKyAg
ICB1aW50NjRfdCBwYWdlX3NpemUgPSAwOworICAgIGludDMyX3QgZXhjcCA9IDA7CisgICAgYm9v
bCByZXQgPSAwOworCisgICAgcWVtdV9sb2dfbWFzaygKKyAgICAgICAgQ1BVX0xPR19NTVUsCisg
ICAgICAgICIlczogdGlkID0gMHglIiBQUkl4MzIgIiwgcGMgPSAweCUwOCIgUFJJeDMyCisgICAg
ICAgICIsIHZhZGRyID0gMHglMDgiIFZBRERSX1BSSXggIiwgc2l6ZSA9ICVkLCAlcyxcdHByb2Jl
ID0gJWQsICVzXG4iLAorICAgICAgICBfX2Z1bmNfXywgZW52LT50aHJlYWRJZCwgZW52LT5ncHJb
SEVYX1JFR19QQ10sIGFkZHJlc3MsIHNpemUsCisgICAgICAgIGFjY2Vzc190eXBlX25hbWVzW2Fj
Y2Vzc190eXBlXSwgcHJvYmUsIG1tdV9pZHhfbmFtZXNbbW11X2lkeF0pOworICAgIHJldCA9IGdl
dF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXMsICZwcm90LCAmcGFnZV9zaXplLCAmZXhjcCwg
YWRkcmVzcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3NfdHlwZSwgbW11
X2lkeCk7CisgICAgaWYgKHJldCkgeworICAgICAgICBpZiAoIWV4Y3ApIHsKKyAgICAgICAgICAg
IGZpbmRfcWVtdV9zdWJwYWdlKCZhZGRyZXNzLCAmcGh5cywgcGFnZV9zaXplKTsKKyAgICAgICAg
ICAgIHRsYl9zZXRfcGFnZShjcywgYWRkcmVzcywgcGh5cywgcHJvdCwgbW11X2lkeCwgVEFSR0VU
X1BBR0VfU0laRSk7CisgICAgICAgICAgICByZXR1cm4gcmV0OworICAgICAgICB9CisgICAgICAg
IGlmIChwcm9iZSkgeworICAgICAgICAgICAgcmV0dXJuIGZhbHNlOworICAgICAgICB9CisgICAg
ICAgIHJhaXNlX3Blcm1fZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nlc3NfdHlwZSwg
ZXhjcCk7CisgICAgICAgIGRvX3JhaXNlX2V4Y2VwdGlvbihlbnYsIGNzLT5leGNlcHRpb25faW5k
ZXgsIGVudi0+Z3ByW0hFWF9SRUdfUENdLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
YWRkcik7CisgICAgfQorICAgIGlmIChwcm9iZSkgeworICAgICAgICByZXR1cm4gZmFsc2U7Cisg
ICAgfQorICAgIHJhaXNlX3RsYm1pc3NfZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nl
c3NfdHlwZSk7CisgICAgZG9fcmFpc2VfZXhjZXB0aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRl
eCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIHJldGFkZHIpOworfQogCiBzdGF0aWMgYm9vbCBoZXhh
Z29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1cHRfcmVxdWVz
dCkKIHsKQEAgLTUxNyw2ICs2NTIsNyBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25f
dGNnX29wcyA9IHsKICAgICAuY3B1X2V4ZWNfaW50ZXJydXB0ID0gaGV4YWdvbl9jcHVfZXhlY19p
bnRlcnJ1cHQsCiAgICAgLnBvaW50ZXJfd3JhcCA9IGhleGFnb25fcG9pbnRlcl93cmFwLAogICAg
IC5jcHVfZXhlY19yZXNldCA9IGNwdV9yZXNldCwKKyAgICAudGxiX2ZpbGwgPSBoZXhhZ29uX3Rs
Yl9maWxsLAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEK
Cg==

