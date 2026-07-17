Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0259FC44523
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2V-0006nD-JE; Fri, 17 Jul 2026 15:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2T-0006ma-Rs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2S-00084K-GR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGoD2I2372320
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MEYet0uqamc/vXc7Rua4NfRuCOnL9XaSxQ5CjDJicls=; b=WUHZt2D8V8V57G27
 QKO+FhWUALSMuMcchWNqn0aUIBmuoYP3ZZVJLKYSHdkD91+GG3y5gHlyT2gSGyn6
 1bAXdXqnjmED+rszzjgoDcxENPE9l3OfpUlzVaHfZdbCshFry/IyEkgk3Jxt73Gl
 TAgxHCvhuJyOBJMHVIsXrT+OLDNUQ8F7GZqhf0TO5k70Za59kghX9hjhXWyo9AEV
 IzuJHSvynnKZMClpMsNwV7w8OZQqxi5j04WAq4I1gsD01isUxe3ihdR/3gt2YiEQ
 r8RrU9ZcOYjeCGni/wd75wJSQlX+liGgAA/gL3r3W+UNrfnQo/w6QhJvvdeS9wQG
 ajTOYg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu017-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-380b630c505so10016428a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315758; x=1784920558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MEYet0uqamc/vXc7Rua4NfRuCOnL9XaSxQ5CjDJicls=;
 b=VKoUEQoVdPib8/XLte3PvE3PcOeXAoHIaSiF/xTx+MvjnoiG7BNW32wK5z/8J6Oq31
 942CkSFnB2tUpb1Rl3f2SZkMGi3iqZQ39O2VfIkS/DVoTHK/0A5KVhYY/ZB3oHOOW6BE
 gljNviBkK/fLVA25nUCxS3mCa6+Mt9ph/6cKr/FCAgXjA2vZ22F6vquQF+dDQ1JTHcw/
 WecghjAyGvoo+p1rQ9rVOMPU0QbR11iwSyRiRf1EJFWKYaEfd6e66ZsKKGATz9hSr7xa
 W3ZS9GIaZfvuWz3Nk3D2KfepVovaH7jB3KsjfmQNnmyXJIkgcZXa1nNb9rpE+WAu9KF3
 29KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315758; x=1784920558;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MEYet0uqamc/vXc7Rua4NfRuCOnL9XaSxQ5CjDJicls=;
 b=tAU1MlV5NWfhzOGQ64vjuWYDyLQBEovDgTvjgmgaJKyDJ2wTmCWBcPSWmzqgcQWZ8m
 eB4Q9YsOYFqaKiLh8LIYlsMUYvy28OQi80N0cWpx0NKN9PxTAFS7l7XbWxI4+rsIXfr1
 pMuszMsVmmi7PBBJHGBKuvW+nrkMa/NsRze7Ei5UYIJhuMdB95rUYbwikJJ+EK0eR/+J
 oJ+kc9UFF9ltUevVV7eOGbq28112ww3oN0gniEp1ZIkxImUppSX7A8M44Ilh3VgmIyHO
 Lm1L5YqrhCHD+Q2fjHVzt/gEhkIZb8FtLMsz51mquHrIIYq1/GMUUxWg7qUIA/ywS50R
 FejQ==
X-Gm-Message-State: AOJu0YzIDJRx0QQP0TJP14hSNcRgeMQyTGKuXhwZwb4d7KxZmcwrI1IK
 pqYFAkejScKj3PJZy2s2l3AUKBAwO2BrT2DCH7DQvaCeRf+Xw/UjCxMjlJWV+rxOYVPscwcfONN
 o0dT2UvrpAtyMP8Vn2o8q96ozwE/b6TkQAd6D6SHjRHrUjLFxFALvnOsAw/iRRto2Tg==
X-Gm-Gg: AfdE7cmk9DBM2pjz+6F8HpOZyyFU2xjquIHD6pv44zfOR4H+/vmpI7RqicN0Nk2ina6
 LlcPrd2z5gWZD6aIVYqXzKEoUIAFb3q9V55sUYzfxsaQsg6HUDNE9hKt3c/T5PRnt1jrsV67gtZ
 /etfiUMXJj31BZ7caVXGMupwO+GY9MyPdaQ+YINrILok4Y4BdgQfk7sXoOhWinkfj6EwVRM6AoN
 FyNCM50VMI9/v5NGjL6tXwRanzFqYDGc7H9H7OSMU+L4cgMG1njDkP7JSBNtpJpHZbvMRJkQ6rT
 439/mHo3yj2TX6wgjlMG/nluc7ez0PmuxY2zKl1i7aCIytp1KjY36iqcLDd5pfS8eVwgYsX8fc8
 K2fM8t3itcqZ9ubyVk8LM3WFIrghgt3aCteV2To5UkQmw5rjp
