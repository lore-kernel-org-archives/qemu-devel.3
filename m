Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE19C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qb6-0003ql-4G; Wed, 23 Sep 2026 13:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9QZ3-0000Pa-3s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:15:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9QZ1-0001ks-5d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:15:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTu6p3665904
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NeurErg7VCxwiecDO2WqHZ
 dHwWTGpFH2izPBguvu/CY=; b=g3RuGl0Z8y8xy+BG3oyqvFW9XX1dOywGKN2Uqp
 vW+RILJA0egT7e4CBT/IPzV1tDdhLgkQi0EV/ZTuAbrXjdUk9dB9834WyiQ537x4
 Ta9zGyxwlvlJBdGj2jGX3FVg2KEG4AcSFhagqwtoLJ2FIvmnMob1g5AB5pQCOpWk
 8wYn6/PdiCMuCGniMOJhvkJWy/qnQT+DzouJKsG3tHwBQJ74kWA+nak82FNrN3kY
 IxfdIAwltt/SGP4aa+xAW54X6C4IhdJ8ufdbVAv7LYSXNlWuN1zBXcrkELRHxvWI
 RJbeTnxsIXdExFxMEEOfFLNhMQszbJA1ld+ydA1ZU6rE14DA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwat1yt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:15:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d9336581a2so16059495ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183721; x=1790788521; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NeurErg7VCxwiecDO2WqHZdHwWTGpFH2izPBguvu/CY=;
 b=GuuXkAH8hDdWkfkIcGFBFw0sq4Rc7yfq/bHpx8J/OaSamYtOunrtsDQnUG58BZ/oWR
 l0jD1frmP3gQE148PlPisIJCe5arYUKReAq/KFC9ZsJBWCdIC9H2xOsLzIUCNYL0cZEV
 CQjUaa3JUMSBw4oaaf/3hiLqjamDoMvrDV8buDGQGH5KS0fqwaD5Fz6Zs67omsihwpYS
 KrBO3pLvNtYpjFen1balgd+vhjbB/mKo+344BKA4ZdeHbZSe0OtmLoTP2y6ugao0ktOt
 95Zl87EI7t+UsM4gr4ZWMoMKxpXB2qWaqSVjeES52i1NGk3jdf553k8g+1bmk0J1AO8N
 aOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183721; x=1790788521;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NeurErg7VCxwiecDO2WqHZdHwWTGpFH2izPBguvu/CY=;
 b=pmxoX9vhfen+KrUyCcq1HiSd4R8N+z1OqG9pQFSsiKBr5rt4Sbj0ZHWrD0EWJsMifJ
 Q2g4r22D8sKeU/N09PRkWecz6ks6htUfEFNgp4t+b8EN9eKjRjRy15puaju/ffFn/lVF
 DlJWsxKXtH50A7lQizk5r02HPPZ4m2jfjDVpW2cGST4zO7oqULs3VZzv1xb1aUzdKdeN
 gCSnXdd7H3CDJKr+9bElPSDElNrmVQUd4UXrl04SpZ2hhOHwDszy5NYmK9jihqXGvFXV
 7HKwys5fUxyFtYCOpYTNJJlLSXm2is3Jv/eyO0xPZZiHwkOLBXMIbsYo6HU9b292LhJN
 kiaA==
X-Gm-Message-State: AFuF++nsaDmF5qcuRnBX94byW5wKIsp4p2QdJk+cqRkBxKLZmoUDWzqB
 c0D5p8GXwIn3/9YqnXmc+GE1W5wMSoetojUOGGmFLLgkX3Fhmxl4OZNBnJjs0kffTvVSbbX/n38
 7KATfBkYH1O2fyDx4nIILwM1kQXYiQF0fqDh2RpFEn3afQix+A1a5Aj0B/Gj0GL+s9Q==
X-Gm-Gg: AYBFou38wpQaz8szSeaEVi/IO/q8vLziHyBw1PF3891je73f2nh+lxI1GisKQ6vddIu
 crBZJjdcy0f6mwwA6TtJ3Molyco5zrlKXtqbqKxbAujIqUF35NCRu60Mn8qTtaFIfOBcEL6XWyD
 ndFFykZR06KA9cjssDKa1E5/tO0k029cfhn/t9vtyVoS7EIo6kea7fdhDw0TCo55wohHPKDuvu/
 WNOQYcnUTTAHXRa/bawUpeK3c4sqRxmjmWnfEhRrYKPht17MYLWkDIOwLPr0Jy1+T5s3fF6rOYy
 9xd6c1b8JpPTJYs902PCmjd4gsfN59+Gwz4H/1L68y5f3XZJpq6J4eXD2gkCiA0knEdAOeWdtCR
 oKWG8lY7d5pqbyyFcCJ90rx6AMd2+7+dcIdRgK6ASBEWrDoY=
