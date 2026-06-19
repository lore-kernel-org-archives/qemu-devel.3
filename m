Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE9CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig4-0004DS-DF; Fri, 19 Jun 2026 19:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifp-00043i-O9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifo-0007Tu-6O
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY7cc4085515
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=; b=SyGgNTiYlrS4KJaj
 XlLVjJgM7hiXxjJMxKvDlLTswnXnr0FxK7zcINBBxEhl8J43qI7r8rCqnPs6WbeW
 9T5EY14wbsOTrz0pXygWpZbrBja9c7YtVvYZTQsab3I92LKLdb9tCrddPynmBJj+
 2+pUo4CAqngrb8liTVjD22VW/22f08zjstRLw2mny4d/0iHvQrKu6cLCqI+0+Z8t
 r2EvfsBSXilAd+4TMLGgw9IaJKaag0Ik2tI63zxPQt2/+1oDNpWjZmy1Nfl+b4oE
 SJ8MGhW/pcwhcXQDTuU6ERYla50Oi034x6faHWvK3KD15duRru5wKaSdmW7b8xd6
 7ptYCg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmyrdma2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bfe262ef0so1143543eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911844; x=1782516644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=Iu1IwTI9BOI2lS/r1h4mdOv+QiWOXGPColm9A2MTNj5xD+zTemb/Y8ihyTkTszeB8F
 8S55cbmJcIS+0W4DcF+yjv/IbomTfm1l+JtVEUQsQb6aaPIapQudjm3VmtmqUjpTb81b
 ntNgV3bN1wUinxfpBuRSV+DGeByBopdrt1JeQyTo9crun2dP1viYbNObBCD8QVXjOenH
 rdoFd5fCuRHp6e33Vd+cXc7aXU+WS3OIL/XGtEusxIx934+tu+IUFTuYzA0dg1e4hvhx
 81ckQEe8Yv5IHUuG74J6F1bqdTbLhD72hmlPR3di8rQl+37KnZhEDLIrqI93ka+1l97Y
 INGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911844; x=1782516644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=PiTmw3CPcrmA5Jp2PYVqpwooUeyn9ODryB5rga7VoY3Xv1jzh5zNvMEZX2SoIKp7/+
 FCfmGFhOpAwm5c4zdVty95SJeKq99t93JzlYVoH8hmgFpsfYkcSPwcszVbMbMglsM6dp
 RoxvLyLxNk0neCQMYf/ZPXPWLxZQBXLRJc3cYoBlwDXFYo6pkncAlxrGM/GiPq5rr5cy
 wCx5Ed/N01S83CrQqh4/3N+NbMerImHluA7/PgijgPiX8HI+2jgcUlzeTRDZCLsFa/QR
 wVLzM6gf+fQmXMLhshIqsjua2qDnuEv60zCiPh8aZwF3Pq0i5JxYRp0ZiHwCbPa0HlrL
 X88A==
X-Gm-Message-State: AOJu0YwSS82uFIqkzK4iaYEBGXnKYR2wytjoSzRrcPPt1g8VRRIfSps4
 irQZW0n3BU2fJWJcsP7sfhLfQ+knyfVQxINSLXbkb5uGCY2w7crmy5SiMIGNbLvxMeQ4/pr1Ztg
 i/NGnQsLGVjGPhjHhnjy8oaP/oHpEL6+Qd2LSgHFktfOj9jD7TZPIVU0VpvwRWMWDnA==
X-Gm-Gg: AfdE7ck7LTyqyHmqfX5BPkebjgusVR5oa/ZCe0nQ2Cj63rgE4V8eBrFm1f0kqhqSoTR
 dEwgZHO7DdaNjkOd8WXgSFjQQniPt4LaUz7isCWVXL+i3jOmZMZQi+S3Bj9i3BpWStFZ051RVbP
 6fjqmz19idScK9VfHeqp3GZ6IYtN6OVEwhE21XVBr05n4Lbqc8c12Ys0B4vQhQfLkkqX+uxvUHv
 zh8ciC7Z5/cpm8xHsU/hND+QHCwzsFw6aT8+zWWo6K0wikyM3XFjKhE6DCubKA5nUMZ6zLjpctJ
 CcQBUiJUpXtjg8p1LJCna6Xy2qtyqci1DLurK5m6hNsWWcvfDhMG6UAPQWoylxOEzPHs5D6GL3t
 QF6dVLwUJ0LdzowQKYsN1Zq1G+BrUQh7QoVlsbS17/x+918vn1EFUo8i/RlU=
X-Received: by 2002:a05:693c:414b:10b0:30b:d86b:f250 with SMTP id
 5a478bee46e88-30c0766a680mr2066126eec.0.1781911844242; 
 Fri, 19 Jun 2026 16:30:44 -0700 (PDT)
X-Received: by 2002:a05:693c:414b:10b0:30b:d86b:f250 with SMTP id
 5a478bee46e88-30c0766a680mr2066115eec.0.1781911843707; 
 Fri, 19 Jun 2026 16:30:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 62/74] target/hexagon: Add TCG overrides for transfer insts
Date: Fri, 19 Jun 2026 15:58:59 -0700
Message-Id: <20260619225911.159473-63-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RZWgzVtv c=1 sm=1 tr=0 ts=6a35d124 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: YKNtUE9Se55huGDEgzzPJxq7HaZdT6Uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX4ztQaFhYfDkQ
 WxSSwDUgCF27droSt0rh53kYnqRf2BR36X0aJFCAVfB//jPV5RNOvQxB8asC8Bp+Jpg5k3iadkJ
 DdYMzRA2LSaAxlOdqNshNOyaii4EP4u4KKGH/kkt13qKKMUMc1ARDmsTD6zv9LOnTyyrTD/GMG7
 htTnRCOcBU2ygwLGR8oxO6mcrYeXMvwJtK7G5Ev/GqAwDdIxIzPPUnJZ4b3GX+CaBtZr6qRCiQp
 penjj30lp34rMTcRReZCod5MuZqyRhlJxBriMl3hPeVi+fxTxQDcQa8VSPQXv+UaEfUeHBGObwo
 zZv5tBpYhh8VQbq4zTaBrAGVg6f1n5MbvJEG/sjH7EZiaCXfcoQAWZB75ZIfDffHGFyH56FV2rJ
 JMwxEfOKcS+TW/Nve+/QSgvxxMRHHxhalGT1/+z5KKGMymQ/B5C7JAL6oMrRoQ41B1EK0gaSP/W
 L1A+zIHeMVwbIueDO6Q==
X-Proofpoint-GUID: YKNtUE9Se55huGDEgzzPJxq7HaZdT6Uc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXyGMDKwcHzMr2
 q3yCSm0Z+UyLHH3JqHhlxSd150odaYIcWHw35LOa62Jd0nTgJFdrsg3qtuxFOwieXnzAYcaCa9h
 bc3xP2mba5LhUNjOsHwpT8cw6hOdC64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDY4YjIzODk1NDI4Li5h
ZjUwMzIyMTRjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

