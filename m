Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFC1CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rPv-0004Sz-UG; Fri, 17 Oct 2025 16:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPk-0004R8-Rw
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPg-000321-Qh
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGDK9004525
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a6OfDz5CSmiQyrjuQLU260NHno3BVhDtrFgBxqU0E3w=; b=ZsPBAJqKe+dSspYO
 hBKBXIonWsf6K2q0YOFmsqYLpWpjt/wQIchIBeOG9qK0OFECteUvCqQwTt37YYyX
 cuguAzGlJG7yTcbEWfoBXA9/AnBkMsEmVEOrJY2fT2M5tGHaW3znNH+tm13TfFLO
 KkrsdWm73VrkEwVxG7tcty6ElVKpqya95CtTvwOBfG4i7y7wrXWr5+qkx8DlthyK
 /z4bZTwFltUSvO/y8Jhq5avU9FJnU6es/K4yc/hO4y2RbAhRtuyjEklIf33tQCr6
 y5Tng8t4LNY764gdb6u3jbX23j3L1gWZmglYapgIESenX9H3CEUWtvah6ooJiR/6
 865kXQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5wua4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5a013bc46dso1700524a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734257; x=1761339057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6OfDz5CSmiQyrjuQLU260NHno3BVhDtrFgBxqU0E3w=;
 b=LK6oPi76Y7Fhco5N92em7Ac3cwqNZN1qFjWXuq8Ge/ELdcMGrlxgKOBmgx+baxs5Mk
 QVjxy6rSgfFSIHjuXDE0bb/kxInZopV7WvHcQ/dcMDPemm2ldcqH/rsl4Er0Ikur2QSd
 16/p7ZUZifzb+I2csHpjPcN1GK3zC3rJb0OWykC5VVBdtWIDeK3CT/ex4c1TUWtWG+jp
 53jyEJHptktamrt2RYxsBQzE8Z7YLdUyXgXYIp4p33a8LCmauxkKBA1pnaJFvoJbgbY8
 g0rqmHn0x8UIJzm2EcdnxmkeVu20Ff2O009crHbLXlKD36HlkCKrY1v+dhJUyuJsNy96
 NopQ==
X-Gm-Message-State: AOJu0YwE+hhZCxMfdIfwZOIo/IgZ/dF91L7nzSd6efrGPtfTH3TdoXHH
 DjAJrRXeRxaPDohZg2Lp2zXSJozEz0I9cExkFfJZ8Q+iqutji/O957eOFTmvX0+fD2J1+Cr28zP
 Q2WmDCnHaEUnl8/K6X5SawDwqjQbp07UxVeNqEMrZZ4IhsEU5WBR92l+hNb0pXWhJrQ==
X-Gm-Gg: ASbGncvmzxoZTdAEtJ9B6Cqv1ajaqBWBXSPJZ63eY0JXQq4aOJM+yy3Am6EdOxldPHS
 63y7Z+T3NVlMJt1d6TyZJn50kqScX28WLCHffnjxlHuK4RhzMQSFLlDFtrq+gZli9s2AC3nXK0C
 px6uNf8FSRqNPjQJniif9j/1HQaN1DW7e2gVJj6Va7EpvMNwOzmHhRN7e5A5JoeQRIIkCHQg6vE
 kLtzd7isCiDudSi39dr895DPcTuhi30lpYANhDIS91kILFx+8R10X6QYexc0I5YrWanx9eRm7ik
 LLbvt0xCYBoKEAPpaQOBOPleK04ySgdThUPHt3knOjWgrFG1LWgAxOzrkEWGhAhFxSvEwiNQQ9U
 b5KmF6cc7GTZ3Ia1IJ5LrM4KiVvg7kad4cdb7+lO39jnqGMg=
X-Received: by 2002:a05:6a20:1611:b0:2d6:9a15:1394 with SMTP id
 adf61e73a8af0-334a8546d29mr6758812637.18.1760734257299; 
 Fri, 17 Oct 2025 13:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKfBfrXp8rjQ1GbB9FoPxpgODorONSh3z+eXx7D3ZIiUF4L52aAr+rQud3RR4sR6asoI/YPw==
X-Received: by 2002:a05:6a20:1611:b0:2d6:9a15:1394 with SMTP id
 adf61e73a8af0-334a8546d29mr6758795637.18.1760734256878; 
 Fri, 17 Oct 2025 13:50:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 8/8] target/hexagon: Only indent on linux
Date: Fri, 17 Oct 2025 13:50:28 -0700
Message-Id: <20251017205028.1105595-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: qP1z0UFryqZGM8Ks1oDJeyYJYOBSTMIs
X-Proofpoint-ORIG-GUID: qP1z0UFryqZGM8Ks1oDJeyYJYOBSTMIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX0CY4H4UjpRri
 jPlwBl7eNeVF44zmrMJ/taYTuL41iJWYVjgnwxmLS/jzolW9XLAQg49Npf8utGqcHYALiRqQRxl
 M+ascXzRU0pTHoydGTtuSHEEetplwLvM32zq2O+3k2oFr1yEw23E2gbSiQ39q5V4X/mqbgTkDKq
 JYqOUxEtJky4orbEGW5QnJEp3jzZjff5P8Gd6BvfvGqUFwGfE/KOwP2Qr+qgjV7pCEH5KV8ho9h
 hHLzQnV18q51cUrf25q88TTNWNM2dCU43pSocEU4B1d+YHt3ZNoS8vYLKcuzFTPOWQjRUa/EmtT
 883r9vqiLa00XwD4DcP9uqIbS5f3F64BtBL14mgtu3hUI/fCLsWON4u3dCkn3njicwlP/v1P+OA
 ueOo0PwGocblTk7ebfzhntyMDFmIYQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f2ac32 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XAINxP41AtmSzHFTvZ8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCmluZGVudCBvbiBtYWNPUywgaW5z
dGFsbGVkIHZpYSBob21lYnJldywgZG9lc24ndCBzdXBwb3J0IC1saW51eC4gT25seQpydW4gaW5k
ZW50IG9uIGxpbnV4IGhvc3RzLgoKU2lnbmVkLW9mZi1ieTogQW50b24gSm9oYW5zc29uIDxhbmpv
QHJldi5uZz4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBhYmNm
MDBjYTFmLi5kMjY3ODdhOWI5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWls
ZAorKysgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtMzI0LDcgKzMyNCw3IEBAIGlm
IGlkZWZfcGFyc2VyX2VuYWJsZWQgYW5kICdoZXhhZ29uLWxpbnV4LXVzZXInIGluIHRhcmdldF9k
aXJzCiAgICAgKQogCiAgICAgaW5kZW50ID0gZmluZF9wcm9ncmFtKCdpbmRlbnQnLCByZXF1aXJl
ZDogZmFsc2UpCi0gICAgaWYgaW5kZW50LmZvdW5kKCkKKyAgICBpZiBpbmRlbnQuZm91bmQoKSBh
bmQgaG9zdF9vcyA9PSAnbGludXgnCiAgICAgICAgIGlkZWZfZ2VuZXJhdGVkX3RjZ19jID0gY3Vz
dG9tX3RhcmdldCgKICAgICAgICAgICAgICdpbmRlbnQnLAogICAgICAgICAgICAgaW5wdXQ6IGlk
ZWZfZ2VuZXJhdGVkX3RjZ1swXSwKLS0gCjIuMzQuMQoK

