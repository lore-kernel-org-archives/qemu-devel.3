Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C21606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jA6EvWyG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VO2fp1oy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4SX-0004Pq-EV; Thu, 22 Oct 2026 21:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rs-0002ow-97
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:52:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rq-0006RC-2O
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1Etpd772889
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=; b=jA6EvWyGRvxAGfJW
 6jrxQT1RVtRcz7TEHrlIbBFVw5kLs/6NLf6zvzWf7BqnORpxfGw5kASbkUXqVjh6
 /1ypo4IPrkx4FwQ9uc1ALTRaWfQ3vMT991HrBhxzOS/yLtSHqABLDs8qEsdv55pQ
 7J4aWLqWpy1yy8DoMf6ba0op2xwtQ5qB7ccyS0v+Ch2ssht6yZCAbZHpCHVDjKd1
 hV9eE5MKwufkymRpZYOD73JfZnZdsEZz+GaDa/8+IWkI4WbZkh7AxgUuybyk2DKv
 cCu/omyHHWqd5mfvOBLLrCc6hQ8qXL56ivKv9/+eJw28fUlBwIOFkTYLwUbpwCEj
 gdB+oA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtsbvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so968483eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720306; x=1793325106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=VO2fp1oybFA72DByayDtcr9L6WtUKyIxyIFcGQpbuusL7yFWBLGZ7W3lQWhzv6IK+q
 PoppsmbaVd57LGPDFryOJHYjGHabUo5PGFrNR2/ML8DCMLrK9cohdoBEew0qlBF4GMqa
 HID3q4uAGKAFwAjtF5RY9HdG+xwhfU5vo/ewccc0uQqLJ4iEHjG6O4P7KGtaUAr83BqU
 35gJAJrZxrwi535HqnB9WlSrLZhMeCLP9VqmmUTm34GNmnCw8QT2mH7R9wxwMiBovg+W
 JM9ZYNciiqnOHKYrFpj42UHTjhDErCQ72S2vDNWBLJFngaS2zcjCfS7XV+4YYRjJnism
 1bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720306; x=1793325106;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=SFLzxJlMH+jNnGzaSSA+88funOV+/sAYS73U2PvJF/Ra7W4lFIwESoysDjtP0NOCBT
 Tyk320P324VSuyL44fcxmMGahQlhDM6rvLCOaEwNz7+PkyqvI+FZ8DgdtTH/93f2ADp3
 KJfUCwIkmA0yrtlTYsDBAfwNdTFID1gIygfmFaEi90WHvhEltJHLESL88Y2JWdZSRdLn
 RnZKz9fws8r4al5vVtmPyGQNqupeB644+0bAhYay9L8o1x0Nyk906Aq/9F+xrGEasq27
 82YclsaRrRJLe1js7RWyyWb7eBQebDgMbcUH20SZZhSjnkmxkF4LPBZW2D9D9qU40bfO
 vZjw==
X-Gm-Message-State: AFq9FYLWNzDujJfQAJQy0KJAOlDm1FKFznC4kmHczEwG9LP0To9BHrkd
 qVpX3Z5ckQezG0TOVy/6T4TLHbyZqiaDy8mfWAdTIhUn1dDKjVIoJLp8VPVoxZIWYisz1+wzNk0
 XThPhVDzghBXuVDPWnZXYYwcxnydzPcC/MmuS3W+02Xd1Q2W7to9+M3pa59idZC4p4A==
X-Gm-Gg: AYBFou0jQGDamjaJA2oa+BHjwrEmGUMYU7XkJXOIymbQu9NVCbGe++cBo9CYbntpNCq
 /OYKzo+4/3/aqqIHKjC8dLPwbOeWztI7KAnuAWqw//l7Vy/WrrM7AWCPKtwHVp8M2paaJrNQ4NL
 6cWwlXbpz4yPf6oCvsi03+T3ZOKYu91s07P+mf9ScA4W/KU7M6C1V1wZkRhte7eKAOeSyDsX9fR
 lVHDHUC6hnUj9FPFS58kQ6jis/cgFWzcf4WtIAK1TXTDRs+1CJs8raI4b289uEs80t//aIOzgGZ
 3fWN/nhbWos5Znnc9qwE2WapieGKvuJfiMyA8YEFReb2/qWgVsjwPlVkUKoMRoT8cJ63Jp91bjv
 5MjiCG52Xl33+r2YN6D60U8BAzfOPef31te8mCLeGVwJTk0Mf
X-Received: by 2002:a05:7300:d212:b0:369:2f25:339b with SMTP id
 5a478bee46e88-369d97c6495mr1024857eec.8.1792720305594; 
 Thu, 22 Oct 2026 18:51:45 -0700 (PDT)
X-Received: by 2002:a05:7300:d212:b0:369:2f25:339b with SMTP id
 5a478bee46e88-369d97c6495mr1024830eec.8.1792720305041; 
 Thu, 22 Oct 2026 18:51:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 38/43] target/hexagon: only flush the softtlb when SSR.ASID
 changes
