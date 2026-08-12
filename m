Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB717C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7I-000551-7h; Wed, 12 Aug 2026 11:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6m-0004QU-3J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6j-0000Kc-Af
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDcBDT3972558
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=rdDlY3qU/0LNS95L7DbZFHoCyOTCmkgkmMGMvOgfJX0=; b=CR
 hk2LzLFzh+DcSF2Jid0FocQ+oc+v9RGgd5d/Dw3CQCHxkQ1o4QcmHB55Yh/4UCc8
 CGdXJptoRzE4OshibzIhVfyfXCvcd2nW9AYOcvUo5YLkbWw5ZRQtXUN+bfjWrtWi
 +VqCV300bvS7z6AjgFMjBxsoolSEbDRTLSaJIajYDjnE520GvRG0EJrVWSNh47j3
 tOfAnLRzjx3DoIPDi0/ZUQNCG1Ayqr+uejGvs4MyOOZBNXY7ivI6k2vf0RbsA3xQ
 xVn14QdhurzDrCfoq8VJJNzZbTvwKvGHoygpKQ2zO1neTGmJpKHWGpvuGfR6j/oh
 rZzKmmsp8facYbpHypQg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrjjap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so924619a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549387; x=1787154187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rdDlY3qU/0LNS95L7DbZFHoCyOTCmkgkmMGMvOgfJX0=;
 b=kO/vXMPjDd/W+cyjxK79zic8vGDKgnf4vZknYysE7IVp/8Rg0j7/cOXdvobsMiD0Zt
 LP2DVRa0SbjzvtjPZZrKCgsuBy/hEG/EFYKJxXZbzmzAbHiJqRSRE6Ya3SwNo5DMHkAR
 QAYIXsSp8VRiPKtbUmUclCbaoBwZfVBDGoCl2kP1jqRjxLM8ZMqUOrWH7yboqtJMgLhr
 I//F9y9PQY7yMKl4/3V06nhqkrmkANp7C9+70YB+XjPyX9ufHz9EkwjjTeUsWCDLOH25
 /s7xXgVg7zLcAFVQbjyFswqh1lSn1vwA++z8WwjFmQ0lFM11tP6DngiCCpxQBsmcGszN
 qorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549387; x=1787154187;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rdDlY3qU/0LNS95L7DbZFHoCyOTCmkgkmMGMvOgfJX0=;
 b=siHlkYlGey/KQW1LCS2UvZTGl+6TiWdQfWQ0MwXyICTviS89vOE4n2CZBu0j+4iQ1e
 tSDnPWUv6pcAErL2wdlf8inDuQHSumEI07H8ybnhAkGAZDM9hAl8enAsbNMw8/5Ae2Yt
 5IkpZyXCJVVYCnmlRQe9qllczPu7ZJIQFue4HbnZR+b8tFQf0dwUPT8EAPbOpyJew/zz
 9NcHrOhdtwCIPRSuaHhmkNTBNVMYXZwmXmwrk8C1tnjI2Icxj4NhpVKMpPaWI876rsOP
 ZhZMOsFTtv01Wv3M2sWmCPvONCV44zbWb2e3MwvqqcbQP38egFOFE/UFNEBDkcinPok1
 rxxg==
X-Gm-Message-State: AOJu0Yw4AckrTfFPStxGs+UgptzIi30juKyArOBS9MNZp1ThLDV+wqJ4
 dMoafN0uX7MvUO+Q9z6o//Vy3cUdKWObg0uoeGaeqPayCT8w7vQF+9t7hY0UA6q+FLU/xMD711m
 mrsnCS0kMOu6bi3O+ZF74xzVCVgcCEkbpl82sfK+043/+y7M6AvEeYDOtlS4H6VaZng==
X-Gm-Gg: AR+sD13rU56o0O/V2e2sbY+kSdJVMTBJyZids0NDDIJTD9J0pvMv3J74HyjBFHEUKHj
 M6NkI2htX3BY+i7pjRIdlm/w46Cq32tWt5a7CMJRlFJUB0NuyGFDgWx7fUmSUiD9Do+dc8xc0yc
 iv8Eqn57oNxDavfIeNMMnTkN/UzNnZy4xEiD7tkPSLc8gtC8X7JKwOWjX7TZvDQg0KwsR8JRkO7
 auBdLuGHXr1A6AZiIe4fBtyWUplgIXioJqGlUGNCKj2cAdXKIPsZJSme3YQbc7PcktkEaeWIA2c
 dwSpP+jeB5mBcBHTW3QpDUN+AfhTCgMrk+qV/fm7WKHKPV9wBW8Y9bslCvCsTqVpzznO83IMOfk
 Fj0U+7w/C7NvZQzzdURz/v5DrAzkTBh+J6Y2Ui9SbTh2UGbNh
