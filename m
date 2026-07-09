Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CB6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whroG-000374-5i; Thu, 09 Jul 2026 12:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroE-00036n-Ph
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroC-0003ab-UD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669GIWDZ2160238
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=d68sAPE0898RZmjfUVKpgI
 vwwr5NxY3/xzv49IdhG58=; b=lRWqkqzfGMo8AO5p8fANiB5Wwg+66583oL3sMK
 aoM7XBhaea1Kz6SR6QFr0JzI4IG0aI1NxXI1aZTJvgeOHpNjffGq+qxIRgSylXYs
 x84dOo5QFQ0AXqPZzZHf/9d7VPnUrfzoEsPpoCn9A8YoW2eJSuQMcscq0e8pgVr2
 gX6yh3FQzFzKkvWNLEx/3DnR0ek9K0n3sMZAYEJqu6eOPhphqSS0JGjQEBATqg0e
 C75Kw22lQfkHWloYSNBRCZIfTWLFUIeSq1mZW9wfchq5TzLuQ6TvGHx4FCxbhXLt
 2bW/Nj5Ql5KDUFH2rJPYj/rgmbxySvXeb1TYAhcRHLnYY42w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24r46x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:41:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso38684191cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783615266; x=1784220066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d68sAPE0898RZmjfUVKpgIvwwr5NxY3/xzv49IdhG58=;
 b=ds1lrjAl9t56Wb82yFCP4/O8kuDKhtGBuy8vcu4N++LQjx5WkRMvPA8kmxBcNgI48i
 1oHNc6pdD/9Nx0n/pHkMP+WKDL/Zrgnh1VgP4KVkXBlof1e+Sp+ydX65z/5eD9uMhzge
 eMClmf3z7UyQwoWIm76eHgz7rUwcbHz4tzzVJgcs+uUV+mSGftmxAH3sONf7zEkGv0gO
 75vEaphh8MAmAYSZ3Vp38PnfcanU1dqRWjDX0QNnQY4tnzELtTTq2mP96RbDmRFdhsmS
 fw5R9IF/2ewMpHSUsUj/vKNhwNZFQwAWlV+k7BV+iuMIj8CpMksSQnLCU5cHzrPGYBB2
 2T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615266; x=1784220066;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d68sAPE0898RZmjfUVKpgIvwwr5NxY3/xzv49IdhG58=;
 b=sMak49s+gw5HFSgKOCOT5LvsCARg7dP5HuubPbG03kxLLF+vjHZHzeWFD+FuRVvifk
 JpJlN09iJMoHFo5nU2WFQqyX5qJDfp7gEs/lHu35B1xLYlhCj/dx48T22s2C2gnzja2B
 pbA3RdKl9b0xQZ9J6qNxoY6vskteBZ3Z26MHXRpsHnYik9G9VrVMHYNpLozNjBke2NE+
 f9KdW1ekR0FQ+RnVz4z6PbzHHQZn0o5CBplWhGU8D8O1On6FWeOKnONmnRE4sF1GLeeB
 JpoHDXYdL8l1JmzIwomVhiwZEn8uoxYqDkPvyb65Oqq9YGu3lQ+qgpMffcZERtI9FUCl
 snSw==
X-Gm-Message-State: AOJu0YxT+63N5QGcxEBdeuBRY4MMPb8rnK/p/e0FhxiejYj6QL8a2eJJ
 M/kOsP0oqzaiXI5Avhh73kbEgwuJ6QRygF3txYT6XY1PCzlfSaypyJ8d7lTpMIkM0vJRU3ztGUh
 UtXjACqwzxtvFq9w7ErB9wRe+obQsx/aCimtF22eLdZd/9L6Fp9A4Jr4VWYyeH5ERkg==
