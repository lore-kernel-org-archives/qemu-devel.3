Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF12BCCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rPg-0004Q0-Ly; Fri, 17 Oct 2025 16:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPe-0004Pk-Vb
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:50:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPc-000311-4M
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:50:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGVcA004621
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=dP/CtqqnHIR
 n2R/LV/V9NVA4uWnSejZpGW0q68Jj32Q=; b=crglR+vYyEZZYFyK9CvOxnzNNb/
 FAUIuHiSyPpAp36MqXhPg1cVt9jIZWakqMBruYFmiQ87NuJqHP9rsFCcaj4eBGhA
 xxGrNJTG5l+98Rcmvn9cayhpsh/PEGgopmgo1tAvO7dQX9NGh9k9c554b+DqTjvf
 +YBnV+EaLhnspjg+IUEC1gDHzQd16HXT9HvzMF86N9cjwPM4lfzUI27Div2Wzc1O
 XqwK4erzgPrRn+k5AOYC7ZNoVYYKvwOw5HGkMq+DIQVtNvSHKeW9teBUQHg0+DcS
 sjXtadDWcun0ceNTf93Hcz7yqKOSiTJJVyUJZXR/T7hA4WeYm4UHmTJetDQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5wu9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77f2466eeb5so2804951b3a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734250; x=1761339050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dP/CtqqnHIRn2R/LV/V9NVA4uWnSejZpGW0q68Jj32Q=;
 b=rFrae/b5W9FMEDTxZT8w7AWuzPVjCd1Nu9zPQ1SnGvM9sGBZM1Hkbo6WdTCzXGNXq2
 ZPhI+RuFlbh5nQMN86nVH2Sw+hF0/rTIb5/ZjqfXX8ipFfXv48fVGi3Tgh6jzOHwwhD4
 QYuT9z8QlKA5neEJaUEWqchzz6FcpEHdFzNlY7epkvv34UXdbFMCswSVLUuxD4l7jqGq
 3refatArxySfVG4Ks0mWJb+kWgBmhO2y8xECLwzD2SOP2no6IVOso9eQc6vpV027to6r
 eXRl8Y0tMxN6gjdGhrVxfMNrDBVwTxYbRa2L8Dxn0aPikDt1SC4PQPRqSWWxJ6dT3eG8
 0zaA==
X-Gm-Message-State: AOJu0YxOLNr9tQtJVsxp8yxIUnGcU4fzNADX8Id19ONaf8Kxm361SJW0
 GWOGdPl/jcPrB79LgfLIOYHn+cfbwOVJh8V68AHJI6qdFwXJyXXtL1g7FeEnUhb+fqNq3Ihlwve
 0JrCN+4mdVF8+jPE33/MlM5RkfHp9SRKQCNWjWg7vFZvwsrSwwjcv5f/fKyN9FZCyrA==
X-Gm-Gg: ASbGnctodbJGtxs2HLTtPf7jvhK3/q/jiPPaBu6E1UYVZEA1+YTCiwehm0TkBXhu9LG
 /Kes1hyU67M7c9JwVkPAwnPuKAT2QCIenug7IclN6hqv9a95gRg7SwtWy10ef+n3Col86ErNSQ0
 VQqIu4tzW3r2XS5TvvEtinnfa84UX0P6Ovfes7holTMI7qR6WbzqOB60gYwoHdvwXz/rztN7Pt+
 BRuzzolLkhuiMBFTWv10iGnBi9NQ7VUFXRHcziFQW1NivLgdHATDwQXhiZsb+R90eRxZQXS5MOs
 lTyUM1AuDMM4ySnLRQ+X8XfsSkmv5WTMD0Avs29aejoJfrvNj+yRIXPK5+Fi/x18ytZNFrt335O
 hgYy+/kwEOTii2q1qNHB2dEd0VhtKRBKrwPuld8VgGxYpplA=
X-Received: by 2002:a05:6a00:22c9:b0:781:9ae1:1be6 with SMTP id
 d2e1a72fcca58-7a2206eb5f2mr6169207b3a.6.1760734250104; 
 Fri, 17 Oct 2025 13:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG28J63A9VbP+SUDY6mSQs3F7JU1SCoq8LXYh1BzO7TLb4RQq25eanljy9z7pz7558f7k8Ltg==
X-Received: by 2002:a05:6a00:22c9:b0:781:9ae1:1be6 with SMTP id
 d2e1a72fcca58-7a2206eb5f2mr6169185b3a.6.1760734249615; 
 Fri, 17 Oct 2025 13:50:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PULL 0/8] hex queue
