Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAF606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bHXJHtTO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dVsAGNjH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbvW-0006TM-St; Mon, 09 Nov 2026 21:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvT-0006RZ-GX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvR-0004FM-IM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:35 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0jGrw237147
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8XyDR9YAbCVUIH71fLGKb8tlA0BJpq2yPdnsJPtwhW4=; b=bHXJHtTOl/YIXU5D
 V02DgfLnl4ILpwdGp05R0hwO+qqdRNdnl+4XN0SBIqBOXNdJJBThs1DDGXr2UHkQ
 Z2AiWYbJvpJbapGDLqrh9u7PIwj/rM8sSYVQlwxndojUZau1YvP1bFaoesowfqE/
 PSla1HdWYSh8Mn4ZWw69o+GXaxUuuoX2GfrwmAqtLKmF+JQQCe1z6t1mHpbqiXzK
 fFHLN3/0Yf536pQghKE5f6LyFI63y6B9bVm8JpZUp8XRL+rIlN4vOcLYAC/gH3jm
 vwCx0FvGnqwB9pBNGghFipGOC3U06O3Is8gs3arYkxgftD2QRM0P7WY+P8EU6SyV
 HX3fZQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8ue7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b3ae327c55so897522c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794278971; x=1794883771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8XyDR9YAbCVUIH71fLGKb8tlA0BJpq2yPdnsJPtwhW4=;
 b=dVsAGNjHa09XK+xo66Tdks/s2nJml9to8Tw5czi9h9HXGhur2YyUVm8LrYqTWcRMmq
 /b6mCopykA1KPXICr1pQ3RM9onILI6Ud+wOu8JaiHRogaedBKMAcG31avwndq/r/aJh4
 wilC3sr3bNFphNbShBUvgraj44FVKNHrOgyajB9CcQ17rPBqcxDlzC7KH99h1G/1MbJU
 JWWWvElPfaFW3D6XgseaEYewvRN9xcsCDocDz+OcAsKIVTQM3a/xoFz5oNfaXEunzvME
 PRGDhXqPRpgN7JKOz0VtpYD/hrR1cU6Z1K246fks1UZv93fQr7Xwj+g5Q7SAcbeoXskw
 tGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278971; x=1794883771;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8XyDR9YAbCVUIH71fLGKb8tlA0BJpq2yPdnsJPtwhW4=;
 b=SKgd3tdeiG29Pn2CRFdQPdZzwazRWDQj3mauRp0PtbqN0yv2D6JpEv1Ud3WtDXkC9A
 q5Q6HQnm10ENY7JyOQSj5o4ng2zgH2tn9RlZNi/y6mvrimdx0A2O4KuNBABxtbjoHfE+
 kCaE+fWdZu77kbPx/8kw79eoH4KmhTEm7oVfIRed63w/zU7bXV3ktwZqBcjAyJyyVLYe
 Ra2xms4Ye0bNs7oqxiqYBJrv0KkAeM4iZjWsh/BELBAn1A0R9bVf7OadO1t5+ksQqegt
 oObOZuVg2/b8d/mT7FV5CKBjLsMa4T7iD93oL0xM53UNOhg4CGmDK6XXLkTcZzegeZrR
 cf5w==
X-Gm-Message-State: APuU4Z+VAnC/XYweeHnTiUNfn8daj7Bh9tfM8lQD6JUIYjmtTp0u70pH
 tlDQRJR6gBUwAGgFKJ1bPN/TtxVKifr4aq78Awt06OUFAhMGeQVr65e4iQpTSqZ7D3XOE/BIzjq
 YGebQJLDmYfEvpDrN208IozOO2VkP6Hj2MoL2ndSTHEbid++d6KFqKzinPrcPJWzbBg==
X-Gm-Gg: AYBFou2HIWsoSpLdP3riu/2VFByzSPpfBsENdf4l1cTsaAMFR9x/mL6b9Cj4MqC36GU
 jVJhr4sK+trpyGTHGmHnyyQMVwAop/jVLVM+rhVC3RG/iSWjwliA/4EY+PZ3QTnZlBZV+oGDNDe
 bTxhhEg/q4B8MR8Jyo+b3jL9hl2W0dwU9Rj7envEDi5QxUZK0ovnb11k+t/GE4mDx1gMVuZctw+
 svX8lj2pQ8FwARRHkdeGp23VlZ9NA+ISvjPn2KRV7qs9mveVaOqvDRakKzQWj1QyJjYtrneOPU3
 HmZb+QJXMb/NiJkkc7QiGWsf4xADSv3IeDs8uxmqPfNXocelcgAEpxFtHmepzei+FmguurvSRsz
 Pcbb/yR1/7HJ2Jr4d7fDqjQyH2bNVX/kgDmeg//WPDEGEUYNP6StRHY8CQhc0mcVWGjAAzxAKPY
 bXKOqv5OCz0fssM8NO5nt/
