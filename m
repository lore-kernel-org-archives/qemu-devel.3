Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8624BC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coD-0008Vs-LZ; Wed, 02 Sep 2026 00:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coB-0008VA-F9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1co9-0000J6-O9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTHen2982853
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WvmBQy5dMbgt9UR5nYGTA3klSicXmWsc2axDcx6oLEg=; b=RxrkkBGfg2CYqsIY
 KjX34Hgwi6Kxxz0LnctXsqb/svMs4zGbuFdm7XThJZpIfObxBt60OmptfcVqbg2/
 rosV/Ijlup/4awzQy7dw1Pz2TBjqQQspfUxR9KOHBPM0gYfAhqbMihUum9WOTZNz
 6Q/SrpRm5iahk+0g3Qg95DVsvXD8hxjrYOI3M5AMvK/JDzfB9pG91cGQ+voMne6r
 deGIg8vrWGaGU9M8F8POYajCHVc74mNlawWpWl4tHtzCD/1b2yTel1Z3DSnr7OtN
 rxUz9xefLfL5BsvCkeylDN9owMnwpOFX+LFp9660hs318Ji1M+TxLzGIKxg3HNCq
 pC4uEw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so10425365ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324164; x=1788928964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WvmBQy5dMbgt9UR5nYGTA3klSicXmWsc2axDcx6oLEg=;
 b=OnDakW9IZ2zGMzX9Wk+RuQTtTsslBPleHs8wutdnmHW0GBMR6YFHLvoHpgjds/+Ij0
 TFZYJEerVjBhXZA+hhmS5wjSywBO9twqEkCvaiSnAsx+OjVErTb6Nn22MPY5LOJTQjuv
 2QspXB9xGy4Dzz1xedF/24EhmIuyP/OtCI92HX6wsbsmMMO1h45qhnQRXS/zpQ/L6PhW
 /2vmR4+i+YowaCuMNu6BiE7X8Txv8PYvNJVH0P0b0rJ0yzI0vuJDK9mRGq9jZfnp4Hc1
 yLN0TlY+z8hZImXX+0+stPXBU+6cF5KpbP+lW+irGFbh7GpJuH+GcUziB6+iyVzYhRUm
 d3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324164; x=1788928964;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WvmBQy5dMbgt9UR5nYGTA3klSicXmWsc2axDcx6oLEg=;
 b=e8XACrrnNap/Jv4oBy0szDnl0PUvkADmeXBv0NI/iTM+KZ+4GskZV1lmY0hitISEPy
 ntymYDHwoXBcyJR9YLY+tsrfBb4wBNdBdtEzKCWdoWxOUqsmXAv2hgWnGr+Cm3/5E0fr
 sj2TMCPMqefoVDhCPDh7NW5+4XDTGgpDhyTvwsj1AXBUmhgDYCPoXB0o5BEtrrAQ/cNB
 Epyn92XnZkuBfMoT/Pp6di5BaRw51vI+wiQrIRDMpBRi8t5ZT5NCpaT8Zk1+GTQYP4GP
 xvfcAn2OiAr7Zo7NvHcyU1Qgq9bYW+je35Gk5zhhYCOR1PLgWSfcUYp9qcm48/tJbDi4
 kuAQ==
X-Gm-Message-State: AFuF++lMwd05SvJdlyJoH1E1+t00/mghWSBIwSaoZeh3bMWzf52Lly4W
 +Jn7231OurtIRGzsZj5Ek/gOPWOk9VYPMXJm034laAnKs0Z1BwGF7VOIoYl1Y2ZfZMlum2GkiQR
 I3o2HNvNl9pps18m7Rs5EZvIuqYB4yffCmFO7gXiOmkd4IrZkjrf04Oo8k0RKnF2rqg==
X-Gm-Gg: AYBFou0prtZd0mn46u/IEPhA7Eod+5ArR1fZAZXPfPnp3KQ5PF1FqUHwKXF7KLHhgDm
 N6qqXMrolUcFuIWkJBAW2Au+jR+MacaFoVG/zK0u6n3xNo27Mdm9bblTSxlJd6G1XgGYztFpHxK
 p6H90rw826d6YLVwwKTHqrFxkGvYUJjCdCkS5yupMvlkCo6u2l4BWHr2vmIZrK3tzeIZ+f3HzSM
 a3c+N/JVAmThELw2G/iwNOXijdHb7edeSaDKCthVaE+nlgp1RQ+VZ/4z3p9NbIV8OLP+FrNH1u6
 8TE1XYEUg4MqsqiK8kP8rKaROrjDUDhGreYlvzMWdEEDRpQUOjKe05QqNbGUb3bWMLo4mL1ohMw
 PwU9hZ806ROWF+JwIOKNqVy97ffIr31/3K+AM4xkSa9LDYp7B
X-Received: by 2002:a17:902:ce87:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2daec5f25b5mr29762685ad.2.1788324163759; 
 Tue, 01 Sep 2026 21:42:43 -0700 (PDT)
X-Received: by 2002:a17:902:ce87:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2daec5f25b5mr29762105ad.2.1788324163200; 
 Tue, 01 Sep 2026 21:42:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/28] target/hexagon: fix store-conditional on big-endian hosts
