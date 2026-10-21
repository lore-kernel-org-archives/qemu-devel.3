Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D36606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a4C72gtv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fYyBhUj5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJauo-0004DO-8q; Wed, 21 Oct 2026 14:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaun-0004D4-1I
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:19:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaul-0000Cs-DT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:19:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LI6RZ61336276
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4HLNxdcOdJr8cre5HuRRB3xKOxYkRcEdsvr
 2vdrlaZQ=; b=a4C72gtvG+eJOZ19tPDMNEopG3oSmsftOQZoXPG5rifF3ziTsQH
 Sf+SsOIikf2R1gvJAoEQMp/f+PqBr991ot4jSIWOg79PZmCoFvsEm7A1EiM/OF5x
 MGAVcILnk+O7gDMzw0oFH5jjxjkk3u37gzARpfBhrxFsfCmYPO+Bi4z4eVehZ68I
 PBw5V6qhF7jo1faVtJPSfZDyKKMtzGg5BO35FqTzF1lL2OLqHRnMwtH55j+8PyhA
 1rcZuylj7b200zyjlcd4F+cKNzwO3sPh9EvmV+8n1bigSifBAFppKRy6+kzEG5bC
 Af7wDbr1o4Ke5t9Duw5rsIMlbvBeHZmaPZQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf2cq01w3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:19:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso1123155a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606789; x=1793211589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4HLNxdcOdJr8cre5HuRRB3xKOxYkRcEdsvr2vdrlaZQ=;
 b=fYyBhUj51dRsRTQ5F7SM9og/vP+BAjJrceHRkzhF9cOHN+lHUnwjaitRTd0M3UcoE3
 Wy9CeRNSFJAyc2NW3EfqPD7hCgy64YjXkxIBqzqbpl74IsXOC/MAiXJX9VTEmIsWNWtG
 /JHWovI+j06wIp4xk/9uULnnTtMSxRp5ybSs6d9koNmJ6LJqt21muA0+vNvnklTwT1iS
 LVkzJYfMtPKCT+II/RPFDKb/i4LfdAdU00F62pMBqayizVERKeBfXLRztPGkERF5HCIq
 7nJteHQg8uunAZ64gexxZ9NwCTcIBFZ9TXQpFZNXu+LjixFW9EAIeT8EsdcehC1cT8r4
 YBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606789; x=1793211589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4HLNxdcOdJr8cre5HuRRB3xKOxYkRcEdsvr2vdrlaZQ=;
 b=ynHaXTvchyIEG+En1NR6i/UDXkZsrHLkizZH9uufsl3KTfU3BHWObyWfnvx7WgT2di
 ajy5ei3Le9EmhTibyclTKjfLYryLouNfXG8FaKlvx7p9XjOQITChhqgCG5Dskqx5SUfr
 f3N15miozQoeO4dpfFfuQXDLFzcgYTUKZ0qrG0zImhLYrWD9zASo8OgwPTBfMgifv0W8
 OB0rVEE669HOVnZuDfApVavGdwDCuL+vRZW/7zPpP604Th73ud3wadGXzgAbo8rRH4vB
 amJYgWdej/9XXeX3Ys632E/E/TE2zzZwt4465zsD8Dq2Vf/Ga4MmVzK27JjGGG4xgJZ6
 QvNw==
X-Gm-Message-State: AFq9FYIfNxZ1fooBzvYBpsMd6hs6F16VGsO1z8pzYbS2fAvWFRFub3U2
 4P7tBwmy9ttkQQR2E0ffglbkh1oSEkiANJWobrz6HP/LneLBypcHu60gCKCnYTRVDXmRGaTFz8i
 5AIbkOgCw56DH3oUfshK/q6lMidR2DGFmG4BwVI3a9EoO+vC62y0DtPGDXS5nF5KGYw==
X-Gm-Gg: AYBFou2hgCxWqrp8QbddeXqCRh2cYAuyz/3eM4Qn+/QkdwyfPEpGrx4KxJ3JJighm8T
 dVDYCBBU0ix7jFT7MYmL3IGX98gYkBFeP3rs2iI1dN0DEANod+2Q2LEs8mvqJXEZPtjXSmFbGso
 1lCXMVuK/2UvVuzJhNHZQ0YsmYIW8QWzSZCKTqAwAakLtzT7qH52ipMJef3ROMgQXQQRo/9GsCt
 i7JSLgyKJtdTu8qUFlDbUcvpLxPbJ66Dbqz2fCnnLNQ9CVoNHdLa9sn+XREWokOnBsN979yEv5x
 FzX3osKa4T8VXhvj/G8JMxDTCMfH3wzCeHES6hpk9scUkZoBdfaODjASrI4uIgSqoAMX0bdKW3x
 X5W14pEFwl5YBPCgkKABBKCK4d9jsOp7XOUaGc9ywRRByoMlvxqcM8cD6skrVgHc=
X-Received: by 2002:a17:90b:3842:b0:39e:3713:c2e4 with SMTP id
 98e67ed59e1d1-3ad86ccddb2mr2703140a91.14.1792606788971; 
 Wed, 21 Oct 2026 11:19:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3842:b0:39e:3713:c2e4 with SMTP id
 98e67ed59e1d1-3ad86ccddb2mr2703121a91.14.1792606788512; 
 Wed, 21 Oct 2026 11:19:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48bcf45sm521701a91.15.2026.10.21.11.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:19:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] ci 20261021
Date: Wed, 21 Oct 2026 18:19:31 +0000
Message-ID: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HLhWhYtv c=1 sm=1 tr=0 ts=6ad90245 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vih41aj-88J4E6UDT9MA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: kaC__O9s3LJulN1cBTctWB1jG3wwOm1K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfX94G3u8nAREhc
 F2YiSamzo95ZYSREmYOas3jnHHwwPwfW9u8ghmR/herbf9huthKBUskS5gAAyeP5IjObI+muO1I
 ewmVdrTF/gZ0ngEGmplzfAGxzxmRuuQ=
X-Proofpoint-ORIG-GUID: kaC__O9s3LJulN1cBTctWB1jG3wwOm1K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MyBTYWx0ZWRfX13uBr20kLDE2
 6kFF8kXFZ4VLbHmCRv/BkZyZeTAxuJlZtqvu9F9dAdAlleOm/TpKfEurJkwk3BITZ+DXgf2oSmH
 BTQ+fzKfKYyf9t/WjvN74D90t+RJpmTdL41NZUf8lHX6sJcv2/ETmCMcHxtEEuHcawPJ4r88fUy
 JCdtl2yBVCTTe9xiMCaFcvbeq4eEjjAfXEY8OzcZDWftAmd2vFQZrRLM2tPZvjEmz2ZkzssBwNX
 FbH4ZUl6M7q7KX0sEapYlYXzT+CLGaz0E2zXOXdLz6rnsZtHYdzjxJDnVd4LYok5kr2aiRopf7E
 YRkj1th3C6GFKdn7cRVqvqcRlipfTgc2qdgGzhRRf84cuIj/oJ4Fd4pTN+8PfblAa99Efi8le+O
 dblY6IQwGLkrSDrhpBr+LgGGJdmY5MyKhkUUacv7uyOTdG906HIAiCUzIZgfkcFxB/BYblRQea+
 VcTRxjtyWChV3gcznGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210073
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

The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:

  Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/ci_gitlab-20261021

for you to fetch changes up to 3a6d37c9883d21529a01e3615960696f91499153:

  ci: add automatic retry (2026-10-21 18:18:33 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] ci: add automatic retry (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (1):
      ci: add automatic retry

 .gitlab-ci.d/base.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

