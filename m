Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8BFC55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphl-0002r7-1w; Thu, 06 Aug 2026 00:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphf-0002q0-Dh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphd-0003CX-A2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbDZu267108
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tOukWTJNy11ihKe0HGTFZQymqy/N77aZU0OGWHRrnP0=; b=XlJGOqvOvCx1HhMO
 lPWKlO9JVnwp9kfCkSnXkPKkFITsfTpFJi+Xb9R1WXyOR6mPS9uxwlkIwC2msvHw
 LiIfhyl8DABlJ9S/aug/ZMEY3c8sglVE0f43Yt/J2p64ovcDttwqNhcvWZaJr+bd
 GpO1Sr2oG/IEqJeZFizBCroYiuYw4mHfQc5Nc+rxeKVAf04Qg0OKuVrhdkdUDutA
 BzceTKn/rrvNvPSMEK2n14llUt7I3szx9YaX96ia2fR7TXzcOv7elW1vKjHK0SXz
 fV/ZwM2SUUm6i40EhUY+CiiWBBNcQ+DXRR1pEdLu2C7HuuMD3bDu7ogSb6rlOa4i
 BeAUxA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv3w6c1j0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb835525b10so2185009a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990451; x=1786595251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tOukWTJNy11ihKe0HGTFZQymqy/N77aZU0OGWHRrnP0=;
 b=kTBiC1PTWW6gQUserE4FG6eUqeMPKCcZ1pWCh4p+U1ZJ6hzB8aCmU96HHCc5XaKkCM
 T/bVh1Fy6qG6uM3BzlUrOsDMEHE98gLpMemQxcIYHqeFPuiHY6AhgOApBcY7bT0EV3O4
 5ME1t9wGu7yvn05V2garUut56iQwaO8RqOBwlLtw0DDQQYWS6LvUJZpILp8BTI+WCt3H
 HVyX1SXqH56Qn4iHBF5wyZBG3p5q4GTWC/12i9epEgEUQpeGnSj0mJBsFBZoY8nTwWO/
 ual351dUYV+29d76tSm/poYuhH9OfTDvIdaMcw0/WqaLM01wta8vYEevyO3w8aky7+L3
 QmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990451; x=1786595251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tOukWTJNy11ihKe0HGTFZQymqy/N77aZU0OGWHRrnP0=;
 b=e6oPt7fEOSr5OYhlmxTduey8JSSFsDA5K9WjuWxde4poPuMFRPSFsoXwqKs/cns2lj
 dKS9asgVOYF67votQ93tvvXyYjN6KFblLfybBeTedUZMCLdZNGbMGZdmdrw0bGG62+3s
 vow/izLEEbgTbhu1FI1tpevNe/fq8kwBS5F5IxyFyinFc4VqETMHxtnglf3EOBawoaud
 VDULmdJmKbR9SPQEw0SLAJZ+kopszauutbBCXgwHgRunO582ORY6yMWHBU2DDalKq2rZ
 N4y6tV7+FFwLOtpAHf2d6CfhfR6uYxd0v0kh9QDBrpiYBG3SfMOGPBXnq9DOwcrn7MM9
 FJbg==
X-Gm-Message-State: AOJu0Yz9CE9Y7Rwrr7rlzVI6ZAlD4Cc1s1+toUI1Dg/MLbenblVhiIQa
 +AN+FvUzGWMQdpQsHS5dYmB6wwL2sKlGBe6Et6bRtMuHrThawITGvsDOGrT1Lcq/kl5b/UxgOU5
 AYCVhNCZuzbKTy/NnAaO4UMll5Ng++sfHepUg11WrEMdGtOj9sqfRvNcmvZXbj0V/Kg==
X-Gm-Gg: AR+sD13NoslbFesg1yz52QSkyPpNlEZjWMifS5LK49sjt9KDIKJOo4vQu5Ehy8ZoIiF
 Vg4L5HsReN9VAFw3rF3Jnd+2shRo7JHQr0jOIxVdTadP7pvXhXC1Lx4FGaJRzBtxtgeP/xKTjMX
 k5WrCe77DdZ7J5+6YmEnYyTNskvfmpOeNqIpAU0vhP88txGhMqhH6iJOS2+nvRdX7J9S/GqhWo9
 BiRS1rLNW62mMt1ef27QE+zTX7WHFGo5pe+iJjnBEGAdlJpRBwSEmFNdJ67389fp1ELQtBHPjAV
 8aeRJhEFFECDZIwn6fRamaFNjcvrRVZDWV5aRBjUsvjwP/ElIYg3bZfMuF6gU3NyVYF5f2z0GCC
 Eij1i3V29THtXBfy/OjvrWRK3gCLxM2dHTb7HarTzHVZ1MMSF
