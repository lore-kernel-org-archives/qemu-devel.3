Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9307EC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpht-0002tE-Kt; Thu, 06 Aug 2026 00:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphh-0002qT-K1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphg-0003D2-2w
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763x6UX1071254
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=; b=HS9HB2IggkTEMthn
 rIyrQnBNKUDs4kHC2duBuOAibzNgX3/0LrpZ+HUisZRunAR3wEfEhfXhAXVQVjUB
 /sXIQ+YsU2VyN2ySLxNgzGZ6gEeTGTvLZFaWr6pDKwVDkN+vp3FfxvWCpo1zMrIm
 XKNOD/Ss80olg6rxS7hhUEe4GZsJ2/HwmcnTKu8bvd2qvvM4NXhFBakoO6GcJlQW
 7H3JROz3wDZ8KqLrNhvy9qkZDtnjc8rAGxV1FdrU7v3alnFwI+3b3Xlp8veC0UhW
 dkpOp41KHHXcQ2Ba1mWPH3r3+Ka5sn0Gig+9crS46tnLyVkeGOGbXahY9iEXvEuC
 U5dxRQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjud02vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab041eced3so2598844a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990454; x=1786595254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=;
 b=W7srMRljCWVmsxSSw0MQ2Rmpzo29iWXrTNA85JDHVUB3huKDqtMd4yNtXJqMJRBacc
 my6+l+zFJgRTDi+IJq1s7Ozo8oTf9MF/4LwRxjUYsrYfeMqVQiE5yCqr9c6bGZLaUjJV
 5LvRC0TAUek+A8kXktmLiQ2e2W9ICBZjhDN1fpGhQbRzN6KR1vU7y40pO8OMKWXS6lhq
 AF3Tv23w6AzkfdwAbQybAcZrt0eKtqyAA2cG/g4+e9Jb5iBoN3lyX9lGdy59R3CarzQu
 tb1C0toNEAW/lAWSfEYmE05FNGQaV/FbhZJR/INrbZIIFKjI0Me4LNdYto3ekDvYPGS6
 XetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990454; x=1786595254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=;
 b=g1+Pljyo/owLCZM1RlMVkw1al+3a7LgLCHAolWBa6HpR4hfgy4VMJyuD8p1n9ym7Cj
 AqCF2pGUte08CItAsTD5lkc6Vf+Jlm4d7UrZbfSbwe/HCGc68Q8vuedBr0VUbk30i+WC
 CjOHKTfDkQUf7kaiNSeYTSVom0vkzhySHbzidMINlLj9BXmWowM+ubg1cyqEARnaDMUv
 rsLVs+61tVRbHwbpO7RzFM7nILYNcc5axUOn0ffhz3qgCSUT4+w8tLT4if7Hu4dPvAdu
 o32+BTxAW5NBb+Pr3KGmrAVb6kCVAUUgMHajJ5dyS3b7At9lx7hTAAwckAWShdEk/vsz
 gmlQ==
X-Gm-Message-State: AOJu0YyGP2mx8OUdai+V9ozs4UhgCGj8bpqClr37hadANBvVd+xc8HqX
 dwjAGO/QOYryQwIIUi30PelQJGKaqLPFiGHi2uRraHkmwwbJysOIi2KlqfpWixdV1+n7Vz0PlRL
 J08bn+mNhpXcJzTP9D5lTNCHN0IoXcWqSfU5HusXVsLaep4XmJx1Jq+G1wOvaobMYPw==
X-Gm-Gg: AR+sD10TmkOEaG066BCWlQT16HWPyqb3SGuTZeXBTVya/4XtUcz+xpi9T3s7nKenu4F
 2LUPSCLTNyCv0WZOcBAUVKmXlrHA2XFvkJwdv3Tn3Ebp2llnGuJuUSpw6OSxiyOVcfXOiBh29HR
 ysRW/JKSWmbEjitY84A33B0tncMsw9y5ezqzYqMCgcCaTvuzaIKWfRJS8GiYtp90lF+DcVmSYVm
 2I5JBdN3qL8/3ooA6yjjxgwDz1D4BYsbyRs0t9JDMFaq40n4G2GBzu7qjnYC0Vslaz8Wd5UJf0W
 07uk+A23ptAy8A4n2A2MsBoP2+TUhUEuZWilm3dp384bMIQJegerJDyQENiF4ebn6LB38zZIJsE
 5nnfKmDAPlfobvAv7HYBDmyfEQnamUf2RLB/oX857U3VPmWwr
