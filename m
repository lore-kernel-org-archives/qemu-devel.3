Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDD606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a/Q6304F;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=axzO6KU9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd0u-0008T9-Kk; Wed, 18 Nov 2026 05:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd0o-0008SP-Um
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:35:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd0n-0006f3-D1
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:35:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI9kJvE4082382
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ypdhkdwKC8DgCDS/9fQOGZHJu/+mCUBCspr
 hI3cFoO0=; b=a/Q6304FrWoijfLAIRH1JwRPo3FUxFghwRiBI5KYKYeBcxcCD+u
 mi+RQrNpzUr9M8z9TNUA8+UtV0ofXqQx1KW5viZUpmLs7AybUVWF4NW6nRVRfk+7
 jQG1cToBH73rRNFnnHWr4N0pKz4ETfkaeKT5mZAjaN/2Ta0Nv807dA3qfHgzTgM4
 y5wayb2P7cBXTpZt7Rj5l7nwXAh659yOv4aTd/KfJfSA8x3ZfGyMHYtrN328NrKD
 FTlRIyGT8GWK7N5eyV71iTtA/3ZZPH1O/1OgHgehfTzlVRe/BkAVZCrmR2mTGyNB
 CGpgu5aCVZsEGqTlBLcYT97YASwZngowoAQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9jhgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:35:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55d32f54d21so15962711cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794998131; x=1795602931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ypdhkdwKC8DgCDS/9fQOGZHJu/+mCUBCsprhI3cFoO0=;
 b=axzO6KU9T7AvExS9/XqWcu5vyg3hz6wYJzni0RBIoh5e5OoBVvOiAD+cCgM+WzkrYS
 zUeZeO8l1yH6qGT3JpKBn4Dqoty19ElBtF6kNRX1m8V8fiIFYofcH6xxMG4l+H2SxXC9
 Ff5wd9XY7c9fFRn/WZi1r1cCzVtBOZnB3olFxOqSHaDRB5wxcqjURguia4zQ5cDow78V
 Asnoey4hsuZlvlcMGR31m0relwuKE7UXJl/iYbGwjN3HvKLnYJlBWOLRJdL9pNYhGTq/
 9FU+RtM+/z0eFEFtWHhJTsvgGammr5+CKdnYMfgzNofbMG9eFweKePgcvjngZpKvPxOa
 wwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794998131; x=1795602931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ypdhkdwKC8DgCDS/9fQOGZHJu/+mCUBCsprhI3cFoO0=;
 b=FBhBUsyOaxztoPUMFp8MGsbqlsONNr+NWONZjKUOvIKghaRqySb/W6r0XWTD5CYMek
 HldR4Xj8roAU9hpID3eHKFAxmOK+PsetzrT4UHSlpAHnyR2CIKU2VrZyucXraxLWwpLz
 vY++aVa8ioFnzX7nGGS3LRRHQXXLXbE+/yvrWzSPVop64y53qh07RH5DMmRrMUBZyv61
 iWt9tj9aEKQkRIEoVMEHtgsAxRbl8OPGMb8OkjvhPhBDoFwoosr2Ij9RHA/Tk73buH7D
 PHDDkVVMTsD8oR7UqeRHazxsc428ri0fJ7D3DsgiNIclD5IwCLQ1PYu1tmDYfu4Pm2y9
 GmWQ==
X-Gm-Message-State: APuU4Z/E3GYNE3MudnXSHWExHgWfqL7siGFT1BXPkZ2i/aoJldZ0YEGV
 mxOgKWkigv+63doX38r4r/+f0LfZT8m+VgoPaav4LooSKzOYn65gO+P4XQEzF5ZIRUATOyqkIuw
 HQVmgGO4EdKEwzYz09PlpvRmFqHWp2iDfO3S20WiG1d6I/pSU2cgMqsqSVrSIBn1eKw==
