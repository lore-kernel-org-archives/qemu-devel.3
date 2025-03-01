Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC985C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPh-0000og-60; Sat, 01 Mar 2025 00:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPf-0000kn-3v
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPd-0008PA-4p
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:22 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214dhpS027225
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 anJeR7JBHMCNo7CO2Pbad57KBKIBbqcgLbQHoEN9g9U=; b=HNJSoNOgfAJm7G1y
 6UCHDgDJbmZX0RMT74jl85nSxpq+JeHHN7J4XX1fQRzHrj3tsMn4mnog4GoPKFGT
 inKTa6teM7nUgtgocqWZOCAnv7PEvf43QStmmrB/LiXFSJRStfmCNKmynZY+Vgs2
 JOzapRyPcAymnABzR1tbqj58YdIKlA0Be4j12nuZOV+lhMotrIAA2iGqE+UE9vAr
 UeSVmaebumnKeety0dJQswlHxVyEFbllZpMeJrfFoIsyM+X7D04f5bd9FahsF7JJ
 DDG4T0iWrPKYl42y9WSfQDfuw1m/whCAy+JyMQOzAXPquW4U9f+CL8aRswA85L1x
 4wdlMw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453udgr29d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fe86c01f5cso5848678a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806948; x=1741411748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anJeR7JBHMCNo7CO2Pbad57KBKIBbqcgLbQHoEN9g9U=;
 b=RwWljId/O7bUupoel79yFr02Ui0ukRwwq3632lAF9Sz4fBkbj+LnFPN/3kGSBmUTTc
 7aOkPCAINhhWWTNSLhzZV739hjVMnzWP9ZOyKc4TVPIqnyHndN3kV9twdW3JzIOCzOOK
 7HS3W1QOVF3r0tljdfFFundviJK+voSZ+2W0L8vvubwRYNi4tGKIlEaW1UUiaDqkiUb3
 AHacRkBRl3xPKaxcprXtWMTj1FjC40JeY+9ElFjgwXQ8Xr7ouoNofX4f/d7TgoYIWXe/
 SJYP0yvLYhjeS9qUsF+ut3JACFfDnCOW1qD+x7QYd2qZcCka7zvMS37LZl0k5rHnwJK2
 dmDA==
X-Gm-Message-State: AOJu0YwYvd+0GfuC8rVJ3+eClsg+hG/9jn8yZ80hqf3vj4o5g8mhhWQJ
 4lojTujUMXD7Clk7ZP7hNt6kefjIUo/SxBbBw9V7BXsCv9hBXSvNc2qcJ9n6eqErM1RiqMb9CwB
 H375T9vVLpvYwTPNoixVUSJ6QBfKyDdMx7aL6LelNriqFkgxXJdDQNva8swEE6Q==
X-Gm-Gg: ASbGncusgSHf07kWlY6pL/3Q5Yr/uCaqaqKLAu+Z8mp/827TXLieGHAssGO/TS3q0eI
 GgzQD3bpEij5YAbbgQrBczYuUBQ35t1fs/L2TrPvqvwDXTCHvbbPLMddauMRolZtBiaHxUQuJ9o
 rqk/J7BjsvM54sOJIlHEHm8vThJRzSk6U33h5i2N8ve/zwtstmat8awEnwLDoSsUuJK2y4k1nrR
 iqknlQaio7TkV+WvpdX2vKhWBzVxLMWttPnHfYMwflEfL7Js/z5sVyG51uxDna062TBuywSGT7e
 sSAbUWgt1jlnGtUZ3c60h0mbsn66Q6/6hTehtF6lmeHhKFuwhzOX9ThKMI4vtt6W
X-Received: by 2002:a17:90b:3ec4:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2febabdc25emr10069540a91.27.1740806948359; 
 Fri, 28 Feb 2025 21:29:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhBoRbn0TaX82jSkSdrOypGGKOLeiN5oqsPCurFYnt2tKeEQDFb5pFvPuE6L2sJDZnAFnAlg==
X-Received: by 2002:a17:90b:3ec4:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2febabdc25emr10069523a91.27.1740806947984; 
 Fri, 28 Feb 2025 21:29:07 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:07 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 14/39] target/hexagon: Add system event, cause codes
