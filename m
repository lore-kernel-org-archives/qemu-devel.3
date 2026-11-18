Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90260A2614
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XH2nlPbV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aaGn4TJP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTjEj-0002KE-3Y; Wed, 18 Nov 2026 12:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTjEg-0002Jn-Gn
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:14:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTjEe-0002xD-UU
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:14:18 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIH3hW72421092
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjk6ZSimM3L7gL8P3PWuFyaXHgJLGifWygx8+zs0nng=; b=XH2nlPbV/G2mhY78
 FqGmfxML+cPzUrIpEmXjAQLGXyFZ3nhDhNz6JC1rfjWHeES8f8sbk6lKBUp08n0P
 6gkdiA3y3/R8F20EuSVm3dwKsX1LIbGcw/6w4rvJY9ith9KnuXcN56EW0286T7TK
 lpJoKpliPZuAOvRdV/MdqKd/aWnZ7NbJjRy0aTGk1o2LP0oSYKfrRWCAIDlWGSK9
 ujJFdvHADwGUQMwTJ3qSJLj5F1zLs5gFHJrA41edksbSBk3UewccXDd8wqYhX3Wo
 P4Y7Pzm4qi8r5gQcZB5gPNARhtRT6jCspKSIQcvhmoipggH3mK05FwKDC4gWcbjI
 gAh1Vw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3b81qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:14:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-383435e46f9so502900eec.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795022054; x=1795626854; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vjk6ZSimM3L7gL8P3PWuFyaXHgJLGifWygx8+zs0nng=;
 b=aaGn4TJPGzHKXRgb5PXFtwln9N91qKbAwHwp7kja8am9DWdjB8KLhyQr3G2ydQAILF
 zd5BNqCC9bcl0QxSv/9dk6DhzwS79ZfCDzZdEKtb2ELf2jIxUFY2Txc/UdrO1sPIZpvC
 +7JihB8A51XhfoZAFZg2oy7McbaCjXvDICwt0hEfHA5GO//Vw1x39BLRqrLcp4afb6Ch
 Ux1aawMHFYYhTf8ctw1cE8kb1rZSakO9eECXbXN5jcg1xN2iM6ieV8VKDpq0BubkS4h2
 +TtAfntjCuOqIHozr0TbNcMS9IoIZ7Pf5kDPKXpsbaKRPC2gyTR04nluobH5DC6IjHsX
 F1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022054; x=1795626854;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vjk6ZSimM3L7gL8P3PWuFyaXHgJLGifWygx8+zs0nng=;
 b=HSghsTKy63GXUt6jORi8lznPY2Z5/b1pmgppW1kv5LtnukB5qD47sIYxrHj7KbKd3r
 998oQZ0nMW+m8KMwFV+6RAmc8FO42sE86FYvk4nD9+pt+m8sy4tsyA1fghVZN98NhMwH
 vardBnnbQV3tbuaXQBzpa6LQ7dWaC3SXEC2Op0oOJOk8S9ozTNplpgTz1Pkf1/2QubZ9
 Ye5dSb6pTiW3jdv9zFHaJDKJMXd2TB+Mj+xt8sr/HUheLxzW/1D6E6NDNwa07OPLU1+Z
 DUcANIY7CwiVLI/bE1mj0a4W42vIpS+LHfSjfCQFp0hdRPXw3JA7GHOkXxaMBLH6cgG6
 9VPQ==
X-Gm-Message-State: APuU4Z/Aqrop6XE/OUjOk8UwyNxn3XyWiOGN1kXZaMLmGao57VD7D5gx
 9DqWOwjH8/msRiqFIPYF4O6ihDn0U4fcximEMEB/XzYqgirYHn6b86GLoWuksNCyiAmsyoRJU2/
 YP6EX6Y7VCGHIb73bhIrgSWIsyY5xpI/HmlIWVyRMTdwpJ95UdtMV5gdFIV2F9G+N8g==
