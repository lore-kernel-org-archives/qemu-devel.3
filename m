Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351DACDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBh-0001kU-VF; Fri, 19 Jun 2026 18:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBg-0001jw-9r
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBe-0001c5-Mc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JMwVYw2081768
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=; b=DbV7TXPgHu52wz0N
 fm0qnUFN9JwZFmBg4rXq1PMx1LGqA/NOZ/IvygsXl8Ji6/z14B+AAxJt3yv09cCp
 2a8wDTPCd4G7wPEjA071M/1fczg0cYZcB/ZHSGB6clNd5I43QSkNOp15PC7rRKn/
 6+oCUo0AApx3B4HrRPyL7Sltt1BZfPcByYJX2bRTt8gFo6quShaJhgWaNjdiDEbe
 K+nnq7r1rBs2+BWG7VxHsMEJVMSp0p/9S/YDaGEanXCpLjSLf8Le0dSU2iwmEvmL
 rx620UQwZbYNs6xzie5+FUelA+ycz9h5UlMpbiganjj6gmwaxtQejpuQ98mhjswV
 p6wZBg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm22e05c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:45 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137e49e896aso2474905c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909985; x=1782514785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=dF5iPD2ZLLnkQozY3fWP40C9+KZ6KUqhfbt0q8KQ5B/FzfVoJL6RoyjPJMc64f4J4d
 t7QwHmJqE+3BsXgtbIfRZzKzVUvjo3V8KUgfplwH0MlsuPldcf/DgHa0mjIk+XkXmOD7
 P/6r2dz29etEjxz8J2rT1mieBB9oGBlawdb/n9WY39l2WxMycVNnRSKTTf7n8td6oBxg
 ohJjhSwd90SnZLn5PRD5J18KcOhsOZyEtk7ckxsjp2RixoQJRjpNZw1Qu6u4uispGLca
 ow7eAUTnP+IDUU6Xr8ElkyQA7xQ+yoJHn5mwQCEMkKV8uiNDMnV+eeTsxftCTZcnYQYl
 R2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909985; x=1782514785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=N43/p67MUXDA3f/8/yui7AqLOvAz9Ez6w1Hmxoz3h/rUWbtrq4xLCsNmva4/A9V6y+
 8BLNs6ygGbT2PcAEkMvNdf4oEBWkFNHZH5sQIy37nIXjHbkTCk4mTOzEx+i/VL3qRfVt
 K+ASh2/vwPOcWSm8lmUBg7ZFF10k+HHmMJuQUaRRy3X2K4y9rVkHv1AoJkv022zqAcgx
 3zh3uM03Wr8qXzTGPdP/mGCcF3+6T2B+Cr/OHDxL0BYs+9YHcv23oW662zzphrGpZvmn
 VhCYeN9KZBr6oFsqvfm05n/Lm4ogaYxD7E65LB8Uu+5oFAnzyaqdhKkinHO8/r0LZhCm
 s/gg==
X-Gm-Message-State: AOJu0YxCNnLGmlB/Jt2b1CNFurQWZA4mMyeFJf/5qFNAgdotvfCmvSZL
 bMM2kDl9mtDX5nBRFTpO2pWR39WoTltaQTBn3Z+jUNtxFh4s3no/daq5GZs0VcLRTg2I4XiE+GM
 D4m9RMGYbTUsiYJ+oC6UB/Xh5/GymtGdrrSUEqgMj1YULk8h1t6m9jx8FAM4GWJdI6Q==
X-Gm-Gg: AfdE7cl6x0bBuqk2x2YphYQRQ/T8jXg4dhD7ZdLh1x4HRJYuKf0KyKubYICeyHjoXrH
 b3gGQh38i2oYxN4iTWsbqCg2I+W1JVlMjtp4gk+L4Q5HS6tmwbZbIkhnQdSg3UfroslkapES3eP
 +0WPXH4dwyVrxZotIC+YeZSxnKPJIdU5za5ibpWeAFOIouSAdEvkQcN7iEayLF2eRl0in/y3VC5
 YfMkltv8kXB3sNAp44oTxhCUlb7RIvKPOIVN1R2rbvDaU4ZW4h6SY0zq4Hj8xa33ywtyUvhck4q
 aEh38I+J2zmpNWZSJQ2GBetA81Ww2dCzohFZaCpqz3yQPoWL7b+gNRt9oRpdt7nbIKWJMoEHSX0
 g4sI/+sWgMQva/HiquNc7eKLXHuAn1JsXz9zxEV+5/rUID1lM2yr+H70PQd4=
