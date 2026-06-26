Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A554BC43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdByA-0006QH-BC; Fri, 26 Jun 2026 15:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBy8-0006Pj-HA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:12:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBy5-0003oL-VU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:12:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8gW72265112
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 19:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 El9MGaq/BueehQv3m3y3zOrb24GUWxlNxrJjeJ2pFjg=; b=WHGfYunSUDyj0d6H
 IQZlR672AEIrDm/mj6uFTttZxVvsuIHKSXb6dVQVxQdqkvRRvsKCNchMTtmIC1ZW
 /b99zmGdddemGiJzZep0QUv8zNe3hr2UxgCRSzrDTML7iV6CpFPt+jHQn0oDK6SS
 XwqRZFFz+V2Vch2gzBIDa8y11u+yxkgKIGBOrhRhQzOy5xbRQuJiEqNbhQCZQbwV
 HfJhnn34wJfTyVDFL8SB9DcVQxUBfT8RvpYogj6FzYUxrBTuPhW8rEYFJ/mBg5iy
 XJBLleL+jjc+pPsEEciFLv/qVfU5Yi7hD9tOPnV8hgF/Izjn6ucmjvl6FmZ3Jb14
 eyAwkA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewc5nh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 19:12:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bf794ce48so2230552eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782501120; x=1783105920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=El9MGaq/BueehQv3m3y3zOrb24GUWxlNxrJjeJ2pFjg=;
 b=Z/Wbo34O3ZaueaeR4w53Btstdn13FpfiB5TKypRTtLX4aEWp7y6KafgYoO0bGqOk8I
 wjenSuz0UflQoitJYap5q0UnUkKHMP+XCJmiv6cN1nY+JwDj6pJxZ1e89urpZUUJnOor
 rz6dVKs+ZOeSp0fmF6QzGngY2CYtVNrll5XZdj6M+U29IgSJhvqtKp8icy3eLf2mbCzj
 rMeyQDEOT7Pjr7CsaQehYTzvo2euXE3qSZ2eb2cc4lZjpmzDhKHCioNf0hJclfrpB89o
 RC6mCgulGLiTw6FdyyPuupnXmFHE1q/tQgORuCE1Oj/5dE8sqKKueJsS7CpBlKdvaJVN
 8qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782501120; x=1783105920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=El9MGaq/BueehQv3m3y3zOrb24GUWxlNxrJjeJ2pFjg=;
 b=jCdjlcgkumgvY+BtreVG52v/l6/S/pEX1J7/HQ8iMe0zebUjra5Zyk4x45PPmP0rO2
 ekMWhRcFe0xUVw0PMsrEobErW1Nl1U+lBZUJKp3P08Co7tPnyA/bCGbopkeBxdUYi7V0
 KlDXkaTqjl00CQItx/+XujKe40K+N84d1mT+Gow2Q+ATkmXL2yhQmYdhRgpoMsdlmQ4k
 nDjAMZTFiag6mB7Hhp71mbQYMd2OURFkI6QDiouajRSv5hxaHTz132YjrHlEpBuofBE8
 FAJy0XEcUpxBonJtWmn7JV8FtQwGbvfKuHyUMP2fEmrumdn9twms8mTeElS5Vnauit+X
 jiVw==
X-Gm-Message-State: AOJu0Yzy4tq3LDGepS7KOaomIEgUFFwFozd9zStLDTWdXKQQNXVaAL6a
 KMI2GYs9L5z0NWwpY+qJLGxJhISHBe361uBvcOOe6NwIzSXWd4oSp1uyLWzmRC9E3xVOtZeYyZZ
 OKEVEvyRmOcWItb52H/qlvMKBnJ6pr8s0so74yUkwdBRp1ms1+nesduJVe2Jd5Y5tow==
