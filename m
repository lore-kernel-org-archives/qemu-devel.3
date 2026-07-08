Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E07C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVRs-0008EL-OR; Wed, 08 Jul 2026 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRa-0008D3-VU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRW-0003p7-9F
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLJc13347798
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0TkTNK4eFSbph/Spc6nZu9
 I5xwYU7rHfiCzWvuu8/QA=; b=EtL1fUc9pVUaNJliyTmrcackiiZDlzrm7+m/4Z
 ZeJvPdXtvXxwBhIB2Zogcvq/pxbYRp82f6zef2psU/FD5m3QpjP24vyPRU6GrRFt
 WXER18TDwYNCUnKuvZBBzGXqcJSw7yqKjcLfBWzDFyFh7N4ZQwEY4wg3Ogy2GOdy
 xNP0JelwmGoJ/BGqWBK7FLmaAGWwDAkhD8RUmtzb3fFbnQOAcEK/ZvAJS1VdFnQI
 xG9YC9RtXc6XjXlolYVK3idUgHxKT9fMQMvppR3b3iyO1pKEIGYN5qS3c8vqvMlQ
 SJsf45jX30GUeeAV2XSNG+xoZRgBa9+Iey3Xlor9EmUE0KQA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hjv1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:48:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37fc66ee6a4so1712033a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783529290; x=1784134090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0TkTNK4eFSbph/Spc6nZu9I5xwYU7rHfiCzWvuu8/QA=;
 b=aeOcisukW8fdIBK6zTkSayGjQ0TgsEgXbtx77CCkH2dd9g95VtVny5OSujWMmGWs/Y
 K5sYUXNl5TqXhRwfU7gsHwYbpE5i5fzQTL0GphtuiDiZKdn7WqbW41pyPwLwKNsBLkev
 FuZa9ycWRzALH97Q0Piabmc/0bBpBnqCHAnTwHAi9ntQ4NjWDeVXN54IjALSnRj0aDiG
 knzzOsqI46foJtEPDdU/VrDnNm5zh/RadMl4PoK9dNvIrFSmCi70iuaUrAH6BFjeGCN3
 eiK+fFU8kKdIem31nWuvdnO0QMLRs/0Sj7JDJnISGDDyZILEmIzruiZqfaimA5g1/dRn
 vrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529290; x=1784134090;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0TkTNK4eFSbph/Spc6nZu9I5xwYU7rHfiCzWvuu8/QA=;
 b=oCum04Hu/kwmaQIKup5hDRBYDOISvjr7jjY9tTDpEG5Hp8YJxi1KfP2PGtS4HOV62A
 SAIgCjnK/O1msg0JBWXKmLA21gGWCVMF+GLPpesfR3bwja3+xBXJMFz+flh1Z6HCr6Jl
 r1UspKr2oGyZx8sB1HqzqoILC9q4yo9UIo+S5qbKE2OaNBvWG7R1A8rq9MweT2PJqc3f
 Jg0QD6Wavfqm8fiY4B6lMehBvoy9kRgSzzC2k3bBP7sQ5vtyTg1cLBSc37Kxmwse7/K8
 IEs59kLUDOc7bkIF6TvnQugkMzRV5e088pVpeVDw/hyOKI1/k0cvMXomQGzi46XvrQRf
 iYPg==
X-Gm-Message-State: AOJu0YyCg6QSAPBd7TufjrY3e3DncBpT9txbdxPN6adShrDxVIc2ufGE
 ZMXFZljx3A0tJ2XTkPwRYRG4LxnIIsvGzXKuEWo6X4uvNUgsk8LG2f7x4RetTm1ysPOhPgXm+kg
 E3dRNpNWpRr+eh55yZhbtj4y58IN+RP/PCNO8Q831V9/u2PmRVoUqsDDSoPcH/BXqeQ==
