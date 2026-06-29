Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C88C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnM-0004Q7-3Y; Mon, 29 Jun 2026 09:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnL-0004Pv-7T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnJ-0003BF-Ps
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT6pa2618925
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=; b=HU
 o2eaH+rN1wlJ4HJpE1lRYzJB6hyJi84PPSCmRrG7ZQwzyRm+46vIRVPxO0obviCw
 vc2g4rFOUzOkyW0w7uFK5gUNhlQaRpyE29WhKVpWfO7A3YwgHx7F1PnJA+km/sYQ
 6N3n0r/9KD6Y0k9m9OExHIifjZG1/OKF6Fnq7ZBVUAMHjb/QgufTGvSYKCL4e9e1
 YAKkMNSiVMs3s6MPckroudmjGdgbQluT2E8YRqux23vufMahrpRB9qCQOG0B6125
 +WMMWPtY1agKGWF/eMj32pmqNhlgVLiK9CXo/3aUyTHLVNbvg3cGUtEY1bib7oDI
 B+6vET26jxQe2H/5K3Ow==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrr3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:00 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13b0686d13eso1426326c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738780; x=1783343580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=h7P+LT399lQ2J7PPeAiULTAJVCjWjpnlPHAJmHqU/ODP17yP3VJAjA7VTxI0Cr1tuh
 lRtH/s0wynA8ATv43/if82eZ/LD3XWLjWZkiXpKdoA0Me7W0iBcDDEMvQTNdk1vwLq46
 DyeoD1ABMG/GJQQl7hV8/WvP2mClm4Sdx8gA1lcoTMfjbANkreKY0Hpb6f6Ulje1b9iL
 uwVxKfUjTsXb8MEp1HFayH/1zT3gaF9VynF0Ynt61lxw6x/rsfzwSdtevHCKTZpUJUbb
 YLU3Z8eabEzabDWYXAcO6CcBV7bksWyz2ThqY/jd0ve5XAzl1nqQqJB+0CShwcFdowpp
 idCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738780; x=1783343580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=JnaJZk1aKn1zcB5HMifqVhXIjos6SEAyi1s4icBTyzOWPgDoaX9YpcI7VMZBCyyO7Q
 Emyuqgq+WDpx224xiNUb/c86W9CE8gOSCCoYcPFMc/d6eRmuky8vQ2nsmOkrhuOQiqnA
 kt5opR4CPsqZOjmfJNfqRfpokQ7223xXUQnAJMkemDdeWa1gixY2mfgtmNr14FZlhgQm
 RFkunEYVZsB4nP8oFpeHfQjNVf/S7eRNUdXXsMMD0azBNGkh0Z66sdiFUQeisTfM+KUa
 YIuQhf/grX8xXZbFUe8+tbqDG+H2Lsp/wDMpOr4EiC8BHbGNJuAJyOX7GD2OVWynKpj1
 Rzuw==
X-Gm-Message-State: AOJu0YyinYHO4205R784Ms6A0sK+T/L5msxSGke/j4NuTBHMBcoy+QEq
 Irg4/quRl0vUkZzEhaZWBDPuL7rIuuTj1sZy7X32vsVUa3kEx+LW3xknyUVZVMDH+/mK/PpXoPd
 mznsynJovhHIucBC7cPGnhit43hAx2dFQpo7FznEYNl+LOWXgn5iImWTarWENh9YKKA==
X-Gm-Gg: AfdE7clqXpmzUQzQBR57WVnEJCXoxOVOM/cqonUdND0gpSyemIFL2jVXfxEbQbJMQdQ
 O9h4ljdu0K05pA3kKTEysmOmWJrP4h5n2rx7ITv9QdfYNvuN/ez9PblMiayfX88BiC42vzoCQFK
 JaAzRpQo9PzK/jr5BhmAq+xElkGqgIIm7HuCshJ+xMnlePi7VMGdCTalwSb2LA+a8faIgWZHeFz
 2dPgplb88v0X5VuMESXn8UHzOizGtBDRGqIQ/7wiN3KjXj9aqkZR3+563wQ4rcjK7KEU0Z+EcSL
 fPCRosAWeT4APb6ZjsswYLYZjXoCzghtQgvQbULRvFDvJol3wdy3EndNkTanUKKe/yDYTStRcJI
 kONmlwIMG6lldG6f3BaSjqYdORGDPPG1MO2G/Gyx693c+xdSPpVOEigrKs70=
X-Received: by 2002:a05:7022:21a:b0:139:f749:b077 with SMTP id
 a92af1059eb24-13b22731b49mr492509c88.43.1782738779966; 
 Mon, 29 Jun 2026 06:12:59 -0700 (PDT)
X-Received: by 2002:a05:7022:21a:b0:139:f749:b077 with SMTP id
 a92af1059eb24-13b22731b49mr492477c88.43.1782738779423; 
 Mon, 29 Jun 2026 06:12:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 13/77] target/hexagon: Add a placeholder fp exception
Date: Mon, 29 Jun 2026 06:11:28 -0700
Message-Id: <20260629131232.2487780-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a426f5c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: oC95Vu-CAIZsVEQxNuN3mn_fy4CMs61u
X-Proofpoint-ORIG-GUID: oC95Vu-CAIZsVEQxNuN3mn_fy4CMs61u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX6AwZQ0Sbs3sC
 n1WBktYu1NL4MpX0sBZ2HMh1DLMDVlVF5rg7IwyZdFafdPdKkApvAPfVpV6jfIeh4D7C7a1URXI
 5yb8oHYDSt0wBCYlp2t9n4VyONh2IXMH/uuiwUrbXKAZjw7MY28Mp+WnMzoC42nFij0mPlthaqg
 42KFsoWazxo0Z8F3jsMjjfWqpMsfz/2JF+hPxiMT2rfrERhPZP+8z7L9BrKpqB5PyAmw62NctH9
 7AlvRJx90Lij1C46zregZ7YfHUIIMoRHK79WJAPG7h3XCN+xjAag9wO+kDJhRcmzmTQ6tGRTA3o
 4Of5Vqo7xPzZD3k2DEuoNi2n9/YGkb5nzTUnw8TTpivBrH9DEm9r7IG5ol+NUo+jzvAsdiJA8sA
 aELsrRX0kZgOjwcRGrjRfUgBgSh9ezrc2EuKjJX1Eie7xNaaRXzeupSgBIlQ5UeVvP8oDHTaCYc
 NedzlysP2Jn47/STZDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX6n1yyeH6MweA
 20fJViXJbbpKreeJlfifJUGy61bVc0C2DH0zy63RvPIlaXtBtll0tU9hWK0k9oxAu9NGV2uATal
 CDF7clf7I7ziEKQtusVfNmsIImiMww8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