X-Received: by 2002:a05:6a21:6f87:b0:3bf:a543:e7f5 with SMTP id
 adf61e73a8af0-3cc3f53a5aemr7642836637.3.1786549387326; 
 Wed, 12 Aug 2026 08:43:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f87:b0:3bf:a543:e7f5 with SMTP id
 adf61e73a8af0-3cc3f53a5aemr7642795637.3.1786549386893; 
 Wed, 12 Aug 2026 08:43:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 19/41] host-utils: fix ssub32/64_saturate return type and
 clamp direction
Date: Wed, 12 Aug 2026 08:41:58 -0700
Message-Id: <20260812154220.1029828-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX5ih2xJrnaenE
 oMucKYXmY6SZW4vBQDTL8Tc5oUA/5bihoZ465PUQvbKisVtvkbQT1llVn6REn83kETNLvTqax1K
 kMbyZwt1pfpodh0uMVffv2/F6N1pjOQzbuI1U/Bog/regTbVJFY7slqlY8bxZQGYZMlbles2x7p
 KIYn7NmdpW3N+QGnD6yWYoxCJYNVk310XSlnwj7UBihdeqB0BiRg+XBGYpeRHIwIij50sjSL7RW
 bP3BeF6MwyXQYLUd1Dc45Y7x9Cun289khUlAm0QJWFolK46R+l4YxE2QlrEZ9BtB8YkW7nQcU9E
 PZRv4AE8HhxljiO/FTTb9icuOT912jpzUWxsQjTDm5MtyBA6h02UEixAstiJnFRXifRV27saxeC
 CpO4BV2OdqnlHyr3EuxD9Z33jCv1BhVSw/qjxmu1/qlUh4ZcM20hAsimh3vMIBndOgsFJJDkJpI
 V7vBibpJoobfcxRZqZA==
X-Proofpoint-ORIG-GUID: Ptyo8mHDA_n2e22MibHtv1vMBNXMtC3Z
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c948c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=kM50MvNqywxRmdRKJWUA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Ptyo8mHDA_n2e22MibHtv1vMBNXMtC3Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX/f8GFq0gupjM
 Phn+SBjYpbhxDit0Nl/rx/YK2KQVffAR6x9qyMwx0XhOW6sOzpo47cpIQJ8wrx6nDinRET9JHUx
 IdPBwRD/gGWhXMe1R6o2LLrIV5u/Ry4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