Date: Thu, 22 Oct 2026 18:50:35 -0700
Message-Id: <20261023015040.2473105-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adabdb2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=03mWCbMf3N1Ipu_5KecA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: VSA-ImTcxyMVrt2P4TPhI3Dd3runmgJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXyqmQaYaGFpis
 KPPLidJrKkwePw7delA8g1xWlEyjr8elLmjU8s1TmOyHz/2tYQxf1PpbFsIjv3xYC0Nmg6resAj
 CvVuaqZvrgRtWgxguIq2BgS8/o0M2gl+bvv54/PXNNqYrbwWysdOzjNBxrGvOxoACYGw3R5fdao
 iiFG1noTkspoE4BoZfXd4oqYEejZ7P6vjeb5L4/aUMAMnq4tvSs0ymBOuLBeNqtEJ2lx4SJNLi/
 f8FXoojBEnvMWGhNclDJQCjSUJOqW6CkThp8i7SRDKfb54/yLmi99B92Cl50WS2kbwv7nw5u8mq
 Raig0TX2WPPLSyzD1zk/L0/nqh1os7wJX694OAwQp//8O/GhlmOOpJ8eVEmSBTHnVdG0pLwo8yY
 mf1mtEW7RM4Rwr/27drRM5GLn0BEzopew7GlN7yaJIKqXgZIDUihP9s6q7BiuHSZQhyvHg/+3pA
 ZmQVX9wbBW9ccMwP2KQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX5lcU2R5VMuLu
 AJ/32g4nG+tnJD2jKCXsfxl5mp0zmCwbCfCnfOnZVKxrkKzoURB/N1UJ+mQrztSKO3B+0GfUz8s
 FjciYtmvC0Dt3GNDvRfsIifbXqfqB9w=
X-Proofpoint-ORIG-GUID: VSA-ImTcxyMVrt2P4TPhI3Dd3runmgJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
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