Date: Tue,  1 Sep 2026 21:42:05 -0700
Message-Id: <20260902044231.843004-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXxwCPESbkI45A
 +l/EzzdNBw6L/KGxz0q9P0+ZkbJismyqOEaYw61t49zyH4DAq7AlGb9rb49FWc076RRA3yoB2KF
 g3bEJKimKezPjmCG285QCCM5UIx78H/RB+F8lWR8sXNPx7WzYLMROcZL8p9ikYa0CUrCSifekGP
 XHGq6BnSg1sAC8u7QC+AfbjCrFgDeQmdwJSkOOegylFHHEvzrVuJr2crPvc+LZibMoXUwTLP0rv
 qExhabPpNC8DsPDutjjUKv4EFt/wvafY6kHoTw0yZsGCEyh61Ngi/coN0t9XW5Ghy4nWpbw2qrl
 b6BZJb/YoW4CpbWn0wMFnzV2UEy3eLaZ3W+QPsPbcaRRt9lyK06s5o5wSWmET7gfLmCUJhO7gw7
 QBgAOk0NJjgIfWcxDlN8V2i2XsKT0I1tCIzykq3dU8H9vuvmoIwR4VF3n5MShTt2dEugo0VeQJS
 NmCBnS8jtokIJkNEfMQ==
X-Proofpoint-GUID: vwB2-9lD0D824f4JziFo1BwvQyQpVA4m
X-Proofpoint-ORIG-GUID: vwB2-9lD0D824f4JziFo1BwvQyQpVA4m
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a944 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=leud2LzcgvzU7ZSISvAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX/1yg+kY3KYvs
 IiSX/ZPByaxaYEIcGfjfyDJbg/+lZDBGUxN7b+gD1MWlVBbbsEXMP+VpvUWQOob3WfUWS8811qS
 x3HaeTk4/yI5CBDNq2478gOABfuzzJU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKZ2VuX2xvYWRfbG9ja2VkNHUoKSBhbmQgZ2VuX2xvYWRfbG9ja2VkOHUo
KSByZWFkIGd1ZXN0IG1lbW9yeSB3aXRoIGFuCmV4cGxpY2l0IE1PX0xFLCBidXQgZ2VuX3N0b3Jl
X2NvbmRpdGlvbmFsNCgpIGFuZApnZW5fc3RvcmVfY29uZGl0aW9uYWw4KCkgYXJlIG1pc3Npbmcg
dGhhdCwgc28gd2Ugd3JvbmdseSBhY2Nlc3MgZ3Vlc3QKbWVtb3J5IGluIGhvc3QgYnl0ZSBvcmRl
ci4KClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJl
cm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bnB0ci5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hl
eGFnb24vZ2VucHRyLmMKaW5kZXggMmE5OGIxM2I3MTQuLjkzMzA3MzJjOTliIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpA
QCAtNTc2LDcgKzU3Niw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc3RvcmVfY29uZGl0aW9u
YWw0KERpc2FzQ29udGV4dCAqY3R4LAogICAgIHplcm8gPSB0Y2dfY29uc3RhbnRfdGwoMCk7CiAg
ICAgdG1wID0gdGNnX3RlbXBfbmV3KCk7CiAgICAgdGNnX2dlbl9hdG9taWNfY21weGNoZ190bCh0
bXAsIGhleF9sbHNjX2FkZHIsIGhleF9sbHNjX3ZhbCwgc3JjLAotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY3R4LT5tZW1faWR4LCBNT18zMiB8IE1PX0FMSUdOKTsKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGN0eC0+bWVtX2lkeCwgTU9fTEUgfCBNT18zMiB8IE1PX0FMSUdO
KTsKICAgICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfRVEsIHByZWQsIHRtcCwgaGV4X2xs
c2NfdmFsLAogICAgICAgICAgICAgICAgICAgICAgICBvbmUsIHplcm8pOwogICAgIHRjZ19nZW5f
YnIoZG9uZSk7CkBAIC02MDEsNyArNjAxLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGdlbl9zdG9y
ZV9jb25kaXRpb25hbDgoRGlzYXNDb250ZXh0ICpjdHgsCiAgICAgemVybyA9IHRjZ19jb25zdGFu
dF9pNjQoMCk7CiAgICAgdG1wID0gdGNnX3RlbXBfbmV3X2k2NCgpOwogICAgIHRjZ19nZW5fYXRv
bWljX2NtcHhjaGdfaTY0KHRtcCwgaGV4X2xsc2NfYWRkciwgaGV4X2xsc2NfdmFsX2k2NCwgc3Jj
LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+bWVtX2lkeCwgTU9fNjQgfCBN
T19BTElHTik7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5tZW1faWR4LCBN
T19MRSB8IE1PXzY0IHwgTU9fQUxJR04pOwogICAgIHRjZ19nZW5fbW92Y29uZF9pNjQoVENHX0NP
TkRfRVEsIHRtcCwgdG1wLCBoZXhfbGxzY192YWxfaTY0LAogICAgICAgICAgICAgICAgICAgICAg
ICAgb25lLCB6ZXJvKTsKICAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIocHJlZCwgdG1wKTsKLS0g
CjIuMzQuMQoK

