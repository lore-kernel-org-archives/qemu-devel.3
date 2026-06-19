Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3305CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waife-0003w4-Iq; Fri, 19 Jun 2026 19:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifd-0003uA-89
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifb-0007R2-JP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYdKM1337398
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=; b=e7ANLWD0K+pyxo+R
 wlUxSU8nAS5iaG9NBgaWv+QVU0m/CIF76VtaHwxG9qUWEnkBRfICR6vUIFGhTL0+
 59W+SJUsRPDfX8iOhEjBrHXW8rNSVCyAYs2v0hFYl4DHRnaQtMW4aESVwEPEW2Na
 6MUVww5ACWMW+StO2gGPkRybhh8GlbVMschXTaVchTMXSBk4TezvCsMZEGtMIzcm
 m2G798qZQCYKjoYFLhDKOGdVMuu6uJtbBXOSyag09rDtRBRwWhcNu5uTWYbGHI+H
 3cc1nGJsk9DvJlmf8807rvb7RZjY28Uop+r8drzWSJJA6lheTKZw1aQBaa3zdVIt
 TdGA0g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6757a4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4641153eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911832; x=1782516632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=XyhRXV6Gk17I6/fOBAbiCTohZTKQ59Hkkue1iJLWxYKRHJH71HWsJgTkA2dRrpkzU5
 /Hkb9GrTUN9qeqtllj/g6JBqmzunaC+O+PT1xnO3bAgP/fYhtTz8U2Lt1iyMaFmkHX2I
 8dQotu/qlEsi542tc4nJi5rsquwhzGuRjua5DUHeWbhGXbf7KL5t4MDRtOJhDKg8EsSp
 zx9jVFHPcw/0eSUN0H3gbAzY7E8QS582THvhLGpJwCJxhZmg9TmE2eu4++dJeh2zvE/x
 dDRrS5VMmaSRiRuZhCM/I1aKRD6HGTU14yOmVdqkfrTQLDO4Z9H5ORkde5JD2AZnQhG2
 cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911832; x=1782516632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=QIXyIuLeJD6lLb4FA+JmeOR39OyfcxRqkTF/ai+4OPV4ye/EfUowKH83NML0t6ND/M
 n+7J3JMvY8xLN4B4FbN4NZoCrk01cvPGdBO9VS/BwL3dfm89/c+fkSFH5p0mwYmv+sLo
 4Ryifhh2wrqSgUUx11GBN5dF0NcEZlXz7b3ObA04mRd5lHLsO+zq+fstPdJX9jLJZTyp
 Zmgii/6aRr6X0CK3jvW/BOE6O5MC42JcTNq/yj4p3FxFC0k2jceQZ5Nm4ZGUW8Snu4bH
 Nlb8wZ/4yjKeHb+CvIqTCfy+zEg4LRofbLXLOa8wcRh2ifqhAvwZM33ynW7xxKI4xx3J
 MbNA==
X-Gm-Message-State: AOJu0YzkvYX9Hc8YmEp15XVdxeRuEfw4l6DsPvbyZj2Qn4X/D75aC5ad
 YPgu+puBnQHn3F2s0ggihvDjEcGpm2WUqN+zJFZkEHgMS1fBEajuR6YeCEwqhUOtlpIa1dQpdjv
 ksGpQeOpbqJ9UvYma7Pdt+BIi3TzXIjsX5rZxSunuNkt9Cbp34QHKEVKqouFumPqUBg==
X-Gm-Gg: AfdE7ckXRUVY57EkdAnNnPwDWhHAwRa6LUuiwlUzjPcf1h0hwlT0JWnoEYx9QnHQ+im
 7eSwC6bX4ZrH47r2+IxXOgi6aMzyFmyfvmuADtS2VsCMWY6IGleTG2UbZVzfsM/ejxeDT/iIIU3
 imaP9TBdyJYkEOefvFU8lJU6frKlNEmOpCyWQrd3ZrHHp25VcmeRw3aSAmsWaDSs+VHrPLkHCy/
 1nD+aZRdYFsUplgHBxLzEfMyGAnDxKElmHXNIJNGrWdSEyu6hqwFARWpsoELO1gersruVk7wR2r
 s5AqrqSvakJsO+oqLERDNfvKjgw5FVy2GXtrUUbKCAx7nbGtMsNmEhmc28UEj7edNaOUjcgP3vN
 MjUz5btFg3NqwCLSgqF/EK74x43eAimuO8yc1o9k+u8hs047X1pWQ5LbdFpM=
X-Received: by 2002:a05:7300:3c2b:b0:30b:e14e:b5e0 with SMTP id
 5a478bee46e88-30c0d2a4bf1mr2171805eec.34.1781911831554; 
 Fri, 19 Jun 2026 16:30:31 -0700 (PDT)
X-Received: by 2002:a05:7300:3c2b:b0:30b:e14e:b5e0 with SMTP id
 5a478bee46e88-30c0d2a4bf1mr2171787eec.34.1781911831077; 
 Fri, 19 Jun 2026 16:30:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 53/74] target/hexagon: extend hexagon_cpu_mmu_index() for sysemu
Date: Fri, 19 Jun 2026 15:58:50 -0700
Message-Id: <20260619225911.159473-54-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 2WJOIA3b8CBum0QoluvtH8mGe9S1CMaT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX1bl7cbTg21om
 ZTT22/XdjH+X93ZcriBuknweEO6MmTo10ua+On9V6JrjepZdwpTkWIV14vtPNAk6t1uaOaPTLhh
 6Q6ibY9WwJWVdJ/c80M3kJpCihWBIC9p6NvHp8k110OyHMhow8UkcNeOizOYF+InqP5QDWzoDwX
 E9i1Hqu9E/MhYiMz9EaYRXpFp1Uy08OTgbVxqro7OmhJgFahntChYeTdqESZZ/hdmjEivtBXg8g
 nxKu5BVCMbBGKanhKx80h9fldUBE0BLGIPk8vUxt5g1DsayqM2uN8dLmDh6QAtw4xBaHb9L1rwm
 qiitB++bQ3y4Fqh8V2zHMWzQUE/iFfufjatyfPrC5h0gDI1KPoOl6fZtJNezJaQ8DPlTEYwY93v
 ycIAUO/a36WXsxe1e6Yljkh2Zfwuxt1FgGTne34WoeadbZFer+tvfgMPRf7JgJzdc+0FzLprQeg
 eiXjZ405nTc6T5Aj9DA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX0PvYy069KAhb
 kwUrK4prBHIa8z07k0Mr9cbDUUZygaDuYK9v+wBNV55aI8COY5tGbMbOF1ZSkm+9VRtCHBsfuAP
 7YA/p50SgV+TQoeJAUttGaiq7ZwTxWY=
X-Proofpoint-GUID: 2WJOIA3b8CBum0QoluvtH8mGe9S1CMaT
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d118 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNjcwNjY4ODA4YTgu
LjNhZjkwZTMwYjBmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ3LDYgKzQ0NywzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
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

