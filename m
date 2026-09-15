Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF279C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4a-0006NF-8b; Tue, 15 Sep 2026 12:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4P-000647-P7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4N-0003t1-8G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAdKL2836564
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vLaqIhQngXnaflzIMte6PhwnWM1y756KZYKftZcjSL0=; b=YcpNGznUUIy3s+v0
 KcqkGoXTBd9boJo4l5RhrKXPg4yfcPRjQnY7mSLB00k9qpiq/fYYb2ojHYQibn5u
 UR3MRW5AOWDDnwwp3ZSkWYqPJtQCmUkZT8Lt7hQewY6TAJGd8QaCuvO5mIaXEEGW
 FHGFX+otmvLHnH5tV0yXefhoRwVVo36/5zw2B4loMi0hSOmqlBnvGAqtvok5wCsu
 8sk3Rau1/xTcwjY4nweTlUi37qCLDjk1dUJGYdocuH/2gcVKNNsopgZpKRqVhcBT
 f0TqSDedo7RXNJPBGbExUtqDSCIav1aeE7QRmAxy3+si0TO69kmBefi9y68hGwMC
 6efW1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq1qpaypf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-395543dc382so6297187a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489891; x=1790094691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vLaqIhQngXnaflzIMte6PhwnWM1y756KZYKftZcjSL0=;
 b=hvHWQccjbV1ir7qwDLYg4rglKMaOOJCjs70MK6C3wNK4wymh85BcK8dnnyvXHLyFOh
 sQWdj+90CVS0RbmZOzDh8ldD9nXb5sRJ1oLq/7GAKq8edwrIMPRzbF1fDqdszJiYOS08
 +yZSCHoJ5EXhzTlmN+f039GP8q8JL62xYeK7IpcI6jfyPvNF3k5NSB+XPZODTMuxJVul
 9HDqsS5pdmyloZDqvnHMtafJ1cINY905O/Uz3Rs/z7jxrAL65Ks3XIcYnBgQmTWyaWmb
 6LPP0T6kD7TfxzcNaf7BwolSBqOXQ+ZCe75CEOXpKs+9oa+DsbYsQ/Em7wlA6SoPUSRP
 u9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489891; x=1790094691;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vLaqIhQngXnaflzIMte6PhwnWM1y756KZYKftZcjSL0=;
 b=FyrHuJNYcGpbJXc/MKZB3q29/i4W+nv3+hfmlMrAUkBvdKb96VbE2HwAf8whQ7pFha
 EY8Pbz9obavB9dwmQU7LdvsJzQmMHVithhEEGVmtbvlqJ28aLRPTJfy0GswaHG6wKGI0
 6UIanOmLB7smPwe524Owm+cbdf6w0MzJ4VuI2p73KpZZ6KaHBu/AzJaJKS3r4xyV+3OQ
 j1JngcktEyNM7XqM3yy9aF90T3rWJC+mByrG/vS5OUH8pkdBPGDZN601YchgXQf0IkjX
 1wmTCEEE26ppopx5jWyG6ecZXg6diG9kDGoGZLBKK37MXq54uzziD3qj52jP7X/0EJPW
 FMQg==
X-Gm-Message-State: AFuF++ng5Q0gflWJYaeClbEB3bGdygLsv66CdEmXD/XjVOAd+S07jn6L
 s1cnrXIR2lCz8y7hyleeElbR94MqYLp/dHtyUa1o2N3Y+vIIY2ZJugOv9uLIGQN3ytoZP0l/S/x
 9r9hNipHW1pUgPRJd7RcXCLO9tj6OGm2nnhTO5iD3EPNTsfYmYKGRNbd8XbU2zYI6KQ==
X-Gm-Gg: AYBFou2HE+DsAW9pXseY+4ID7aCo1le240SCl+1DtT2mBiD9/jilIE21NLffDbU4DrO
 BfzFPrNZV9DyDrCrHArOUfusCKF0x/jP/9bd5payEGzX6lMGa2DapW585qSUZrBVFXfggI57Tw/
 52OX7/ZllLQYkaryIh9yfq8T/0ZM/n6n0OK2/f/7KvXBNvjtLLtxU1f0sAyflQaBZLxqTwMejYK
 pBmYrbTkqX4tUXht6wLMoqG3cFJgZoy1KAWg0Gpams7S03KF6AD5rs7wsW8pgHk4WO23pRtJ3iY
 qA4PgJwaKvBauOtE3PQXdXcpzgTAcM87vG0JUUBXART0I0BrFzi4DLIbyXfx07NWShFIz7M2Hlg
 X8H9eykfcrDtLbcTNb9mkSy7spmEJxu0BWzEQ5xqUKFZAr/pg
