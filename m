Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69F0CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXz7-0007lb-Ge; Thu, 11 Jun 2026 01:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz6-0007ku-38
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXz4-0000qR-0c
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GOQW3835120
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=; b=R6zFhYoEja8T7/Sl
 GUZuqndhamZqvROIigeEO5Ta721FdNf43pH30xiNTW1RpWJ0Dg8ZUrYXGm3G/4n3
 A6zCeBTJLsKZyrR9aNItuZnw1FVIufC9dGBAXY16IoQEbtIpkLqrWK5VANOp1Ud1
 jY4WQDHgOfbp23UtYvRshN83uwAWOhMCF8IKMtyUcG1ecBmp/xHL0tLQLI7PM43b
 m6bqx8HFYB8GfmFrlZkRaajZHKmNUX8zh8Myilo9+t3zzcJcvqtNpAFSAYt0LyzX
 T1QbioHUOQBhcUA5qa3WjWYp5hU1eaNpG8SqsIqEFwOq5RzOxmWimxROYI5UYyHQ
 FIQV+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ths6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-307fd7138b1so984969eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155770; x=1781760570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=;
 b=U/28gjodOdNca2XoGstUf1JsCN3bV4OON2VvTlTYmOfMXJCM5qDvNzPkx2qgfrQffX
 0gTfa1cwJuEu5b2zpLkbziYqOw78qe/FbF2wNiaLhtUQr7e8R/I2TjjRFPYnGYf1fCvn
 FMxY8NlGI7qyMMTqgJIUivmr1Qt/QsNQj3R0uhUcfIdLBau7NuidnuG/6QUAzaZFzq+z
 nRMrt1r2vIWcArhEs2ee5ZdcN09G6fseYc0lxJbp6xJIarNLSRIdvX7vu6LcbkhSgFiR
 hxkEiQ2mBdftiCHMzMQV5NF4IK1eAizMZVINhhzDBZQsjMp090w1gOyKUMQW4AC0Pwn3
 XXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155770; x=1781760570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93NO5nTkqSLKhLHTshorCnrOXtq4w0A1wRQSw+4IeFU=;
 b=Hh0RPlh/MRkPccDnCKKJ5scgvBs8MASN7ZGP02Cp0EzXfjBFLjJEVEeIgIOKCM7aVl
 WCIy7EnRjV/YWbELl1E9+RnE50Y2LcyMDdIvWGdYVkL/9z5jK6rOeI9YB+xBq2Dawqp7
 Lu3rRcqbPH8jlzsU2pDlrBZQbkPS/H5i4tSR+Te4eMsS6SEwULzLYkkgJZfh5WToMf9E
 hTDlbGb89dBo+h0x+mx/y3OsnZSlO3V/S9Vz3RZfwqg+t4unHsRfHQnaLe3fGaGOZsMP
 llttN3fsGdN/ABslDCC2cwoaf7vU4bq/QD8p5cR3c8P9/wbDrh8InX8nDerg+gdvWG9D
 E+wQ==
X-Gm-Message-State: AOJu0Yyo1mCevFXwiyFVYBepl5PSoiHNoTG1gIKFFl3UxOaUA9vGc/55
 HVmz+Qzahi+Oo+rSL0npr9Fzve4E2VN7WJF/N6PsGBbaATPLXynnsDwC36wjMrrVaNMI3EX3t/B
 NxxuJF0VEhz1zL2AK4I5OyW+pCXaSU/XD/GD2lHhgD65JWaS1MZlbAlqRsBjb88Wovw==
X-Gm-Gg: Acq92OEzv/YF2nUNSd5yznlYAq+66FRiFCX9dpY4vwLGWRkac4fPjFXOEnMjZ0qEjVE
 ZJAnZ/G+hcVnowVuSYYVrs3hlZbYBBwR5x9/UcOT2iu5ONDghwsbIzfenC3ExAQYPGdwBVmV0+U
 l2j6Kw6P5FFK9/ZKdG4Epb1w8eIi+tphZkm13Fc29cQ50WeZ8LZiUC3YeDbBTb+c3AmnaAT/wnS
 YYcmHKyhLunrEiz1AUoddruY+GrG6KjVRwrIwSJBFBkExxavzqzIYJAFWZTSRc5RUrnZ5caHpuK
 GartztGl5UHbMLIa8jHi42DDtJaXwxJ1Xr+2b0f1XmnaDnA5uWL2HTD1HopHQvC0QwC4WxPlMaK
 APamM0tYsFL/+47TiiHgkPLGONHH6kJ1/wnahFNAZHHE5OrKNxfeL7X1VLsdu5plIeVKDd4+Y55
 Vf+kVV
