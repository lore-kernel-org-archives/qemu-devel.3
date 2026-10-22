Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2D606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DNDdlt+S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XcdMSvEX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0qE-0004Vz-Fw; Thu, 22 Oct 2026 18:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0pm-00043U-EB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:00:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0pk-0000yi-I6
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:00:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtSQm387578
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 22:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KUH6m1Mozo9nKXWH5hjhbgu9ixXZ6r1Pqdl
 EJuFB3Jc=; b=DNDdlt+Sc49AujcZqaLjs2T3M3HuYxZ3DQEH0sqXs8RnpZUGEm1
 cIB5zIxp05/ADxrYYJDJ4CUeOzNX7x8hs8m8j6QsyjFJVjNAInsGsWXhXoTbbRWK
 ULXGHYM4PKwksSvhf8Kkm0KmrguLPH+YV1Cck+wACPDV+q/OTndyeM5R63Gr1PNT
 5JVXVP746OqrxNjCfdPDaZycjAqEr5XdFQ3wnZXWMg5s0WTUAfwSt6XJ6EH5yIUa
 GR1sO6a9spV9LgfgZMttzLQzVoVj8j0Gpaq4IBAuQUr8PUge/05iSeCZI9bMsgM7
 s2KgcPj2HVl5JXh4RudhZeWsN9ZDr7e01Mg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:59:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so1081914a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706399; x=1793311199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KUH6m1Mozo9nKXWH5hjhbgu9ixXZ6r1PqdlEJuFB3Jc=;
 b=XcdMSvEX/y7frSO+MoNvqonGLsMXv/SMgxZSvaZaTuq5CF2gpEMqETFQg54vuA65Se
 EmUT9XLBpTV2ZUoHfEEb9USyJP+H9Ra96v6u75NEUATL2qDr+27J/gbhvjDx9K/eOG5l
 AHWpkOX5JrBgtzQXZyPXnMsPrq+Rba5ZnXIwHGPx1CgOASBayol4I54c1XPRaco924vp
 4x2bAB1XLJEj6LihWF+xKsUtre5YKnxAk0sNfX0SRngsz1PtJdJrN2sfjM4cFZWaOvtx
 LEeKd5gMgqY5Oj7bYCnMr4fqOhv4XVYR6mpKZsPRbK2Y/lnZKYGLrvdQQgvT8VD0AVs1
 d1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706399; x=1793311199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KUH6m1Mozo9nKXWH5hjhbgu9ixXZ6r1PqdlEJuFB3Jc=;
 b=cu471i8Xyj1SexCfrQB6lfCgqh+MSJ0IUJDq5Edg9W8spjDon8JvWjo5Sstpck9G2T
 vYX/2+i5VHxuzbNXrx9W9MFeJVb2MvHC6WPGJ7p+w0u8gL9dhOUPn9fIJ11VHBnxdY8q
 LS47NOIWtHUuvxhb0eEMILCHiwxZgN7AgSBILOXytvOcdwAsOSIeZvDbpeBhDKQ17p/E
 OXbQspGuPxSt7FOgO14hqnB2QG1LUfMBE7KneufjuAsnQFODJlgcLfE/0waBCfv3hd00
 ClqL8VMQLQ3D73dgzChn/QrmvJDJo3hwaliwJ4OaeocjECTw1AZBnQQyMlweM6ayJMb/
 qzEQ==
X-Gm-Message-State: AFq9FYKGOq5CHeZ5FT/VB67VBxAACvOjFYAsCtUc+98dHPkqftWuI0pY
 azMPEy7UP0FfjyQkN8uNJnAKodEimwANtA7zMzrhlZw8vG07/a3QMnLHJapdBevqkFQvDRlluCf
 EkLedh0/Lqo1AofMSgib9OcIKoK60dr8gvDa2rKpVAXnJTt8LvKg2zn8qalgo1yLWJg==
