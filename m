Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5935BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wo8-0003p0-HZ; Thu, 09 Oct 2025 16:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wny-0003j9-TY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v6wnu-0005Bt-SH
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EbccT029641
 for <qemu-devel@nongnu.org>; Thu, 9 Oct 2025 19:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oA4ozt3fYHKu9orcATS/76PnZrz9p+EYtMwaMzHl5GE=; b=gseuXUS3mHxiD/bA
 +28j6/Fixs3wkdale0QEGhwodETHMpmeS7SXMOQ3Y3rLrR92NmsjB1hf8L4lHEGt
 R31gyH0b7e65rt7+GqVBfShk9pEjgAjeaql1pocVL7G9/4KfphSjZBIpkyq41Jrk
 ahPvBR9Un8ibDJkglTpcfnf2Q7bxgTZaRnbkLDEYxj1/aPgVKwWUcNIZFLwYZAcx
 5tBmxjH62+G5q8Ui0ULJs+zEW6DmfickzwsfVY403/Z/M/nz/97iRBgGD75XuVKF
 zHHgieequeuqZ9xU+Td+B3OPR60cqcfJgJEgLu8zcqhuo9VZBaxzr5MoE4NkMhMB
 hyh/IQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kv608-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:59:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-28d1747f23bso22998265ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039996; x=1760644796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oA4ozt3fYHKu9orcATS/76PnZrz9p+EYtMwaMzHl5GE=;
 b=L81R2hGCxexqzgKELyaNFodcCA2ODElefI3XsqUkClyUkgecPFT598Fr8zAvBuGoqM
 dwEkvIvcaWgI3UT1BR3MZHenH3tJeVzqkPbdWURfVn0AMjSMVPwFOzfZ/F8hIXrnYhx/
 odmSXRfBcUQXhVN9BeKB3EcwdjEw+fcKiPJCNemnyNywVG584RUQU97D9BhuWdzlvZlx
 A0mXa8qLGoQLaXao+zLL77QLe7E8LqBNNN3p09c9DbRfVzF0MvIufFUnJeFJUAq2ycJU
 sL9uN6ScI6raUsGEk0o0vjcvDm5ODHQKbsII+FGt6xeezrIyE27mduQAPWc5ojIIwMQg
 XK1A==
X-Gm-Message-State: AOJu0YylmjNQeFtIkOaZkRqY8Hw6DGTlwNt2KNNX5QT08I5Ic3LGQx1L
 MUhAOLm+Tt0v2AOfgvEYo2blG0Dnakf3CwaHcmoBVunuTe2FXqWEo1cgj786//KPOKkqi2a4eLj
 bSz/vnw4Fcj8UzcWDOxrbrRrpxo0seh3uby2T4p4EeXNthBN1syyeAtYgfdXl9Kq1Iw==
X-Gm-Gg: ASbGncvSPeh1HOhQUPEAyqRTqK5z00fe8MTV8OyvbfUT5f/4Q/UtD54dNrN9UberLGs
 gIECh4Je8RwBXSDqhgf8cHkHCIvPcrx63LVtoY5ylJqFpz0anU32GqGA8wGC21NBbQFd1D5WfCg
 qAQf38VNK1u7dPW6Vih1Yc7XiByRRubOwKXwd21c4vcsCLJgHO6w93Vs3xGCeVhO8ds9uOl75fs
 sTRKZVyZdMx+ExxpLLREldVGihv3JI/ETkhj6aoLn7ePd3eW/BnjHQq6o7jCG9nn8DHFo+Z/5hw
 Hk6TEj10x73OPE2fWZVlXsfnnYr7j/6cscJIrwYtov5LJlsF17R9j5O/3hiAmQFFuG0g5OumDqE
 QwYsqQmpe1giuYAzkzw==
X-Received: by 2002:a17:903:fa7:b0:275:f156:965c with SMTP id
 d9443c01a7336-2902741e441mr114877005ad.52.1760039996091; 
 Thu, 09 Oct 2025 12:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6JPwHDxY1Abm3u/N6B92ykde+YxsugwgeYUjSJ9gtqZumYL7qDAdT0Fu79lvIglc/oR8hTw==
X-Received: by 2002:a17:903:fa7:b0:275:f156:965c with SMTP id
 d9443c01a7336-2902741e441mr114876655ad.52.1760039995622; 
 Thu, 09 Oct 2025 12:59:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f32d6fsm36678805ad.96.2025.10.09.12.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:59:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 4/4] tests/tcg/hexagon: Add cs{0,1} coverage
Date: Thu,  9 Oct 2025 12:59:43 -0700
Message-Id: <20251009195943.438454-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1RRXsFTxijZ+
 umicJvcB6AIjieRjYh3krQ/Byj9XKYY0MLBg73GnpnctQRrLlH7JruiU188xNXq87+7dPyaHVKG
 oNG3dblSss3qUEwFJHLnlocscjeumRcA0krD86rdvLZPqDdwS83cOs8i9W1krKpzcYQt6lclJMX
 m4vIzGwUiQDYzqrk6hFPkSWLecmun1gIDsde1a4eAv5WOiUYgsjm67eoyfJpb9SXAYZYudkEqeT
 70odvwMjcgebKredE0tip1fyPXJvH782lPLJwq8MjNYKXWOm/j+5reuNRkURy81wfS2uoWQd785
 B3prjCHRbylPZetiOkvuiKTGVNwc3sWcWR8EIXDEMNIyR7INIpqSXxS7ctdyFIvdcgP92F+9O7L
 bVZIGv0fjjbeGTAWBYRKjjp+6d0G9Q==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e8143d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=gohRq8mKNrDRu6Qpr2AA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: YZ4NzGsv1LZokb-VrD1yqPCjuHrQJVLw
