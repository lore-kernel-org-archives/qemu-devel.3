Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29810606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rke174Fe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C4ZYOt8t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLint-0001uw-48; Tue, 27 Oct 2026 11:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLinq-0001uA-GD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLino-0000hc-Fo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RF7iFn2570471
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=; b=Rke174FeA2ewpMZL
 /w9zgn2c6NDgB9H2BWPLM9UliTyM5x/QQHEXIqiQ3Ki5pgEqtoOFYLVGV91fiEFb
 /gpOSP2ZjOZF0kj7TXe5Ya5Jkm7vIPOP+B8qerXoOz9JMgaiTmM7BD1szvi9nXl/
 pmrAYFAOd4+qsjbJFYS+ww9hqh9ApR7XCxRnBcH0w44gldwFh7L86Kgv/CGFZYJv
 LCU1SpHytPSCRRgtCPc+0nnqmCtQhHzvS8XhHWy5p3Yc6098Tiw22RbNB4HkcFXy
 CvxWu+rdhEtIftC/dTsdIYROQROCaWRmh1YX/S7eFgJg3W8URzB5V8V9UWW82GS1
 LmSXqw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1h7v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:09:15 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4f2040e10d8so3894364b6e.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793113754; x=1793718554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=C4ZYOt8tQEJz05n6H28yDJqu+UOF0OsSepTsNYeyM8lDoj2aqC7MkSJKq/JvdsLYcN
 HUVZrQa1FkQl8GbZycEAuhMm058pIpfyufYN8k+3EMmDFb+CjFH6TThgQQDN996Epjhz
 d9MjLSXblt4iuCv3qiJc1z9Yy4Mtd9uViQ2qbGfgyXYmnP96BwcieNzLStfpsyPnvvJl
 5CXBNPyt3gBzNTijZqHn8IHOOzhSzXyVQLpwkxIedv/6iUsPLG6UJG82OG3Vovk52lmT
 Gwejkxt3gJ3OJpSeEe4ht1GiEnpm4cj2ioXpCSZzwnCgXdYmsrMqoAU6J9hdO34dw9wg
 ztPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113754; x=1793718554;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=EXppguu/ySUPxY2kzZwBLPiEORPjU1rXyAGokEa229oosG9j+9HIQ3XmtdFLiepeo2
 7ZrtWQHd9BOatVg/x/shsCJg8r9ex734umKM9aGwdKp49vqBicGqx9j9W4YKQ3xJ/ZdO
 PhYpvPWY6b1wnYp76/9KiopViccxvjUow03wB+euSMtmaIYkVH59Yu3L8Vyb7miizecH
 RFvBfTyIWSo5cJ5YzZ3IfY37nm1orGzHmyABLCR+y8RN2TSS0QioLgcstpyfOgu72hz5
 lttP+SpuFcv8Euuw+C+D6MavLE8b5Av0jnXSOyYvTJbkr08czP4rSd9OMK2ELMZYYz44
 a4DA==
X-Gm-Message-State: AFq9FYK56hTTgbOqURMYJi3rmscWDJSnLoVXCi+xNUcWyMXY2zc4L4xT
 CsNJuA3Tpy/fSoX+4CHyMTFzfEnZ1uqQl6t9cDNB4kxH35UiqOFRg0jn2arIsUOdpkOVEJt4ud7
 +wOmE6HpE7Qxo6xdPVaw2XgeuKgdKWJdA+MCj4N0IAVSpqxfUjInC4GlemrzxjeZHsQ==
X-Gm-Gg: AYBFou3LT7hZKewvB9DhnmTBTH+QsclM7mXFnxk2P7yfB6ZOrukSRiG9uOyQRo/In+3
 +VoDJ63OrdkwUezHHwqAGMr05kkuqBP+cmkuNQGHWCmXiJ6KkDDJt8IxGcmAAu482ml4ydl/WDO
 p5jsW7ldJgKTSJIuoEe2YlVaBzuByfN9iRXW52+uQzkyz6gIBA0InpadgOo+Yp78aXb+FNz/yt8
 oZXbsEDolvzJPlNjJ+J8hqmSth7uXkqv5LzSgPixB0Oa0hmUY4qF1P26ID2Vxe8pUpe79Mk8TcF
 pTj/PG/f3refl37kQSVWG5QB1ccwaiD0TNTeHUOq7YrS45bB9C9EKUKO4vS0wWZEoU0wEL3KHDt
 jlihQd65ShU54xOg0CPZ36yb2nd9HiejMw8/h7TnjcrG6oqg=
X-Received: by 2002:a05:6808:2443:b0:4d6:90f3:74b3 with SMTP id
 5614622812f47-55c003d2d6fmr6119936b6e.51.1793113754365; 
 Tue, 27 Oct 2026 08:09:14 -0700 (PDT)
X-Received: by 2002:a05:6808:2443:b0:4d6:90f3:74b3 with SMTP id
 5614622812f47-55c003d2d6fmr6119914b6e.51.1793113753933; 
 Tue, 27 Oct 2026 08:09:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c03dc3524sm7673136b6e.0.2026.10.27.08.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:09:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 40/42] target/hexagon: only flush the softtlb when SSR.ASID
 changes
Date: Tue, 27 Oct 2026 07:37:19 -0700
Message-Id: <20261027143721.4125584-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0be9b cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=03mWCbMf3N1Ipu_5KecA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: Q59mej2m0-y1puWXymujpVWAFW9_pGyp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfX3bNDCxox14I8
 gfeCnUEZ3jPmU7D8A6BKYMukKhXCCyJmoMqhcQgRUigMC+ip4654u8GjvymlNAS+mwX4E5/Lu1t
 tjZiKBxtWg39GKV8NpYXx/KedSURqpk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MCBTYWx0ZWRfX9wbMqA/GckWV
 2FTZY4mQMn5IIJsW3vbEtreXJxL090V7E8JM3AzOYUOKdLtEnY1eK566Y3mLdi5vVDl+DPWfe/0
 iCpdppwZVQKE/Q2WT/noEAkQHM7kvmGm1o+zC04UvBQma6zpwCaKRvjh1r2W/+cwAgCc8Ld2qt3
 cdxqvGBgYVvOfq/Fi1FFw6BOKBaTyzdNKjMmVd7bHPRzRo6WbuCYnLxvOEGREzbIUy+NtQ0o+br
 odAQSzthUeRh+vuKskNE3vMZ8SgePbRCv8+ri3RKJos0uESWZDue5L7Hy1Dculzg3dq7Ka2Zcum
 QM7O8fB76JEtVOwP+fIAnDYVNNCzgfwY3pPkmEQkhmVShiSEx7eslwXnEfoFXy7ikf95lxjCTCL
 hzOkQzWMAry6QnKF1fVujNmYMo+rB50lwB3OtAJnbe8hfTJWhZrlRC3rXo6e/k988ie/crQ9NoW
 p5zT4l1Twg0+z6FnOmQ==
X-Proofpoint-GUID: Q59mej2m0-y1puWXymujpVWAFW9_pGyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

