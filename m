Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C45FC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 20:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueJNO-0001jL-VS; Tue, 22 Jul 2025 16:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueJNM-0001ht-VN
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:14:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueJNK-0001t4-Jj
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:14:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MIWGnG016262
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 20:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nmnX/xKgSu+5/1cXpptovo
 eiAaGDzyx+sdbPmv2Icdw=; b=GzVIvFJjrf+nk+Hko8VuJCuwrtoQahn5kpiJ0p
 phZm9yGGaiaI8VjSsxz4Kd2bHZxaNjT8LOrJ3g6l4wpRWtmSAn8WzeZ2tk3m4HVY
 e+2KLHykxThmcsthwkEIF0azNwOrmKSeH/Ch9OPpPFbCl2zljGipgbVrcM3fyRue
 ct2qYvx57AtRAtfmm6Miv669I8nxl/mTCh7Pur7q7XH1H4zGZbu3nf6dnhxrKmg1
 0LE+o3VX0x372rDc7VfEUpGrZoBZtIxsStVNMhKVFivEWErVaX/wl6G8HUWDl3Mh
 AfSavjLRTl7jb1gw+lnxUhQ6ob/M5NSkfwSFywttP7Hdwl7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s2u6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 20:14:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-235dd77d11fso59378425ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 13:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753215247; x=1753820047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nmnX/xKgSu+5/1cXpptovoeiAaGDzyx+sdbPmv2Icdw=;
 b=CIFIBqkzT/ZdLbBWFBmDWebJaR4XF9Lhjm3Kxwyg/S8vMEyl4wVBFUXumR+4eEiCHc
 OX52dvKs/R1T8S5k0dKiIP+A9r9gxYHz3hOWCNKYC0AIJD+UFKy8tZvwk6CIR5o/+rfV
 l1uuERtgNDveY95glaM9s247yfp1W5m3obbgLjUab9ssb1woP5v5AkBpEo5DECTCbagw
 0YziQhC8jbJ4/NbmPXohYnH/J5Ck+MaUgWMJKA4E/toVFey3vFAnKHyzIZG9a+oT8A7e
 ZfFrGvH7hgyv8NCOyvwC7Nx4DUZEG/vZNIYiTbAyzT2QGRjOsXXlma7Y0rK4ZZk6DFZb
 sJ4Q==
X-Gm-Message-State: AOJu0YwpMjfV3OXPKZTPbgCPt5Gy2IpYfCzwsCooPzNvV2rQe6mkANK8
 A0tQEMB7UvZirZ+Y0/JsqMqoQQv6952rqgGdUi5U6UsSlthy8fyWMvBxFlOtJ/rd2voV1vL1u8m
 nOmbn+nZF8UametUj68HDuWO6nSPrJCaknfvy1uT5ikbzIvy45Uo6kmeuwzz9vs6QpBcW
X-Gm-Gg: ASbGnctN/9Io/p4Hw1JyAqnsCZq4z39tS9zTMRKBB/8h98gWLxtrDwwuKfLhLsyQSD6
 zujs+sjvRzShCnFRN4WlBuZIktXxjVrOS4sKgDs8ej0VbyFI/pFRztC7LV5biaTOilqlPSA4KwF
 Myxuc9J3A2ulBbBUxxkikzFZEsECbCBd4I0pJchM9k5ZOvD+xXHSx84L6k9C1AQgcL/OIKawKaE
 W3Y2zHJ4rZ96eM4lx+UihCIT5NJmpCXM9q0xrWjmJHm3TLboNaHBDrLWQMkdA806zo1KT+Eoc7t
 iMutzqw8k/OtIcVtPmr3TpMEbHKglFFDTrLMwPq08a2Zr3KZyOzZoA15UW4XE7WfINAqU7Afm5d
 gfhd2K/eIrb1lqQg=
X-Received: by 2002:a17:902:f64f:b0:235:c9a7:d5fb with SMTP id
 d9443c01a7336-23f9818d905mr3836525ad.16.1753215247091; 
 Tue, 22 Jul 2025 13:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjNCEfS05A3wad+yiqv5XGTIH+N7NOlUxBOo910SB4zJSkGzA48qYLki3rUSZeT53D3+y9Zw==
X-Received: by 2002:a17:902:f64f:b0:235:c9a7:d5fb with SMTP id
 d9443c01a7336-23f9818d905mr3836225ad.16.1753215246590; 
 Tue, 22 Jul 2025 13:14:06 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4a9esm81917075ad.93.2025.07.22.13.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 13:14:06 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v4 0/2] target/arm: Added support for SME register exposure to
 GDB
Date: Tue, 22 Jul 2025 20:14:02 +0000
Message-Id: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3NCBTYWx0ZWRfXwXwL9T7dZee8
 PMqcQjqxRogW04zwGNSBL7RJ9kD5H19B01fAuy/OyBEgR4U0h2gfCjv1lNjn37GJHwcsvh/K1Rm
 bO3KPY50TAV5EGpAlZPQuLDjMe6EFS0RoRJxUl1Ib+/TpGBQeoGf8YChFUbgHjXTsOgCMwDABTW
 mkAJhoRjRgIyfbJVYMbYO/S+9b7mX0AlOfgbDSaxVhNpoahx8Kgdicup2QkVyPAfpACnFQXLrfR
 jOWXxidbcaegoz9Ub568uLfpEgb468bHcUjQrFlnfX17ZkIR5PLUlOoqiXNCE+IRQLKapb5Mg1H
 I0jaUl+c5cJeU8WDwcDP8TDo9Vkf3L4tGe8YfCy30VEiV4cR64kjI5otkv9la1zNssoDqDPEC6y
 rMTnNcZH8czVxtKIcd/6Mid/d1XDaOLcnLKUprF8ivo9DIkGzRr5lyxcDrbwXx8/j3EJ3keg
X-Proofpoint-ORIG-GUID: eAKdiMkCeYTzd5CKpDMI1zUzJ1l8DNSf
X-Proofpoint-GUID: eAKdiMkCeYTzd5CKpDMI1zUzJ1l8DNSf
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687ff110 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Q-dapHUw0VXFM7UNezAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=608 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The QEMU GDB stub does not expose the ZA storage SME register to GDB via
the remote serial protocol, which can be a useful functionality to debug SME
code. To provide this functionality in Aarch64 target, this patch registers the
SME register set with the GDB stub. To do so, this patch implements the
aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
specify how to get and set the SME registers, and the
arm_gen_dynamic_smereg_feature() function to generate the target
description in XML format to indicate the target architecture supports SME.
Finally, this patch includes a dyn_smereg_feature structure to hold this
GDB XML description of the SME registers for each CPU.

Furthermore, this patch series increases the value of MAX_PACKET_LENGTH
to allow for remote GDB debugging of the ZA register when the vector
length is maximal.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

Vacha Bhavsar (2):
  target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
  target/arm: Added support for SME register exposure to GDB

-- 
2.34.1