c3N1YjMyX3NhdHVyYXRlKCkgYW5kIHNzdWI2NF9zYXR1cmF0ZSgpIHdlcmUgZGVjbGFyZWQgdG8g
cmV0dXJuIGJvb2wKaW5zdGVhZCBvZiBpbnQzMl90L2ludDY0X3QsIGFuZCBjbGFtcGVkIHRvIHRo
ZSB3cm9uZyBib3VuZCBvbiBvdmVyZmxvdy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+CkNjOiBxZW11LXN0YWJsZUBub25nbnUu
b3JnCkZpeGVzOiAxNjQ5NTUzMzEzMSAoImhvc3QtdXRpbHM6IEludHJvZHVjZSBzaWduZWQgc2F0
dXJhdGlvbiBwcmltaXRpdmVzIikKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI2MDgwNzE1MjI0MS4xNTc2MzM0LTItYnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBpbmNsdWRlL3FlbXUvaG9zdC11dGlscy5oIHwgMjQgKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2hvc3QtdXRpbHMuaCBiL2luY2x1ZGUv
cWVtdS9ob3N0LXV0aWxzLmgKaW5kZXggMmU4ZGE3ZmIzZDAuLjFkYjlkYmIxMzhlIDEwMDY0NAot
LS0gYS9pbmNsdWRlL3FlbXUvaG9zdC11dGlscy5oCisrKyBiL2luY2x1ZGUvcWVtdS9ob3N0LXV0
aWxzLmgKQEAgLTYwNywxMCArNjA3LDEwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB1bXVsNjRfb3Zl
cmZsb3codWludDY0X3QgeCwgdWludDY0X3QgeSwgdWludDY0X3QgKnJldCkKIH0KIAogLyoqCi0g
KiBzYWRkMzJfc2F0dXJhdGUgLSBhZGRpdGlvbiB3aXRoIHNhdHVyYXRpb24KKyAqIHNhZGQzMl9z
YXR1cmF0ZSAtIDMyLWJpdCBzaWduZWQgYWRkaXRpb24gd2l0aCBzYXR1cmF0aW9uCiAgKiBAeCwg
QHk6IGFkZGVuZHMKICAqCi0gKiBDb21wdXRlcyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhl
cm4gdGhhbiB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCisgKiBDb21wdXRlcyBAeCArIEB5LCBhbmQg
c2F0dXJhdGVzIHJhdGhlciB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KICAqLwogc3RhdGlj
IGlubGluZSBpbnQzMl90IHNhZGQzMl9zYXR1cmF0ZShpbnQzMl90IHgsIGludDMyX3QgeSkKIHsK
QEAgLTYyMiwxMCArNjIyLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50MzJfdCBzYWRkMzJfc2F0dXJh
dGUoaW50MzJfdCB4LCBpbnQzMl90IHkpCiB9CiAKIC8qKgotICogc2FkZDY0X3NhdHVyYXRlIC0g
YWRkaXRpb24gd2l0aCBzYXR1cmF0aW9uCisgKiBzYWRkNjRfc2F0dXJhdGUgLSA2NC1iaXQgc2ln
bmVkIGFkZGl0aW9uIHdpdGggc2F0dXJhdGlvbgogICogQHgsIEB5OiBhZGRlbmRzCiAgKgotICog
Q29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXJuIHRoYW4gdHJ1bmNhdGluZyB0
aGUgcmVzdWx0LgorICogQ29tcHV0ZXMgQHggKyBAeSwgYW5kIHNhdHVyYXRlcyByYXRoZXIgdGhh
biB0cnVuY2F0aW5nIHRoZSByZXN1bHQuCiAgKi8KIHN0YXRpYyBpbmxpbmUgaW50NjRfdCBzYWRk
NjRfc2F0dXJhdGUoaW50NjRfdCB4LCBpbnQ2NF90IHkpCiB7CkBAIC02MzcsMzEgKzYzNywzMSBA
QCBzdGF0aWMgaW5saW5lIGludDY0X3Qgc2FkZDY0X3NhdHVyYXRlKGludDY0X3QgeCwgaW50NjRf
dCB5KQogfQogCiAvKioKLSAqIHNzdWIzMl9zYXR1cmF0ZSAtIHN1YnRyYWN0aW9uIHdpdGggc2F0
dXJhdGlvbgorICogc3N1YjMyX3NhdHVyYXRlIC0gMzItYml0IHNpZ25lZCBzdWJ0cmFjdGlvbiB3
aXRoIHNhdHVyYXRpb24KICAqIEB4LCBAeTogYWRkZW5kcwogICoKLSAqIENvbXB1dGVzIEB4ICsg
QHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVybiB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KKyAq
IENvbXB1dGVzIEB4IC0gQHksIGFuZCBzYXR1cmF0ZXMgcmF0aGVyIHRoYW4gdHJ1bmNhdGluZyB0
aGUgcmVzdWx0LgogICovCi1zdGF0aWMgaW5saW5lIGJvb2wgc3N1YjMyX3NhdHVyYXRlKGludDMy
X3QgeCwgaW50MzJfdCB5KQorc3RhdGljIGlubGluZSBpbnQzMl90IHNzdWIzMl9zYXR1cmF0ZShp
bnQzMl90IHgsIGludDMyX3QgeSkKIHsKICAgICBpbnQzMl90IHJldDsKICAgICBpZiAoc3N1YjMy
X292ZXJmbG93KHgsIHksICZyZXQpKSB7Ci0gICAgICAgIHJldCA9IHggPCAwID8gSU5UMzJfTUFY
IDogSU5UMzJfTUlOOworICAgICAgICByZXQgPSB4IDwgMCA/IElOVDMyX01JTiA6IElOVDMyX01B
WDsKICAgICB9CiAgICAgcmV0dXJuIHJldDsKIH0KIAogLyoqCi0gKiBzc3ViNjRfc2F0dXJhdGUg
LSBzdWJ0cmFjdGlvbiB3aXRoIHNhdHVyYXRpb24KKyAqIHNzdWI2NF9zYXR1cmF0ZSAtIDY0LWJp
dCBzaWduZWQgc3VidHJhY3Rpb24gd2l0aCBzYXR1cmF0aW9uCiAgKiBAeCwgQHk6IGFkZGVuZHMK
ICAqCi0gKiBDb21wdXRlcyBAeCArIEB5LCBhbmQgc2F0dXJhdGVzIHJhdGhlcm4gdGhhbiB0cnVu
Y2F0aW5nIHRoZSByZXN1bHQuCisgKiBDb21wdXRlcyBAeCAtIEB5LCBhbmQgc2F0dXJhdGVzIHJh
dGhlciB0aGFuIHRydW5jYXRpbmcgdGhlIHJlc3VsdC4KICAqLwotc3RhdGljIGlubGluZSBib29s
IHNzdWI2NF9zYXR1cmF0ZShpbnQ2NF90IHgsIGludDY0X3QgeSkKK3N0YXRpYyBpbmxpbmUgaW50
NjRfdCBzc3ViNjRfc2F0dXJhdGUoaW50NjRfdCB4LCBpbnQ2NF90IHkpCiB7CiAgICAgaW50NjRf
dCByZXQ7CiAgICAgaWYgKHNzdWI2NF9vdmVyZmxvdyh4LCB5LCAmcmV0KSkgewotICAgICAgICBy
ZXQgPSB4IDwgMCA/IElOVDY0X01BWCA6IElOVDY0X01JTjsKKyAgICAgICAgcmV0ID0geCA8IDAg
PyBJTlQ2NF9NSU4gOiBJTlQ2NF9NQVg7CiAgICAgfQogICAgIHJldHVybiByZXQ7CiB9Ci0tIAoy
LjM0LjEKCg==