X-Received: by 2002:a05:701b:205b:20b0:1ae:d447:6c84 with SMTP id
 a92af1059eb24-1b3b5e42655mr1778046c88.19.1794278971270; 
 Mon, 09 Nov 2026 18:49:31 -0800 (PST)
X-Received: by 2002:a05:701b:205b:20b0:1ae:d447:6c84 with SMTP id
 a92af1059eb24-1b3b5e42655mr1778017c88.19.1794278970641; 
 Mon, 09 Nov 2026 18:49:30 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm2700263eec.25.2026.11.09.18.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:49:29 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/11] hw/hexagon: fix FDT address and size cells
Date: Mon,  9 Nov 2026 18:49:01 -0800
Message-Id: <20261110024901.1610588-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
References: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX+vM2MVz+cR8/
 +/4zi6kGbuIg9FcFByTDth3PwweblG4Ckv8GQ5KKmC1PpZLExChsKyiWIHcSyVjmIuinsXcLd9s
 Gsx4vrVsk6JcZwagpsbFfJ95aU+LjMDgkSCZbTGeXW/pIMDX0c17HV0bZwzBzIovB99ganKTfVP
 prHCV78L9WOe0UJfM485G511Mobug54aNvc4V13TY5cvf0PnDgTHjnP9XaBX6GU48FhmA11Girl
 VHpRMGHnYpowH4Sbp5mPFsf/1aSJjcTvqA5VsXQtiuiprjBK9RwLnb2cv4cpSEiIZIHbCgo+yu5
 Jp5T28B6+fS5fRSL9lUkbaAWDuzPk3kThV/6VRsZFn3jeCN31TheE8VjqNP8ziCs+1yWp44YcJU
 2kqpAUa5E9WztsjKdbI1J9mmDwdPRywGRpLEWo4AFj1xJQnnP3/wHctdds0gvBLxZKSdpRKdTQV
 kNkx4Me/Zswe8MYPFfg==
X-Proofpoint-GUID: gsisErf7x3MfnxWt1r9F1UinMR5zUFZT
X-Proofpoint-ORIG-GUID: gsisErf7x3MfnxWt1r9F1UinMR5zUFZT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX/OdgYhUClMf8
 OvyCQVvNprmYPeRYGCSXrpoTp2CBw30y30p0TxUtz2tqLiX18Ko1xuD/I1oqNzcVI10McswoREr
 ZYl8hyeP6OutU5fFgq8EPQ4/47NXh6Y=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af2863c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=3RaGgONpw-BU2ZlCsxAA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100010
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