X-Received: by 2002:a05:7300:3204:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-3080463b951mr1124947eec.13.1781155769887; 
 Wed, 10 Jun 2026 22:29:29 -0700 (PDT)
X-Received: by 2002:a05:7300:3204:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-3080463b951mr1124930eec.13.1781155769352; 
 Wed, 10 Jun 2026 22:29:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add handlers for guest/sysreg r/w
Date: Wed, 10 Jun 2026 22:28:37 -0700
Message-Id: <20260611052857.3911981-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXxefBDpDCsISx
 z31qq9pawNsn9bWERwci9oyuGx6uTAnQ1dW7VoXwdFieJsdHmjugJ30P2seCd9V11C0qBQhmb4A
 uWp9CS/T0uKqKgAxBarwWJVBJuPmj5tpnopQaE7O1Jsv+aRBqq2N4FDxSOwbIMAlgHNMus071dB
 wjbkm5xoHSfS03MKdCg34FgmdMj8gqpBHUYkf6aCoB2LzM+gUzZqTLMky5+ZTinT3TkdTualciV
 IbuDxAEqAdCIgksO0npwwpeoxlPmb0f6PWnAU3lRIAqxJM4mVIBr8CD3OsLR+MMhwPEr0c4cAkR
 qCBf07AJMGrXeN5XzsTsMbxB4FlpIIcvXSnwRtAObHtnhhxr/bhUYKJNV+XoN4DTNNrObd7LkrY
 BDX2CJca80PXJOh5IXA+WH3xWW3etTXTPopNko4Hv6rMfTXi2BzPe+CD3UimDYkOAcseCABi2A/
 Wf/J6DAY/TglXiuHeUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX5JrI4nqFvACr
 9oww32d5F5N5kwCX7vl8r1F78zPA6MS/t6wIYSdW1xy9VXzmWHR361pnQnuXzM9dEnXpBj9SPkW
 N0UXjl4oEX8rasFFm6+/ps/Jb0LuoWE=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a47ba cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bcV7jyKSBUD-uhze3XuLahFrvEb0Mf1S
