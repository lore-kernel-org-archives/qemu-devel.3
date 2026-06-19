Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF40BCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifQ-0003qb-7Q; Fri, 19 Jun 2026 19:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifE-0003mQ-UE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifD-0007Oj-7Q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYd0t1253233
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=ZrNWYo0pN/1yh+Xw
 489b07TsJYIYWbfUnNNqEU6TR4l8dq7CZbo99Yx0VB9EJQMod79WhC+sTcpgd17k
 s91I5ha4nuVSLKMdeIPHwbCKenDTopFvsHdMcKn93OfJ+nO16KFJbC0/jWzVqagV
 1LjQ7oWd64o6WUEx2kJRNE68bActDRe92tZcMhdSG5xokqjo1ciTiIJy4WUeYs6e
 ULDxLbOLlEr0qKo7S0P6u59KD8mG/3SZBi4UQqd0JBL5+mysGLMGVLXMq1dcCt1y
 LBW6IYe/zWEzGtP+5tLrLjwb1IxsrkZASAqf/1rjOie/YrB8OBhymFrkYpB7ANf4
 vhrd+w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8q6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:17 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-138156c0492so8941761c88.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911817; x=1782516617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=FY3wSx/+u4vxg8YcbYXG8f1Al+Lk+eINZ/IO7+43h7oURkmkhrj4TR7xuUztwTfA2Z
 0DAG/4J9rVdG7dS/MUypNgbf9dU1OR+Vzib2tuMvjhiw+2lbwQw+F+jIAfP2oUYgue5v
 8Dbig+5M4hHG1ITC4JLL3ngLC6ndbfN9taom9PBnsxjptFZ0vmWoWhnuDiJzWnVLkNtw
 hXt+pi+dW7PS1YJfsB9nsKjNuA9AX5dMC6iiZ4+GOuRu1fqI9QOlYKQPGTITsWug0bps
 Q/SYr7XjjuOy6T5epEoF0Xq+6JWjZUYXOAQfvdzARyHkSBZMEpjxEqhOQyBXwZMk2NZA
 youA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911817; x=1782516617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=Q9lb+ym4jKG12i0A/jNIiQudwLGrG6b1NFmypR6wxAjDGP66M59U/v9dClbKqGFoRs
 sq+v6bcAzT+LPaVK66Pgox2V+NPHdhO9rbT/MF2+18vaW/xEKPKkGVzeA8lnd0yhkYdT
 EA7A1VVYDUygSKJwO9uP1ONVfdq0OK4bwfn0sLRRHbwGelfLpWJz7eoiP2EQsrDK1SaZ
 CzR7sD04Rkn75orv8fdRFD9ocQz3jIWSxXHieYh7Q5g8CjhGpy89zzE4da5oaUMZt6+F
 BqAw7aMex7MolxhqsTeZWPOW/EAbX6j+J2FD7pncqzlI8DfFOL9MCzeIJemPyXPisdtA
 VEag==
X-Gm-Message-State: AOJu0Yyy9+9jAPeKZDvXFJyG3G2HtwOKVWzHEaEo61CcJiGNdrxqMpFd
 F9NHtlXYG0QBi4dkLMxzjOdvbkYIJRA7v18aMvaVKvjEFw/plH1s6QQ7NAGv30Y2ysUaCtBsfzS
 96dp8A4nvTMyyZQBQYDHYtk8sMDe52Ws2rmazJhGNms1p/M09SwligdRvkxNPwDZCZw==
X-Gm-Gg: AfdE7ckCGDwg4DlhhtZJENwZIDrFL0UoCkrilfJK8Wf9eVzk3qx93ouw45tBsB1gVYC
 FXocM3x9T4Shxb3TA3s9SDLYC8Pz1tTbbMEw8ZB79ZAA1D9tWexQoWyAutCwhB9bnCFJjYcE5pH
 T74vvueki0qiuDop2gBxSy1YiuVh5KeHc/uppwSqzGQkAA2pKLzSnOWcN1UlwF/lrA39iOz1V+l
 Nh1uzAjWxllpngaKCkYJBSUYcEMtXxkH3ieW2KPwVSEi96KcMSbCiSPiPkcSkSOhAoHsuuQiHCc
 Fvp0qsi7P2wwTwv5XHhqFZn4bcvQNSL+yHu44neCTcE5CyR7QsFaHlwSJiXmoePzs+EKoo0obPY
 KmNRm8yGjzyzwmt2H+QiIU7O5qHNBGldrPtPKby4ZtfWZZNOe9Uu0h6XOtm4=
X-Received: by 2002:a05:7300:80c9:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-30c0cd8b940mr3072204eec.8.1781911817075; 
 Fri, 19 Jun 2026 16:30:17 -0700 (PDT)
X-Received: by 2002:a05:7300:80c9:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-30c0cd8b940mr3072182eec.8.1781911816559; 
 Fri, 19 Jun 2026 16:30:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 42/74] target/hexagon: Implement get_exe_mode()
Date: Fri, 19 Jun 2026 15:58:39 -0700
Message-Id: <20260619225911.159473-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: qhItzqeq4zqvU19X8KYNiXgFJ_ysxIJa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXwZs2litz6ukW
 Kb7axZTpN6qBgbMzyFy9kkPPd8tffFpAJ+W8wT3xanIAcCCjW1+kQAwYtriQ0XIZNADrvdKIItS
 tW66dJSWjd1m/pArkeCDkDJITKWqfyzqiEouVvtRGJpv69tV9rK1kjsY1/KBwYWyfCiTg7ug53S
 I3uoRSRzUoNysNw8kMBVyHRPgJ8v+c3Ds2i2vygbmtDdNblcrQcGc8vkzQ9xHIwbkCUfRNRQH22
 UU1IdHa/JXWWvu3/4ZJsAdCMpnuhknQMJg3NWD09Nhjl9JUUNoNl2yDoOENx3s8TzL0gMIGPqPx
 65q5Nq+MtQdyv/bUMnhnPG7imkrBPXGEqksFdxzt6CJkusZ+iAFYUV54i7WjZmoQ8wviIU1q9CB
 17dXVB+hrM8x+C56J05tcsEDWrLTszD/7Zw0yON40Mf1N2BNhnKSPLBkSfRF6aLnf2qQYafSQLk
 Jx33zNdJaUJlMBm+F3g==
X-Proofpoint-GUID: qhItzqeq4zqvU19X8KYNiXgFJ_ysxIJa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX/jRBXd3RD8Zm
 2cMmc+L9YY2B/5D6kt1b4dY8FhBlqz1dQ/sOnuc5lNBXbK/Vpeb3K8gmRCjqBBX6Ah3ttNtRh+6
 9AV9Fll+ALFiG4H8UYYYjRI3L8WPXcQ=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35d109 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

