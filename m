Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E267CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJA3-0002x5-S3; Fri, 10 Jul 2026 17:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA1-0002dd-41
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9w-0006Sx-Gm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3idb1648591
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=daoGlI2ileC
 E5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=; b=HEPCsf5GtQajj1nlc7tBwEMnlk7
 D7n0sbhLmac+zw6LkNysZZTbINwW66INf+3OjJM+KJ6fxKNi5JfD5g2DiEgsFCaP
 9KBAa/RfmRDJlBSAJHjMtZqpbu6ljEJtFXZahv+R1gR0HkxRn3ntLKZYTXSpIkBb
 WBa7NKv//LERxmt0hEqvhfzoT8cEnyELToBX/kG/Xm8keV38LPppNry83aiqdN8n
 5fUDozv7q+snypmJzpMOJG+/WjWaaESVLfn/zRAy9uyaxF53IUbaFXZmuelynya9
 HL23lZBeBCv3ib3CNyRxej8RVGR25bYg02RVJwzSWCSdu2n8ppEaoOZej8A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhdv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so950656a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720402; x=1784325202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daoGlI2ileCE5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=;
 b=IvGpbULn28moUJKdtpu/wmDpOPKgHPcUCbjp4OUW89gOaegXUgF2vSlEizWCA/Mst5
 NIqnCQdHUmcpVydsNOM2uDGxPeBZzf+7ElBEs9hdvYPaxHc66ibR5fSFb92shmZM52z6
 7AydKXQM4i+a8HnZsOgCIqh0W9mbBM2h+RYB04DlPnqaCIdv61FtF7qEQnMemTrHrz5X
 APoGss/fjY7o0klQ7f+0pCUYddGymojEziW9F+TmgRBcnEHdsrOBgMOSxK/Fjhpd8pAe
 wW45mon2/mNeOKrFtMY3ivUPfIsr4C/GU5xkvaPdchZDHIZDf1ZNAlAN5J9plNRSxDxL
 alwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720402; x=1784325202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daoGlI2ileCE5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=;
 b=stQFuy5XwKEMhK/Tq1Uol3fZV5RkfCtVXN0gR/Hl2EvrSvkkcS/1bIQbPhMdfeOr7C
 13gTVe7/VtN8qnh0dXoOjQ/1satjEkxTgcNO3SxBydBQwwoVKjne2xPgTX+Eh/IhzWhO
 RQL8l8fK7zGE3zvjDjLPmp3CINcszYnsYxO1qjVxlxjeWrDruhWLboza3MRfi3LX076g
 MdO0ZRbyRmlz/PRZY8cerjnQIjvs89X20fS+J2D+zWPn1qPpcSQSdpE2xQVdf3qnxqTZ
 zmrwPZjD8CBQ3zBo+A7o7Gyf2tSKtwTxaQPnGcC97GVccjddySV75WCRH2tOSFPe9zYy
 5PVg==
X-Gm-Message-State: AOJu0YyTS9s3SAh/XKOsccc29x58tD88FGkjCHgrEeBuuGgUZZ0U/RYh
 E4xCF7ZHrfC5MPYkY0qE2tFF8wM2zPE1NvOfRSMpjIAPE7wUHw07+7lm+Lw/o7MTs53KI2yuaZU
 W604epqaYWiy/t2b0tMWyDXOUTjDljqtb1H760BSl4bvorBMy0xihbZN3i513xePjLg==
X-Gm-Gg: AfdE7cmVK896D8iwqE+a1/prGqrotqIi04fq9ZVfs1zxbEzdM8FqQVjg3hn5KjJPMGQ
 1mQXjyUt7IlWOgi2C3nLobvk5lvpsUSpRWYObJurXgeDkVKklM4IT5iKzf/PulrKHLgLZ9NqPsh
 fLw4bP3d/kqiMBdeABwLd5bks30sJk+wJVS0Fa+cao9ktvrMnAEcQpwlW2hrt3cRuR+1xM0wfSE
 7RcXHtCHnX8bN80sxy03Q9Iv0nYCNko+YP+brLYNXFHPKB00IoYqgaQ+TAM0Jl0hSTwAFB2QK6n
 HlF50maPOszn9dne32fuK3ysCPYkEfahkKW2Z655pM4Kk9MyH6sMAvYBEBIkx40i5UIgTm3LKMD
 v2bZ8xe5XldqQ+7ATvrEes1Z22BYR7CYvxC3LanOPbYNGDchz3nllQPB5MsJBiHTcAqWtSHsN4t
 OU72sbcA==
X-Received: by 2002:a05:6a21:9d48:b0:3bf:5ff5:2b0f with SMTP id
 adf61e73a8af0-3c11062f658mr755089637.12.1783720402267; 
 Fri, 10 Jul 2026 14:53:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:9d48:b0:3bf:5ff5:2b0f with SMTP id
 adf61e73a8af0-3c11062f658mr755056637.12.1783720401846; 
 Fri, 10 Jul 2026 14:53:21 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 92/98] tests/docker/dockerfiles/debian-xtensa-cross.docker:
 add test_kc705_be toolchain for xtensaeb
Date: Fri, 10 Jul 2026 14:43:36 -0700
Message-ID: <20260710214343.2065491-93-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5169d3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=wlx_lthn7XJiM5nFl28A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 975DGxvnQVTdT1KHGa84AZ3CHJJc9JLG
X-Proofpoint-GUID: 975DGxvnQVTdT1KHGa84AZ3CHJJc9JLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX0jHasmAn5bkw
 9kPMG+c6z4Ic2Y9Mm/ZHiHkTP3PtHOl3kdPGqnhygfjPi3wAziHcx4NmJw2VFoSWK+TG7XzMzfz
 7zUrwoSAg8mJHxDEr36xdXrTK2Xf4iEwX2JZ61MHE57sYhi7o4Cr12y+gbHpFM8+2IuEP44Km9A
 reaY9hh4OZ4zkN5KCf/RSRaUftYMls7zT2kLcoSn+oZhAsfCQWuvLoiGD9RoJ65FFhCB+4IFcKj
 iX++jDIBqd0jruH44wjbDd/zyGeCbIOjt4jGQbaFeLogcgMTOrhTwEjdGbauptYn6pQnRGcwbzp
 hG+8jLKn/r/+UGEaAe3Huw/5erZnvu/8DG9tM6CbdHiMFJKWq8QW9LZHkS80xha5Gp+nGn9lgwl
 3NUJTXyUJUv7ONYT8usTRfDBVyVVMYiYtfyfp7RF8Rf1W1gE/od0q/W8w56wP0K749xEe1rnZNn
 OsL2+AWn17aQuXv+mgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX3hvmXdyvtPQh
 oojH+o32Ynpei5vxXNx6oDYTVlHYWwvAFhmh+dvspc8XpPsIF/vHmZqowaWdSKScDYhr+HTIKhg
 azCoNhrNCf6THcClzMZX6JYSPKJUXU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d9130fc3378..0eb6d98cc75 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,7 +19,7 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400 test_kc705_be"
 ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
@@ -27,7 +27,7 @@ RUN for cpu in $CPU_LIST; do \
         | tar -xzC /opt; \
     done
 
-ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-test_kc705_be-elf/bin
 ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.47.3


