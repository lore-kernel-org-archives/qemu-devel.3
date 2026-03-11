Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FBCFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsK-0000tC-PQ; Wed, 11 Mar 2026 00:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsD-0000ql-ST
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsB-000061-LR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKOeMX140361
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dFZu/Z+47ChRFZONflI6rUJhVTzPEYlcTJK2zoxcJdY=; b=d/4JIbtW09KySJ6r
 wRkmNrm3NumKbT4vhI3H5eAEJcPkR1sHnO/3Jl03i+Ap+uzbMJihFWUqk+53bKvQ
 HCnWyMqYPTzZtw529Ymokb+HICVnTH9P8PKM37xaxILxxDlhBcjwoQuTYTqeDixi
 U/YtOZOc+cZN7iFDNXbctrhhjl7YrXeFsXN1kC5FIFR34YQQXH8gTc0qD6APyAEi
 te/RsjQRUgib0ZV6ev22n6htQbpJLrVD4XSqiysaaVMC9ZpzUJl+7hnd7TzuraHH
 MjZenIc+j4Hw1riGIBJPlyyw0uWgfUd/oFPGhqqA2S0+AJcTSBOo6VheLtaG1Rj0
 MkQ7IA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1muwgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:38 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-40ad1c724daso61168391fac.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202118; x=1773806918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFZu/Z+47ChRFZONflI6rUJhVTzPEYlcTJK2zoxcJdY=;
 b=ZMQppX6UIfmSPoCupgOAFJRZAw2mM6LOEUff8URKAs0nB5CtyQ1kskOVFSE7JUrGRH
 pdOnms2ySx5EOYZ4wX4rWEL+YRujPdBtaNk4wTLL4u0IA/uSRsvjLSmh01fJbzIMT6Cg
 5allsBQQiVrnoXujAUt0hIsfySb2wB4tgqweyJWiypP+Cnt3EC4Kz8OZh69L80ld/6E1
 +Noyb0av3CZVPGED7WAnjUUqv7+FiDxU8l0DSC4am170nosPCJ2FTiJQPyCxkMV0TQey
 J/FPYlPlapCZYUMy9XLNnjaIZ3ZeO0liZt/eIFm288uArDPrg6gUlPa8y/Bk6TRa8Gya
 gwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202118; x=1773806918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dFZu/Z+47ChRFZONflI6rUJhVTzPEYlcTJK2zoxcJdY=;
 b=Cf7JTDCojesWCkXFL8sZ/CuOKFBwrlOMSNC+05e14lW9qH3/XYBArSnQkYFuqpyZ8M
 aFFiFZFVwW4T1L9zxH76kZvBA67Jf635VtbHTcoUXYrQTPoLzr0MXy/TObaMqgQITbg5
 dWTX//NZ2xZQe1vjk4rK1mIywNBkLqMy42ytD27gWuVNqm0vT8YZsAvUO8Y02E6qd4Mt
 +LonOOlQyUjPk52F6OgMkxx+3Ws39YajO6GV5SrlSSQFson7j1o+ZrRNSl88/OcJdrTo
 VbJGcDGbQALd+BEv0TzYz68EZU4kyH5HLlDNTz5kbZoCUIQ4+JAMJxJ2/OZfio9T2KHM
 c4Zw==
X-Gm-Message-State: AOJu0YxR9C3g2a3HQzrzEV6QJICS8h220xDcIXZagRUwPnxHigJi2ZUC
 AoGPwVSDaq9G/57q9DGX88Jvg/zHfMfk/tsLjxmthKRvw3Ea7015a1LqnLrm7wCy7aC+LJspAnt
 5koeonULkF7HWPyhACjqqUZzLfiLGDac6Ibu67vRYrcA1WEnqb2/AoeJUA6MwJld7ng==
