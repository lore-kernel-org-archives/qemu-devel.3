Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52773C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIJ-0004Aw-NX; Mon, 29 Jun 2026 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHs-0003sF-O3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHr-0006Nr-1Y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATBNc2647651
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=; b=Te
 vWyd1SZj8Q9Jnv200rhaCuHytCrGfXcpNPINw3mZ/8ubXZ0pjZtgftxlYX5YGVc3
 OEjILMejG/8mnRnyWUTbRwmDqwlvD9lCLbym1w49/ZCVGLrsLId4B/27PqxkMwZ3
 4QrFVKx+M4SWpPrUuuvo/G9k/c61B+xu9Zq3HaM1+34swbuKv9e0dC46zxAstjcQ
 w4yZ+z+G4AaXf+TQwJink6lMVRIRDv3xy63cf/GUSAb+Z+jVFvu+mf9IP//z+sBd
 M0twPZR3UgxCpAxJ67Z8cUztOIMSlOonATEne2iHVYU06y5AmnBiAYrT6nK0M4gx
 NbXZK/3hruoazphbb5yg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhj6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c9ae1da340so35448515ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740673; x=1783345473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=;
 b=DV5PZ/rS2LQR9YFFBSJM+OIQgOoRX62Bvb01rwOKxMjbvDOQ0UhX4HCOkeiV2LOV6g
 ALSzgILi96Bpt3Stb0lvrAiUXI0si0q/wW/HA61+6lyS+/PEN/i7HmUtl6WMHKlfkm2K
 QzPFIY9yL7XcmhGrlkjC6jQgq4lNZdK7WJD+prbg283zbLdT7yZDfbbSPMK3CwQBRpL9
 ARcO8y4tbb09GJTrpZ5oZTmKhLbaM/IA4ePgiOBVA7WJGcYGvhSho5bb0PF9iRMJB5Rm
 s8XjMD9fnsM89Jq9t4AD5zNCH/u57u/yLpwt3D3vrWU+2akrElSd9eOsOraXZ6G81/U2
 VxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740673; x=1783345473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koogbpqsRfa0PrvfbI4x1+QqWqwbbpCsK4Ya9bbJIn4=;
 b=RSVw1s4540UPHVqTabKT1MZN7NQ1YZu7AuRVuLMG8vVn12gH+UqWeJ5+yI4Tatxikj
 ONGNri86Pj7TXuzFcwsv3JUE5clq4pZYDGMLO5PBzoXDB9dDphDxkdTqPgExIHUa8W7U
 mnFQVF2yutp1rIo8NubUd1TR0Lz2Kr6dG1D4Fk7Xd7u9rlP1nPT4oLQKRrZm7MDKIdCp
 WiPB1gXy+6ix7tfuWin7lFu+BN9mwGAX+KLZ0wFBkmIu6NyzCVzm5GN024IphPRjuien
 weQn9jJkPwoNhtqk1gExzU9c69rnJFqPoe6gyXLj4QankLn0D9qjxjbipLUd8wiVQO5s
 k1uw==
X-Gm-Message-State: AOJu0YwleN9GMHTcsiHVobFnZptqYuuIq+Fbsvu3dEPRHz3WmUbh8TpR
 AdA1h6GosbgSk3k2B0ZwLCzIW4DHQR2Z9ImkAgdR8rHf+pq46b/oR/HunN/nYzA2lHqCKtfWNPs
 15z3KMk5xguvMJhNT7XtWFGpslKAWtJYiRVTTr56l1wo/lYW/cel1vqwYF0r/htOj4w==
X-Gm-Gg: AfdE7cn4JzFcf2+sbX4wY+uszSInBvxQNByVSnnxJmzP8R/niWwPgVoAcIrE5tTz3FK
 gS4IlRBPWlA9kTxdyA705yBoDf/ErJ3nOVkBDM6GMdgjpzauuT0sP5RrJSV/ABLV4vQjaAg9wE6
 pDoW9CS5YwnEtcj3SWrzthIjGtLLyVsix6uLsq93mnOyQjEJbHQEk1JHBgpL/hOE8TDTd1T6X2m
 GvOhzzfWT6qcLC6Nyp8dDk3Evt7IZh4Qu1KbjMGnDJaoSBDpWut48an3cTLswzfNBqtZVKlVXmx
 h3h8svbpncF+EwoV9BqCTpQT6kaenPRzaK4M9MxB+C3r9Gbzmzs27Xyf0f82vwZXZCP7xZdMoJu
 aFNTBd0fg+STBXkeRoJg/NHQGB4fFnx0Ywl4kj/pKAE0NHmvj1EKev16em+w=
X-Received: by 2002:a17:903:2443:b0:2c9:ceb9:865b with SMTP id
 d9443c01a7336-2c9ceb989a7mr53432205ad.21.1782740672837; 
 Mon, 29 Jun 2026 06:44:32 -0700 (PDT)
X-Received: by 2002:a17:903:2443:b0:2c9:ceb9:865b with SMTP id
 d9443c01a7336-2c9ceb989a7mr53431905ad.21.1782740672374; 
 Mon, 29 Jun 2026 06:44:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 73/77] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Mon, 29 Jun 2026 06:12:28 -0700
