Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709B1C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coM-00006W-33; Wed, 02 Sep 2026 00:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coK-00005t-RS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coJ-0000Jm-5v
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTFYm2468840
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bIdP3MyJvBiNaQACqfwwsKzexe7QSvciscpahroNaz8=; b=n1HkCoQsZFEl6QCP
 lJ4XAtmD7C2XxbsW6D746xmzeRXZljnYTa6pqfBQkUCroGX1VF/MZfd1oA5sa9+/
 ai+dHROCXSOgZ3hFIcX16U+4wPo5tCHrvnIISh7isPU6vY+1aYapZdI3FA8pp3gp
 Te+veC7x8HCWT737tLWq3UeMIqsXWoUFXqwqWJd1chUHYDFgOL4BRsJRY1Hu+0kZ
 cQ+qMYGm3PcRTfoGjLpUR3uLhlcuAoCDtzqlRqufKkBuUuq+h31CzQL+mdEgDvQu
 ZeTXLq9OO4JzNpLm3kC/sqievHVyCaXgdytfVfagP10YPL2NuazgYQctd7hIBLhl
 jtRPMQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj378-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6f75c1219so12272095ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324169; x=1788928969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bIdP3MyJvBiNaQACqfwwsKzexe7QSvciscpahroNaz8=;
 b=hvvaZlN1Sqz92ktwJOBUQ/FdX9UkmQ33EYZYAKJRx2p4rH6vGRFtJsmQ1aqh7V2Nzk
 +Zd4Ms+wKDseWS3xgjxN1yDvuSUeJToerlc2QJNA0G4kBzzX5af90ufErMrEGvCmag7m
 0l/WLy2Mn3hKHYO7qh72hvFSJzeXwO+FPclO848iddJq+mAODKy8//rW+OUDW0vXpb0Y
 M7g2yTSgYwtY0PGr5ZMEI3sTXFhegcD9I1EmRNTZrxDkD6A7j2UCxL9CZ8WWuVBxtvJc
 Lzi0Iv/ldogCFkAPnlRQYUEskSHKvf/8umOz5Z4Lvk9M2QYA3l8Wc1cCAA8ZGOoMw1Ou
 r7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324169; x=1788928969;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bIdP3MyJvBiNaQACqfwwsKzexe7QSvciscpahroNaz8=;
 b=mxW5y7Xur+EMQYsemcp3O+CIZaHBOqOa9UY2e6o3CEvUiVR4LVDvGj6Z9Sg6Ocz5gz
 2w76etyrgQPJba7kYpwGlTv5hlCogDB0a1a2+EHVptdIgrlSRdIUrIpLkFuFc8F3UPKO
 VJKef1IIbURVuFG53qUrgOuK/dO0MCehapi5PD/impYCdkBFh8ec9Eisn2u095tAYDVN
 iJkFv2csgo2YeylpKZCf3zKaftojg9sM8vh/hZMGkPFt6tPxFZ86gZXPDq5KssPClB2c
 CYnRrSFj8Wdh7u67eXOuAxs7/bJ5VA9T4yzmSYfm+ee1VBo3HMCxTARLITwPNCd2RpG8
 Twwg==
X-Gm-Message-State: AFuF++k/IKYxXSTzzcFALbWa9gEMKyhULEp3WkSQxxo1UxABIl7jkNGo
 5p2UzyxTfS1P8VpEchek6h73Ibq/F6GHWhn8rGULZnvfbzyFd3xI5SmPY3pkGuHdPyN94dqjeMO
 jxIwYgOnM4iJORlTQBmi0JfyM+j0WUfKqLHibpVwlqch/EOfMnc9fedUqhip0bOg+AQ==
