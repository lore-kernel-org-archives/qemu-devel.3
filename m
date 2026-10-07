Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDF7CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWi0-0005C6-Ro; Wed, 07 Oct 2026 14:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWhr-0005BJ-08
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWho-0002o6-SB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IAgJW1621366
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oygyf6H6FCCia/f83vM1QE
 yjPsDeZoO5+mZdt9PVea4=; b=Dcsmgm+BEeTEcoEHuSu5wt5l+hWM0LUxHRtzGS
 qI/JJ0CH8koxUhdqkOwAOG0aQq2jxhWWiTNX5FhnJqs1hjnbeH2Z1TG8ZM77Szpa
 Cf+JyliZVOCNhx3fHpxStD61QA4NEaHlpt3QLEUDiyxTBbBxnCjJY7i8lrULMc9T
 J5BWNWTesfw766uLRMDhNEIlI3Siif6ADNtfRDdi6EpDsWu4tp6HVF8qN2phaCv5
 djyEo+fg9eH0mozfii+Nai9LctfxkMI2fBzv/e+m1QckrUgzIhlmrrNoZPDgsYzc
 36mVPtfi4Ts4goXCKXOzpmK5iNJ1Iq68k7nICu+5OfcWmjSw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5suhrjgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:49:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8333717eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398970; x=1792003770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oygyf6H6FCCia/f83vM1QEyjPsDeZoO5+mZdt9PVea4=;
 b=KiLAyxJAqtvO+748Im5D8/ziD44X7VGa4wko3J+L3yjIWCzkVBP7FH3H0CYF310cP4
 6i8C0ssE7lLN3dA6+wjBUf3dea09hhQgvT1LCl436iKS0LJHNcU9sywt4Zhplu5TG4gL
 AWrAeVvrOV7oO3+vl3z8V1qZTihZTuzQhiE1SxtloCWP3jFMlPsUlVf9y+0feeF0/z0z
 2u56nnPR7+kmbvY6golZY0XRAJ9knvLM4pxz9cxxBjwjYOZ9QOJNmmU/Vpl6UgxPROjP
 jd7hFllmIWE9DCE+eA562IpnImAjO3e+ffAQcn4SSfDtvv6rkNjCsaltNzcRmvmn4hDJ
 W5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398970; x=1792003770;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oygyf6H6FCCia/f83vM1QEyjPsDeZoO5+mZdt9PVea4=;
 b=FNXzAKM0FTyGT7ziXqlQVoppWLlOp54oPOQvFUQp0hyTA1hN0gmRp4J3Tr3z1KEI7R
 is5KA4UdFyKBAcEecQbrMbI+mZh/0tG185gJ2Q5idEVKvn5LOpGlNR6OPO9Y9o9uCiOn
 vRzBH1ZmX1ZuiDHuBf3q8f+vgSdwvnxA5DvFsh9PM4l1QqFhRJRSWPatxDItSj5feSR6
 xx1JMHV479BsESI2YjjM9SiNhu9xC4USZ4j2gSecGWEl54gaHjw/TmZvWd4vFbKEolBp
 5ys/kepDIcOKNUN7ZgWOJB89AWjGE/knEK8y8icN5QSDyMNLna7ZejFi1ee37QjGe79B
 8A1A==
X-Gm-Message-State: AFuF++kF24d3I+ZzNPGDRY7ocnnALtHZU0alDUz87V1LDUQ98MwBbjax
 RgOwXhctoBcqZ5NDAiML7RDRX4eUA7gWAzwBT1KwM1KXhy69byjxJ8AXewQPRJYm3J5hljjPa1h
 PXSj3RAzav7d2oPuahZU8il7IQ3/Nr3C8M1BgjRCnbN9K7EXKPWAN0PxzTxegyC7aYw==
