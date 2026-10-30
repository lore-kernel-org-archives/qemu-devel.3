Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E0606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hO6VoVYm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MDe4gOXv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumT-0000gj-3y; Fri, 30 Oct 2026 18:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumQ-0000fv-CR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumO-0003qV-4U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtOYe3568400
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DlHQFm8JES1Uk+DfZYaxc9Xapcig4tw27lfDRp5tofY=; b=hO6VoVYmv86z3vvN
 L2f3sdhL95SojjZdSVzMTkQgXEOXl4X3+xTseiGfS2zr8hBmMFDrhMQ629T9dwXs
 88Q1TyFsM2oU9LSJHSIB1L0WBWMhDI8jB/1DsP8nBT4kw+ym1+sYs+0LjeVFRRwH
 JEMtue51BVlXcX3RFe/a7C5qD40DzjrfvKuC9jp0JaCq8IvBI6zDZucjs+Yis9ua
 iUsZAqbFwViQjMeAJauVMDPHNlcr+06Iq0Zk6QL+Rv6AgiQKP6rwXg2yepOiH+QG
 +2EsbVhZ2srlpv5+8UQDYIQVKxOI+xTYP5M2DvmxEZbDRWOP5l/G5WOyhJN1ohaW
 hwEIxg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g5d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso2551303eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398134; x=1794002934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DlHQFm8JES1Uk+DfZYaxc9Xapcig4tw27lfDRp5tofY=;
 b=MDe4gOXvIiVJZN8XOLOS4q+F21k22aiO9oJrRgDeIuP9xo3TZqcq4+6fyBdOHuY+8h
 jX03zw86/WCH4Y6FQ5sBx+LkVoZXa73rb1A/vuin0qsRVQc7uVwDpaOMeNtEx7tl45fE
 6ghBEooOvulR/uhxbK0FN00eiL0Ga0nEobwSjnJMpKGNu6KTKSlUXx2ShR7xRnAvu1Yn
 KxHEIoiAyFfDaPFx35CabapdQKmc0utlG3F74TpsB+b8NOzsIttgB9BIKN4mYvawupws
 bY8ZLguTVzkMl6xANVp2UD9i3L67sdRXn1ekkp98RTbrRoDHSGZkD7/z5BVbxSq76OFi
 gDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398134; x=1794002934;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DlHQFm8JES1Uk+DfZYaxc9Xapcig4tw27lfDRp5tofY=;
 b=1GlhciEImINGB0A6hSkA76ccxvyz7fWcUH3ODvkHB1wUFCkQO4FQ5JzzEtEnsAJvFF
 EcOmrGKMBSA5a3E0frHJTpBLdGlbCpip1kO7hak1bk/Txer0d1LWZqb/MEvBJ+hV8Zp2
 Eaf+SuKFT5qkmHnAqt79XtAbEDJ6p/3/4FUZIUofFtbPgxllTngj6S3S2Fk3FbO8b27b
 Mz6zuFBcJG6cXf6jRBzFzbkvhKsRrjTrs28FqP8HMPiOmE9yg1KlMPrEk20BbvnvAcXX
 kUp2/oWJNiPgDWIJemBOQMpek7LpGUsQCp+IniC48sH5dJ7iP0NljPIyUNhFpePZhkDq
 lquQ==
X-Gm-Message-State: AFq9FYITq7qg4/Z9+Xh5AXcrhuEKfkulf+pMjrOMo/5uzJdlIWrxl2d9
 rdMhIyQnGYj826yIyRiP/h9kz+ZaVzVJZ3sPLe24kDy3R8SwcFDphItl5QsmhSWU/MNlXsf4sa2
 qKV7F26AQkJkZRF2qfarv+ALPYpSnvkeG0HomEOcDPxDQhaevV2h/y8p+sDAqwdBUmg==
X-Gm-Gg: AYBFou2sbGFlDKa1qBl91YE6fV72fweVauDlPdYAflWjM39ltIEtsHGEressUTFX7+d
 dRcjqJjrYbpYE91B8ZptZx5g+s3HlCcN3RUQAP7nZy/fIm+YSzAwRIgBfzumt2iPcoDBGDNIgE2
 h0zZYjTTif/0JZEamy8Ncdm5erE+ZYQzESmj2OrfZo4/gREVIF2LR5Cv4liXl6CGomD4/FuOLL+
 El1L8iavNF2xMYyEj0q/R78OpyfyvUreJZDH1N/LuYuYICDXOaXLmKv1hYEdC0QPo0Sa0w0Vmdv
 +IhdVTE7rzrJm2qb7/XoeTtrMJR6g+a6HrJxzmHiVEHMQVc/gvpfCcN2Is+d10jm+ISO9yBWfI8
 bEhRpfAhb6lUliyGyHERTLJ912c49s+Ix9MVzexxMED/fhLzln0Gw8S/0HpR2qWtz8xYYh1zEqT
 bd24SF3CHJIXzVi0KMANhw
