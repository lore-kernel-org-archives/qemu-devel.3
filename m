Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28FCC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 16:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5mcI-0003Tn-DG; Sun, 13 Sep 2026 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5mcG-0003T1-P2
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:59:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5mcF-0002dX-13
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 11:59:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DDxm3I1950953
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=; b=cUAcdRkk/hLdZ83A
 CbgonGIML9NXLfjB8GAQ6Y93Vk3/j4PW8yfnc2DhV+eXiBsaC3POKoW84gaUL0hL
 o68/HETxkFR6WGiJ2qlXBfsb197hWG7seWRVzeDe8QEBuDpkv00LQInUYUS1YEPt
 CtieSsXCI9lvgYbWpiFROh2e7zZb3fn8SxKepv9VcbB7ir1D8UQAmILKn21nkWn8
 x4kwRTxpORH8jsJlTn2YdOJn4CbRKLLUy1QE6ueKKPvHEKPedw647duRsEJjYonz
 Bz9y2eoWD7XVBAmqiWDQ5JOBbqmXB/Mo2U4a0y0LdnhtIUJFGAU8HLEwoOI+ewLd
 pYQGZA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d3m36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 15:59:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d94f086fedso33310235ad.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789315177; x=1789919977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=B/v9/098pQ3XavIanGemA93lo6hAZby3+LWBZEQkqklk0xJdNBohjvGvDrSrl97/0Z
 14YCZSdkJ4rPHxTWhJUKAa1a41elzt2urTvE7Hw+XXYsDPlKEpLYETWFkGWzy1nuuR6C
 NOCGK6Xh3rkwESDR0d7IGBos2rqxTVj7nvlouNScUOiD6hRTbVarwTT5vzpl+BiuVmSU
 bb3S4Dw2jJsLf6d7x3QgKbwM6405yWGB+XORidavezr/XsYoqbHkTRZ+VAfX8Chet5vZ
 HORLDercltzZ7sae4KT0iyW+dAalYHtOeakZepAI3deI9jGotNcg+X3kl5kf/6yQXcCB
 Em/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789315177; x=1789919977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=co5UNZNwd4lkRMyoIuckyPSAVp+yK5oUNJVOpNf4S8Kn01qfy2gOW6yI3CepBIgaCm
 ZohTctCmhMoWy7c1ItzEwYeS5axK0s1rSCXk4ZKB3GZWYQ+AsuCNgZLDy1pQ+Fi1CVfI
 5gXfw+KMugRZjc/196qRyy3vHwQOxQDv8FL8FIKV6+yybNWqKAzu/J9dNaxFRozzZwAO
 AWODpFsbtzyfU2GKZ9DpZektsDNFJT+I7YdwtrQZYp5iYycncmGBvdA0zLIS0aAUTxTP
 wZ9JGqHFxzv/5uVliL/euVxwQ8nnOtUJRHbixZrxiGSt5j5R/XjnQ6DlQ5C2FKmFPf94
 oEmw==
X-Gm-Message-State: AFuF++lBW3VG9HCVGm2GbL5MFCOyvEqCtP3z/3Fhpy0Vzr0oycvqny0Q
 GRN93jAHgMS9RSm5UpWzPS5iJp+vTBJCDtHRRl6DGotkj4PloydIy5xE8lNmVegDEi/EB1nuzh3
 +9CZcGMVl7eNlSYXoqrGpHiJY0riUlxaVOwFbgvDM1YSqm80mjuhpgx4DxrdYO4n/9Q==
X-Gm-Gg: AYBFou0hMRXcw0CgGpnkBZFIfmu1FEfq9cguq3zoyx71WfroESlx0h9OnXasoAfXJtA
 8SjcYFemWIFRx+jKB3kAqV2GEOo93zz4grkbkoLEEibtQ0JYiuNVcdHLkDfDhp2d7A3EAELlUPy
 8hmdMSWxiWGXim0fyIkZ55lBel5qxBErrAj4Ktbvd24xZOMrcPEo1gZ6dpO3d8VGhQEana9Vgad
 XpoOtLMn0RWaYR4klwVrpPJf3Xvz16we/MNRR+u35mtghjdtKFSk93oershXNO6AlyTPTQIAa6g
 g3zlzuntxIgeV7qCXusRCguAsjn9aB8mGRZH1NQnmSor8BzlrhtcMlNmm2QkkmFExiw898eJrmu
 c4Yz8sAbK8w3uG1hmggUcGtOriQtlJDPtJ5bqo/8i7TTGaTTp
X-Received: by 2002:a17:903:1ac6:b0:2db:331b:e187 with SMTP id
 d9443c01a7336-2dd2a1e0a15mr252149355ad.8.1789315176954; 
 Sun, 13 Sep 2026 08:59:36 -0700 (PDT)
X-Received: by 2002:a17:903:1ac6:b0:2db:331b:e187 with SMTP id
 d9443c01a7336-2dd2a1e0a15mr252148905ad.8.1789315176512; 
 Sun, 13 Sep 2026 08:59:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bbeb053a5sm8076380eec.27.2026.09.13.08.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:59:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 4/6] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Sun, 13 Sep 2026 08:59:26 -0700