X-Received: by 2002:a17:90b:1c81:b0:387:e0bb:57f1 with SMTP id
 98e67ed59e1d1-38e4b56bd45mr4162133a91.34.1784315758427; 
 Fri, 17 Jul 2026 12:15:58 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:387:e0bb:57f1 with SMTP id
 98e67ed59e1d1-38e4b56bd45mr4162089a91.34.1784315757920; 
 Fri, 17 Jul 2026 12:15:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:15:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 04/12] target/hexagon: handle misaligned load/store cause codes
 in cpu_loop
Date: Fri, 17 Jul 2026 12:15:39 -0700
Message-Id: <20260717191547.920048-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX/7hqtZWxYLBO
 8PIo91vGnQWZh7AKmDgJOcFppZ+T9T5x/ZJbSAeeAHDyNZaspXCuaAMVH6D5iEdIFWtM1SDNE2B
 GEFoTRyr2SsBy/H3absst9BdaMEXj6w=
X-Proofpoint-ORIG-GUID: YTZd5UyXI2wgiNqsw0cH9oPyzKkZZ70F
X-Proofpoint-GUID: YTZd5UyXI2wgiNqsw0cH9oPyzKkZZ70F
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a7f6f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tYl-21R0sE5cWuHd9JgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX3uPiBIfrARno
 o3uxS0rErIA4AjWyPAcCowaw9Kf3ZRTx+cXMuUzSsQTEg7GarCI+NJWpXxhRupchNqAgqI24RLp
 lJAcf9WRQxNKxvhoNNBb/sHQ9GRKzTMwzK53F9dLkaMHf0rrO4pXwdv5REuyM4uT8pQ57e7Il/t
 5uXNL3qFBF55awd+FAnLWZLIls7QTnVVanccKkDADHZUIvFaH4GVslVIM9weqlsVZ2u69WyNT/x
 M6t0ZoM9HEpKcGxvCuM2JYoBvIvTQ0f7f6i2SkQMVi1QyDPDZAMitcNu+Q0iYZXqTKJW/10/1+u
 Bf0yOmBh3+YAqyhdl2EzOey2RAOnXR+RrzQ1O9plE7DIgiZwbrveEyVUB+5OOB08DnmPzmZhmeI
 HfXDsP2SnVE55//yGvkHHCv2WXrkv6Zbsy2i+Jwj/UgFEpQsOYSM4e0lDKZEEM3mLWXKdO5Kdxr
 1OsQdpUctRerFK0bV3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

QWRkIGEgbGludXgtdXNlciBjcHVfbG9vcCBoYW5kbGVyIGZvciBIRVhfQ0FVU0VfTUlTQUxJR05F
RF9MT0FEIGFuZApIRVhfQ0FVU0VfTUlTQUxJR05FRF9TVE9SRSwgcmFpc2luZyBTSUdCVVMgZm9y
IGNvbnNpc3RlbmN5IHdpdGgKaGV4c3dpLmMncyBzeXNlbXUgaGFuZGxpbmcsIGV2ZW4gdGhvdWdo
IGxpbnV4LXVzZXIncyBvd24gYWxpZ25tZW50CmNoZWNrIGluIGFjY2VsL3RjZy91c2VyLWV4ZWMu
YyBjdXJyZW50bHkgcmFpc2VzIFNJR0JVUyBiZWZvcmUKSGV4YWdvbidzIGNhdXNlLWNvZGUgbWFj
aGluZXJ5IGlzIHJlYWNoZWQuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogTWF0aGV1cyBUYXZhcmVz
IEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGlu
dXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMg
Yi9saW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYwppbmRleCAwOTU4YzUxZmJiMy4uZDdmNzM0
MzlkYmMgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xp
bnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCkBAIC03Niw2ICs3NiwxMSBAQCB2b2lkIGNwdV9s
b29wKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICAgICAgZm9yY2Vfc2lnX2ZhdWx0KFRB
UkdFVF9TSUdJTEwsIFRBUkdFVF9JTExfSUxMT1BDLAogICAgICAgICAgICAgICAgICAgICBlbnYt
PmdwcltIRVhfUkVHX1BDXSk7CiAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAgIGNhc2Ug
SEVYX0NBVVNFX01JU0FMSUdORURfTE9BRDoKKyAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX01J
U0FMSUdORURfU1RPUkU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR0JV
UywgVEFSR0VUX0JVU19BRFJBTE4sCisgICAgICAgICAgICAgICAgICAgIGVudi0+Z3ByW0hFWF9S
RUdfUENdKTsKKyAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgZGVmYXVsdDoKICAgICAg
ICAgICAgICAgICBFWENQX0RVTVAoZW52LCAiXG5xZW11OiB1bmhhbmRsZWQgQ1BVIHByZWNpc2Ug
ZXhjZXB0aW9uICIKICAgICAgICAgICAgICAgICAgICAgImNhdXNlIGNvZGUgMHgleCAtIGFib3J0
aW5nXG4iLAotLSAKMi4zNC4xCgo=

