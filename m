Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831CF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iCJH963w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PSdnHm7a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWBC-0003k8-LX; Thu, 29 Oct 2026 15:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWBB-0003jj-0P
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:52:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWB8-0000wz-48
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:52:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjxek1708156
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Dr0JwKZeBdqw5SOo94UOWn
 cJ9wqSWlBL0lIq4z8QmPk=; b=iCJH963wp3sjpDDkKFeMITWxvSZ+nOHwJWEfLG
 a1xyWMhbaHxsPP33WdSld17R9c2STiuDegTOmLlcrxuCGf0qUINZ372z0+ZHWvTn
 vbFjJ7HrFwYoRr4Xt3uGAY0VwGIOvG2ArpuRFdbVNOsL+0u6w0joGT6RccoODPim
 It2dUsg4qTvf8v55mvijhiKZ7WgWFBcmkYUGbfae4g5DlJlySwBNMzZBu/iosfxr
 bTyV2/NWyn6ia3Zr7XzmTXjuUv3p9v3VFuoCnp1UeisAwqVeHjT6x1ynHLH8Mjmj
 PZpEN6lJ5RbLBoLoAC8NqznHQjTVq4/bO1gStu5mBPJEqWLQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76ck1sa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:52:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso4235654a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793303567; x=1793908367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Dr0JwKZeBdqw5SOo94UOWncJ9wqSWlBL0lIq4z8QmPk=;
 b=PSdnHm7acEuX4rFGaDuaWLOedqKd/2nVFe4p+6DEiQ8dPI4cr1GPy0qW4IXaGlHaR6
 5+T4N7wbK80d7A0xpG3/6aTT03JzcujGGInB6fAXT7877QYFI37IiG/0WpY/YnDqclge
 AEdNhW9NiD8zUfdNe/4714Q3idyBRHHc/t9MzVl5o3lbMrJrsqYfDSaRkayhiy8BjmE1
 8eIutYMKfQN+LPRvmiSRnGenstVJI57j8ulxIuJPuFdRnOEPWm3gTvCtCU3eE6/JoyRh
 UC1QjELkQFeV6UZ2Mlp+yjIAMb2m8dt8C+zEc0n00Xl4reU/m9OvCfTu650y5rZ51rSg
 Oq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303567; x=1793908367;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dr0JwKZeBdqw5SOo94UOWncJ9wqSWlBL0lIq4z8QmPk=;
 b=ARqzX4sFvv+f9iqSUAJHMPgq95si6evB1HOad5adeuraI1WPTROwLphTkmfOrEnHLI
 VS/+SEiLa5Hwq3EkGGJ0/mzRB0OBkFrp+798s89/saBauEs4weggYW3WRU08J/WuWp3r
 d48Xfl3nk7VFzrMVuuVnIfjy/EIwx5B0fhZqS/qX40oFtDns2VhtpHTEqBUWVMXKHQT3
 eFy0qXpFN++UtFML+h0UUEueMVkRd5p4zBXay+axPZ3OW+J0BLHLqrDLiG+nGEPkJzJ/
 vTV278rQiQJgUUwN6ABixPBk1Q1wpZx6Og62KalT5GGo9vtal8Mtcp+Vz4p5hBheVZ42
 sBvg==
X-Gm-Message-State: AFq9FYIzbwByzielRsklp4D93wRtr0OcRyblkETTQv6lu1Q4Tf3aP6vS
 sSbXmPGlDNbu+djEOJLrGoVoRm1CdVrUmiOEnK8tjwhPf5R8p3/NvtlOtsJsz9De81HdpkyWSTc
 YBJWzxDTuady/to/0x9LXiI93UK0rbhangAjXPn9fuJ3SJVFPATf+Cpjnbb7nPtVt4g==
