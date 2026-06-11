Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58E1CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3E-0002Nq-MM; Thu, 11 Jun 2026 01:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2p-0001ew-MY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2n-0002hK-Qz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQdf3835154
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kf2+FiBxfw9IHnL4W5TYHhEeBmhymrGkUNN09BVXB1g=; b=muDHcsRDotU+ZGKg
 EcjNB2Ga5pvwUcfraRc9F/fR27zvzwtZf3kxJW5SIl3aZG9dbOkuADRcdgN7UEov
 SKmjm3i+AOlInqqCQzywYhuJMWLNhXPxa4JhHCMe2GD/0zFnOkyKIH0AVaaDDsZQ
 iF+ExHX3IB7MJwFTG3tJRW0YBlui/Kf2hZ9V9YS3eRLmavBAQ5WYyXf5dUQoNJJJ
 5E8O19IG2XgYZNqNnh/SceK9Lw5kWMABdRYEWR9rTlAbV4qhQHmujdkMiPkPNhkL
 Y6MSsssKux2TCmGkObtz8FLb2uc4rX+/mjptibPUOxe9ymoQnaXshxoKG26j5oG0
 xU6O4Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6thsp5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307fe856724so1885447eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156002; x=1781760802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf2+FiBxfw9IHnL4W5TYHhEeBmhymrGkUNN09BVXB1g=;
 b=BDBxATaKtgpMurroON5Rc0cwJnq4J8PhBz+bHgb9PyytWAlUGfJCZo8GznMIXAdttD
 YkAtMiFYxec0DKRdzoL3srf7lWPbka2zlXxxp7KLa3CtKxdt1xI8nPdDbuHZjba76HMD
 ki8We9xMS8fDGNnutgRiMBYzwk+7caeun4jGhoSO5g7FZ/u4qJBjo996lEeX2OOJXm1p
 9WbY4vHzs8i+TKyhbzKAYaawxp46m0O7GAz+s29nSVG0XPLEeDiqqL724U36lxHMoajm
 oWcfW3hRl/+E3lXrFcMz7odhc+98AQq3fjB+s+whHsWT7zjmkCZNssXWxCJKUZIuSoIL
 O/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156002; x=1781760802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kf2+FiBxfw9IHnL4W5TYHhEeBmhymrGkUNN09BVXB1g=;
 b=ASokhjYnzCbKvdbENeQEhOP5hlqI0SeOtwW68GgQgw23/pzNI1/Qgwm8nR1DH6Jp4f
 yUrG9ZoJmRjBiUtug1onj3GNd24kmAcEGUAfihml7YzxB2SWB8+yl6t0Ss0MJ2Sc9Fd5
 2uDFonS5ra/8FUq9lGHzm4YZACLZ/ijMuY/c/Kg3JbCWXz5iAbRiVHeKzU415g6uJVjX
 87FVUslMpSDpVOd8ZQeT4s/SpzhcdOV8wk8jxUYfKdbL9wawbMtqPf1CL6v8iB+56bnG
 08iT/4HRsp/RTaMzCfN0SEOG5bLkVQWEsIH9xQyiiSLHMzIBM9QkQSeEDjXZQFXLYVS8
 GLIQ==
X-Gm-Message-State: AOJu0Yx51E/Eyof5XBIWPYASOV5vVP6tySQ+yaUucW5ps7w6b8tTSfL6
 NPbrlR4vKzYwdx0vPBlnD5d52/Rf3MNqYoyJmL6BLXK/9Jah+/VVcWsUWXp7hKEVq/BRNPX2adk
 rNaL3ec7k1ekd2NM5LBcpIsp8CsO9qukVTibbcIE+417m8hM8iKIQjqY8LgGq4mZ3Xg==
X-Gm-Gg: Acq92OEVnWW7Zkn8GEZ9Dr+wvBdBxuL80Pp8BkCgx0ONq41DSnmAxcsuWBaRkVokSRv
 EvIBP+/CcraoCh88oWHTM64h9JTNOykH6S+Z5V66ClBx+wllipIRhOuOK/HqTwI+8ggQwpx8g0w
 h8REctqnPTchRO+dN/+3hBIE24Nr3JpyFB3PdYASW/Pz7/CZ7yC+IZzsta6lEpyma1j5KgOZQmh
 kqe/WhBzuOKTZzRyMKHFxxOtACe53DoCyrf6z3SAajlY4FTRDM8RAlyQo9+YfQH1xi0htz1asZL
 mHrcWcN5q9xqk516iHtpo5xWcZCQZ07rNmhMXtJYhhUCfoE2Utsf2q/uNDfDAxnqG390/s0xnRz
 WrfKwBBAlJvaJSGtXB0DhUyKg4yUehnw2gOc8n6aJ+Phnk+jWz2jACrQcdbCdIuti0XksmClCAM
 3l9Dql
X-Received: by 2002:a05:7300:d70e:b0:2d8:df01:d9f7 with SMTP id
 5a478bee46e88-3080478e89bmr1210581eec.15.1781156001858; 
 Wed, 10 Jun 2026 22:33:21 -0700 (PDT)
X-Received: by 2002:a05:7300:d70e:b0:2d8:df01:d9f7 with SMTP id
 5a478bee46e88-3080478e89bmr1210551eec.15.1781156001308; 
 Wed, 10 Jun 2026 22:33:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: extend hexagon_cpu_mmu_index() for sysemu
Date: Wed, 10 Jun 2026 22:32:38 -0700
Message-Id: <20260611053249.3918491-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfXyHCzcHkartI/
 lNREVTLvvuHIWQf1ERS+ZMQ/pI/zJ2mE1BH5PPTBJF5KoDZqQmFmG6liW2sfrWuM46duDYnmFtf
 0Q1+QL8XUsA+YDkCBkdlu9E5dgRworx3NLZ/fyXB2JGKkebAhIq/mmY3V3Vz4C1U0H1WIAcsmSi
 ifYdwgWM2vhJ+NXCrL/1Ef0j5s+7RT3Ife+eXYNTzcf0n02IfiKzwPKxTPoTl5gSvmr68jgqzQG
 5ygGMGRojYeqMYgnQ9+WpHosWoPMT6aIb7aMOqFSHlTDMCkj+s6SN+FxrCcfYMRiHKL203bd65I
 iG+j2Z4zPRvqURtXJAzFOeeCjbGsHMW0VXu9Km0n2VWxEBp4yalEMaEQ+tfbgiajMGeCG4ojs49
 B9TnLdTFnIBGU64FKLMdsMnA74LdZdRzHBzKseORfKyuD+WJRHOif+A+KQuMum67gkseqcV75rr
 16jgfdbVW5vNPXoZ5lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX2tqhuvMuUeUX
 h/uH6LX1kneDzz14KZdNNoYM267fzrQNv1X4iDqohq+23wALsi3iXhHQQp7VJa7HGecPl2FBzLf
 kUPLPMMxj1pxGkylBaXoxfVKTfZfQn8=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a48a2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NSfsAZQ8mYYaudvhr0F_-IrlNgtVPBgt
X-Proofpoint-GUID: NSfsAZQ8mYYaudvhr0F_-IrlNgtVPBgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNTRjNTM5ZGUyZDEu
LjRhZjk0MzljMjVkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ2LDYgKzQ0NiwzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

