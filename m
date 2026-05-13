Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36760CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDr0-0002BM-92; Wed, 13 May 2026 13:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDqh-00029R-2Q
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:58:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDqe-0005mR-Ny
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:58:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF9bfU4159600
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=q2kFeEhZKvbYtDfx8fuukt
 ETzwHkcI1urMJpIbqytvo=; b=QJFi/i2YaxqVA8nanOoDYOTVJyAXlYY8/1yH2C
 J8doykYtVB+79xCYXemZXJFDRo0lu/OPALIm1/oAZ9ZPvzJJJtFOCpMH664huoXv
 OhY6zKxEnwojfQVoJNdfjXmgwF2H/Xw1m/ayb/iEgqg8mC/B/MROVGtjIGc88DNR
 R9SUeip8OhJj9RMDqsL+4F6ep/HKh75d3aopb7K9e5DwzlXavukbk2euUYU0XeoB
 QYCkIex2yODnReXIMek83qjFNNYJRA7OnWhZY2lTDz262TGF5p2F/XUQgIBCRgeT
 1jhQea57GN4too1ubI3xnwkpElCbU2SzDk4Z9fSNh+n/0psw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91t512-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:58:18 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-132d5ad9c32so2182704c88.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778695097; x=1779299897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q2kFeEhZKvbYtDfx8fuuktETzwHkcI1urMJpIbqytvo=;
 b=hl9U8Jkd2I9npb+R1TMKcWJ//PopD5FO+CxcfXSCP25uSYz1VLlnqa/JMM3dl2qNim
 wlubA97p+DZDQ8gPNoPFeEmzv22Q3dPNA+xBdc66losoPaEzCHju2H/cocByN0u//ncG
 tZ95h6Wh1FRuYbtwWNPfZdNv0vQe9NvrsNGn28n7ZnLv8tfE+e5d7iwKkUGfVWv7rOsI
 qw+kQ8ebtRBnRgo+7Bw3bKoRnWnPkBGlTZEdX6kk3zOFpOMltxqxYiytldZRlVVYJpsJ
 +mm063NABgJ7bnRlVrXo1jl3DQj8Rsh6B1b9uaP2bv+dRRUNhMaua4+r6a1gnWNKhdsw
 eEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695097; x=1779299897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2kFeEhZKvbYtDfx8fuuktETzwHkcI1urMJpIbqytvo=;
 b=Js7sfhIZHY3NJsNiqKLHZ/RjOka9tqyo9X2nvZfIVG2BNe+pQgV5OAVixeiiJszKdr
 0gXCr9ZmhSNWSakLaNIwYAq290a7uQ0VsY+fjSAziee6V0h9ZmVFp5gI5fyKvfGywpEf
 N4kpeBPN9FyypAuvrIRyah1BN/taxPh4OI5Hh1Qp8wKk+glWxdsyNo94BmNgmXWgve1n
 wwAUMZepY+b2ni6V+JiPP6e5nivoSgKCk4zbQJ5iN1IAXVzEHmxxliiLNmS+HuHYbPiW
 +1EG5q5okwfdG2Fl02Z0MucdHI+vYPdUQKEEoLiiuqV5wYLk4WBKWiHv/v01xwlpf9PC
 MiGw==
X-Gm-Message-State: AOJu0YyKTQqiZwFqd5V65dorncv63KYN/cv91O/vJBFjQTPKmeemWASt
 xV9BR6uYVESSvJRvb2LKsKAURwPLgzMi3ELXScyMWWEmEx0m5UxeWdFQmFYze/I+iyae2hDdABM
 WhfRDje9bkKkbkAzxKCEJGPQWjxUjd9zm/9M0eMXrsKaFtMNlFDLFeczCbJ2xnByhwuz2
X-Gm-Gg: Acq92OFUlEry64IVCXopgdtZIE/2omghLXNlYSZ0w3nssja1d50pCNzhvKW9awSsBxW
 ygLdwyFxQaD+cvDXAzJwXq7rni8wdoiZxFjgZURoQSn6ZS78Z6I6AB1kkHBIoRhYkGC7h/a3vj4
 RgdWCkAtOeJTiIXzg1GE0n4101n8Rsa69Qglk3G6dTjkuXiYtsBpO16b0R2q5P7608pq+DPSD5p
 6uAv2k0KABleSaH2hCTli3TYCVGga4nCKtYKCVlNpCk/m1SPVv3teb4wguZ+jBN39aUe+pYYD9c
 PFjXZblHEFJPWGCchUTFIR9nrGxBY15yzRHwomVMkRHysQiTdHh2nDhUpn/ugDCdFom0okFX3T6
 r0nlhc35LtlB0PezVN6Q3XCqRmQrzNIa9BMwcNdpZJvEU5F9DlSfE0P+UWtLe6OdyR50zfrw4NG
 bW0EhxGw==
X-Received: by 2002:a05:7022:6b93:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-134369a069dmr2957519c88.20.1778695097371; 
 Wed, 13 May 2026 10:58:17 -0700 (PDT)
X-Received: by 2002:a05:7022:6b93:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-134369a069dmr2957492c88.20.1778695096815; 
 Wed, 13 May 2026 10:58:16 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ed3sm236569c88.1.2026.05.13.10.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:58:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Docs update for 2026-05-13
Date: Wed, 13 May 2026 10:58:06 -0700
Message-ID: <20260513175807.3557565-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YvoZu3cs2OzagPmY2GblBzFTirwjvJqY
X-Proofpoint-GUID: YvoZu3cs2OzagPmY2GblBzFTirwjvJqY
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a04bbba cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=PzGKxP3WAAAA:8 a=HqRhqw1a7FLkLDdhEA4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX2oCyoVj4Z0nA
 vby6uarijHOlffzsoWgykB3t6/9eVJ12qdqM/InEEKwnIjpVAwQTgnPyQJTpnqxWiO95pVcctuU
 /Na5Js5uIeDAWFc+9TWllrdULyuEBIPw8fgX1+8RYAkA7hO5aX3CNxWtzAYyeHDuYGxTeQS0P2D
 /GXQgq9JRfetqnqeMiOusTYQU6IY0OwQKiem+J1qvUShwA7aC7SotJ0DzfheD6fPxv05QBp+0Ke
 rhTgypxe5xcSp0yDSOmcp0+1gEUWkYtFlZwRhTXeQn48IhzhUKtLQPUtpkoMK0VWEzW9y6BHsyA
 6zB2rx0RS9ZzLv8s6K9C/KC0qPxQ6UxHk33KHwK00kPyRO4spHpkpZd8amqbzDAcYhwbtMmobvx
 sd+LxUEh9c0nNtX3134nlIkfKLK1o+v/pWpJ9KuLlMS0gtZHz+QK6EYl8nwWc4r+X79+hCKDzxH
 TooE5j1YLDB4GA9Ld9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130179
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260513

for you to fetch changes up to 785724e81c35bb5bb13400d8424e26671a0fd74f:

  docs/devel: Fix formatting of `Error **` (2026-05-13 10:57:09 -0700)

----------------------------------------------------------------
Changes:
- [PATCH] docs/devel: Fix formatting of `Error **` (=?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>)
  Link: https://lore.kernel.org/qemu-devel/20260513-error-v1-1-49fa04bc5c22@9elements.com

----------------------------------------------------------------
J. Neuschäfer (1):
      docs/devel: Fix formatting of `Error **`

 docs/devel/style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