X-Received: by 2002:a05:7022:78c:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-139a3020c97mr2488578c88.4.1781909984610; 
 Fri, 19 Jun 2026 15:59:44 -0700 (PDT)
X-Received: by 2002:a05:7022:78c:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-139a3020c97mr2488564c88.4.1781909984084; 
 Fri, 19 Jun 2026 15:59:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 20/74] target/hexagon: Define register fields for system regs
Date: Fri, 19 Jun 2026 15:58:17 -0700
Message-Id: <20260619225911.159473-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=YN+vDxGx c=1 sm=1 tr=0 ts=6a35c9e1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aZhdU0zyZz4-RCoAUHp8vONW0zdc5CGp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX+f4kudhS80kn
 HEtbz98SSS5BJA5GsPUNclrGhyBKVeBeLlLKThKZltofGOD0N+uMh3Mofevto8IAYtK4WTBAwUa
 VgJUhY0izoA2SvjaOhYENHOy4rzLrPw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX0RzaT8fGZwW3
 emM56UuD9UtF6V5Tc84qNHrH98RUqRIMO8mlyfaGeyNtPeWgAy6zX51C3PZ24/WcrKhhvQucS7y
 YqUyIzne+kAaH8820Mhhfi/VJB0jj2uv5ltZREo80t1EEOpTpef8wExJ4htFR1gaI02JhQCnROO
 uTaJrP4Wj5Pmgr6RBAHXkNfTC9zmD3O8bODfK2JOzjnEgSCp1b7pkcqfn+29F67np1KoKW0hCBQ
 BLqwZ5y3o8YyF3jBijemjy3UYqRqX7crpjsHJNTukkQKTYjV6IT1DhCt21ypVkvO8Xz1VLlhKzs
 RfCbrdM9nGY09jJ3w961BtfOCQ3iJsVii1VWuGMNhVB759viOqNWPbAiUKnZJFlofSTORCJYAJY
 EPCuy99aX965JHAlOU81zSyYL5r396U/X1kMnXYqS28Iv61hlXMc0BPk31BRJQi/UrRN1S3n9Ct
 Rh+RXitSo1wmYWxw2nw==