X-Gm-Gg: AZFdTZeha/NCd8c4GjDL2MEpxKmLZ2iyfIIseAO9amtjMzPfvFw7ReU7SA+yr0FT0Ot
 BnLcpF2aCuu+69duFbDM5SxNB4xNwJFbGPoIezl3UsK83ADYbKxMWnELcgJiUJ9RqlBl/qsxoM5
 NUoEIpwwluYmVd3YJlc8+HOSt3QjOKImh6SGFaeB0y1dfdI3Ju8IeJ/4fmwA7zKygwRrj4Hqecf
 5PXTrh7wS2eUhaTVpdO6ktSVwEN1IvNaY6N6ya+KxTvTHa3xqpN7N+9Prys32EzI/PbQrk3JYtD
 IJuHPTJumao9NxUpB+2OmSMSIVtg/PZlbI/sLFVmD8bv1uRsjxdH32O54Fcq/bnnlaqgTxf31qN
 RBs0Q5s9kUTOwaMohfIViO/h6crDXrZRhIITZjQML/KqwSRv6plTAgtTVvgzkGnIGh31Awkgn/F
 YfPHlnRKN3Z6nP82FR2k3CDw==
X-Received: by 2002:a05:7301:460e:b0:37b:5343:2dd5 with SMTP id
 5a478bee46e88-382827ab891mr2744775eec.36.1795022054405; 
 Wed, 18 Nov 2026 09:14:14 -0800 (PST)
X-Received: by 2002:a05:7301:460e:b0:37b:5343:2dd5 with SMTP id
 5a478bee46e88-382827ab891mr2744751eec.36.1795022053720; 
 Wed, 18 Nov 2026 09:14:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72e52easm8900707eec.17.2026.11.18.09.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:14:12 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 1/2] roms: record the H2 commit in a file
