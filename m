Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABD7CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig4-0004DZ-Su; Fri, 19 Jun 2026 19:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifx-00049M-0e
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifv-0007Yk-0N
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYRUw1628731
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=2D1KK2ftdD1qqMY51HqNdBRbUzmKNkoIdyCDzlZ8KkY=; b=NT
 xFnjpUrVawOKmlaMHSKFGBROzuyyETPp96uwdj/ZXY/FEMt5JLayQFRWeVkje4LA
 XsbxgQQBql57fK6QYKLRPgf+C16LjQsnrHfzKInnjMe8cvC8cAQ3tJXIVzHrAzxT
 ZWtxd0YHFQWys93n6GdK56tBtXrgLAp8DpJA5LTBoxmYObocSqf2RHwnIYzezV6p
 ecgL4p6R2wgVUr7gVJxAXMev1z8sx9TUUH9GMRe2RRhNUMxFqxdmSVw36rlvbkc0
 BkqyHdPdOpraFu728qscY5d3gZ43oKLzi/mjuVei5+Eak859jmmj3OzLx+Z6JgWW
 LunDFig6UFRA0PEwUMLA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evpyuw1us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:31:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0f4950ceso1010419eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911861; x=1782516661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D1KK2ftdD1qqMY51HqNdBRbUzmKNkoIdyCDzlZ8KkY=;
 b=Gu/KzQZp5dofsSuc1lxq5NdVnQZmaxowSelhm+Boit7curVNnTGVkhRVM22stu93HN
 +crz8p7YN0VC71+v2QJVoPoqwBIpSp2ts6ytV0+BuzBJnNvC0F9UVB9KL5Qg8r0HqGy7
 FTlSWK0MBH+mIyY7VK7ANLhWAYuzHBbKjw/etIjpx6ooglWLKLMcMuq4qGUwDMDy0vju
 LGGw1HIFi5qsOK4z9tEU5uZVBqPEXcIYvcQf0NkG4uVQa4idRfQpzGetNcpNHTWuA0WJ
 vlnT+eSM/GHoeOoZFhb4NLmISMvxCOTW5PJVuK9UPnJJWVj6AUgFFOcgR7zb+DX0jIpt
 G2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911861; x=1782516661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2D1KK2ftdD1qqMY51HqNdBRbUzmKNkoIdyCDzlZ8KkY=;
 b=Z3wCGRbWRhnNBbi7YE5hR95sHsln5Ldbv5caknUfqPPLWILSuhMckhF8pPzdyiPKOw
 BLzijvPv3EinFX1vY7amZ+xB0KNTxT/OKSs7w0kWHUzrZMd68MC2g3RKBmMqBcC58IbA
 RbilcA83Pt2g1tIMH+9o7cj2koKKj+l69trBny4LGxSFwNmkSyq8RUHv7+xN7/AIDSvm
 3GmDL78DIOtDa6sQ4CJwcaQjXzO7lWKYz7/3dUBZdr4C/eH0TA2PGElUipJ9PENlVnGK
 liCMkuRcFCgbF370ubexRN2dFzOE8f7v5pCrsOVAt0vfQTJKOidqghID9gVvHp7bs8sl
 u/MQ==
X-Gm-Message-State: AOJu0YyLJ7RcI6kTTYI8ER0ZbC9ggn83i5O00qE5C7xUugfg0Qj3E69M
 i4Bbce9a3SN5LGRywmtSYR9MujiQGdQTUCAhMcZ+KVYskKaaskhXW7KAsNPcCph0dkevUzqc1zY
 +H72miFh7tKeL/991ao4oRFk1Y5PAmdRyEKPRvn1pC/Lyp5D0ZVjLKlUuDpZuDV2skA==
X-Gm-Gg: AfdE7clyKOePmeweTbkaJO9asbAd8YGpVgAQ1KLTPGmZb6Z7QxU4BJQzVll4C75BzKm
 KEQ0csberPDEivGJlddlxF2WuRTmObdL+S3aMHO2VUAry/Cbqn0rIgDFAUT4eHzaQuJySiHCJdX
 83lzsDYQ29JiksH/cIM/4ks0cpce9gbLkYnzPqgyljse9Rb7FsN8y+lAJ+Pa8nxkpEDU3+g275h
 /NX8vQius18uPUyrteZzQwgz1MJSC8JM5qQzkKXcxrImvmOqkuO7Mql8ng/75G+4Ma2Lx5yOyol
 6/3JlLkoT4R4JMkNvfgPiG7sEXpBQYmHoOdyHtDjEG7WvAxW1p41R6Iye5T9VQArO84pmBQOFgU
 DAVMmNqNs5OyQ+uCny+VJcm3rSPk5VbW19cNc5pInLo3oFLZZx9O3oHW6Mn4=
X-Received: by 2002:a05:7300:fb91:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-30c06d4b520mr3653058eec.7.1781911860974; 
 Fri, 19 Jun 2026 16:31:00 -0700 (PDT)
