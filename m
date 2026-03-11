Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582D1FD88F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B3z-0006X2-K7; Wed, 11 Mar 2026 00:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3g-0006MJ-CH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3e-000321-SO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ALXXAv2140298
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QGqATWnGsHcKy7Qc5Z0iiGQWLeqDEAzl2XBf73MelcM=; b=PdCLWvFg++pXi0Ue
 YbJak1sjbrg7D2feGfLkk1D/l+LkKpViutuf7Uxk3FPfqFF9KLjvvSTJTJXozSFt
 dnlxDoyyTTIoEj2aBw+tKCMRqEEQHpPEGz8fUeIDPZotO2HNp3khI6nfxc6unVRV
 +EUuywEtmfSYjqa2DclROnHHy+E5ZjMFXmgoQg5pSj+vHHuEFV9ak1YG7GyjvjK6
 EtSkOia6XaoPaYj2WZNwR4G47eyRfR6hjyjwQCp7Agt3920vejco8od4YlaxuFCd
 qZ4RHo5153gPPvpdqTkhNuSvsKj6STxGzCkQ7QfGjMRIs3V4k2/DdcmZIEpAZhqx
 Z9jt+w==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9w0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:29 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d74ab502b0so15999601a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202829; x=1773807629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGqATWnGsHcKy7Qc5Z0iiGQWLeqDEAzl2XBf73MelcM=;
 b=MfDzJltvApjvoJX9OZN9aFFcIHG1G14AMb49q7gQssKeFE0NTnAaUcL88fEF5/ksdg
 nP4A7bOfSoJmXsf0EsSbd8qLBH3/lzFIbgrxde4ohCYc9Vy+7zVh2CH3GWZMdgpVC9dF
 4L6smhlKw8KmM/fRHT6SybI/nDLI8XAXwkHzHnkrd6PmKz6G3RoPEPv5VYbbMAWPl/gw
 EJfGKjZtbPSS7OwOb0tXxqiJrum4cB2wG7CPzhNZmAC4x/CCjk1S729DDMeTmrOjTEaK
 TTpOfXHxoIM5M4F3PK0kmaKFdOmNMk9y1Ff7vCzGTtMqRr/pwD5h6GsH8qsMxT0QR5Iy
 fulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202829; x=1773807629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGqATWnGsHcKy7Qc5Z0iiGQWLeqDEAzl2XBf73MelcM=;
 b=aALhPBo+nJTaD7EvXui6PFclrX0WMrnmjlQLBOQZHHpjH2c65JNuCHgXcXGdWDhSgC
 vMYLQnzop0B48rbNQ/OXLkkCfv9OlM8VWA42LpcSMXHJHVxVOqawHNwNdcVx8aQ3Pk0n
 2IclUCyDHmSohcbulCqZcpqzEyTtyZ8UswQsU0ccsBorqTSBzu3oySh05nhkxvRumDfy
 cgQSZUhb9k28KoIieiUgToYFshFTPl6td+PkE3qSLWmqyVemu3QfNus6y3/kmh/mJhY9
 ztTFE++bIKmdCPEQ/xUPPoDqw/s1Otxv6XH+fR8lWi+caoufBmq6yDBbQxRd+FIzx9cH
 8y6A==
X-Gm-Message-State: AOJu0YwtwNmLqpyVLnELw8zP+n6osE8S3IbcMKJ7oC8bFDjjpV2pmD0K
 Rn/u8eAshkCp9fMIxjVstgyfOzfRQxcYZBlrUv4I0vFicEBR2ZBxdlIvkfOPQgSEyV/ipImtL1t
 l9g2CDE0hNWfkio20l+NNzm09aVW8zuVTfQBuKzcgDLNzkzpNasWfd/HKnY/RTofUeA==
X-Gm-Gg: ATEYQzxbBKiUJCBO82lj5MqXvGn8ty8myzldYdiDHwKW0xY3YrqA0dY7bFerI6VjlB7
 k22TQc1IhR1ZJjEGNGzeAHCLwQPDIackcaO8YPNx990wovLQNzHaGSq0ZBEOzU39KPJ3xguBFYr
 /TK4N462pWW/M9DbftJhoh/UF2ngKdWDxUASIpkTsRx+nnVh1TUp1Zyx9T6+nW2GK0YUi0sn3AH
 jCEKFX31yQ5UjRm4n3LMAK0Qj10BWTv23I+Lyl1GLaPc0U1gRSve/27xqjm0Hi3z4L+Jmx9p8f1
 D1pb4+HmlcnfNGOCb1F4GOBmfBeEgy+8QCfWUt6K5FH9Okdq0Qt4y8A3NDTYgakTBE1MlN4b+Dq
 w9Df/LOCLAfumElS9NhXldWhtCjGvOj+j0UF60QeJWEwuCoMS0zNfBQmoB+3Tl5L9GtLTnQ==