X-Gm-Gg: AYBFou0DOe6OnBt7TU4oepFCaqTM2tLdsd8AqmsZklVBGkTPYvsJW2R8x/2GWFKxIUy
 seS6MAFZfGxmy9oxeOR0PbXmLqRDSrOwje8swVyeXoZzlYmFnUcvYztXkZWfVOGpqa52Tbg0Viz
 ivzB1JLK4Qd5b4x+cw4lwhkDRXmxScT67dnjkYxVKMSsAws9S/mhO7RRJ4D3JsZxm/0MdUBNuhW
 FgdExnH3ho++U5V7mVuJHl4oRVMyKw5cj+ONsq2x8loylbydYfnDNgY1rCDsJD0aolvRcY5hO/4
 +rqPEjvqyIoBngyGZd/arrmMlkyhINVLmGrUg+vhxcxbidkL40QF/1QStivhmZAJGMwEIUxw2/m
 b/Ib6QSXTpGhaaknInetsBEV+S0iDKPV2twSCke87F6qGPjNi
X-Received: by 2002:a17:903:2b03:b0:2d8:d4cc:5bb2 with SMTP id
 d9443c01a7336-2daec75cd4dmr32286545ad.18.1788324168892; 
 Tue, 01 Sep 2026 21:42:48 -0700 (PDT)
X-Received: by 2002:a17:903:2b03:b0:2d8:d4cc:5bb2 with SMTP id
 d9443c01a7336-2daec75cd4dmr32286005ad.18.1788324168488; 
 Tue, 01 Sep 2026 21:42:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/28] semihosting: add APIs for chardev-aware guest fd routing
Date: Tue,  1 Sep 2026 21:42:08 -0700
Message-Id: <20260902044231.843004-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a949 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4trHgkiC9q-UxXHgwkcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: jwZ-3swsVY3HTvkhBMcQ82dp8BCiZaVh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX39UzrdyMd0Uy
 tU2ToGo+24vg00QxK3jROy8HdqPWKSyxLuz2zNKs3dQbovnDmd1gEKh8HCUM2M9FOFL91h/T1EE
 W49+QvXyZhw1pu6rvX+MMdYYLRSKUNA=
X-Proofpoint-GUID: jwZ-3swsVY3HTvkhBMcQ82dp8BCiZaVh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX9CVfWe5CA8+K
 hmw67/G6Pz5yYOivp/wz734d2ycuGJPC87ylzGWzfcXBjXzBWv3qEbA1tBXJqmwCxgS3VD/9ujQ
 Svs/VHKdxlix5tmhEP0s4Y4pkEiQUlx6O9VY1rHpwosSgghOzcBpdfhSlk+ZI72JQnXng9o2tpF
 Aln+mWqq46uVqvd5XO8I/YFi4ZO9bD8d5xAebQDIL3eVa7pjmuKscycMpNRgrTeSS8QoGMXlPHv
 N2ju+U7rUaNrM6ighMM+95C4CPxP1CHzz+lpjFCFpHsDXMeHpjuCNjVC59jUR9KGMzvLF8QwDZp
 RzgHo/Na18ZsK0BVa0eozFWDCSYY8ugtU42zZATD58MCV8JnWhiEE86QngeFY+EYhoxKqOXUYWk
 GXe1Tk5DgMfkZcZ0ystAqC/ixQlA3EQbeIVGvWD9WUJtcm7ADPB88Q3dWn53/5XgIlvxtLM3SnO
 d4X6Bl37mbGaM1GHtHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

