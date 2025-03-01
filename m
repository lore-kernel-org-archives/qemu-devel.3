Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35576C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPk-000119-NU; Sat, 01 Mar 2025 00:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPg-0000mH-Q8
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPf-0008PJ-4t
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:24 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214o36Z023030
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VtSlR5f388w5C7mOSJea5wLDSl+4cWCfeCRwHMbp/80=; b=ohz1gmtX7qINYiuA
 aOiBjzD5oJrmjA9aicOihQ1Wx2usyQ96WslZ2A5vxbtQmMiZB+A2aHkKTgWQhYPF
 ZozocLzz+uEPjUPHMVDGIfWWH6pKvlyqlEHrmG0SDmGUazEn4K5yQq5DBcOUkiaQ
 tSx7v7NPDdB0RSLcqo4iaIgBy5otDczsX0b6Ku1Ea7MoMSYmM4CEfJw4+1aZHx8n
 SpJPyQ3JvZ2xwQkOKztgJLgjodoHkwXm0zw8+ipcDyPgjVWxkAiBjOkiI/RX227v
 4KZ1+7qq7LpVDIuScwg7pGdXOa4a9OUDB5zjTxxEl5wnQo+BXteh23ayYDXFwJpx
 F/CMlw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh701xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feda472a6eso476594a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806951; x=1741411751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtSlR5f388w5C7mOSJea5wLDSl+4cWCfeCRwHMbp/80=;
 b=AabsZLNENsMleOB0IXzRBtyvpivWur242THibtbCjy0k5/FQEnFbTzifs/3j5ZfBR1
 2Z6+XHsnlCob555CwoF9Y8rzNlm2craA0wtMOUjkJL38KIE0+BYJ6p8BkeLccHnJLGld
 wGQjmHuOoUdxiRBWfpf9u93oJnt1UCbHKn9P7c0Oqwq6X0Um03XFw1BYmtmhaKttAjW1
 P1A58DWl8bqiyHD1hrPu7jKNN0KwOJlWv0loBjrX5PW57qC9iSjkSu1EFYgLr1MZ9XqL
 dLiadin3dXCI/mpS5Ueoi0g5hP0EDOUsw+bp+in8YrhYS9F1QxMnQ7Tew8dbe7sFD9vS
 NWpg==
X-Gm-Message-State: AOJu0YyOdZ/Fo8E7kBwQAazNjZUdhb4SKp1JGprhpz/l8RmpQ6ERrZkF
 90MFkfGZCZSXyw7p/c2uDF9up61K9H8OznXy/Y2FrA2WV6g8A4Y6Bt94GHlCOmDiWfjNHdAKFKP
 g81NfJd6yTUnF3lTVZ1NYaT6RuGIYwoVoUPYx9GulNR2hmL6Kfmiody6oGnd5xw==
X-Gm-Gg: ASbGncv1LZoVTOxlYmxXN+sFXM5N9gyJZrGh1Eo0EZhmESZxvLGPnRsbIrbmFSg6WBC
 pD4b5l8nqTAGYTNS75u/EtFUSFWc8F0N/k5OQtkKWfRcTJyACl1IffrfonGBByKlo0Xj4rxEWgg
 tEcOKBLLWezrTAJuB8bw9PfWEuRr9UFmh9VnHdNJaPrbNLwlT0PXyhnI7Q5AFdYb1eEaeYZ/YTb
 TUEOhYqMk4w9UHFHVG1y1zcsOVcDjd+n11t68LHcCH7DwbBp4fW+3he/zkpjz+gnvCUxpm5Hxlb
 fuQGAjj/K9Ne4B194BKF1ebH6kzEbOmiqZfNBEp+RDdfdvfFd3qmPJ5CQTzA1jiD
X-Received: by 2002:a17:90b:1d10:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2febab787cbmr11261042a91.18.1740806950661; 
 Fri, 28 Feb 2025 21:29:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM0JTBXEVUCzmthe2Lzxmd3V5i576mO3yr48zt/46U4sHr/2hQFrvNdNvOjxBUizjA1dFPow==
X-Received: by 2002:a17:90b:1d10:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2febab787cbmr11261017a91.18.1740806950301; 
 Fri, 28 Feb 2025 21:29:10 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:10 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 16/39] target/hexagon: Implement hex_tlb_lookup_by_asid()
Date: Fri, 28 Feb 2025 21:28:22 -0800
Message-Id: <20250301052845.1012069-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: yu8PN7QYwjkeooYUnyRLiFVTD7DMFNl2
X-Proofpoint-ORIG-GUID: yu8PN7QYwjkeooYUnyRLiFVTD7DMFNl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=571 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aGV4X21tdS5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaGV4X21tdS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCmluZGV4IGQyMjk3YzAz
NmQuLjA3YWQ4ZTk2MTYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKQEAgLTM2Miw3ICszNjIsMzEgQEAgYm9vbCBoZXhf
dGxiX2ZpbmRfbWF0Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBWQSwKIHN0
YXRpYyB1aW50MzJfdCBoZXhfdGxiX2xvb2t1cF9ieV9hc2lkKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBhc2lkLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3QgVkEpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50MzJf
dCBub3RfZm91bmQgPSAweDgwMDAwMDAwOworICAgIHVpbnQzMl90IGlkeCA9IG5vdF9mb3VuZDsK
KyAgICBpbnQgaTsKKworICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7Cisg
ICAgZm9yIChpID0gMDsgaSA8IGNwdS0+bnVtX3RsYnM7IGkrKykgeworICAgICAgICB1aW50NjRf
dCBlbnRyeSA9IGVudi0+aGV4X3RsYi0+ZW50cmllc1tpXTsKKyAgICAgICAgaWYgKGhleF90bGJf
ZW50cnlfbWF0Y2hfbm9wZXJtKGVudHJ5LCBhc2lkLCBWQSkpIHsKKyAgICAgICAgICAgIGlmIChp
ZHggIT0gbm90X2ZvdW5kKSB7CisgICAgICAgICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVY
X0NBVVNFX0lNUFJFQ0lTRV9NVUxUSV9UTEJfTUFUQ0g7CisgICAgICAgICAgICAgICAgYnJlYWs7
CisgICAgICAgICAgICB9CisgICAgICAgICAgICBpZHggPSBpOworICAgICAgICB9CisgICAgfQor
CisgICAgaWYgKGlkeCA9PSBub3RfZm91bmQpIHsKKyAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVf
TE9HX01NVSwgIiVzOiAweCV4LCAweCUwOHggPT4gTk9UIEZPVU5EXG4iLAorICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBhc2lkLCBWQSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgcWVt
dV9sb2dfbWFzayhDUFVfTE9HX01NVSwgIiVzOiAweCV4LCAweCUwOHggPT4gJWRcbiIsCisgICAg
ICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGFzaWQsIFZBLCBpZHgpOworICAgIH0KKworICAg
IHJldHVybiBpZHg7CiB9CiAKIC8qIENhbGxlZCBmcm9tIHRsYnAgaW5zdHJ1Y3Rpb24gKi8KLS0g
CjIuMzQuMQoK

