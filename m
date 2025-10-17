Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9496BCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rPt-0004Sj-MT; Fri, 17 Oct 2025 16:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPi-0004Q7-He
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:51:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v9rPc-00031T-Nh
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:50:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGLAm024075
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WZO9CO9qWm+jy/yPd9QqQbX4TSxkiOoUPndczWNuyCQ=; b=SnOnPNdndiP12ssl
 5HlLK9DD1WjS2IbnUWKCdTAn4BYQjd7YaS4WZ1Nnvge9JQnad7PL7Eh+07KSqVmQ
 ifJYYKo7CUECJ23Ga6uAyL+k/wO+PRav9qDl87BWhYDZlSanyuMUVRwa1Qrydx6H
 vI5D9JjBG9mKNekO3NTtiAgGOe3pNDb5JFugsc9EYf22eXRXFBn2GlONNGJkJhFV
 WS3e6pvSa3ym04SHica9IwL5K7S6z8sra76taPIy8j/apwG7ExEeMQYIN+Ed9YDn
 Om6AW3arBasUkRvUaZ0V8m9z972nqO04aHim7J4x9yB7ZFfzWWx065RQORqaDpTN
 GuX9yQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpq34a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 20:50:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7a144677fd9so4173474b3a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 13:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760734254; x=1761339054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZO9CO9qWm+jy/yPd9QqQbX4TSxkiOoUPndczWNuyCQ=;
 b=suK09kbc7EesYgmojmXOu8NsQIT2Uc78JKdmS41MYn+GyjUAdI0mi1Gi2AxOX+Qcfz
 5v1XV5EZTXaZwAr55ZrdeKEGLOgsqi5cjALzGAqk6vCb4Vfr/fe9smhNZNt2WU79nrrB
 p04SMxEdkE/Vv0pblSVTpXJt0hQIFpUQigMvr7EGrFsGRDLza0StG3rR/HZRHHYdmMxq
 Jt4J7ziBTj6UIaG4uZazEOi4QwNtC/AKT32/pVz6klln50yvR3nq7AsND25YdsQk2gcs
 cZohx0TmJo/SI0FxxQ2ik+bUR3IZkkXo+i/qJfL2iAdQobqVLOI/PoB/qhX/zVU9RJ1f
 rv6A==
X-Gm-Message-State: AOJu0YwZPsaFxZcgG7N2uZQAII04+1cGF8IvzkNUnxv21IhX1hTYr20M
 HVJ4YG5PqBbVK6WMC7tVFjMWIogfxxgXt17hB9213NyT+Y2e1SpwSI8hoY9fhknh5l0zjX5dMU7
 gw+aMePG/aMwSTX1BirBFRAWCFopmpxH77x4VT1EUmRdo1R9mTSri8QCvPjvPIdnhKQ==
X-Gm-Gg: ASbGnctwS/lWZqvqQDaXDLGWNhlXlW7Sxpicr0/5pMFSxwxK+m85y2+dFkykLZuhtQd
 hTXG1hGOfpJ1skNKrHIaZXuv+1FKWLWQbv+Q4l/+n0R22wWWVoIuDqlcImuQkYZl72vb4AdJKcw
 1+cDlcQ9gvg2qsJA54yM8A+K+/XyrBTOG7wcONHH3tMfeuXCedmjopuyX+3OWbBgPCT/dvPKx1P
 V9H6H3smgG54vFojJ+5hadUfjsHrwHWzHwPekSDKNpmapWpP2qTAEEqKyLvYzXXwOkrxICZF+f9
 723P62CEyvFUUFOC1pSFU4QU1047eyRRMNlE52D9UCAEVxbgrSnYZxjTksXevtvPm25YJmx7V+0
 ousF+eGK9/19hA0eNikaPY/rq6LbHst6vuE3XmLjhcbyyo2A=
X-Received: by 2002:aa7:8886:0:b0:792:5db2:73ac with SMTP id
 d2e1a72fcca58-7a220a91974mr5373732b3a.7.1760734254282; 
 Fri, 17 Oct 2025 13:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVC0q26KC77juyw6pH/SAi02ucIc3oGbeLeMh8FKGG6U0+5ZKpqDVQOoHwz6CUsT/vY9ralw==
X-Received: by 2002:aa7:8886:0:b0:792:5db2:73ac with SMTP id
 d2e1a72fcca58-7a220a91974mr5373713b3a.7.1760734253857; 
 Fri, 17 Oct 2025 13:50:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f251fsm495080b3a.39.2025.10.17.13.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:50:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PULL 5/8] target/hexagon: handle .new values
