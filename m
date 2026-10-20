Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14036606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hXRpV/8Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P2k9nts6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzCr-00011Q-Aq; Mon, 19 Oct 2026 22:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCp-00010k-2k
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCm-0003jB-Tq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0t7743806878
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UebSHfNGHCnl3lV5FG/Q9b7I36P06qarQ39hZQcc+E0=; b=hXRpV/8YqNpOg/1v
 Z/d8CXNuKSEwOAFAESF57b8AXfEkcf1ZzFbTlDkaL2EEqQpbb4iuZPZol5GJInLj
 G/jHrmpqVDPS/80+dZ7Ts701vDFfyLMyesG9QXv6dj1CVToFIu83IZec7Djc0xMF
 QN619hrJrebmZ4nNXvuXkkQZ1jM1wcx2xQVVKq47pwmsesalCGN3EMBaSeAoTcyZ
 5HirP8oWIjtCkQh0tjkjjs1Ka3XVf1rkbIGTZmv5DHJ3i2EliBekNa1cKHK6kqXx
 dkxP5Ytfuz6FXe+/XNX8BgrLTOjQwbIbMErbqMFiLNhELppPpHpIwxMTUpgl2XNw
 vkXvug==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p8d0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5668910eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792461835; x=1793066635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UebSHfNGHCnl3lV5FG/Q9b7I36P06qarQ39hZQcc+E0=;
 b=P2k9nts6uBlEYIIb2n0GFRZunj9ZnKixb+l5ZGoKO00kaGtSXXQTIjTYqNNGKRv8Y7
 ndjCUVQXuoogPUBSCFOG/cQ3KnLGWKSedRfevQjLWUOBAfu5wBoIsVZKR0RQPjDFG9k0
 wnUdw3fD4xMWADDyvwC1o6qx7r5WoJGL8Zh2rVzFRkkCFQZjKGxhKfTVvWt3umTkNOrH
 P8dFm347m7WIhwz82rCePBlASL7L2dIP+Ck9bjED9YkEv/R9IX7QILnvtDiQ0azHtfe4
 YHgkbKgIod1+pA/VnIMqGKYqcJhENuiIdSU2nsuGVEvBk4qKDnJeqInyxqXvU71kP4gY
 D/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792461835; x=1793066635;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UebSHfNGHCnl3lV5FG/Q9b7I36P06qarQ39hZQcc+E0=;
 b=BCN21eo060R7Ry4fdXJuf6ys0V6NQxsqKBrAbB/J5IHvxAQArZSgveOMFlalbxLaiQ
 P9aayf00cr8GJpAkmb+uWJHhMOjU1K1q+SngCi8sWdT05iFng+pmqYpSbOZhOVk0fFW/
 9ItSCcBc7ffA19EBvAjpwwpFaeNkwCoZKc8U2QOoBqio/uGk+V327Jd/gLx6ZvDCQGO9
 D237ULCVK21S+2QNa5xOUqAmL+IkvXXq8p+JHc4bkFF7F16LfOhzpz9UUPMzkYM4QFP6
 0gnJexdtCQan9EuN7pnrsP9bfO2KR8TrUXLpxrJNUegi4pREXARpTeIPX98NIM0yCCF0
 LAGg==
X-Gm-Message-State: AFq9FYKtUVEITzuL68FAs2LhSqPMLafp7Q9ciCKgEzUupqGfeqAFD9b5
 XhKB9ATG4sM81FXpiuAAYbo16PihR9ShOMPWxObQ6u4sDFLDct8XHgmtd6C6cDjG8NWYhfsAkWa
 Wh/UhXcuxXX+64S1e5isnUjOekayiuZWb7xs1HVKvC86y3+4yVIfVj4qL+JxyrsBbxQ==
X-Gm-Gg: AYBFou3dOpCnfhGSxF3Q4GAx5T/XHBMB/AWzfjerBdlq2GjzloHqHv4WD6jC1KLedNI
 8dlr4M4PdPM2v+X5CHaCbhdTbSKp1ldFAf4jjnVcPxOu13Ll0OQXh+dcEVbvQFJwzctd1rFMXLm
 fxqmIghSlKbvLpHRRtTbbEUvArXXiwTGpSVXgNgmo1Rzm9l5qJ0t8gLhSBNXSQW2PgQhNNTzKY6
 vLbS9as86C8eydZzih4C8pzIhWhGSdboW/Q/kBUOIBmq+3bBosyDvsaW6nRgUJMK7r+P74tm8AQ
 RwnEP/2Q3DGzgaDFe/tiy+/PpAnXhQwv0T4YTnl3O7vBELh+sJFrsmIBJTovYhfDd+QPq5/IVwa
 hgDu2ZbQhwZ2XKEQLJty6my23WxzIDybzq4qrAvwO9SbbHZGd
