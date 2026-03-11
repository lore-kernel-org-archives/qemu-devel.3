Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F358FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsZ-0000ye-5v; Wed, 11 Mar 2026 00:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsX-0000xT-EY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsT-00007I-Et
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B1Jvwp509379
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eDXxY8veDppPGZYB4pvyhydqmDwea2dSVqYJLsKwO3E=; b=HW6kbCJVPrL99Qgh
 5JAVKdOQV+D1mVg4lDievMM7ljQJHi7NQGmbu+4OhC0PGKsnrkO0A7bDz4c66HsR
 KLIULyucF9i0eznBUmBlAnOx/1K3+qa+YvuON2NvjRQ/v3OKD4EcNOCLX3drtq/Z
 HvJDrsvdY5XaoRsDcId8oZv2mQ7zFPVBL3LN0ivwmqR0te+12n8qerIZTOz5y0ez
 CQihVC97m0WTQARNF1W0ljrARpDio1UrJSOBYtxxPR1qkJ8E2AuMMqpK7gyvmBT7
 1HBmqNqeLVKB3Ew7add42tX9XVmwWKHOt+bEpwAoqOmA1j4Ud53DEdRIQ+zf29qK
 48nkFw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppaj4yx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:46 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-40f09403c56so5154992fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202126; x=1773806926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDXxY8veDppPGZYB4pvyhydqmDwea2dSVqYJLsKwO3E=;
 b=N6ngjrqE86jKhkEyBaqPXCdx14/3vkkZuiD3TfFDY+JwcmPT7C0Md8I4vWvECs0y2i
 uO+HNwDepck52K/oLxiPcvxI6Xq8Gk1aF6FXLH3XbXn6fJPFpHpLRj7UsaL2xuKTOpCM
 J6pF+Ls6PxN1BqGtEWgqYhos/3J6R2/QQp29mj5vrE+1JjnXKEtC6q53fJG9JyHWHfhj
 uz5M7zXiUEIx4XQz9s2bw7x0T8eCLw29XdvPP2IZmPGHjE2XxSkhi0JCBvHrmPdsOeYW
 GAOWOesTBwrWF/AtOF//Of2JZPK1/2GF/jETDj5/R2SMDywjX9NwitQ45LxCc5FO7wRu
 /mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202126; x=1773806926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eDXxY8veDppPGZYB4pvyhydqmDwea2dSVqYJLsKwO3E=;
 b=tK1JaqxrjNVmetCXUpSr4C6ZhXKoFtAtFx56QZKBif775hq/i+2spzL2lagTX76ikf
 ueMkaJJZXukAmR2OqmwMK9rq+zvyRA1m/D3g4mvgLpmcBircpTeFvMZSM57Ceae0ZQAa
 VN6YARgSfKuWFrEF1wuYsTU3uYmNr+EfF1BPY6gypTfLX57rG/THDJwcbPI9Fw5UfsI5
 EGNeR/y+6pTKycRnSWOC1N95luBKArsYFoCOSPvr/crm2NXtNo/FJZ6gEErbusdJYSs+
 kjPB6wF0wBigvNC+G2ENTBiX6nre2AksDy0N1+MT67gJYcgikWA7kZ9HxKaWj95NlUnw
 NdjQ==
X-Gm-Message-State: AOJu0YzT2A2nA0zXZLBsZDk+/Ku1zTpoXj68LKE9vR697CmBbuBfKDj1
 bR9XIYhtqAfEkf39X3XUJyxTTCbZTDRxaWrBfKHF767yqgcIZzmpU4KqQDTeslC8E2Ur0PAfh7u
 tRk//+ZoBK95zg8WpGWSv72ZGW/SWMrq0NcpT9j3qENiZ9aVpIbiLvjwTXYBRValatg==
X-Gm-Gg: ATEYQzycXHrrKmpWw9wlMEDI/duh84Z4qefQ3ZVIwIuW+1AIIrw9f2iwCTPuLe7fD5Y
 ci74IyjeblUNIVK4lLeVVmjuritSx6tAWao7JGK1kH+t+0KJdGiZK+jqGchUf1gfCY9i7S5nllp
 57Af0cH1XweLe10N18uELNkBFmcSW9VrkCgCSAW9doLvYH2DN/H1ei13eHuI9M1WvUYiBy8T7tx
 wV281O1s4C0W7/89QE9iJRf6cXMeO9MhGV1ScbQiEHYXIWZQm0Uj975HmEU9d1rzBZDl8CfCKJJ
 UCxvFZNUMiM1iCTIKUOCdDIb+xl7v3vF/PUuIRsX8Akej9nuYV2JzLeERhQ5HAdsJ8n0jziOiOr
 FD+z5lr0dGC3MBv0DkJHksT8kH1HTvkqGa7JjQop7VU8+wqsKLQhMVJkDoj4YK1oSPoyHRw==
X-Received: by 2002:a05:6870:a789:b0:417:3161:bfcc with SMTP id
 586e51a60fabf-4177dc77bb7mr775474fac.5.1773202125787; 
 Tue, 10 Mar 2026 21:08:45 -0700 (PDT)
X-Received: by 2002:a05:6870:a789:b0:417:3161:bfcc with SMTP id
 586e51a60fabf-4177dc77bb7mr775461fac.5.1773202125427; 
 Tue, 10 Mar 2026 21:08:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 29/32] target/hexagon: Add TCG overrides for transfer insts
Date: Tue, 10 Mar 2026 21:07:55 -0700
Message-Id: <20260311040758.1068731-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ggFzC54rJZbf63HKX5WebyoVrQC7Edpr
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0eace cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXy7DEQTSigM9I
 6a0hoU97mAainjIBn0lo/i0MHkMUNJeokCc0xrDiDcFyBTNVRYJfC/coyRI4mKz/zMwwGa5xrxp
 hGfBwttQOQfH+wJ4Yp6TI27XuxzicqHg1Yzu40jql6uFOmetvTBH0QBQjSpKGZROWwTh7SsYiH6
 SQEiwRU5VAkrYdg0a9bELGrLT5KXnfiT0zEVLFCetMPbBFZs6Em26RNwsRPjQyUzAt+N19G7Tvd
 oGew4id+6bVboEqv2RRLTK0LAYbEH6Cldi9WF18cWbw7qEw77oI1QLfodusLxXXpRvS9HC2atAs
 XQwAVm2aJhnQqqKAkomPFxJ3UsKALXpP9KBQQunCCKUdt9j/tHWSL+nen/GYcIBUE7iwV7gbjYs
 L4lU1doT41P6EY7VSwFLBVCx7tK6U5fEDAgHecTHHREtO5DXVUou6QuWXpbibgs+Zh5xzt4cjaR
 iO0AY3ZC9A9KBOwIakQ==
X-Proofpoint-ORIG-GUID: ggFzC54rJZbf63HKX5WebyoVrQC7Edpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDA0NDA2ZGI2YTRiLi5j
NGQ3YzIxYjg5MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw2ICs4MCwzMSBAQAogICAgICAg
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