X-Proofpoint-ORIG-GUID: aZhdU0zyZz4-RCoAUHp8vONW0zdc5CGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgpSZXZp
ZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIHwgOTYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgYi90YXJnZXQvaGV4YWdvbi9y
ZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCBmMmE1OGQ0ODZjNS4uOWIxMTJjY2VjNjQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0zOSwzICszOSw5OSBAQCBERUZfUkVHX0ZJ
RUxEKFVTUl9GUERCWkUsICAgICAgICAyNiwgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQT1ZGRSwg
ICAgICAgIDI3LCAxKQogREVGX1JFR19GSUVMRChVU1JfRlBVTkZFLCAgICAgICAgMjgsIDEpCiBE
RUZfUkVHX0ZJRUxEKFVTUl9GUElOUEUsICAgICAgICAyOSwgMSkKKworREVGX1JFR19GSUVMRChJ
UEVOREFEX0lBRCwgMTYsIDE2KQorREVGX1JFR19GSUVMRChJUEVOREFEX0lQRU5ELCAwLCAxNikK
KworREVGX1JFR19GSUVMRChTQ0hFRENGR19FTiwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU0NIRURD
RkdfSU5UTk8sIDAsIDQpCitERUZfUkVHX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIDAsIDkpCisKKwor
LyogUFRFIChha2EgVExCIGVudHJ5KSBmaWVsZHMgKi8KK0RFRl9SRUdfRklFTEQoUFRFX1BQRCwg
MCwgMjQpCitERUZfUkVHX0ZJRUxEKFBURV9DLCAyNCwgNCkKK0RFRl9SRUdfRklFTEQoUFRFX1Us
IDI4LCAxKQorREVGX1JFR19GSUVMRChQVEVfUiwgMjksIDEpCitERUZfUkVHX0ZJRUxEKFBURV9X
LCAzMCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1gsIDMxLCAxKQorREVGX1JFR19GSUVMRChQVEVf
VlBOLCAzMiwgMjApCitERUZfUkVHX0ZJRUxEKFBURV9BU0lELCA1MiwgNykKK0RFRl9SRUdfRklF
TEQoUFRFX0FUUjAsIDU5LCAxKQorREVGX1JFR19GSUVMRChQVEVfQVRSMSwgNjAsIDEpCitERUZf
UkVHX0ZJRUxEKFBURV9QQTM1LCA2MSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0csIDYyLCAxKQor
REVGX1JFR19GSUVMRChQVEVfViwgNjMsIDEpCisKKy8qIFNZU0NGRyBmaWVsZHMgKi8KK0RFRl9S
RUdfRklFTEQoU1lTQ0ZHX01NVUVOLCAwLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfSUNFTiwg
MSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0RDRU4sIDIsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19JU0RCVFJVU1RFRCwgMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0dJRSwgNCwgMSkK
K0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lTREJSRUFEWSwgNSwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BDWUNMRUVOLCA2LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVjJYLCA3LCAxKQorREVG
X1JFR19GSUVMRChTWVNDRkdfSUdOT1JFREFCT1JULCA4LCAxKQorREVGX1JFR19GSUVMRChTWVND
RkdfUE0sIDksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19UTEJMT0NLLCAxMSwgMSkKK0RFRl9S
RUdfRklFTEQoU1lTQ0ZHX0swTE9DSywgMTIsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19CUSwg
MTMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19QUklPLCAxNCwgMSkKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX0RNVCwgMTUsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkNGRywgMTYsIDMpCitE
RUZfUkVHX0ZJRUxEKFNZU0NGR19JVENNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wy
TldBLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyTlJBLCAyMiwgMSkKK0RFRl9SRUdf
RklFTEQoU1lTQ0ZHX0wyV0IsIDIzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQLCAyNCwg
MSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1NMVkNUTDAsIDI1LCAyKQorREVGX1JFR19GSUVMRChT
WVNDRkdfU0xWQ1RMMSwgMjcsIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMlBBUlRTSVpFLCAy
OSwgMikKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyR0NBLCAzMSwgMSkKKworLyogU1NSIGZpZWxk
cyAqLworREVGX1JFR19GSUVMRChTU1JfQ0FVU0UsIDAsIDgpCitERUZfUkVHX0ZJRUxEKFNTUl9B
U0lELCA4LCA3KQorREVGX1JFR19GSUVMRChTU1JfVU0sIDE2LCAxKQorREVGX1JFR19GSUVMRChT
U1JfRVgsIDE3LCAxKQorREVGX1JFR19GSUVMRChTU1JfSUUsIDE4LCAxKQorREVGX1JFR19GSUVM
RChTU1JfR00sIDE5LCAxKQorREVGX1JFR19GSUVMRChTU1JfVjAsIDIwLCAxKQorREVGX1JFR19G
SUVMRChTU1JfVjEsIDIxLCAxKQorREVGX1JFR19GSUVMRChTU1JfQlZTLCAyMiwgMSkKK0RFRl9S
RUdfRklFTEQoU1NSX0NFLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1BFLCAyNCwgMSkKK0RF
Rl9SRUdfRklFTEQoU1NSX0JQLCAyNSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1hFMiwgMjYsIDEp
CitERUZfUkVHX0ZJRUxEKFNTUl9YQSwgMjcsIDMpCitERUZfUkVHX0ZJRUxEKFNTUl9TUywgMzAs
IDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRSwgMzEsIDEpCisKKy8qIG1pc2MgcmVnaXN0ZXJzICov
CitERUZfUkVHX0ZJRUxEKElNQVNLX01BU0ssIDAsIDE2KQorCitERUZfUkVHX0ZJRUxEKFNUSURf
UFJJTywgMTYsIDgpCitERUZfUkVHX0ZJRUxEKFNUSURfU1RJRCwgMCwgOCkKKworLyogTU9ERUNU
TCBmaWVsZHMgKi8KK0RFRl9SRUdfRklFTEQoTU9ERUNUTF9FLCAwLCA4KQorREVGX1JFR19GSUVM
RChNT0RFQ1RMX1csIDE2LCA4KQorCitERUZfUkVHX0ZJRUxEKENDUl9MMUlDUCwgMCwgMikKK0RF
Rl9SRUdfRklFTEQoQ0NSX0wxRENQLCAzLCAyKQorREVGX1JFR19GSUVMRChDQ1JfTDJDUCwgNiwg
MikKKworREVGX1JFR19GSUVMRChDQ1JfSEZJLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0hG
RCwgMTcsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9IRklMMiwgMTgsIDEpCitERUZfUkVHX0ZJRUxE
KENDUl9IRkRMMiwgMTksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9TRkQsIDIwLCAxKQorCitERUZf
UkVHX0ZJRUxEKENDUl9HSUUsIDI0LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1RFLCAyNSwgMSkK
K0RFRl9SRUdfRklFTEQoQ0NSX0dFRSwgMjYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9HUkUsIDI3
LCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYxLCAyOSwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZW
MiwgMzAsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9WVjMsIDMxLCAxKQotLSAKMi4zNC4xCgo=