X-Received: by 2002:a05:6a21:70c8:b0:3c3:b226:f165 with SMTP id
 adf61e73a8af0-3cb8603af69mr13575068637.35.1785990451271; 
 Wed, 05 Aug 2026 21:27:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:70c8:b0:3c3:b226:f165 with SMTP id
 adf61e73a8af0-3cb8603af69mr13575014637.35.1785990450784; 
 Wed, 05 Aug 2026 21:27:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 04/18] hw/hexagon: move the TLB to hex-subsys
Date: Wed,  5 Aug 2026 21:27:09 -0700
Message-Id: <20260806042723.3785369-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: vw-mKuuNnFwefkMGmDqq7ywXzlpDb34p
X-Proofpoint-ORIG-GUID: vw-mKuuNnFwefkMGmDqq7ywXzlpDb34p
X-Authority-Analysis: v=2.4 cv=a48AM0SF c=1 sm=1 tr=0 ts=6a740d33 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=qVS_p__ePFo4ISZweN8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX43N/4jAW4aOL
 z6MkZZtcGNRZKe5qY7V9wUJCcLfk26nw0TJHodGh0RoSAWEUEHmVz//Ga7Foiec3142CDISt2KE
 XI+c1IJAw8YADxo83b0MzI2qGXzzxaA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfXwjxW2wCo0hu1
 1Hdco2bQ1EgwelOsSK5WnJJ7vSOKk1JW+v67zINxxOaHfBa6ffPIDtLiQR2Hd76Rbnk4wHtJmG8
 4vt2vLpjJRLYgAjc3GbUxWTUIoTi87FYLy70OAwlGvtsuxtVzs5zARBoeeLtqLNVz8a1eBsm1ir
 s0ShZ4uDQpvIEYPX/GYI9827dzZYa8z9ob1lhBbZYcEjDqsvdi4dPOiYVwp/X4Z0Br9wUEysy20
 V3d2NlFIM8o6jnlT1x8JKkdVZqy+wSiQveopRO0s/1v4yXnuBM4kixc2V9bayZdkuqaukvZNUUg
 20rthsumaRadY9opWUY8rwBhNci54NOkajv4eoGwiPewznT2RyD0qlvQOceYN4LEL/52gzn1RvM
 p8HsqEOPbtHACz5Ko5bVGKLEAt6LgJlqoishRi7gAztBai1WvzJB0BcJrsNgshwJ0wDilQwI/54
 KkXrDFNBVky1e8um0ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