X-Gm-Gg: ATEYQzzqAYrzC6S42Htn2SQAMi4GMEvDKOdkwzYLwFbk19b+WTyFb9F9myOBGj+IOUd
 Z23OqH+F/QFB+2IGuMjaiIwZvn7AkaJFyY99yynDqgkUtYjEaaRELkm9RQ7bm9WltvsSDVzpp1q
 iGgfLVPSTvojhVtsDO7pVE18nzV5kwO+Mmh3h2V+Dk6hooiu9cQ5+7tQeO0SI8YfqxrSNrYI+zw
 Ta6424utE67N9LLrwnmQQF8rvvKk1Fg8rCBu+WJnrsTAHB2sgiSt891aHOtoNppdoYCobqJmtLu
 u26BD3RMCcZ01lLH7S3cedTUA/tapsc7e6Iur8wWwWH0FxJjQ9/5Mh7vF5jF4xQd2G857slUtHY
 UYClWLWpoqzueZs6G5E0TqqJ32CLHth9roDuAcWjS7Hn4Qvs6rd9E+f8iqPDjBVqwxaZZoA==
X-Received: by 2002:a05:6870:2317:b0:3f5:5af:c9de with SMTP id
 586e51a60fabf-4177c9fbfd2mr985678fac.51.1773202117995; 
 Tue, 10 Mar 2026 21:08:37 -0700 (PDT)
X-Received: by 2002:a05:6870:2317:b0:3f5:5af:c9de with SMTP id
 586e51a60fabf-4177c9fbfd2mr985665fac.51.1773202117646; 
 Tue, 10 Mar 2026 21:08:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 23/32] target/hexagon: Add pkt_ends_tb to translation
Date: Tue, 10 Mar 2026 21:07:49 -0700
Message-Id: <20260311040758.1068731-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b0eac6 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=imK-vThzYG-NRbbrpigA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _D8W0gn0MYfnk5sG2wP9PiN_yyLXgewK
X-Proofpoint-GUID: _D8W0gn0MYfnk5sG2wP9PiN_yyLXgewK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX3BjdWbQCZS3j
 n49mI33cNtamnz7SX9Z3z5/3HiWDIqQczRdggggrj+QeFYurwUdnRIQd8ziswm4hLospEwXAVSs
 PsVuQ/P7qVUYQYOigkemKJAr8mJLFqKRdz4yB1CYw16PbLQYx0Ha+VH4pA3K/65KHIGdMXFw/W8
 dsM9YviKfyB4SihaH+rT4J5J4EQfJDsZIwo75GZuALJk7zaf+w21HGkj5N0VVTCzrd8uyyS7kb/
 OTj1qqamhJxLC7poSOe+X5vLWhkEW8IDsIxjVuAaM7P8jbwbNJmXYON2E4qGCtTX6cckgIzti72
 avgsF8eg05JEHuWUESGBU+5uWpHmXO/6U4Lk0iTlBR3MbBDtSHOWiHWSZhFS3KwsHyRz2F/pInz
 J8av7sNfWhiu/hW10RD1Kq+jIJTpdUTJPRx6cME8QGhdORTURQZOEdqoD9vnsxCIZjEuHLEXMkf
 DuFWSNNOUIPmB9I4ikg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAxMDIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxMDEg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IDgyYjMyNzMx