X-Received: by 2002:a05:7300:fb91:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-30c06d4b520mr3653044eec.7.1781911860388; 
 Fri, 19 Jun 2026 16:31:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL 74/74] target/hexagon/idef-parser: open input file in binary
 mode
Date: Fri, 19 Jun 2026 15:59:11 -0700
Message-Id: <20260619225911.159473-75-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXylisx4KNyQfq
 NvsPqjgvAHam5yhCgeBIVfG+g5/0ybHi2JJ5SmoZbNP81xjT+P2pXldykH76q5jARF9TyosPy5q
 FbRRBtPh4RWcHVJgqI5VkJ5wMSIxRXI=
X-Proofpoint-GUID: sWeBfO3BTjzmr0ktZlQhpZg576z1SeDP
X-Proofpoint-ORIG-GUID: sWeBfO3BTjzmr0ktZlQhpZg576z1SeDP
X-Authority-Analysis: v=2.4 cv=cY3iaHDM c=1 sm=1 tr=0 ts=6a35d136 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XwlTJ2-QRR3pk5tWCfYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXx31JG2dIQzoL
 iIXWKOOUR78vqEIr7ijr6IL3M2+gVdwmh4AEOwqzBYVvSrclKWztTJDN4PmNcF/oPUcVwGIijGi
 hF3IoeA1ccAGzI8GEwb0fG/Ip9a1H8AT2tfsmVxcrYHztkcr+nsdUr7JEshKrHXP0R4ydY4pg3u
 jMWuKK32nSZfs8aYmdqJmNoUSPf+rcZUHJIzK3np71aI49xeEO4T1UsR9z04J5Jygy3ozbJUqpJ
 CgAc7gzSrdoBsajLObUEQhDuRlf84JORGA2loUPDrhadrXA5tNUbYK32IfF3ExeoCsjcrTAr0UO
 I1LrlPHYW8nEesVG1Hgd2FWaYPzrDhIzQXcpvcjPFsEXUz3mKxEqMfChjDsCl0osxhuWXNl+IBx
 eZdMKUeReRHhMQgsYshoG6t3hR+CucvdfRl14MLD7u9/GHAMyC8qiVHMKm9dFCi4Cu+1u6cTlNQ
 3lKROrSMBWexdINfJPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

T24gV2luZG93cywgb3BlbmluZyBhIGZpbGUgaW4gdGV4dCBtb2RlIGNhdXNlcyBmcmVhZCgpIHRv
IHJldHVybiBmZXdlcgpieXRlcyB0aGFuIGZ0ZWxsKCkgcmVwb3J0ZWQsIGJlY2F1c2UgQ1JMRiBz
ZXF1ZW5jZXMgYXJlIHRyYW5zbGF0ZWQgdG8KTEYgb24gcmVhZC4gIFRoaXMgY2F1c2VzIGlkZWYt
cGFyc2VyIHRvIHJlcG9ydCBhbiBlcnJvciBhbmQgYWJvcnQuCgpPcGVuIHRoZSBpbnB1dCBmaWxl
IGluIGJpbmFyeSBtb2RlICgicmIiKSBzbyB0aGF0IGZ0ZWxsKCkgYW5kIGZyZWFkKCkKYWdyZWUg
b24gdGhlIGZpbGUgc2l6ZSBhY3Jvc3MgYWxsIHBsYXRmb3Jtcy4KClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55IHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueSBiL3RhcmdldC9oZXhhZ29uL2lk
ZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKaW5kZXggMjIwNzBkOGMzZmUuLjNjZmZhZmE1Yjc2IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CisrKyBi
L3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKQEAgLTg3Miw3ICs4NzIs
NyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgY29udGV4dC5oZWFkZXJf
c3RyID0gZ19zdHJpbmdfbmV3KE5VTEwpOwogICAgIGNvbnRleHQudGVybmFyeSA9IGdfYXJyYXlf
bmV3KEZBTFNFLCBUUlVFLCBzaXplb2YoVGVybmFyeSkpOwogICAgIC8qIFJlYWQgaW5wdXQgZmls
ZSAqLwotICAgIEZJTEUgKmlucHV0X2ZpbGUgPSBmb3Blbihhcmd2W0FSR19JTkRFWF9JREVGU10s
ICJyIik7CisgICAgRklMRSAqaW5wdXRfZmlsZSA9IGZvcGVuKGFyZ3ZbQVJHX0lOREVYX0lERUZT
XSwgInJiIik7CiAgICAgZnNlZWsoaW5wdXRfZmlsZSwgMEwsIFNFRUtfRU5EKTsKICAgICBsb25n
IGlucHV0X3NpemUgPSBmdGVsbChpbnB1dF9maWxlKTsKICAgICBjb250ZXh0LmlucHV0X2J1ZmZl
ciA9IChjaGFyICopIGNhbGxvYyhpbnB1dF9zaXplICsgMSwgc2l6ZW9mKGNoYXIpKTsKLS0gCjIu
MzQuMQoK