X-Received: by 2002:a05:6830:81d7:b0:7ab:e111:1a57 with SMTP id
 46e09a7af769-7d76a83dddcmr839045a34.31.1773202829283; 
 Tue, 10 Mar 2026 21:20:29 -0700 (PDT)
X-Received: by 2002:a05:6830:81d7:b0:7ab:e111:1a57 with SMTP id
 46e09a7af769-7d76a83dddcmr839030a34.31.1773202828901; 
 Tue, 10 Mar 2026 21:20:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v3 5/9] hw/hexagon: Add support for cfgbase
Date: Tue, 10 Mar 2026 21:20:15 -0700
Message-Id: <20260311042019.1085030-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: jWQAUijvA3J4E6nSH1l8VLo3g6A4dtz4
X-Proofpoint-ORIG-GUID: jWQAUijvA3J4E6nSH1l8VLo3g6A4dtz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfXzPLFn61uV8xE
 DhujUNqywV43p2gPKLRmy8kA3761a7SC7pXCczZXzD2CwB01NhNorIPdkuX7PxSWdQ7kcMMKncZ
 Sm5PSHAagFGyE0bPxRkJlcnPLLYvN3/RJQfWJUON8Ijkf2gIUrBSuzPzt3q2ul3DgGdCuY2ReWU
 NQPykVAy9jZLdDu1AkcaV0rgAnr7Mj7IAVL3aXwF/l8JiW4AlvfzlGIv5VdqWhgda4FkqENVkwL
 JEVVNrQeFpSGDTbOQvgDCrpAC2HuqlXqECJe+XuQ6GRQpQYGMVgD674n8JBadfe2c+I6qx64B5I
 M5F55QwcTPcKD9hvIVelh3SXtt4EO8/FySCxcGFlr00mfmOJXBsQLcN92YmqbDY3FjehHsVykz6
 IkgTufQf/wUfH9pIxUW68A6y40ecUkX8S7FBjLekMK84qVwgk9V5qDNr6OQRA0KzsHDMkybVz97
 F4UB/5DpAtuODxQy65g==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0ed8d cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=AXV-LJTb53eFTJ4lgsgA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jIHwgMTAgKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgIHwgIDEgLQogMiBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCmlu
ZGV4IDU2Mzg0NTM2NTE5Li4yYTEwYTJlNGIzYiAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhh
Z29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpAQCAtODIsNiArODIsMTIg
QEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jb21tb25faW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUs
IFJldl90IHJldiwKIAogICAgIE1lbW9yeVJlZ2lvbiAqYWRkcmVzc19zcGFjZSA9IGdldF9zeXN0
ZW1fbWVtb3J5KCk7CiAKKyAgICBNZW1vcnlSZWdpb24gKmNvbmZpZ190YWJsZV9yb20gPSBnX25l
dyhNZW1vcnlSZWdpb24sIDEpOworICAgIG1lbW9yeV9yZWdpb25faW5pdF9yb20oY29uZmlnX3Rh
YmxlX3JvbSwgTlVMTCwgImNvbmZpZ190YWJsZS5yb20iLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZW9mKG1fY2ZnLT5jZmd0YWJsZSksICZlcnJvcl9mYXRhbCk7CisgICAgbWVtb3J5
X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGFkZHJlc3Nfc3BhY2UsIG1fY2ZnLT5jZmdiYXNlLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25maWdfdGFibGVfcm9tKTsKKwogICAgIE1l
bW9yeVJlZ2lvbiAqc3JhbSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7CiAgICAgbWVtb3J5X3Jl
Z2lvbl9pbml0X3JhbShzcmFtLCBOVUxMLCAiZGRyLnJhbSIsCiAgICAgICAgIG1hY2hpbmUtPnJh
bV9zaXplLCAmZXJyb3JfZmF0YWwpOwpAQCAtMTEwLDYgKzExNiwxMCBAQCBzdGF0aWMgdm9pZCBo
ZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgUmV2X3QgcmV2LAogICAg
ICAgICB9CiAKICAgICB9CisKKyAgICByb21fYWRkX2Jsb2JfZml4ZWRfYXMoImNvbmZpZ190YWJs
ZS5yb20iLCAmbV9jZmctPmNmZ3RhYmxlLAorICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
b2YobV9jZmctPmNmZ3RhYmxlKSwgbV9jZmctPmNmZ2Jhc2UsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICZhZGRyZXNzX3NwYWNlX21lbW9yeSk7CiB9CiAKIHN0YXRpYyB2b2lkIGluaXRfbWMo
TWFjaGluZUNsYXNzICptYykKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjZhOGIyM2QyOGQuLjIwNzlhZjEwOTM3IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAt
NDEzLDcgKzQxMyw2IEBAIHZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3Rh
dGUgKmVudikKIH0KICNlbmRpZgogCi0KIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hv
bGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogewogICAgIENQVVN0YXRlICpjcyA9IENQ
VShvYmopOwotLSAKMi4zNC4xCgo=

