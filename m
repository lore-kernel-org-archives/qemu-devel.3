Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C1C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coo-0000Ko-Gz; Wed, 02 Sep 2026 00:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1col-0000Je-Ig
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coj-0000Me-Us
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTI2F2982875
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qewLIFfOi6lHQJ/9/MZcPmzrBcWMeQOFjUtVSbqXWyM=; b=XsQ33E/Dwj6ukhEU
 mK4tUtYcqlgQCVRHNR0b8gRI41lc0T3ROsP3GPYeJIyfygEbun09RJID7/Rw2WIU
 3qHEBakNM30uE/zumRl6zlY2U7v26VQKXvUfij46knDhxB1MM9oqcu9IP1HlZl67
 yMXY1RFXTcSMNg2sY+d/XrwM+i+kKe8wX+ssGhcyizNpdl/bujkGeWyTVTrJqMx3
 n9UZCOvN4s8bble8p9AydXJGq5BATbo1X2CnlMaPynDwpbKs8Ti7iSZjIqu276nB
 tyUgDZ35YDpD8BiNMQbPNiEPbtj9S2sMkcGBbI4xJDymB54f7jFnSR1iSSbVeC4c
 eDZ5ZQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25tk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398d292eac1so1241274a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324189; x=1788928989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qewLIFfOi6lHQJ/9/MZcPmzrBcWMeQOFjUtVSbqXWyM=;
 b=duITfr1HsEfR1xH4NcVX68SSgBnuy3vymaZiYb2q8wxAvRdY2QqebmqEfniZM+3pC7
 YE778vtz5shfcLblAjducCRsp5izwCfeSTEy0RqzH7ahTqWMnv4Uzk0NQGL04LjM7x8X
 jxSpb2twiPTP2TA9oOnUfOF9rfANt1+c77mcM+voeUYoGsbQzLvBtPVwHSeAAQbpQ5e5
 HuAmDMuzfOljUV1w5BVBiB6nKxt+tXGFoawlwTb8dlDh49kDizQrvgXEyBuntmCdtSxM
 p2I5c276kXNdKJ5lODH8reKRDoRgfUHAI5hnXFg2ecTI5KaTwWiywZDkcr5SN7oof3D0
 yQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324189; x=1788928989;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qewLIFfOi6lHQJ/9/MZcPmzrBcWMeQOFjUtVSbqXWyM=;
 b=o6K/jccTWO3oBvEXeXkKE/MleP8HW8Um7J1Jb0juY7Oiq2au5ZM97rIiM2q5AMNxGi
 u1ZFlzNmM7KJZaGRA2suMLCMCZGZp0hIrLgMbS3ryOfo+LJ5AAqCyyHtrcIZYwGoclK4
 0Jyawhi6wzjID8+n9+MxyIV+X2kHDx3swcxzklARoBhcoE/zDbnF2s0m1xm6+bawWkXT
 vYCbBfSGz5id3x5A0vwp9NSO1tCPoU0zBWGupOhVq4Nbdy7QJnb2yNN0vLvpq01jLoBt
 cZ9dCOnJd9bREdZvB/3StdjVy9LIzR9hNYNtk6umcmNqfXyZxAOdCBQFeJ1Zh92S/ka2
 RmQw==
X-Gm-Message-State: AFuF++k32e/aH1SWi/RXTnQmlSmOf9slTcyR/3YhIlAblADZnHl7aMJR
 b6tBoPU7lh2Oc3L7px6uwwyk5fJGFK1UYafUwjrab9XQM+bm3jcSf9Kt+0NxRHIUxTUaiZDPenm
 qsFDpf39uDkPEUiy/5DcZNrACnW0nRCtka2wjXmN6ocV/AWyfvIxsTVetzzGmADYy8A==
X-Gm-Gg: AYBFou0rYKj3oYOCw9UX2WXoyS8SpjgV6wGJWBtk8bT8jp8O8Se+9svujDCA04Dhhkn
 2EDvmr59kF2ib/quM8pmutHGRBzb835jAFvXZEpYZQHmQw93WV6NdAdJOjlLGaN7Hf3IXYKZ85C
 nbIDtVNeyKOXEeY87Tz1f9rNgq4hiMuaU+/9G5uKeY9aeEuWcYPijjhufwCzXWFME0to4sl8HlV
 QrtSl8Y+q45pOHhau+K/lfesyo2py14DI/zYjocbr/2J3z9Crd8dbpg8wB+BDSYGjILwlDXWf4c
 CxR09Glj4hMqlX2PcOHJyESjn2bGBB7ktWzyitgW9qPsdWJTo7sCwgBxsjJPjqfKB6Q6Ow0sj2N
 44BeBvajd507jNUsK3GgVl+Lc1qOClMGkcIYstwLWORtrgDCo