X-Received: by 2002:a17:903:3846:b0:2dd:b52d:e856 with SMTP id
 d9443c01a7336-2df69d339efmr30138895ad.9.1790183720797; 
 Wed, 23 Sep 2026 10:15:20 -0700 (PDT)
X-Received: by 2002:a17:903:3846:b0:2dd:b52d:e856 with SMTP id
 d9443c01a7336-2df69d339efmr30138375ad.9.1790183720179; 
 Wed, 23 Sep 2026 10:15:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5f66b3sm14796035ad.73.2026.09.23.10.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:15:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v6 0/7] hexagon: Add HVX context
Date: Wed, 23 Sep 2026 10:15:09 -0700
Message-Id: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX7EFTIhrypEPL
 mRFU9/08JvnZQAQeYmyEDj7qPFWHof+FAVvQ8t0aLpzmIqoQUKR33JbSjDazbHdvLDPLK0ehjjV
 UWna+UdBJVewiwHVszMRSuv46wKLnYAUONVFvFN/T9Fc5lVbBwPjkTVGYe0TGbA54R2tL6sPnUw
 R4t4NlCHzn0ab0aJTuqY3cIM2xVotqNOntEsOeUnfc+X+mJ60sAFb2dQxTfJPR7f9zhqIelGuqV
 v7VqGJF1gpWJCUs9/dsOFy6v6IAh8w97sMyLFt7cnVHkYwPF0kpUcgb3H10dkzmCOPPKfcEWRDG
 C7a+5IIxoY6mOWLIR+vJYy3vpwzWdEdjSGe5HKtPRvAj374dZtlLaL/rERgEyv+bsYCj62wI9Dq
 /1w37lW6ERDkXAOVhLzNyb6B2TWxRrcTYNiJ08PB9e5LMZhtjAZxx/n+Sjti7tZ+FiPnaNiGzBl
 dxZ99HAcekN3kTTczPA==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab4092a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zTHlpq2rQ3psEcsZHm4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: B51qe5Nhf5aD-MovPNCDWMdSsAEyav9b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX3bKT1HfNADyU
 R5msv2gE7ov5B/qB2zBoKDkZ4I3b1Kkw3aO8Asicy0djD7d6PhWjqHqSZEHxxpYhegg2IKn6TIf
 s6PRK+ZTvgeRxm4rn9A88RDn7jC4xy0=
X-Proofpoint-ORIG-GUID: B51qe5Nhf5aD-MovPNCDWMdSsAEyav9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

