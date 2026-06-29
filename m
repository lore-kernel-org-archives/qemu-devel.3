Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA09C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCHT-0003db-Km; Mon, 29 Jun 2026 09:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCH7-0003Ys-VG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCH6-0006Bf-Fy
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT7xw2604444
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=; b=dBXhaaTqi9d22sCA
 1sMhapMfDXjhbDx/Ccq+Hp0Y2VX/IaIAgs8h5ShAKzaPK2rQ6MhcIilsUu7FrdwZ
 29g/rGP1AznCysreKH0gh2ipR/Ilytd6EcH+LMKoruXc2uqILguve57E94HKUlDy
 K5PMwNy6yBVypYGfXRVAAjc/rKzRgr6PBztYqsT4oQ5QHbLENKTfKWIEs4IxPBcb
 rpqYViSgT5aOinlNabPvS2zL1zObIGaLZr+gUyeSx6qweEI3AxdJzllS6arMBAFh
 WYOQK+dvLYS+2yjm+3f8eyT3VUvEkFsz4t21eMQOi7Iab/cQTB7iuAekwRglFqgW
 oYFYbQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq892k5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fee8a7813so823196a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740626; x=1783345426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=ax87qECis/YcvLx4Q6ori4XqWXW25/oSNXkqzmjcxFJVPAL68hhZj7mg6yxioBS+Q9
 7WqrvVJY2Pp8UZhFVo5BJXkKLQXOCnc+W+pvpMLpQLjGEYsIaqDAUExCpjVO0Sf/4omN
 LnLM1j517KORQuRVGbe5HICDkc295Pn/B1WsgDlKhlJHq5T1y9Cmka3EEn5McWiU1jbb
 GAgI57oXPW/pBZ0VutO2yaUfF0ZKkvLbJWeqnBERTOCEF56V6EirgagEyK7dDO5IZYfa
 rw7Uni+5ZFj8xnHJhmCKUiOwu8/gqFDCSlfmxyPPy9/rjaw78eW4aYLLzOs2u3nYd4kW
 C12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740626; x=1783345426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oY8qK4LAUtINTePvitXB1Xfo61hqyHEyBFAF6Gss008=;
 b=YEji7ZVZY6tmqhMZexQ1b07/OjkPFX9d/YsHaiRx8t8YvxRiWBfWIYibdnpqlZOIvs
 XIMAjk5a+X6zEHWxiDrJZLaQryw4n1cudPicefsB/XVOw+AXTMTydRLWfeLAzCTmUxVp
 wtzQFMEEprIpIigI88PvB9HfE3tN85yoOTux7K3KEsPFMdujZ6kPw1UyPiNOHpDXZMSw
 cFvMR+bVSdAB4xZHow2tmPtGoeSU1CzNhz3HK8W/vIlo82SiAaOYUZP+yF2FsvpB3abK
 WJ08jf8Q+RZRO3BuyGebw7OAxdbzt55SjMWeF5EblvRqWe0MVbP7I/AmfGYGULN8A7Hn
 KrLg==
X-Gm-Message-State: AOJu0YwOL7qDdyuAi3lfwGEhITsuZgbn8EoupZirw1+9IJIx0vMuIaO0
 X47PhLvdhnpVRy9/SknBP6dt7b1y0Zl0surehWkyLGTByXe6GxELJ5CnMJWjTAZqFa+SOmYHgr0
 Wpr9+tjrHrcqsXzFvLjoPnSqWJxCr4kF/94/pkyvNquwkp+kfIfaD9BMxEqb6r7XYNw==
X-Gm-Gg: AfdE7ckDSsCNRKfbB18n0l8ngZF+Nq3KfMAQVkaJ8yElCf0FMqHokinDUL3zP+Jqk+5
 bjJZHMiIByGKGr53wI1em186JNFGH0d/fMOzwJBQCKpPBDdOqjnHJkI2tgLIOqoZH2uBHAvIzDA
 vWBQvpdgxkpvPLS+ssEf+CILK4GXMEwXLoHsbgJKPmGRBQYtgcwWnLmushWFCYc/iNZwoBTVKZt
 cIFXzkBw6Qcf601yugk2WSmMS2Ep7PX9iJn9v/MZHA2+3q+15w8d8xhNVtJN20461H3mvk1BXAR
 sULOQmS5fnWTgRT1qJyd/rdIjC4Av2UIT09UbCjCFLJkGSFrPWsam5cmJJQdzmip7R751lTaSVY
 tjjVEwAH+7peVKvVkaZnNSAEbddiS8D5btKdam9U/63RtU5raIRurqNt4CoA=
X-Received: by 2002:a17:902:da86:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2ca0c68c766mr20523685ad.38.1782740625539; 
 Mon, 29 Jun 2026 06:43:45 -0700 (PDT)
X-Received: by 2002:a17:902:da86:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2ca0c68c766mr20523435ad.38.1782740624769; 
 Mon, 29 Jun 2026 06:43:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 41/77] target/hexagon: Implement {c,}swi helpers
Date: Mon, 29 Jun 2026 06:11:56 -0700
Message-Id: <20260629131232.2487780-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: NpfXut1A9IWteC16n52j-FnttTqfk5Ow
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX6u95HGkZhph+
 9nc2Ag6inHeBRuj+laObV+WdfjXmwqFgKrQNxG/DQXY+tx+SH4fwmy798IvDZSC0/B+pTTTamQr
 4TW5XIWUKH/nquyJJAjOvqb0cWfBVm8=
X-Proofpoint-ORIG-GUID: NpfXut1A9IWteC16n52j-FnttTqfk5Ow
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427692 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX4zwYZOpfZ53Q
 cZNjPk0uXq/bznz1g91xWIiqDORKnnaqGFtkmjRXhdjzaEmI4k9LclCSaodn3duSBI4Bqt6lu/o
 HhLWyzryveA8p/I4Cs58I7JjIZjjelQWUd8M4xLXBgN/6yqnplDNiOov6v5N+9D7X3jo/dkFDgp
 +n5l7eHYGTGGIa+ukvNZRMKS5GcXAC4mAB0aHHXtOfEWp5qSlkpJ9fJmpdHkw1dUsRSoyLZ9fE1
 qMsOpsIzUs5fVkuyNeeLacgieZ/vJLknxLFvOr7Iz61R0eYMksJ4bTCGEt7NIWoZxKg7fwId8c5
 cp3NyjDjKsasqPhqDPIXtGg74tozz1fAwAShX7eYzYL1cHG1If4iOE+hVS+VKtGOXj3kTfNMdsO
 A2R3Fi7Oo6tHGEBk5aaovyPRzzNinOUJugYTKARl21qNbzB+l9dlaiW8dshf9qTgY6RiCFePft1
 MA3ngnC0sew+oVi7XZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
NGRjMmI4ZTYzYTcuLjc4Mjc2OTZjNmIyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjQsNiArMjQsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzYsNiArMzcsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MywxMiArMTQwNSwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