X-Received: by 2002:a17:90b:1c81:b0:39d:f66e:1720 with SMTP id
 98e67ed59e1d1-39df66e17d0mr13755774a91.13.1789489890661; 
 Tue, 15 Sep 2026 09:31:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:39d:f66e:1720 with SMTP id
 98e67ed59e1d1-39df66e17d0mr13755652a91.13.1789489890069; 
 Tue, 15 Sep 2026 09:31:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 17/17] tests/tcg/hexagon: add decbin MPS test case
Date: Tue, 15 Sep 2026 09:30:47 -0700
Message-Id: <20260915163047.4180600-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX6oSnx0aB5ztr
 XYTBK/y3nl5E0sShydgtvIzT6sHZlmScDHjPEqrnpR8SBQOfY2EtZx8gNMkqAioQprhMv3P1gVk
 ot44ZowQNA67STu5XXe2Mzk6PvMpeKI=
X-Authority-Analysis: v=2.4 cv=I4Xw19gg c=1 sm=1 tr=0 ts=6aa972e3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QfmX1zfwqVA98Td9WrcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 2SunhXwzjYk_rvgbPOefAtgSnt-sz2AO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX4iZhBSgkUn1y
 LtbNnQx3/ofuGHqBzrStSXbTbq6E1itVf7qE0I1AUZlUxAr8EGN5QS37B6p9TBfoKanRawDfoVS
 6q5ulfyele1SP8qHX0vAjfsGAZsyoizEFm9FAMw8pQpjO6RCCPwQA5cuASPOU2jHkGwg9BprtbY
 RdNbAkJboFDtqiN377j1JHV0WUiLgN+oESxwaM1gghldby116sa6fWKItJxOS/XQRCOdjo5D2Vj
 O+79Bk5/wYysgaAbmr/e4TZ3lfWpO9oHVE44r9UkH5Vx2l+mtP0aehyFIIPpn9Tk6FFN+chkEs8
 wUG482BVyhw7Td//F96E1gaxq4RNzK3Qgit0pTdc1HNXzx6gT+3X4vH3zSaVZMa5CWq96STu82N
 n6b7p2Vva4uDuE5PmKaNlZi19veZEVTzbGjG0g5UUXzQ7ZvJkyoHVKKID/V5hK1gBq3E06pFoVD
 UNzzVwrvB7k+MbNUKFw==
X-Proofpoint-GUID: 2SunhXwzjYk_rvgbPOefAtgSnt-sz2AO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150239
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

QWRkIGEgZGVjYmluIHRlc3QgdmVjdG9yIGV4ZXJjaXNpbmcgdGhlIE1QUyBjYXNlCgpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vbWlzYy5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9taXNj
LmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKaW5kZXggYWJiMzRhYjZhNjUuLjA4ODQ1MjAx
YjU5IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKKysrIGIvdGVzdHMvdGNn
L2hleGFnb24vbWlzYy5jCkBAIC01OTksNiArNTk5LDE1IEBAIGludCBtYWluKCkKICAgICByZXM2
NCA9IGRlY2JpbigweGZMTCwgMHgxYkxMLCAmcHJlZCk7CiAgICAgY2hlY2s2NChyZXM2NCwgMHg3
ODAwMDEwMExMKTsKICAgICBjaGVjazMyKHByZWQsIHRydWUpOworCisgICAgLyoKKyAgICAgKiBU
ZXN0IHRoZSBNUFMgKG1vc3QtcHJvYmFibGUgc3ltYm9sKSBjYXNlIGluIGRlY2Jpbi4KKyAgICAg
KiBSc3M6IHdvcmQwPXJhbmdlPTB4RkY4MDAwMDAsIHdvcmQxPW9mZnNldD0weDAwMDAwMDAwCisg
ICAgICogUnR0OiB3b3JkMD1iaXRwb3M9MCwgd29yZDE9c3RhdGU9MHx2YWxNUFM9MShiaXQ4KQor
ICAgICAqLworICAgIHJlczY0ID0gZGVjYmluKDB4MDAwMDAwMDBGRjgwMDAwMExMLCAweDAwMDAw
MTAwMDAwMDAwMDBMTCwgJnByZWQpOworICAgIGNoZWNrNjQocmVzNjQsIDB4MDAwMDAwMDA4Nzgw
MDEwMUxMKTsKKyAgICBjaGVjazMyKHByZWQsIHRydWUpOwogI2Vsc2UKICAgICBwdXRzKCJTa2lw
cGluZyBjYWJhYyB0ZXN0cyIpOwogI2VuZGlmCi0tIAoyLjM0LjEKCg==

