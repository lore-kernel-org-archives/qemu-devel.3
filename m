Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MKe2dqnY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cu7BcG0e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXu1-0004ma-PC; Mon, 26 Oct 2026 23:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtp-00048L-Eo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtl-0000DS-Vi
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F1PL4151834
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=; b=MKe2dqnYBiVhosf2
 81gVf0tdS1/ub9CkcKbcKDlMxL8Dm4OtyRr+PiUHNCH5pExPXEY41hYVxDol2REG
 glZPoJN2KCdFvd0PPHnxvWM2dpKpQY+zu8NCscobqRvL00nfkfhAUYiBFxJiGPSm
 EG4usfIkR3aRNbnwhNcSHlxrgNCAwjXfvrgFOyl1FYQIMPtHUXdOeG0+AlgVFElt
 cvHkBggt5q+1prU04PDgfDZVt/W/c4hHqWmhQ/a25PQaGLxgrK2OwkN7Q0tmmxue
 OizQm6ir2tJLzIpUZUWsCY/AeTizcWLURmZhBaMdUHrGrsMi32C4qLPmz7LdNQRL
 +M59bQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u63set-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so461718eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071849; x=1793676649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=cu7BcG0eWs62s/3U+hPqWCwfGTqqt/Uh9jt0y8x9JBdR+bPuNPaM2lEVXSpStY6vwM
 hCUmImiTDNPeyzYtT2MB4ZekKtXbaNH4zPgdavzLVba4SUIHThLN7GFmAuXMYHbx5t5d
 N419EhAHNWK9lVDNxQ/MgzHLWEnc94WtsXjCT0ObBuVzwhJmQS66Ru/OE7KdXOOUZ63t
 yfL6icHxJN3fPh8y4cNZnCxDenUN5kwEDw7vwXPD0rR41PWC69utDamESBU9VZKRcN2H
 Q385zyI+t2J4lN1RHaPOSkKbgj7n7kes+zeW+pzxKmoqJgaTRLehJR2GBit+LGVG612b
 nYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071849; x=1793676649;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=Fu+UxI8c17BpDk1btdCFn2kspVp7evBahYH7TBDQJ13wCc00mNE0bYZ6JBf49W5vQc
 dsQMdybULXQI8tDdLw8aNXTp+ReHhGGPfnvGQ8Q8S9Wm8GQga7wEEni9DkpEGJyYlIrP
 oyLuq8GKkjgv04hw0SrfdR0W8OeFobApj3HMxpqPkRFVcZbx6aJu02MrsJIW5VOOTi4+
 WUp6sA5cbN00a4N1zp/HjgYGFrf7JRVv8mbPOhq88cJN6r3PrwGyt0KvsfR7DPIHYmI9
 u6nGEbATkJ9cE+BSyimGm970LCVVkTBgMs2/VvwPc/o4qOvvbiEkb9tD4Rkw4wy3MXK5
 zu8Q==
X-Gm-Message-State: AFq9FYK4f/mI3QTYLOw+bNWwDtcWi2w5o2OUnSsv0eZsdvpj/jEnDWl+
 c6B0jha66nwYR4J4agWZSJ84szq4o/C5ioNzP/K6EFMzfnqsa2xKn/5LBv+KJKa5NCpd0hyINm9
 iMSi6VgPDMQM5cwEXPCQH2lGU2wZUt0n28ey6oDK8nDUhLJBghjgkQ1WbJ3pPT7j92w==
X-Gm-Gg: AYBFou1UfQTpzX1WQsFaJxrz3OrCwYUUvm9DgqbXFZE4ishB0nuEhErlo/g0vGu5fQS
 zSEuEnfdg8LKCLEje/VmAKHjIQKrXChL0Y7D7b7Ojkn+rfPb9qLGWD7CzCCoTquXDZutlS+shyv
 Ee28TKh3qhEIbpk0F+5ODCRCuYQZYokcsXyECmz9yqagDkKy7g6U6w5pE1rh/21D3O7suWL1cKS
 nVHmllXwrBfRHiRKt0I6/ltrtugobZHHX3MuPZ0EVqL9wcSWtciLfD1Dl8/S1YUgjIkjNK7mXA2
 7Vh503wgbWFzdIqXJp36TZgXWQupY5NATBdsd6/WpmeD2hDYwa5s+ZfgpR5O0hB4PzSZMleL5WY
 2GWu4YekBs8n9PPIPdG/bXqerjJDATd0wtvV8i2zCktS7Esc=
X-Received: by 2002:a05:7022:f514:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-19929f6dab3mr11237998c88.2.1793071849007; 
 Mon, 26 Oct 2026 20:30:49 -0700 (PDT)
X-Received: by 2002:a05:7022:f514:b0:196:e2d0:129 with SMTP id
 a92af1059eb24-19929f6dab3mr11237965c88.2.1793071848455; 
 Mon, 26 Oct 2026 20:30:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 36/41] target/hexagon: assert qfloat shift
