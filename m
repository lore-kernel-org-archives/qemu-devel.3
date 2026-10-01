Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A81CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxY-0007yC-G9; Thu, 01 Oct 2026 13:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxR-0007xT-4b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxP-0001ka-00
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsjYh2886451
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ksa6lEuBJNeClTXQHoQzoX9OHLD/TCHsgVBUYodknmE=; b=mNiCUUoGP4dEPEru
 R6gv1I6ATnI8XjeG+jjLqp4n/XR/blkxg84IiunDbJd9pWmzQVYTvx4xOx7QxlTB
 9pehQjhBlSPQiOhtM2kueeXdcr9FJTaS5TSyBH88LSsSdaibprvyEmBAXa7KlhcW
 PycoPnhZ3Ei7EuMojKbtRpAdUnSCWuK/wAh6wWayl7huSmvVsYAdCdaJv9FeUBB2
 s5CLjPjKLBn9coxeji1XW+TC/AU501QKbOFPgsSYQm/Pe5vtdbzuGJesou2tszx1
 B1lZcLIAnpE4IC23X6iKAwYjiXVYhUT+sKP5Z3LIlUZS8aBWEDKHTtiLQApgo1y+
 3Pb3Rw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdch1bu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1384427c3efso10237486c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877153; x=1791481953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ksa6lEuBJNeClTXQHoQzoX9OHLD/TCHsgVBUYodknmE=;
 b=IWF1W6GSG1QaW6wLeABzj4YYwdeGgsaTpB8UjWn/79ILLuuAS4cNv7HGMCPw/Y2a4E
 EsvaONGHv8LA+YvZxDxc9leYHmqQP0A0GO/galaJf888wY2eDNVBPrXN02V61pNwQeTx
 urGH/rl8aoARwGsj8xxptVJDVlmzmjF+z2hhz5mq7t0mc5vQ/R3tEWMl6k/HX68DyDvQ
 0pfH9fgC5f2PZ0KogRARscINrehlAKrH8TAWdSPRNuYs/4caMGon5wDe+ejomsEFq7Eq
 xJVTD4H88l6zwZ2ieC8TykwTcRZ9k2V6hq6GkayGNyqAHEZm1lFkMTRu1MrYtm45KBBc
 KGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877153; x=1791481953;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ksa6lEuBJNeClTXQHoQzoX9OHLD/TCHsgVBUYodknmE=;
 b=CfdG4fgwzayZtp8XJrTS8bz6oGEaNANfqykF+qZ41LuZe5C316ufZVbc9E4GMLmIWy
 OudiIxGpzMITMdY2ZMBmBPXn7jkxTncld7TaYreNmAAl6MLmxxBY44JBSu6fg8e69hVp
 FkhgpoBi2hBHvFBda6VSkn3WE0dBEAkiv+lbtHa9qecUY5V7PAz9x7ZZoPG36G0HKdS/
 1XCU1U5XQUZ1ZPscKu4xiIsce821rNpguyP1a2Mz28pemOuHjnHdp9cUz7KB2eLTuuuq
 QkW5LPy+gMs2KOSp31cvsFEUbkGwbqQY0IaDe/9k+2kXb8AYXO2Znlv7Yq6bc4lZlrJE
 dqdQ==
X-Gm-Message-State: AFuF++nccF/kmZAk6uoHndyAJHLDzCDUPG4DNgvtTzzul86KCr4tMX1A
 LnErH4ciLnpGbgnk+Jj1JwiTwuDsTLthLlqmfTaGLmOfPb0kdNvVieFq32K9uNG4iBZaIFbYYTW
 2E6WWk4sJRr6+xcNIi190R6bdouyouSZFCWLgDe9LNdcpLLqCHGQzAqbyy1IXgHcyRQ==