X-Received: by 2002:a05:7300:c00e:20b0:36a:2289:c599 with SMTP id
 5a478bee46e88-36a4243a674mr6476884eec.29.1793398133916; 
 Fri, 30 Oct 2026 15:08:53 -0700 (PDT)
X-Received: by 2002:a05:7300:c00e:20b0:36a:2289:c599 with SMTP id
 5a478bee46e88-36a4243a674mr6476846eec.29.1793398133208; 
 Fri, 30 Oct 2026 15:08:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 6/8] hw/hexagon: describe HMX in the device tree
Date: Fri, 30 Oct 2026 15:08:38 -0700
Message-Id: <20261030220840.4142885-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX65QzNq64NSDg
 04aX+SuPjN3ltDeJgxD9dI5rlEQDpnwG8W2p24yeDgxA904L1FOlUyWJXY7IWuy888xBW6HFHv2
 bnPhMtC2TrHSZ2hsKmd54M8lb29V4os0KD5KlVhprh7ZXq7tmLqelGF+RL4IeeFTUShF0KSQVLq
 aMeq+4XGzzRg2ar3qAIR+1bt8yOwQLYnpHqxmfdLy0FHZWHySfdbrzR0i3wNcR+5jdntDP/vV7U
 W3MgdHVU1KGbbHISK0NQC463SdCr0phYrZ70lfRbXtEuLpGMXVYlbrIB8pEZlMp7aJghWewHQ+T
 BSulMmdj1kltEfaEaKhHbhjhgBOYJccTuaTb+4dZhDXMnrG0Es/w6MXIvAsFpkMcbNxkiRjKglH
 3gY4+V/I9FBDR0G+hzKoTUc57SwMgcqUntxN7jKdXJg415kOCA1/x3D6HfwXBLb7W2vrA3ATBQ0
 Rxe8h/1+17DFU3LFElg==
X-Proofpoint-ORIG-GUID: 1NpcgObXTKonjYl11wxZN7AHEWGM9ZFL
X-Proofpoint-GUID: 1NpcgObXTKonjYl11wxZN7AHEWGM9ZFL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfXzN2vKrL8/X1X
 zS4/aFvbt54FVn9yJgeWLhvZ1UEIuqyEdzVcoKcFG8I2G+4MwIDdyRTdPVZtDylECP+NfcqHuJd
 fRZYkscYarRzmLkJwvzuxgWfS9yW/IU=
X-Authority-Analysis: v=2.4 cv=Arx7T+9P c=1 sm=1 tr=0 ts=6ae51576 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=keNgUTRjmwFx0GAfnIsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
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

QWRkIGEgL3NvYy9obXggbm9kZSBmb3IgSE1YIHVuaXRzLgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExp
ZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleC1i
b2FyZC5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9ody9oZXhhZ29uL2hleC1ib2FyZC5jIGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwpp
bmRleCAzYmYwOWU0ZTdjNy4uZjM4YzI0NGJiMmIgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4
LWJvYXJkLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwpAQCAtMTA2LDYgKzEwNiwxMiBA
QCB2b2lkIGhleF9ib2FyZF9mZHRfYWRkX2h2eChNYWNoaW5lU3RhdGUgKm1zLAogICAgICAgICBx
ZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsICIvc29jL2h2eCIsICJxY29tLGh2eC12bGVu
Z3RoIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0LT5odnhfdmVjX2xvZ19sZW5n
dGgpOwogICAgIH0KKworICAgIGlmIChIRVhBR09OX0NGR1RBQkxFX0hBU19ITVgodCkpIHsKKyAg
ICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwgIi9zb2MvaG14Iik7CisgICAgICAg
IHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsICIvc29jL2hteCIsICJjb21wYXRpYmxl
IiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInFjb20saGV4YWdvbi1obXgiKTsK
KyAgICB9CiB9CiAKIHZvaWQgaGV4X2JvYXJkX2ZkdF9hZGRfY3B1cyhNYWNoaW5lU3RhdGUgKm1z
KQotLSAKMi4zNC4xCgo=

