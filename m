Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF05CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktT-0006pi-QH; Thu, 25 Jun 2026 10:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktR-0006jV-KB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktP-0008U3-JQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9kAfr1921421
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=jl9O97QcOmmmWiIR
 fB6Gn7yE5xHJw5A1vFTi2rlMnpIoheWy+cXzcmcQJW3i6ZrYi53+blFI8ShiZSBk
 Ykole5r5dNvB1YgzOEH+Z1If6uW9CkSUsvSOLDJp8c5+PpmBlRGgXTnU2jaEhQPP
 NVEWPmP6j9gNnyIIDuh/Q7sH4KAlo2VdUeSQuUKhQd+gPwOepM+ZFdrVuDc6q1WC
 vdaYFjXE2GamvqXNDGHSGHZHWGVlYEZLI8ZJ0eVEVR2B/fn6hOKKGZrx3SndmwQE
 5/JykcWMa2caNCJ6fKRuP+gPqdOjWx0faXgGFefyOZ/BRSJwFiKcoBc1PDwJI9Hh
 aAKF0w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuajux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2672200eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397032; x=1783001832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=Mac33QDS78RKHo8tmSv4nTX9QlJ0r1WB0bjXu4m/0cupjrNEmnVbHwZdwFRHPsqVCu
 gUmn6mNYi5n65S7Uo7xWv0SuQFpNJuivjiKPHphsfKJS+b22CuZgATOiFzqCjBUl2kIO
 FYOwYuaUIOtHt4tmEcM1mnqEOtqeDAl/Xz8bf42AqlDGuLDyeLcyPEUlcTfJgBrW/ap9
 8zoXsK06oyFhlGpT60bAVhDmPWPWn1UdVWhTkj8M3bxJy5J/28/MXKllnkZYfrK4qpiO
 DFvfCQ2ndPtyuzwx4yMEorcXb7ezjVboJ0/MSo3I7kYdtUkpXGfJ/sfGZJg+JPtoD0Jp
 LuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397032; x=1783001832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=I1kyd3jT0PpJm1kVzVxlJ8nhT9VISOGM+mJWa8GZcj+/4TUK/eRaHKCnEzgl9pz1e3
 2zhHQgbDhN6jDx2DIhSfDsMP8NlaQZC6loqOhPxU3kS3q/7tbD/hNACnuzZlTGSiTrHA
 T98tBTqVHgEwFfx/B9zAda9OE4vj0pAv2nQ6KRKFUW0Om6OrwD8dTociUKOQlttsVLwA
 sePxrrYsucikNsA87WJ3LhqfYew+OVFgCEulTs3ADiFYQ3EPyEuXgOWM7oo+GOvtqQm3
 g4plhdQS+QqauJyh/VLD1jErRTXWE7qiZx6YGWTXA0uheBnYpulm6NSwYDZzmUk1OTtH
 lO0g==
X-Gm-Message-State: AOJu0YzZBS6B/gmdGj5HKoeOq4IlvGhlyk1qQXzfkVwRgNfyXv2Nmc+2
 2ufYY1qDeBbhRte4lrYuCJ+xYq3ID/RjpSVd5tCxrqEbCCxY3DzqpfDtn9qvJNrq8wO1IwpbvD5
 rQxkxqDi1EgdEQNUpr0/fFuALHM2wkJ/aXO11jJnYq3+dBp2zcMCx2yO+rTEyN20RuQ==