Message-Id: <20260629131232.2487780-74-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: CS3CNw_CQLwx49NwV-qHWCOzzYUco7Jg
X-Proofpoint-ORIG-GUID: CS3CNw_CQLwx49NwV-qHWCOzzYUco7Jg
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a4276c1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX+9tF88z44tNH
 AG3GTkNrLFB52TpeJKyxwI1mcVzQgGAaM+g+8rpJ+HW7SsGTTmsVmt5vq/5hYn7kIs8fhAj/5nv
 yGhlJAPYsqfPkklxlqO8Fn/RusMKmjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXwNeHvFtPSFRU
 gWKQyTHxQEbFMSuejr492HU9bZRfm4LgUXuZ/1E3MyhBEJyJQ3GlDYJ8gLLzJiuIuUiQJNu/gkq
 +I85PnEv8J5FP9emrwiDk9B5H5uBIewuLiw5Qnq9C3+BwDn9uleBQwS9zomhgmmVWk2KINTiyWc
 ABtXagDzqz9ROxVFz03HaNxlXQ+AIMK9C0O9f0wynNohtm7Ez6Da2E7I2dU1i9UOjW/VbMQlUs/
 UE925hBs5PEw3jKezOmWyXCIhtgfjRseJ0GikHPSvlrtmpXBKk5njBkthmA8W1jHrPQHkySNeWH
 Z2xgpWU0kOHhOCdKJUlHgpbwepOkXKodguGqj7oOymH3Whfav5ZhxPy95qoy/mLzh8F77tsgQpA
 0PWhbT4hP0vpbojnDd8Lf9Bn9bLJOpmQYMfO8TeTAH8mJh1zbUlk72BwyHSSEpe9An9ef6tA9z0
 pB9q7Sq7FcOQj23VWIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFj
aGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysK
IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jICAgIHwgNjQgKysrKysrKysr
KysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKykKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5j
CgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVfY2RzcDAuaC5pbmMg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNDQyY2JlM2JlMzEKLS0tIC9kZXYvbnVsbAorKysg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwpAQCAtMCwwICsxLDY0
IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLworCitz
dGF0aWMgY29uc3Qgc3RydWN0IGhleGFnb25fbWFjaGluZV9jb25maWcgU0E4Nzc1UF9jZHNwMCA9
IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgMHgyNDAwMDAwMCArIDB4MTgwMDAwLAorICAgIC5s
MnRjbV9zaXplID0gICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAweDI2
MzAwMDAwICsgMHg5MDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgMHgwMDAwMTAwMCwKKyAg
ICAuY3NyX2Jhc2UgPSAgICAgICAgMHgyNjMwMDAwMCwKKyAgICAucXRtcl9yZWdpb24gPSAgICAg
MHgyNjMwMDAwMCArIDB4QTEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21f
YmFzZSA9IDB4MDAwMDI0MDAsCisgICAgICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAg
ICAgICAuc3Vic3lzdGVtX2Jhc2UgPSAweDAwMDAyNjM4LAorICAgICAgICAuZXRtX2Jhc2UgPSAw
eDAwMDAyNDE5LAorICAgICAgICAubDJjZmdfYmFzZSA9IDB4MDAwMDI0MWEsCisgICAgICAgIC5y
ZXNlcnZlZDEgPSAweDAwMDAyNDFiLAorICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwMjUwMCwK
KyAgICAgICAgLmF4aTJfbG93YWRkciA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdHJlYW1lcl9i
YXNlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2VydmVkMiA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5mYXN0bDJ2aWNfYmFzZSA9IDB4MDAwMDI0MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50
cmllcyA9IDB4MDAwMDAwODAsCisgICAgICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEs
CisgICAgICAgIC5leHRfY29udGV4dHMgPSAweDAwMDAwMDA0LAorICAgICAgICAudnRjbV9iYXNl
ID0gMHgwMDAwMjUwMCwKKyAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDIwMDAsCisgICAg
ICAgIC5sMnRhZ19zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAw
eDAwMDAwMDAwLAorICAgICAgICAudGhyZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAg
ICAgICAgLmVjY3JlZ19iYXNlID0gMHgwMDAwMjQxZiwKKyAgICAgICAgLmwybGluZV9zaXplID0g
MHgwMDAwMDA4MCwKKyAgICAgICAgLnRpbnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5s
Mml0Y21fc2l6ZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMDI0
MDAsCisgICAgICAgIC5yZXNlcnZlZDMgPSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNl
bnQgPSAweDAwMDAwMDAwLAorICAgICAgICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAzLAorICAg
ICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQg
PSAweDAwMDAwMDAwLAorICAgICAgICAuY29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAg
IC5jb3Byb2MyX3JlZzAgPSAweDAwMDAwMDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgw
MDAwMDAyMCwKKyAgICAgICAgLnYyeF9tb2RlID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmNvcHJv
YzJfcmVnMiA9IDB4MDAwMDAwMDgsCisgICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDAwMDAwMDIw
LAorICAgICAgICAuY29wcm9jMl9yZWc0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnNSA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3Byb2MyX3JlZzYgPSAweDAwMDAwMDE2LAor
ICAgICAgICAuY29wcm9jMl9yZWc3ID0gMHgwMDAwMDAwNiwKKyAgICAgICAgLmFjZF9wcmVzZXQg
PSAweDAwMDAwMDAxLAorICAgICAgICAubW5kX3ByZXNldCA9IDB4MDAwMDAwMDAsCisgICAgICAg
IC5sMWRfc2l6ZV9rYiA9IDB4MDAwMDAwMTAsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MDAw
MDAwMjAsCisgICAgICAgIC5sMWRfd3JpdGVfcG9saWN5ID0gMHgwMDAwMDAwMiwKKyAgICAgICAg
LnZ0Y21fYmFua193aWR0aCA9IDB4MDAwMDAwODAsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDAw
MDAwMDAxLAorICAgICAgICAucmVzZXJ2ZWQ1ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2Vy
dmVkNiA9IDB4MDAwMDAwMDMsCisgICAgICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAw
MDAwMGEsCisgICAgICAgIC5jb25zaXN0ZW5jeV9kb21haW4gPSAweDAwMDAwMGUwLAorICAgICAg
ICAuY2FwYWNpdHlfZG9tYWluID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9
IDB4MDAwMDAwMDAsCisgICAgfSwKK307CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVf
Y2ZnX3Y2OG5fMTAyNC5oLmluYyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0Lmgu
aW5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4wYzc5Njg5YmMyMQot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5j
CkBAIC0wLDAgKzEsNjQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyICovCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB2
NjhuXzEwMjQgPSB7CisgICAgLmNmZ2Jhc2UgPSAgICAgICAgICAgMHhkZTAwMDAwMCwKKyAgICAu
bDJ0Y21fc2l6ZSA9ICAgICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAg
IDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3NpemUgPSAgICAgICAgMHgwMDAwMTAwMCwKKyAgICAu
Y3NyX2Jhc2UgPSAgICAgICAgICAweGZjOTAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAg
IDB4ZmM5MjEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21fYmFzZSA9IDB4
MDAwMGQ4MDAsCisgICAgICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAgICAgICAuc3Vi
c3lzdGVtX2Jhc2UgPSAweDAwMDBmYzkwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5
LAorICAgICAgICAubDJjZmdfYmFzZSA9IDB4MDAwMGQ4MWEsCisgICAgICAgIC5yZXNlcnZlZDEg
PSAweDAwMDAwMDAwLAorICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwZDg0MCwKKyAgICAgICAg
LmF4aTJfbG93YWRkciA9IDB4MDAwMDMwMDAsCisgICAgICAgIC5zdHJlYW1lcl9iYXNlID0gMHgw
MDAwZDgxYywKKyAgICAgICAgLnJlc2VydmVkMiA9IDB4MDAwMGQ4MWQsCisgICAgICAgIC5mYXN0
bDJ2aWNfYmFzZSA9IDB4MDAwMGQ4MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50cmllcyA9IDB4
MDAwMDAwODAsCisgICAgICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEsCisgICAgICAg
IC5leHRfY29udGV4dHMgPSAweDAwMDAwMDA0LAorICAgICAgICAudnRjbV9iYXNlID0gMHgwMDAw
ZDg0MCwKKyAgICAgICAgLnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDEwMDAsCisgICAgICAgIC5sMnRh
Z19zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAweDAwMDAwNDAw
LAorICAgICAgICAudGhyZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAgICAgICAgLmVj
Y3JlZ19iYXNlID0gMHgwMDAwZDgxZiwKKyAgICAgICAgLmwybGluZV9zaXplID0gMHgwMDAwMDA4
MCwKKyAgICAgICAgLnRpbnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fc2l6
ZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MjAsCisgICAg
ICAgIC5yZXNlcnZlZDMgPSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNlbnQgPSAweDAw
MDAwMDAwLAorICAgICAgICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAxLAorICAgICAgICAuaHZ4
X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQgPSAweDAwMDAw
MDAwLAorICAgICAgICAuY29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Byb2My
X3JlZzAgPSAweDAwMDAwMDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgwMDAwMDAyMCwK
KyAgICAgICAgLnYyeF9tb2RlID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMiA9
IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDFmMWYxZjFmLAorICAgICAg
ICAuY29wcm9jMl9yZWc0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNSA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzYgPSAweDFmMWYxZjFmLAorICAgICAgICAu
Y29wcm9jMl9yZWc3ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmFjZF9wcmVzZXQgPSAweDFmMWYx
ZjFmLAorICAgICAgICAubW5kX3ByZXNldCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5sMWRfc2l6
ZV9rYiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5sMWRfd3JpdGVfcG9saWN5ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnZ0Y21fYmFu
a193aWR0aCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDFmMWYxZjFmLAor
ICAgICAgICAucmVzZXJ2ZWQ1ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNiA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5jb25zaXN0ZW5jeV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuY2FwYWNp
dHlfZG9tYWluID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9IDB4MWYxZjFm
MWYsCisgICAgfSwKK307Ci0tIAoyLjM0LjEKCg==