VGhlIFRMQiBkZXZpY2UgaXMgc2l6ZWQgZnJvbSB0aGUgY29uZmlnIHRhYmxlLCBzbyBib3RoIG1h
Y2hpbmVzIGNyZWF0ZQppdCBpZGVudGljYWxseS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hl
eGFnb24vaGV4YWdvbi5oIHwgIDEgKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDE2
ICsrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgfCAxMCAtLS0t
LS0tLS0tCiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgICAgIHwgMTAgLS0tLS0tLS0tLQogNCBm
aWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb24uaAppbmRleCBlZjU3MDAwODJjYy4uNmVkZDkzZjQ3OGEgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgKKysrIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24u
aApAQCAtMTU4LDYgKzE1OCw3IEBAIHN0cnVjdCBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlIHsK
ICAgICBNZW1vcnlSZWdpb24gY2ZndGFibGVfcm9tOwogICAgIE1lbW9yeVJlZ2lvbiB2dGNtOwog
ICAgIERldmljZVN0YXRlICpnbG9iX3JlZ3M7CisgICAgRGV2aWNlU3RhdGUgKnRsYjsKIH07CiAK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgYi9ody9oZXhhZ29u
L2hleC1zdWJzeXMuYwppbmRleCA2Nzg5YjZiYjIzZC4uYWM3ZTI5NjA0ZWIgMTAwNjQ0Ci0tLSBh
L2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCisrKyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCkBA
IC05LDYgKzksNyBAQAogI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKICNpbmNsdWRlICJody9oZXhh
Z29uL2hleC1zdWJzeXMuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVn
LmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oIgogI2luY2x1ZGUgImh3L2Nv
cmUvbG9hZGVyLmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNs
dWRlICJody9jb3JlL3FkZXYuaCIKQEAgLTI5LDYgKzMwLDE4IEBAIHN0YXRpYyBEZXZpY2VTdGF0
ZSAqZ2xvYmFscmVnX2NyZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAg
cmV0dXJuIGdsb2JfcmVnczsKIH0KIAorc3RhdGljIERldmljZVN0YXRlICp0bGJfY3JlYXRlKEhl
eGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyAqbV9jZmcpCit7CisgICAg
RGV2aWNlU3RhdGUgKnRsYiA9IHFkZXZfbmV3KFRZUEVfSEVYQUdPTl9UTEIpOworCisgICAgb2Jq
ZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChPQkpFQ1QoaG1zKSwgInRsYiIsIE9CSkVDVCh0bGIpKTsK
KyAgICBxZGV2X3Byb3Bfc2V0X3VpbnQzMih0bGIsICJudW0tZW50cmllcyIsIG1fY2ZnLT5jZmd0
YWJsZS5qdGxiX3NpemVfZW50cmllcyk7CisgICAgc3lzYnVzX3JlYWxpemVfYW5kX3VucmVmKFNZ
U19CVVNfREVWSUNFKHRsYiksICZlcnJvcl9mYXRhbCk7CisKKyAgICByZXR1cm4gdGxiOworfQor
CiB2b2lkIGhleF9zdWJzeXNfY3JlYXRlKEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcywK
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGhleGFnb25fbWFjaGluZV9jb25m
aWcgKm1fY2ZnLCBSZXZfdCByZXYpCiB7CkBAIC01NywxMSArNzAsMTQgQEAgdm9pZCBoZXhfc3Vi
c3lzX2NyZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgfQogCiAgICAg
aG1zLT5nbG9iX3JlZ3MgPSBnbG9iYWxyZWdfY3JlYXRlKGhtcywgbV9jZmcsIHJldik7CisgICAg
aG1zLT50bGIgPSB0bGJfY3JlYXRlKGhtcywgbV9jZmcpOwogfQogCiB2b2lkIGhleF9zdWJzeXNf
cmVhbGl6ZV9jcHUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLCBEZXZpY2VTdGF0ZSAq
Y3B1KQogewogICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoY3B1KSwgImdsb2Jh
bC1yZWdzIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKGhtcy0+Z2xvYl9y
ZWdzKSwgJmVycm9yX2ZhdGFsKTsKKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNU
KGNwdSksICJ0bGIiLCBPQkpFQ1QoaG1zLT50bGIpLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmZXJyb3JfZmF0YWwpOwogICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoY3B1LCBOVUxM
LCAmZXJyb3JfZmF0YWwpOwogfQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5j
IGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCmluZGV4IDg1OTlmNTg4M2JmLi4yNWU4NTUwZmJh
MiAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24v
aGV4YWdvbl9kc3AuYwpAQCAtMTUsNyArMTUsNiBAQAogI2luY2x1ZGUgImh3L2NvcmUvcWRldi1w
cm9wZXJ0aWVzLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uLmgiCiAjaW5jbHVkZSAi
aHcvaGV4YWdvbi9oZXgtc3Vic3lzLmgiCi0jaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX3Rs
Yi5oIgogI2luY2x1ZGUgImh3L2NvcmUvbG9hZGVyLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5o
IgogI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiCkBAIC0xMDgsNyArMTA3LDYgQEAgc3Rh
dGljIHZvaWQgaGV4YWdvbl9jb21tb25faW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIFJldl90
IHJldiwKIHsKICAgICBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMgPSBIRVhBR09OX0NP
TU1PTl9NQUNISU5FKG1hY2hpbmUpOwogICAgIEhleGFnb25Ec3BNYWNoaW5lU3RhdGUgKmRtcyA9
IEhFWEFHT05fRFNQX01BQ0hJTkUobWFjaGluZSk7Ci0gICAgRGV2aWNlU3RhdGUgKnRsYl9kZXY7
CiAKICAgICBtZW1zZXQoJmhleGFnb25fYmluZm8sIDAsIHNpemVvZihoZXhhZ29uX2JpbmZvKSk7
CiAgICAgaWYgKG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSkgewpAQCAtMTIwLDEyICsxMTgsNiBA
QCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwg
UmV2X3QgcmV2LAogCiAgICAgaGV4X3N1YnN5c19jcmVhdGUoaG1zLCBtX2NmZywgcmV2KTsKIAot
ICAgIHRsYl9kZXYgPSBxZGV2X25ldyhUWVBFX0hFWEFHT05fVExCKTsKLSAgICBvYmplY3RfcHJv
cGVydHlfYWRkX2NoaWxkKE9CSkVDVChtYWNoaW5lKSwgInRsYiIsIE9CSkVDVCh0bGJfZGV2KSk7
Ci0gICAgcWRldl9wcm9wX3NldF91aW50MzIodGxiX2RldiwgIm51bS1lbnRyaWVzIiwKLSAgICAg
ICAgICAgICAgICAgICAgICAgICBtX2NmZy0+Y2ZndGFibGUuanRsYl9zaXplX2VudHJpZXMpOwot
ICAgIHN5c2J1c19yZWFsaXplX2FuZF91bnJlZihTWVNfQlVTX0RFVklDRSh0bGJfZGV2KSwgJmVy
cm9yX2ZhdGFsKTsKLQogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgbWFjaGluZS0+c21wLmNwdXM7
IGkrKykgewogICAgICAgICBIZXhhZ29uQ1BVICpjcHUgPSBIRVhBR09OX0NQVShvYmplY3RfbmV3
KG1hY2hpbmUtPmNwdV90eXBlKSk7CiAgICAgICAgIHFlbXVfcmVnaXN0ZXJfcmVzZXQoZG9fY3B1
X3Jlc2V0LCBjcHUpOwpAQCAtMTM4LDggKzEzMCw2IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY29t
bW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCByZXYsCiAgICAgICAgIGlmIChp
ID09IDApIHsKICAgICAgICAgICAgIGhleGFnb25faW5pdF9ib290c3RyYXAoZG1zLCBjcHUpOwog
ICAgICAgICB9Ci0gICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoY3B1KSwg
InRsYiIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2Rldiks
ICZlcnJvcl9mYXRhbCk7CiAgICAgICAgIGhleF9zdWJzeXNfcmVhbGl6ZV9jcHUoaG1zLCBERVZJ
Q0UoY3B1KSk7CiAgICAgfQogfQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi92aXJ0LmMgYi9ody9o
ZXhhZ29uL3ZpcnQuYwppbmRleCAyOTA3ODNkNTExZi4uYjllMGJiYjcwNGMgMTAwNjQ0Ci0tLSBh
L2h3L2hleGFnb24vdmlydC5jCisrKyBiL2h3L2hleGFnb24vdmlydC5jCkBAIC0xNCw3ICsxNCw2
IEBACiAjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMtZmR0LmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdv
bi9oZXhhZ29uLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmgiCi0jaW5jbHVk
ZSAiaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oIgogI2luY2x1ZGUgImh3L2NvcmUvbG9hZGVyLmgi
CiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNsdWRlICJody9jb3Jl
L3FkZXYtY2xvY2suaCIKQEAgLTIyNSw3ICsyMjQsNiBAQCBzdGF0aWMgdm9pZCB2aXJ0X2luaXQo
TWFjaGluZVN0YXRlICptcykKIHsKICAgICBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zID0g
SEVYQUdPTl9WSVJUX01BQ0hJTkUobXMpOwogICAgIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hp
bmVfY29uZmlnICptX2NmZyA9ICZ2NjhuXzEwMjQ7Ci0gICAgRGV2aWNlU3RhdGUgKnRsYl9kZXY7
CiAgICAgaW50MzJfdCBjbGtfcGhhbmRsZTsKIAogICAgIGNyZWF0ZV9mZHQodm1zKTsKQEAgLTI0
OCwxMiArMjQ2LDYgQEAgc3RhdGljIHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAK
ICAgICBmZHRfYWRkX2h2eCh2bXMsIG1fY2ZnKTsKIAotICAgIHRsYl9kZXYgPSBxZGV2X25ldyhU
WVBFX0hFWEFHT05fVExCKTsKLSAgICBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKE9CSkVDVCht
cyksICJ0bGIiLCBPQkpFQ1QodGxiX2RldikpOwotICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKHRs
Yl9kZXYsICJudW0tZW50cmllcyIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgbV9jZmctPmNm
Z3RhYmxlLmp0bGJfc2l6ZV9lbnRyaWVzKTsKLSAgICBzeXNidXNfcmVhbGl6ZV9hbmRfdW5yZWYo
U1lTX0JVU19ERVZJQ0UodGxiX2RldiksICZlcnJvcl9mYXRhbCk7Ci0KICAgICBmb3IgKGludCBp
ID0gMDsgaSA8IG1zLT5zbXAuY3B1czsgaSsrKSB7CiAgICAgICAgIEhleGFnb25DUFUgKmNwdSA9
IEhFWEFHT05fQ1BVKG9iamVjdF9uZXcobXMtPmNwdV90eXBlKSk7CiAgICAgICAgIHFlbXVfcmVn
aXN0ZXJfcmVzZXQoZG9fY3B1X3Jlc2V0LCBjcHUpOwpAQCAtMjY5LDggKzI2MSw2IEBAIHN0YXRp
YyB2b2lkIHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1zKQogICAgICAgICB9CiAgICAgICAgIHFk
ZXZfcHJvcF9zZXRfdWludDMyKERFVklDRShjcHUpLCAiaHRpZCIsIGkpOwogICAgICAgICBxZGV2
X3Byb3Bfc2V0X2JpdChERVZJQ0UoY3B1KSwgInN0YXJ0LXBvd2VyZWQtb2ZmIiwgKGkgIT0gMCkp
OwotICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGNwdSksICJ0bGIiLAot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKHRsYl9kZXYpLCAmZXJyb3Jf
ZmF0YWwpOwogICAgICAgICBoZXhfc3Vic3lzX3JlYWxpemVfY3B1KCZ2bXMtPnBhcmVudF9vYmos
IERFVklDRShjcHUpKTsKICAgICB9CiAKLS0gCjIuMzQuMQoK