X-Gm-Gg: AYBFou1pXrCxU70Uro8g+BsQqnJ+M/wCe/d+BsMlbfr20dcRElYRz0EE3221rcY/naD
 dvOi9C2fTU79iPg2FeHjiQHLg0JtgMg6XOAfEbg9QuBMRQNIVTgvg6ayhEukMulEl7ioOuvh5qO
 /jKPimH8fFX3FHa8SqpAp4LVYkgAfcftOHf0yMswmXkUNYLkuCHvMvrBubtKZ8w1s2PQEjInsEp
 ovA7IHIwewqNLG77BTsHPw+U98xxfnUARxQoifgQ6BelKgIympM7ZBvec8gsYKin/iWayYo77Tf
 YHH3TJF5dZQyk1rNkL30Bjm7Fo6I/4BorzclvjpwJNzkJ/XEMt3GIo3XoPpCrls67JMhlmd/6cd
 kxrTRDcm9qmRgnGM4DWsoqrMrwn1mg4qhS7VRE/wsY36Y/cR6P63L5+9IljON1ts=
X-Received: by 2002:a17:90a:c253:b0:3ab:b764:8256 with SMTP id
 98e67ed59e1d1-3adce7392c8mr79181a91.17.1792706398760; 
 Thu, 22 Oct 2026 14:59:58 -0700 (PDT)
X-Received: by 2002:a17:90a:c253:b0:3ab:b764:8256 with SMTP id
 98e67ed59e1d1-3adce7392c8mr79168a91.17.1792706398269; 
 Thu, 22 Oct 2026 14:59:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adcb1b167fsm596875a91.9.2026.10.22.14.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:59:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] tcg-tests 20261022
Date: Thu, 22 Oct 2026 14:59:52 -0700
Message-ID: <20261022215954.2482681-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aHEnNdX6_JEPHfVbbOxJM0Q47DZzKF8h
X-Proofpoint-ORIG-GUID: aHEnNdX6_JEPHfVbbOxJM0Q47DZzKF8h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3BlN93U0okox
 q/t0lLvaL5sDMJSf0y/SupHI0/UonXhC3YwIdkTBqsHCtfJsMaximCUMYYyAZo08xbnWNTGemhU
 eHaKchxSNidjWvOMsAEbV/pqyqg2sDU=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada875f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=D1m1VWLtgUGWw8pYQmQA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3n3UyMBiZJgZ
 Jb6zjpDBbUAxVvOGYxLqmp2doZTxX2qtq9R+Uw8i6BqLda452O55AfRMszyvYjYuEx7cWwd9epm
 4f45Y9Bk0FxssyO/mjXgGa8lDejSBqKBx4s41fXWAeHD7wnM6ZTuwf6VFLe9L/oRlMm2IcdaOSz
 fnsb+pZXt0/3xa/zX050x88ZIu4j7w4Slkg5qb02TeinPV/SegeT/7b1A/dU+qeRRurxrIsPBdr
 imsNQ7AqYujBnyZWxTSelfVZmWWpeBzmRp5x0hoikZHyVTkEWWn6tey2ihMEd98sbfFJ8k7I7o0
 j+rYKiNdyNvB0ZZrbBVvIFCBZyIPl5ZENFLG2oXVdZOtpKvkNlzllp9fQctf5AON/urNrJHz2P7
 PMEuL3PRxahRO00el5IoATGWxlgGNABVAHQ5ybUW64g0Z98WAt4iX+DvoKA6cY9iVaoyuP1J2DR
 Orz5BHQgo3Y9oTUYuFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:

  Merge tag 'pull-request-2026-10-22' of https://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261022

for you to fetch changes up to f69f5f796309c613c2677c553824ec30b0712409:

  tests/tcg/ppc64: Run float_conv* against power8 (2026-10-22 20:32:00 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/2] tests/tcg fixes (Eric Farman <farman@linux.ibm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261019185600.2031729-1-farman@linux.ibm.com

----------------------------------------------------------------
Eric Farman (2):
      hw/i386: ELF endianness fixes
      tests/tcg/ppc64: Run float_conv* against power8

 hw/i386/x86-common.c            |   6 +-
 include/hw/elf_ops.h.inc        |  20 +++++-
 tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++++++--------------------
 tests/tcg/ppc64/float_convs.ref |  80 +++++++++++-----------
 tests/tcg/ppc64/meson.build     |   6 ++
 5 files changed, 140 insertions(+), 116 deletions(-)

