Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9950BC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coN-000088-It; Wed, 02 Sep 2026 00:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coM-00006V-0z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coJ-0000Jt-69
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824M1Vs2982864
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 duQyVDjHvCwWfJ8/fDnqIo03r/fNqO+pyLmoWy36RGE=; b=hsXDBVyCG5hqKBrE
 zrJg4OoGnjC1NDKzjryifJov0CmbXV/DQirTRcTvSuZLJeeCq209Yo4JVpvL7KCO
 9J0HocrHSnOi1I0CVoo/EJy3VPQxY4JBS9bI3HJxg2E34+MB/czk2R2Rxc6WPrxU
 EXG3sP4bvYF+x4egjYNh0LML96F3j3UyO4wNmY5u6HkUijNS9le7SafsN5Hczlko
 fyEz+ZZf1It8mrHfCgDRhNRogQ+mu7+O68Fdocf97ta3grSTQTQc5xhzkDFYX0ze
 sE630gnrQ0d7vP37vLmSrXamWE+J67PeCWdSd+Jh/x724jNODOAAMndeRuRL2doa
 pJNVcw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25rk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so731420a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324170; x=1788928970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=duQyVDjHvCwWfJ8/fDnqIo03r/fNqO+pyLmoWy36RGE=;
 b=e46sFtKK0Z3eJh7IMs/BdubzLqczZcUH5mK8/pLbgG+UW75trNAsSRMJBYmzb6M1sf
 haQeuJ6FOl2nyMHVoINsNy6nYEeioOQGXp0BQxCMtur6W4AXFeA+JGVtFYk3mutD0Wzh
 2rXRAacPISL4pUd6NZeSAn2WkbkKGZtY78KVK7y+NJ5xTjVVRA7oyi4HmoFroMGdtnbJ
 eVFwrhDATPPGsY6I8EZgBT5X6HA4FpDMz+BokFGggtrwGtRfkQiqRjL+4lIcNsHtBY4j
 mfQ0dUCKLkrCc/PjZbN8TWwWE5gAgbXQSxWK+ElU6UsvQvqvq3mAO7VxGtwyxQeos12L
 y3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324170; x=1788928970;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duQyVDjHvCwWfJ8/fDnqIo03r/fNqO+pyLmoWy36RGE=;
 b=p2Bwf/cXlhQdlH5T6BiCluOT8IV1p2V/jdrL8bnUU/KKYdHIW/udUdO9ZIIt9xGIE/
 700FcmVeRG4i0+5WHLinR232Tc7eki90tZbl3fNDhGGCz976waZTq4m5ns9BX0qLR5Af
 g291dHn/UWVH3oghRPUBrDqXzkVMjp0wdQn2LQQP7Ee40GcW3HU6IQA1IuRriyifEktB
 uGur/RnzR1y7PEssXp+zJ4hqrcatjbBcGOGoEk6IqizVo87oRKqoYhvlL8ZHN1tD0HG2
 qbhV//SbC8XFcHTRVJZz0QgYLSZ0j6Bb/sceGwFrfOFKTvZj+I5/HqQN+p924yETZEtn
 Mx3w==
X-Gm-Message-State: AFuF++leFc+q3cUOd2P0qhEbKc2XP98uMkE8P0zIksq9CF9JTdYMlgHl
 8Ag3JSIK0Ho2Cp8/2mwVOsfH6lGRaKDzbNTsHKUq5aRcaZAOJrEa3EhtIlncdJKu485EgsuG3km
 4gI+4VmY8pZui9skhlLMkJyVxdTJ7mEUF6Ari+ACKThbaS6gQa2z+cnCTPOrTsc+zSA==
X-Gm-Gg: AR+sD10fxTWYy1kdE8naFUNGv14rIbOoXfAhwmS4PlvTuIHIuwR/sEV4rc7X441Yoam
 1ubR2nJtnXRkUM1eWo7Fudey9kt2L6aZnyBwTUFdiisEj77PtXD5er0ZJqZTA7MYZyJDYpR2HSb
 SJ9dY9uVG7noGnFsuNBA1BrrGSvLv0etm6fbviIZqN9RqkStqr/ZCWRcNesZioDOzEk3dMz41+7
 adCqlgEfEFohQRrOV5573KlRy5D0uCQWkSOqHSmRtZkjad/r5yVYLFKEzJHHL7zDka/y3kpEsgz
 VGfPWOPcUKBud3i7J7WIe4XnSqQvNWzzuzQu3rCqQzD1WeWpe6N6XsPtCW5OpL/VGKfrjYVf24O
 bKZoa0X4NENWKL6ZvXfwIKTbTyzXQtitIiXmjYenBh+31xuYw
