Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C46C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPx-0002EM-5B; Sat, 01 Mar 2025 00:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPr-0001aA-3I
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPp-0008Qn-5R
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:34 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214CEaa027852
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H857qbuUxi9yfqPXPrWO3tCRpfvSH4Zc9V6gPOS37EU=; b=PNB/rN2FCqgR2zAI
 +Ca7wqNsyFAGup+iD6He7lFLgkE6jjtM/H8wqcP8Ii3+bQw75reFTtF3pzi7fh+d
 Cyi4CeWsFXlTM+aTc8k9n0S3NuZFhdbHlfiKwp+mj6bGcz+Xr5xsPbpPGBKkGNOy
 f6yid4OrrT+gJ8zzMOj7MUMeJ8kD5OlIEKH3fq3vIKEAxBpA8Oy/Y414/fVfiebu
 p7oSfv89cDPO5cr6MHXTMts029qhNEnEyqkNElj6wsmmpRpMEC3L2HQwwBOUK5vT
 8MYQBbcpPUzOK4UxSQTzLaa9BBRFmq/oZm7iiv57Md3i9MH5zuaIy9Ys5pNR5x8V
 qjFbDQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d038h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe8c5dbdb0so5817655a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806961; x=1741411761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H857qbuUxi9yfqPXPrWO3tCRpfvSH4Zc9V6gPOS37EU=;
 b=pBtjLjQy2Qom2/STd2C6r9ZiLaOT7/OlljklV15BpUFfcgtfFSGr1a6gX8Ru+VsEJa
 HFPeVltarT+Lb2ZMT9iKC557HxUG94cN/+M7vshxGZTStSJGVH7S5PX9xdU1CeRJZZcp
 9AHe/dw2953DM6Ncmm/E8f/D4x68agtA7jmAiZmPl6LUncngJVSUUvXYhrm+3Tr1pWeI
 7pOBn0IRDZ9mefKBYPorJCkey7ZpI3euXWGD+lfz3zZKNhZEgvkVycgJVB3A9ejVE/Hi
 XEp3vIfWt0p2kf/ny27NWYYL56uMDTtc3v1dafHcwCBs2GcxUS8/+fUwqni3qL1KfmrR
 ciSw==
X-Gm-Message-State: AOJu0Yxa3f6gHHV7gVxcC/3KMRJNKmiJ7xE2jnh398Xy3Ef+NJtuto+/
 rrDVFJQKJLWN93WEwnHEDhbGTNuj1S/1lsScs8kQXBIK2mUiNMr2gw+r8StFtbdC7jP0lktx+1a
 uZvDk3fBA232JAN7PRcST0eA1L/Vy2xRDx3BcXp88dhD09VI+h9XX9BBRXbeSGw==
X-Gm-Gg: ASbGncu/hL8xDhhXkSmbhWZoIjw03D72EXhGOudV7OCPF0i9UDUJzysykbXjfulxxfl
 b6e/ktkG7JzgxeSJI+3YoV8zFbVCECKWMik8wl1ioHDnLFODboGWn0s57DmdfNtNMiFAzKPSOSG
 vPpZheJeufjxI52oKE3MxIDYP82EytvQtjiKWgv8kqvczL2Uu3bKgP/G/oBSWV25IldtBNmgN19
 9e2lWm3l23uKxmeAjIArJ5F6+iBgOMaFX8sHzJGx4oUOn8r1QkOG0LPO0VLniAPFpFOovCWP0jS
 qu6RBOYw2pxHiZt9RJS8Xk0ZKpxvQdGe46kcGOo5HaoM7EZ7LGLxzG94b1GgNpD/
X-Received: by 2002:a17:90b:3909:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-2febab2ffa0mr9979264a91.2.1740806960779; 
 Fri, 28 Feb 2025 21:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5TF1psYqAHFrZpNI4NP5/ojcyLLCU+kfCkCTtIwgLP8v05Pyl21F//sRwzszPWqduUB9bjQ==
X-Received: by 2002:a17:90b:3909:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-2febab2ffa0mr9979238a91.2.1740806960372; 
 Fri, 28 Feb 2025 21:29:20 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:20 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 24/39] target/hexagon: Add exec-start-addr prop
