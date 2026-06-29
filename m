Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E47C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3ex-0005U1-RM; Mon, 29 Jun 2026 00:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dT-0002hO-4O
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dN-0001FW-6E
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NObw1719481
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=; b=oJTWpj3bTuFYONpN
 a7OuBXILF0FCIdxGcAdAyI0ppgaKTGWpuDPJcjMvUFp4N6OI0rCBtqxGepqzg2td
 Xdlr5uQEgo5r4wMGPQUiGa3IK0BgIgeh2uNItIwKrVxwIuZg4U7v99XDD9716j1M
 nktS/98VuMidgNHz5FiYlIeluRHeEv7kUR7h0+/MvUqT5dVhJSzASis5LivGfb/b
 fTuAO/AUPNnrRyGFDVmrNkHj1aUqNfQw6vBs5ukReBXGkylsTeH+QcDq9VOB37jB
 ZMnwuUUp705FKZHW72WHqtuX+vocpFVkytpqzY9dkieX0sRefXp6X+CKitZxfiWS
 aT9rNw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf49ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso7999465eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707410; x=1783312210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=iVsCLG9nRkzDD3tbL3Kp9XLr+HfLNXWUP1Ur+hlRjl1Bh2V1Mv6emTL/nNt7G6HMTo
 o8ZN/voQKwYikSA3zT5VlpSkRZ4WYZy3HbpJHC/CUeT5fn66aPTPH24SSZr0Kf6zNPJH
 5W7vO3G2/wz9tIXcBhwhaI1xnnC3qWN8FAaCKDzoDBJPCnU8P/vmHvYgc6cLELM/EWh3
 cSeoed/sdDYMbI9c/sqhEbJqC0T8rywiAe24gYbhLvALcDKA6dTsNAfu5MWKtJfYEkfH
 2qlil7+22t+IxOIc+LuiVv6fhW3gNX4v1VfG62WCkfq1PpUPl3hCT6z2VLvHIE1rEsHh
 +Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707410; x=1783312210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=NCiA5xyhMD7CnlQHPFIoFBmAU4aL8dEXEoTT6QpSl6OBcWpGbzXMa4+dNn5XShli5Y
 3db3TPWcTz4xm8UhaQasAxKciTt5hDtazOj6ZA2hGpaRYudoaXNT6fiFPJZ3yM9DKSKm
 xonQI/Vqp9/2NJ6JCzpqgnMDqYMnfFFs8qeFsZU6lOF1WACRf0XODHhfl9zLAK389mUl
 S/DkjueHBkJnwHyA24uDLcPGeC8DzWEtFpnIR2RyQz5iENFN4kC1EzEDGVuXXhTFjgaM
 l07cjTCnA54vM/r4muEldldBpLqaqk7dMs8PdBpDvldugwONd/NXDivO4aRtRQQyHbU+
 ClvA==
X-Gm-Message-State: AOJu0YwsqpCUh1NDQCcXpd+ZneUQ7oISwPxxaB381oaUGC02DOilTFNt
 JVEtgLG1E2VmOWU943SyMR/XJBJZtta+UJTBcibS3gq9spXmpO4dKOO2BKXJnNQwLGheNWBIDqN
 w+4+hK3DRHls1vprQW50N68GC6TAbDrGUIRrXk/qQWLuO6PiiRlg1bAdsCdU45NBI4g==
X-Gm-Gg: AfdE7cl47nUvw5GJWND18vLzi6xvMB1VGw7Qmvnb6CnoBYzeKr8ID0+VAi8kAZCClR/
 FqiKMz92vrqmdKq/z9Vrge0Mpls8n8K/7ldxn4Th05W9abjYuBB2cjLb0CadYR5F0VZLV5L5WpT
 hNB5Le7dn2ZYOQze75Pqf4iGQ3/5lN3vuEWmaP7afHRcczuirnrCeD6HBcK0Ey4JXAEPACtxyuo
 VOUJCtDQAYalFNjL9/PjauCqFyLLj1rymByg2+lqQ5B/3gLf4xjieDqAWbpovlwJsX+df3oiky2
 g5TX8ZnpVLU5vMw2kb0/abmgIBgqqYJoj6d/B3ozwinKMvievi83cJh8a9m/Lip4ba3akZYsrLT
 JDD7E2dETOVLJjFse3yMg6uQHgxildCFJ4kF5GBd8OC2np15MbZVY/BlMK1E=
X-Received: by 2002:a05:7300:2146:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-30c84b6cffdmr15067504eec.4.1782707410281; 
 Sun, 28 Jun 2026 21:30:10 -0700 (PDT)
X-Received: by 2002:a05:7300:2146:b0:2f2:8857:17f6 with SMTP id
 5a478bee46e88-30c84b6cffdmr15067468eec.4.1782707409643; 
 Sun, 28 Jun 2026 21:30:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 63/77] target/hexagon: Define system, guest reg names
Date: Sun, 28 Jun 2026 20:58:16 -0700
Message-Id: <20260629035830.1520296-64-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXxMmblIL84hFh
 GLQOv54hKFSlRfhNzfnQ6lrZ2Q6PWPAqgAZqdhdKwjYL6eMjOU9OHsC4IZnz6ysMZKbFyAN8EMX
 hG+UstmUmnWzuRAJjMl7VqXsBn3gU44=
X-Proofpoint-GUID: -576FZjJFjr307sLBkGR9Mm9_6IvXtc9
X-Proofpoint-ORIG-GUID: -576FZjJFjr307sLBkGR9Mm9_6IvXtc9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX0uq/hHVjZAVq
 50xvVnFY0LH6+BXX1DFEIYOyk/FzPmXJUNtq7v95ZeF6wUemgDr62OQXATpiQwDhzVfUCO1txV4
 Hwxnt3qoKvlBdKfjmUfYwRz6Fszpf1IguRq2LgSMnsEvC/VPrY3kscwg7Ga0U6LlkmvGFwIiYuy
 tGYtnXcR2ui92U8/zq19EmJagrIAbKPeNZHJh8tms/I4Bb5BXQHDx4+Z402bQS5Pvf4B1xL7ftD
 QbzO//4jte8AQ4GUtXWON2TJ+F8E9vgvnvtYqBUQ0pQ1tTmoGEoX/asu8PiZrStPBK4rTt+zX4R
 mWH/ooCsBqZFylN5p6flk783hhvWQrhHoLcyn4ztFgj/WzCKo0wAA7QUy4BwgX0Kpjijj+x2Grg
 ACYOWvmV4S80roqEMDrPh3ZC3or0cq7UBixy5J0tG0ryXuUtNqJFqE+oOG6xSjuZldYNdslZ/jg
 uU+7yBhdx1xJWPwk/hA==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41f4d3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