Date: Fri, 28 Feb 2025 21:28:20 -0800
Message-Id: <20250301052845.1012069-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 2gBj5wTYkcSDgkdH0B9CcHEtkjtePtG6
X-Proofpoint-ORIG-GUID: 2gBj5wTYkcSDgkdH0B9CcHEtkjtePtG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmggICAgICB8IDEwICsrKysrKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggfCA1NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwg
NDkgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA3ZTJlYTgzOGM1Li5kYWJl
ZTMxMGM1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtNjcsNiArNjcsMTUgQEAgdHlwZWRlZiBzdHJ1Y3QgQ1BVSGV4YWdvblRM
QkNvbnRleHQgQ1BVSGV4YWdvblRMQkNvbnRleHQ7CiAjZGVmaW5lIE1NVV9HVUVTVF9JRFggICAg
ICAgIDEKICNkZWZpbmUgTU1VX0tFUk5FTF9JRFggICAgICAgMgogCisjZGVmaW5lIEhFWEFHT05f
Q1BVX0lSUV8wIDAKKyNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzEgMQorI2RlZmluZSBIRVhBR09O
X0NQVV9JUlFfMiAyCisjZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV8zIDMKKyNkZWZpbmUgSEVYQUdP
Tl9DUFVfSVJRXzQgNAorI2RlZmluZSBIRVhBR09OX0NQVV9JUlFfNSA1CisjZGVmaW5lIEhFWEFH
T05fQ1BVX0lSUV82IDYKKyNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzcgNworCiB0eXBlZGVmIGVu
dW0gewogICAgIEhFWF9MT0NLX1VOTE9DS0VEICAgICAgID0gMCwKICAgICBIRVhfTE9DS19XQUlU
SU5HICAgICAgICA9IDEsCkBAIC03NSw3ICs4NCw2IEBAIHR5cGVkZWYgZW51bSB7CiB9IGhleF9s
b2NrX3N0YXRlX3Q7CiAjZW5kaWYKIAotCiAjZGVmaW5lIENQVV9SRVNPTFZJTkdfVFlQRSBUWVBF
X0hFWEFHT05fQ1BVCiAKIHR5cGVkZWYgc3RydWN0IHsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdV9iaXRzLmggYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCmluZGV4IDYxMDA5NGE3
NTkuLmM3Y2M0MjZlYzggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmgKKysr
IGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaApAQCAtMjQsMTQgKzI0LDE2IEBACiAjZGVmaW5l
IFBDQUxJR05fTUFTSyAoUENBTElHTiAtIDEpCiAKIGVudW0gaGV4X2V2ZW50IHsKLSAgICBIRVhf
RVZFTlRfTk9ORSAgICAgICAgICAgPSAtMSwKLSAgICBIRVhfRVZFTlRfVFJBUDAgICAgICAgICAg
PSAgMHgwMDgsCi0gICAgSEVYX0VWRU5UX0ZFVENIX05PX1VQQUdFID0gIDB4MDEyLAotICAgIEhF
WF9FVkVOVF9JTlZBTElEX1BBQ0tFVCA9ICAweDAxNSwKLSAgICBIRVhfRVZFTlRfSU5WQUxJRF9P
UENPREUgPSAgMHgwMTUsCi0gICAgSEVYX0VWRU5UX1BDX05PVF9BTElHTkVEID0gIDB4MDFlLAot
ICAgIEhFWF9FVkVOVF9QUklWX05PX1VSRUFEICA9ICAweDAyNCwKLSAgICBIRVhfRVZFTlRfUFJJ
Vl9OT19VV1JJVEUgPSAgMHgwMjUsCisgICAgSEVYX0VWRU5UX05PTkUgPSAtMSwKKyAgICBIRVhf
RVZFTlRfUkVTRVQgPSAweDAsCisgICAgSEVYX0VWRU5UX0lNUFJFQ0lTRSA9IDB4MSwKKyAgICBI
RVhfRVZFTlRfUFJFQ0lTRSA9IDB4MiwKKyAgICBIRVhfRVZFTlRfVExCX01JU1NfWCA9IDB4NCwK
KyAgICBIRVhfRVZFTlRfVExCX01JU1NfUlcgPSAweDYsCisgICAgSEVYX0VWRU5UX1RSQVAwID0g
MHg4LAorICAgIEhFWF9FVkVOVF9UUkFQMSA9IDB4OSwKKyAgICBIRVhfRVZFTlRfRlBUUkFQID0g
MHhiLAorICAgIEhFWF9FVkVOVF9ERUJVRyA9IDB4YywKICAgICBIRVhfRVZFTlRfSU5UMCA9IDB4
MTAsCiAgICAgSEVYX0VWRU5UX0lOVDEgPSAweDExLAogICAgIEhFWF9FVkVOVF9JTlQyID0gMHgx
MiwKQEAgLTUzLDE1ICs1NSwzOCBAQCBlbnVtIGhleF9ldmVudCB7CiBlbnVtIGhleF9jYXVzZSB7
CiAgICAgSEVYX0NBVVNFX05PTkUgPSAtMSwKICAgICBIRVhfQ0FVU0VfUkVTRVQgPSAweDAwMCwK
LSAgICBIRVhfQ0FVU0VfVFJBUDAgPSAweDE3MiwKLSAgICBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBB
R0UgPSAgMHgwMTIsCi0gICAgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUID0gIDB4MDE1LAotICAg
IEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSA9ICAweDAxNSwKLSAgICBIRVhfQ0FVU0VfUENfTk9U
X0FMSUdORUQgPSAgMHgwMWUsCi0gICAgSEVYX0NBVVNFX1BSSVZfTk9fVVJFQUQgID0gIDB4MDI0
LAotICAgIEhFWF9DQVVTRV9QUklWX05PX1VXUklURSA9ICAweDAyNSwKKyAgICBIRVhfQ0FVU0Vf
QklVX1BSRUNJU0UgPSAweDAwMSwKKyAgICBIRVhfQ0FVU0VfVU5TVVBPUlRFRF9IVlhfNjRCID0g
MHgwMDIsIC8qIFFFTVUtc3BlY2lmaWMgKi8KKyAgICBIRVhfQ0FVU0VfRE9VQkxFX0VYQ0VQVCA9
IDB4MDAzLAorICAgIEhFWF9DQVVTRV9UUkFQMCA9IDB4MDA4LAorICAgIEhFWF9DQVVTRV9UUkFQ
MSA9IDB4MDA5LAorICAgIEhFWF9DQVVTRV9GRVRDSF9OT19YUEFHRSA9IDB4MDExLAorICAgIEhF
WF9DQVVTRV9GRVRDSF9OT19VUEFHRSA9IDB4MDEyLAorICAgIEhFWF9DQVVTRV9JTlZBTElEX1BB
Q0tFVCA9IDB4MDE1LAorICAgIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSA9IDB4MDE1LAorICAg
IEhFWF9DQVVTRV9OT19DT1BST0NfRU5BQkxFID0gMHgwMTYsCisgICAgSEVYX0NBVVNFX05PX0NP
UFJPQzJfRU5BQkxFID0gMHgwMTgsCiAgICAgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19HSU5TTiA9
IDB4MDFhLAogICAgIEhFWF9DQVVTRV9QUklWX1VTRVJfTk9fU0lOU04gPSAweDAxYiwKKyAgICBI
RVhfQ0FVU0VfUkVHX1dSSVRFX0NPTkZMSUNUID0gMHgwMWQsCisgICAgSEVYX0NBVVNFX1BDX05P
VF9BTElHTkVEID0gMHgwMWUsCisgICAgSEVYX0NBVVNFX01JU0FMSUdORURfTE9BRCA9IDB4MDIw
LAorICAgIEhFWF9DQVVTRV9NSVNBTElHTkVEX1NUT1JFID0gMHgwMjEsCisgICAgSEVYX0NBVVNF
X1BSSVZfTk9fUkVBRCA9IDB4MDIyLAorICAgIEhFWF9DQVVTRV9QUklWX05PX1dSSVRFID0gMHgw
MjMsCisgICAgSEVYX0NBVVNFX1BSSVZfTk9fVVJFQUQgPSAweDAyNCwKKyAgICBIRVhfQ0FVU0Vf
UFJJVl9OT19VV1JJVEUgPSAweDAyNSwKKyAgICBIRVhfQ0FVU0VfQ09QUk9DX0xEU1QgPSAweDAy
NiwKKyAgICBIRVhfQ0FVU0VfU1RBQ0tfTElNSVQgPSAweDAyNywKKyAgICBIRVhfQ0FVU0VfVldD
VFJMX1dJTkRPV19NSVNTID0gMHgwMjksCisgICAgSEVYX0NBVVNFX0lNUFJFQ0lTRV9OTUkgPSAw
eDA0MywKKyAgICBIRVhfQ0FVU0VfSU1QUkVDSVNFX01VTFRJX1RMQl9NQVRDSCA9IDB4MDQ0LAor
ICAgIEhFWF9DQVVTRV9UTEJNSVNTWF9DQVVTRV9OT1JNQUwgPSAweDA2MCwKKyAgICBIRVhfQ0FV
U0VfVExCTUlTU1hfQ0FVU0VfTkVYVFBBR0UgPSAweDA2MSwKKyAgICBIRVhfQ0FVU0VfVExCTUlT
U1JXX0NBVVNFX1JFQUQgPSAweDA3MCwKKyAgICBIRVhfQ0FVU0VfVExCTUlTU1JXX0NBVVNFX1dS
SVRFID0gMHgwNzEsCisgICAgSEVYX0NBVVNFX0RFQlVHX1NJTkdMRVNURVAgPSAweDgwLAorICAg
IEhFWF9DQVVTRV9GUFRSQVBfQ0FVU0VfQkFERkxPQVQgPSAweDBiZiwKICAgICBIRVhfQ0FVU0Vf
SU5UMCA9IDB4MGMwLAogICAgIEhFWF9DQVVTRV9JTlQxID0gMHgwYzEsCiAgICAgSEVYX0NBVVNF
X0lOVDIgPSAweDBjMiwKLS0gCjIuMzQuMQoK

