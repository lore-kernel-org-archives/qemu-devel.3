Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9F1CA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFyFb-000320-Ux; Sun, 11 Oct 2026 14:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFO-0002ws-1W
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFM-0008SI-G8
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BILOQk2746330
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:sender:subject:to; s=qcppdkim1; bh=QPCf
 QitHy5Wwi73PjMU3Xhy12JKS7TYpBYVzAmtUj5o=; b=b6pUcsZ5ujBjFRLODwit
 z2hnBw3KF8UTCuYbxML+Mn3P2I4wFe6BuYYvMtusYudSHicI1yGLFj2QAySOTuzb
 ODvOj70AfDeRfKv9eS3jbXos7JOyIcdRvWQkgRPQWSASvMOsQRVE+ot4vOh/s2bZ
 GYA80KK/RBKvfkFw2mzQ1W3rIMX/uP9gMY/baT1IVfI1TkqjW7qChlGeAZXMyA11
 bYY5hMXW8RPKHmQNIKapt1MPRPSrTgcVo2a5YuX97p9FeJw6xCcdZEkyka1IliTL
 D8/e+iU61gGVOThmeK8aoKTIANIKQRH5JvamsYgKN3Lyxft+3Dhygv3HFr2gdTtR
 Hg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjkea9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:06 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-152d1363a29so5910339c88.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791743166; x=1792347966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPCfQitHy5Wwi73PjMU3Xhy12JKS7TYpBYVzAmtUj5o=;
 b=WhXKq0dB03jfykcRiVCTfteB0xgVhq+bxgO/9s5hkRnUjImrGNOw1Se6HAqw8w9Rid
 SaAQaKYUwe1EnNjJJetYJufjLg3Zc0CpSU1sIIemApUDEZMqdUB/EeXw5oD+zVKnvkgM
 3aCn5ATG2YKdJb69CBHKIp7k53+nJ3TyNhwmpUVaaISKCgd+Z3Sc1okFfE5xnRpeV1Ta
 kp4sUIKbKvrzEvi5endv0b4wZRXdlvSKEQ+tAJxcTKmXpRfAZVyo5/eWQ+YvA4yCkAKy
 shiopJpNKPVVrqlJosOIg9+FdkW522u83lzJt46zgPsz4WcJsLV10u8xtpzhYmS7Sinn
 lWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791743166; x=1792347966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QPCfQitHy5Wwi73PjMU3Xhy12JKS7TYpBYVzAmtUj5o=;
 b=xRI3QIgEL/aDO31AISQHt+RstyeIo833tb7xm13jmTzDRiWZzIcXd2L+URcn/U8bXm
 WLIfuf5w3I39Ky6a/D7DNw5XMJ4PXprgHHXwNioJoTnddBhZCOZR55UwAldk6HpAbSPF
 ZAbB2KZpB1YOput1xZIwhcuG89fXvX8l8gsx/OgKwBE73NmkmwN4lPg7zBgLQiiu7r1u
 JPv/elueXzHzAUnXDJOx9neLOfmGwNnfauq2cua7SW8qz/RC+dXDVdchmoxO8Q1tCv0Q
 oSye37TQ1qEJ8WX64C03IwaFUbFRu8ofJXbhhhP++cU9gl+/sdUQMBdg9Df5lSNr/VD2
 9adw==
X-Gm-Message-State: AFq9FYJPchBUPGDMOxG97vegG62c7lmJwRf9PwXchc4Mtnh1Tq/G/CKb
 /kE30J9ZuOn79Wx0YXTvBShPMbXSN0Ph4Ehu7IUD/n/DU73LLvngtl0wU6p8F/3N68yLCypxL9i
 rdokE6SW80SdU92cK9Bt7/iIsJofzkWUHAacHR923OSljKLu0oZxpuvwTCQtivj1K+w==