Date: Fri, 28 Feb 2025 21:28:30 -0800
Message-Id: <20250301052845.1012069-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 5hQ9vQZI9Gucm6MXCdCUFo9hMDmS1ZxV
X-Proofpoint-GUID: 5hQ9vQZI9Gucm6MXCdCUFo9hMDmS1ZxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Y3B1LmggfCAxICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgNyArKy0tLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGJhYTQ4ZWMwNTEu
LjQ2NjdhMWY3NDggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0xOTQsNiArMTk0LDcgQEAgc3RydWN0IEFyY2hDUFUgewogICAg
IHVpbnQzMl90IG51bV90bGJzOwogICAgIHVpbnQzMl90IGwydmljX2Jhc2VfYWRkcjsKICAgICB1
aW50MzJfdCBodnhfY29udGV4dHM7CisgICAgdWludDMyX3QgYm9vdF9hZGRyOwogI2VuZGlmCiB9
OwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCmluZGV4IDlmNGNmZDAzYzQuLjdhZmRjYmY5ZDAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC02Niw2ICs2Niw3IEBAIHN0
YXRpYyBjb25zdCBQcm9wZXJ0eSBoZXhhZ29uX2NwdV9wcm9wZXJ0aWVzW10gPSB7CiAgICAgREVG
SU5FX1BST1BfVUlOVDMyKCJsMnZpYy1iYXNlLWFkZHIiLCBIZXhhZ29uQ1BVLCBsMnZpY19iYXNl
X2FkZHIsCiAgICAgICAgIDB4ZmZmZmZmZmZVTEwpLAogICAgIERFRklORV9QUk9QX1VJTlQzMigi
aHZ4LWNvbnRleHRzIiwgSGV4YWdvbkNQVSwgaHZ4X2NvbnRleHRzLCAwKSwKKyAgICBERUZJTkVf
UFJPUF9VSU5UMzIoImV4ZWMtc3RhcnQtYWRkciIsIEhleGFnb25DUFUsIGJvb3RfYWRkciwgMHhm
ZmZmZmZmZlVMTCksCiAjZW5kaWYKICAgICBERUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBhdCIs
IEhleGFnb25DUFUsIGxsZGJfY29tcGF0LCBmYWxzZSksCiAgICAgREVGSU5FX1BST1BfVU5TSUdO
RUQoImxsZGItc3RhY2stYWRqdXN0IiwgSGV4YWdvbkNQVSwgbGxkYl9zdGFja19hZGp1c3QsIDAs
CkBAIC0zNjIsOCArMzYzLDYgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfcmVzZXRfaG9sZChP
YmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiAgICAgbW11X3Jlc2V0KGVudik7CiAgICAgYXJj
aF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX0hUSUQsIGNzLT5jcHVfaW5kZXgpOwogICAg
IGhleGFnb25fY3B1X3NvZnRfcmVzZXQoZW52KTsKLSAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAs
IHNpemVvZih0YXJnZXRfdWxvbmcpICogTlVNX1NSRUdTKTsKLSAgICBtZW1zZXQoZW52LT5ncmVn
LCAwLCBzaXplb2YodGFyZ2V0X3Vsb25nKSAqIE5VTV9HUkVHUyk7CiAgICAgZW52LT50aHJlYWRJ
ZCA9IGNzLT5jcHVfaW5kZXg7CiAgICAgZW52LT50bGJfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX1VO
TE9DS0VEOwogICAgIGVudi0+azBfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX1VOTE9DS0VEOwpAQCAt
MzcyLDYgKzM3MSw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0
ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIGVudi0+bmV4dF9QQyA9IDA7CiAgICAgZW52LT53
YWl0X25leHRfcGMgPSAwOwogICAgIGVudi0+Y2F1c2VfY29kZSA9IC0xOworICAgIGFyY2hfc2V0
X3RocmVhZF9yZWcoZW52LCBIRVhfUkVHX1BDLCBjcHUtPmJvb3RfYWRkcik7CiAjZW5kaWYKIH0K
IApAQCAtNDE0LDkgKzQxNCw2IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCiAg
ICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKICAgICBoZXhfbW11X3JlYWxp
emUoZW52KTsKLSNlbmRpZgotICAgIGNwdV9yZXNldChjcyk7Ci0jaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKICAgICBpZiAoY3MtPmNwdV9pbmRleCA9PSAwKSB7CiAgICAgICAgIGVudi0+Z19zcmVn
ID0gZ19uZXcwKHRhcmdldF91bG9uZywgTlVNX1NSRUdTKTsKICAgICAgICAgZW52LT5nX3BjeWNs
ZV9iYXNlID0gZ19tYWxsb2MwKHNpemVvZigqZW52LT5nX3BjeWNsZV9iYXNlKSk7Ci0tIAoyLjM0
LjEKCg==