X-Gm-Gg: AfdE7cm1Iw7bbjGAFlCBwAgQakLq84iO0z0JCLP9n5/Lp7o/OKyMv1VgjE/QLsXah+F
 ZKiivO6BWs6ehz/n40P4OpsrYCQUqKsKxiNe+Mgnn3DUnA+EfxZJY9ZvmtmUOqCL/bN5UsklSus
 ShMHfoVgV2y0ElLWnNBmxNQsf3FgFiNcgt26WY0TfEZccQY1YucHXcU2T0uUqLqui22JX+cqUWc
 omjECYeL7z2eieAO2j7IPdZxAFQy9JKMs3jVOOwvqD463olzRnJIuBo9Lq/Y84vwAvO50RdscDs
 DAcraZCEwrh9u37/gLBifJcRyn0CLIuPP/MdUpdIDHZ+WKeKMW7VIPcG6bZWJm4VTY0gqlXUP/M
 XwhXz1DddgBG5SEHNFsr38VmDaEw4rIj5WHVKDybHgOMATCLV8jonFhLM5Fj7DhdgnBR2jcnqLQ
 nR9UdaLg==
X-Received: by 2002:a05:7022:ff4b:b0:139:b0a7:9e0c with SMTP id
 a92af1059eb24-139c3cbcb12mr12353938c88.14.1782501119576; 
 Fri, 26 Jun 2026 12:11:59 -0700 (PDT)
X-Received: by 2002:a05:7022:ff4b:b0:139:b0a7:9e0c with SMTP id
 a92af1059eb24-139c3cbcb12mr12353923c88.14.1782501119018; 
 Fri, 26 Jun 2026 12:11:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e95c6sm30071950c88.11.2026.06.26.12.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 12:11:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] docs/system: add general note about architecture and
 machine differences
Date: Fri, 26 Jun 2026 12:11:48 -0700
Message-ID: <20260626191148.107354-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626191148.107354-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626191148.107354-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE1OCBTYWx0ZWRfX+5m0ugZBmB2L
 y3uRsCVIbemzjSSO5hG5byjSwuS9qINAsfiNR/xARXjpeFuM3dEkNpggYagt9wvA0ocgXc6e/jz
 W2mjCcGA7DGh43XjbGX5cb1xYDMCJW4=
X-Proofpoint-GUID: qBhRkXNWKSvoGu-uwBkcxC93XeRa1oL5
X-Proofpoint-ORIG-GUID: qBhRkXNWKSvoGu-uwBkcxC93XeRa1oL5
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3ecf00 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=3U3sWcpejSb_yR5VqPsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE1OCBTYWx0ZWRfXzOhJd+aWia03
 XCBWm4uXEKNxxnwWHWqQl7t7E7689TX9MO3Xj6gATL08zu9yrXTxvnwVoUOILUsLUuXI9e3rkiz
 jLlFXagaP5wWOeyOI0y1f3ZyuALGeso+x7q5gHdxD72wbkYY9ifdbCR3keKly4vioV9PvyPkBkz
 AgX6RMrblDQnsfnfemqZROc3dzmOK0Su7z64oWGGmePlSuJGs6abEvEgDxg+dcDI9IBhNRVZjCp
 rUhpHDUH7vLYsPrTxrnXhj8oUGwI3RU+ys5yNGZHe7FxysnR6UJuOD8eHLcC4w4Or34cc1MWUTi
 8D++6kMj8e9oyx+YVktWEI3Mjzpi/dKEfLlV8ugCLWbl/xaovVa+wNcxPtnProjlsue8dlP3wCa
 OJ1G7v3nP4HFfB/cGor/U3H8OkfNDDxrAxJuHezCWhHEHcY5bsjxAmaMD2hEEzM3HOwrGSDKoVx
 cDPGtrxUe5tZggNx4fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260158
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

From: Linisha <linisha232@gmail.com>

Add a note near the start of the introduction explaining that QEMU
options, properties, and command lines may differ between target
architectures and machine types. This helps prevent confusion when
examples shown for one architecture do not work for another, such as
the pflash0/pflash1 options visible in -machine help on some machines
but not others.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
Signed-off-by: Linisha <linisha232@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260626181118.1136-1-linisha232@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/system/introduction.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index bec7291e476..8d9ef61d262 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -1,6 +1,15 @@
 Introduction
 ============
 
+.. note::
+   QEMU supports many different target CPU architectures and many
+   different machine types for each architecture. Options, properties,
+   and command lines that work for one architecture or machine type
+   will not necessarily work on another. The examples shown in this
+   manual are specific to the architecture and machine type being
+   demonstrated. When in doubt, consult the documentation for your
+   specific target architecture and machine type.
+
 .. _Accelerators:
 
 Virtualisation Accelerators
-- 
2.47.3