X-Received: by 2002:a05:6a20:9392:b0:3d3:ae1f:d7f5 with SMTP id
 adf61e73a8af0-3d9afe1762emr3031890637.21.1788324170375; 
 Tue, 01 Sep 2026 21:42:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:9392:b0:3d3:ae1f:d7f5 with SMTP id
 adf61e73a8af0-3d9afe1762emr3031847637.21.1788324169936; 
 Tue, 01 Sep 2026 21:42:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 06/28] semihosting: add callback to set error
Date: Tue,  1 Sep 2026 21:42:09 -0700
Message-Id: <20260902044231.843004-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX9UaOPNFUSZ+b
 z2YnNIWIJuarU9W1zvpxBJeYjOrvudTfWssaPNmKn/lNXlTwNlLDrC8OKY0iqq0EQUVKFv8B9bY
 UTbbSYzqaWG8vuCOkWj/aOCzeIjnfY0GT/ofgxBGRcfMkhIQLHV44NN3PLuibQOLE7dHBC7MZBe
 YmTnRgsHOadQXYyY2rs8r7uUQZzLe+caQ7wvAntgnuux5XP8Xjr49mpcSDQwmaC8VYuW4bRg0BY
 d1VfQdcY0h4gE+39ZlvEmujwwBW7B1ePVpLuNCywKbc1UPtZAAQUwjmwRigppvapnCamc6/JSr4
 fhayLKXgGRVoodQjCTAn6j6pbJP9ePVXczeZsZtBqlRle9jiQxLRCL9rnWGKOIVWwaTJOkSNHSC
 CQVcvRmEppXdS4tk4QVKHG3GAtLkY9MhxZ5efxYDhbOjZmKO5izDXN/CNsX9gFw/9uI7sl/UNBg
 gFWewlK9hCgcbDPYTug==
X-Proofpoint-GUID: vtDrKVsenTZoBb16vCH_XFfmH7BMpFUQ
X-Proofpoint-ORIG-GUID: vtDrKVsenTZoBb16vCH_XFfmH7BMpFUQ
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a94b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8ndNYmkutmpv_8xOvXsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX+ADs4W0phh5B
 7GsJFxxw++NdjFtC/B/ynX9/L0ZI1c9aare4cgXaUXYRvoJbdKLMr4wBzZMPwAyDTqLqDqVwmtu
 pNbT8yqA2YVkl3K34zeavcgmDLjUZZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKVGhpcyBpcyBjdXJyZW50bHkgdW51c2VkIGJ5IGV4aXN0aW5nIHNlbWlo