X-Gm-Gg: AfdE7clofm6NKCxnZhC/4+Q6BgVaBvMX9cQa1ZbXdqRYRQ+2Euz4LkRSOVgFDHUH5z2
 URuPK+e0VXA2Mwx1gmmC1c4lLZi5AlDjsP7+pgKJ15h4kaDPjuB5tBEhtBOnZpPwRAxrfCU/nmp
 oHmL1EI6G23a/NS7Kf4yLQn94btyBvoVG80SUItZjNskpBfV2t/QgKzAoQVFvAGWvXNpksOq8RE
 1bEnOIAz3n/azVnCcpfeaUmlGi/bke3CnAONq8+AgMX8kzb39g/dKfpZoq16aOSOyehyYrauAXM
 tGk36gOe1WKJqZ+yHL/PdddLuu0dJziE5qUI9SlDY23DJDhUZ1wlZCK9cFloxicsf7/+jLiQfjM
 qDHX1a2B34tBxoPRyAVI1rvcedtR8/jpgKqiMU7jPvl5FyKCqC1hFfMDq2xdiqCStHKjE
X-Received: by 2002:a05:622a:1925:b0:51c:1291:911c with SMTP id
 d75a77b69052e-51c8b398cf4mr98935751cf.14.1783615266235; 
 Thu, 09 Jul 2026 09:41:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1925:b0:51c:1291:911c with SMTP id
 d75a77b69052e-51c8b398cf4mr98935361cf.14.1783615265853; 
 Thu, 09 Jul 2026 09:41:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3b85sm118786835e9.2.2026.07.09.09.41.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jul 2026 09:41:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/3] hw/arm/aspeed: Various Kconfig fixes
Date: Thu,  9 Jul 2026 18:40:59 +0200
Message-ID: <20260709164103.37614-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8b5VFu9StNU-z4X1mImBIjTfqRZomEgV
X-Proofpoint-ORIG-GUID: 8b5VFu9StNU-z4X1mImBIjTfqRZomEgV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX8UvnpU1ryhRo
 Znx9zjzkxztRBxmj/+JcNZQBc3otrkBfvSmpwjRkqDRPzjIvszPeLbOhFi1zVkIZdNumm6asZap
 lYA+YsL4mj4m+GXHSAFztJ2ReCm1SBE=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a4fcf22 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gbvC6g8y90-K_Dm3SbQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX7Ib1Ysqq02Zn
 JQBA2Zu2y0nwizV76dbEQ4LStuLn+css6PxDvXS+Oou95Jcp2UUY6jEQ0+ZGHdHPkZiAAr09Otz
 /Qt34yxTFT3lBR8vGHMAS2N7YWLOB0cx1YftmHWMh8hX1gfrD69UbqaBsF0ci6uleKBTkK22Tgu
 liWIX/jV25nOy+VqeGgbYngDIkK3m8Eqj1oJ+HqkFSgWxqiO2lAik6FOqsk2j6v6cArcGiSuW6P
 o0oc+4MnnS29XB1C8gGjVD8MqUj4DDQVG0Da1Te/QsqkPr0vVixe6zaXQAHpJOJaJxzT5h46vHt
 vJkzWX+DWbX9SoW6uUevFWWOfsTEXB6igF1ASeKGoEcqJzCMjI1R2nNzbti7htc0wNELTnumDA6
 DWM03ounE6t0vX5lvC/pPOq8Z8ijOp7YGZUAiKTkHzBdrNk2B+Unp7g8J3eiATFF1sRpcNoFhDj
 9kzDWFoTr5gJMXDcszg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090163
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Trivial fixes for binaries configured with:

  $ echo CONFIG_ASPEED_SOC=y > configs/devices/aarch64-softmmu/aspeed.mak
  $ ./configure --with-devices-aarch64=aspeed --without-default-devices

Philippe Mathieu-Daudé (3):
  hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
  hw/arm/aspeed: Add missing Kconfig dependencies on required components
  hw/arm/aspeed: Add missing Kconfig dependencies on optional components

 hw/arm/Kconfig      | 6 +++++-
 hw/pci-host/Kconfig | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.53.0


