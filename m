Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7A8CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6woJ-0003pt-K7; Thu, 09 Oct 2025 16:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnz-0003jJ-Ak
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnt-0005Bb-Ur
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EV4Dg023282
 for <qemu-devel@nongnu.org>; Thu, 9 Oct 2025 19:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 78hUiLIwqfw1lF8IcpkP2DM8dbcUxGbMRrlS2cIjl3U=; b=USnQexUV2PhBrByF
 NdmWEYYcU0PWYVpQubPBBHC5MZBazgDtEtjigKnubcFhehuLCTvgTUySp3P+/LVl
 gEHZQo8CvZLYNASEEAW2ohZ5j9Smfi+Wvr4twkcZ39tI+chpyfDly50eENZWVj9O
 QPGkd6p6fOj6Pdi08qTn1L4Nd5slQY8jHOfjmvqzTUFW/om5EJDe3dhqu0HgB1u/
 LBGkcsL6HL+y+/KsDchTHUESYVMYaVgxa3g4qf34PmYEq2TaK8MQazd0OHiZ2GWu
 Rfa8XvFZOXpQkRE0YZiSJS+My1GNR3R9a8x4YIlJFp4CxhXiWyrBGzeEZ9mBYQtc
 zdJS7w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m45mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:59:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-26985173d8eso51811685ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039993; x=1760644793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78hUiLIwqfw1lF8IcpkP2DM8dbcUxGbMRrlS2cIjl3U=;
 b=A7X8rqTqHm5M5peXj/iItfpixfSgBZgDa7kvCNo0pyS8eM7ZS1OthrEpWpb58JTmq1
 6BzY00sKg3TfVWjVwo2TQcTcQEnvcPGav7ppFbPW4dxzixjt4vV1XNZDS9jJkK6uYqyv
 YVok5HE4BYqDar+yhrxqvLpPrVMz/A5qaY4ec35O15ISgmqKJzb8LIrIrtLM2MM4I8H0
 GyNXxMO6aZAv+eHjYbx0KtRMPHwGfWRz1c2lbvQgh8lsqTw57JF9tIVwf/w/m46+zxeO
 CGycGTThkBuShW2Quynd7rTUvYxJ21r3aIoTBPepUD/HPXhrqMis+bgeoN0GFLQVtnj4
 yxMA==
X-Gm-Message-State: AOJu0Yyrn2IgLw3Y6MYXizNYF/Q4Uy4zChGB/vAVadNJycSibaXRT3SL
 UUrX2/8QTvCTrq9Tv9xGsZhEslpZO04Y22kyTcVYQnjQfYkdZaZeVoogwteWK1J7FMHqBnSo5cQ
 Su4JPBdtWZTpTTE2dIJKNVVod/4imwyjoPqMjxhwv+16hmGYF0egJ98uRfK9352pQvA==
X-Gm-Gg: ASbGncsj+8R0r6XfHZNR/tK+OsOw7VPfDAkhjheWPc1HsSwGpVNY8tdK7E4IuaOOqCh
 SQWoWsQK+RancgOYryCCE7L9/B1l9vfRsjLC1rKjyL2rfhYHSEag2i/9TxZ9J4OmwgFAgR0FXBN
 IO4WebMxuzLZbnMEd2jCNAGCpovwUZ0pO1/mmWmHxmLKaREhWuIBoQqe3wL7oWn9XOAhP4QVI/1
 gRZqpBtBSFtd4enGvD+xwVzjgiZPDbKK4fuqS1OkJN8QBvC+HU9zbGX1OOH/8mmvEFvLblleU1y
 RkTYmOROnAqHrn0QqW9KzZvOjtJHk9hatW7vE5x6DIU+27SMyMXoreGxQO+EeEiKiFuCUuRlPXj
 ypYiewqsHdaCBFaowSA==
X-Received: by 2002:a17:903:3885:b0:256:9c51:d752 with SMTP id
 d9443c01a7336-290273069bbmr115733105ad.56.1760039993507; 
 Thu, 09 Oct 2025 12:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY8smY1TCBqyjiyoo2f6rI+IjR+pb0LeibPm19LO5IHCiOGaoJmeKur03lcGg1yLKqQiuqgA==
X-Received: by 2002:a17:903:3885:b0:256:9c51:d752 with SMTP id
 d9443c01a7336-290273069bbmr115732805ad.56.1760039993060; 
 Thu, 09 Oct 2025 12:59:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f32d6fsm36678805ad.96.2025.10.09.12.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:59:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 2/4] linux-user/hexagon: use abi_ulong