Date: Fri, 17 Oct 2025 13:50:25 -0700
Message-Id: <20251017205028.1105595-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f2ac2f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=G8g7tdY8SUdx2gpfVe8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX0NnAI0GgNC3x
 IQccUOxVxK6SSv5zIfvgOoOyNcUK3p/qTTAm5QdkyG4kJzgHltS6oDFb6OxIp3dBhRgf5cb8xk6
 wpqThlQ/egCMpgqoURBsI6PqMsO/skh3jwKZRB+nybrPlRCE12cWVsZA3VFSQZYK7/WmYBMdIw7
 F5Z8aMzNSOsqv3MdPp8UjP7h2kDpwM5fNc2jgwN33ml7yJhJi7PD14t7N2KSDvWrHyhUkRr0IpI
 7zWxrQUkK5fgZGEAZuboNcsVt5CD0TxkBqI+ZZQ3eH9HB/G+CEjNJeWmJq5i+RSZaIMBldq3moY
 3UnvVKY9OuUjEpWdRrWdzmbZMTVrKC02e4zWsEJBxw6WoT3jFqkVuKtqAc4Gr95TmtbrsCabV/R
 hpFcvvroqUNa76iOp3lsj49WqgKudg==
X-Proofpoint-ORIG-GUID: vq4fvKCcG2YGt7ERH8F8qwm7D5B-OZhM
X-Proofpoint-GUID: vq4fvKCcG2YGt7ERH8F8qwm7D5B-OZhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017
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

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJl
dmlld2VkLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8bWF0aGV1cy5iZXJuYXJkaW5v
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IHwgMjIg
KysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggNzU4ZTVmZDEyZC4uNjgwMzkw
ODcxOCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJn
ZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0zNTAsNiArMzUwLDcgQEAgZGVmIGhlbHBlcl9h
cmcoc2VsZik6CiAgICAgICAgICAgICBmIntzZWxmLmhlbHBlcl9hcmdfdHlwZSgpfSB7c2VsZi5o
ZWxwZXJfYXJnX25hbWUoKX0iCiAgICAgICAgICkKIAorCiAjCiAjIEV2ZXJ5IHJlZ2lzdGVyIGlz
IGVpdGhlciBTaW5nbGUgb3IgUGFpciBvciBIdngKICMKQEAgLTEwNzAsMTEgKzEwNzEsMjIgQEAg
ZGVmIGluaXRfcmVnaXN0ZXJzKCk6CiAgICAgZm9yIHJlZyBpbiBuZXdfcmVnczoKICAgICAgICAg
bmV3X3JlZ2lzdGVyc1tmIntyZWcucmVndHlwZX17cmVnLnJlZ2lkfSJdID0gcmVnCiAKLWRlZiBn
ZXRfcmVnaXN0ZXIodGFnLCByZWd0eXBlLCByZWdpZCk6Ci0gICAgaWYgZiJ7cmVndHlwZX17cmVn
aWR9ViIgaW4gc2VtZGljdFt0YWddOgotICAgICAgICByZXR1cm4gcmVnaXN0ZXJzW2Yie3JlZ3R5
cGV9e3JlZ2lkfSJdCi0gICAgZWxzZToKLSAgICAgICAgcmV0dXJuIG5ld19yZWdpc3RlcnNbZiJ7
cmVndHlwZX17cmVnaWR9Il0KK2RlZiBpc19uZXdfcmVnKHRhZywgcmVnaWQpOgorICAgIGlmIHJl
Z2lkWzBdIGluICJOTyI6CisgICAgICAgIHJldHVybiBUcnVlCisgICAgcmV0dXJuIHJlZ2lkWzBd
ID09ICJQIiBhbmQgXAorICAgICAgICAgICBmIntyZWdpZH1OIiBpbiBzZW1kaWN0W3RhZ10gYW5k
IFwKKyAgICAgICAgICAgZiJ7cmVnaWR9ViIgbm90IGluIHNlbWRpY3RbdGFnXQorCitkZWYgZ2V0
X3JlZ2lzdGVyKHRhZywgcmVndHlwZSwgcmVnaWQsIHN1YnR5cGU9IiIpOgorICAgIHJlZ2lkID0g
ZiJ7cmVndHlwZX17cmVnaWR9IgorICAgIGlzX25ldyA9IGlzX25ld19yZWcodGFnLCByZWdpZCkK
KyAgICB0cnk6CisgICAgICAgIHJlZyA9IG5ld19yZWdpc3RlcnNbcmVnaWRdIGlmIGlzX25ldyBl
bHNlIHJlZ2lzdGVyc1tyZWdpZF0KKyAgICBleGNlcHQgS2V5RXJyb3I6CisgICAgICAgIHJhaXNl
IEV4Y2VwdGlvbihmIlVua25vd24geyduZXcgJyBpZiBpc19uZXcgZWxzZSAnJ31yZWdpc3RlciB7
cmVnaWR9IiArXAorICAgICAgICAgICAgICAgICAgICAgICAgZiJmcm9tICd7dGFnfScgd2l0aCBz
eW50YXggJ3tzZW1kaWN0W3RhZ119JyIpIGZyb20gTm9uZQorICAgIHJldHVybiByZWcKIAogZGVm
IGhlbHBlcl9yZXRfdHlwZSh0YWcsIHJlZ3MpOgogICAgICMjIElmIHRoZXJlIGlzIGEgc2NhbGFy
IHJlc3VsdCwgaXQgaXMgdGhlIHJldHVybiB0eXBlCi0tIAoyLjM0LjEKCg==

