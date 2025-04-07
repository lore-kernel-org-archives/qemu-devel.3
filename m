Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6ABC36018
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 19:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1s9Q-0002Q0-Vc; Mon, 07 Apr 2025 15:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7q-0001gW-UP
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1s7p-0002k5-Dq
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 15:27:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537IWWll003197
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 19:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EiQbG6U0f9LHetgnzek7cEGoKXSJehnEfH9Sv/+XjQc=; b=AMSMyOLku/cP2X2E
 irLFliN9oXlHn5z5cz3o2tGQ8FfO9QSApF31wbGFD9bRePiFHp61eldfxn+jQYKX
 L/KObS0eSuc/5r0DXgP8wumOISpGoUuEVFdpPbmxZna8MqI7JkpqRZ3yGbbM+KSa
 3C6BBrF3emWlhP0KYzI5oi/75yQxX4H/S/31QhzBQixCCDg0auzusPyi8C6Ipl0l
 lh6bHFEsv808TV0zfA4PtZ9VKO7p+GXryF5e6uZ40xweSCRxBRRrSIMGzUcelmAo
 NJlWNoLv4Vm1GLAD4NIRJGbnXzk3y0FbrFPhd1wiwEuXKWpbJbqOVYI0j4D5Wjlb
 cUSQVg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftd9ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 19:27:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-736c1ea954fso2479303b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 12:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744054035; x=1744658835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiQbG6U0f9LHetgnzek7cEGoKXSJehnEfH9Sv/+XjQc=;
 b=U5HsoskgzD4ZPM7g58SQudReYvywLjlg45U3U6yTo5uiz6NAic0LeYnQrU816nviyx
 oe6m2Bd5bGapKdBRH77ktq5VAG39IfGJuCYOIbid+rqO7lkbpOZ09XVcMT4iVdejoXIu
 cRXOcV9GdmpfzpTpRWjwIs5JhdAhUfdSxiy4vyJ0BB/vqZ/TE5Y1lNJtwdFVjMRU7GcQ
 LDatqK8Wk11rqyRanPV36etaYlWk4HQGlnG3qmNiUzEIXaaTX0Nu90rQawmJAffbb9rI
 RFAm1BcuK+jJAfjsNBpRbnjHKm912M3Dn2vALmyT5Vd51iyDGQaGF2UIG4zxD+oFEHWk
 RSFA==
X-Gm-Message-State: AOJu0YyfmRKOK1utt7V1YTjjf0wUEtF4knN3UP4+ApgPc9qLcP4imN/c
 bGlyw0OQu35U5CgC9VvL99RK4okjQUVddGX1TDJx3aFy5tN9Tlu3TRe+Vr/eqiQbSCQTZMS5U6G
 qEs3pZMsDaeF+gX2fxN0DAEu/GF2Vha4qwp2/ZwSxbXtNxI7kh1U+zsHep4AeUA==
X-Gm-Gg: ASbGncs4j1gRGsEVMJzmSWqxtnBFNh0ZRUfauls7236nPZsXOHY1dHJSM/kjskiWY+W
 auDKvzt9vfDEQWDowEWICpQ1kKnwY8zfhWWF7QMfJzqZYxtKreKR/dvXRiBwooisIjUgTAbT/KC
 4KVy8vOMupjAGqSC6rCdk6U2K2ym0ioH0+iBQuZyFNqBwKcUIpJFmCilap838xvNPZ69YLeTWYv
 OIzYaD8LV1P+MtYv2tJuv0CvKQoVXWKRXEKPaDR25TCh88kUPAHWJ9PMNK3n3P2o7PbPpQ/dwQP
 kputvg+LcWvj0pdEe8KG9hos8plkPugS+NBA82WzOqthHcSpGzire5aMwioL1bLu
X-Received: by 2002:a05:6a21:6f8b:b0:1ee:c8e7:203c with SMTP id
 adf61e73a8af0-2010462b41bmr20268467637.24.1744054035018; 
 Mon, 07 Apr 2025 12:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIGhndqzz+tHyBE4738BQOag9UpQQ12nP6wp7LGR6zXt1LwL7C65Lvuj3hcmZSbMuFQFMdug==
X-Received: by 2002:a05:6a21:6f8b:b0:1ee:c8e7:203c with SMTP id
 adf61e73a8af0-2010462b41bmr20268434637.24.1744054034719; 
 Mon, 07 Apr 2025 12:27:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee619sm9206559b3a.52.2025.04.07.12.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:27:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH v3 2/5] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon,  7 Apr 2025 12:27:02 -0700
Message-Id: <20250407192705.2605614-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f42714 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=HN0uuiy-se_EESAQhN8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: mc3qeX8jepC0BkLqKC21DAOEW3vagBkj
X-Proofpoint-ORIG-GUID: mc3qeX8jepC0BkLqKC21DAOEW3vagBkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=905
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070136
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

VGhlIEJBRFZBIHJlZyBpcyByZWZlcnJlZCB0byB3aXRoIHRoZSB3cm9uZyBpZGVudGlmaWVyLiAg
VGhlCkNBVVNFIHJlZyBmaWVsZCBvZiBTU1IgaXMgbm90IHlldCBtb2RlbGVkLgoKU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCmluZGV4IDc2NmI2Nzg2NTEuLjYyZjFmZTE1YjggMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yMTYs
OCArMjE2LDcgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9kdW1wKENQVUhleGFnb25TdGF0ZSAqZW52
LCBGSUxFICpmLCBpbnQgZmxhZ3MpCiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIGNzMCA9IDB4MDAw
MDAwMDBcbiIpOwogICAgIHFlbXVfZnByaW50ZihmLCAiICBjczEgPSAweDAwMDAwMDAwXG4iKTsK
ICNlbHNlCi0gICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DQVVTRSk7Ci0gICAgcHJpbnRf
cmVnKGYsIGVudiwgSEVYX1JFR19CQURWQSk7CisgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1NS
RUdfQkFEVkEpOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ1MwKTsKICAgICBwcmlu
dF9yZWcoZiwgZW52LCBIRVhfUkVHX0NTMSk7CiAjZW5kaWYKLS0gCjIuMzQuMQoK

