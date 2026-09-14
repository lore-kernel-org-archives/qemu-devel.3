Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3154DC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68yW-0003JT-Kc; Mon, 14 Sep 2026 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x68yI-00035F-An
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:51:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x68yE-0003CA-1G
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:51:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0PHg674411
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EGBWtpuUtqS3eRiU9dYw2a
 kTtUkj4NZH0ev+j1X6OeQ=; b=jqQerMoIxd0vK3dD8rTYVAM0p7kYDRbNslpwt1
 bP+bZ0uWM14cxab9Nu4xESri7WEXdyhqE3nRI//tfhgrPk3P/Rlf5C1Usp9UzIAP
 LTkzt87mphhY25WNrTHk3P3ZhRf6JnmTfiJHnJoMssW7KMATT4TXKa5R8JBqhs9W
 gpqqIZZwFz0n+jTHTTvfmzKMl5RpaNFUR18lQ71oU/u0Uoj29f5d1QBkA/RnI6L1
 Tgetkd4g87BMG0F6cG6yrK/IAqI3ZddkHcQkUqZZjQP22/oS7cfbtk0PkCt2SqX9
 //PyUJKfvfy+OimROjGdFb8Bz1Ydy40CWHNyqEqeZ/vvQA4Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpecs9hhv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:51:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso41553995ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401097; x=1790005897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EGBWtpuUtqS3eRiU9dYw2akTtUkj4NZH0ev+j1X6OeQ=;
 b=MS3j01GU9Mc7fQdMEdc+HwRvcWwG+pi5n3GKnH6nHEmKPIzFov22OTDZdPMulIvPui
 pnu4mRMBnBjEmbHkYbzk2C2ov9u7a5ldp7ICvJE45hj4w9y3rD8xo69D9Me//u4dOZhO
 qsDx0tV7owKUYCoOxyMTtkVQckGkq18+aj8H+/q9wjooh+HLaehRsJ/xbcxS1MWkb0Yn
 lRRB9He5Stz/WPgH2YD23oTI7NXqqsmVA4AwoLFGxEyE79RI17dcK/ijFILucDSOQ96S
 67M10g4FkMZ+dgScopP7OGLKu9MxwSZFhaVlzStjRTZV8MW5bqfD3szfLa9cwGWK0WS+
 8zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401097; x=1790005897;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EGBWtpuUtqS3eRiU9dYw2akTtUkj4NZH0ev+j1X6OeQ=;
 b=cFNgZ/LAV3Muyxv9F7327IanwjRkTJ/rszOhLVw/G60kcelySz72CVBiDcs1DSqDcI
 OYMWqrJWiJf3LtCyYuHgQbC0PVnNSCC2wdyLE5u5VkI1QxlCnBG7+UYOgdx7jp2swYvL
 Enb+AjbeQAKfz6xEq4wO8pqyPOT+DXkKW8JDuJfA92I0dtez0TvfRUJUp6FqLvZOUdFz
 THGmYk73bAbkchkMLn1vQJRwbeQqhg94Pyv/0onW/0k6zxxTOu5Gc5Ch7PrBdyAwm0v1
 w74aJkXia88i8aSBANEsVKXYNMYlnqWiMtiChz5Yvfni2cp87WnjWbS8Dv2EaTcbGcYU
 HLog==
X-Gm-Message-State: AFuF++lmKNoIjhYbRB2nYFiex40wFncnAqA04m163v0B9NznxjTEYQp1
 4GwLLLLDLYRrB/et5fbqUztErILNk85jItKhwglHld4fojOOi04tPh49BFwebcKG168DYUPOVqi
 Z4TNIbxITJ8SkT6o+iGUEJVkc9LV1diL3DAPP7dhDN/DD5grX7LWG5rymchykUQfo7A==
X-Gm-Gg: AYBFou1BAyzeFYBoCb0v9WWqnTIY77vgHxWNyDt9RRf5YlUZzsypV6ckCMulGGUXpLo
 MhA5oTSAM448asJGmNmP0NoDMGTiEQwRZhrXDL/d81NIu9hDTAw1Z1d0Tk1/PR5LzO9bSCzmKHl
 5PdRJZxe9bA+am0uo2jbf4BifxDMeNR1uNzmUI2UyzsE7yTMHZ1F7SiU7NOiUaYK/f6wxloopu8
 TSRVnu5DJJAi6Qy+0lU12Tgw8eBHLhJO223Oc9z9KmGo4ZA2tPCnoe1F309T5AiY/u4/1gIacih
 SmM6/y8aNKSfEhPJ4QkCE+GDjGEqwGGrAeywQ2I/yfIJWwMGZoyYATS2x2vdneh/Qh+nho8K+UI
 wwm0D+vSJQFyusWKPXPbxXiPbXlKgr0FNPPQ8Cn2HDRjg01M9