X-Gm-Gg: AYBFou29g0j3NSGahXwMS839yNGdNM162Cs4LzVJn9l+5COJIxmPN0qXd4yT1/28yOy
 pCyM5PiDWQ6Q/QpfqxP5QQIYf+yKdiH8WKW144aZ5RhDA2nff1guEjokSH6mRkCtSAZpCikmIjg
 3OAH5DygkbADGkz+AdLmMw++hyntBT6Kt4Yuo5yJT8qHyAZt9G2seWrNj+6NG9f7nkozZI8Y76S
 /Ghivq71+hBbGSHd4ALyRyzZ7cDhr23W9r+curRv0801+PvNe7+ZpZv1JW0iuwvdIDtdAUA7KsD
 PQsIQzal+TUu0p6pXR6/Jrh4GzBqAaLon7Euvt6C5yHsyHnDcA8uva9+LB/BSpXSzsvrobjmyng
 dBq/UFE7CRpDfkD/Hhsylw9MiR12CSSv52ZMfZJoeDhFLAs/7exVFntgNinaK
X-Received: by 2002:a05:7022:5f12:b0:144:c11b:6de8 with SMTP id
 a92af1059eb24-14d330b1caemr4454212c88.29.1790877152476; 
 Thu, 01 Oct 2026 10:52:32 -0700 (PDT)
X-Received: by 2002:a05:7022:5f12:b0:144:c11b:6de8 with SMTP id
 a92af1059eb24-14d330b1caemr4454170c88.29.1790877151739; 
 Thu, 01 Oct 2026 10:52:31 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/27] tests/docker/dockerfiles/debian-all-test: add mips64r6
 toolchains
Date: Thu,  1 Oct 2026 17:51:47 +0000
Message-ID: <20261001175203.8673-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Nsk-LMnjiU-7cFGJCQilwNseQNh6t0YU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxm7xUeqlqYUU
 FjhkwXNA2oL6KKyi91cfi0hod24FbJGk69V+L50WdUQ4NaJNyuEImLSCnWRZWPNSYUtv3yfKJAL
 JWwUs5qXLk0ss+7eAdnCR0bQ6E+oo7E=
X-Proofpoint-GUID: Nsk-LMnjiU-7cFGJCQilwNseQNh6t0YU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX0mHhZBLjSNY5
 7sH9nkeT//OsVWirxywDNRhdOBaHjhmWnA2IyBm/Z6aGjYCInVGelkSPY8uxRicYZEQLJH21Zpg
 wLja4ejg3e2sMkvL9twKn2iNT0CNnamS5zoTDpk2jzrZ8vCfQAeIxkF9BUt3qAHU8zixz8CjjKY
 i5Yugc227OQUO1yR/3920GyRQmLFUUeKyQgot75KK2AjCHUR1sllRJel5jC5ckaDRpF1PvDrPYB
 eOW1uzlLLcwx4Mk5+TyOJzRgyjDy5w8ae/YxIpbnmATlM/NbMJtCODfdVIzm0TOp/c8iDMyS3ef
 XBgvEDajg+M7RiSxOZMF7eEF6qbHSS/spWL6m5YBBePrAOxGpu2YdtG2rimLH6+zg2P1FU82ERK
 zKzcUeTZU6p1SysvbeUX6RNN83bTT1AYVoSvh5l6Rll9tQ0e5DEMF91pSOQlOPaW0kvMBwtYjSg
 Jl3yd9GEsXoSvyPS+wA==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abe9de1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W5-BjZYuLqWngTJxaqwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-12-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++++
 tests/lcitool/refresh                                 | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 97d3dae6d7f..94524480880 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -89,6 +89,10 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa64r6-linux-gnuabi64 \
+  libc6-dev-mips64r6-cross \
+  gcc-mipsisa64r6el-linux-gnuabi64 \
+  libc6-dev-mips64r6el-cross \
   gcc-powerpc64le-linux-gnu \
   libc6-dev-ppc64el-cross \
   gcc-riscv64-linux-gnu \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 31c06734879..662d8a79f3a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -200,6 +200,10 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa64r6-linux-gnuabi64 \
+  libc6-dev-mips64r6-cross \
+  gcc-mipsisa64r6el-linux-gnuabi64 \
+  libc6-dev-mips64r6el-cross \
   gcc-powerpc64le-linux-gnu \
   libc6-dev-ppc64el-cross \
   gcc-riscv64-linux-gnu \
-- 
2.43.0


