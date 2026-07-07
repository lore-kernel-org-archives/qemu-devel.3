Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF3FC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1MV-0002Zy-8M; Tue, 07 Jul 2026 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1MS-0002ZT-D4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1MP-0004oe-Hi
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DfMT3076713
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 08:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bcLDM0HJqXP1sY7px++lwo
 kDfl8qz7DTwhSghuXc6mo=; b=ATDOtw1RWD8ygFsDF60XxDuVfkv3Jv8b6qtFa5
 Fic3NSTDMAngakuVC4JZIgdsOzbJ8ETjilRg43xhj23taobRjhUnTKBRvvrBoVbT
 cb/LM19Hk6auFEg/x1uqeUUc6G4MjZw1LRtWMcJBHfM8GObdsjgy2hYN/DNZsTSc
 L/11i71hBOlxZ6aJ2gbbsxGBhn8N0NzWUEjly1zYuwlzWZFL91EQNrNQBSYW2Iwn
 Dpuf+04UZxQ0LbjVg26LSpjERwKOmiDRpwOlBFGqY7YSPPuOu8pKGjiQwrVi1wkp
 qrrWYr7GoSWyUG7KhRgOy8kWeK4FkUTCKhsPjcHDAsbnm6Zg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun0bbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:40:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so56906141cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413654; x=1784018454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bcLDM0HJqXP1sY7px++lwokDfl8qz7DTwhSghuXc6mo=;
 b=YQNJvcmIZ6SDBAMTmXFZtIKPc9r2+64U/eBHVgqkL71XCZQh9n5xk1JqnDQmeNalWO
 Ggzz0ShWCIiZRI38/6gTb7mZMoBlr51132HUFmcjMuHLNAiAaiswOn2DusMo9Fkigkux
 Ym9X7shyUboWhUQvLL9Bu/1DO01P1+lxCJ4KF82AW+c5Y8DvuUVq7BCMYZl7TziHqOUO
 u/r/80ORYP2M52rEYXdI+IKb1Zh8Y25mJGCZL+O0s59fXvRVtmTsA6GPcoyspJ8bIASF
 kekmOCXa3KLy9EpAlVatr31e3lhBnzpvVKbqHEYRvFDdPLAb+SRUQEPqIVrjUavr33mP
 ZL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413654; x=1784018454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcLDM0HJqXP1sY7px++lwokDfl8qz7DTwhSghuXc6mo=;
 b=hM6Q6sQePrERERnEmV0xxoFXVniB3a9rzCpx706HCMd2ESePlGZ0dk8EP0SkKidRd6
 SWnqTi+S4Rgx5SQUVpoIQiu5xYFpQE5y7W5j+wD8iWPUuV3ha2jocWUN+EOjaZupaa2n
 trpytCdvDoDC9VEYmRcwlAmnvhDuG5V+fMwK/lL2DWqze4bS7YxV0GBcwdrWLAacX/mw
 36R5+9jl6ArjuO88jaiMuELV2AwU7YdYMVMHnCMvpr6WPZi2rW4w9jld11elhhpnfXUi
 tfh4X79msNTSfYmWN+xi6HxpIIEOiMbxYuYSZtkE7RuKRvviIl1nXBCXCUDi3sr4jtGE
 /imQ==
X-Gm-Message-State: AOJu0YymUyHDv3DG6V8ZJdcXQZCJ2iqCwoziEAHtSlwQQCTspxRLn3MN
 qCWbEYJLVqKLdUz7hPSs7JcJggeGkVSCN+1wOsh0oWrdLhYVCKw2FQeFPYysEfZNZmgqKDEqgLG
 O1JZviszCG/vlZckoRI9iCiaejLaQuIUIrmGIP8XKaXCmobS83AoexA2kuZk/TP368A==