Date: Mon, 26 Oct 2026 20:29:22 -0700
Message-Id: <20261027032927.3055166-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ViB_QRUvCq_dPrtJeQxQeq2wfqmo5NKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX0jc0akNopGAn
 b9HHrsdbrOVYGx9ctuOJMjwXAHc6WTCFCpDm5wc7s/w3daOwEW6cFapDWCxXrwj/AZDSqcpuh+x
 MjUV9LD1/2lltz8WdtwcqVzqpKGSRykGJzd5H8IjFVYjGtdH9hNZ1k0P18USKfKhnj2obEXSUOv
 FXNLEFaefRU1HeR51NmcQlRMufJVf3dBKa1ja7wPkui+6Tr9JqsllKH8xoVHAsCwgDCz8KCxbXW
 5JCouS9np8qyAQM1gMQX3gvNlUnDtm658jkImlC5UW4vpaiIxFlBL2X1l++aeexhyWLoJ3YATkx
 Cy8E0XWTZ8MjSpci2UOdTsuOtHBRNX9X+nd7DHksxdS/CNC6kz/SI0C3ZqAV2g2tQpXQ5fa0c0s
 Mxgz8zbN7ZeTQSD0nmQSp+PgQgwxZqWMKnEFL6Cs9hjUcxJRtm8Rc7nviUDRpYkBDgeLKUfT/ev
 ptsEsywJY5p+7Srv1Ng==
X-Proofpoint-ORIG-GUID: ViB_QRUvCq_dPrtJeQxQeq2wfqmo5NKP
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6ae01ae9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX2aWZT3nXuGq1
 tWzKc71tBLsDSqLYBcNB4YEuvKUr79z/IZqiPbNFRhAuW8r5nFb/cWamBNzIGKaifm+OX0EzoJQ
 IgYNUxFK4WGaB6m4EhgFAreu8Phywuc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIG1pZHBvaW50IHJvdW5kaW5nIHRocmVzaG9sZHMgc2hpZnQgYnkgInNoaWZ0IC0gMyIsIHdo
aWNoIENvdmVyaXR5IGZsYWdnZWQKYXMgcG90ZW50aWFsIHVuZGVmaW5lZCBiZWhhdmlvci4KClRo
ZSBsZWdhY3kgYWRkIGFuZCBtdWx0aXBseSBwYXRocyBzZWxlY3QgZXhwIHN1Y2ggdGhhdCB0aGUg
bm9ybWFsaXplZCByZXN1bHQKaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGl0LiBXaXRoIHRoZSBs
YXJnZXN0IGxlZ2FjeSBmcmFjdGlvbiB3aWR0aCBvZiAyMyBiaXRzLApzaGlmdCBpcyBhdCBsZWFz
dCA0MS4gIFdlIGNhbiBzYWZlbHkgYXNzZXJ0IHRoaXMgaGVyZS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQV9XSi1QWUNmaWl1NDR1VFFpRG9jNThfOUt5
M3VFZC05ZzE0blBnRFBUX19nQG1haWwuZ21haWwuY29tLwpGaXhlczogMjYzM2RhMWUxMjdmICgi
dGFyZ2V0L2hleGFnb246IGFkZCB0aGUgUUZsb2F0IGxvZ2ljIikKUmVzb2x2ZXM6IENvdmVyaXR5
IENJRCAxNjg4MjQwClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0
LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIGIvdGFyZ2V0L2hleGFnb24vbW12
ZWMvaHZ4X3FmbG9hdC5jCmluZGV4IDQxY2M4MjdhYTg3Li4zNDViZGRjZDM2NCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L21tdmVjL2h2eF9xZmxvYXQuYwpAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdGF0aWMgaW50NjRfdCBs
ZWdhY3lfcm91bmRfbihGbG9hdFBhcnRzNjQgcGFydHMsIGludCBleHAsIGludCBmcmFjLCBpbnQg
YWRqLAogICAgIH0KIAogICAgIGlmIChtaWRwb2ludCkgeworICAgICAgICAvKgorICAgICAgICAg
KiBUaGUgbGVnYWN5IGFkZC9tdWx0aXBseSByZXN1bHQgaXMgYXQgbW9zdCBvbmUgYml0IGFib3Zl
IGV4cCwKKyAgICAgICAgICogbWFraW5nIHNoaWZ0IGF0IGxlYXN0IDQxLgorICAgICAgICAgKi8K
KyAgICAgICAgZ19hc3NlcnQoc2hpZnQgPj0gNDEpOwogICAgICAgICB0aHJlc2hvbGQgPSBVSU5U
NjRfQygzKSA8PCAoc2hpZnQgLSAzKTsKICAgICAgICAgaWYgKGxvdyA8PSB0aHJlc2hvbGQpIHsK
ICAgICAgICAgICAgIHJldHVybiBiYXNlICsgMTsKLS0gCjIuMzQuMQoK

