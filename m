Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85386606A884
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJJ6D/ks;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jksDIxGH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTE3-0005z1-NT; Fri, 20 Nov 2026 13:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE2-0005yp-B4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE0-0000cC-Ug
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:42 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKI9VlN3120549
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=; b=WJJ6D/ksH3BPUKXm
 cFpo+kwXdc/ZLtn/gTlE9sf+3opiMUqV7FKX0RGmQ9dPOy9KFCKPh/NnmXAYQOTB
 1uHc5Gy++hoRC10jhDPGzCvlRustHfu21q3s9JNY5xNEU7W+UxeWFj8GEHRA/Fao
 YNiNhwD4JAL+hMAkeRRAaKzWqq0CqzA1OA+okqtWwM8GbEVpWcjdJKlccKWhfStq
 1BTQwZZGezktYcdITRRRl630nGm0lKwGvSRl/4C785roSNGp/4Y8W6BTjalnWJMU
 7fwJdSNdgzwTkY+Iojq50bONbpKEKN7l9SAP6pT9YtHJGWwTI/GcwARFFIAebnLd
 FmOClw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2u8681ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:39 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-86285932977so1366961a34.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198839; x=1795803639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=;
 b=jksDIxGHhw/e7GtWsPh8vsAQM4seaPy14Ifd6VD0nK7fvq/gmOe5V/bS4rVWJv3IVf
 NArWrIkRs4ojoCeHHCKWF6y+gHqUI5y/7kyrwZLIvsUGMoocNcnCMgCjTAeQtQWTuO4a
 vzlMobrbK6NeINb+/giggE7P1acFRiNNBdQMxgEy2Bip4RTd3m0G6WM49nRSTlQn3vQ2
 K1M3fUpe5GZp16b4eRg222oW7CLYbZs95DikTmcFEn6RbA9VjWxvErTUXq0bKOzqAXq1
 3IXOslq3msKFProbMjqvecHDK1fEaGgq6hMA454vgUZP9GN/lkEo9/wVhIoJ0Ovs4kWP
 IMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198839; x=1795803639;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=;
 b=w8FNstOEZuDLzDnFb6qXKRAa041en/mWnH+8HkHeL5KQVKCc7qdbobyv5IxmLoDpiu
 KhZWA7/znIKquXFXXnRvdfuGxABTHV2WyUXLlfkcD2mzZ5dNYVS1T09mk1T8UVBXn4lJ
 /RTPjVT8diIfE9VLlGVyHGICd48VmOqxk7TbkrIFmXK/isp23OB5FeTLLl7iolhhCIB8
 P/CqHWgXyweRzSiEVdkVpptm3Rd7fxPAppcNvdJFHjnKcGlnPOztIXvP9bjEInZ5O0oO
 7tp8IIxaqi3UiWLkn4NxsZrfWOG6PT065ZGHgT2BXKGgrNE0Z6q8EofUk4LHVirsd8oz
 KnZw==
X-Gm-Message-State: APuU4Z8bsQtU88nUX3kRBNNDxAzHH0z1Zt3H7BubGbRMAI2qxpJ/FIcU
 25qK+5FmYPihCxQZWMO0UvIe7o+59NRQZB4GxMIDwd3l+OsHCBIAft0kL7/MMGCmITEJIR+4glM
 TrVbN3uUJswvw28lHDv0xJLd7J49rd/KvgZcKgAkdhDujTzlH2Qs2Vp6jVqKJsuPrEA==
X-Gm-Gg: AYBFou0PgtgZroU9/bhrt5yC0d/JnXAqIps7w+zmxfT02Bqj9dly6imCB6h2PA/byrg
 4i9KG7BqJGg//65fSGgLufz6OaPNc2FnA5if1Kb2PbzUYJUAmqnEYnrAAKi8SSNhBs508u3PuT3
 sKya+GaaAtJlLl0SbxENsrCike0+m9SDGplXuWMlh/oJO7IBV2nZ8I+6DhfpH6kqXPhrG585LOo
 lUsFdEfc8pbTj9m50NzuW4U0FCa36Rraf4pGS1SCiq0hwD9gHaBIIBSYs4P1xet7SGugkzx5HUG
 RfH+BmefJy0+LurpGe87SQs6x4b2mHlK3Cc2YnIVWaY4GE7IfZcN32JPWis7AX2mfM+XyUydAW0
 f6DBU11haKGVS07zyzVrVFByArtL6fHT5wHgHe4mhm/C78yLnHyMlJpcHpwgHsDlWGJnCwZvnHu
 EIF0OG9EN6VEtWTjcb2bcL3g==