X-Gm-Gg: AYBFou072mS0OQN94ZVJofTSIEY5Jdi3hYOuDy2VKBfoqlgO6Adf3SlCWZxpkQRxkqL
 303H8FAJCmGZCd5xfeyYOCjIjLlZwC6758ga5d9TH990H7sdK7XOnDyZI3IWn8eyaGkN6OYnhaq
 n2WtAZcQUH0Wq4drk0WafHXP1cA9ptOg5NlD+BeX3se9EcfN3z6OfgzqQasdf+mrG1TwtXqhl+r
 suRsa2MQEL3LixqJAD8yuS+joMsOIP0g5c7ODzfSj0ZqJVBT5+50GNktRTSEa6/ao/qqaT+sFMs
 684SgSp+qv5mSZ6cDpjjJurmoaMsZKNL8/CowO2Y2n3q+r+DC+euaspIAuWISCc2hGkNP/OEcKU
 HuENiXzo5MhlwLS+q2Ub7+rAjzrSNwoMFK4sx14OrGWfkYakFNqR8XJ7eoxkNm36hWzeDjeUGkD
 XVW42ueLQSsVM=
X-Received: by 2002:ac8:5d8a:0:b0:537:af9b:c73 with SMTP id
 d75a77b69052e-55d5a77052cmr30190521cf.55.1794998130748; 
 Wed, 18 Nov 2026 02:35:30 -0800 (PST)
X-Received: by 2002:ac8:5d8a:0:b0:537:af9b:c73 with SMTP id
 d75a77b69052e-55d5a77052cmr30190181cf.55.1794998130094; 
 Wed, 18 Nov 2026 02:35:30 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d59102ed1sm18927991cf.28.2026.11.18.02.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 02:35:29 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/2] target/riscv: rv32/mstatush related fixes [GL4488, GL4827]
Date: Wed, 18 Nov 2026 07:35:23 -0300
Message-ID: <20261118103525.1192249-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PyzvsNeSzoEQXfeDD8rz1VoOznO2tP98
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MiBTYWx0ZWRfX3qoWN0WazUcu
 JIvr9I7flWX+SzD5Sy1G2qacvj/u131EUv3Xrr0SRF6ugY9MwyEGy5NoPvaKxDJHEBHxBouqXH8
 krLeAZcij+fz3yIHkeeW9cR0KjMvWKs=
X-Proofpoint-ORIG-GUID: PyzvsNeSzoEQXfeDD8rz1VoOznO2tP98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MiBTYWx0ZWRfX7Q4Jekiwhryp
 5aONMawnj/2aMC/ua/MM3dSGhBgquybjKIz5LboANi+OeKPFyzSr9eBCSQLN9RKcdyGfi9r8hXH
 dzKagHlNw3Yw9Xe483GBYWxgmZnzm/+pGzDV4ecQR8rSwnHqdj0vUEdd1UUJsMMgCH71vQfjWnt
 +Lz5274qJ7yTeGRHqXCLuIrffvM5ilPpC11Cwq282abmM+LQM1BnINrllwMHSlwvH8i2EUUs07n
 drTlz3oZcbuEFTEv8SV7xjCvphrAX0zb2hV49hJxasYic1NG7le8hGYa18IYdWnMogFseHjQjUE
 czUT3vUYk9Lp9mUgJHVNOXH6t6L21MYm/qh23wydJ0YtmMJrWJibmWkdVlj5U1vTwrKTEDVXfwH
 3XHR952xd78h6Eb9Uxm2ZwCu8vAY+zZ5FAFCriaEAvbHNERe5feqTRMq3ipblCwJKyNrRIgE6Zt
 XHcfeyFDZG9WOpJL11g==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afd7f73 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=cMPHqgs9ch93h2pu8XgA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

While looking at Gitlab 4827 I noticed that part of the fix was being
done by the Gitlab 4488 patch.  Instead of marking one patch as
dependent of the other I decided to wrap them up in a patch series for
easier review/merge.

Patches based on master.

Daniel Henrique Barboza (2):
  target/riscv: do not clear mstatush after mstatus write [GL4488]
  target/riscv: clear mstatus.MIE if mstatush.MDT is set [GL4827]

 target/riscv/tcg/csr.c                    | 31 +++++++++++-
 tests/tcg/riscv32/system/meson.build      | 14 ++++++
 tests/tcg/riscv32/test-mstatush-clear.S   | 57 +++++++++++++++++++++++
 tests/tcg/riscv32/test-mstatush-mdt-mie.S | 55 ++++++++++++++++++++++
 4 files changed, 155 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv32/test-mstatush-clear.S
 create mode 100644 tests/tcg/riscv32/test-mstatush-mdt-mie.S

-- 
2.43.0