Date: Fri, 17 Oct 2025 13:50:20 -0700
Message-Id: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: bVfczhZctPV9oC0_djoDukP7Uk0oduLA
X-Proofpoint-ORIG-GUID: bVfczhZctPV9oC0_djoDukP7Uk0oduLA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXyeOukjRp+6bF
 cQBAJAWzqEvt65oVcZrBPCVbufz9UbwFkwGptqVm/EI1nPtVBJV2f6rpVAaxSJcCOm+bwbVXGm9
 bWqGqMBiL9ILwGoXboUY8B/Y2qpio+AHWsySLByaSpzUdKSYp72TMC+HUaZ/H+Fhol9W44C0dR8
 FdCeWdmVrQ8hEk04UC0+7S06UUyVtEhsmHO8pi8eeqyq5OBl0bEjDBGYlh0ZOyQABUNn2ykhHdl
 VZFJisuu7Uv7VFuL7V4gL4ERhQUDJfWcjxnFvM/FUlWrg2yryiDc4uDHMZWvOyxZn95uuaaWjqj
 jTC7HSTYku3yWitXAzIL3W1Kjm4WVkIMbTtrjTsDNAy8B/2bq0mhNm/Kx4cmVAn7yrw1hzt2oKQ
 9Fc3NbzeP9hLG3u+UL3kjH9JvJ5Gzw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f2ac2b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=_oQSY8rBVeA38lUtsg4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAxOGY2ZjMwYjAwODliNDcwZjNlNzM3
NjM3YTg2ZGZiODFlYmQ2ZWFlOgoKICBNZXJnZSB0YWcgJ3B1bGwtcmVxdWVzdC0yMDI1LTEwLTE2
JyBvZiBodHRwczovL2dpdGxhYi5jb20vdGh1dGgvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjUtMTAt
MTYgMTI6Mjc6MTIgLTA3MDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjUxMDE3
Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZjk3NzAwZTA3NTI3NTNlMjk0ZGIxMWRl
ODQ2MmFlZjVkODAwOWE4OToKCiAgdGFyZ2V0L2hleGFnb246IE9ubHkgaW5kZW50IG9uIGxpbnV4
ICgyMDI1LTEwLTE3IDEzOjQ1OjQ2IC0wNzAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpGaXhlcyBmb3IgbGludXgtdXNl
ciBzaWdjb250ZXh0IHNhdmUvcmVzdG9yZSwgZXRjLgoKbWlzYzogYXZvaWQgaW5jb25zaXN0ZW5j
aWVzIHcvaW5kZW50IG9uIG1hY09TCmZpeCBoZXhhZ29uIGxpbnV4LXVzZXIgc2lnY29udGV4dCBk
aXNjcmVwYW5jeSwgZm91bmQgYnkgQWxleCBAIFppZwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbnRvbiBKb2hhbnNzb24g
KDIpOgogICAgICB0YXJnZXQvaGV4YWdvbjogUmVwbGFjZSBgcHJlcGFyZWAgc2NyaXB0IHdpdGgg
bWVzb24gdGFyZ2V0CiAgICAgIHRhcmdldC9oZXhhZ29uOiBPbmx5IGluZGVudCBvbiBsaW51eAoK
QnJpYW4gQ2FpbiAoNik6CiAgICAgIGxpbnV4LXVzZXIvaGV4YWdvbjogRml4IHNpZ2NvbnRleHQK
ICAgICAgbGludXgtdXNlci9oZXhhZ29uOiB1c2UgYWJpX3Vsb25nCiAgICAgIGxpbnV4LXVzZXIv
aGV4YWdvbjogVXNlIGFuIGFycmF5IGZvciBHUFJzCiAgICAgIHRlc3RzL3RjZy9oZXhhZ29uOiBB
ZGQgY3N7MCwxfSBjb3ZlcmFnZQogICAgICB0YXJnZXQvaGV4YWdvbjogaGFuZGxlIC5uZXcgdmFs
dWVzCiAgICAgIHRhcmdldC9oZXhhZ29uOiBzL3BrdF9oYXNfc3RvcmUvcGt0X2hhc19zY2FsYXJf
c3RvcmUKCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9SRUFETUUucnN0ICAgICAgIHwgICAy
ICstCiB0YXJnZXQvaGV4YWdvbi9pbnNuLmggICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICst
CiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstCiBs
aW51eC11c2VyL2hleGFnb24vc2lnbmFsLmMgICAgICAgICAgICAgICAgIHwgMTg0ICsrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAg
ICAgICAgICAgfCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAg
ICAgICAgfCAgIDMgKy0KIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJz
LmMgfCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICAgICAg
fCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgfCAg
IDkgKy0KIHRlc3RzL3RjZy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMgICAgICAgICAgfCAgMjMg
KysrLQogdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSAgICAgICAgICB8ICAgMiAr
LQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8ICAyMiArKyst
CiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wcmVwYXJlICAgICAgICAgIHwgIDI0IC0tLS0K
IHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCAgIDUgKy0KIDE0
IGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspLCAxNjUgZGVsZXRpb25zKC0pCiBkZWxl
dGUgbW9kZSAxMDA3NTUgdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcHJlcGFyZQo=