QWRkIHFlbXVfc2VtaWhvc3RpbmdfY29uc29sZV9oYXNfY2hhcmRldigpIHRvIHF1ZXJ5IHdoZXRo
ZXIgdGhlCnNlbWlob3N0aW5nIGNvbnNvbGUgaXMgYmFja2VkIGJ5IGEgY2hhcmRldiwgYW5kIGNv
bnNvbGVfZ3Vlc3RmZCgpCnRvIGluaXRpYWxpemUgYSBndWVzdCBmaWxlIGRlc2NyaXB0b3IgYXMg
R3Vlc3RGRENvbnNvbGUuCgpUaGVzZSBBUElzIGVuYWJsZSBjYWxsZXJzIHRvIHJvdXRlIHNlbWlo
b3N0aW5nIEkvTyB0aHJvdWdoIGEgY2hhcmRldgpyYXRoZXIgdGhhbiBkaXJlY3RseSB0byBob3N0
IHN0ZGlvLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvc2VtaWhvc3RpbmcvY29uc29sZS5oIHwgOSAr
KysrKysrKysKIGluY2x1ZGUvc2VtaWhvc3RpbmcvZ3Vlc3RmZC5oIHwgOSArKysrKysrKysKIHNl
bWlob3N0aW5nL2NvbnNvbGUuYyAgICAgICAgIHwgNSArKysrKwogc2VtaWhvc3RpbmcvZ3Vlc3Rm
ZC5jICAgICAgICAgfCA4ICsrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NlbWlob3N0aW5nL2NvbnNvbGUuaCBiL2luY2x1ZGUv
c2VtaWhvc3RpbmcvY29uc29sZS5oCmluZGV4IDFjMTJlMTc4ZWUzLi5kNWYxNDllMjA4OCAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9zZW1paG9zdGluZy9jb25zb2xlLmgKKysrIGIvaW5jbHVkZS9zZW1p
aG9zdGluZy9jb25zb2xlLmgKQEAgLTU0LDQgKzU0LDEzIEBAIHZvaWQgcWVtdV9zZW1paG9zdGlu
Z19jb25zb2xlX2Jsb2NrX3VudGlsX3JlYWR5KENQVVN0YXRlICpjcyk7CiAgKi8KIGJvb2wgcWVt
dV9zZW1paG9zdGluZ19jb25zb2xlX3JlYWR5KHZvaWQpOwogCisvKioKKyAqIHFlbXVfc2VtaWhv
c3RpbmdfY29uc29sZV9oYXNfY2hhcmRldjoKKyAqCisgKiBSZXR1cm4gdHJ1ZSBpZiB0aGUgc2Vt
aWhvc3RpbmcgY29uc29sZSBpcyBiYWNrZWQgYnkgYSBjaGFyZGV2LgorICogV2hlbiB0cnVlLCBj
b25zb2xlIEkvTyBnb2VzIHRocm91Z2ggdGhlIGNoYXJkZXYgcmF0aGVyIHRoYW4KKyAqIGhvc3Qg
c3RkaW8uCisgKi8KK2Jvb2wgcWVtdV9zZW1paG9zdGluZ19jb25zb2xlX2hhc19jaGFyZGV2KHZv
aWQpOworCiAjZW5kaWYgLyogU0VNSUhPU1RfQ09OU09MRV9IICovCmRpZmYgLS1naXQgYS9pbmNs
dWRlL3NlbWlob3N0aW5nL2d1ZXN0ZmQuaCBiL2luY2x1ZGUvc2VtaWhvc3RpbmcvZ3Vlc3RmZC5o
CmluZGV4IGE3ZWExMDQxZWEwLi43NmNhMGZjZjFhNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zZW1p
aG9zdGluZy9ndWVzdGZkLmgKKysrIGIvaW5jbHVkZS9zZW1paG9zdGluZy9ndWVzdGZkLmgKQEAg
LTcwLDYgKzcwLDE1IEBAIEd1ZXN0RkQgKmdldF9ndWVzdGZkKGludCBndWVzdGZkKTsKICAqLwog
dm9pZCBhc3NvY2lhdGVfZ3Vlc3RmZChpbnQgZ3Vlc3RmZCwgaW50IGhvc3RmZCk7CiAKKy8qKgor
ICogY29uc29sZV9ndWVzdGZkOgorICogQGd1ZXN0ZmQ6IEd1ZXN0RkQgaW5kZXgKKyAqCisgKiBJ
bml0aWFsaXplIHRoZSBHdWVzdEZEIGZvciBAZ3Vlc3RmZCB0byBHdWVzdEZEQ29uc29sZS4KKyAq
IEkvTyB3aWxsIGJlIHJvdXRlZCB0aHJvdWdoIHRoZSBzZW1paG9zdGluZyBjb25zb2xlIGNoYXJk
ZXYuCisgKi8KK3ZvaWQgY29uc29sZV9ndWVzdGZkKGludCBndWVzdGZkKTsKKwogLyoqCiAgKiBz
dGF0aWNmaWxlX2d1ZXN0ZmQ6CiAgKiBAZ3Vlc3RmZDogR3Vlc3RGRCBpbmRleApkaWZmIC0tZ2l0
IGEvc2VtaWhvc3RpbmcvY29uc29sZS5jIGIvc2VtaWhvc3RpbmcvY29uc29sZS5jCmluZGV4IDkx
ZTVkNTBkNTAyLi45ZDc4NjgzMzU2NCAxMDA2NDQKLS0tIGEvc2VtaWhvc3RpbmcvY29uc29sZS5j
CisrKyBiL3NlbWlob3N0aW5nL2NvbnNvbGUuYwpAQCAtMTA4LDYgKzEwOCwxMSBAQCBpbnQgcWVt
dV9zZW1paG9zdGluZ19jb25zb2xlX3JlYWQoQ1BVU3RhdGUgKmNzLCB2b2lkICpidWYsIGludCBs
ZW4pCiAgICAgcmV0dXJuIHJldDsKIH0KIAorYm9vbCBxZW11X3NlbWlob3N0aW5nX2NvbnNvbGVf
aGFzX2NoYXJkZXYodm9pZCkKK3sKKyAgICByZXR1cm4gY29uc29sZS5jaHIgIT0gTlVMTDsKK30K
KwogaW50IHFlbXVfc2VtaWhvc3RpbmdfY29uc29sZV93cml0ZSh2b2lkICpidWYsIGludCBsZW4p
CiB7CiAgICAgaWYgKGNvbnNvbGUuY2hyKSB7CmRpZmYgLS1naXQgYS9zZW1paG9zdGluZy9ndWVz
dGZkLmMgYi9zZW1paG9zdGluZy9ndWVzdGZkLmMKaW5kZXggZThmMjM2YzY5MGMuLjhiNTc3MGJh
YjBkIDEwMDY0NAotLS0gYS9zZW1paG9zdGluZy9ndWVzdGZkLmMKKysrIGIvc2VtaWhvc3Rpbmcv
Z3Vlc3RmZC5jCkBAIC0xMTcsNiArMTE3LDE0IEBAIHZvaWQgYXNzb2NpYXRlX2d1ZXN0ZmQoaW50
IGd1ZXN0ZmQsIGludCBob3N0ZmQpCiAgICAgZ2YtPmhvc3RmZCA9IGhvc3RmZDsKIH0KIAordm9p
ZCBjb25zb2xlX2d1ZXN0ZmQoaW50IGd1ZXN0ZmQpCit7CisgICAgR3Vlc3RGRCAqZ2YgPSBkb19n
ZXRfZ3Vlc3RmZChndWVzdGZkKTsKKworICAgIGFzc2VydChnZik7CisgICAgZ2YtPnR5cGUgPSBH
dWVzdEZEQ29uc29sZTsKK30KKwogdm9pZCBzdGF0aWNmaWxlX2d1ZXN0ZmQoaW50IGd1ZXN0ZmQs
IGNvbnN0IHVpbnQ4X3QgKmRhdGEsIHNpemVfdCBsZW4pCiB7CiAgICAgR3Vlc3RGRCAqZ2YgPSBk
b19nZXRfZ3Vlc3RmZChndWVzdGZkKTsKLS0gCjIuMzQuMQoK

