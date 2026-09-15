Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20745C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W41-0005w0-Hg; Tue, 15 Sep 2026 12:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3d-0005u0-NT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3b-0003lv-Lx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:30:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFATvn4176138
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zF7wNM0uK32PaFnM0cjYMMOMVW+Srqc+PhvZl4ELL8A=; b=B3ehBxub/r0elv+J
 llZxyEYBzR+JHq9BybRxAYsmYiEIcLU5d2QgAWN5+R1u1plqNdNdX4guABjphtg+
 OT2eCZEo2+4Bg0b5gqWF9SpmALSzYqjNHIEQtOTWgXcpm3MmUchSjF6vmWs4CBgy
 r28QE2IgD+47LUlPHmk1Ki7kcONtsP/i8WGyrxnjqe84nMu2wBLqamS10e5fCWSg
 w8zwkqfOUIe5wgp8dUGu2G01jZKt/6UvEHpdop3Eq9Mbty2bO02cMK+eIeu7iHl6
 W+mi3kwU5/6D6MhNNi+aBqPfvrhWtf2UCat5Aq5fQAy54Mp3ebQdubwMkyDVSp+T
 pZE4BA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc2df4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39e087a18deso1363332a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489852; x=1790094652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zF7wNM0uK32PaFnM0cjYMMOMVW+Srqc+PhvZl4ELL8A=;
 b=IJY3GyjpvGsM3vq5FnsjM6jdLoL5avzy7VMGN7GVd9uh8Awb+rGD7xsz0xPZi9Ua3r
 QMmGcReADIyzoMcbnirbKj2tG7uRfEb+3SZm7pdPavL2naXj6uX9q+D38p6UIEbnmWon
 /DquKFmCL/nA4zdM/Nj0zx5IF+35RXgtq3273k9pDfb8l1A7awqSt1DuUgX8+UJtXZq3
 RyVQRJ8xEktrVpxThCnpYd+lBKAjbVqRSZWpZzXbjKTr3PNLK0jD/98YDlukGsohMzEj
 tuKXnNjgZfxHzL69x3NG3VILQTf8pR9QkW8VDy9qVkbpRmn929MFxQTd1m/bVUrHxqT2
 jIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489852; x=1790094652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zF7wNM0uK32PaFnM0cjYMMOMVW+Srqc+PhvZl4ELL8A=;
 b=OUgM7nPKqkC7ezprzHsWccHBNVPsrctPgcDrsR3YEPsOgDPgBxGwTfokZnx9ms4sIs
 eoO4NvW/GuhvNtIhKyTFoJFnx5q0E15w5+cWsTdZf2JSWV30bwzCO/oAKkTKRUNS24+v
 5fTOphor6pmBVVI/odRqJpirMXPpbz7x01M+uM9LL4oBrcZ1d8n6Zm525nNfNrBjGsga
 J9byg9OJrQZU5ngDyWBcnAAXofhdndHxcXp0QKrPE4S4sRdKfZN7/YelHTuDiRx0ursY
 Tww5VVZweotot6ejQKESqOvxRewPDLPeJImLuCNv4L+ZS/z2SNgxzyalbmqHNs0PePZ6
 9DFg==
X-Gm-Message-State: AFuF++k2dxdQyR9pCiHt5VjXbPxqV5ThZMCcH9QAFJmpHyoV8rnoQAMZ
 KyblpuRKXfO9IawVpZYsvhLGIvIhsLZb7NuJ4jSxss4jQ30XoFAiGg48GK4xWtm9hmWLf8vr+vV
 FshozwCB3oFgxjspNih1ADsVbx8wHXbexJBg9cpr/MrvvEmg00MquO7lbIlW8AddISw==
X-Gm-Gg: AYBFou0Zp1zLWTA/w7FIAvHt/N+arXe37A0BISefGe0/AJAoFerVqymDxSo+9MuZ9fz
 5VsUfLDIHylMDfY2DwhrlizbztPflHqxvhI9uVphRcYarCUedteFGvips0QYjVX5D6TQjBGbAOI
 Ze/vVzBgSdFMavnIr43BwVHbGjCCBB+CINIlQymdRcHxwcPmOC1qKN0kJESF366rq/JnBdxjhQv
 mdIWbbgoh8lNJJy7nEBNi9gYWsYDpK1Jk1/x0YbyYy9CgeTZRTeHOgAmRckeEKw/xmoud190ja7
 7KGVPUYTJFmuXfL563zizY4MfRD6afUQiYOFIQi6ZK0tIbqF0/gmIdyYdnLC++VBYkWbbbsp74z
 UXct3yFNwDnj5ACsXGSzqzJa9NnEyOL5GJzJtKbVM8nbfnQbH
