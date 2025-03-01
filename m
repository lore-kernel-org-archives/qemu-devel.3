Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEE7C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNm-0002xp-Rz; Sat, 01 Mar 2025 00:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNk-0002wy-Um
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNj-00088W-Kr
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:24 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MEsA026213
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7nt/o7ENbBye56WXPrBYAt0CKr8zp4jqoZYSjXDdNGY=; b=JaTV4/i07Bi22Bsz
 GRc1JoWhFesToTuMcQPrVgRhQZX/QnNwwJOzCvT69sgSB/dKyI62KuTyP0RmEVQj
 srRbgAnNqKklzN9OyzBFKoBQyPN3DiDJqaEo5CoAyKEyJeszsCSh3leXRAzArSWx
 LBVb3Lwu/ZdRR4CVI1AC2zMf5jjZtzMVT/I2sbcGEF34mJ9JtobEBH7jwrl5Hmfs
 jLs6790vr+KOmjgiZtqhFVkAoajU81Ey5Nc2+ZTMUOd0Gbjs13+upmPfzlA9Vaoh
 U1Yk4zjFrvVlp2Um3VddH984DElY6L+avhBS3AIMyz9U+eQDCasoy6sSWn2anKfe
 TDDCSw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95r62y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2feda472a7bso471401a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806831; x=1741411631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nt/o7ENbBye56WXPrBYAt0CKr8zp4jqoZYSjXDdNGY=;
 b=VTnREg72LqOgncPU4irM4+nR5RkTJEV4yDyukWwi2Yd5t0M+zAkLRH+4XnKuwX2vZy
 /wPDjY24wWUGnoeFwKxxFq14hdjfwj+QJcb2uteJtedHtjeWSy6nG2UEw9vRCOd9bs/W
 U5HUgqKCpPIW+VcTAiu9VHKEbV20tfnn3fVua3JSDZ4PEsd4Ot50TsXxRs/rszlwV0qF
 VW8veYVICPWbsfga5okXG2WDq5j0GDW6WinM72EsGRmF7ep9jBa/4fOpAneKCfo9Sxh9
 ZR7OEaLqqy6nTP1kszqAuQxT0Ept3FHOGcvz8uskjUzCqEgcsnGq7kt1jEIhjo9v3i3I
 2gUw==
X-Gm-Message-State: AOJu0Yw1CNkzc15PcGDs9zmB7q3YU6xnIsr9lO3qkP2D2swfA4Ma2k1Y
 4OEgg1dgxthUyqtq4Eq7RT16xlR9xfXhgR0J/WB+FQ+Crvk3zu1EuPf5OAAlukx15NUbjfdIhtI
 pWzIXauT4pWURlA0i1hvKwfxxTqJM+dBFJkVUmSGZFpAlUxqJzQamnWKLYjOf0A==
X-Gm-Gg: ASbGncsWmMpyiTtUiFwSy3QadPKEdCitoyHnjxJA4a8YUuC4fI+fp4xfLMx1N9Z2/ty
 EHlegoj6uaX4HJ7rN3LsZ86rq6KiPIGDp1Xipi15QcHKtiNzJi9u4QhozfKjcjJYFwththam/4N
 d/S3EumMifdYodtzvmKArXTbbVd/nCDSn1ZQbdVvNT3oEj7oIC8tPACNEKCjdkQNgOdod6M9D3r
 aQgzdb7B0ut/nALkYVXHh9wFNnEns0/VnkjPVtkmQUZZyr165WdGx0BrmlhJfKpODOqApg1WrfH
 oabI3YFDDheMMKpYaXrtI13sFaynwsmxRU8zgUAI6ehr763hcOoOai7P2RUJcYtg
X-Received: by 2002:a17:90b:38c9:b0:2fe:7fea:ca34 with SMTP id
 98e67ed59e1d1-2febac10a31mr8480209a91.32.1740806831105; 
 Fri, 28 Feb 2025 21:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF20OsHlDN1Rh5ErTgu+ad8qJI40NPryPMur2ZxC3zt3evRXqgX+9CH+VkaIZUwFNtzWHV0ZQ==
X-Received: by 2002:a17:90b:38c9:b0:2fe:7fea:ca34 with SMTP id
 98e67ed59e1d1-2febac10a31mr8480177a91.32.1740806830753; 
 Fri, 28 Feb 2025 21:27:10 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:10 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 18/38] target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
Date: Fri, 28 Feb 2025 21:26:08 -0800
Message-Id: <20250301052628.1011210-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Mvmx1SsRlxVI2MmwKfztHbD0FiP46dGT
X-Proofpoint-GUID: Mvmx1SsRlxVI2MmwKfztHbD0FiP46dGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=506 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
aGV4X2NvbW1vbi5weSB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CmluZGV4IGRiNTBkZWZlYjYuLjdmYjExYTA4
MTkgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