SGV4YWdvbiBNTVVzIHN1cHBvcnQgNjQtYml0IHBoeXNpY2FsIGFkZHJlc3Nlcy4gIERlc2NyaWJl
IHRoZSByb290IGFuZAovc29jIGJ1c2VzIHdpdGggdHdvIGFkZHJlc3MgY2VsbHMgYW5kIHR3byBz
aXplIGNlbGxzIHNvIHRoZWlyIGNoaWxkIHJlZwpwcm9wZXJ0aWVzIGNhbiByZXByZXNlbnQgdGhl
IGZ1bGwgYWRkcmVzcyBhbmQgc2l6ZSByYW5nZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hl
eC1ib2FyZC5jIHwgMTMgKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleC1ib2FyZC5j
IGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwppbmRleCBkMmU5NThmOWI1NS4uODRmNGVmOWY4ZDIg
MTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4LWJvYXJkLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgt
Ym9hcmQuYwpAQCAtNDMsMTMgKzQzLDEzIEBAIHZvaWQgaGV4X2JvYXJkX2NyZWF0ZV9mZHQoTWFj
aGluZVN0YXRlICptcywgY29uc3QgY2hhciAqbW9kZWwsCiAgICAgbXMtPmZkdCA9IGZkdDsKIAog
ICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsICIvIiwgIiNhZGRyZXNzLWNlbGxzIiwgMHgy
KTsKLSAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiLyIsICIjc2l6ZS1jZWxscyIsIDB4
MSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgIi8iLCAiI3NpemUtY2VsbHMiLCAw
eDIpOwogICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZkdCwgIi8iLCAibW9kZWwiLCBtb2Rl
bCk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCAiLyIsICJjb21wYXRpYmxlIiwg
Y29tcGF0aWJsZSk7CiAKICAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShmZHQsICIvc29jIik7CiAg
ICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgIi9zb2MiLCAiI2FkZHJlc3MtY2VsbHMiLCAw
eDIpOwotICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsICIvc29jIiwgIiNzaXplLWNlbGxz
IiwgMHgxKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiL3NvYyIsICIjc2l6ZS1j
ZWxscyIsIDB4Mik7CiAgICAgcWVtdV9mZHRfc2V0cHJvcChmZHQsICIvc29jIiwgInJhbmdlcyIs
IE5VTEwsIDApOwogCiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCAiL2Nob3NlbiIpOwpA
QCAtNzgsNyArNzgsNyBAQCBpbnQzMl90IGhleF9ib2FyZF9mZHRfYWRkX2wydmljKE1hY2hpbmVT
dGF0ZSAqbXMsCiAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAi
I2ludGVycnVwdC1jZWxscyIsIDIpOwogICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9k
ZW5hbWUsICJjb21wYXRpYmxlIiwgY29tcGF0LCBzaXplb2YoY29tcGF0KSk7CiAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9jZWxscyhtcy0+ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIGNmZy0+bDJ2aWNf
YmFzZSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgIGNmZy0+bDJ2aWNfc2l6ZSk7CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwLCBjZmctPmwydmljX3NpemUpOwogICAgIHFlbXVfZmR0
X3NldHByb3AobXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtY29udHJvbGxlciIsIE5VTEws
IDApOwogICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgInBoYW5k
bGUiLCBsMnZpY19waGFuZGxlKTsKIApAQCAtOTUsNyArOTUsOCBAQCB2b2lkIGhleF9ib2FyZF9m
ZHRfYWRkX2h2eChNYWNoaW5lU3RhdGUgKm1zLAogICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0
cmluZyhtcy0+ZmR0LCAiL3NvYy92dGNtIiwgImNvbXBhdGlibGUiLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAicWNvbSxoZXhhZ29uX3Z0Y20iKTsKICAgICAgICAgcWVtdV9mZHRf
c2V0cHJvcF9jZWxscyhtcy0+ZmR0LCAiL3NvYy92dGNtIiwgInJlZyIsIDAsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdC0+dnRjbV9iYXNlIDw8IDE2LCB0LT52dGNtX3NpemVfa2Ig
KiAxMDI0KTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0LT52dGNtX2Jhc2UgPDwg
MTYsIDAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdC0+dnRjbV9zaXplX2tiICog
MTAyNCk7CiAgICAgfQogCiAgICAgaWYgKHQtPmV4dF9jb250ZXh0cyA+IDApIHsKQEAgLTE3NSw3
ICsxNzYsNyBAQCB2b2lkIGhleF9ib2FyZF9jcmVhdGVfdWFydChNYWNoaW5lU3RhdGUgKm1zLCBo
d2FkZHIgYmFzZSwgaHdhZGRyIHNpemUsCiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZk
dCwgbm9kZW5hbWUpOwogICAgIC8qIENhbid0IHVzZSBzZXRwcm9wX3N0cmluZyBiZWNhdXNlIG9m
IHRoZSBlbWJlZGRlZCBOVUwgKi8KICAgICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVu
YW1lLCAiY29tcGF0aWJsZSIsIGNvbXBhdCwgc2l6ZW9mKGNvbXBhdCkpOwotICAgIHFlbXVfZmR0
X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLCBiYXNlLCBzaXplKTsK
KyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwg
YmFzZSwgMCwgc2l6ZSk7CiAgICAgZmR0X3NldF9pcnEobXMsIG5vZGVuYW1lLCBpcnEpOwogICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgImludGVycnVwdC1wYXJl
bnQiLAogICAgICAgICAgICAgICAgICAgICAgICAgICBsMnZpY19waGFuZGxlKTsKQEAgLTIxMSw3
ICsyMTIsNyBAQCB2b2lkIGhleF9ib2FyZF9jcmVhdGVfdmlydGlvKE1hY2hpbmVTdGF0ZSAqbXMs
IGh3YWRkciBiYXNlLCBod2FkZHIgc2l6ZSwKICAgICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUo
bXMtPmZkdCwgbm9kZW5hbWUpOwogICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhtcy0+
ZmR0LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAidmlydGlvLG1taW8iKTsKLSAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+
ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIHNsb3QsIHNpemUpOworICAgICAgICBxZW11X2ZkdF9z
ZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwgc2xvdCwgMCwgc2l6ZSk7
CiAgICAgICAgIGZkdF9zZXRfaXJxKG1zLCBub2RlbmFtZSwgaXJxKTsKICAgICAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0LXBhcmVudCIsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsMnZpY19waGFuZGxlKTsKLS0gCjIuMzQuMQoK