QWRkIEhWWCBjb250ZXh0cyB0byBIZXhhZ29uIHRyYW5zbGF0aW9uLCBuZWNlc3NhcnkgZm9yIHN5
c3RlbSBlbXVsYXRpb24uCkNoYW5nZSB0aGUgSFZYIGluc3RydWN0aW9uIHRyYW5zbGF0aW9uIHRv
IGFjY2VzcyB0aGUgY29udGV4dCB2aWEgYSBiYXNlCnBvaW50ZXIuCgpNb2RlbGluZyB0aGUgSFZY
IGNvbnRleHQgbWFwcGluZyB3aGlsZSBhdm9pZGluZyB0aGUgbmVlZCB0byBjb3B5IHRoZQpjb250
ZXh0IHdoZW4gdGhlIE9TIHNjaGVkdWxlciBkZWNpZGVzIHRvIHJlbWFwIHRoZW0gcmVxdWlyZWQg
c29tZSBnZW5lcmFsClRDRyBndmVjIGNoYW5nZXMgdG8gZW5hYmxlIHNvbWUgbW9yZSBfdmFyIGZv
cm1zLgoKSW4gdjY6Ci0gYWRkZWQgYSBub3AgInByZXBhcmUgZm9yIHNlcGFyYXRlIEhWWCBjb250
ZXh0cyIgdG8gaW50cm9kdWNlIGhleF9odngoKSwKKHByZXNlcnZpbmcgUmljaGFyZCdzIFItYiBh
Y3Jvc3MgdGhpcyBhbmQgInNoYXJlIEhWWCBjb250ZXh0cyBhbW9uZyBDUFVzIikuCgpJbiB2NToK
LSBhZGRlZCBhIEdVRVNUX0VSUk9SIHdoZW4gU1NSOlhBIHZhbHVlIGlzIG91dC1vZi1yYW5nZSBm
b3IgZXh0X2NvbnRleHRzLgoKSW4gdjQ6Ci0gbW92ZWQgdGhlIGxpbnV4LXVzZXIgaHZ4X2N0eCBm
cm9tIEFyY2hDUFUgdG8gQ1BVQXJjaFN0YXRlLCBlbGltaW5hdGluZwpsaW51eC11c2VyL21haW4u
YyBjaGFuZ2UuCgpJbiB2MzoKLSBmaXhlZCBIVlggY29udGV4dCBhbGlnbm1lbnQgZGVjbGFyYXRp
b25zCi0gY3JlYXRlZCBoZXhfaHZ4X3B0ciBnbG9iYWwgZm9yIHN5c2VtdSwgYWJzdHJhY3Rpb24g
aGV4X2h2eCgpIHRvIHJlZmVyCiAgdG8gdGhlIGNvbnRleHQuCi0gYWRkZWQgc29tZSB0ZXN0IGNh
c2VzIChyZXNldCBNYXJjbydzIFItYikKCkluIHYyOgotIFJlbW92ZWQgdW51c2VkIGRlZmF1bHQg
aHZ4IGNvbnRleHQgZnJvbSB0YXJnZXQvaGV4YWdvbi9jcHUuW2NoXSwgYWRkIGEKaGV4YWdvbl9o
dnhfc2VsZWN0X2NvbnRleHQoKSB0byB0aGUgcmVzZXQgaW5zdGVhZC4KLSBjb21iaW5lZCB0aGUg
SFZYIHBvaW50ZXIsIFFPTSBjb250ZXh0LCBhbmQgU1NSOlhBIHNlbGVjdGlvbiB3b3JrIGNvbW1p
dHMKaW50byBgc2hhcmUgSFZYIGNvbnRleHRzIGFtb25nIENQVXNgLgoKdjU6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MTUxNDU1NDEuNDAzODYzNy0xLWJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbS8KdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjA5MTQxNTUxMzQuMjE5MTkxMi0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8K
djM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MTMxNTU5MjguMzY1
OTI4LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwp2MjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkxMTIwNDMzNC4xMjY0OTIyLTEtYnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tLwp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2
MDkxMDE1MzIyMS4xNjc0Mjg1LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4g
Q2FpbiAoNyk6CiAgdGNnOiBzcGxpdCBvdXQgX3ZhciBmb3JtcyBvZiBndmVjIGxvZ2ljYWwsIGFi
cyBhbmQgbWluL21heCBvcHMKICB0Y2c6IGFkZCBiYXNlIGFyZ3VtZW50cyB0byB0aGUgZ3ZlYyAy
cywgZHVwX2kzMiBhbmQgY21wIGV4cGFuZGVycwogIHRjZzogc3BsaXQgb3V0IF92YXIgZm9ybXMg
b2YgZ3ZlYyBzYXR1cmF0aW5nL211bC9zaGlmdC1pbW1lZGlhdGUgb3BzCiAgdGFyZ2V0L2hleGFn
b246IHJhaXNlIGFuIGV4Y2VwdGlvbiBmb3IgSFZYIHdpdGggU1NSOlhFIGNsZWFyCiAgdGFyZ2V0
L2hleGFnb246IHByZXBhcmUgZm9yIHNlcGFyYXRlIEhWWCBjb250ZXh0cwogIHRhcmdldC9oZXhh
Z29uOiBzaGFyZSBIVlggY29udGV4dHMgYW1vbmcgQ1BVcwogIHRlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbjogYWRkIEhWWCB0ZXN0cwoKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAg
ICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQu
aCAgICB8ICAyNyArCiBpbmNsdWRlL3RjZy90Y2ctb3AtZ3ZlYy1jb21tb24uaCAgICAgICAgICAg
IHwgIDk3ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8
ICAyNiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAgICAgICAgICB8ICAg
MSArCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oICAgICAgICAgICAgICAgIHwgNjA4ICsr
KysrKysrKystLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5oICAgICAgICAgICAgICAg
ICAgICAgfCAgIDggKwogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgICAg
ICB8ICAxNCArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgICB8
ICAxMyArLQogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAgICB8ICAz
NiArKwogaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMgICAgICAgICAgICB8ICA4NCAr
KysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzIgKy0K
IHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgODIgKysrCiB0
YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstCiB0YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgIHwgMTAyICsrLS0KIHRhcmdl
dC9oZXhhZ29uL21hY2hpbmUuYyAgICAgICAgICAgICAgICAgICAgfCAgMTIgKwogdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICB8ICAzNyArLQogdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICB8ICA3MSArKy0KIHRjZy90Y2ctb3AtZ3Zl
Yy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MTcgKysrKysrKysrKysrKystLS0tLS0K
IGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFy
Z2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8IDE3OSArKystLS0KIHRl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAgIDcgKwogdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgICB8ICAgNiArCiAyMyBmaWxlcyBj
aGFuZ2VkLCAxNDU2IGluc2VydGlvbnMoKyksIDYyMSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9odnhfY29udGV4dC5oCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMKCi0tIAoyLjM0LjEK
Cg==