X-Received: by 2002:a05:7023:b0f:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-18512c3833dmr19861532c88.13.1792461834615; 
 Mon, 19 Oct 2026 19:03:54 -0700 (PDT)
X-Received: by 2002:a05:7023:b0f:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-18512c3833dmr19861510c88.13.1792461834099; 
 Mon, 19 Oct 2026 19:03:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm49452078c88.11.2026.10.19.19.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:03:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 4/4] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Mon, 19 Oct 2026 19:03:42 -0700
Message-Id: <20261020020342.3619566-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
References: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: y3gtZ-buUF3HuMN5JAEAKd5wwQxQRG7k
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad6cc0b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfXxMVgMHB6insI
 FjFnY/atVyLEq5TgMccTmYjZTeZFdxySjovenOC6E4kNowYZaVacyLeg7R3+20FnX4r7XrHBYlb
 7W1Pq+cVSLE7Z0O2EdNtKdIqBLvC/Wnp8t1m4hU3nTyoLbXS1AL0ixyptNHbb11ubMTlajgDxGr
 4OBtxyX9dlzdK+EtaM4ZiQFDefvSLKTgQs8giKuMQWh3ns57JHFgZKdJE31T0qy4JiPxq+G3np7
 znFDOVuTm0YvgiKJ2WKybfIFbWum7dtsiGa7xer0PGVI6JSyxduODOWrywz43SEYWz2dz9f2QmN
 Lf4cJCkDwKKjLD62jsOA+ieeGCOwsdeWB6M5eQjwJf1hstKTZf4K6yHdnM+mn9vludISuFdgPbG
 oAEHRhigdQf7l5Ym8+fVzBWLMEuQORJ/2QDuXc7MGRmX8XadK3JBDWNarRtdNOwzqkHA5pDMCvJ
 pvLF4+yHgDtS9IC3mOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX/HGI1nfunGld
 oflEdb7tOPBhIDSPEAQ6Y5H3GnoMEypQAidg4j9qZPDLegMlmqaCZ7DDBueE0BIApAzyTkVBtSh
 4HHp+dSkgRR/NdoJ/Ujb1pLKR6hQji0=
X-Proofpoint-ORIG-GUID: y3gtZ-buUF3HuMN5JAEAKd5wwQxQRG7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200007
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

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuCnRoZSBndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzCndyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5j
IHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggYTVjOGVlMjdjN2UuLjlmZjcyMjUz
Mzg1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYwpAQCAtNjI2LDI2ICs2MjYsMjQgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRs
ZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19BQ0NFU1M6
CiAgICAgewotICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZp
bGVuYW1lOwogICAgICAgICB1aW50MzJfdCBGaWxlTmFtZUFkZHI7CiAgICAgICAgIHVpbnQzMl90
IEJ1ZmZlck1vZGU7Ci0gICAgICAgIGludCByYzsKLQotICAgICAgICBpbnQgaSA9IDA7CisgICAg
ICAgIGludCByYywgZXJyOwogCiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIoRmlsZU5hbWVBZGRy
LCBzd2lfaW5mbykgfHwKICAgICAgICAgICAgIGdldF91c2VyX3UzMihCdWZmZXJNb2RlLCBzd2lf
aW5mbyArIDQpKSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9Ci0gICAg
ICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtpXSwgRmlsZU5h
bWVBZGRyICsgaSkpIHsKLSAgICAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwotICAgICAgICAg
ICAgfQotICAgICAgICAgICAgaSsrOwotICAgICAgICB9IHdoaWxlICgoaSA8IEJVRlNJWikgJiYg
KGZpbGVuYW1lW2kgLSAxXSkpOwotICAgICAgICBmaWxlbmFtZVtpXSA9IDA7CisgICAgICAgIGZp
bGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhGaWxlTmFtZUFkZHIpOworICAgICAgICBpZiAoIWZp
bGVuYW1lKSB7CisgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUZBVUxUKTsKKyAgICAgICAg
ICAgIGJyZWFrOworICAgICAgICB9CiAgICAgICAgIHJjID0gYWNjZXNzKGZpbGVuYW1lLCBCdWZm
ZXJNb2RlKTsKLSAgICAgICAgc2VtaV9jYihjcywgcmMsICByYyA9PSAwID8gMCA6IGVycm5vKTsK
KyAgICAgICAgZXJyID0gZXJybm87CisgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBGaWxl
TmFtZUFkZHIsIDApOworICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDogZXJy
KTsKICAgICB9CiAgICAgYnJlYWs7CiAKLS0gCjIuMzQuMQoK

