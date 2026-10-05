Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855EACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnrf-0000AK-0U; Mon, 05 Oct 2026 14:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqs-0007lG-N5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqq-0005p3-WF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLKXp2909384
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gnr7ETlxOnhF8QxzXIZ1+lrtb7CedFmjamJqa3Ob5NE=; b=eV8Apd94sovNjF7S
 I0Jml6zkQ8C1jUjJEGy6hjuqSCWu1IuhjYGAR95mJ8+9bctLaUpnJ7yvPmzzDnEY
 O/6T6dG8aNQnysEYdM9GD3QriSh/FS+NPc7/hz9kJTg4qBDeFVt0v5tuwLCvCt9v
 kS6mHLMBfhPH4uJGmZGRAnC9bs+at7vhmyJNYg2yNch2rF7P/Dw49+piBmwwyOTC
 WfGMlUToRJz/jp6E0hDG0sJSm03ZYCKeMpWl1qH5LEAdUI+E2JjNrZsJ+aZsCmyh
 vSGbD6qCO+vK12mobx+RTGf7vynOK2s4m9t5Lp39tCLvn8YwX6Ud0DAGVZXcCpwV
 vldjsA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg1py6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30f1b904861so2464072eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226541; x=1791831341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gnr7ETlxOnhF8QxzXIZ1+lrtb7CedFmjamJqa3Ob5NE=;
 b=TjfroPwltpMLZXFH4HzVhueF75emk5horZyYlk1pP5CL9+tL2iVFLui6XcPPwbQLAT
 NiuLSW9ZUmm++dHWoPmYklmBdxsYA2ze5xV5Q6zT7tig+cCUsm3//NKUCscG3tmVgN9X
 rpD1J6/iK8AnipiCHFY5EGdUMjARUQ62ShuHqkyqeUVGrSH4BAPNMZstcHn5ETZ2mOb9
 n03kY3Rw7sYW1YCuAmF+PQ5SBlb68CCu4Rmtyok0mrkEzTAdjFXzv4mrZfEFTDfF/Jg+
 MdqbgQ9BKATNEVnVhs5Pjuh5fFTZvhF3IFXoMe6YsofL2hDpFMJBhq1bWPIQHJFLyO1u
 U58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226541; x=1791831341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gnr7ETlxOnhF8QxzXIZ1+lrtb7CedFmjamJqa3Ob5NE=;
 b=D5KQ4qD+9F+qdgBWYszR5UB56G8nHHpxStGAU/tf5pUaiWTqzQ/+rclYMrigb0PRqN
 ipPFSjdgBmUAhvXbrKRaF5EaAyN92O9IBIXVLIaWky7Bg+U1odsHJNmKkeRR/PXXE7n5
 QlyaiYxMPVNR/NwuRIO267J8tAhVtJ63Ds6lJivgMaIqXLiLCaSohDWWSsUdqQc5MQQZ
 m3uQIEVssxKVFWybvdmR3xXU1jdy+b7GkyPwsER6QgYSTrQtml1wb+YpuyRmwX49oovh
 sdTXyTJdXaTrzognrgQaWwznss5Xi6RFC0Bqh2kgFUYvS+Wuoj5mXnLvxLzaODX8vl+8
 ZqiA==
X-Gm-Message-State: AFuF++k4DZ77kppUQM17i3TAIsKKKuGPtoggIzOYOC2xgT0YzB0x9KYZ
 YfLvucZNyUgkC2mYStUMEzjIuGEKjTKflb3gObcaGOXjVfPQPLXuFhpbqPIFEEV3VZIY0zGZyxA
 q5d50uYmZjCunzlLXbdz7kgtAuenHZBY2y2AKIkHCIXGuqwBvw0gWWCvht+gVoEcdqA==
X-Gm-Gg: AYBFou1Vj6f0FkPM+e1SLQMWs3H5qLQlTpclgK43FPtw6gdf/lG9z0KL2jycyo2RmL5
 bqIuhzbOCGqKf13juviwLhc47IJeg/qDQRbGQxGqORpvEfU8lA1MGUY3aoDdcjx/A8aOL86AqVt
 Cbv9bfiirkNXhfrKrMHwgDcCrpAmtNDRJaeabHn65bd3L/jJ+2EPy4h4pLyptn0Q1hSGiy7WV4U
 ocn4YVtg2P6FGSPJYojb+2BivawV+TwnqFruGe9EHWeweFhAuVnBPT+5TUFh2QBjZZptfbqYow7
 QJE/uppBT5Hn/5wwOH8sB4BEGo0PheHcTsL9llWvMIV6Gh9/ok/xgnevOeCRK29vxHDa/6iu8Gu
 uuV4r1ANXwUBL4GN75kb/It9rzn/acxA63DCtTIMpxD8AoFKR2fWWk0B/90jf
X-Received: by 2002:a05:701b:4518:20b0:151:8280:2c1a with SMTP id
 a92af1059eb24-151c406f5b2mr10562310c88.42.1791226540955; 
 Mon, 05 Oct 2026 11:55:40 -0700 (PDT)
X-Received: by 2002:a05:701b:4518:20b0:151:8280:2c1a with SMTP id
 a92af1059eb24-151c406f5b2mr10562271c88.42.1791226540266; 
 Mon, 05 Oct 2026 11:55:40 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 21/22] meson.build: add or1k-softmmu to multi-target
Date: Mon,  5 Oct 2026 11:54:57 -0700
Message-ID: <20261005185458.405929-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oJGMmtz8o9-rqaqPrFfJYpj7OKUn3GEX
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3f2ad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX1SDItClsZVet
 mgX4C0MY4dUTqWYwF+djdztOaPCQZgWJWIqrGKJAXeMD5NOD/yHbv60UGMZFgsc1bIpiS18craT
 4G24mp+RwLws4i5pfEwvn0sIZOUIwUQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/MXBTpmxAKQi
 jGYf0oueQMZbXlmryQXbUk7gr8/VUSowmTqrp28MVDk/B1RjKc7MaAFp/7laKJc92ud56nFQ8uQ
 QLvhw6lyZULg3MEIQPa1Wo69qCaZ3gLm29RgCN1H9gVmNimFAdypBhqNovSEKgf43czQuMsWg89
 vJVLL93XyoS8hmNuNoh8/IBXIs/T9Z13d6JKY5o0vOy1fE21n+mh2P3G7bJt0GKJByoA4EHFIvv
 nnLjfFFqVJreDWjfsf5FvVPhyDNHvJq7VE5gHtV2eoHDBprgKqvZyweLmiEmbrV2dJYUBL9zxRO
 1PlWXxYz9q+WTILbMyZyC/OXbW2NN+knyoWIv6/GBI8YcpyKegfKdchAYfgnafWYenTPM3WebKL
 HFDBP+GsFNsPtNyHEaMbE8dzCtltE4nmjfAlhm9F0+G26woDmcwncMQEQe3Avf15YkpuFAmYP17
 PGSqXV7YJ5YCexkWFjA==
X-Proofpoint-GUID: oJGMmtz8o9-rqaqPrFfJYpj7OKUn3GEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-22-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 335d3dcf772..828100de816 100644
--- a/meson.build
+++ b/meson.build
@@ -4269,6 +4269,7 @@ multi_target_supported_targets = [
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
+  'or1k-softmmu',
   'rx-softmmu',
   'tricore-softmmu',
 ]
-- 
2.47.3


