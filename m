Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49678606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yp9FIJmc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=afPoB9jH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzLn-0007CV-Bz; Fri, 27 Nov 2026 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJM-0006DS-6U
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzJF-00026K-30
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:00:31 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpYGx2925626
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=aRwtEqbh0B16CujcN8M8p5
 Z2mM3ISy6+ZtqKfjAqZbk=; b=Yp9FIJmcdFuz1O8nw8CrHwjspfELgFi9/dzdVm
 9i9vaKPVm4GIK3RXyNztMvepZDFkOgcEKciV3Iuv+bbwqcnUbcc4+AuGJ9iKEonH
 32YbUPNnQVdmIpJJH4Y3r9sKjo6wcJlB4VwPQjwF1TX6QtguZiKN9yCxALW3CoWz
 xGFNrIJU6FM3U0E996xz2stscvgCAQJsPO6AU4aWsBIr5yHvBN332GndYxyZHS61
 xPvwIcRWeI00GDgObY5etrmlNzQiMdk0Br5GCv4Oai7y0GNEruPVvglqdRUygNSc
 FyYgmB0Kdtz56Ja3RJOYVj3ayvcR6BBCevE99kPnWRm20lxg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhjj76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:00:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8a01e2962a1so6343442b3a.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795798819; x=1796403619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aRwtEqbh0B16CujcN8M8p5Z2mM3ISy6+ZtqKfjAqZbk=;
 b=afPoB9jHQKoBDofdY3pQs/9HInfzzU4yDRNPZh6VwezjUo/wdU/EJ2bz2AtRDSAmfa
 cmHQx32N4wZXbByrFQo6JLDIA0+G+GmLhFWJRPc+15+Kad69G5JcD66zPTwzpc+nJXd5
 55yTxcQNL3a9xQPjB+8uGAsYaD8zvJl8Ui14q+mOrpnVGBWeiHyVaquSIAQyRcZbcDiz
 vD+Jpub24nPyqZfkRYv8xx2AfK60ry/gtcEtVM2J/U+7koqTzmLNnainA5ACQTfZNs6h
 pq8Xujot/ZELlrf9h1i/J2i4mghrqDhD5nnK2slsGzjWgsr7BMoVBMnFiZtBpLtIx+yj
 knrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798819; x=1796403619;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aRwtEqbh0B16CujcN8M8p5Z2mM3ISy6+ZtqKfjAqZbk=;
 b=pFd1brjZtD+p+IfpFhCV93t8BhKWvvIjROwZ8sh56hhFkLPbhy5n9NMJZn+W/50QJk
 4ENSKtwuk4cBh7bN0IYmZdvdHVAJStA8Coh9wFB7lM53OZoCHZE0AOBNEZHVXDcbr980
 T6q2AmDkHfw5slhfMrvT1dpHhi9f7HNzUxyGaOT7Nu0nNU/4GXgLBDxbDDBOtk4j1gjl
 EpMlOTnLQNicSrcIYQ37L3S4P4jK+uGlYdEcZl/dK03O9IskesQpatE+nBeh8XLNIPZ4
 YuXDu5WjyejezQB13ZQnYDkEDO3+DbUox9K+FIa1KiRx5wpvU5d9oRGsTjbNoe1YfvpP
 xmag==
X-Gm-Message-State: APuU4Z/v1XZZqUEUo9fFDxCkzEhgXjWHged4rh0Pm0ADZnDvTVUaRKjA
 cL2xPQ0CJRf8+Zkec4ZxT1kC0m5V/ffxO4UUQg15rl3MgFM3gNnZghpkmkLm64+D0tZCj8q3ZSE
 4hjIofhv8Vp+tCUGwcu4NOAxnsSwauv6VuxVcHuEl0KfffAzVqyPZnosaH53x3VtrxQ==
X-Gm-Gg: AZFdTZd4PFjgKId742GCynbDTAajs+UwqDya2C1B+HqdIDxoSkAzV07UZWaHAGOrkiF
 q2CvUuYAK7U5MRPugNw0VVNDSs8zx/wr+GpkEUtAt0TYCx/v/XuvFWsLtK/EHP0DWiMnw9tne3M
 aJbaGDvCwMNlM9qIx+5wciMLGHj23S72dou2KclZKvBEnhkI4PEtHwwKQU1mgftjRT7zuu0crjU
 X4XEyj54fQujKyf19yv3zePJtXFXIczcmlGb9Nbu76yrLQqjDwnU5x+TC425Yb0DCsNACxoEzgY
 Qh98jt/cb8iMyoFY//xCPhVz/JU7oGH1sAVKcCGCP3r7GXnS/7g9d3A7oLXoNUuc85gnZb66E8K
 uEvLzsowbJji8N144G6ZRLzeThz4MVQAJHEnTSPB+8f8Z3AjeOHTUVrLwOmXYz4MT/zI1xWPTfX
 kVP2WeyMXNZvboN9/YQSVY1sgyROBhrpe0Qq5D
