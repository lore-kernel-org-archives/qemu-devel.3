Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13C0CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifq-00044q-PP; Fri, 19 Jun 2026 19:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifm-0003yM-5w
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifk-0007T4-9a
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY5DB1369135
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=; b=RpGFZEOWWJXPySKW
 ZQKl5kBV9qNU6FMyWDo6Hp9oYRYyJ4s5FAk67vQNj0bBPEz4k17sf1iPvIBMozeU
 mxuUUTnh/k2OcfWnjRDW7EYYNYxvMRGyZ+65G7l+xXBXsJIoE8/QwE12gEmINUdM
 DAHEuVAJ4Hr5no3Yh8HYMCzIm3EVtfOMfU2BileBfnM3J6PEbzGADAZCegQXlmzd
 ltfnFQggd3KTPRlcbCfT4nvxddrCb29+Xcub8Xos3Y56LDaWH1ONlmCWeDj/fyT3
 rgedU1JqXU9QvDTdulrgH/ZSgeLhkniZDK22tF1IOquj0VoIYGObSQHQVmrhDDPb
 JrvPoQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewcy30dxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4641370eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911840; x=1782516640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=QvQw9JQSxAIC9p0QgFVMonnx2jgnZ450L2rs/QPaB+CxoQRqx64MltAumWiKK0Vecg
 ae4Hu4LVFn8fU3x8JnsOfjFte1J+qGbKS+Lh2BrL8VMAIEv5p8r2uzImdh/Sd84/pFD/
 eced/9WoAecnH+yPVYTbZhjqM1Z+QdO41ve5DF8HitEb5R24lu+E7ZsPbm2WQaVhgsLV
 UTWkQ5AYz7zb5TeLiRn2j8TsBB5J0IdnXolbkMwLTM8Re14/xGVazoFZC/IS4MCH24/b
 AtZol/i4wMfhU687hzBQjVEygPUsOtW2wv0pXL/s1nDpwagBzndBvqcAcNq5lvzZunrl
 fqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911840; x=1782516640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=Y9q9JtuQKiVKCBnF5zzw7HscQmHL6+0IqcRZ3Pz2aV9LKQoK/Cc2asi74/aTHYYA1m
 Zj+YRuGVle2sIeA5nNXEvIKDrCd9WiQjNCXaO+KcwJBr7d4YlD/szcKNz9aMmD4E0B2I
 mLVvl+RgIDt/5yYo3jp1sequRTlElleRqsxpHicPxsrigiXfQV/bY44jZqUtLwfFHg2n
 UzMY8WZOm/IGzwxkm9v37OdlkczNNYoC0E3v88BGUSWAHmz8S4cp+DsyQ/MWRqSsRStU
 Hi20X6zsIQUenuvEoeLaiBxiRvSzssSt33jxNiKdiYyP/o3W6VkDgNguau6BYnt9nMWQ
 r+VA==
X-Gm-Message-State: AOJu0YzP+bvvCcfyWPPtnUVwDf8CgrHsHo6eDM5mk5k0+cL+2krMFoD5
 q1+Notbxi6oERMauwewEv2THSbu3u8e5s64dE9POH6sPiJBytX/O+F+f4GE7M82Zuh+c501vRbx
 3i18nJ14330rYgQBoCfgh02XumhWy03XHugQohloOlMiZeIS/IPEnQRPt8vGBWzdAlA==
X-Gm-Gg: AfdE7cmM2piizsX8HNRu4tRejNIDvESbulHG38rIB4MviDNb+vR6dUCQ1onNJT9eLsA
 toN4bBL9v5qfVNIFGjWnl7puAuOGWVcZM7G0Cmpl8V1j2Qde1AgOHwg50gnit6CIS50utesCKYK
 Y7BxxilMGDuDuLtltHYOvUFDIbL0OyxFbuVNG95q1QxtOVJUPGH7Ebh8creeNJXUXZTr5Cks8pH
 yvX+acuJAzjqkqDD4gzq21M/lDcSuTUp0u9eEiXKrjiMELq2lMWg1L7kJlDhPF4K15kzN/94lrd
 IqX1CGTlHqQ4NibT/kG9j1ISjMjikOaICQTfDX1ARQ8QngurZXNeasszMGniFLuH4FvBypa54XL
 AOvGCewRFT62c+cBUtXGlZ3FOK+fkV/vFDUSdKqY6q1eOMqS/NCFlY3SYhp8=
