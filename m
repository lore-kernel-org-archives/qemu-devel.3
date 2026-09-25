Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6C1C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vAE-0005z7-Kz; Thu, 24 Sep 2026 21:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAC-0005rp-GZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAA-0006BK-Dq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1lNaJ3187737
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qw03TSUT4OFuqkn9z9ic+yAik6QSC2p4Ukr6ZgQrJHY=; b=JilH/S4du62Lgcsn
 60EFhzJ6yIkUlOQHIi+AYR17yNEj244dHJOVCqG5Wf3N1FwrCD5tL3j2v3NFzRJ4
 GMLHrti4N+KuIsRmXM+bK6aticF9PXHkG2vTi669ml7xgsFegBbZ+4Pm/U9YDsq/
 I1nXWh0kaO7OOq18EUyFXLQuar7XcwO0WF3d0M3SE1yYURvV4CuzpNsvwZ/PZkC0
 HT9dUlXE06unuKnAGFsU4f5kBcRe2Eb4cy4OD64aFrJ1X9uVdfTBFrzfFdM/b9CZ
 TdE+DM0YLIbPdsDWpXsrDVbUlzug7Ddnbr4jiVmBeK8WfWpydb8hZw9P7xDo1mPM
 CBKUOA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7ucr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so723271eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301334; x=1790906134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qw03TSUT4OFuqkn9z9ic+yAik6QSC2p4Ukr6ZgQrJHY=;
 b=PA/RY7Wl2HYn2YnR983UleQuk5nfwkC86nIjION8HnV6D9CynwDi2YFr8nttXpTmuF
 +W79p6uh2Q4QrbWfemz4b9VseeZQlnRWAuYb/Euzk+k4qWlzbhufMO3PWQrpvZTC8je5
 Ed4p4fK6EBheSa1ii4CeGkI2Aa+67VslgG3sHsLR5ZbOn7pv278v/g0z8lx9AfHduvSO
 RWZ7ge7vFKiTgu6gi2yUup2/kUWHV7acXrV0hx204ZYk6NGh4fUwtBHRVa2CPJ/QUiPF
 ienv0CV0Gy371HrciJbFVtQD8+J71FgFDtgHKaT7YKNNJYgDagDki37ZFjnobf+6GHZx
 MZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301334; x=1790906134;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qw03TSUT4OFuqkn9z9ic+yAik6QSC2p4Ukr6ZgQrJHY=;
 b=X8byiH6tP4w1OX6p5haDIXmq6SqAJKOYOWw+QAxaE2KheV7OB1rXgCf8xo44iWH9+f
 vgBRZIZDeyhrGhFT0e+hXo5sSocY76/jdhwE2v4E0ZcHjZtiqaNmQMDyf8qPVFJAoqZi
 PclHmQDXjnCad1A6HgfBrg7+/wc49PusTIlAySEEovfFsthVuHpWunFYuBM5mb5QptXo
 Ro9BcMJiBqN7vt4J118It0I/Yp/OxV4KXFQAPlrYo4coFQlg886J7qCULlrcxVlttDU8
 9HyFgJ5zAXTFKRIQEK7S4FXJipZAcqLH8SC5pt0lEkF78Cn9rg6HIrdn4RVElhB0Vjzj
 v+hg==
X-Gm-Message-State: AFuF++k/fESsp+ELBJNByurlCjw4GjoQqfPCaV361er/hUWyr6IK9XLi
 Lal/aYB+E3Ri8Y0wX39Lnv6+j3MMhPz+XJwz5ieU2JO1amsNzu4QLYalsN9+yTKQySTe+HIldZ1
 MCmBYpDMD7Dfkw1HLHEHngVhjte7kko5zS03eXuLdKmxKRYjGFdCs+g1UK7u/wS774A==
X-Gm-Gg: AYBFou3HO2GjL8rbyvwe9d9jOPhXZ54DdC8ZQkc/BL75IialkYZMHkChRqIXMnzSG+q
 sAEd4Qea2wYatIXjmQYBDIe0ICTImQ9LV67LLApQ5ZlWd6ZeY3HVqUg9k4cjKeBHl/AKrVbV8+G
 zUu7Xg/7PznNRmK6a2wPsUMCo3139pklSR6Gknvem8enVjUl5RhnDBTIRZ7C2df04lEyQRcuc0F
 KmXLkUSdYFvsGJ2i4O1XDi5eL1mGsaJ6d1nYOUtjLONd0Vr66I/HmO2z5N2sb6OynX4ZB/QCzLC
 VOVAcKg9yGeKVtab1B3zblmXHlQKfMSRWtHdV73WphXM2HHMq0X85t2R688XlXEwCbA+AL4CqXZ
 GQL7ctw50gae4xbkaabzdcRHuAIMVhVAOHS1eL+opbRUHvJk=