X-Received: by 2002:a17:90b:3fc7:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39aee251837mr3417109a91.22.1788324189224; 
 Tue, 01 Sep 2026 21:43:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc7:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39aee251837mr3417059a91.22.1788324188770; 
 Tue, 01 Sep 2026 21:43:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/28] target/hexagon: guard writes to unimplemented guest
 registers
Date: Tue,  1 Sep 2026 21:42:20 -0700
Message-Id: <20260902044231.843004-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX4zV9JJqkFGtY
 fJxMu6Xmn3ibMkf3dR/Ic2BmvsMCrhyMGvUPuNNsE+juEZcqlVcUfm+eaaxKthu+WhWiqm1aMuB
 VDLIJyUgwlzcHWfxt0TBtzdzuhy3L+xGNV32XINKN4H4IrI/DLzdJptjgynTeIWTALuCH6P5n2C
 5oNSW01zfeUDcSTsMlxbkbCInaYn0uBX0GxM4tGK66YUm82VJ7U+M3mKl7oMq9hX+fF2O37by6w
 t97w6XRQFr8KQ5kSGVZugjp5o8lH9IpAprSCRJdCeK55Ff1UoVL8Y8orA3P8Weql2fD5Q+FGPEl
 ysX7TMWYkaLw1LWgY0flLlEsjyKwXox6E/H5E6C1xDPxXQL9FkBbVFfzjz2xZiFq5INAtdNIxkq
 2Lbb0TJLyW1UFSDrM2sxWLiGdfvMbYbR+rKKfxBkIxt+fUdc9XesOr6JGbo3ZYGcdUFHqGF/dS0
 49q//wIzA+l4eQhJG0A==
X-Proofpoint-GUID: 5IGkbFj_nPKMkzdWPOtuy7Ffl6-8bJbX
X-Proofpoint-ORIG-GUID: 5IGkbFj_nPKMkzdWPOtuy7Ffl6-8bJbX
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a95d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=q6_NcmobPIDMa4dJqmQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX6qijWI3ORQVl
 it2RiTHJ9xAzn0l+jb5RxBQYvaSYWY5nYsn5yX25pQW9TMJu5cj+DQ0Vo1SJsAlR5K/NUG3zSkO
 tqEpUwNshoonNErBMARkYYMKwKldYUQ=
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