b3N0aW5nIHRhcmdldHMsIGJ1dCBpdCB3aWxsIGJlCnVzZWQgYnkgaGV4YWdvbiBpbiB0aGUgZm9s
bG93aW5nIGNvbW1pdC4KClJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSA8ZGFu
aWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZh
cmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQog
aW5jbHVkZS9zZW1paG9zdGluZy9jb21tb24tc2VtaS5oIHwgMSArCiBzZW1paG9zdGluZy9hcm0t
Y29tcGF0LXNlbWkuYyAgICAgfCAxICsKIHRhcmdldC9hcm0vY29tbW9uLXNlbWktdGFyZ2V0LmMg
ICB8IDQgKysrKwogdGFyZ2V0L3Jpc2N2L2NvbW1vbi1zZW1pLXRhcmdldC5jIHwgNCArKysrCiA0
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3Nl
bWlob3N0aW5nL2NvbW1vbi1zZW1pLmggYi9pbmNsdWRlL3NlbWlob3N0aW5nL2NvbW1vbi1zZW1p
LmgKaW5kZXggYWE1MTFhNDZmNDIuLmExMTkwNWVmNGVmIDEwMDY0NAotLS0gYS9pbmNsdWRlL3Nl
bWlob3N0aW5nL2NvbW1vbi1zZW1pLmgKKysrIGIvaW5jbHVkZS9zZW1paG9zdGluZy9jb21tb24t
c2VtaS5oCkBAIC0zNyw2ICszNyw3IEBACiB2b2lkIGRvX2NvbW1vbl9zZW1paG9zdGluZyhDUFVT
dGF0ZSAqY3MpOwogdWludDY0X3QgY29tbW9uX3NlbWlfYXJnKENQVVN0YXRlICpjcywgaW50IGFy
Z25vKTsKIHZvaWQgY29tbW9uX3NlbWlfc2V0X3JldChDUFVTdGF0ZSAqY3MsIHVpbnQ2NF90IHJl
dCk7Cit2b2lkIGNvbW1vbl9zZW1pX3NldF9lcnIoQ1BVU3RhdGUgKmNzLCBpbnQgZXJyKTsKIGJv
b2wgaXNfNjRiaXRfc2VtaWhvc3RpbmcoQ1BVQXJjaFN0YXRlICplbnYpOwogYm9vbCBjb21tb25f
c2VtaV9zeXNfZXhpdF9pc19leHRlbmRlZChDUFVTdGF0ZSAqY3MpOwogdWludDY0X3QgY29tbW9u
X3NlbWlfc3RhY2tfYm90dG9tKENQVVN0YXRlICpjcyk7CmRpZmYgLS1naXQgYS9zZW1paG9zdGlu
Zy9hcm0tY29tcGF0LXNlbWkuYyBiL3NlbWlob3N0aW5nL2FybS1jb21wYXQtc2VtaS5jCmluZGV4
IDVlNWYxODFiOTA4Li5jNTQ3NTNmNjk2ZiAxMDA2NDQKLS0tIGEvc2VtaWhvc3RpbmcvYXJtLWNv
bXBhdC1zZW1pLmMKKysrIGIvc2VtaWhvc3RpbmcvYXJtLWNvbXBhdC1zZW1pLmMKQEAgLTIzNyw2
ICsyMzcsNyBAQCBzdGF0aWMgdm9pZCBjb21tb25fc2VtaV9jYihDUFVTdGF0ZSAqY3MsIHVpbnQ2
NF90IHJldCwgaW50IGVycikKICAgICAgICAgdHMtPnN3aV9lcnJubyA9IGVycjsKICNlbHNlCiAg
ICAgICAgIHN5c2NhbGxfZXJyID0gZXJyOworICAgICAgICBjb21tb25fc2VtaV9zZXRfZXJyKGNz
LCBlcnIpOwogI2VuZGlmCiAgICAgfQogICAgIGNvbW1vbl9zZW1pX3NldF9yZXQoY3MsIHJldCk7
CmRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NvbW1vbi1zZW1pLXRhcmdldC5jIGIvdGFyZ2V0L2Fy
bS9jb21tb24tc2VtaS10YXJnZXQuYwppbmRleCAyYjc3Y2U5YzE3Yi4uMzhkNTJkZWIzZDYgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9hcm0vY29tbW9uLXNlbWktdGFyZ2V0LmMKKysrIGIvdGFyZ2V0L2Fy
bS9jb21tb24tc2VtaS10YXJnZXQuYwpAQCAtMzQsNiArMzQsMTAgQEAgdm9pZCBjb21tb25fc2Vt
aV9zZXRfcmV0KENQVVN0YXRlICpjcywgdWludDY0X3QgcmV0KQogICAgIH0KIH0KIAordm9pZCBj
b21tb25fc2VtaV9zZXRfZXJyKENQVVN0YXRlICpjcywgaW50IGVycikKK3sKK30KKwogYm9vbCBj
b21tb25fc2VtaV9zeXNfZXhpdF9pc19leHRlbmRlZChDUFVTdGF0ZSAqY3MpCiB7CiAgICAgcmV0
dXJuIGlzX2E2NChjcHVfZW52KGNzKSk7CmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY29tbW9u
LXNlbWktdGFyZ2V0LmMgYi90YXJnZXQvcmlzY3YvY29tbW9uLXNlbWktdGFyZ2V0LmMKaW5kZXgg
YWVhZWI4OGQ1MzYuLjM4YTAwZTE2MGMzIDEwMDY0NAotLS0gYS90YXJnZXQvcmlzY3YvY29tbW9u
LXNlbWktdGFyZ2V0LmMKKysrIGIvdGFyZ2V0L3Jpc2N2L2NvbW1vbi1zZW1pLXRhcmdldC5jCkBA
IC0yNiw2ICsyNiwxMCBAQCB2b2lkIGNvbW1vbl9zZW1pX3NldF9yZXQoQ1BVU3RhdGUgKmNzLCB1
aW50NjRfdCByZXQpCiAgICAgZW52LT5ncHJbeEEwXSA9IHJldDsKIH0KIAordm9pZCBjb21tb25f
c2VtaV9zZXRfZXJyKENQVVN0YXRlICpjcywgaW50IGVycikKK3sKK30KKwogYm9vbCBpc182NGJp
dF9zZW1paG9zdGluZyhDUFVBcmNoU3RhdGUgKmVudikKIHsKICAgICByZXR1cm4gcmlzY3ZfY3B1
X214bChlbnYpICE9IE1YTF9SVjMyOwotLSAKMi4zNC4xCgo=