X-Received: by 2002:a05:7301:fc07:b0:341:9040:8ec6 with SMTP id
 5a478bee46e88-3419040924bmr484261eec.41.1790301334150; 
 Thu, 24 Sep 2026 18:55:34 -0700 (PDT)
X-Received: by 2002:a05:7301:fc07:b0:341:9040:8ec6 with SMTP id
 5a478bee46e88-3419040924bmr484250eec.41.1790301333633; 
 Thu, 24 Sep 2026 18:55:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 31/40] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Thu, 24 Sep 2026 18:54:20 -0700
Message-Id: <20260925015429.2579174-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: wHCMIOgBHNO1zwf_MyXIJy56m6PfRP16
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab5d497 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXwddeZGXmmpUB
 5Y2pvgCicO5Rv5Ej7y0mp0pypWl4LeWW2Xf++avor9eva417H4ofWCwMN8/X39Jc7zpXPv7MyS1
 J2Ib2cS6Us0MXhlCTN74f/4o1AjCQgvSxxwCEZ8NXfZahgdRpmXc6xp/SJcUb+5x0inAl9PodGX
 A7rCHCoI0E4+A++uoMgJA7ElKvt+53KGPMarx7I0qmGaKDGQA6BC/JSYYZRsSYxDZH21ctvqDR0
 d0WBCqqUJEuzWNwvolwgFSVTSircJwO/z/C1mffusKxNodxdh1zhAsFycy5BRy90tQArj9hIHFW
 63N4vSSSBeGp3DfdCP7ULmrt2gFcaPwSyyQ7r2ualOByOweUcqDDGvNlmKb//DWjcEatEsErprD
 LhlXorfoP4o3HF348/ioyHsyUNjvKG+S3WgjbLPID6thjz4Von9mLxgpee40XGQXKDrz/4E2rIu
 deSm4giqiP9vQa5A6Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX4h23hLslv5J2
 exUZfKf9hPXwECne1wEc4F5d9qHC4tlitCFKBkLsmXpjEfKXJs86zoxybhJThS2GkbHleo2UN3v
 Dqxrc+bMl9k0vrJIkEnZDZNtscXZ88U=
X-Proofpoint-ORIG-GUID: wHCMIOgBHNO1zwf_MyXIJy56m6PfRP16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBiOTBmN2ZmZjFj
MS4uYjMzZDVkYmRiZTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC05OCw2ICs5OCw4IEBAIHR5cGVkZWYg
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
YWdvbi90cmFuc2xhdGUuYwppbmRleCA4NTYxY2VjNGU0MS4uYmY5MjE2NmUwZmQgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCkBAIC03NjYsNiArNzY2LDE0IEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQo
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAgICBpID0gZmluZF9uZXh0X2JpdChjdHgtPnBy
ZWRpY2F0ZWRfdG1wX3ZyZWdzLCBOVU1fVlJFR1MsIGkgKyAxKTsKICAgICAgICAgfQogICAgIH0K
KworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGN0eC0+cGt0LnBrdF9oYXNfaHZ4
ICYmICFjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5odnhfY2hlY2tf
ZW1pdHRlZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NBVVNFX05PX0NP
UFJPQ19FTkFCTEUsIGN0eC0+cGt0LnBjKTsKKyAgICAgICAgY3R4LT5odnhfY2hlY2tfZW1pdHRl
ZCA9IHRydWU7CisgICAgfQorI2VuZGlmCiB9CiAKIGJvb2wgaXNfZ2F0aGVyX3N0b3JlX2luc24o
RGlzYXNDb250ZXh0ICpjdHgpCkBAIC0xMjg5LDYgKzEyOTcsOSBAQCBzdGF0aWMgdm9pZCBoZXhh
Z29uX3RyX2luaXRfZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgtPm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+
cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9F
TkFCTEVEKTsKKyAgICBjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCA9CisgICAgICAgIEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVEKTsKKyAgICBjdHgtPmh2
eF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5kaWYKIH0KIAotLSAKMi4zNC4xCgo=

