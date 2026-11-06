Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAE606A331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=frWzMU6a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CAtPM1Se
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPEy-0008HV-6C; Fri, 06 Nov 2026 14:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEO-0008Dq-DI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEM-0007FJ-3F
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:07 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Ht2EM125943
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eSwKYtWEjjb0DvriCPVVPGzgDCr00kCMByr8/Y3M7Bo=; b=frWzMU6a5utqAps1
 Jo0EFTg6wUG38BP4f2+L31F9gdnMsjS+/K1ZPs+ovTFdKWNB7Py0YAiroQAqKPOT
 norEQFdzge7bnb07LW5hADDWMxdT7vLiMYTehLXR6Aywgoes4nlhemSeuseIpyz1
 1+gq4vP/yVdcpY41mivw8yhCssBn8hFeu1TBBfy262hGlIaKBhp0VMjLLItEmbXB
 P8wRrAC39p67/crGrZwJRTa8Dya9SvkzAzmaeBoCYcL5NE0wzr5NwsJYe15tbC7h
 SLU5Op4MouKdivClEjM65EKMFLMqnQhyaY1x+0rC6tGvRVEuutWvbfnxHYZ3NFJT
 MxuPIw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48rf62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:04:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdb4c49e52fso942294a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991844; x=1794596644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eSwKYtWEjjb0DvriCPVVPGzgDCr00kCMByr8/Y3M7Bo=;
 b=CAtPM1SeMqxWoyrADNw3isj1BEMVDPW7aGHggDEP0PitEzKkgtnFFx8xmplXH0V66D
 YQAO2+yRP0IXzYqUE+Qdy19MXKSrVAcnQ+hI5Vd0XYM7Ublh2/I380otnBynqvU3uRg6
 EW9SkDVbwtKGEfMGTKcWGUIdTSOqAVwV596vnAktU7rLs8XmwYIytyE6ijrdl570FreV
 9KjXhnVAXJ1qB8afgh8xgjdygYmPJbEsR7mPyPzQhRZA56D7HdqnFxK0Gt1J8Tc/gxjL
 6qPbR5GYmFgbQrbhLI+dVSYMuZbEaKOq8HwIoW0od9Nfuaa0KEe1OTz2g5vFbkWGk34U
 17zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991844; x=1794596644;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eSwKYtWEjjb0DvriCPVVPGzgDCr00kCMByr8/Y3M7Bo=;
 b=TOF7wFMijAPE2PxEU2rg++qK9+ZN9OQXjEPvyIL3Mi/Y8szrT64OdyczFaJOO0Cqt1
 FZzzsR6X5nXeBTQJXeBqXYlRgb6s20TPqgTUvfw+Tx2B4KKpjROF5rjSaUfJGVP3CZHB
 02f25TJBMHhXOyiczBeQ34Yp8yLiG8P0DlWvoihktPJ2AusBzCJvVTMlB3Av96Qake97
 cCZPJFaDStxdlVh11kVEAZC+dtjluZAZzaoKvP7KXatycRJGRB/g9cLjG4+YIE/o7eja
 dQMF8RPaR/ExPP4JjZCWOmvA0w5lRg774FWYhKV3cW7sECFKw868Fs91RRYrlajawaRU
 veBg==
X-Gm-Message-State: APuU4Z/AWbvdpLUfrkfpVArx2FweJchp6J78T7NkR3xcu4rvCHRodIpt
 q0tOGBaS8lISS6/s9neLElvrKQve/SxxWPw4+jCR7KkviaCkjbRLsxsCSwsj5WcFSLpgHewMU8m
 Z9tbDGqyOBdbTXSjfZpF0WQeiflbcn9upzqQyxM2PLuqk1T9Y82mvhRii3CKkCE3qmA==
