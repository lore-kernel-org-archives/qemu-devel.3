Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23F4CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzc-0008Fx-QR; Thu, 11 Jun 2026 01:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzQ-00083E-EI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzO-00014P-Mv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GH7T3815865
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=BwmI0pU3nKxnTOq3
 p/d8ANY0pUDs3AmrAsH0A1oAxUJLws9/hUy+iG3dWReFvuZEMBJoPn+x5rG5zq9X
 Hxc2lt5VbASE9gSENefmA0kWUoIJFjRePrAUh/L1a4W0Jkhl0aXLm3T0C6ATkzF6
 grrkuxNzagv+JjlUfsLaIFa5goB+ZF6x2vhqwUexK1bEomIbCIMaNO+demfemOO3
 7BP8Le2/NR5LSvDM+xGbUUIQ9rED36U1V6LD4dsCAn3KeI/TR8budN/Put0Yh4Yf
 OjEEishrgLPT3Xdf9oBj/jq1s9WWw18hI6/Bj/USlRLGp6SINBXStVHtYbjvHw8P
 Zm5f8w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1rs0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307fd7138b1so985223eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155791; x=1781760591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=cJBlTCUAG23px/18+lTHEJ23aYOb651SevgXrmaSpVHv20IvSOi7moFhHhTcizqOtg
 4Hl38jIMdX+avgXSo9MMKXGl0WwExT4V4wBGn3Q2qRz8xBRCItz5hWy3hq3VVn7VwRg3
 G2fMZmcVYv9rhQW4x0tkwAO7u3Q4UAoMFqoyFrVjI6oqoZEAWMdwud2Mv50Hax5xxIhn
 IYkpdZ46BYDmEZ/F0lqFB9cJ8Gi0RXi8DSXQNNZTmitlGLcitiwFu8IHJSTCDmygtQFJ
 Py1BDjvRuqCQSM/cS79dS530GqagjyelJ1sjbCDF45Ay32btbT0kgv0sXLZUqsLRCSMB
 lGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155791; x=1781760591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=mwZzpUF5Z70m7xtkdfJ7WGCra8RWJRg8ggyXfvY/LAZ4Vw/ai0lnlAiTH3ADWyQABY
 NgAdRVABWlwcUzqYJcUQuTkiP03NlgiXhT4lL/WZUR4HGVBR6DQfNuK4gspeq3lNxUoi
 5ABUm1WQCyDuwh+357kz55I02t58fV62A+o0fb9fUM21CSVw0NZ+C/j4BhCWHFLpOarU
 6pS/Ke6w6Ep1wantGmNn8q4J6YxCDZchodYMntlTwYw7Ik7Ed3sUHwzkkPDFV7f8GaST
 0CFaDfcSNgLhIvuxTpPPM9APTQwNyKRkDvjZ4Wr2UU/JYnQbw1rQupV1ge8FuBiznKFJ
 2Qfw==
X-Gm-Message-State: AOJu0YwGDGHschDWq1D076legA7+v5c6MDe6hLOlYFC95HsvhwfWDt5T
 TYSdFZgeFse7gZtAcYIkc5ChtBLmx7g9k4+fHwO/y2IXHKUPsB+rhWZAwKloHFN3NXTlOc7rOWk
 Gru2354F3QnXUbZruXFiUt1MsTQS4uALNTo7ZWBQU2tM6cVmEwboE5VYeRHT2GvQ3EQ==
X-Gm-Gg: Acq92OFVE28b839JfMGk/C5ne7jI0/oNIHq1xA45zwSmtQlGqbJS9hZcgw4Qai7uAO1
 TZ57fagxTHt4TeojwuAmNUavzVfc9wQhY7GgA4cm4lOcceW2TaivpEHbAugHLZiwKKVyh/W1Sqy
 JAFL/qkhi/E4JEplSjDNgjdVHin2etBn0yTh9VYhrDeuvU8yLNJHs3hPbDyoKl+12bcdSu3Ancd
 R7khKd26tVwB6QIwmlNOk5wrkroqkf3mlCVbVzLnRAi7RoNH+w0tEdqgCC/7g9dIwZScwNPbtoN
 Q+ODUY2kpUsrokQVIIQQQXi0daW8ChnaevtgXy8gANhlsdHhubZKWpWyQXfsD79FEwp7RHAAd9h
 0vM+WgFiCWDR8GaFO2socv3Ho/0Jykc9NC7IOXyZyg7FaxmUqceCXXQqldtefS9nIMHSN7gNiy2
 npaH77
X-Received: by 2002:a05:7300:220f:b0:307:6e28:efcc with SMTP id
 5a478bee46e88-308049a36f2mr1111984eec.21.1781155790667; 
 Wed, 10 Jun 2026 22:29:50 -0700 (PDT)
X-Received: by 2002:a05:7300:220f:b0:307:6e28:efcc with SMTP id
 5a478bee46e88-308049a36f2mr1111950eec.21.1781155789946; 
 Wed, 10 Jun 2026 22:29:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
Subject: [PATCH v8] target/hexagon: Add pcycle setting functionality
Date: Wed, 10 Jun 2026 22:28:52 -0700
Message-Id: <20260611052857.3911981-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: HvCALiXL0i7JknjtJkiBowdEPhZfmYr5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX3xhVGDYN2r1v
 W+BmtnAD2HiHCJhm1BpDD7bI2LwPjw5Xv1YaK66e9NLbUIeyXThck7LMSZuYughZBPl8Ta/Hk68
 LqjDDfuWw9xuDkhy/itqDKtRfxCShmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX9tFJg7q2Jfla
 RsyzyPYRVx2O5Ep+QF94YxX+SdgHlYZz7OLODGObDPBkNiQ3ZaolODse33f8E2QoJa4r/VGFZWi
 xymR8HO/vkHRVq2VJnOmds7mrzVfMMBLpif1bR7z36DDS6h/UTaY0+uOQKcboqu1RfsouFEhSr+
 ccULEWM/U3z83Yyfu7pqD5SFPHqRqlREKBaM6cyQFJBtUhTYzepQ2H79cwCAg9W59AK1/NIXcxm
 C8bqi4Tbo8V1HSKqtmXw05duxUnxcB9FjtteVeVxXXsPCmgv3cYr+nEMlT6izEnsose1Y0Pn4ZW
 t5BHlZmr5bU5tdgduDMIy1DvqwVL7QiHYW0oqnXf8N/U93WLCVPcJzm+WcKSaRCWanVEjkOLj3G
 oLEzGtHa+bPIChwsR1XN4Zdl+PYilDnLiqob8/o1Oge0VlEAuIMnDiQcjc7jx/RSrfxjYwmEPKE
 tP+zoVR5r4/ktAUu0Lw==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a47cf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: HvCALiXL0i7JknjtJkiBowdEPhZfmYr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