Message-Id: <20260913155928.365928-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260913155928.365928-1-brian.cain@oss.qualcomm.com>
References: <20260913155928.365928-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfX/0xsDeB+Nf2B
 t+V6fZ8ms+MkJfQBWWPI+fIf3+qI+9BssjZaIFiUalhYbG2K2dkcn3O5GCCYzqF+QTf4lvhFWht
 QuWx7golS9lTpYh6Ku1ZRZRn/mJ9Uno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIyNyBTYWx0ZWRfXxDbogDXGI8Hn
 d3EhQjfZv4PzpIUSoTpkJOgsBaIZQGoBhiGXgFQUKwhVKK8us2UyExUQ2KnjKbVtsM+aVpbzjRI
 RzVHs++5qNN3E6jYzzKthqFLt5XYj3xjTkL5/G9IeGhiw3VLXGuz1qKb6pHCp0yqWNbMzd85aHF
 SAGvVDYb6N2xhwEvsWt9w2rrli9+rt87TICSRGzIgQkt81XZoKkSBO5ALw4EyAQ1mYOV2xE41vt
 CHcxUMg940G+mhpd0wx7M4I9H6AG1X1qD+MobqxEWmRUU349GlfamtJoO06+/vBWb9K7ctkJmfm
 d7siU5zsICsleh0z87C0Yylh5Q3/u6hcjZ39HPPn8UlEweUZvq8KnmkEoxRSXGf5caE4pynRQ0i
 RChfVyV7NJnAvxJxF1HECnHwO28xunfpsNrAk552CeHw9wuo2lBSGyC9VkeyYB+/E66CGsPIIpo
 +BCHgKb7HLKDk0m+7Sw==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa6c869 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 5SBWRJXxftMYTgTOzCw2NdK20hNYuWXY
X-Proofpoint-GUID: 5SBWRJXxftMYTgTOzCw2NdK20hNYuWXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130227
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

U1NSOlhFIGdhdGVzIGFjY2VzcyB0byB0aGUgSFZYIGNvcHJvY2Vzc29yOiBleGVjdXRpbmcgYW4g
SFZYIGluc3RydWN0aW9uCndoaWxlIGl0IGlzIGNsZWFyIG11c3QgcmFpc2UgYSBwcmVjaXNlIGV4
Y2VwdGlvbiB3aXRoIGNhdXNlIDB4MTYsCk5PX0NPUFJPQ19FTkFCTEUuCgpDYXJyeSBTU1I6WEUg
aW4gYSBUQiBmbGFnIGFuZCBlbWl0IHRoZSBleGNlcHRpb24gZm9yIHRoZQpmaXJzdCBIVlggcGFj
a2V0IG9mIGEgVEIgd2hlbiB0aGUgY29wcm9jZXNzb3IgaXMgZGlzYWJsZWQuCgpSZXZpZXdlZC1i
eTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5oICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgg
fCAgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgfCAgMiArKwogdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMgfCAxMSArKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4
YWdvbi9jcHUuaAppbmRleCBiMTUzMzY4MGJkNy4uOTdmNjg5ZmRhMjIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMDcsNiAr
MjA3LDcgQEAgc3RydWN0IEFyY2hDUFUgewogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1As
IDAsIDEpCiBGSUVMRChUQl9GTEFHUywgTU1VX0lOREVYLCAxLCAzKQogRklFTEQoVEJfRkxBR1Ms
IFBDWUNMRV9FTkFCTEVELCA0LCAxKQorRklFTEQoVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxF
RCwgNSwgMSkKIAogR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihD
UFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBkODYyODM4M2Yx
ZC4uYjg3YTJiMjBlMmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04OSw2ICs4OSw4IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOworICAgIGJvb2wgaHZ4X2NvcHJv
Y19lbmFibGVkOworICAgIGJvb2wgaHZ4X2NoZWNrX2VtaXR0ZWQ7CiAgICAgdWludDMyX3QgbnVt
X2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGZhZDUyNmNjZmI1Li4xOTQ4NmUwZjc0
MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTM0MCw2ICszNDAsOCBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dl
dF90Yl9jcHVfc3RhdGUoQ1BVU3RhdGUgKmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIo
aGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1X21tdV9pbmRleChlbnZfY3B1KGVudiksIGZhbHNlKSk7CiAgICAgaGV4X2ZsYWdzID0g
RklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwgMSk7CisgICAg
aGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VO
QUJMRUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwg
ZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOwogI2Vsc2UKICAgICBoZXhfZmxhZ3MgPSBGSUVM
RF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwgTU1VX1VTRVJfSURYKTsKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwppbmRleCBmZDFkZTg3NDA1Yy4uMGNiM2RiZTU0MjAgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCkBAIC03MjAsNiArNzIwLDE0IEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQo
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAgICBpID0gZmluZF9uZXh0X2JpdChjdHgtPnBy
ZWRpY2F0ZWRfdG1wX3ZyZWdzLCBOVU1fVlJFR1MsIGkgKyAxKTsKICAgICAgICAgfQogICAgIH0K
KworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGN0eC0+cGt0LnBrdF9oYXNfaHZ4
ICYmICFjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5odnhfY2hlY2tf
ZW1pdHRlZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NBVVNFX05PX0NP
UFJPQ19FTkFCTEUsIGN0eC0+cGt0LnBjKTsKKyAgICAgICAgY3R4LT5odnhfY2hlY2tfZW1pdHRl
ZCA9IHRydWU7CisgICAgfQorI2VuZGlmCiB9CiAKIGJvb2wgaXNfZ2F0aGVyX3N0b3JlX2luc24o
RGlzYXNDb250ZXh0ICpjdHgpCkBAIC0xMjM5LDYgKzEyNDcsOSBAQCBzdGF0aWMgdm9pZCBoZXhh
Z29uX3RyX2luaXRfZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgtPm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+
cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9F
TkFCTEVEKTsKKyAgICBjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCA9CisgICAgICAgIEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVEKTsKKyAgICBjdHgtPmh2
eF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5kaWYKIH0KIAotLSAKMi4zNC4xCgo=