X-Gm-Gg: AfdE7cmtvmw7x307PifRcSW2iHteBlVUnyHsMYS+cobCxHwMzqPgHH3qVNEUrDH1ZDf
 RjDNox2DttaNSocy/CbbrkM4tDM/nirNDQkvKzy9K9TMDWJ3jCs9lq+MAIlY8xxQbtlV+3o7TGh
 v7l2PpMFglUbcs6rkJC41pbX+F7BxzRbaieF9k6xRJp1Mzr0MoTV72v6KuBRfINa6Em/4Hy8oN+
 qi/9ZILsMSdLYBPrFP/C5TzHKlEqYWTMK5DZfgcQEhc5nx26GHBXbDZW4ZIrMejr3c0KWwN3wPK
 AxQk2NVcpMvJk/IDeEB+nC6081VpDN6TQWT0sF29+4lWCvawn8xf0ZrOchAOwh3yHXLDHG0rdXa
 F/9+7/W+1r6PaNJ6ZadFVrZAXXgZku7072L7ZSDU1L27qQ3ZJwZqgM4+Hl5N57niMBPUrz4+mxH
 TN5iy+6w==
X-Received: by 2002:a17:90b:45:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38940631bfcmr3299383a91.17.1783529290532; 
 Wed, 08 Jul 2026 09:48:10 -0700 (PDT)
X-Received: by 2002:a17:90b:45:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38940631bfcmr3299349a91.17.1783529290112; 
 Wed, 08 Jul 2026 09:48:10 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5975sm20603290eec.4.2026.07.08.09.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:48:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/4] Dockerfiles update for 2026-07-08
Date: Wed,  8 Jul 2026 09:47:54 -0700
Message-ID: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX+5LXlnWzDrIM
 pSSdQGxjTLr4WAvjQuUZoVVw492LfiGvqEeZpLo6Etlw7/IGWZV18kHnXFpF2EM3UrH8IR9tOk9
 jGnOVnkezxQ8Wg8sC7jHTTPDNIJMQrLuGUb5AbudUt/eQSrOWRGeHtVuX1vlZqHqIdHGjH50CGo
 xrzLx9D+9dZsuaxslQQI2OD4DEonF1jCxdPLt1MfzvXWt0rt4Fa/xRJFfeu/CIYd2oECyNuizBc
 0IsZm4ZiK/JafNdexGfYCUk6PHHilmbnp4c6HSzztomOfyqriO6UPYeNbqbs7VkoE2aS4EPqlgH
 yC8+Z6SAkzhncvjsi7qT6UgqsjU8pUX5uf9XGudsuG8BfITprv+WwdR6psmiSdLbM1t9Mgu6GQN
 C2TiKyz1QePqRJ0SjbIjYxsSwmyJHr2y68zRGwf01V0wO59FWX84BkEvzgZRzrT/csjQ5sjchzW
 qfuqWyUGE4bEejJ6kaw==
X-Proofpoint-GUID: vm4QghMOI-w_waFydR9cR5dl33cwid-z
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e7f4b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=7cal0JwsSWQQglXgPZkA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfXypsOZkJVMZeH
 YosOtaJgKYDv6/3VcltefOr2GOC5S+HJn1VBj7ghlqlexky+JD5TjFNjC8koRO0JlEgAQJSAe/p
 aJqWaQ/JRdJaWccZgKYqIfLRqt3dHmU=
X-Proofpoint-ORIG-GUID: vm4QghMOI-w_waFydR9cR5dl33cwid-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080165
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

The following changes since commit f893c46c3931b3684d235d221bf8b7844ddbf1d7:

  Merge tag 'qemu-openbios-20260707' of https://github.com/mcayland/qemu into staging (2026-07-08 16:01:29 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/dockerfiles-20260708

for you to fetch changes up to 7d9493a331402f4037b52439370ffd6c0fe06aba:

  tests/docker/dockerfiles/debian-all-test-cross.docker: add missing apt update (2026-07-08 09:40:43 -0700)

----------------------------------------------------------------
Changes:
- [PATCH 0/4] tests/docker/dockerfiles: add missing apt update (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (4):
      tests/lcitool/refresh: use raw string literal for trailers
      tests/docker/dockerfiles/ubuntu2404.docker: add missing apt update
      tests/docker/dockerfiles/debian.docker: add missing apt update
      tests/docker/dockerfiles/debian-all-test-cross.docker: add missing apt update

 .../dockerfiles/debian-all-test-cross.docker       |   4 +-
 tests/docker/dockerfiles/debian.docker             |   3 +-
 tests/docker/dockerfiles/ubuntu2404.docker         |   3 +-
 tests/lcitool/refresh                              | 213 +++++++++++----------
 4 files changed, 116 insertions(+), 107 deletions(-)

