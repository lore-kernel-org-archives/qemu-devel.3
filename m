Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6E606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mWrf57Uz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LMiI3MTq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosX-0002hT-DZ; Sat, 24 Oct 2026 23:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorC-0008Rm-2X
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor5-0001Xe-RT
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P17eB94169856
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=; b=mWrf57UzEZvtgboa
 0hHNnlwDmnNTHaKASuKWnjtQEeyIG1/ooqYSL3dUg0voFbBouwnyQxKIxkmCdjZM
 ydOJs9PbdYQL/y/PB8DyC1VfmkEq0dWRpRZ3UMcKuLyEWctrznVUQrARB+MNOAdd
 LQCTpm9ugArtbudkn/RtKJ64HMN5cXq2CtpXka+qTpKaSo+kRJQ7IGwZvmFVyIkv
 lrsHAKoi1Vz17osKu1Gx99r8A5+9GgGV3NNWA2GhWFLO7GqGPZGcV1xjszbz4dyd
 T5+PDYbLfVoA+0kQlVo0hs7pKIJ5VrkbMPFzUp7YU/8HxVAT1reFfUKEr8k1BV9i
 +PyCZA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsaena-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so5813750eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898696; x=1793503496; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=LMiI3MTqnS4gWFeXzWBNKq5v4fVMiX4E+mcBTeK1ZKwZ5sGi8sfHw0q137ajqsG9g2
 iL+X5XLoRQpGmCmEFQztOYVKtqIfw0LIBrz9a3xkMUSbT0+7QrxJW7k7JnH3NdKkQoSx
 UMO/bi/xXAfaFsNK09UJGCMYez7p8xJfxO3sKssbX0dTWsn6BHCVxm3FfdWDRjhXOsnH
 hQbcNIqI7gCqs+OJaKxDSN5jZVjpxc9yHG2HkwMEq1SZX7mCRw8OZgMNDBkWl0fHQusS
 KIQorTxljZwJ977chf+PHaIqg6+ZoI8KCu3ZYRaDsiV976toc66SDykQBIu13lVwLKBJ
 JCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898696; x=1793503496;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=calLhFjDgr8AxCYLOAnSYW3kVnW3+WxarSJxc7JE6g4=;
 b=TCU1IrN1zqS8vHqjDm5ADFAqStObHV/sq5xCOMuoLDPRMSr5UTcRDXLgUM+ceCZv76
 6+qZR8w5B5FPFonAfh/2M5bNySd8Z+tx/yXJ9Jdvp/NB4f0oazg3XOFlHN+3Tbk5v8Av
 hNIqK3+OvD2jmdziIxcuj4h+8LhHYCPY9JotkdESIrMnoziDjiMjzpIelYbe4bn5SbnZ
 x/TIPUsnpPiZLfN+fX4rCsyblQJxNV3rd3dhdn4MgRVn8GRFm9H4rxVGFbuRkocMjW4T
 ORKTH+o80yhSOBJglvbogGFcg2BErkD2XZbT7wN93ePn6aCjsr1xnkU4c3LvJsIu6cp4
 ypYw==
X-Gm-Message-State: AFq9FYJJKNPkL5y1WGn9i/ZvGMdLOhn2Yj0FJyEanbZ8QVyuvMnLwzIo
 9BFcSVdUEETtOwU9ABrDapzfxCajikBtO6vwpopwe4fYL41YTudJNT5eUjGVgH/q6fJNexbXhsF
 K33xxoS1ibGdCswKOefG9NguDgQhHHPcSS2U1c72cfn00ikugi1YxbYlp1p0HYtGJSQ==
X-Gm-Gg: AYBFou0tEvRNr5CGI7KjNHPRPVCdPrYVDvoXu8y+aTP4FfpUZpyIBw4iXhNDjcBlBU6
 XulP4PvztF90Tef2PgEyefZ9Yn/to9qHGkY1EgVA7qcJ9kIyI3+sRmVq1HDy05+FmjOzbAfrjom
 RGgwQSpfNskuxxwWxYNGzJSDqlOHXhy1DPQcuJ+hP3f9AWhQJXM+N6CjEiSeYWjJHaWsaopdPDL
 hzCSWh2Jx8pNaee1A+3Qm+YHWTEemEpgdDUopJUMHb7HzwOLB2EdGJI0ys0jZAQNWgkuTk19cmJ
 Oe+P1kGTXgK3tOb4dfZ1mtqe8bNaCLFiXinaWNjPQB1jth/48En0zZeP5NCxx0N5yITh9l6F0ic
 NtjZQbLkgeniRgT9H50yFyk08oCadvhxZqNhY8Uu4nnT5wb4=
X-Received: by 2002:a05:701b:2406:b0:184:992:c9ef with SMTP id
 a92af1059eb24-199374f32f6mr4365215c88.36.1792898695643; 
 Sat, 24 Oct 2026 20:24:55 -0700 (PDT)
X-Received: by 2002:a05:701b:2406:b0:184:992:c9ef with SMTP id
 a92af1059eb24-199374f32f6mr4365194c88.36.1792898695099; 
 Sat, 24 Oct 2026 20:24:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 35/40] target/hexagon: assert qfloat shift
Date: Sat, 24 Oct 2026 20:23:41 -0700
Message-Id: <20261025032346.2917451-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: j-S4jtWaBkaAc65sxPr6eH8rUeGeugcT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX8aIsrEl51CzT
 z37ZQ2LF8lRS2lDRZt9rxoWX/QNzcEVEXGoBGbr6XPr45CqbD9ry8+owTr2sHL97b64EeGvIUHK
 XBDLDt2wKsdhZKMNOgUMh1uuey8lWNEY+osYQj7pI1L38tOvFBLgC9h+W6heFQsCRYOQVgqHBrI
 9O947xSO/WkZNNU23kx9FznI1Q75+BUd2acC+kvAlggTKN9mszmLySYJ9Ax7AlAGt3mMaoEihJb
 HKVovks6fM4EpyqdGmJq9PYhetPqYAwuYJlNMuW/4qDRbl7I5IUgCRQeQNnQ8RgSALiaAex2LsD
 aV0/ifX34Y9AogkJKaLgOJY44aZ+ylq83tNbNe5RwoEGvJW1ip5VLZF7ofD9SM3R6vyF+vYpWI5
 eZQ+VZsilKU32xDWhbvENuecQ2aMZiv/FucljKKDOBxsaDgmL1Ui1XiK4YgPlXRuoaqKiha73Li
 0iebsCcMg5NTQY0FQbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXweRqNI3nRaeT
 BL8xMe2e8+UWzxAkccBKpuyLbrNAJccqFI97MHqNEGo0+qmYZpdSwLCTlzFIAgQontk6CzsALv7
 QRo4+Dl2KhiuuOXI87bK3aaPIjDVOoM=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6add7688 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: j-S4jtWaBkaAc65sxPr6eH8rUeGeugcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610250013
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

