Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5DBFDEE50
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1l7-0002el-5q; Thu, 23 Apr 2026 17:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1l5-0002eU-LK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:38:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1l4-000225-6v
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:38:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFr4nS154571
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZnaNdXuSZf0U9ozyEQmo9n
 U+k9nzTVImUs28z+4Wjx0=; b=Vz9OreM058TP5GQK7q3BSywX/h2d2Ra2DcqYlM
 JDu/PeTgN5iSEDOipweyrEnTPBpCgSBTuQdwOLf3jxM2YmJsf7Ysdkiqtcsq2Lka
 29pNwkvPkbqelYyX5cVe4EFr69guVLoSjYjSuj78QRp/TGqfvq2qLVLS63kjPvNq
 eMMJ4deNv3I3umxl2m0ToAzpmHlPBqyO3yOXAo6UreB3gIdyRljMmd4o91t5GcAx
 xZxVDy2agjXZkxAhQgTLZ2gax2bABLUhLN3VcwnHLl6IMSMzIFzI131HhhJwCKXa
 vmhJx7B014bUocMr1+nELCnXVXDEHU3umla+4/Xg6yn4yqOA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpf61fkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:38:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso9149943eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776980327; x=1777585127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnaNdXuSZf0U9ozyEQmo9nU+k9nzTVImUs28z+4Wjx0=;
 b=h7hZvnyFQPwASVCmOz9PNhvYgCAT1s52/cFoJ4WUCImyrc/XrdBKQzIpKnaJ/VYr5m
 H2rM/DrqRSN+TaG2q/yyMmRlnkQjJmZWtaDz0r7WikaIgVrzzaLKOwTibE/EGXs6qKLA
 mW1PEXCtsQ1LRMEYbneF5yFpClNc1R3um9FKg/gR6MscOGrJgBuq6DIGEfilD0B91Z9A
 cZ9doWCylWQzcmZcHTKdOjawZ4OXkGIU7juZ0DWkzDJ7a7ygJY8qAqYIz6OURm9hV3Bm
 3ZxC+d7mdaQ8C6QwYngKqYkdC864w4AM3d49h4+fIPr4OGrmXsm3sj3c2225dAmHLZx5
 Uvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980327; x=1777585127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnaNdXuSZf0U9ozyEQmo9nU+k9nzTVImUs28z+4Wjx0=;
 b=N4kBPAVR0cHWGTzkUyqj+2Ni+ROdp+uabeh2QwZILNlFtemCi+sDhkwDc8XgIPCOfs
 9Yjx8iIztz5hIVlwgrwf7Ncq+xTtZ0drBUtRCJeueZOs0mgKe0JBbFGM9TYZF9JhOa6K
 o+1X59caXrj1j11Qa3QDkJqq5/eAmdFvpdNr2v7YnfB/L8Ce79eDtsNinz1A4VO3Zcmp
 PbA3qCpI15mwwjKV5FmJ1Qero42zCZp0FBuI8aZ0zMJqOBt5+TCHlAXiTE8LNHGYRiql
 oV5fQjv9GvJChV39LqJCt3KT8rDjZHibBk5SS/EplYpavGRthRLUjwRUC/yPtQvcY1Qn
 rumg==
X-Gm-Message-State: AOJu0Yz82AseuN86QKl9JmJ1PKKbogsKvsvNhsOX3bpVWBI1UVfazALa
 QoorV1D2xJuGPoNjQ7/3CUaOEy2JEwas+0SPQFqWly765RYkokZwKDOXD3ikOlAotnTmqfVNNXR
 1fnxxf4F6lG0580S01F1M9td+/SqhFI152YLRc02c9Zc/HboBWBoLE4dBEHjrmZagQQ==
X-Gm-Gg: AeBDiev+RVH9mDtIs9260qQfPfR8dfL9tRGLCM037uZFBwpC6Mgl5mMEnfZChPusIkG
 TTZkJf7I1+ZkukY5tgvbNlhIU8dcYwk1BB5VLUxFk2DuBPW/WRdEyvwmaZDWB3utZ2+JrdPgxKE
 clIXUiVgw2bmruNuQHf3aZQHPPFUKS/bAmbKM4fKAIv5rl+a64M0otag7/uBnU2FoP2ityv0kks
 iSRimvujq0wLH2kMDy8nAHKpfZpSCDwOzI06gR1QnZmAM/PheNVSCyp0yxis2Cf3n82xK0F4FnQ
 OSxvhwyEx0w5Sp3IVy5nXbNQqv64Iclg5p/RfQgQQYkb0E7AMMOdHHEFy9PZca+5T8LYp/ughJ3
 c6WHYF9LY7rPmIT513M0mOi66O6Wnn8/7c/HDH28rScjFExr1mR6/AoMgJwR1MsgyelFJCXUWJx
 O2nFYkIk1dZpCB5nA7tugTIFN5Jdk=
X-Received: by 2002:a05:7300:4313:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-2e464eaa3ecmr14526706eec.3.1776980327113; 
 Thu, 23 Apr 2026 14:38:47 -0700 (PDT)
X-Received: by 2002:a05:7300:4313:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-2e464eaa3ecmr14526694eec.3.1776980326589; 
 Thu, 23 Apr 2026 14:38:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e79c2954f6sm30840209eec.30.2026.04.23.14.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:38:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH 0/2] contrib/plugins/uftrace_symbols.py: fix issues to extract
 symbol/srcline
Date: Thu, 23 Apr 2026 14:38:36 -0700
Message-ID: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Iocutr/g c=1 sm=1 tr=0 ts=69ea9168 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=M6DMieBBkHAs6JRH4aUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 6akg3XVQP7XcXuDokrVSYbPUYYyn-T-h
X-Proofpoint-GUID: 6akg3XVQP7XcXuDokrVSYbPUYYyn-T-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIxMCBTYWx0ZWRfX3CDrsvUY7c9F
 80+I5Y6M81jP7f2Ne4PwyP+Ca9fqjb4sTlYm4hEyrUrF6bHRebhoOvvJi/eGVo3ywmT14To8DXC
 kL+iDU3m7Nx2PjKEAnacdmoP1XzmU5ALPd6rX22q/Nw143kOMrMQGFuek+ZzVBNFINTOj6f/NEV
 LnjobFBFI/7YKPElnvBZ/bhvfvDp6J+Rdt+MxIN9wV5NrkSD3go5K92julwnL7K3GwYawHyBkLo
 EvEUJLTTT8kqWic1JoHD09Ik0SSqoOlmJUgjpgR3+JHZYj+07L9I47xhHDcOnel2S1HD5yfBk8l
 73VJnNCrLdViQNc/eQlfWLc++2/c+TfBhQ5WcOG/uAsUzmnUzAWIr9z2d8sYgcl8qeAEbfFZ/h2
 g+WSBmBzZdDjc/UkDGovudqUY5l6MpKA58xOe/kp6A8LAZqZEEotl0z1Z/Ee5iq+N6WhhTYoV2a
 IerfYXxZgs/ahORH6gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230210
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Testing this on hexagon binaries exposed issues with symbols having file but no
line information.

Pierrick Bouvier (2):
  contrib/plugins/uftrace_symbols.py: fix symbols reading
  contrib/plugins/uftrace_symbols.py: handle missing source line from
    addr2line

 contrib/plugins/uftrace_symbols.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.47.3


