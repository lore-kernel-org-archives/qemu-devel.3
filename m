Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2CBCA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqBO-0006xm-35; Mon, 05 Oct 2026 17:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqBI-0006w7-Bv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:25:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqBG-0001Dg-MK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:25:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KN1Xa2596519
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zUluoFnJQU+WiDRpDyM7uz
 ZW1LAqkRy9yyVJaQCdCbY=; b=BBz9Dx2oPaVxjv7IeXvIQ5QaQfF8syPxTGhdUP
 J2XOGjCwzk7qPZ8O8iVoY+8bdB56OZDQGUtMi4/wyp6t25TY/N1zXPe6FOeycpTf
 tI+fTQ3ebYQAIvjlUT8aUYcrIXJXzjVg/MXIFqkyh4bwwVIS0cHseA4H17nPZWdG
 1GhKv9P50+PJlCKAvBWgDlSc0oywYIbmY70fetnaFov9+ov2/paybrQfG7vnzNy6
 AFMFWJS1XzuLT2SqxabcrU1mHoKmUFkMGBiMowNTef+UzbbLe7IPmEDhqRS+PzbR
 H+EsLawyZUxqWczMksNPcYp7TtrZqLnhLcEbFqqf3z4tRiVQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dtcqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:25:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34ef0362d95so4148148eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235504; x=1791840304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zUluoFnJQU+WiDRpDyM7uzZW1LAqkRy9yyVJaQCdCbY=;
 b=HiOO/yDwlUzymbBa5lxIP9PJflNllREWRDnrmIj4GD3ioPE/2gpK1cdf9ojONYUmCs
 jXzx90XYg6iqwemZpE/05OJF8RJDp+UirkSaJXKs7kUkyW2dEW5V9bjP186ONA4UVhfs
 L8+enpzK0OzLiD06yDQPAR5szVp3A/LhicyoFE/9+S9zmVBcbHPfWWZOF5OrHlkAvDPV
 yUXyZsnZvVVh/G7OsowEuTX4EYj8ZLVXtB2RqED4AO3sE/efcwQ3fsaDT9qBXADlPLNE
 vSDnfnlOgIPBbxtDoeOf2Qd1MXev2NNTT1JLCqFJrzzCQvOGbULjRoNCFQicCcRthgxE
 3rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235504; x=1791840304;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zUluoFnJQU+WiDRpDyM7uzZW1LAqkRy9yyVJaQCdCbY=;
 b=lOnFzsIlrO+3cJZCVJz8Joru6KCurP7EGDkcSMXFhfcT+JhgfxPQVwfryYXKVDkWs0
 5O5AHzZmWCuc3wKKFYXf7DcO2TfS+jUqvyLgj1B33FFS8dF/GtQpRISxbfNhceeKxrWm
 qtQp7XpwD2CxU0DBT7YMtRsEObXDrQqRHxXHZNiFCAmbg2A2CjDnY3KDv/0YjbKWbyEN
 oif5fUkxceUg1ZOZmYXPlZXV8iy1hmsjj2crS1ZWmdOCLf42hsc6uvtst0tTsANB8y/f
 +sa8jMpRFUtSXplDD5gPjsJm+3lFvsbVdNPBQmYqjpJKOf0uzPU8/4Zh74xFc8DBIrF4
 Djaw==
X-Gm-Message-State: AFuF++nsVUkJwjs4ZVji8S1U9Y6gHk+D90TxeMbFvQ/J3GvNMqptDISC
 2tLVPtnzshnc0k5VhTD20JurwMI+Hb42sAwalZ+EVZYb8GXFMCMSQaINaHtjFdvMoNFL7KBAP2B
 JvSd71kcPRZP4oXDHcsWb/sgARxr+T3ojF6fw1R3rsRWszdri4bKS0T4NBtGggCyHnw==
