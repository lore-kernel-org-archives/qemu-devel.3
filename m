Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56970D66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVx2m-000431-0l; Wed, 17 Dec 2025 14:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vVx1q-0003xW-CC
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:17:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vVx1l-0002Vb-QI
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:17:39 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BHJBAER1221181
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 19:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Z1jPnr6atA5Bimlw2rcG7lbr8G0TJD2fJSE
 hqbmv84M=; b=Pp+w8XjbX35NTJNEpWp99M84/TA3wFSufcaT+E1HxznkvcFL5n6
 H8SDN+x/Kxczk09h7w1FAGznEUNtKJnJ6pAk5J/0c0cl27sFJow2eQv4N2m8rfhX
 gkWYTiCWvGbiQTZdChSNIvqfT4LV7qzAflnUf9bsacumhcCmuPbZKY484l88dLWm
 9WpPcGAEbMYiHhKcLCQPhsk+gfVaB0dbHH61vl/ejnqVIN/skWl66zuybGNOUZUD
 XHuG4F0G/M3cgbZGjHi2Ev5vPIF/Musj7w68m6u9skIPg32rbmx/CGivRmhG7r3p
 UDb2I1NNGQCWwmfll5g9afX8VfMt3aBtjtg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3t8e1scf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 19:17:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ac34c4b41fso862699eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765999052; x=1766603852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1jPnr6atA5Bimlw2rcG7lbr8G0TJD2fJSEhqbmv84M=;
 b=WqVO7giZ8uG9zZxE0A7E2mklRo1KT/l/RLouG1WQBOagKEoKif6lBgT+CW73wGH11S
 KK1UCeo/n472nndUNQpgyOQAkuUh6WpaeSfOwcYJYm8JB3oYnps5NW1yiLI3ejrT0vus
 hsASvZXhacY4bRXQ4tsrLvMUXahx/U+pTBC/krH0Nrx6Zcljq1fF1CEd0K6qT8oObMx+
 N6lDrg+P1g4KJVtXC/2PNa0Oeh5PUXE8ZTcWvZAE+DT69x1USQRMWtbOrcHhTR3lQBq6
 mSE03cWjh9h7n4lhoR1VmQgsCuws1lenT8ujmsn2PbE8hiMM6LGRjvWDnliAN6ASOWQ0
 oa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765999052; x=1766603852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1jPnr6atA5Bimlw2rcG7lbr8G0TJD2fJSEhqbmv84M=;
 b=bPdL7z27rRfuHJ+py24WaaWMQSKUT4RzYD31i7ug/FlDz29ibzQnDjonNuR1m1Yj6t
 OKETDA/bvP/YiAlT26oj/HkvDlc+70S6juAFKus1i2HIlBqf/GccUqrRorX6KN3gAhs6
 UPaKIW8B6mW2SKpUV5JVwHYg9E2UXB7QeNvXky214BKG81t8R9fvdpcKXzJvObD0W2od
 vPe9M6MXvaO4Pm35Q5tO+Gp9UhnIQf9PDvXWr90EpM/dD6+GnhXTA7kUPWShWi9MZjXv
 sKOVkfCHSKFIkJbjw6cPzqBqbBVvLNhImP5EdgMlV+oGkCUC5fLFQJRUQCF5mWN/u4Ad
 l8Pg==
X-Gm-Message-State: AOJu0YzYk9xeI4IHQTLxbN3cHdG8KAOjBAkTv3r7rMwlWfDOwg64jM2+
 ooKKppGJy/pGYX0CuZv4o7Ysnkiuoec3vWHQCy+o6c0J/dXzbT00Pq8VLcNNmZ24BdwnNg+2eAk
 OZo/Wras1GO694DOF07eWeCUXjnE+NyULjmLnMH2CD4AvAJYUOoahOvFuBIAPzZoFQJ9fzMI=