MmVjLi40ZTA5MDU2NWFhYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgK
KysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTg1LDYgKzg1LDcgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBUQ0d2IGJyYW5jaF90YWtlbjsKICAgICBUQ0d2
IGRjemVyb19hZGRyOwogICAgIGJvb2wgcGN5Y2xlX2VuYWJsZWQ7CisgICAgYm9vbCBwa3RfZW5k
c190YjsKICAgICB1aW50MzJfdCBudW1fY3ljbGVzOwogfSBEaXNhc0NvbnRleHQ7CiAKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNs
YXRlLmMKaW5kZXggZTRkNGRhZDhmZmQuLjk1M2IzNGI3ODkxIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAt
MjcyLDYgKzI3MiwxNiBAQCBzdGF0aWMgYm9vbCBjaGVja19mb3JfYXR0cmliKFBhY2tldCAqcGt0
LCBpbnQgYXR0cmliKQogICAgIHJldHVybiBmYWxzZTsKIH0KIAorc3RhdGljIGJvb2wgY2hlY2tf
Zm9yX29wY29kZShQYWNrZXQgKnBrdCwgdWludDE2X3Qgb3Bjb2RlKQoreworICAgIGZvciAoaW50
IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAgICAgICBpZiAocGt0LT5pbnNu
W2ldLm9wY29kZSA9PSBvcGNvZGUpIHsKKyAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAg
ICB9CisgICAgfQorICAgIHJldHVybiBmYWxzZTsKK30KKwogc3RhdGljIGJvb2wgbmVlZF9zbG90
X2NhbmNlbGxlZChQYWNrZXQgKnBrdCkKIHsKICAgICAvKiBXZSBvbmx5IG5lZWQgc2xvdF9jYW5j
ZWxsZWQgZm9yIGNvbmRpdGlvbmFsIHN0b3JlIGluc3RydWN0aW9ucyAqLwpAQCAtMjg1LDYgKzI5
NSw5MCBAQCBzdGF0aWMgYm9vbCBuZWVkX3Nsb3RfY2FuY2VsbGVkKFBhY2tldCAqcGt0KQogICAg
IHJldHVybiBmYWxzZTsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgYm9v
bCBzcmVnX3dyaXRlX2VuZHNfdGIoaW50IHJlZ19udW0pCit7CisgICAgcmV0dXJuIHJlZ19udW0g
PT0gSEVYX1NSRUdfU1NSIHx8CisgICAgICAgICAgIHJlZ19udW0gPT0gSEVYX1NSRUdfU1RJRCB8
fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX0lNQVNLIHx8CisgICAgICAgICAgIHJl
Z19udW0gPT0gSEVYX1NSRUdfSVBFTkRBRCB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9T
UkVHX0JFU1RXQUlUIHx8CisgICAgICAgICAgIHJlZ19udW0gPT0gSEVYX1NSRUdfU0NIRURDRkc7
Cit9CisKK3N0YXRpYyBib29sIGhhc19zcmVnX3dyaXRlX2VuZHNfdGIoUGFja2V0IGNvbnN0ICpw
a3QpCit7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBwa3QtPm51bV9pbnNuczsgaSsrKSB7Cisg
ICAgICAgIEluc24gY29uc3QgKmluc24gPSAmcGt0LT5pbnNuW2ldOworICAgICAgICB1aW50MTZf
dCBvcGNvZGUgPSBpbnNuLT5vcGNvZGU7CisgICAgICAgIGlmIChvcGNvZGUgPT0gWTJfdGZyc3Jj
cikgeworICAgICAgICAgICAgLyogV3JpdGUgdG8gYSBzaW5nbGUgc3JlZyAqLworICAgICAgICAg
ICAgaW50IHJlZ19udW0gPSBpbnNuLT5yZWdub1swXTsKKyAgICAgICAgICAgIGlmIChzcmVnX3dy
aXRlX2VuZHNfdGIocmVnX251bSkpIHsKKyAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAg
ICAgICAgICAgIH0KKyAgICAgICAgfSBlbHNlIGlmIChvcGNvZGUgPT0gWTRfdGZyc3BjcCkgewor
ICAgICAgICAgICAgLyogV3JpdGUgdG8gYSBzcmVnIHBhaXIgKi8KKyAgICAgICAgICAgIGludCBy
ZWdfbnVtID0gaW5zbi0+cmVnbm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0ZV9lbmRz
X3RiKHJlZ19udW0pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAgICAgICAg
ICB9CisgICAgICAgICAgICBpZiAoc3JlZ193cml0ZV9lbmRzX3RiKHJlZ19udW0gKyAxKSkgewor
ICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAgfQorICAgICAgICB9Cisg
ICAgfQorICAgIHJldHVybiBmYWxzZTsKK30KKyNlbmRpZgorCitzdGF0aWMgYm9vbCBwa3RfZW5k
c190YihQYWNrZXQgKnBrdCkKK3sKKyAgICBpZiAocGt0LT5wa3RfaGFzX2NvZikgeworICAgICAg
ICByZXR1cm4gdHJ1ZTsKKyAgICB9CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBT
eXN0ZW0gbW9kZSBpbnN0cnVjdGlvbnMgdGhhdCBlbmQgVExCICovCisgICAgaWYgKGNoZWNrX2Zv
cl9vcGNvZGUocGt0LCBZMl9zd2kpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZ
Ml9jc3dpKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfY2lhZCkgfHwKKyAg
ICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFk0X3NpYWQpIHx8CisgICAgICAgIGNoZWNrX2Zv
cl9vcGNvZGUocGt0LCBZMl93YWl0KSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwg
WTJfcmVzdW1lKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfaWFzc2lnbncp
IHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zZXRpbWFzaykgfHwKKyAgICAg
ICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFk0X25taSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29w
Y29kZShwa3QsIFkyX3NldHByaW8pIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZ
Ml9zdGFydCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3N0b3ApIHx8Cisg
ICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9rMGxvY2spIHx8CisgICAgICAgIGNoZWNr
X2Zvcl9vcGNvZGUocGt0LCBZMl9rMHVubG9jaykgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29k
ZShwa3QsIFkyX3RsYmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90
bGJ1bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9icmVhaykgfHwK
KyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lzeW5jKSB8fAorICAgICAgICBjaGVj
a19mb3Jfb3Bjb2RlKHBrdCwgWTJfc3luY2h0KSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2Rl
KHBrdCwgWTJfdGxicCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3RsYncp
IHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNV9jdGxidykgfHwKKyAgICAgICAg
Y2hlY2tfZm9yX29wY29kZShwa3QsIFk1X3RsYmFzaWRpKSkgeworICAgICAgICByZXR1cm4gdHJ1
ZTsKKyAgICB9CisKKyAgICAvKgorICAgICAqIENoZWNrIGZvciBzcmVnIHdyaXRlcyB0aGF0IHdv
dWxkIGVuZCB0aGUgVEIKKyAgICAgKi8KKyAgICBpZiAoY2hlY2tfZm9yX2F0dHJpYihwa3QsIEFf
SU1QTElDSVRfV1JJVEVTX1NTUikpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAg
IGlmIChoYXNfc3JlZ193cml0ZV9lbmRzX3RiKHBrdCkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7
CisgICAgfQorI2VuZGlmCisgICAgcmV0dXJuIGZhbHNlOworfQorCisKIHN0YXRpYyBib29sIG5l
ZWRfbmV4dF9QQyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBQYWNrZXQgKnBrdCA9IGN0eC0+
cGt0OwpAQCAtNDQ3LDcgKzU0MSwxMCBAQCBzdGF0aWMgdm9pZCBhbmFseXplX3BhY2tldChEaXNh
c0NvbnRleHQgKmN0eCkKIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0
ICpjdHgpCiB7CiAgICAgUGFja2V0ICpwa3QgPSBjdHgtPnBrdDsKLSAgICB0YXJnZXRfdWxvbmcg
bmV4dF9QQyA9IGN0eC0+YmFzZS5wY19uZXh0ICsgcGt0LT5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRl
czsKKyAgICB1aW50MzJfdCBuZXh0X1BDID0gKGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9rMGxv
Y2spIHx8CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3Qs
IFkyX3RsYmxvY2spKSA/CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNl
LnBjX25leHQgOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+YmFzZS5wY19u
ZXh0ICsgcGt0LT5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKICAgICBpbnQgaTsKIAogICAgIC8q
IENsZWFyIG91dCB0aGUgZGlzYXNzZW1ibHkgY29udGV4dCAqLwpAQCAtNDkzLDYgKzU5MCw3IEBA
IHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAg
IHRjZ19nZW5fbW92aV90bChoZXhfc2xvdF9jYW5jZWxsZWQsIDApOwogICAgIH0KICAgICBjdHgt
PmJyYW5jaF90YWtlbiA9IE5VTEw7CisgICAgY3R4LT5wa3RfZW5kc190YiA9IHBrdF9lbmRzX3Ri
KHBrdCk7CiAgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKICAgICAgICAgY3R4LT5icmFuY2hf
dGFrZW4gPSB0Y2dfdGVtcF9uZXcoKTsKICAgICAgICAgaWYgKHBrdC0+cGt0X2hhc19tdWx0aV9j
b2YpIHsKQEAgLTk1OCw3ICsxMDU2LDcgQEAgc3RhdGljIHZvaWQgZ2VuX2NvbW1pdF9wYWNrZXQo
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIHBrdC0+dmhpc3RfaW5zbi0+Z2VuZXJhdGUoY3R4
KTsKICAgICB9CiAKLSAgICBpZiAocGt0LT5wa3RfaGFzX2NvZikgeworICAgIGlmIChjdHgtPnBr
dF9lbmRzX3RiIHx8IGN0eC0+YmFzZS5pc19qbXAgPT0gRElTQVNfTk9SRVRVUk4pIHsKICAgICAg
ICAgZ2VuX2VuZF90YihjdHgpOwogICAgIH0KIH0KLS0gCjIuMzQuMQoK