X-Gm-Gg: AYBFou20BGf6Yr4gLfV1RDyA4ThbFLioAEku6pDXkqK8ENrKYOSEUGJzkp0b8WOCv4b
 BQrQ3nYMKg1jrOwulic16FwcGCBhia5b/wDHaImkUL6k/GMCv2qWSpqeD5Hsl2LqZ/66xhmVUcP
 kqsyZp8D2/WIh3TjoykLVqKgJ5h8RZNFe8uJZnjSxaOFbQXV6d0GRDBpIK2pYfFfxXIUgiukMOo
 OeWAPYYSVCNrgGKf759svFtHjtP5hZ9SpzblSrBd79ufZmET77fARSlR78o6F3bt1owLUDiuY5m
 IwP+IQ3nY7BLpr5ncMH1/51883YHlFag64dngJrelF/8BOAgzmvPLq+WOO8+o4hmyjWFEQiKyLN
 syZWzj4laA3uDzq89aCCm5PMmt1JnCeI4483wMDNXBk2c+v7dbVh07JOVH3LuEnhY2nNrcZCJCD
 8ANRPI3TjLjH6cDqy9lznX5xjQtDhR6MVowVmQ
X-Received: by 2002:a17:90b:2f87:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3ae897f6d60mr7662a91.59.1793303567274; 
 Thu, 29 Oct 2026 12:52:47 -0700 (PDT)
X-Received: by 2002:a17:90b:2f87:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3ae897f6d60mr7647a91.59.1793303566808; 
 Thu, 29 Oct 2026 12:52:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9b1506sm5275862a91.15.2026.10.29.12.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:52:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] dockerfiles 20261029
Date: Thu, 29 Oct 2026 19:52:19 +0000
Message-ID: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: y2nc4OzuXXRw63_b3fmA2FzKHAOKc2dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OCBTYWx0ZWRfX1GrRv1Eld4Ck
 LYgdkRz6Z1eKU+8xnkx93Y/DqKcWbfoQkFx1pL/SasW0wgM27Y1gHpCZvO9L1BdlIekFxp+flFu
 6SjtXR3tetI0/lZGDIw9/yUqI/KNrnSsxmsK55Bs+BTKbBeDJTb+ug8D7dbB/BpZ0Fs1MNw8p2P
 QHls6FgxbhP/okp3r8UtqHOjRY2Rv0lsAG41vUexG2ODjArO9B0G4+VNbX+mfOL0W7uSXJBl5Qj
 H7ZET9JbnRRJaK4vA0jTajTh/ISfVKczhX0FiaBNlwibagkif2i7TPX3aZG6sYB2QoIHMM2Uw5P
 M+pRlij3KIedcCKZHgxSFwGJCh7y9jTxziipOv2QlKFICK2OJnOfnwZQZBfXAl+LSVEral0tu/1
 Z2J7PtXObr1LMl8DMDLqeMzGDqcVcztrSpsW72jo6MVww1UJ0DF6TpBiLobtaG5B3t7gS/4gW6C
 RvMfcsB2uK+LHK04fWQ==
X-Proofpoint-GUID: y2nc4OzuXXRw63_b3fmA2FzKHAOKc2dQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OCBTYWx0ZWRfX2NLk4T7nDDF2
 bGM5dxQ59Bnvni5g33Qumw8MczWfQuMrLV+NP7ulsMwTD+KmWtFZqgLPH70CcumFEt2q+xwOJfi
 WYfXalCbInc5aMhiWgWofzIQGBiyf4U=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3a410 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=aRXIdvFbYeXJRBT5feUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

The following changes since commit 5624b266cdd513506fb333e9041778407b6d1ac4:

  Merge tag 'qga-pull-2026-10-28-2' of https://github.com/kostyanf14/qemu into staging (2026-10-28 14:53:37 -0500)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/dockerfiles-20261029

for you to fetch changes up to 5e1e9a4c65de4ae5c0e7ed2ed5c5d9192c4b512b:

  scripts: add build_release_container.sh (2026-10-29 19:51:34 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v5 0/2] releases: build and run any QEMU release easily! (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (2):
      tests/docker/dockerfiles: add release.docker
      scripts: add build_release_container.sh

 scripts/build_release_container.sh      | 63 +++++++++++++++++++++++++++++++++
 tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 scripts/build_release_container.sh
 create mode 100644 tests/docker/dockerfiles/release.docker

