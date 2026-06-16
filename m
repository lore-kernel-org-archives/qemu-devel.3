Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC8CCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXyi-0005qM-IE; Tue, 16 Jun 2026 13:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXyZ-0005kW-UF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:53:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXyY-0002Eu-6V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:53:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH9bTr4168218
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Bbxu8xLDsaH+oaxzGq5ISEb5EPAwkceAlkA
 k6z7aKJo=; b=EQFNkwAXPYSu5vjjKw+9g0nNRnmNjYU1N5V+ylOIY58CsHovFpd
 taZN6sPkCTqfFSJPuwifjmtXmyb9DVRgyL2OLGOMbgNHoXxjrux0bZOqabM/JLXI
 F4X9rRVSNdVyGkyz1ol0LdIObiQIhcQjK22Wo3tQowmWPrf+vCS/y802AU3xyxRX
 40tbjT5INeXLoWZRrkLeUqwUjQgwH38sEDaEUzW/UdsesM+kj6TglNNSvfpV/ZoL
 ZLR5T+830g3Yis63FU/aXyWZGl9rt/GuFg8N7jn2E/0KgayYRP5SAqvk7sLE6cDV
 F0YyqX6kk64ICRj8MF8VQusJ0J6Rhqq992g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ystut8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:53:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so3303801a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781632403; x=1782237203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bbxu8xLDsaH+oaxzGq5ISEb5EPAwkceAlkAk6z7aKJo=;
 b=TagcMGT2JqUAwPawWEtF+8Y9IqInnNn/s/n5L4x+QC60wX5jJxbxTtNUOXz1MCzVcL
 CZqYmwwHdQePsETKUVcZBeGW36LItkBYFlO0qpLn/01vPcVoLi4BRag1Ha1sxIkl0SbC
 6cLXf7IjB7K/MCPUTO3WPfY5flakNd3KmPPACA1BrvOy+VAL7AwtVOeOinweqQ4Zk01N
 8hYKc8BEj3alwq2D6ePHx6J/GEbVBEo4or2iZ/OZjTVkGqdnEsg6MvYxdGcpk7uEt2Wd
 5cgmXOQ7RHhUaSDb41NAAzVQO4Xpn0WLU0r6G5h3GPa8Y6lInGK8aOleaZ3ogfkFK0ED
 BVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632403; x=1782237203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bbxu8xLDsaH+oaxzGq5ISEb5EPAwkceAlkAk6z7aKJo=;
 b=LfY9eQcoFXRBdj/3lHv4yh3CA8bjwaIArkGL8qSRdwiqTqbEmPRM4ZZeoO7L93G+Xr
 8OeIXqSbGOdRLWY+UIzXzUI/yhd+tFIl5RVm+Q5lukr9vUVm+aBq7Cuygrfsuob80GgJ
 hE3A361tH6l7z1tuJG25tckLVi7ZeIMHbj5SEGIiecdhBNtLC1loDP442NqSKgv2PB4/
 kU+DEB/M45V1xziCmnp1hJIjQg6yYae8IiwAkBP6VYFb4Ztb8mw3Dz9pbM9y2v3St0kc
 flbPVbMUhq2QfVgnCqqIrRngfefK22rvnbupwc0dwfT+q0KzC/FXRCTMNbELk+sGZLVN
 NDyA==
X-Gm-Message-State: AOJu0YxSUhxDWr+4LIrRObVt8hKJMPb9vsPg5g3JoKH0D4sCOwJRzUSA
 81enYzJ6cALtFsHgZv1GSEbqak/XOan7MTsQkaL/FvKNBmHWQ+VO5+KwRUm+xVmjrE8sQ5k4r/7
 T4HKN8BN4vTYxjChgbmEtThWYN2iKa+rRyRr1FaIRXySq0Zm1fGrC0joCDNE3itouoC3X