X-Received: by 2002:a05:6a21:3a48:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cb85df12ddmr15161325637.2.1785990453862; 
 Wed, 05 Aug 2026 21:27:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a48:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cb85df12ddmr15161266637.2.1785990453416; 
 Wed, 05 Aug 2026 21:27:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 06/18] bitops.h: Add find_first_bit32()
Date: Wed,  5 Aug 2026 21:27:11 -0700
Message-Id: <20260806042723.3785369-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX1xP601kikoGM
 jv0qkXOX882I0XlURvRQEUjhiJolBsJk+ToDCqi+i41JHNBh/7Q7Gm+ZG0ajUhDtTPKBLiM4F7u
 6NXkrROjGHNzYTls3iLUgiRpJMmWs7gNptAj5hjLhDLm9WOlhpVKPInIQi0w3bu3lTVZTrk2ns0
 fteMejOqZ6gB8+6plG7/wI2vFWeGd7JDyEQQ2+yCfBccioklb2+qkQ6YOGixZWvZVZCoteUENPv
 EkVrrl7FgpY6d0l9GzE7huBGibwNmsTlb5fCH4IZa6oiC3N3gYUnb0JOAMAz+RVlzoAGQ4ZFu56
 gxOmHAeAD+9ageRs5G3HumBQNPXXQEZlvanVbH/+N5yPbLH1fxwPTINY/X+kcKO7Xi1mKgKmfQy
 hmsJmwj+M1OkWkSnNeGf2ZbhB10iKTo/7sJd792EX24k4afhiEHC08BVDbefzYe70EQjLAmeX22
 XwBzBxWMbFGfGRvp01Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX+Qgtl8xKYqaO
 ag1AMHrZWrIMML9gJb4/S0IwuB5wZtDJJFt+GYlC2+j1ikIqLUAmCoERqUuX8DEaLR9ZwSpwbYT
 bgiwA/N8WZf4ylQtoGGmn+9OeOtPurA=
X-Proofpoint-GUID: qV00s71kLRB1gxtNA80QzmCLuJDjAVbp
X-Proofpoint-ORIG-GUID: qV00s71kLRB1gxtNA80QzmCLuJDjAVbp
X-Authority-Analysis: v=2.4 cv=DeInbPtW c=1 sm=1 tr=0 ts=6a740d36 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