X-Gm-Gg: AfdE7clEHCw3cicP8xhQVZBL8zEmIlruow2bZdcWzJO9ORQ8PzspmxBLUa0UIvE8+lY
 IAdrncmNZL6i/fsIb10v6OiNBftSwSGMmyM07GUxky7Y9u/BANDtE7jfCVMhlewLgSBHhshg9wb
 DVLXMWKtueiaC9jn8HcITucNgh0tKar97YD91apF+yMcNSWFfEBjn6MVGW4/F6xdFOAStXPKCMd
 vpyscjsSZigu8lm7QqGt1kElPDDIHOuPdqYy1q5qQQ/3x4sIGRGI0iyOAhwnpF6a5bVrNrMeSH5
 zFQQGQNLd9CKuAbCl7KNf4xNolOQ5hA1m0xu1pxbkHInWvqcMKFuAltTpFYAFV4bVWFeMoMpgMz
 74DJrYNSYLYEm6bTZ/5KuFVjEe1G0gNb+0peAGJ28APFj6YR3Mb/nRJsvNnz5vpmr/Z1Z
X-Received: by 2002:a05:622a:1:b0:51c:1590:8e13 with SMTP id
 d75a77b69052e-51c747aea20mr51213181cf.4.1783413653904; 
 Tue, 07 Jul 2026 01:40:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1:b0:51c:1590:8e13 with SMTP id
 d75a77b69052e-51c747aea20mr51213001cf.4.1783413653544; 
 Tue, 07 Jul 2026 01:40:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f51193sm40082665e9.12.2026.07.07.01.40.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 01:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/3] hw/pci: Consider reserved slots mask when checking PCI
 bus is full
Date: Tue,  7 Jul 2026 10:40:47 +0200
Message-ID: <20260707084050.32137-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX+1dC2twYOQ8k
 a8DI4ixAzG85UXEpkpJlKZy+p7iC2SAsc7+L+3mlPFczLFWL6bagKfe2zlqxBDWJ/23vhRQfuAf
 hE8JoZ2YCctVT+E+1R90dSUMe+tsV1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX8pgUGZa09d81
 1EZ0jZnaqezKjaTg6Nd1YP/nwtLDBTBmt9/wLcKWMyY5M0O+k7d27Co0k4oYek/fqSauhUfJddj
 VFopm76S/URL7lwIlz4YLZtdE8gilg4iqWOnE0PQOr663v0BSrleclf4Bil2Xu8XvQnp1OQ5tZR
 exHEqvMROj2tXqqAKT3tQ5MuK4iYa3jfQ61B4V8ggWPfDd+F1dhp6+Xr00D4MCWdee6y76eJyWO
 S/76VzPChhoc91GSuI94hA4jrx0lHW4sFEv5mrGWqwsPJslYRYfOgA2DEtWCLQQNpzobUNTC+y9
 JW00gZtn/ioTNYlCWscTwWIKouf/bejUZK447xhwZQjBR6JCgwd8xrAujAEm7HSZ05psgBE+w2W
 0yDkFDgHicoWwBdwosleAm3m2Kp+k9mfndK3zc1vyXa3Ylmt9AjrWgkJitgukD28CzJQ4VYLpvU
 vwZ30/sM8erFm1K7k8g==
X-Proofpoint-GUID: CV0lmUqmCnyMauTLz3Z85yBH3hwwZLvF
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cbb96 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ho9LhJ0hDLnLZcIwV9MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: CV0lmUqmCnyMauTLz3Z85yBH3hwwZLvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Generic fix for the SPARC/Sabre issue reported by Thomas:
https://lore.kernel.org/qemu-devel/20260309181452.83702-1-thuth@redhat.com/
"hw/sparc64/sun4u: Mark unusable PCI busses as full to ease device plugging"

Philippe Mathieu-Daudé (3):
  hw/pci: Have various pci_bus*() methods take a const PCIBus argument
  hw/qdev: Introduce BusClass::is_full() handler
  hw/pci: Consider reserved slots mask when checking PCI bus is full

 include/hw/core/qdev.h              |  5 +++++
 include/hw/pci/pci.h                | 10 ++++-----
 include/hw/pci/pci_bus.h            | 10 ++++-----
 hw/pci-bridge/pci_expander_bridge.c |  4 ++--
 hw/pci/pci.c                        | 35 +++++++++++++++++++++--------
 system/qdev-monitor.c               |  3 +++
 6 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.53.0