X-Received: by 2002:a17:90b:4b0f:b0:39d:f4fd:8075 with SMTP id
 98e67ed59e1d1-39df4fd8118mr12196478a91.19.1789489852387; 
 Tue, 15 Sep 2026 09:30:52 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0f:b0:39d:f4fd:8075 with SMTP id
 98e67ed59e1d1-39df4fd8118mr12196398a91.19.1789489851836; 
 Tue, 15 Sep 2026 09:30:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 02/17] tests/tcg/hexagon: fix undefined signed left shift
 in brev.c
Date: Tue, 15 Sep 2026 09:30:32 -0700
Message-Id: <20260915163047.4180600-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Sgxl3LDCXBR00vgxBoFKNpzKP_I2xq1s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX2mGmHdrbPak1
 /81nzJ1wCJnmaqs1l8j+Nscv1kOQnEgdrXjUBNwSbygp/1BprUzJhZZtdoPd4tIgAeFRxDPDxU7
 6xrakBgIiZszylf2+c8o82WvVh/m3No=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa972bd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4mfA0qixJg5lnvjYkK4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX5iwg521T45I2
 puAT+Pjl9+TvN7KWV57YGbKBWeOsLZS38ZgvmgYCZKfBt6Vp50Q+ZmCyh2VssGayQWI6RcH/8L5
 Tj3saZ+68XjSSbcMawn8ItQIR3j3t/mCUjyvfTjbPDnt3eZNIUZJTf89c/LkN8Mq/UDvrAy1dZX
 SfkDoZc7/uQ2q9G/JNvOkHKFpCy3TFg3Cva4qKdBfvv3k2y51Z0mYfLbdRAwpuLSmM/IxzH7hsS
 N4Jx0wILIHXpZmjbqUZId1qjGJibVEGmy16Rz54zLJGctnJhKFck6oPinPAtJMSYaW9OaAvtryv
 0DAlMp4ZXPXAufapgcp3HZM6dv2qkTuQsl8Aa5t6/KL1bhQy/OYMX3coEfeT4Eiy/tbI5saLTXl
 2zLtOAF5U8DMwjCE9+IeLmH3/D45vi/zSYMgHLFb4eJQ0wep5ADsBQOiiqGd3w6V3HdanV4WPAR
 FvVvsTX21RQ/rJgqrIg==
X-Proofpoint-GUID: Sgxl3LDCXBR00vgxBoFKNpzKP_I2xq1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150240
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

Q2FzdCB0byB1aW50MzJfdCBiZWZvcmUgbGVmdC1zaGlmdGluZyBpbiBzZXh0OCgpIHRvIGF2b2lk
IHVuZGVmaW5lZApiZWhhdmlvciB3aGVuIHNoaWZ0aW5nIGEgbmVnYXRpdmUgdmFsdWUuIFRoZSBz
dWJzZXF1ZW50IGFyaXRobWV0aWMKcmlnaHQgc2hpZnQgb24gdGhlIGludDMyX3QgY2FzdCBjb3Jy
ZWN0bHkgc2lnbi1leHRlbmRzIHRoZSByZXN1bHQuCkZvdW5kIHdpdGggVUJTYW4uCgpSZXZpZXdl
ZC1ieTogU2lkIE1hbm5pbmcgPHNpZC5tYW5uaW5nQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1v
ZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0
cy90Y2cvaGV4YWdvbi9icmV2LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMKaW5kZXggNmM3YjEzNDA4NDkuLjE0NzNlMzA5ZWUw
IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9icmV2LmMKKysrIGIvdGVzdHMvdGNnL2hl
eGFnb24vYnJldi5jCkBAIC0xMDYsNyArMTA2LDcgQEAgdWludDMyX3QgYml0cmV2ZXJzZSh1aW50
MzJfdCB4KQogCiBpbnQzMl90IHNleHQ4KGludDMyX3QgeCkKIHsKLSAgICByZXR1cm4gKHggPDwg
MjQpID4+IDI0OworICAgIHJldHVybiAoaW50MzJfdCkoKHVpbnQzMl90KXggPDwgMjQpID4+IDI0
OwogfQogCiAjZGVmaW5lIFRFU1RfQlJFVl9MT0FEKFNaLCBUWVBFLCBCVUYsIFNISUZULCBFWFAp
IFwKLS0gCjIuMzQuMQoK