X-Gm-Gg: AYBFou1PlFVfx+5Vas/IDZsWfOhjm3J3eZYeKgABBFAVW91HN/+0jZTiimNZdjoMuoO
 7FlaikIHncVAHOtc4557ac8rq0SLVOGonZ1LJmXePie++ksBYd+AJKaouzYCFi1wStCkdT7DmKT
 HDh4E7oKonVQnN+ccrjERoDM225RivVpSTOIHVfcTTsLHD6JwM3545QC92KoO+a1JFiM5hEwcXl
 b5SbtXPvp3DgCdGWLUOAQldZbXkKuYj01AU0tLjdnIX9/xHW0Yc8yAXCNg6IgZ4TY150PfS9EkJ
 taHqNVt8a33AeYC/62PD74EcfitbBIokZo0H1YF/pRvlNthHcnLZSIk92ZK1O+gPOo5FkWAvCL9
 O38yLHFle7s5FRDeiGcocbkXp4Ka/mT1j7QwcbkJCwVXS0sHE5bxMiNSaGHGz
X-Received: by 2002:a05:7022:fa4:b0:14b:992f:c168 with SMTP id
 a92af1059eb24-161fdfc675dmr4632537c88.4.1791398969820; 
 Wed, 07 Oct 2026 11:49:29 -0700 (PDT)
X-Received: by 2002:a05:7022:fa4:b0:14b:992f:c168 with SMTP id
 a92af1059eb24-161fdfc675dmr4632480c88.4.1791398969047; 
 Wed, 07 Oct 2026 11:49:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1616b01c2b4sm7259158c88.20.2026.10.07.11.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:49:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] TargetInfo fix 20261007
Date: Wed,  7 Oct 2026 18:49:10 +0000
Message-ID: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eK4cUXPxdtFZoYiEAR8eMOf2JwyfMLtk
X-Proofpoint-ORIG-GUID: eK4cUXPxdtFZoYiEAR8eMOf2JwyfMLtk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX4FeSSNZ+1/A8
 +1CwpcbGJLoAk9fM6JWhXqa8+Ka09d+e6nBo1cWalhmwQZAruN1IHKNozHZUymn8ru6lMC6VcEo
 HnjKibgGKRADcrTtKmZEb+pld9XYIDo=
X-Authority-Analysis: v=2.4 cv=e9qT2qp/ c=1 sm=1 tr=0 ts=6ac6943a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AUowa5qApGVBvWaOwkQA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX6i59kdItavFN
 dWej3SiPFHZdK6rrc10Aro2anb6AOIhPTizCScM+nAPiKkwAyhotLJqzmLTXIYImriDaCNwLMCL
 D1HBJoyrBqkBWM3OJ65CzkS8SKrA6SN0pyq704vRGvxbiR2Qvj/hhlO1Sek/+DfeGcb/6qk/d8e
 PImUtEwDbqBdf1ZAB99qi4PssDaY4HtEAChGOzVMYNM/n5JJUhpmO8os4bIOGU8ZduG+8sn2T26
 OmwRonwBNwEgwGbZ/+uZHss3PYVhH2NN9a1ICj/LinUieNzl/IsCd2pcU57h4gx7TpD/P7qzH5l
 y6b2QjxCAqRN8Q8dxPaSoLx+u9is7L8rYMA2Szq8f3bvjQBGVaAZQ/NTPIjcSFcxdsV6pTw8HGA
 eQj9xhsxUJqqbSHyT8uonlyTQq1njkrdamxXdJaoZBgCMLBt02RulXWBGwTYOrENJY43qk6pUGB
 ivhCXMr10m8w5Be/mnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074
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

The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:

  Merge tag 'pbouvier/pr/plugins-20261005' of https://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261007

for you to fetch changes up to 43e6a3898a30b7f751438c8d777bf2ffcd3b1766:

  tests/qtest: check query-target architecture (2026-10-07 18:48:11 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/3] target-info: expose full target variant (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (2):
      meson.build: export TARGET_ARCH_VARIANT in target config
      target-info: use TARGET_ARCH_VARIANT

Yonggang Luo (1):
      tests/qtest: check query-target architecture

 meson.build            | 11 +++++++++--
 target-info-stub.c     |  2 +-
 tests/qtest/qmp-test.c | 13 +++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

