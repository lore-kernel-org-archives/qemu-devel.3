Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E688C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39U-0001dJ-MW; Sun, 28 Jun 2026 23:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39T-0001cK-Az
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39R-0006Gr-Kf
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2craH1543568
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=; b=NP
 v1xOaKxRswQwCIlDFpi+HPmf1RBm/QfejMEOZ7elzdL6hTADGi/J3zFVd41zcphd
 yaLK619Y1lu/n3w3QtynWeCDdILoDHsUvNuWzO2j7m9P76yBlO18ORRpy382YZf1
 EHZdSm3FaO1kFK7Nytci4xZfj/UTTQI0sC+pk0oMwRCOgwEDg1dqk5s6CwBkY/wA
 7YLjkE+XygtkBPW1ZcNmVuEftfLwncgQio1JNvuS68Y034CZf7TnTdhDUnwsEcHI
 ZNhrbDJlcI0sd70NQOEVFgfBzCdcJsTzmoUXFHwNqrQWycQBVyRBOIkIyQ0L6csh
 z2ZiL5QC062RJH76nJdw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumacg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:16 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1370417c0bfso3341608c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705555; x=1783310355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=SAwQEpOKuBbLXmZqqtz9jayQdW021C8xCwFd7eZ9HX9NeBzYCaisPLqc5NPGKdbYdl
 iFawVkOok+J/gpbwkFAByTm/zILT79Wi6xb8IFbiYwD5QzXLd5IdwBw5LMNqb+kR4o41
 YzTlFtX9CGEUHUGg/yvv90/YHHyCsbIEnGkO06KD9KDE7NIyKf+g89JCMaDD9+9w6Rui
 cmlQhobo+YJiCxY9/IZk8HT6Fk6txdCnt0rJWPqxEaDG6blm9iUKhQM4J3D75dypCmxN
 c0oDzJB/ox699YMZJC9gHR8vVqcguu5EGSi99faBxfFwk7rWA6ImOhacAdvdlVdBJRUR
 kTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705555; x=1783310355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=QyOPqSDF/1llH2zPJi8lihefqzPphlodFNgt+PqHR0XxOqh6FB0yxq2r3WlD3QL+5G
 0oWklzudARaTQ7do9TiP9RdQbIMWewjHM2qM0/72WVKgpLfJPXJgVZKTgx13yhJ3JLkX
 R8Kcg9KfUElO32YiP7YzHRR6Xghli2c2k0qjw4BCbOD9UmRYsz4ypKx/6vMieTPAOqrU
 XpgsW6Ya+4Ml/WSnZYu4nOKBArId8pAKKaCRaeu9oKrnMsTzaCXsXpqpRevKGjOSMv6p
 fpg0QgszhYI7YlLRYShbQ9cd2k3YlhLHjK5h3mKjc5vTIlVy99IiN6Quenp/V4xQhTzZ
 tI6Q==
X-Gm-Message-State: AOJu0Yz6cMlAgpp7nCzv7/ivAvic83zVDWbt1Lm61sHzfZHrniKnHDDs
 Uiye+LfIEFKFXXL9b19jUcp2WJpD2gDwSsvhikR1pEyVeq1N9gmPyFlz2jXSQ37vBpqvOT7yOhC
 bivJZ6mCTerdUlBlXwhhYgqwHRLOoRvVhXwcgDPn4PavoshZ+ONbTMUSHkc2zDz9cPQ==
X-Gm-Gg: AfdE7cmEdFmWfkDL8oXljCH2I4VSFB+Br6WJ+OybcoH8OWFj8uuIE1MA5AnNtNdTUe9
 FVOh5QojucabykIs144JQK2GxmrPirmKoqUOjJ4cSaTKd7nCPqT8x6Y9eZL9MUY6kaFt5kVQTu0
 kzpBuDm7LQuTQtpelE48xsTcRvFd1hFFZh9lWSNzLQGSeUjiCWDM5ad1idxmXh6ESyqQ3C1qRFX
 x4FfwqLztyAxnfCUnb5+dpurBqqO0WaA2BYvwCY2zxLmqvvWjp1PKD+UP7AYiewc7JPkNM/HeLd
 zXNdrFgHjJo0Z+6cSg/EgiQowKr1wfBG4WxIfh/Am5XajlNZwJBg+SW5nzkgH+2+WE2WB0V3vJB
 D8dYHDLi7fmoz1PzIVu/lMSyPNtRbhfcJIYu4ZDumzY1qFGUmoo2rrLHneVs=