c2V0X2JpdDMyKCkvdGVzdF9iaXQzMigpL2V0YyBhbHJlYWR5IGxldCBkZXZpY2VzIG9wZXJhdGUg
b24KZ3Vlc3QtdmlzaWJsZSB1aW50MzJfdCByZWdpc3RlciBhcnJheXMgd2l0aG91dCBkZXBlbmRp
bmcgb24gdGhlIGhvc3QncwondW5zaWduZWQgbG9uZycgc2l6ZS4gIEFkZCBmaW5kX2ZpcnN0X2Jp
dDMyKCkgc28gY2FsbGVycyBuZWVkIG5vdCBjYXN0CmEgdWludDMyX3QgYXJyYXkgdG8gJ3Vuc2ln
bmVkIGxvbmcgKicuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9xZW11L2JpdG9wcy5oIHwgMzAgKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvYml0b3BzLmgg
Yi9pbmNsdWRlL3FlbXUvYml0b3BzLmgKaW5kZXggYzdiODM4YTYyODMuLmY3MzYzYTU0NzlmIDEw
MDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvYml0b3BzLmgKKysrIGIvaW5jbHVkZS9xZW11L2JpdG9w
cy5oCkBAIC00MywxMCArNDMsOSBAQAogICogYmUgc29tZSBndWVzdC12aXNpYmxlIHJlZ2lzdGVy
IHZpZXcgb2YgdGhlIGJpdCBhcnJheS4KICAqCiAgKiBXZSBkbyBub3QgY3VycmVudGx5IGltcGxl
bWVudCB1aW50MzJfdCB2ZXJzaW9ucyBvZiBmaW5kX2xhc3RfYml0KCksCi0gKiBmaW5kX25leHRf
Yml0KCksIGZpbmRfbmV4dF96ZXJvX2JpdCgpLCBmaW5kX2ZpcnN0X2JpdCgpIG9yCi0gKiBmaW5k
X2ZpcnN0X3plcm9fYml0KCksIGJlY2F1c2Ugd2UgaGF2ZW4ndCB5ZXQgbmVlZGVkIHRoZW0uIElm
IHlvdQotICogbmVlZCB0aGVtIHlvdSBzaG91bGQgaW1wbGVtZW50IHRoZW0gc2ltaWxhcmx5IHRv
IHRoZSAndW5zaWduZWQgbG9uZycKLSAqIHZlcnNpb25zLgorICogZmluZF9uZXh0X2JpdCgpLCBm
aW5kX25leHRfemVyb19iaXQoKSBvciBmaW5kX2ZpcnN0X3plcm9fYml0KCksCisgKiBiZWNhdXNl
IHdlIGhhdmVuJ3QgeWV0IG5lZWRlZCB0aGVtLiBJZiB5b3UgbmVlZCB0aGVtIHlvdSBzaG91bGQK
KyAqIGltcGxlbWVudCB0aGVtIHNpbWlsYXJseSB0byB0aGUgJ3Vuc2lnbmVkIGxvbmcnIHZlcnNp
b25zLgogICoKICAqIFlvdSBjYW4gZGVjbGFyZSBhIGJpdG1hcCB0byBiZSB1c2VkIHdpdGggdGhl
c2UgZnVuY3Rpb25zIHZpYSB0aGUKICAqIERFQ0xBUkVfQklUTUFQIGFuZCBERUNMQVJFX0JJVE1B
UDMyIG1hY3JvcyBpbiBiaXRtYXAuaC4KQEAgLTM4Miw2ICszODEsMjkgQEAgc3RhdGljIGlubGlu
ZSBpbnQgdGVzdF9iaXQzMihsb25nIG5yLCBjb25zdCB1aW50MzJfdCAqYWRkcikKICAgICByZXR1
cm4gMVUgJiAoYWRkcltCSVQzMl9XT1JEKG5yKV0gPj4gKG5yICYgMzEpKTsKIH0KIAorLyoqCisg
KiBmaW5kX2ZpcnN0X2JpdDMyIC0gZmluZCB0aGUgZmlyc3Qgc2V0IGJpdCBpbiBhIG1lbW9yeSBy
ZWdpb24KKyAqIEBhZGRyOiBUaGUgYWRkcmVzcyB0byBzdGFydCB0aGUgc2VhcmNoIGF0CisgKiBA
c2l6ZTogVGhlIG1heGltdW0gc2l6ZSB0byBzZWFyY2gKKyAqCisgKiBSZXR1cm5zIHRoZSBiaXQg
bnVtYmVyIG9mIHRoZSBmaXJzdCBzZXQgYml0LAorICogb3IgQHNpemUgaWYgdGhlcmUgaXMgbm8g
c2V0IGJpdCBpbiB0aGUgYml0bWFwLgorICovCitzdGF0aWMgaW5saW5lIHVpbnQzMl90IGZpbmRf
Zmlyc3RfYml0MzIoY29uc3QgdWludDMyX3QgKmFkZHIsIHVpbnQzMl90IHNpemUpCit7CisgICAg
dWludDMyX3QgcmVzdWx0OworCisgICAgZm9yIChyZXN1bHQgPSAwOyByZXN1bHQgPCBzaXplOyBy
ZXN1bHQgKz0gMzIpIHsKKyAgICAgICAgdWludDMyX3QgdG1wID0gKmFkZHIrKzsKKyAgICAgICAg
aWYgKHRtcCkgeworICAgICAgICAgICAgcmVzdWx0ICs9IGN0ejMyKHRtcCk7CisgICAgICAgICAg
ICByZXR1cm4gcmVzdWx0IDwgc2l6ZSA/IHJlc3VsdCA6IHNpemU7CisgICAgICAgIH0KKyAgICB9
CisgICAgLyogTm90IGZvdW5kICovCisgICAgcmV0dXJuIHNpemU7Cit9CisKIC8qKgogICogRE9D
OiBNaXNjZWxsYW5lb3VzIGJpdCBvcGVyYXRpb25zIG9uIHNpbmdsZSB2YWx1ZXMKICAqCi0tIAoy
LjM0LjEKCg==