X-Received: by 2002:a05:7300:ac90:b0:304:e6f8:7cc9 with SMTP id
 5a478bee46e88-30c0d0c8f0dmr2275294eec.20.1781911840188; 
 Fri, 19 Jun 2026 16:30:40 -0700 (PDT)
X-Received: by 2002:a05:7300:ac90:b0:304:e6f8:7cc9 with SMTP id
 5a478bee46e88-30c0d0c8f0dmr2275281eec.20.1781911839690; 
 Fri, 19 Jun 2026 16:30:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 59/74] target/hexagon: Define system, guest reg names
Date: Fri, 19 Jun 2026 15:58:56 -0700
Message-Id: <20260619225911.159473-60-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 2ccXB2mjFB-hznxhCZtQDi6ApTBqgV5w
X-Proofpoint-ORIG-GUID: 2ccXB2mjFB-hznxhCZtQDi6ApTBqgV5w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX/LdMZs3+yh62
 tIxzuiXtcdNBF/RLHMZ64Fjw6oivqa76Sqp4jYbNlqvnEAMiJs/fi5UttCLzX8Ru+f5jd8xROqF
 rLzop+RXQD9qY3TYyaO5yqQE0C6eoAPjX2B/pBwFS4sKXVXECPLpa+ZbcccEMiUhRd/XETOgADO
 xGtO2ALq9BCkeaZkV8SeyEqJMjwoydUPRG8+KVOI47VemypLg0UNawTeSJhnGDA3Vkz+GXhsEUA
 rHCNrS1UWrWQEtR85kh52zsJoIBS6egeAo2/7vbxbbN/WzKPi7mHWwkqkcTLi2sBrDFW6Q6UkL3
 PkF0wcFkfeubjBfgOioT6YUQv+4OOCj2QTAjGsI9anwfLoc/7kuV/+MaoFtXz8FmnOi0Dlo2WMX
 tXJXjBsxlr0EKYzNFUKD7AycLAWyZX7tc6SWJ0UiqYN7X+Jc0hUHbBWIY0sZz7SD6lohiDE88sM
 CcdD9j3W/YQCNwIBcBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX5jzsGn5URrEe
 VE/8qpojgTCc6RD6fwOyOC8wefFV47iilLA6Dp3ImF/F3x7m4Rg2+HRayz3pOgLGNyOXK9CoM1q
 YH60eN8dXJg1VhVf651+EdvKodmW8/Y=