X-Gm-Gg: AY/fxX4iIADkSGIHfKQlJtTAY8E6uM92j0aYv2fi5r35R1NaaQO8yxTeBbg07G58agN
 j8n6gRpXtAFaZyay6OCTl5LIBKDg126v1kMZy82uopNH/thPBp63UZBsAa328QaygeVoLCSgvou
 mOJDziimSslo5GgK8ShFRekcWxLJou9lWO1udubaRE4agL9pygcXbpUQy9pEM2ZIW6jaqmb/yLu
 qnTL+oVgcxfvVsZPeyW0lpfSljIJCilDflwgJFuh/59fNS9MDu6Xt8dHeSkS/wiRApVoZyfMMJf
 RAHaH/cjvCb7VWX9pj8Yxq7zPQkJv8r+bnHaIPdhu8xe6pUrrWqS9Qvya/ksKvKCHvp/Q4PtYrc
 ZjeiR5zcXbBaQYXNiZKOWuiNlyLw8h0E=
X-Received: by 2002:a05:7022:670d:b0:119:e569:f84d with SMTP id
 a92af1059eb24-120619279c2mr484519c88.4.1765999051669; 
 Wed, 17 Dec 2025 11:17:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9QLX8Hnj+pEC3QRKNJk+/mynUxrBE/GbbyyoHp/V2kWnJUzEqZJbopBkmh+kPAt3+3WM9eQ==
X-Received: by 2002:a05:7022:670d:b0:119:e569:f84d with SMTP id
 a92af1059eb24-120619279c2mr484492c88.4.1765999051050; 
 Wed, 17 Dec 2025 11:17:31 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([179.193.8.167])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061fceec2sm339744c88.13.2025.12.17.11.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 11:17:30 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: update my email
Date: Wed, 17 Dec 2025 16:17:26 -0300
Message-ID: <20251217191726.194767-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE1MyBTYWx0ZWRfX9lfJBoxCl84K
 /fX7AzuJwU4Y1PCsoFqu/AzY8PuYiY01eVKIDVYk8Z2/GRUCUbRw9WMokdbGfU38e2GWkXmodn3
 E3zjqrBdWDCpmW6uOyxs5FEy+4GMwiqbhjvvNmCjXG33x1w+fJ72p+3KsJr/Z3Oun7RhB+20+lI
 Eg6Q+f6lS1Ph4WmK9+XN4AOAjdrzWyu+mMhN97OexaaZWSyxFkKzNdSTFT2EIGRAWvU4FiFOy6d
 gt1Y+3z6CN7wdJXmo/h1k+7XpJtIO2ovV/KqKTGTg75HzbjJ4UILb/8Y87vUyhgp1v8eFagxYxH
 EJuO6XIuNCmdZ5Rr0yuonHE5xTr48jgAIVbWVZG3QY7oaCXhIi1Wd+PgUiV7a+dMZOhyknrESPU
 2/QkHDcrBnWQkbjh3JueIYluVknS1Q==
X-Proofpoint-GUID: -DjTVhC27ke2bRFzvAEmqhZoKFCVQvFJ
X-Proofpoint-ORIG-GUID: -DjTVhC27ke2bRFzvAEmqhZoKFCVQvFJ
X-Authority-Analysis: v=2.4 cv=EsHfbCcA c=1 sm=1 tr=0 ts=694301cc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=PgdE4ROMVEJNTRX5P8gU4Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_O3DOGVWAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8
 a=bDdBU3oEAAAA:8 a=SRrdq9N9AAAA:8 a=69wJf7TsAAAA:8 a=3YaQ9OB9uBDa7B75xg4A:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=xVlTc564ipvMDusKsbsT:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170153
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Also add myself as a "RISC-V TCG target" reviewer.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..35dd77c819 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -319,7 +319,7 @@ RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
-R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
+R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -4058,6 +4058,7 @@ F: tcg/ppc/
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
+R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv/
-- 
2.43.0