X-Proofpoint-GUID: bcV7jyKSBUD-uhze3XuLahFrvEb0Mf1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGlzIGNvbW1pdCBwcm92aWRl
cyBoYW5kbGVycyB0byBnZW5lcmF0ZSBUQ0cgZm9yIGd1ZXN0IGFuZCBzeXN0ZW0KcmVnaXN0ZXIg
cmVhZHMgYW5kIHdyaXRlcy4gIFRoZXkgd2lsbCBiZSBsZXZlcmFnZWQgYnkgYSBmdXR1cmUgY29t
bWl0LgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDE1MSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dl
bnB0ci5jCmluZGV4IDVkNWFkYWNlNGIzLi44ZjE5MWY4MDYxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTIzLDYg
KzIzLDcgQEAKICNpbmNsdWRlICJleGVjL2hlbHBlci1nZW4uaCIKICNpbmNsdWRlICJpbnNuLmgi
CiAjaW5jbHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRl
ICJ0cmFuc2xhdGUuaCIKICNkZWZpbmUgUUVNVV9HRU5FUkFURSAgICAgICAvKiBVc2VkIGludGVy
bmFsbHkgYnkgbWFjcm9zLmggKi8KICNpbmNsdWRlICJtYWNyb3MuaCIKQEAgLTEyMCw2ICsxMjEs
MTU2IEBAIFRDR3YgZ2V0X3Jlc3VsdF9wcmVkKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcG51bSkK
ICAgICB9CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorR19HTlVDX1VOVVNFRAorc3Rh
dGljIGJvb2wgZ3JlZ193cml0YWJsZShpbnQgcm51bSwgYm9vbCBwYWlyKQoreworICAgIGlmIChw
YWlyKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAgIHJl
dHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLAor
ICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdpc3Rl
ciBwYWlyIEclZDolZFxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAg
fSBlbHNlIHsKKyAgICAgICAgaWYgKHJudW0gPD0gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgICAg
IHJldHVybiB0cnVlOworICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBpZ25vcmluZyB3cml0ZSB0byBndWVzdCByZWdp
c3RlciBHJWRcbiIsIHJudW0pOworICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKK0dfR05V
Q19VTlVTRUQKK3N0YXRpYyB2b2lkIGNoZWNrX2dyZWdfaW1wbChpbnQgcm51bSwgYm9vbCBwYWly
KQoreworICAgIGlmIChwYWlyICYmICghZ3JlZ19pbXBsZW1lbnRlZChybnVtKSB8fCAhZ3JlZ19p
bXBsZW1lbnRlZChybnVtICsgMSkpKSB7CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1Q
LAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBndWVzdCByZWdpc3RlciBwYWlyIEclZDolZCBp
cyB1bmltcGxlbWVudGVkIG9yICIKKyAgICAgICAgICAgICAgICAicmVzZXJ2ZWQuIFJlYWQgd2ls
bCB5aWVsZCAwLlxuIiwKKyAgICAgICAgICAgICAgICBybnVtICsgMSwgcm51bSk7CisgICAgfSBl
bHNlIGlmICghcGFpciAmJiAhZ3JlZ19pbXBsZW1lbnRlZChybnVtKSkgeworICAgICAgICBxZW11
X2xvZ19tYXNrKExPR19VTklNUCwKKyAgICAgICAgICAgICAgICAiV2FybmluZzogZ3Vlc3QgcmVn
aXN0ZXIgRyVkIGlzIHVuaW1wbGVtZW50ZWQgb3IgcmVzZXJ2ZWQuIgorICAgICAgICAgICAgICAg
ICIgUmVhZCB3aWxsIHlpZWxkIDAuXG4iLCBybnVtKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVT
RUQKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fbG9nX2dyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpj
dHgsIGludCBybnVtLCBUQ0d2X2kzMiB2YWwpCit7CisgICAgdGNnX2dlbl9tb3ZfaTMyKGN0eC0+
Z3JlZ19uZXdfdmFsdWVbcm51bV0sIHZhbCk7Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2
b2lkIGdlbl9sb2dfZ3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwg
VENHdl9pNjQgdmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigp
OworCisgICAgLyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIs
IHZhbCk7CisgICAgZ2VuX2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAg
LyogSGlnaCB3b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOwor
ICAgIGdlbl9sb2dfZ3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK3N0YXRp
YyBjb25zdCB1aW50MzJfdCBzcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10gPSB7CisgICAgW0hF
WF9TUkVHX1NUSURdID0gMHhmZjAwZmYwMCwKKyAgICBbSEVYX1NSRUdfRUxSXSA9IDB4MDAwMDAw
MDMsCisgICAgW0hFWF9TUkVHX1NTUl0gPSAweDAwMDA4MDAwLAorICAgIFtIRVhfU1JFR19DQ1Jd
ID0gMHgxMGUwZmYyNCwKKyAgICBbSEVYX1NSRUdfSFRJRF0gPSBJTU1VVEFCTEUsCisgICAgW0hF
WF9TUkVHX0lNQVNLXSA9IDB4ZmZmZjAwMDAsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gMHgwMDAw
MDBmZiwKK307CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9sb2dfc3JlZ193cml0
ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0sIFRDR3ZfaTMyIHZhbCkKK3sKKyAgICBjb25z
dCB1aW50MzJfdCByZWdfbWFzayA9IHNyZWdfaW1tdXRfbWFza3Nbcm51bV07CisKKyAgICBpZiAo
cmVnX21hc2sgIT0gSU1NVVRBQkxFKSB7CisgICAgICAgIGlmIChybnVtIDwgSEVYX1NSRUdfR0xC
X1NUQVJUKSB7CisgICAgICAgICAgICBnZW5fbWFza2VkX3JlZ193cml0ZSh2YWwsIGhleF90X3Ny
ZWdbcm51bV0sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIGlmIChjdHgtPm5lZWRfY29tbWl0IHx8
IHJudW0gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfaTMy
KGN0eC0+dF9zcmVnX25ld192YWx1ZVtybnVtXSwgdmFsKTsKKyAgICAgICAgICAgIH0gZWxzZSB7
CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfaTMyKGhleF90X3NyZWdbcm51bV0sIHZhbCk7
CisgICAgICAgICAgICB9CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICBnZW5faGVscGVy
X3NyZWdfd3JpdGVfbWFza2VkKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIocm51bSksIHZhbCk7
CisgICAgICAgIH0KKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9s
b2dfc3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwgVENHdl9pNjQg
dmFsKQoreworICAgIFRDR3ZfaTMyIHZhbDMyID0gdGNnX3RlbXBfbmV3X2kzMigpOworCisgICAg
LyogTG93IHdvcmQgKi8KKyAgICB0Y2dfZ2VuX2V4dHJsX2k2NF9pMzIodmFsMzIsIHZhbCk7Cisg
ICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgcm51bSwgdmFsMzIpOworCisgICAgLyogSGlnaCB3
b3JkICovCisgICAgdGNnX2dlbl9leHRyaF9pNjRfaTMyKHZhbDMyLCB2YWwpOworICAgIGdlbl9s
b2dfc3JlZ193cml0ZShjdHgsIHJudW0gKyAxLCB2YWwzMik7Cit9CisKK0dfR05VQ19VTlVTRUQK
K3N0YXRpYyB2b2lkIGdlbl9yZWFkX3NyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sK
KyAgICBpZiAocmVnX251bSA+PSBIRVhfU1JFR19HTEJfU1RBUlQgfHwgcmVnX251bSA9PSBIRVhf
U1JFR19CQURWQSkgeworICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChkc3QsIHRjZ19lbnYs
IHRjZ19jb25zdGFudF9pMzIocmVnX251bSkpOworICAgIH0gZWxzZSB7CisgICAgICAgIHRjZ19n
ZW5fbW92X2kzMihkc3QsIGhleF90X3NyZWdbcmVnX251bV0pOworICAgIH0KK30KKworR19HTlVD
X1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZ19wYWlyKFRDR3ZfaTY0IGRzdCwgaW50
IHJlZ19udW0pCit7CisgICAgaWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgaWYgKHJlZ19udW0gKyAxID09IEhFWF9TUkVHX0JBRFZBKSB7CisgICAgICAgICAgICBU
Q0d2X2kzMiBiYWR2YSA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICAgICAgICAgIGdlbl9oZWxw
ZXJfc3JlZ19yZWFkKGJhZHZhLCB0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19CQURWQSkpOworICAgICAgICAgICAgdGNn
X2dlbl9jb25jYXRfaTMyX2k2NChkc3QsIGhleF90X3NyZWdbcmVnX251bV0sIGJhZHZhKTsKKyAg
ICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIHRjZ19nZW5fY29uY2F0X2kzMl9pNjQoZHN0LCBo
ZXhfdF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhleF90X3NyZWdbcmVnX251bSArIDFdKTsKKyAgICAgICAgfQorICAgIH0gZWxzZSB7Cisg
ICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkX3BhaXIoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3Rh
bnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lk
IGdlbl9yZWFkX2dyZWcoVENHdl9pMzIgZHN0LCBpbnQgcmVnX251bSkKK3sKKyAgICBpZiAocmVn
X251bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICB0Y2dfZ2VuX21vdl9pMzIoZHN0LCBoZXhf
Z3JlZ1tyZWdfbnVtXSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgZ2VuX2hlbHBlcl9ncmVnX3Jl
YWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJlZ19udW0pKTsKKyAgICB9Cit9CisK
K0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lkIGdlbl9yZWFkX2dyZWdfcGFpcihUQ0d2X2k2NCBk
c3QsIGludCByZWdfbnVtKQoreworICAgIGlmIChyZWdfbnVtID09IEhFWF9HUkVHX0cwIHx8IHJl
Z19udW0gPT0gSEVYX0dSRUdfRzIpIHsKKyAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2NChk
c3QsIGhleF9ncmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaGV4X2dyZWdbcmVnX251bSArIDFdKTsKKyAgICB9IGVsc2UgeworICAgICAgICBnZW5faGVs
cGVyX2dyZWdfcmVhZF9wYWlyKGRzdCwgdGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihyZWdfbnVt
KSk7CisgICAgfQorfQorI2VuZGlmCisKKwogdm9pZCBnZW5fcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0sIFRDR3YgdmFsKQogewogICAgIFRDR3YgcHJlZCA9IGdldF9yZXN1
bHRfcHJlZChjdHgsIHBudW0pOwotLSAKMi4zNC4xCgo=