X-Received: by 2002:a05:6830:7182:b0:862:8364:7962 with SMTP id
 46e09a7af769-8631595eeebmr4909179a34.23.1795198838876; 
 Fri, 20 Nov 2026 10:20:38 -0800 (PST)
X-Received: by 2002:a05:6830:7182:b0:862:8364:7962 with SMTP id
 46e09a7af769-8631595eeebmr4909146a34.23.1795198838405; 
 Fri, 20 Nov 2026 10:20:38 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:36 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 03/12] target/hexagon: fix get_exe_mode assertion
 in hexagon_stop_thread
Date: Fri, 20 Nov 2026 10:20:22 -0800
Message-Id: <20261120182031.560481-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=X+zHu2Te c=1 sm=1 tr=0 ts=6b008f77 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DyE358pAE-X188sEe20A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: lGFl6cZRkJgqiOGFT1sKgIuadj7Txk6r
X-Proofpoint-GUID: lGFl6cZRkJgqiOGFT1sKgIuadj7Txk6r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX9KEYcydrxLNU
 sNiMhL/opBp7eUbYgwG+yk4o/Hv7qGqxMTzDMUuGC0w12DAGbKtdLwD2k1n8+9CE7gu61oxxW1o
 s4h9UyzWCCfxXsnzKF6q34ys8tWljNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX3UqUXDI6kCtG
 alSDEjss4f3LArZlpEQzz3ptBhRmqbcxrjEL4t6r4129790qNQqR3o4Ge1CiPh3CiJdhQINiYw4
 TueQz9/T0Kf9Ak8dIvJ02ZNYgBAaZfhUS4J/2NFPurTwJuKLSawyVGCgun96xei9AE7Oc39JZx2
 TNWYRiwZCWSajh8u72rDq3ivtul0IUtJGpPE5O7ohMEsP4wspjLT0mOFmFHW88ADnGyokJqHHFO
 KvyW5q4JiYlnclAAxcworK+CZVuLvEx/8Z1jCabVzX2uf7+s2CEUCwfo5Sut+BNssxWSU/uC6jA
 apgJq8TkJvAAiBcaiakhXqVWrF1DZtG8bIp+Dm2ZZiOlzS0pddsLDhW1NQ75HwLXqOL1C/IuZ5n
 u6xzAyZaHGCLO6kCZEfcDwpEsPg8N9+6ynD30vzvoIttfWh9u/Ya/i/bSWKhGTmhft0smt5AU0D
 UtR6j8U+bwcOxYooU7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

V2hlbiBhIHRocmVhZCBpbiBXQUlUIG1vZGUgKFc9MSwgRT0xKSBleGVjdXRlcyBhIFNUT1AgaW5z
dHJ1Y3Rpb24sCmhleGFnb25fc3RvcF90aHJlYWQgbXVzdCBjbGVhciB0aGUgd2FpdC1tb2RlIGJp
dCBiZWZvcmUgY2xlYXJpbmcKdGhlIGVuYWJsZSBiaXQuICBXaXRob3V0IHRoaXMsIGNsZWFyX2Vu
YWJsZV9tYXNrIGNyZWF0ZXMgYSB0cmFuc2llbnQKKFc9MSwgRT0wKSBzdGF0ZSBpbiBNT0RFQ1RM
IHRoYXQgdHJpZ2dlcnMgZ19hc3NlcnRfbm90X3JlYWNoZWQoKSBpbgpnZXRfZXhlX21vZGUoKSB3
aGVuIGFub3RoZXIgdGhyZWFkIGl0ZXJhdGVzIGFsbCBDUFVzIHZpYQpoZXhfaW50ZXJydXB0X3Vw
ZGF0ZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRleCBmNTNkMzc3YWIxNC4uNjgw
ZGNmNTY4MDMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTQ0MSw2ICs0NDEsNyBAQCB2b2lkIGhleGFn
b25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAKICAgICBCUUxfTE9DS19HVUFS
RCgpOwogCisgICAgY2xlYXJfd2FpdF9tb2RlKGVudik7CiAgICAgdGhyZWFkX2VuYWJsZWRfbWFz
ayA9IGNsZWFyX2VuYWJsZV9tYXNrKGVudik7CiAgICAgY3MgPSBlbnZfY3B1KGVudik7CiAgICAg
Y3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKLS0gCjIuMzQuMQoK