X-Gm-Gg: Acq92OH33WIKIuTXmF2Yft1JQofEs5R2HeG7xE9dyQW+DAmVnghgVPXWA/mJV72pERb
 qGl/sku5LD7CqFJqbmNjmwExUpow3X7eSPFZZfoW6KWdPBOpdZTlvzaLaoWvo9xtnS4BZUW7/nR
 oycKpA8raC7ipx+EGk5YF/ki/1EcjE9+icfJ7yagspSLTdiMH7w1Hp39fxTI2q7k8O0dlvVKBcd
 HXg8DGD7m8FpTrgA43opJcwbtyJoX5d10LNjLOTlLF4SwIdeUAb3WUKVVgD5QSk0SkTRnTuUZue
 eMN1yuXNKJ9ng8PzPyUSOjOz39hRwq8MiFhlbzT/X7IBQcy0XqGFe+1gPPhrK1xjwNDVKZbc6yg
 wlFhqE4CPtHThah5gaQTemtQgQXSJdoGzpSBoiv70TqMqSIDfeXYJW73vSVgQbfDJ3c/3/TJ1jX
 AmZsF5NjM=
X-Received: by 2002:a05:6a00:8014:b0:842:74e3:48a9 with SMTP id
 d2e1a72fcca58-8452445a68amr183669b3a.12.1781632403414; 
 Tue, 16 Jun 2026 10:53:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:8014:b0:842:74e3:48a9 with SMTP id
 d2e1a72fcca58-8452445a68amr183642b3a.12.1781632402995; 
 Tue, 16 Jun 2026 10:53:22 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14537865b3a.54.2026.06.16.10.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 10:53:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Docs update for 2026-06-16
Date: Tue, 16 Jun 2026 10:53:15 -0700
Message-ID: <20260616175316.264758-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7diITN0kxowjhfZLFOyqElW5IddKQIuQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX5klYDTcrxPOA
 roRqMFN89AGfvYEXhm+DOuIiCJA66OPdgfas0AnnWC8txxO6GZ2vsz3jT7Bnrz64rm5XnsD2bGF
 c/MUmJBEdyoxUA7E6v1M+jBjFKqqGP0=
X-Proofpoint-ORIG-GUID: 7diITN0kxowjhfZLFOyqElW5IddKQIuQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX8X9pXs+vb2VG
 LfCDb49n8skwp1tzUJpYiwchdxeNEhsUlm17cKMdU2Et3YQFGgAp9sycDiQH2ev/B5hMCch83tu
 Ibd8jlOR1dDfmbNErVsjMmzfnHHLe8oQvbefp2iub3KWusw+GBN0FHkLcxK7ip3AdBw8pd5CQcq
 sojzCgA5oDbuVr/aXE8pmD3fC/nIo4T2rF67FtIBAgdwEHKXBWpLJUrR8ri9ExzceOiQdLllKo6
 Cj41rWOa6tdvRSYAOWSVr9toOfkRn2gBP3JVjFjAeakBPemuhPebkE4KuTwkPJJmw/1bdGMt0TX
 zrzXbFMl8nUjo05HVNcNtR/kasXbcmM81eOLrV5hLqBFCWWLJB8eGhJDRizFKdxEjf3xLP4YAbK
 oYIPqvHaqgguXD8IkQ+TwXlYgBVonl3nri6vPF3PEsp7im3Jk/9ypIp1nwq/6FDDhdfqvspT8Xl
 4Ck/g6oAnRvN2FR70ng==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a318d94 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=G-81AXr2r0-U5TI923EA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160183
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

The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:

  Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260616

for you to fetch changes up to f00622a929b296902f9b23a5fd5dc1b5988e669a:

  add a note on -shim to direct kernel boot docs (2026-06-16 10:48:14 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2] add a note on -shim to direct kernel boot docs (Gerd Hoffmann <kraxel@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20260612161707.158029-1-kraxel@redhat.com

----------------------------------------------------------------
Gerd Hoffmann (1):
      add a note on -shim to direct kernel boot docs

 docs/system/linuxboot.rst | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