X-Received: by 2002:a05:6a00:4fcf:b0:8a0:5d6f:8a5b with SMTP id
 d2e1a72fcca58-8c87d70b055mr24117995b3a.50.1795798818466; 
 Fri, 27 Nov 2026 09:00:18 -0800 (PST)
X-Received: by 2002:a05:6a00:4fcf:b0:8a0:5d6f:8a5b with SMTP id
 d2e1a72fcca58-8c87d70b055mr24117928b3a.50.1795798817867; 
 Fri, 27 Nov 2026 09:00:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077a058sm13014650b3a.8.2026.11.27.09.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:00:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] Fixes for 11.2: docker + plugins + gdbstub
Date: Fri, 27 Nov 2026 16:59:50 +0000
Message-ID: <20261127165953.51257-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX744imVADlWZK
 VroLiGShouO+eR76FXDx/widCid97+9pOWbYmuhsbnXYh32FQHkLVyFKl+1vt2rZlsbMTeYL0I/
 u4w+rpJz7Rq0l4+f4lyeRHa0ib8N0f4=
X-Proofpoint-ORIG-GUID: LJW4YZsaice7vzRSQAcIEynuOXiw-6f2
X-Proofpoint-GUID: LJW4YZsaice7vzRSQAcIEynuOXiw-6f2
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09b723 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=bE78bsctrH0UH5uGkF4A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX9lGncaXzcHfw
 2LNtuo245x8NAjdVlntqKXr5qThZzy6ppXSmDwQtSOACbaUK4fR5O0HIK6HyFTTEtP0eEaQxyfK
 Txl3wsV+OymzQ3r08aEt0t5+xBAcQTxjb1T6iCo6yKx5wMfPSCONoFOghyciIHQrhduwe9Gdl7X
 0HxYlo6rRR9fhcOyH2TD4yf1KS41o2u9wt4gt2ljleuQeayIcFDXo9C0Jdr4G2fDxI2dZM2Y0RZ
 uZ9I1NQFRwyKJ2wLBYBAg0WviQcKHyuVTB/hHpxU8IO0CC0bbewyV6k4uDvYIEAX6ujbK2KFfjX
 KKyZIZUE3LDR/2KUVcDGAmnoYOhnaLL/tFBbxDL0g3FgPqS7ldwynmIQSlhb/cIY/bOaPBDPb6c
 5kIC50zg+EFZ274y40WAatpRspvKjnRBKWFVwT/a3mztBESc/RW7M9Es+Fe10vljBWAqoX2FfVc
 YH7/4YXqFrT4nKrHUIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 9751c62358073580cbf330a4df22077a7c6a407c:

  Update version for v11.2.0-rc2 release (2026-11-25 21:39:27 -0800)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/fixes_11.2-20261127

for you to fetch changes up to ff4c3cf7ca6afd7f3da1a011be304f897d2d5fab:

  gdbstub: reset supported features on Supported request (2026-11-27 16:58:43 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] tests/lcitool: Switch to a newer version of netmap and check (Thomas Huth <thuth@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20261106063103.21061-1-thuth@redhat.com
- [PATCH] contrib/plugins/uftrace_symbols.py: ignore warning reported (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261118021020.1253822-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH v2] gdbstub: reset supported features on Supported request (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Justin Sapp (1):
      gdbstub: reset supported features on Supported request

Pierrick Bouvier (1):
      contrib/plugins/uftrace_symbols.py: ignore warning reported by llvm-addr2line

Thomas Huth (1):
      tests/lcitool: Switch to a newer version of netmap and check it out faster

 contrib/plugins/uftrace_symbols.py     |  3 ++-
 gdbstub/gdbstub.c                      | 15 +++++++--------
 gdbstub/user.c                         |  4 +---
 tests/docker/dockerfiles/debian.docker |  4 ++--
 tests/lcitool/refresh                  |  4 ++--
 5 files changed, 14 insertions(+), 16 deletions(-)