Date: Thu,  9 Oct 2025 12:59:41 -0700
Message-Id: <20251009195943.438454-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9lOQ0kCRU8GE
 61ZmMKRm12ojvTlSKkAruWq1dU/5zUAvZuUoFzz0/DBBfNhOMD3uADJKIx79eKViBbNtPHlQRWR
 WxL/kBbLOkncaA11amSc7K+zHIjqOZzSPfA85IcjAFTSLQ240JAiwRHjsLmJlC4UFqn3le6T1vt
 2FvWAM2tzm3oVuEu0VxUpyxwE3Z00AoXb74WqipWLZ8+mvTjsAwMgwGHEYTSE7pPogUG4Bh3xpY
 ABoYvNZq4q6dfO3OISeNmIdYeLJYStiIw8p/0h3Yrh4XeFigWM6S/xAqtXl2h3UnvPgWzVEpfLz
 fWLSojWBKgHHZRXwEwYNjkG7NVahSwcbgYaHQciId7U/SNGUI27pMQsSksrySo0UL7RHt/hRgns
 GrNeqz2n7srEOIxArrb82+0BSvLy6A==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e8143a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=bKXqxLCKRvHHRPj8uRoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: x2Rp_oxQREDiuSsn19QJZey5zXy8K6R8
X-Proofpoint-ORIG-GUID: x2Rp_oxQREDiuSsn19QJZey5zXy8K6R8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Q2hhbmdlIHRoZSB1c2VyX3JlZ3Nfc3RydWN0IHRvIHVzZSBhYmlfdWxvbmcgaW5zdGVhZCBvZgp0
YXJnZXRfdWxvbmcuCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzdi
ZjNkOGM1LWRmMDctNGNiZC1iYTYyLTRjNzI0NmE1Zjk2YkBsaW5hcm8ub3JnLwpTdWdnZXN0ZWQt
Ynk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQog
bGludXgtdXNlci9oZXhhZ29uL3NpZ25hbC5jIHwgNTIgKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDI2IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9zaWduYWwuYyBiL2xpbnV4
LXVzZXIvaGV4YWdvbi9zaWduYWwuYwppbmRleCAyODQ3OTUyMjE2Li5lNTUxNGIyYmVjIDEwMDY0
NAotLS0gYS9saW51eC11c2VyL2hleGFnb24vc2lnbmFsLmMKKysrIGIvbGludXgtdXNlci9oZXhh
Z29uL3NpZ25hbC5jCkBAIC0yNCwzMCArMjQsMzAgQEAKICNpbmNsdWRlICJsaW51eC11c2VyL3Ry
YWNlLmgiCiAKIHN0cnVjdCB0YXJnZXRfdXNlcl9yZWdzX3N0cnVjdCB7Ci0gICAgdGFyZ2V0X3Vs
b25nIHIwLCAgcjEsICByMiwgIHIzOwotICAgIHRhcmdldF91bG9uZyByNCwgIHI1LCAgcjYsICBy
NzsKLSAgICB0YXJnZXRfdWxvbmcgcjgsICByOSwgcjEwLCByMTE7Ci0gICAgdGFyZ2V0X3Vsb25n
IHIxMiwgcjEzLCByMTQsIHIxNTsKLSAgICB0YXJnZXRfdWxvbmcgcjE2LCByMTcsIHIxOCwgcjE5
OwotICAgIHRhcmdldF91bG9uZyByMjAsIHIyMSwgcjIyLCByMjM7Ci0gICAgdGFyZ2V0X3Vsb25n
IHIyNCwgcjI1LCByMjYsIHIyNzsKLSAgICB0YXJnZXRfdWxvbmcgcjI4LCByMjksIHIzMCwgcjMx
OwotICAgIHRhcmdldF91bG9uZyBzYTA7Ci0gICAgdGFyZ2V0X3Vsb25nIGxjMDsKLSAgICB0YXJn
ZXRfdWxvbmcgc2ExOwotICAgIHRhcmdldF91bG9uZyBsYzE7Ci0gICAgdGFyZ2V0X3Vsb25nIG0w
OwotICAgIHRhcmdldF91bG9uZyBtMTsKLSAgICB0YXJnZXRfdWxvbmcgdXNyOwotICAgIHRhcmdl
dF91bG9uZyBwM18wOwotICAgIHRhcmdldF91bG9uZyBncDsKLSAgICB0YXJnZXRfdWxvbmcgdWdw
OwotICAgIHRhcmdldF91bG9uZyBwYzsKLSAgICB0YXJnZXRfdWxvbmcgY2F1c2U7Ci0gICAgdGFy
Z2V0X3Vsb25nIGJhZHZhOwotICAgIHRhcmdldF91bG9uZyBjczA7Ci0gICAgdGFyZ2V0X3Vsb25n
IGNzMTsKLSAgICB0YXJnZXRfdWxvbmcgcGFkMTsgLyogcGFkIHRvIDQ4IHdvcmRzICovCisgICAg
YWJpX3Vsb25nIHIwLCAgcjEsICByMiwgIHIzOworICAgIGFiaV91bG9uZyByNCwgIHI1LCAgcjYs
ICByNzsKKyAgICBhYmlfdWxvbmcgcjgsICByOSwgcjEwLCByMTE7CisgICAgYWJpX3Vsb25nIHIx
MiwgcjEzLCByMTQsIHIxNTsKKyAgICBhYmlfdWxvbmcgcjE2LCByMTcsIHIxOCwgcjE5OworICAg
IGFiaV91bG9uZyByMjAsIHIyMSwgcjIyLCByMjM7CisgICAgYWJpX3Vsb25nIHIyNCwgcjI1LCBy
MjYsIHIyNzsKKyAgICBhYmlfdWxvbmcgcjI4LCByMjksIHIzMCwgcjMxOworICAgIGFiaV91bG9u
ZyBzYTA7CisgICAgYWJpX3Vsb25nIGxjMDsKKyAgICBhYmlfdWxvbmcgc2ExOworICAgIGFiaV91
bG9uZyBsYzE7CisgICAgYWJpX3Vsb25nIG0wOworICAgIGFiaV91bG9uZyBtMTsKKyAgICBhYmlf
dWxvbmcgdXNyOworICAgIGFiaV91bG9uZyBwM18wOworICAgIGFiaV91bG9uZyBncDsKKyAgICBh
YmlfdWxvbmcgdWdwOworICAgIGFiaV91bG9uZyBwYzsKKyAgICBhYmlfdWxvbmcgY2F1c2U7Cisg
ICAgYWJpX3Vsb25nIGJhZHZhOworICAgIGFiaV91bG9uZyBjczA7CisgICAgYWJpX3Vsb25nIGNz
MTsKKyAgICBhYmlfdWxvbmcgcGFkMTsgLyogcGFkIHRvIDQ4IHdvcmRzICovCiB9OwogCiBRRU1V
X0JVSUxEX0JVR19PTihzaXplb2Yoc3RydWN0IHRhcmdldF91c2VyX3JlZ3Nfc3RydWN0KSAhPSA0
OCAqIDQpOwpAQCAtODUsNyArODUsNyBAQCBzdGF0aWMgYWJpX3Vsb25nIGdldF9zaWdmcmFtZShz
dHJ1Y3QgdGFyZ2V0X3NpZ2FjdGlvbiAqa2EsCiAKIHN0YXRpYyB2b2lkIHNldHVwX3NpZ2NvbnRl
eHQoc3RydWN0IHRhcmdldF9zaWdjb250ZXh0ICpzYywgQ1BVSGV4YWdvblN0YXRlICplbnYpCiB7
Ci0gICAgdGFyZ2V0X3Vsb25nIHByZWRzID0gMDsKKyAgICBhYmlfdWxvbmcgcHJlZHMgPSAwOwog
CiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMF0sICZzYy0+c2NfcmVncy5yMCk7
CiAgICAgX19wdXRfdXNlcihlbnYtPmdwcltIRVhfUkVHX1IwMV0sICZzYy0+c2NfcmVncy5yMSk7
CkBAIC0yMTEsNyArMjExLDcgQEAgYmFkZnJhbWU6CiBzdGF0aWMgdm9pZCByZXN0b3JlX3NpZ2Nv
bnRleHQoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHRhcmdldF9zaWdjb250ZXh0ICpzYykKIHsKLSAgICB0YXJnZXRfdWxvbmcgcHJl
ZHM7CisgICAgYWJpX3Vsb25nIHByZWRzOwogCiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhf
UkVHX1IwMF0sICZzYy0+c2NfcmVncy5yMCk7CiAgICAgX19nZXRfdXNlcihlbnYtPmdwcltIRVhf
UkVHX1IwMV0sICZzYy0+c2NfcmVncy5yMSk7Ci0tIAoyLjM0LjEKCg==