X-Gm-Gg: AfdE7cn/zij5/QK/tNkELJifjs8Ic10DfMmpeoyv7H1c6bmMft9RZ6D+9zNuND0eA2g
 RmGPIp5T2zFlEtQSJvT2OGGzP6np4ci9eRqiwUeHV3cSkZbekxcmfjU43LC6xzmFGsRzI7eolPu
 G4SxVNK7KiC50fFj9QOqU1KbTh7oXMW5Gnc2Knp7H7EJShkbUjSBRJDDMfTI60KBx0m5BiG3sXu
 1ktv4Pa0Gse+/wjp9xzS+sJ/EN5oB1Ryx5uRsCQjvXP7wsj5ojFVyk+Yh03mQ2by7AF08agrNg+
 Tcs/vl8ZFWW7vPr8XWNoGDtdaclBcoBrg3kX6jAaNyCSCVwg13hxV828I/MF2LRHCYBJ8PeQrA+
 5NmW4NC/HWmla5XV97D+4ROeNqodCKvCBYwW1GQywqgRJrdAoQLPbqDQAF7Y=
X-Received: by 2002:a05:7300:aca8:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-30c84b8a06bmr3224564eec.14.1782397031540; 
 Thu, 25 Jun 2026 07:17:11 -0700 (PDT)
X-Received: by 2002:a05:7300:aca8:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-30c84b8a06bmr3224462eec.14.1782397030796; 
 Thu, 25 Jun 2026 07:17:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 16/76] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Thu, 25 Jun 2026 07:15:33 -0700
Message-Id: <20260625141633.449487-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: uSFE0BI_ip6o2v6dg9te1r_X78HDmTq0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX6ct1mS0mZI/a
 0A1413+u0kYxguWsJJp6dQNiihtM8Dx/EvkVCc69B3OWaZORWOKxBYUqiINIb6emuhL+0Pilgsc
 e8+1Tb7ILtjBekf81uV52N2tvXs9jlQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX3BMRZk9QYeF/
 WttR7eaBpFngW3NEDnaA4hIEVFnoq4Tt6uBC9f57uXBd0fxU01NZj7TBVog/XxWRqY5D6lXbcnD
 Yvt5RZIAAphGsU9SPP2ZDLLdhiQOtBS4+YB2tyUn98bimUbJkyJ2BmK9vdm7hlShfgd6H51DVnn
 PH5mm5dEpvj39b/6zZlmwVADqBI682m1Rvy12ii7Sbq2b7JZkywxFGgVbZI0NxZWcKJHyaVCUHo
 t3VeeWvWI16lVdBTX2nlWyHLf/qeoq4szkSQddjnCMID3lkUI+YrXpShIpo9qDTyPJANYvCJ1I5
 kvxZPrAzQ+zzHxYu0H0YzoK/XfO3QnrNtLgMFfl75+H5Azt708FO7R8a4jffu8eorYqYm8UAvFo
 G9Ts+LGySYH8gk+EOwvxok9Zb4t/3KWBav7kN4t9cgOXwYgegMD/rL3+R2mhycCevDhIQ5qxi0Z
 mnTlgSgOHJepSgJUfBQ==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d3868 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: uSFE0BI_ip6o2v6dg9te1r_X78HDmTq0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZDhlZWE1NjE5
MWQuLjU3NzY3YWNmMDAyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDEsNiArNDEsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODEsNiArODksMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
bCBpc19nYXRoZXJfc3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCk7CiAKKyNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQorc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdf
RzMpOworICAgIGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICBj
dHgtPmdyZWdfbG9nX2lkeCsrOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVn
X3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQoreworICAgIGFzc2VydCgh
KHJudW0gJSAyKSk7CisgICAgY3R4X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4
X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSArIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQg
Y3R4X2xvZ19zcmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBj
dHgtPnNyZWdfbG9nW2N0eC0+c3JlZ19sb2dfaWR4XSA9IHJudW07CisgICAgY3R4LT5zcmVnX2xv
Z19pZHgrKzsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZV9wYWly
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUo
Y3R4LCBybnVtKTsKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtICsgMSk7Cit9Cisj
ZW5kaWYKKwogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0pCiB7CiAgICAgaWYgKCF0ZXN0X2JpdChwbnVtLCBjdHgtPnByZWdz
X3dyaXR0ZW4pKSB7Ci0tIAoyLjM0LjEKCg==