X-Authority-Analysis: v=2.4 cv=ZOvnX37b c=1 sm=1 tr=0 ts=6a35d120 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdv
bi9pbnRlcm5hbC5oCmluZGV4IDQzMzg5MTRlZmI1Li4wMGIzN2FlYTdhZiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CkBAIC0zMCw2ICszMCwxMCBAQCB2b2lkIGhleGFnb25fZGVidWdfcXJlZyhDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50IHJlZ251bSk7CiB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRl
ICplbnYpOwogCiBleHRlcm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9U
QUxfUEVSX1RIUkVBRF9SRUdTXTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNv
bnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX3NyZWduYW1lc1tdOworZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX2dyZWduYW1lc1tdOworI2VuZGlmCiAKIHZvaWQgR19OT1JFVFVSTiBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgIHVpbnQzMl90
IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKaW5kZXggM2FmOTBlMzBiMGYuLmIzNWNhYWVjZmFlIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtODYsNiAr
ODYsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
UkVBRF9SRUdTXSA9IHsKICAgImMyNCIsICJjMjUiLCAiYzI2IiwgImMyNyIsICJjMjgiLCAgImMy
OSIsICJjMzAiLCAiYzMxIiwKIH07CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorY29uc3Qg
Y2hhciAqIGNvbnN0IGhleGFnb25fc3JlZ25hbWVzW10gPSB7CisgICAgInNncDAiLCAgICAgICAi
c2dwMSIsICAgICAgICJzdGlkIiwgICAgICAgImVsciIsICAgICAgICAiYmFkdmEwIiwKKyAgICAi
YmFkdmExIiwgICAgICJzc3IiLCAgICAgICAgImNjciIsICAgICAgICAiaHRpZCIsICAgICAgICJi
YWR2YSIsCisgICAgImltYXNrIiwgICAgICAiZ2V2YiIsICAgICAgICJ2d2N0cmwiLCAgICAgInMx
MyIsICAgICAgICAiczE0IiwKKyAgICAiczE1IiwgICAgICAgICJldmIiLCAgICAgICAgIm1vZGVj
dGwiLCAgICAic3lzY2ZnIiwgICAgICJzZWdtZW50IiwKKyAgICAiaXBlbmRhZCIsICAgICJ2aWQi
LCAgICAgICAgInZpZDEiLCAgICAgICAiYmVzdHdhaXQiLCAgICJzMjQiLAorICAgICJzY2hlZGNm
ZyIsICAgInMyNiIsICAgICAgICAiY2ZnYmFzZSIsICAgICJkaWFnIiwgICAgICAgInJldiIsCisg
ICAgInBjeWNsZWxvIiwgICAicGN5Y2xlaGkiLCAgICJpc2Ric3QiLCAgICAgImlzZGJjZmcwIiwg
ICAiaXNkYmNmZzEiLAorICAgICJsaXZlbG9jayIsICAgImJya3B0cGMwIiwgICAiYnJrcHRjZmcw
IiwgICJicmtwdHBjMSIsICAgImJya3B0Y2ZnMSIsCisgICAgImlzZGJtYnhpbiIsICAiaXNkYm1i
eG91dCIsICJpc2RiZW4iLCAgICAgImlzZGJncHIiLCAgICAicG11Y250NCIsCisgICAgInBtdWNu
dDUiLCAgICAicG11Y250NiIsICAgICJwbXVjbnQ3IiwgICAgInBtdWNudDAiLCAgICAicG11Y250
MSIsCisgICAgInBtdWNudDIiLCAgICAicG11Y250MyIsICAgICJwbXVldnRjZmciLCAgInBtdXN0
aWQwIiwgICAicG11ZXZ0Y2ZnMSIsCisgICAgInBtdXN0aWQxIiwgICAidGltZXJsbyIsICAgICJ0
aW1lcmhpIiwgICAgInBtdWNmZyIsICAgICAiczU5IiwKKyAgICAiczYwIiwgICAgICAgICJzNjEi
LCAgICAgICAgInM2MiIsICAgICAgICAiczYzIiwKK307CisKK0dfU1RBVElDX0FTU0VSVChOVU1f
U1JFR1MgPT0gQVJSQVlfU0laRShoZXhhZ29uX3NyZWduYW1lcykpOworCitjb25zdCBjaGFyICog
Y29uc3QgaGV4YWdvbl9ncmVnbmFtZXNbXSA9IHsKKyAgICAiZ2VsciIsICAgICAgICJnc3IiLCAg
ICAgICAiZ29zcCIsICAgICAgImdiYWR2YSIsICAgICJnY29tbWl0MXQiLAorICAgICJnY29tbWl0
MnQiLCAgImdjb21taXQzdCIsICJnY29tbWl0NHQiLCAiZ2NvbW1pdDV0IiwgImdjb21taXQ2dCIs
CisgICAgImdwY3ljbGUxdCIsICAiZ3BjeWNsZTJ0IiwgImdwY3ljbGUzdCIsICJncGN5Y2xlNHQi
LCAiZ3BjeWNsZTV0IiwKKyAgICAiZ3BjeWNsZTZ0IiwgICJncG11Y250NCIsICAiZ3BtdWNudDUi
LCAgImdwbXVjbnQ2IiwgICJncG11Y250NyIsCisgICAgImdjb21taXQ3dCIsICAiZ2NvbW1pdDh0
IiwgImdwY3ljbGU3dCIsICJncGN5Y2xlOHQiLCAiZ3BjeWNsZWxvIiwKKyAgICAiZ3BjeWNsZWhp
IiwgICJncG11Y250MCIsICAiZ3BtdWNudDEiLCAgImdwbXVjbnQyIiwgICJncG11Y250MyIsCisg
ICAgImczMCIsICAgICAgICAiZzMxIiwKK307CisjZW5kaWYKIC8qCiAgKiBPbmUgb2YgdGhlIG1h
aW4gZGVidWdnaW5nIHRlY2huaXF1ZXMgaXMgdG8gdXNlICItZCBjcHUiIGFuZCBjb21wYXJlIGFn
YWluc3QKICAqIExMREIgb3V0cHV0IHdoZW4gc2luZ2xlIHN0ZXBwaW5nLiAgSG93ZXZlciwgdGhl
IHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlCi0tIAoyLjM0LjEKCg==