X-Gm-Gg: AYBFou1vt+2pDuNiQC0qivrGWr4nZPiJwxqPxL8/6oyDx67AAHD4fkhlMGQC01KxZT9
 10IfkbM2E42KvS2JfE8iKvNs98eY3GRYMIbDTN/J6rxCchltlACZhgZ9iWEWV7FvPGgLZRtsz3H
 QyOVcZYgtQii6am/o7cwIuV78dSl+7inftxvfg2xOIXR9cK6KlHWBhi79cuyFqjY3EiasJt6Ong
 QnAmmxUKYkOtbwBGEVndVncp0pMUHrf2semmF/SGh51cFXt+mh68YThA+Cm8K6v6TePZaLKQpxS
 ADoVF/KRMqSJcPo02l1Za1eurjk5+SeVcfVcpWJmFR1gMzbj0G/U6mYQRrpbGC4oFvFaqryB0Q0
 FH8AW8+03j631dQrLNRe9/bgmm0I7hYaqd1MdFRT6pocalWo1yifKewz7SDQx
X-Received: by 2002:a05:701b:221c:b0:143:8860:afa1 with SMTP id
 a92af1059eb24-151c426186dmr13943651c88.46.1791235503170; 
 Mon, 05 Oct 2026 14:25:03 -0700 (PDT)
X-Received: by 2002:a05:701b:221c:b0:143:8860:afa1 with SMTP id
 a92af1059eb24-151c426186dmr13943577c88.46.1791235501833; 
 Mon, 05 Oct 2026 14:25:01 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d819cbe53sm869166c88.3.2026.10.05.14.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:25:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] tcg plugins 20261005
Date: Mon,  5 Oct 2026 21:24:56 +0000
Message-ID: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX44WUshdQteHY
 0ooDsE8Iz3sTm/oc4i4o3U3qWWnKp2Su7WnxOkomd3zCxTDKmis5zn9ieUvdUSaKzP76W4YWwzL
 m/vcBNqo7qt2R6hl8OwbtFmwMbqvp1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX3WfgQY1v/sAf
 IWqb9HyIr/BUEr1B6Ms0CZjU/QAncg8nqO0IGyDnBvTmj74UFmsNiRkFTRu7ylODnAboAf/ZV2C
 0YC7MH7XszlD8KuIgGUCVEaWM6Ij+lOIOFqvVTvYyFBAZbXPb0E8bBLPZJHNN5FQuJlu8t66USd
 VHaURe45VfdKgK0xGN+GiNNMPM1Bgw9Wirik6/3vqHggsP8kRs+OMi247VAXljvbd8icRmWisYe
 zlcv4zfoUhsxdjcGGsiRT1PjRZB+mPXZzSzBz2pipr6P3j1XgRSH0aRxnY9yzVUOj5ztlsR/6Vy
 CSLs2lTWH0YbSSPa9y8LW747fWLLRO/bTEwh6BvApJpTe5Khgoplj8CLpiUY4DgSoD9GEeLphh0
 I7v8hZ+/v0tev98ExrWEvYrKTHCvDgEtnMDGEXl2IE1AEWPoqE68FTQ/c9ijHJLFwjEH+oX0xxO
 qJLF5iBmTNtfBxJfw+g==
X-Proofpoint-GUID: AZOUfwMcRoHa-MMX8X4xD2PYBtPUQZtP
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac415b0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gnUrX8lAZtfz7XaTkwQA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: AZOUfwMcRoHa-MMX8X4xD2PYBtPUQZtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050084
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

The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:

  Merge tag 'hppa-a400-updates-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20261005

for you to fetch changes up to 46a8b8b378259a4ddb4bc4b79f88eba7640ad899:

  plugins: fix register handle encoding to reserve NULL as invalid (2026-10-05 21:22:37 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] contrib/plugins/uftrace: add support for Hexagon (Brian Cain <brian.cain@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260930175519.3601312-1-brian.cain@oss.qualcomm.com
- [PATCH] plugins: fix register handle encoding to reserve NULL as (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Matheus Tavares Bernardino (1):
      contrib/plugins/uftrace: add support for Hexagon

y zhou (1):
      plugins: fix register handle encoding to reserve NULL as invalid

 contrib/plugins/uftrace.c     | 130 ++++++++++++++++++++++++++++++++++++++++++
 docs/about/emulation.rst      |   2 +-
 plugins/api.c                 |   7 ++-
 tests/tcg/plugins/registers.c |   8 +++
 4 files changed, 143 insertions(+), 4 deletions(-)