X-Received: by 2002:a05:7022:6b91:b0:138:4952:5f8e with SMTP id
 a92af1059eb24-139db94aba3mr13588826c88.3.1782705555390; 
 Sun, 28 Jun 2026 20:59:15 -0700 (PDT)
X-Received: by 2002:a05:7022:6b91:b0:138:4952:5f8e with SMTP id
 a92af1059eb24-139db94aba3mr13588810c88.3.1782705554880; 
 Sun, 28 Jun 2026 20:59:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 22/77] target/hexagon: Add vmstate representation
Date: Sun, 28 Jun 2026 20:57:35 -0700
Message-Id: <20260629035830.1520296-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: mRIpFPXCKJWVm0FEuzF6xw7pmZZLXIAa
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41ed94 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mRIpFPXCKJWVm0FEuzF6xw7pmZZLXIAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX3/nl13D4g8C0
 5UHNY2sxl7iLHH53dab4I4qK/VZad5CVFmS8OUL/0Aw9PYwvBCEzdXxgOQHjkKTifhd9DAI9rZ2
 9EdjgaN/duNSJKD1zv2M1PMcXyF7n86JBwaYgJ5gDSfzwFoSfuKuA1aNep9YgoqqNk7JacV5Op8
 aseI3TB2GirDOTdjFs56a48N9EK9+gpL5WDdaTric9Vc+8gdjtfyHuJaLxJ+zlp0m93XzRceT0Q
 ClQwJZbnuKC1ywzBxov/WTCqyy+pYR0N7IVLUo7tIIb6Gb0wc1JDAC83BTLmFeob9hvAc6/rY2+
 UPeLWSU7WIQFL5+bbjWQ/UcHWElxC2FJqwyH9czSX8BISE5Y9cBNKvUT8a7xPPDOuGdt+XhJ299
 dfICSODo2+OENP5eD6Oo3/6TeR6Voi3xQkELmqNKUW9IAaAbEaLHCKkpddrgRD3HsaOEZD+DdpK
 H1pR3D6fMeQ8VlrwOPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwk9csP7z9y4v
 K3RfMKicm1+gLrn+PSd9dDU0U7Js4PitHeRjwUw5diYFTpTZYb4JA9I0vXpLpscH0oCMzmjSHjF
 WDbpufHDSLIChhTNwMar4FHb8dFZmdY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAgMyAr
KysKIHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYyAgfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKaW5kZXggNWZjODM3
YWUyMjkuLmNkMDZmZjQxZDRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKQEAgLTMxLDQgKzMxLDggQEAgdm9pZCBo
ZXhhZ29uX2RlYnVnKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX3JlZ25hbWVzW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAKKyNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hleGFnb25fY3B1OworI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBkMzBlNWI2NGVhYy4uMzA1
OTE5NmJjYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0zODIsNiArMzgyLDkgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBjYy0+Z2Ri
X3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVlOwogICAgIGNjLT5nZGJfY29yZV94bWxfZmls
ZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8gPSBoZXhhZ29u
X2NwdV9kaXNhc19zZXRfaW5mbzsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGRjLT52
bXNkID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CisjZW5kaWYKICAgICBjYy0+dGNnX29wcyA9ICZo
ZXhhZ29uX3RjZ19vcHM7CiB9CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY2hpbmUu
YyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMC4uMmRkOTU0NjZlN2QKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9tYWNoaW5lLmMKQEAgLTAsMCArMSwzMiBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgorI2luY2x1ZGUg
ImNwdS5oIgorCitjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9
IHsKKyAgICAubmFtZSA9ICJjcHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11
bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7
CisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5ncHIsIEhleGFnb25DUFUsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5wcmVk
LCBIZXhhZ29uQ1BVLCBOVU1fUFJFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShl
bnYudF9zcmVnLCBIZXhhZ29uQ1BVLCBOVU1fU1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Ml9BUlJBWShlbnYuZ3JlZywgSGV4YWdvbkNQVSwgTlVNX0dSRUdTKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoZW52Lm5leHRfUEMsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYudGxiX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYuazBfbG9ja19zdGF0ZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi50bGJfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi5rMF9sb2NrX2NvdW50LCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIo
ZW52LnRocmVhZElkLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmNh
dXNlX2NvZGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYud2FpdF9u
ZXh0X3BjLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVf
Y291bnQsIEhleGFnb25DUFUpLAorCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAg
IH0sCit9OwotLSAKMi4zNC4xCgo=