aGV4YWdvbl9tb2RpZnlfc3NyKCkgZmx1c2hlZCB0aGUgc29mdHRsYiBvbiBhbnkgY2hhbmdlIHRv
IFNTUi5FWCwgVU0sIEdNLApvciBBU0lELCBidXQgb25seSBBU0lEIGFmZmVjdHMgdHJhbnNsYXRp
b24uICBFWC9VTS9HTSBqdXN0IHBpY2sgdGhlIG1vZGUsCndoaWNoIGlzIGFscmVhZHkgY2FwdHVy
ZWQgaW4gbW11X2lkeC4KCkVYIHRvZ2dsZXMgb24gZXZlcnkgZXhjZXB0aW9uIGVudHJ5L3J0ZSwg
c28gdGhlIGZsdXNoIGNyZWF0ZWQgYSBmZWVkYmFjawpsb29wIHdoZXJlIGEgVExCIG1pc3Mgd2lw
ZWQgdGhlIHNvZnR0bGIgYW5kIGd1YXJhbnRlZWQgdGhlIG5leHQgYWNjZXNzZXMKbWlzc2VkIHRv
by4KClJlbmFtZSBoZXhfbW11X21vZGVfY2hhbmdlKCkgdG8gaGV4X21tdV9hc2lkX2NoYW5nZSgp
IHRvIG1hdGNoIHdoYXQgbm93CnRyaWdnZXJzIGl0LCBhbmQgbmFycm93IGl0IHRvIHRoaXMgdGhy
ZWFkJ3MgbW11IGluZGljZXM6IHRoZSBBU0lEIGxpdmVzIGluCnRoZSB0aHJlYWQncyBwcml2YXRl
IFNTUiwgc28gb3RoZXIgQ1BVcyBhcmUgdW5hZmZlY3RlZC4KClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
IHwgMTcgKysrLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICB8ICA3
ICsrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmggYi90YXJnZXQvaGV4YWdv
bi9oZXhfbW11LmgKaW5kZXggMGM0OTQwNDQ0OGMuLjliNmVhNWI5NjdiIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZXhfbW11LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oCkBA
IC0xNyw3ICsxNyw3IEBAIGV4dGVybiB2b2lkIGhleF90bGJfaW52YWxpZGF0ZV9hc2lkKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBhc2lkKTsKIGV4dGVybiB1aW50MzJfdCBoZXhfdGxi
X2xvb2t1cChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3NyLCB1aW50MzJfdCBWQSk7
CiBleHRlcm4gdm9pZCBoZXhfbW11X29uKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIGV4dGVybiB2
b2lkIGhleF9tbXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KTsKLWV4dGVybiB2b2lkIGhleF9t
bXVfbW9kZV9jaGFuZ2UoQ1BVSGV4YWdvblN0YXRlICplbnYpOworZXh0ZXJuIHZvaWQgaGV4X21t
dV9hc2lkX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiBleHRlcm4gYm9vbCBoZXhfdGxi
X2ZpbmRfbWF0Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGh3YWRkciAq
UEEsIGludCAqcHJvdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAq
c2l6ZSwgaW50MzJfdCAqZXhjcCwgaW50IG1tdV9pZHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDkx
OWZjYmM3Yzk3Li5iYWZmZTZiYmFhOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hl
bHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTkyLDI3ICsxOTIs
MTcgQEAgdW5zaWduZWQgaGV4YWdvbl9odnhfc2VsZWN0X2NvbnRleHQoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHVpbnQzMl90IHNzcikKIAogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewotICAgIGJvb2wgb2xk
X0VYLCBvbGRfVU0sIG9sZF9HTSwgb2xkX0lFOwotICAgIGJvb2wgbmV3X0VYLCBuZXdfVU0sIG5l
d19HTSwgbmV3X0lFOworICAgIGJvb2wgb2xkX0VYLCBvbGRfSUU7CisgICAgYm9vbCBuZXdfRVgs
IG5ld19JRTsKICAgICB1aW50OF90IG9sZF9hc2lkLCBuZXdfYXNpZDsKIAogICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CiAKICAgICBvbGRfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgb2xk
KTsKLSAgICBvbGRfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgb2xkKTsKLSAgICBvbGRfR00g
PSBHRVRfU1NSX0ZJRUxEKFNTUl9HTSwgb2xkKTsKICAgICBvbGRfSUUgPSBHRVRfU1NSX0ZJRUxE
KFNTUl9JRSwgb2xkKTsKICAgICBuZXdfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgbmV3KTsK
LSAgICBuZXdfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgbmV3KTsKLSAgICBuZXdfR00gPSBH
RVRfU1NSX0ZJRUxEKFNTUl9HTSwgbmV3KTsKICAgICBuZXdfSUUgPSBHRVRfU1NSX0ZJRUxEKFNT
Ul9JRSwgbmV3KTsKIAotICAgIGlmICgob2xkX0VYICE9IG5ld19FWCkgfHwKLSAgICAgICAgKG9s
ZF9VTSAhPSBuZXdfVU0pIHx8Ci0gICAgICAgIChvbGRfR00gIT0gbmV3X0dNKSkgewotICAgICAg
ICBoZXhfbW11X21vZGVfY2hhbmdlKGVudik7Ci0gICAgfQotCiAgICAgYm9vbCB4YV9jaGFuZ2Vk
ID0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG5ldykgIT0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG9s
ZCk7CiAgICAgYm9vbCB4ZV9jaGFuZ2VkID0gR0VUX1NTUl9GSUVMRChTU1JfWEUsIG5ldykgIT0g
R0VUX1NTUl9GSUVMRChTU1JfWEUsIG9sZCk7CiAKQEAgLTIyOCw4ICsyMTgsNyBAQCB2b2lkIGhl
eGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50
MzJfdCBvbGQpCiAgICAgb2xkX2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBvbGQpOwog
ICAgIG5ld19hc2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgbmV3KTsKICAgICBpZiAobmV3
X2FzaWQgIT0gb2xkX2FzaWQpIHsKLSAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYp
OwotICAgICAgICB0bGJfZmx1c2goY3MpOworICAgICAgICBoZXhfbW11X2FzaWRfY2hhbmdlKGVu
dik7CiAgICAgfQogCiAgICAgLyogU2VlIGlmIHRoZSBpbnRlcnJ1cHRzIGhhdmUgYmVlbiBlbmFi
bGVkIG9yIHdlIGhhdmUgZXhpdGVkIEVYIG1vZGUgKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2hleF9tbXUuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCAyZTBlNGFiNzA1
Yi4uOWEwZTI5YWUyMTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKQEAgLTczLDExICs3MywxMiBAQCB2b2lkIGhleF9t
bXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgIHRsYl9mbHVzaChjcyk7CiB9CiAKLXZv
aWQgaGV4X21tdV9tb2RlX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3ZvaWQgaGV4X21t
dV9hc2lkX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBxZW11X2xvZ19tYXNr
KENQVV9MT0dfTU1VLCAiSGV4YWdvbiBtb2RlIGNoYW5nZSFcbiIpOwogICAgIENQVVN0YXRlICpj
cyA9IGVudl9jcHUoZW52KTsKLSAgICB0bGJfZmx1c2goY3MpOworCisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX01NVSwgIkhleGFnb24gQVNJRCBjaGFuZ2UhXG4iKTsKKyAgICB0bGJfZmx1c2hf
YnlfbW11aWR4KGNzLCBNTVVfSURYX0FMTCk7CiB9CiAKIGJvb2wgaGV4X3RsYl9maW5kX21hdGNo
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwKLS0gCjIuMzQuMQoK