X-Received: by 2002:a17:903:458d:b0:2d8:f965:7e48 with SMTP id
 d9443c01a7336-2dd6c5cc20emr65588845ad.1.1789401097233; 
 Mon, 14 Sep 2026 08:51:37 -0700 (PDT)
X-Received: by 2002:a17:903:458d:b0:2d8:f965:7e48 with SMTP id
 d9443c01a7336-2dd6c5cc20emr65588155ad.1.1789401096677; 
 Mon, 14 Sep 2026 08:51:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfcefb6sm51824605ad.56.2026.09.14.08.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:51:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, marco.liebel@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 0/6] hexagon: Add HVX context
Date: Mon, 14 Sep 2026 08:51:28 -0700
Message-Id: <20260914155134.2191912-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX5L2+k1JnwvMV
 IQaNj/UOzxyaCxW9OS305pdxFXZ7JdmJ7xh/pwVuVw3v3h/JgdOtYsWiyQuNSZ2FXvG2bqbcBaV
 cOhJVHhqS7GZMfSwNdyQk0CnW6oJ4NU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfXxojroeb7x2fa
 /ZK96MCCk6j5cnXYCRzQHXirCDdFSuvaSgPvaXIw2WZb2UERjyoa4C5U0AkbHcSrEfrbu4XM5dL
 91Dmf0PWmWJb3b+4XMQrecgYXrbhyboCB5/dOr68GQV/+QB808t6FHRvx1AKFATuBxr5uYbTxbT
 juv9Lkf2ygpD6TEsc+LHa/BZO7AONNSbKL5iI5YFXVl+5w7RKF4qYMcebgEWBv8arZXPDdHl0Es
 rG/qdb94SrdCQGmFmQOTScvKRRE72Iq8MDnXNcSuY0Fn/onhZMH5qfX0cr3KsqKAXhRaKqYP5nL
 NZK9spahKpWsQ46vTCRCk35zzfJIfJx8VhuGKNw8ipFzB0V0x+pXIfXRMfOOsJFRPhUuVJJI9jJ
 o+OWRyxImVDrXyl93ZRaqyD9UAAoJfQ26iTU7M05sVrWhfjDQHx/RKPRwrQGB8sCSPDUwkOjRZo
 w3/asqtPSIwc68cB3WQ==
X-Proofpoint-GUID: 2tDozJY1FChq9N6Ev2CqV0rUpFyaIyx2
X-Authority-Analysis: v=2.4 cv=b/cncdGx c=1 sm=1 tr=0 ts=6aa8180f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zTHlpq2rQ3psEcsZHm4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 2tDozJY1FChq9N6Ev2CqV0rUpFyaIyx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140226
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