X-Gm-Gg: AYBFou3+CwYZdk6V8quVjD2pvReVyJ5qWvWPFcGrKvY0KJOVzS1wYz6GRygM4r4EuCd
 G1B8jc4fs2rfstfwHqo2qc+40n6A8BWQA5fXkm1aHTfkKh4U0DRBSeMke/7XyNWzyPz5ObZ3Kvk
 hiQIuYeLQ5jzeeEzY62+bTcCNqqpc7yiNyeo9Dnp3xis7xHnOb+D2z0+LQU7K4tv5tEenfkEzcF
 JTGKFK0B+oZPPP/HwNdNH8yq7JYf7SNIoRnGWKy7fXgJCN8TBCOiNCKTiAf1b5IjsuLbYuF7bsR
 10rvGy5F29MjlPY4PFzQm4yToeewj7E3bJ2TyXtCFTsgGbe5uKIDByVsNl+bEza4EdmTf/r2II3
 yXrq49BF3ORMeeX960cRGyOebXN6el6UIYEydiy+pipnXC/Rphdd9rahOaFWmGeDM08v0bpEHh6
 yi/vpIfrdbErE7/bdNVJWu+6rM37RpCJdgKiCB
X-Received: by 2002:a17:903:234b:b0:2e9:4d9f:a65b with SMTP id
 d9443c01a7336-2ed41c0aba0mr43202275ad.53.1793991843842; 
 Fri, 06 Nov 2026 11:04:03 -0800 (PST)
X-Received: by 2002:a17:903:234b:b0:2e9:4d9f:a65b with SMTP id
 d9443c01a7336-2ed41c0aba0mr43202005ad.53.1793991843361; 
 Fri, 06 Nov 2026 11:04:03 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d40d19sm8283735ad.32.2026.11.06.11.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:04:02 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/5] tests/docker: add igvm to Fedora container images
Date: Fri,  6 Nov 2026 12:03:50 -0700
Message-ID: <20261106190352.1665081-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfXxWMgYIf9Heqw
 m51dswGC/MCJFjuaDAHd2njaxXlL0pRH6HvCcRQpEgyZuEkc0V7r88B2uFjrV6kJ6cHocVWxy4J
 z0Xo8TcoSBsKDwJBNvD7J5oOeZpZ++xMn49xyjU6meXSw0MGprZujN8DmiqwVUHVYZ4uSGbm9AY
 TsiwcOcBa577HPLWNmTPCHKHMVUSSa44bgTEw89mujdcwDRtdFdZyWxi4kgYgQwBBz+gTn4/jJY
 TNZVUjymqmu81mNE8RtXM3+eKHVc9vKJLiySi0JyVhyBPk7pW30Z3P0dpGjc818RhvRWFpQmwDh
 jjNwRRq6g7JsaPVGPs5zt1YDOAiS5a/jjHNh8O2hrICiOEcMGzP4D7WcAx6HgodzZvaETcPQjGi
 bDQeBCH26Vq0wolm9OZj4no1Um22pvTvXJxCjORe3vv8q9tSpCh+S3syiI5ZmSkRww9pgG66R1E
 mZxpRc22go2NWVcPfYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX81AfKijlhbBp
 S0tHYKWMWqegtv6Rq5+QZ/tsSToYPNDwErr56Mrg9wLaGU98oHEKoq1e8znKzUp1i7EzIhAbN3D
 SskmDlqhvw5+lNDg61BcD05IxR2CHmI=
X-Proofpoint-ORIG-GUID: H2VsukJ63xJO3guSAdu5JOyRf5ZO89a8
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee24a4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=FHBqb38XBGssrAiPUdsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: H2VsukJ63xJO3guSAdu5JOyRf5ZO89a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

The igvm-devel RPM is used for certain features on the
x86 and arm platforms, so should be included to give
build and test coverage in CI.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261106171836.2020151-4-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/fedora-rust-nightly.docker | 1 +
 tests/docker/dockerfiles/fedora.docker              | 1 +
 tests/lcitool/projects/qemu.yml                     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 144325ae1e7..7eae32f126a 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -54,6 +54,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                        gtk-vnc2-devel \
                        gtk3-devel \
                        hostname \
+                       igvm-devel \
                        jemalloc-devel \
                        json-c-devel \
                        libaio-devel \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 8f7e9efc899..871b1ba3f20 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -54,6 +54,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                        gtk-vnc2-devel \
                        gtk3-devel \
                        hostname \
+                       igvm-devel \
                        jemalloc-devel \
                        json-c-devel \
                        libaio-devel \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index abbd3e3f0b8..37a0c931fb2 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -35,6 +35,7 @@ packages:
  - gtk3
  - gtk-vnc
  - hostname
+ - igvm
  - json-c
  - libaio
  - libasan
-- 
2.47.3