R3Vlc3QgcmVnaXN0ZXIgRzQgYW5kIGFib3ZlIGhhdmUgUE1VLWlzaCBmZWF0dXJlcyB0aGF0IGFy
ZSB5ZXQKdG8gYmUgaW1wbGVtZW50ZWQuICBXZSdsbCBza2lwIHRoZXNlIHdoZW4gd2UgZW5jb3Vu
dGVyIHRoaXMgY29kZQpyYXRoZXIgdGhhbiBmYXVsdCBvbiBhbiBhc3NlcnRpb24uCgpOb3RlIHRo
YXQgdGhlIGdlbmVyYXRlZCBjYWxsIHRvIGdyZWdfd3JpdGFibGUoKSBoYXMgdGhlIHNpZGUtZWZm
ZWN0Cm9mIGRvaW5nIGEgTE9HX1VOSU1QIGZvciB0aGVzZSByZWdpc3RlciBhY2Nlc3Nlcy4KClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29t
bS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgIHwgIDQgKysrLQogdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSB8IDE4ICsrKysrKysrKysrKysrKysrLQogMiBmaWxlcyBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5k
ZXggMDBkZTJiMGQyZWMuLmQ4NjI4MzgzZjFkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtOTcsNyArOTcs
OSBAQCBib29sIGlzX2dhdGhlcl9zdG9yZV9pbnNuKERpc2FzQ29udGV4dCAqY3R4KTsKICNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0pCiB7Ci0gICAgYXNzZXJ0KHJudW0gPD0gSEVY
X0dSRUdfRzMpOworICAgIGlmIChybnVtID4gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgcmV0dXJu
OworICAgIH0KICAgICBjdHgtPmdyZWdfbG9nW2N0eC0+Z3JlZ19sb2dfaWR4XSA9IHJudW07CiAg
ICAgY3R4LT5ncmVnX2xvZ19pZHgrKzsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CmluZGV4IGUzM2Q0M2Uz
Y2UwLi5jMTgwYzE5YjA5MiAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0xMDk3LDExICsxMDk3LDI0
IEBAIGRlZiBhbmFseXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIp
KQogCiBjbGFzcyBHdWVzdFJlZ2lzdGVyKFJlZ2lzdGVyKToKLSAgICBwYXNzCisgICAgZGVmIGdl
bl9jaGVja19pbXBsKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgaWYgc2VsZi5pc193cml0dGVu
KCk6CisgICAgICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAgICAgICAg
aWYgKCFncmVnX3dyaXRhYmxlKGluc24tPnJlZ25vW3tyZWdub31dLAorICAgICAgICAgICAgICAg
ICAgICB7c3RyKHNlbGYuaXNfcGFpcigpKS5sb3dlcigpfSkpIHt7CisgICAgICAgICAgICAgICAg
ICAgIHJldHVybjsKKyAgICAgICAgICAgICAgICB9fQorICAgICAgICAgICAgIiIiKSkKKyAgICAg
ICAgZWxzZToKKyAgICAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAgICAgICAgICAg
ICAgICBjaGVja19ncmVnX2ltcGwoaW5zbi0+cmVnbm9be3JlZ25vfV0sCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHtzdHIoc2VsZi5pc19wYWlyKCkpLmxvd2VyKCl9KTsKKyAgICAg
ICAgICAgICIiIikpCiAKIGNsYXNzIEd1ZXN0RGVzdChHdWVzdFJlZ2lzdGVyLCBTaW5nbGUsIERl
c3QpOgogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgc2Vs
Zi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCisgICAgICAgIHNlbGYuZ2VuX2NoZWNrX2ltcGwoZiwg
cmVnbm8pCiAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKICAgICAgICAgICAgIFRDR3Zf
aTMyIHtzZWxmLnJlZ190Y2coKX0gPSB0Y2dfdGVtcF9uZXdfaTMyKCk7CiAgICAgICAgICIiIikp
CkBAIC0xMTIxLDYgKzExMzQsNyBAQCBkZWYgZGVjbF9yZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToK
ICAgICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwgZiwgdGFnLCByZWdubyk6CiAg
ICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQorICAgICAgICBzZWxmLmdlbl9jaGVj
a19pbXBsKGYsIHJlZ25vKQogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAg
ICAgICBUQ0d2X2kzMiB7c2VsZi5yZWdfdGNnKCl9ID0gdGNnX3RlbXBfbmV3X2kzMigpOwogICAg
ICAgICAgICAgZ2VuX3JlYWRfZ3JlZyh7c2VsZi5yZWdfdGNnKCl9LCB7c2VsZi5yZWdfbnVtfSk7
CkBAIC0xMTMxLDYgKzExNDUsNyBAQCBkZWYgYW5hbHl6ZV9yZWFkKHNlbGYsIGYsIHJlZ25vKToK
IGNsYXNzIEd1ZXN0UGFpckRlc3QoR3Vlc3RSZWdpc3RlciwgUGFpciwgRGVzdCk6CiAgICAgZGVm
IGRlY2xfdGNnKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251
bShmLCByZWdubykKKyAgICAgICAgc2VsZi5nZW5fY2hlY2tfaW1wbChmLCByZWdubykKICAgICAg
ICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAogICAgICAgICAgICAgVENHdl9pNjQge3NlbGYucmVn
X3RjZygpfSA9IHRjZ190ZW1wX25ld19pNjQoKTsKICAgICAgICAgIiIiKSkKQEAgLTExNTAsNiAr
MTE2NSw3IEBAIGRlZiBkZWNsX3JlZ19udW0oc2VsZiwgZiwgcmVnbm8pOgogICAgICAgICAiIiIp
KQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgc2VsZi5k
ZWNsX3JlZ19udW0oZiwgcmVnbm8pCisgICAgICAgIHNlbGYuZ2VuX2NoZWNrX2ltcGwoZiwgcmVn
bm8pCiAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKICAgICAgICAgICAgIFRDR3ZfaTY0
IHtzZWxmLnJlZ190Y2coKX0gPSB0Y2dfdGVtcF9uZXdfaTY0KCk7CiAgICAgICAgICAgICBnZW5f
cmVhZF9ncmVnX3BhaXIoe3NlbGYucmVnX3RjZygpfSwge3NlbGYucmVnX251bX0pOwotLSAKMi4z
NC4xCgo=