QWRkIEhWWCBjb250ZXh0cyB0byBIZXhhZ29uIHRyYW5zbGF0aW9uLCBuZWNlc3NhcnkgZm9yIHN5
c3RlbSBlbXVsYXRpb24uCkNoYW5nZSB0aGUgSFZYIGluc3RydWN0aW9uIHRyYW5zbGF0aW9uIHRv
IGFjY2VzcyB0aGUgY29udGV4dCB2aWEgYSBiYXNlCnBvaW50ZXIuCgpNb2RlbGluZyB0aGUgSFZY
IGNvbnRleHQgbWFwcGluZyB3aGlsZSBhdm9pZGluZyB0aGUgbmVlZCB0byBjb3B5IHRoZQpjb250
ZXh0IHdoZW4gdGhlIE9TIHNjaGVkdWxlciBkZWNpZGVzIHRvIHJlbWFwIHRoZW0gcmVxdWlyZWQg
c29tZSBnZW5lcmFsClRDRyBndmVjIGNoYW5nZXMgdG8gZW5hYmxlIHNvbWUgbW9yZSBfdmFyIGZv
cm1zLgoKSW4gdjQ6Ci0gbW92ZWQgdGhlIGxpbnV4LXVzZXIgaHZ4X2N0eCBmcm9tIEFyY2hDUFUg
dG8gQ1BVQXJjaFN0YXRlLCBlbGltaW5hdGluZwpsaW51eC11c2VyL21haW4uYyBjaGFuZ2UuCi0g
YHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbjogYWRkIEhWWCB0ZXN0c2AgaXMgdGhlIHBhdGNoIHRo
YXQgbGFja3MgYW55IFItYgoKSW4gdjM6Ci0gZml4ZWQgSFZYIGNvbnRleHQgYWxpZ25tZW50IGRl
Y2xhcmF0aW9ucwotIGNyZWF0ZWQgaGV4X2h2eF9wdHIgZ2xvYmFsIGZvciBzeXNlbXUsIGFic3Ry
YWN0aW9uIGhleF9odngoKSB0byByZWZlcgogIHRvIHRoZSBjb250ZXh0LgotIGFkZGVkIHNvbWUg
dGVzdCBjYXNlcyAocmVzZXQgTWFyY28ncyBSLWIpCgpJbiB2MjoKLSBSZW1vdmVkIHVudXNlZCBk
ZWZhdWx0IGh2eCBjb250ZXh0IGZyb20gdGFyZ2V0L2hleGFnb24vY3B1LltjaF0sIGFkZCBhCmhl
eGFnb25faHZ4X3NlbGVjdF9jb250ZXh0KCkgdG8gdGhlIHJlc2V0IGluc3RlYWQuCi0gY29tYmlu
ZWQgdGhlIEhWWCBwb2ludGVyLCBRT00gY29udGV4dCwgYW5kIFNTUjpYQSBzZWxlY3Rpb24gd29y
ayBjb21taXRzCmludG8gYHNoYXJlIEhWWCBjb250ZXh0cyBhbW9uZyBDUFVzYC4KCnYzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTEzMTU1OTI4LjM2NTkyOC0xLWJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyNjA5MTEyMDQzMzQuMTI2NDkyMi0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbS8KdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MTAxNTMy
MjEuMTY3NDI4NS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDYp
OgogIHRjZzogc3BsaXQgb3V0IF92YXIgZm9ybXMgb2YgZ3ZlYyBsb2dpY2FsLCBhYnMgYW5kIG1p
bi9tYXggb3BzCiAgdGNnOiBhZGQgYmFzZSBhcmd1bWVudHMgdG8gdGhlIGd2ZWMgMnMsIGR1cF9p
MzIgYW5kIGNtcCBleHBhbmRlcnMKICB0Y2c6IHNwbGl0IG91dCBfdmFyIGZvcm1zIG9mIGd2ZWMg
c2F0dXJhdGluZy9tdWwvc2hpZnQtaW1tZWRpYXRlIG9wcwogIHRhcmdldC9oZXhhZ29uOiByYWlz
ZSBhbiBleGNlcHRpb24gZm9yIEhWWCB3aXRoIFNTUjpYRSBjbGVhcgogIHRhcmdldC9oZXhhZ29u
OiBzaGFyZSBIVlggY29udGV4dHMgYW1vbmcgQ1BVcwogIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bjogYWRkIEhWWCB0ZXN0cwoKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAg
ICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQuaCAg
ICB8ICAyNyArCiBpbmNsdWRlL3RjZy90Y2ctb3AtZ3ZlYy1jb21tb24uaCAgICAgICAgICAgIHwg
IDk3ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAy
NiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAgICAgICAgICB8ICAgMSAr
CiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oICAgICAgICAgICAgICAgIHwgNjA4ICsrKysr
KysrKystLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5oICAgICAgICAgICAgICAgICAg
ICAgfCAgIDggKwogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgICAgICB8
ICAxNCArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgICB8ICAx
MyArLQogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAgICB8ICAzNiAr
KwogaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMgICAgICAgICAgICB8ICA4NCArKysK
IHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzIgKy0KIHRh
cmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgNzIgKysrCiB0YXJn
ZXQvaGV4YWdvbi9nZGJzdHViLmMgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstCiB0YXJnZXQv
aGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgIHwgMTAyICsrLS0KIHRhcmdldC9o
ZXhhZ29uL21hY2hpbmUuYyAgICAgICAgICAgICAgICAgICAgfCAgMTIgKwogdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICB8ICAzNyArLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICB8ICA3MSArKy0KIHRjZy90Y2ctb3AtZ3ZlYy5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MTcgKysrKysrKysrKysrKystLS0tLS0KIGh3
L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8IDE3OSArKystLS0KIHRlc3Rz
L2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAgIDcgKwogdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgICB8ICAgNiArCiAyMyBmaWxlcyBjaGFu
Z2VkLCAxNDQ2IGluc2VydGlvbnMoKyksIDYyMSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9odnhfY29udGV4dC5oCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMKCi0tIAoyLjM0LjEKCg==