Date: Wed, 18 Nov 2026 09:14:09 -0800
Message-Id: <20261118171410.3753915-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
References: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: cO8BpLov_ylYGtq1NfySrj4en8vIVXiS
X-Proofpoint-GUID: cO8BpLov_ylYGtq1NfySrj4en8vIVXiS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NyBTYWx0ZWRfX55+2zCIq8kHc
 wsrrhJj3h+/wj5yyb+WBaDxJhARQ8ebrZsBH3w4LDoX8pNJ1V4VTzd0WZUhHe+QHEC92SHpnFPa
 KY0ByQNN+ekqTMkYsKOKt32nqnwdAJM=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afddce7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6TPXupxyv9tJbjdrH94A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NyBTYWx0ZWRfX8B/3jnjhyAIm
 aZZB3ym58MNYFnAz4y3EsvN/gEM0uKBAF0JdDVqD9prriBz31AxUwdnQ5IlCSd+WECewKDwD7Qi
 wDPwRcrISCOqrFsw6B8cOh3nBSfLQemgQBQmhH/V+2KLPi33MTHScWiWxJx0n00g652cLZilanT
 LBmovK2eUssId/HYx7bpT2MfUd7xYwckpzFBZzdzvwwNupaSkYwLpjcgFTRDhhMNZj1qB/XZtl+
 LGSUshR2ngSQKWuz0l4IBIIc/NO+LE2uVGFk22VQS1LxQ6JQ0p+8Ru7XpMHeqpqDErvUxViYiMS
 OpPcbi1nvTfqKkwhJ8ymI0U1zwnV1ljm/S+kNUmgWrRMrPg+wQYyjhtcPyg3bzTWPLVb3kg8KOD
 4F7n4yHoOctsVNqeRhWRLJVcHGFavqjPh4zcXIO+AdASWD3HxkmlS2xxdNphj6SegOneDTVRBwz
 ictzcooEa4MGgIoVr2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180067
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIEgyIGJ1aWxkIElEIHdhcyBkZXJpdmVkIGJ5IHJ1bm5pbmcgYGdpdCByZXYtcGFyc2VgLCB3
aGljaCBmYWlscyB3aGVuCmJ1aWxkaW5nIGZyb20gYSBzb3VyY2UgdGFyYmFsbC4gIExlYXZpbmcg
SDJLX0dJVF9DT01NSVQgYXMgIjB4IiBkb2VzCm5vdCBjb21waWxlLgoKSW5zdGVhZCwga2VlcCB0
aGUgY29tbWl0IGluIGEgdHJhY2tlZCBmaWxlIGFuZCBhbHdheXMgYnVpbGQgZnJvbSBpdC4KV2hl
biB0aGUgc3VibW9kdWxlIGlzIGNoZWNrZWQgb3V0LCBmYWlsIHRoZSBIMiBidWlsZCBpZiBpdHMg
SEVBRCBkb2VzCm5vdCBtYXRjaCB0aGUgcmVjb3JkZWQgY29tbWl0LCBzbyBhIHN1Ym1vZHVsZSB1
cGRhdGUgd2l0aG91dCBhIG1hdGNoaW5nCnVwZGF0ZSBvZiB0aGUgZmlsZSBpcyBjYXVnaHQuCgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHJvbXMvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKystLS0tCiByb21zL2hleGFn
b24taHlwZXJ2aXNvci12ZXJzaW9uIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHJvbXMvaGV4YWdvbi1o
eXBlcnZpc29yLXZlcnNpb24KCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
CmluZGV4IDE1OTQyYWFiYTNhLi5jNmVkMzQ2OTc3OSAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMK
KysrIGIvTUFJTlRBSU5FUlMKQEAgLTE0MDAsNiArMTQwMCw3IEBAIEY6IHRlc3RzL3F0ZXN0L3Fj
b20tZHNwLXRlc3QuYwogRjogZG9jcy9kZXZlbC9oZXhhZ29uLXN5cy5yc3QKIEY6IHBjLWJpb3Mv
aGV4YWdvbioKIEY6IHJvbXMvaGV4YWdvbi1oeXBlcnZpc29yCitGOiByb21zL2hleGFnb24taHlw
ZXJ2aXNvci12ZXJzaW9uCiAKIExvb25nQXJjaCBNYWNoaW5lcwogLS0tLS0tLS0tLS0tLS0tLS0t
CmRpZmYgLS1naXQgYS9yb21zL01ha2VmaWxlIGIvcm9tcy9NYWtlZmlsZQppbmRleCBiYWU4ZjNi
NzY2Yi4uYmNkZTY4MzU4NTEgMTAwNjQ0Ci0tLSBhL3JvbXMvTWFrZWZpbGUKKysrIGIvcm9tcy9N
YWtlZmlsZQpAQCAtMjI2LDExICsyMjYsMjUgQEAgaGV4YWdvbl9oMl9ib290ZXJzIDo9IGhleGFn
b24tYm9vdGVyLXFjczY0OTAtY2RzcCBcCiBoZXhhZ29uX2gyX2xvYWRsaW51eCA6PSBoZXhhZ29u
LWxvYWRsaW51eC1xY3M2NDkwLWNkc3AgXAogCWhleGFnb24tbG9hZGxpbnV4LXNtODk3NS1uc3Ag
aGV4YWdvbi1sb2FkbGludXgtc2E4Nzc1cC1jZHNwIFwKIAloZXhhZ29uLWxvYWRsaW51eC1zYzg0
ODB4cC1uc3AwIGhleGFnb24tbG9hZGxpbnV4LXNhODc5N3AtbnNwMAoraW5jbHVkZSBoZXhhZ29u
LWh5cGVydmlzb3ItdmVyc2lvbgorCisuUEhPTlk6IGhleGFnb24taHlwZXJ2aXNvci1jaGVjawor
aGV4YWdvbi1oeXBlcnZpc29yLWNoZWNrOgorCUBpZiB0ZXN0IC1lIGhleGFnb24taHlwZXJ2aXNv
ci8uZ2l0OyB0aGVuIFwKKwkJaDJfaGVhZD0kJChnaXQgLUMgaGV4YWdvbi1oeXBlcnZpc29yIHJl
di1wYXJzZSBIRUFEKTsgXAorCQlpZiB0ZXN0ICIkJGgyX2hlYWQiICE9ICIkKEgyS19DT01NSVQp
IjsgdGhlbiBcCisJCQllY2hvICJoZXhhZ29uLWh5cGVydmlzb3IgaXMgYXQgJCRoMl9oZWFkLCBi
dXQiIFwKKwkJCQkicm9tcy9oZXhhZ29uLWh5cGVydmlzb3ItdmVyc2lvbiBoYXMiIFwKKwkJCQki
JChIMktfQ09NTUlUKSIgPiYyOyBcCisJCQlleGl0IDE7IFwKKwkJZmk7IFwKKwlmaQorCiBoZXhh
Z29uX2gyX2NvbW1vbl9mbGFncyA9IFVTRV9QS1c9MCBUQVJHRVQ9b3B0IE5VTExfQU5HRUxfVFJB
UD0xIFwKIAlITVhfSExYX1NVUFBPUlQ9MSBcCiAJSDJLX0xPQURfQUREUj0weDliODAwMDAwIEgy
S19HVUVTVF9TVEFSVD0weGEyMDAwMDAwIFwKLQlIMktfR0lUX0NPTU1JVD0weCQoc2hlbGwgZ2l0
IC1DIGhleGFnb24taHlwZXJ2aXNvciByZXYtcGFyc2UgLS1zaG9ydD04IEhFQUQpIFwKLQlIMktf
R0lUX0NPTU1JVF9MT05HPTB4JChzaGVsbCBnaXQgLUMgaGV4YWdvbi1oeXBlcnZpc29yIHJldi1w
YXJzZSBIRUFEKSBcCisJSDJLX0dJVF9DT01NSVQ9MHgkKHNoZWxsIGVjaG8gJChIMktfQ09NTUlU
KSB8IGN1dCAtYzEtOCkgXAorCUgyS19HSVRfQ09NTUlUX0xPTkc9MHgkKEgyS19DT01NSVQpIFwK
IAlKRkxBRz0taiQoc2hlbGwgbnByb2MpCiAKIC5QSE9OWTogaGV4YWdvbi1xY3M2NDkwLWNkc3Ag
aGV4YWdvbi1zbTg5NzUtbnNwIFwKQEAgLTI2NCw3ICsyNzgsNyBAQCBoZXhhZ29uLWxvYWRsaW51
eC1zbTg5NzUtbnNwIGhleGFnb24tbG9hZGxpbnV4LXNhODc3NXAtY2RzcCBcCiAJaGV4YWdvbi1s
b2FkbGludXgtc2M4NDgweHAtbnNwMCBoZXhhZ29uLWxvYWRsaW51eC1zYTg3OTdwLW5zcDA6IFwK
IAloZXhhZ29uX2gyX2xpbnV4X2ZsYWdzID0gTElOVVhfTElOS19BRERSPTB4YTAwMDAwMDAKIAot
JChoZXhhZ29uX2gyX2Jvb3RlcnMpOiBoZXhhZ29uLWJvb3Rlci0lOgorJChoZXhhZ29uX2gyX2Jv
b3RlcnMpOiBoZXhhZ29uLWJvb3Rlci0lOiBoZXhhZ29uLWh5cGVydmlzb3ItY2hlY2sKIAlybSAt
cmYgJChoZXhhZ29uX2gyX291dCkvYm9vdGVyLSQqCiAJJChNQUtFKSAtQyBoZXhhZ29uLWh5cGVy
dmlzb3IgJChoZXhhZ29uX2gyX2NvbW1vbl9mbGFncykgXAogCQkkKGhleGFnb25faDJfbWFjaGlu
ZV9mbGFncykgXApAQCAtMjczLDcgKzI4Nyw3IEBAICQoaGV4YWdvbl9oMl9ib290ZXJzKTogaGV4
YWdvbi1ib290ZXItJToKIAkJJChoZXhhZ29uX2gyX2J1aWxkKS9ib290ZXItJCovaW5zdGFsbC9i
aW4vYm9vdGVyCiAJY2htb2QgLXggLi4vcGMtYmlvcy9oZXhhZ29uX2Jvb3Rlcl8kKHN1YnN0IC0s
XywkKikKIAotJChoZXhhZ29uX2gyX2xvYWRsaW51eCk6IGhleGFnb24tbG9hZGxpbnV4LSU6Cisk
KGhleGFnb25faDJfbG9hZGxpbnV4KTogaGV4YWdvbi1sb2FkbGludXgtJTogaGV4YWdvbi1oeXBl
cnZpc29yLWNoZWNrCiAJcm0gLXJmICQoaGV4YWdvbl9oMl9vdXQpL2xvYWRsaW51eC0kKgogCSQo
TUFLRSkgLUMgaGV4YWdvbi1oeXBlcnZpc29yICQoaGV4YWdvbl9oMl9jb21tb25fZmxhZ3MpIFwK
IAkJJChoZXhhZ29uX2gyX21hY2hpbmVfZmxhZ3MpIFwKZGlmZiAtLWdpdCBhL3JvbXMvaGV4YWdv
bi1oeXBlcnZpc29yLXZlcnNpb24gYi9yb21zL2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9uCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40YWVhYmRjN2QwZQotLS0gL2Rl
di9udWxsCisrKyBiL3JvbXMvaGV4YWdvbi1oeXBlcnZpc29yLXZlcnNpb24KQEAgLTAsMCArMSBA
QAorSDJLX0NPTU1JVCA9IDIzZDViZGU0MzEzYzFlNjNiYTY0ZGQ1ZDdmNTQyYjEwNTUxODhlZjgK
LS0gCjIuMzQuMQoK