X-Gm-Gg: AYBFou1A5EjmdagjW3fyAq8AF9BthedPCP+lmr7+j/FKaf3JFMkXJ+NqXiPZ2I0x1+U
 yiHW1goz/hQccmO0VuuxWmGCu8Wa/K4PfL2tGTQE62Flru1eexl3PJXvrz7xPlg08GgkYyiKCRh
 A/XZ8cjNxm6bvFes8wdpRaAO/zgdSfCq8kEt8lEIOv3vVu36JRj8gkBhAJmJw1ZE0W3iwwECPKA
 mYqGhnOW+Z54oVEoag0E3rKUY7BKjzWTkN8iVLbiuYPcS14DlvuUgKXMAgd/hUB3B3IKIiG6Ny1
 WbbXThpagaHxByQ/6mcq20VU/ioQhN2vJhZ0Keo2UzfS3GO+PkJhzqIUWOgiJDtrmPKT2qWiNL7
 jIk66JEfhcyRQUygvDTkpmlOkqO+7oAkIZQ2fHF5EKdfyLiEIqA2cJO4=
X-Received: by 2002:a05:701b:241a:b0:164:475f:1a07 with SMTP id
 a92af1059eb24-16a55f1e60bmr10830864c88.1.1791743165710; 
 Sun, 11 Oct 2026 11:26:05 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:164:475f:1a07 with SMTP id
 a92af1059eb24-16a55f1e60bmr10830832c88.1.1791743165183; 
 Sun, 11 Oct 2026 11:26:05 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm22505284c88.22.2026.10.11.11.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:26:04 -0700 (PDT)
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH 1/4] tests/qtest/bios-tables-test: Allow PPTT for RISC-V
Date: Sun, 11 Oct 2026 23:55:49 +0530
Message-ID: <20261011182552.1071742-2-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX8+vuS8a9oybI
 +S1uzFYYhVg5CgOZNesSOTzKyP6XikGrg5XSSMncIisBzkvuXUxJbaPMCwnd/pWyEhrmtWlQlfh
 /G2X/us0E6TCncfF3gWhLijviXskGh9Leog4MIawWdxEI0bq2YV/c96GpE4GtSWvsqbH5j6O5LM
 fDc0CGu+yTmIvebcj/vN/+IPV+HzY8hJFcXQX5EoBH0kUoo2rDxU/aU0agOr0ClTvq+GvGtoG1A
 c4z0EWL19GEW5wA4FmHI6Tf7y4dqK4n96Z/u6efHLnKATmnhDXmTUUUUIa6HyFHXJ5JjZQTz/RZ
 j31PMf9piVM2fYsQ9/41QdbpqupP1kK6BBTzR9eiA5JyFc1qxA4GlBWKwl4HeGvIOa5F5fm7yzi
 OxkTEK6xYdVMtq2/siFjvIQL/9BTdldeSMUf2DcqirdR9Qf5xETU31MbXuB4iT8G7CQJthoX2D/
 fdsXE2SBIDQzc8rhWtA==
X-Proofpoint-ORIG-GUID: a4Bf5Wix__dS1zHp-nv_V4HOSGjEv3vI
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acbd4be cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ou02Ivcb4NLdwMP0g4sA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: a4Bf5Wix__dS1zHp-nv_V4HOSGjEv3vI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX92kdkyM8FO9M
 UpS39GaKHURlOBIDfDRMjTSTQvRqfYtJ3O+2UENpdUhI50UDXkEfeBtqcf476gSRyj2gPJrm6NP
 ceVe3nQsI8tGsBnRM6PLEoGhObmWZh8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-to:  Sunil V L <sunilvl@oss.qualcomm.com>
From:  Sunil V L via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sunil V L <sunilvl@oss.qualcomm.com>

Allow changes to the riscv64 virt board to add PPTT support.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 tests/data/acpi/riscv64/virt/PPTT           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/riscv64/virt/PPTT

diff --git a/tests/data/acpi/riscv64/virt/PPTT b/tests/data/acpi/riscv64/virt/PPTT
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..94be7a69a22e 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/PPTT",
-- 
2.43.0


