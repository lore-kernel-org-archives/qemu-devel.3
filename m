Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B27C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJp-0000fi-LY; Sun, 05 May 2024 22:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJn-0000eH-GB
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:43:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJl-0007Xh-EX
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:43:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4461FEGj019022;
 Mon, 6 May 2024 02:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=xTHNdKjaMcNyFVIFGPK9K3KoKTJVMZ8U6p2D1jnpYPo=; b=Kr
 2T1Sa/su8jS9Fm0GNhwZDSnP1K1gVAW9sBDw1SX7tOGQVmKUL9+yr9yphrlnJM7v
 C6GsKVYkx3FmRZ1Oy7Z+ENwAsEdpfJ7V6TQsrqdUkDrLrwyc9nshlXEFd1ZD1BXb
 Kq3haHz3L6BxbEa+EvXhdDvd8MnzOml+eFZ+o09wHh15yCx9Ka+P4h3ngDgHyxVg
 bXoj2B6hMqlrw/XIE7g1b7PqXeGPF/q/u72+rojjcWmFZO4CZnDKGCGlgq0prZl1
 9sobRwYgjPF74VMGfaiVLxcqT2vboHcVO6r2xIezXkZPca586Pd+gqkxPkZ429SR
 iBheCXa7T/sgTSmJ8s6w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcm4jgc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gqhH008423
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:52 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 19:42:51 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 14/15] Hexagon (target/hexagon) Remove gen_shortcode.py
Date: Sun, 5 May 2024 19:42:26 -0700
Message-ID: <20240506024227.3345791-15-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240506024227.3345791-1-bcain@quicinc.com>
References: <20240506024227.3345791-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 283RNpXXoOvMmCVwgQOCBYOp5zenrVcM
X-Proofpoint-GUID: 283RNpXXoOvMmCVwgQOCBYOp5zenrVcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060012
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClRoaXMgZGF0
YSBzdHJ1Y3R1cmUgaXMgbm90IHVzZWQKClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxs
dGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBx
dWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz4KTWVzc2FnZS1JZDogPDIwMjQwMzA3MDMyMzI3LjQ3OTktOS1sdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMu
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL1JFQURNRSAgICAgICAgICAgfCAgMSAtCiB0YXJnZXQv
aGV4YWdvbi9nZW5fc2hvcnRjb2RlLnB5IHwgNjMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwgMTAgLS0tLS0tCiB0YXJn
ZXQvaGV4YWdvbi9vcGNvZGVzLmMgICAgICAgIHwgIDcgLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCA4
MSBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEwMDc1NSB0YXJnZXQvaGV4YWdvbi9nZW5fc2hv
cnRjb2RlLnB5CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vUkVBRE1FIGIvdGFyZ2V0L2hl
eGFnb24vUkVBRE1FCmluZGV4IDIyNGEzZjkyMDYuLjdmZmQ1MTdkNzAgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL1JFQURNRQorKysgYi90YXJnZXQvaGV4YWdvbi9SRUFETUUKQEAgLTQ2LDcg
KzQ2LDYgQEAgaGVhZGVyIGZpbGVzIGluIDxCVUlMRF9ESVI+L3RhcmdldC9oZXhhZ29uCiAgICAg
ICAgIGdlbl9wcmludGluc24ucHkgICAgICAgICAgICAgICAgLT4gcHJpbnRpbnNuX2dlbmVyYXRl
ZC5oLmluYwogICAgICAgICBnZW5fb3BfYXR0cmlicy5weSAgICAgICAgICAgICAgIC0+IG9wX2F0
dHJpYnNfZ2VuZXJhdGVkLmguaW5jCiAgICAgICAgIGdlbl9oZWxwZXJfcHJvdG9zLnB5ICAgICAg
ICAgICAgLT4gaGVscGVyX3Byb3Rvc19nZW5lcmF0ZWQuaC5pbmMKLSAgICAgICAgZ2VuX3Nob3J0
Y29kZS5weSAgICAgICAgICAgICAgICAtPiBzaG9ydGNvZGVfZ2VuZXJhdGVkLmguaW5jCiAgICAg
ICAgIGdlbl90Y2dfZnVuY3MucHkgICAgICAgICAgICAgICAgLT4gdGNnX2Z1bmNzX2dlbmVyYXRl
ZC5jLmluYwogICAgICAgICBnZW5fdGNnX2Z1bmNfdGFibGUucHkgICAgICAgICAgIC0+IHRjZ19m
dW5jX3RhYmxlX2dlbmVyYXRlZC5jLmluYwogICAgICAgICBnZW5faGVscGVyX2Z1bmNzLnB5ICAg
ICAgICAgICAgIC0+IGhlbHBlcl9mdW5jc19nZW5lcmF0ZWQuYy5pbmMKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2dlbl9zaG9ydGNvZGUucHkgYi90YXJnZXQvaGV4YWdvbi9nZW5fc2hvcnRj
b2RlLnB5CmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDc1NQppbmRleCBkZWI5NDQ0NmM0Li4wMDAwMDAw
MDAwCi0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl9zaG9ydGNvZGUucHkKKysrIC9kZXYvbnVsbApA
QCAtMSw2MyArMCwwIEBACi0jIS91c3IvYmluL2VudiBweXRob24zCi0KLSMjCi0jIyAgQ29weXJp
Z2h0KGMpIDIwMTktMjAyMyBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmln
aHRzIFJlc2VydmVkLgotIyMKLSMjICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91
IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQotIyMgIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Ci0jIyAg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGlj
ZW5zZSwgb3IKLSMjICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgotIyMKLSMj
ICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJl
IHVzZWZ1bCwKLSMjICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUg
aW1wbGllZCB3YXJyYW50eSBvZgotIyMgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKLSMjICBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgotIyMKLSMjICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQotIyMgIGFsb25nIHdpdGgg
dGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4u
Ci0jIwotCi1pbXBvcnQgc3lzCi1pbXBvcnQgcmUKLWltcG9ydCBzdHJpbmcKLWltcG9ydCBoZXhf
Y29tbW9uCi0KLQotZGVmIGdlbl9zaG9ydGNvZGUoZiwgdGFnKToKLSAgICBmLndyaXRlKGYiREVG
X1NIT1JUQ09ERSh7dGFnfSwge2hleF9jb21tb24uc2VtZGljdFt0YWddfSlcbiIpCi0KLQotZGVm
IG1haW4oKToKLSAgICBoZXhfY29tbW9uLnJlYWRfc2VtYW50aWNzX2ZpbGUoc3lzLmFyZ3ZbMV0p
Ci0gICAgaGV4X2NvbW1vbi5yZWFkX2F0dHJpYnNfZmlsZShzeXMuYXJndlsyXSkKLSAgICBoZXhf
Y29tbW9uLmNhbGN1bGF0ZV9hdHRyaWJzKCkKLSAgICB0YWdyZWdzID0gaGV4X2NvbW1vbi5nZXRf
dGFncmVncygpCi0gICAgdGFnaW1tcyA9IGhleF9jb21tb24uZ2V0X3RhZ2ltbXMoKQotCi0gICAg
d2l0aCBvcGVuKHN5cy5hcmd2WzNdLCAidyIpIGFzIGY6Ci0gICAgICAgIGYud3JpdGUoIiNpZm5k
ZWYgREVGX1NIT1JUQ09ERVxuIikKLSAgICAgICAgZi53cml0ZSgiI2RlZmluZSBERUZfU0hPUlRD
T0RFKFRBRyxTSE9SVENPREUpICAgIC8qIE5vdGhpbmcgKi9cbiIpCi0gICAgICAgIGYud3JpdGUo
IiNlbmRpZlxuIikKLQotICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoKLSAgICAg
ICAgICAgICMjIFNraXAgdGhlIHByaXYgaW5zdHJ1Y3Rpb25zCi0gICAgICAgICAgICBpZiAiQV9Q
UklWIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAgICAgICBjb250
aW51ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZ3Vlc3QgaW5zdHJ1Y3Rpb25zCi0gICAgICAg
ICAgICBpZiAiQV9HVUVTVCIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106Ci0gICAgICAg
ICAgICAgICAgY29udGludWUKLSAgICAgICAgICAgICMjIFNraXAgdGhlIGRpYWcgaW5zdHJ1Y3Rp
b25zCi0gICAgICAgICAgICBpZiB0YWcgPT0gIlk2X2RpYWciOgotICAgICAgICAgICAgICAgIGNv
bnRpbnVlCi0gICAgICAgICAgICBpZiB0YWcgPT0gIlk2X2RpYWcwIjoKLSAgICAgICAgICAgICAg
ICBjb250aW51ZQotICAgICAgICAgICAgaWYgdGFnID09ICJZNl9kaWFnMSI6Ci0gICAgICAgICAg
ICAgICAgY29udGludWUKLQotICAgICAgICAgICAgZ2VuX3Nob3J0Y29kZShmLCB0YWcpCi0KLSAg
ICAgICAgZi53cml0ZSgiI3VuZGVmIERFRl9TSE9SVENPREVcbiIpCi0KLQotaWYgX19uYW1lX18g
PT0gIl9fbWFpbl9fIjoKLSAgICBtYWluKCkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21l
c29uLmJ1aWxkIGIvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYjNhMDk0NGQzYi4u
OTg4ZTc0ODliYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIv
dGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTQyLDIxICs0MiwxMSBAQCBoZXhhZ29uX3Nz
LmFkZChzZW1hbnRpY3NfZ2VuZXJhdGVkKQogIwogIyBTdGVwIDIKICMgV2UgdXNlIFB5dGhvbiBz
Y3JpcHRzIHRvIGdlbmVyYXRlIHRoZSBmb2xsb3dpbmcgZmlsZXMKLSMgICAgIHNob3J0Y29kZV9n
ZW5lcmF0ZWQuaC5pbmMKICMgICAgIHRjZ19mdW5jX3RhYmxlX2dlbmVyYXRlZC5jLmluYwogIyAg
ICAgcHJpbnRpbnNuX2dlbmVyYXRlZC5oLmluYwogIyAgICAgb3BfYXR0cmlic19nZW5lcmF0ZWQu
aC5pbmMKICMgICAgIG9wY29kZXNfZGVmX2dlbmVyYXRlZC5oLmluYwogIwotc2hvcnRjb2RlX2dl
bmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCi0gICAgJ3Nob3J0Y29kZV9nZW5lcmF0ZWQuaC5pbmMn
LAotICAgIG91dHB1dDogJ3Nob3J0Y29kZV9nZW5lcmF0ZWQuaC5pbmMnLAotICAgIGRlcGVuZHM6
IFtzZW1hbnRpY3NfZ2VuZXJhdGVkXSwKLSAgICBkZXBlbmRfZmlsZXM6IFtoZXhfY29tbW9uX3B5
LCBhdHRyaWJzX2RlZl0sCi0gICAgY29tbWFuZDogW3B5dGhvbiwgZmlsZXMoJ2dlbl9zaG9ydGNv
ZGUucHknKSwgc2VtYW50aWNzX2dlbmVyYXRlZCwgYXR0cmlic19kZWYsICdAT1VUUFVUQCddLAot
KQotaGV4YWdvbl9zcy5hZGQoc2hvcnRjb2RlX2dlbmVyYXRlZCkKLQogdGNnX2Z1bmNfdGFibGVf
Z2VuZXJhdGVkID0gY3VzdG9tX3RhcmdldCgKICAgICAndGNnX2Z1bmNfdGFibGVfZ2VuZXJhdGVk
LmMuaW5jJywKICAgICBvdXRwdXQ6ICd0Y2dfZnVuY190YWJsZV9nZW5lcmF0ZWQuYy5pbmMnLApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3Bjb2Rlcy5jIGIvdGFyZ2V0L2hleGFnb24vb3Bj
b2Rlcy5jCmluZGV4IDAyYWU5Y2Y3ODcuLmM4YmRlMmY5ZTkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL29wY29kZXMuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcGNvZGVzLmMKQEAgLTM3LDEz
ICszNyw2IEBAIGNvbnN0IGNoYXIgKiBjb25zdCBvcGNvZGVfbmFtZXNbXSA9IHsKIH07CiAKIAot
Y29uc3QgY2hhciAqIGNvbnN0IG9wY29kZV9zaG9ydF9zZW1hbnRpY3NbXSA9IHsKLSNkZWZpbmUg
REVGX1NIT1JUQ09ERShUQUcsIFNIT1JUQ09ERSkgICAgICAgICAgICAgIFtUQUddID0gI1NIT1JU
Q09ERSwKLSNpbmNsdWRlICJzaG9ydGNvZGVfZ2VuZXJhdGVkLmguaW5jIgotI3VuZGVmIERFRl9T
SE9SVENPREUKLSAgICBOVUxMCi19OwotCiBERUNMQVJFX0JJVE1BUChvcGNvZGVfYXR0cmlic1tY
WF9MQVNUX09QQ09ERV0sIEFfWlpfTEFTVEFUVFJJQik7CiAKIHN0YXRpYyB2b2lkIGluaXRfYXR0
cmlicyhpbnQgdGFnLCAuLi4pCi0tIAoyLjI1LjEKCg==