X-Proofpoint-ORIG-GUID: YZ4NzGsv1LZokb-VrD1yqPCjuHrQJVLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
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

Q292ZXIgY3MwLDEgcmVnaXN0ZXIgY29ycnVwdGlvbiBpbiB0aGUgc2lnbmFsX2NvbnRleHQgdGVz
dCBjYXNlLgoKUmV2aWV3ZWQtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
ZXN0cy90Y2cvaGV4YWdvbi9zaWduYWxfY29udGV4dC5jIHwgMjIgKysrKysrKysrKysrKysrKysr
Ky0tLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vc2lnbmFsX2NvbnRleHQuYyBiL3Rlc3RzL3Rj
Zy9oZXhhZ29uL3NpZ25hbF9jb250ZXh0LmMKaW5kZXggNzIwMmZhNjRiNi4uMDBiYmIzZWZjNyAx
MDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vc2lnbmFsX2NvbnRleHQuYworKysgYi90ZXN0
cy90Y2cvaGV4YWdvbi9zaWduYWxfY29udGV4dC5jCkBAIC0yNiw3ICsyNiwxMSBAQCB2b2lkIHNp
Z191c2VyKGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqcHVjKQogICAgICAgICAicDEg
PSByN1xuXHQiCiAgICAgICAgICJwMiA9IHI3XG5cdCIKICAgICAgICAgInAzID0gcjdcblx0Igot
ICAgICAgICA6IDogOiAicjciLCAicDAiLCAicDEiLCAicDIiLCAicDMiKTsKKyAgICAgICAgInI2
ID0gIzB4MTIzNDU2Nzhcblx0IgorICAgICAgICAiY3MwID0gcjZcblx0IgorICAgICAgICAicjYg
PSAjMHg4NzY1NDMyMVxuXHQiCisgICAgICAgICJjczEgPSByNlxuXHQiCisgICAgICAgIDogOiA6
ICJyNiIsICJyNyIsICJwMCIsICJwMSIsICJwMiIsICJwMyIpOwogfQogCiBpbnQgbWFpbigpCkBA
IC01Miw3ICs1NiwxMSBAQCBpbnQgbWFpbigpCiAgICAgaXQuaXRfdmFsdWUudHZfbnNlYyA9IDEw
MDAwMDsKICAgICB0aW1lcl9zZXR0aW1lKHRpZCwgMCwgJml0LCBOVUxMKTsKIAotICAgIGFzbSgi
bG9vcDAoMWYsICUxKVxuXHQiCisgICAgYXNtKCJyOSA9ICMweGRlYWRiZWVmXG5cdCIKKyAgICAg
ICAgIiAgIGNzMCA9IHI5XG5cdCIKKyAgICAgICAgIiAgIHI5ID0gIzB4YmFkYzBmZWVcblx0Igor
ICAgICAgICAiICAgY3MxID0gcjlcblx0IgorICAgICAgICAiICAgbG9vcDAoMWYsICUxKVxuXHQi
CiAgICAgICAgICIxOiByOCA9ICMweGZmXG5cdCIKICAgICAgICAgIiAgIHAwID0gcjhcblx0Igog
ICAgICAgICAiICAgcDEgPSByOFxuXHQiCkBAIC03NCwxMCArODIsMTggQEAgaW50IG1haW4oKQog
ICAgICAgICAiICAgcjggPSBwM1xuXHQiCiAgICAgICAgICIgICBwMCA9IGNtcC5lcShyOCwgIzB4
ZmYpXG5cdCIKICAgICAgICAgIiAgIGlmICghcDApIGp1bXAgMmJcblx0IgorICAgICAgICAiICAg
cjggPSBjczBcblx0IgorICAgICAgICAiICAgcjkgPSAjMHhkZWFkYmVlZlxuXHQiCisgICAgICAg
ICIgICBwMCA9IGNtcC5lcShyOCwgcjkpXG5cdCIKKyAgICAgICAgIiAgIGlmICghcDApIGp1bXAg
MmJcblx0IgorICAgICAgICAiICAgcjggPSBjczFcblx0IgorICAgICAgICAiICAgcjkgPSAjMHhi
YWRjMGZlZVxuXHQiCisgICAgICAgICIgICBwMCA9IGNtcC5lcShyOCwgcjkpXG5cdCIKKyAgICAg
ICAgIiAgIGlmICghcDApIGp1bXAgMmJcblx0IgogICAgICAgICAiNDoge306IGVuZGxvb3AwXG5c
dCIKICAgICAgICAgOgogICAgICAgICA6ICJyIigmZXJyKSwgInIiKGkpCi0gICAgICAgIDogIm1l
bW9yeSIsICJyOCIsICJwMCIsICJwMSIsICJwMiIsICJwMyIpOworICAgICAgICA6ICJtZW1vcnki
LCAicjgiLCAicjkiLCAicDAiLCAicDEiLCAicDIiLCAicDMiKTsKIAogICAgIHB1dHMoZXJyID8g
IkZBSUwiIDogIlBBU1MiKTsKICAgICByZXR1cm4gZXJyOwotLSAKMi4zNC4xCgo=

