Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CAC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UZr-0003sf-Bd; Tue, 15 Sep 2026 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6UZq-0003sF-2i
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:56:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6UZo-0005rS-Ct
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:56:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FCxpW53264789
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 14:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=; b=j+XmZKFrcbN1jIut
 cLMXDrBsouWoUQwfp1LXVJ46zo9Su48SIyk8/G/bl8Rd1hLPQcAd562oT5KN9u5u
 cD0nt9y2tJkmGl3Q3O01Lg7gi6NUOW1zRo4QQaT/GqR6TheMHZHAfxz6hxidBXDr
 nqv6CqEeR0CGtmrPGb5fgvQkFrKmTFfXtI/njGwMwMC81UGIChYVnYb+HB5a0NPE
 UtICzxNlSmSvEMH6hhZyfHssID9Ryj3nLr1oS4Yj96ZIAbmflFoGkJvngugYgFfE
 szzAiZH99zhDSJGsjlRiBIPfnZmG7VutcjllS0ysIzVUbMk0OPtePgA64EbQkUyK
 Zp2IZQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpxydah16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 14:56:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so6497696a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789484162; x=1790088962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=iOYrPI5eGGY1HpYV+6KfaTSkx82Eu5JseSyLdIKKXUlmqZiLILtWk6u67XHlDJwClE
 QnVlc1au/ViIjE2XLidUAdC/ccCMHeSEdCCHesN0nDlH/kiAH0RtPXluZ4LDIemXay5m
 6+1+MW7Y0IrolF+e5sA7Pv/LmvPxgsZHTCdocCPIiTdtISYMy+d0K5YXB9k+XNzErtEP
 EVtgEnylgwNRhNSzb3/CIzK2tN4ooolb/DTzWHiSuKwphppLjTmzAtznyneOWtGJSGox
 8LT60U8Y8BT+frxtUv9V3xIDJxJV6TIAyfvK7YFc4Fy2o1ckhtJ4CnZy21+yAXkqjxY/
 Wsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484162; x=1790088962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=zeWMycuoCtlQb3/63tkf9l8g5czLXoFYrjI3rYPf/x6cJZs1BhwkyLJoFuBr3A5mP7
 raoJRMdbcsZ5+NH48BxAq3MtZV50RqKqxZyQMJLHwGFUJeJLiz+LYgA8ikP1G6HlBpUq
 ZxECSwdFW4drqFi0rAXdfL/mMZOvefjRMsJm4tPHXeSYgZBQHT+VTpQrz2lQeqLEeyFH
 EIVq5bO2IEcvnoEwDvbjy2EI0IbtXE/VHEkcrLPHB0apFeNKvoijCNfXcP1aXW1wtn8a
 P6a9YyA1U6YvK+zLbC0KRjKvudQk0Lk3E2yU3e+v2+eoZh5W3HlPcRNNAG+wvlKfvW5+
 K4uA==
X-Gm-Message-State: AFuF++n9DZjkmhrvND4F8NJR/NxVgPAMMpeRrKwTIo2AwVZ7IsGFpOgz
 Oh2aI2K/YP9ZDS+ZboqJPr3CNFDPefEFhGs8MyjGPT4gay/MI/Y+itaFW3zPpRmaL/PGD3RxJEx
 a25AAi7Cqhw3UQObqHz09AKT1ASBmQivchoASfUbLSb/B7+bdh3c+33wLjSaAYfNsvA==
X-Gm-Gg: AYBFou132DIvlil8yr+R/25aYj6Bx33CJfhhSBxjawFUFymLyUcX016C9P2iipagePq
 35vsMkU/yRxFCDuGMbeEUyJIJY+qUDE2C8Q+eHAbv2adMCvnJEjUOEyQa24j7KVwwbvbLolM69f
 WagT1iBkl04CFkNox1SczZU6kMB31on/NlscxCrtH7dx7k47oG+DRxpkkIA5kmEbpC4S+NFatxr
 tJ6z165hxHtRtEIOYGUDVGd82RvcfjkBqPdLXZcjxMp+oIxb7Ph8v1QCRkiKuygF66Qnxrg77Bz
 bh+HnJp+QxqLbYDyARwYiTuVgKKc92af8Jfl+CzaxU/7TMQUb0K0Gag8PgZq+1+v1MzkPIFknjN
 77pHnqYxtm6tpzEnttC1DDGKMQ49BdSVdoxrSrzhh6WL+OUR1
X-Received: by 2002:a05:6a20:d090:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3db40422652mr16389924637.10.1789484162298; 
 Tue, 15 Sep 2026 07:56:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:d090:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3db40422652mr16389704637.10.1789484160392; 
 Tue, 15 Sep 2026 07:56:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b287c2775sm6310860b3a.9.2026.09.15.07.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 07:55:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v5 4/6] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Tue, 15 Sep 2026 07:55:39 -0700
Message-Id: <20260915145541.4038637-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
References: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxNyBTYWx0ZWRfXxVPnsw7t0ZHV
 Y90AfED/W5KzDrVu3DfnKTn7uO9p3eoawxLzbQXjDzixG+3HuH9QxreAwmtxD58aNyR+foYlBwa
 BcV0+eUxS4Se6z7eb6MZ4jOLwQyoBT8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxNyBTYWx0ZWRfXyY7QTDrMw9N1
 /SxWz+0sED/aGcMBknG+TeMmlJo8vd2CAxKmFawNc9AgqaPWp2zoXgeqBUJDc/tWFn8M3W40B43
 QQBIc0tA2e36D8/Gu9omiCGxTOsMBRahDfqGDhoPIrds8mrJWSGeIArZ7kp8N9TCddsEKLuVGLJ
 hrPJe68SP8Yn39VcknTE61sXIBJ+PONyACzElPF/vhTaZR3/EMjBII50kczn8KmN05fXI83d0SE
 0bxFkhyNjqJrJCODveClQ6LvMdw9Ygy1DuWgfnvyVGKwlJowTEQaqQSLM0s8xbUblvwYl3P2mjt
 uo1rh1SqkrvyGN/XgFa6KK3uezzsnYHGBqMm0ZXQzuCxHMGkGkvwJ1y0i3/n47Ebo963H5fXvol
 klpF9PlgJo5SfTrc9lVod4/hO9Irkx3Rlhzu/7egpyjEIh+BseoG4GF5rJDs4Fq5dFUpBVBV7E4
 xKzxFUqWPIxbm/VtoqQ==
X-Proofpoint-ORIG-GUID: iku3h6OQCrxFMIPELpdOjQdX69vjkLV1
X-Authority-Analysis: v=2.4 cv=LYepeTfi c=1 sm=1 tr=0 ts=6aa95c83 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: iku3h6OQCrxFMIPELpdOjQdX69vjkLV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150217
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

