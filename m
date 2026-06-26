Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92586C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBy8-0006Pc-4V; Fri, 26 Jun 2026 15:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBy7-0006PD-1f
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:12:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBy5-0003oF-Cj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:12:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8bkd2264986
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 19:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7rVzesuOP/0FXcPi2iYnYR
 fqgZyboi3xinI0nHdRsSs=; b=W23o0/Qr78wn6qndrYN3y6jeznNBNWtEsLkCPI
 Z1rXtMlYT7MtVjfwcnZu9EHbXGOePnm0soWLvjbGpb+RgCuhWXKGuLbZjtm0JUyB
 Q7g1iDKu+5rCcYBXTyK4F8tc8HLgVVgdB4Q7AkNYTrjisJeqEyDMqEzqO0jCBaPw
 QOm2yKiDevnH/dABkAt/SK/k01dErh6Yrh/eyd/PSGjl8rzSAvI8Q0/KUcUQTPwT
 imJXJ3aj/+p1ILveVHhS5fQCVlSDfUPRXSPZA2yw5kqtDZFlR6tjS4BvkiX0Vnmx
 qFpufO8ZDC6nHj6JeTQ9FFoK1tsV4M43zAMgYh92+uSr2Jug==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewc5ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 19:11:59 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b74d67e0so3668265c88.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782501118; x=1783105918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7rVzesuOP/0FXcPi2iYnYRfqgZyboi3xinI0nHdRsSs=;
 b=P/5HvIwjr3RDpDEDyI8ri/A0O8XBnzytW52+JV5ASukAEKEa+fMFacxYSuA1lLmIRn
 qnSLteKXatWxJyRWqZUcdjBED+H65g/KsvNmruLWFNLx3a2L++6rIg+jV6ABzbsOSfCM
 WHXS2bq1/Jlhzb7gmw2AiVoN+iy9fOvr4uMH2nu2uwqGtLuhi1n1Han4lHrcZPgKEzpV
 Am9ja8TW2kQdVggu51HxrHqfgIenxHjS5yMnnkx9xeGRUsEJBYNYTfALWBGb3nrq1OIz
 kGVFDnT0hGnANR0p/6tFALeoh8EQVzEKVX10NGQZkQQuSjyXS2aFNDslJgB5DvqQy4Uv
 Yf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782501118; x=1783105918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rVzesuOP/0FXcPi2iYnYRfqgZyboi3xinI0nHdRsSs=;
 b=Cg8GObnLf6hBUyo4eUD91D1JI6fnse5QAMNwCllxHay0Bc3cm8tDT+IeplKQTn5/fo
 oqHM6zcUSlA4yLNGn1yyyHdF+Lr4eBGvgvkXClfUClY8oVH54Tftnov1hJbMgYpwjuCp
 8feGqLIIDz7IkuglgS6+2yu0h2ZH/PSAd/JhfRa/tMwBUacYR+5e2v9mu1HK8q3VfeaB
 YN/yyE5zTOvioQwCfETMCU3v8WYduhozAIrIkbPQZK+4XapkaSRgKwNX8WN/6JFC83eQ
 50sorYpTwpOqWiU2racLoDaYLQyGyZWYnftRmjXOlI9ef7pj2+TJGoMu8iVo9Yo2xY/k
 ZRVA==
X-Gm-Message-State: AOJu0YzYc1e/Y/mLkcEZgY8aeSN5n/q7PpWcUiZDtGgnS8Gez1vW6pOU
 IVV5dRYjNsHskSMEWPkRXtyP+0yxrNtXNRWEutB+qhYKc3KGmi8xfpOX/mbOx9p46KuTTMbaofB
 zN45kuvpZsmkA+uNi1oaUS0n2p4bfISJPn9JCVuA/CZZF04Fm1+tIxsWfoXAl5CAmSg==
X-Gm-Gg: AfdE7ckvGyIsCWqG8EV+DNPJ1PCrzJBXxGOED29xOMl3Y5EahNEldMU/BscTPJ5/YH5
 ykbaZ/GOxwno68Baf5Ob+tK4T4/ulPD+aNadju1jatOS6qciRr/TuTKgcJzR4+KNVRtAkLhFahK
 eWyRSEBW0sUkA7kIC0c+hHkpqixB6cp9OtnOa8LLGmwZZ/JT6W755wJ7arGTyOXYxzF74tVXqck
 7Z8Q/lAkrAESfJkQsDW0ber5tnMZl3gUrpeU17VyHopAgXobp4mg3NrIjtlRAl+LE6+XwSy720w
 bXBa6BMErAY5qJV8bOOo6tePkW9Jfbf9p6dX7kEuMR7++xEF/LTAoejmdGVMy7XVKDe0mWiOG1Z
 1UqmocNY82dUyVZarK3jX8aBLmc0Yl8kcuoLMzhjCpQtGj1/mMkgnYttssQSdleznGasOW7xquX
 x8aA0IeQ==
X-Received: by 2002:a05:7022:1a84:b0:137:f532:e342 with SMTP id
 a92af1059eb24-139eb13157amr1191619c88.7.1782501118485; 
 Fri, 26 Jun 2026 12:11:58 -0700 (PDT)
X-Received: by 2002:a05:7022:1a84:b0:137:f532:e342 with SMTP id
 a92af1059eb24-139eb13157amr1191598c88.7.1782501117916; 
 Fri, 26 Jun 2026 12:11:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e95c6sm30071950c88.11.2026.06.26.12.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 12:11:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Docs update for 2026-06-26
Date: Fri, 26 Jun 2026 12:11:47 -0700
Message-ID: <20260626191148.107354-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE1OCBTYWx0ZWRfX7lCA8Wenqwvy
 w3BqQUJD5X+doXCGNGGfahWLDsIOngbQCvyuJdMcFUP41ZrqpnM7cJ22EUJChKODC8O4adUJGIw
 SxdoObzRMWuDOach/u6Lm9g13BU4KnY=
X-Proofpoint-GUID: Uvf7hI3uIW2JMA454ZSDZT7ehIFEmtW-
X-Proofpoint-ORIG-GUID: Uvf7hI3uIW2JMA454ZSDZT7ehIFEmtW-
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3eceff cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7VzxzFeKj8cBHIHMU_MA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE1OCBTYWx0ZWRfX4j6RXktOxigP
 ycVArbAyPh4QCHdLy+12PfffXPGKD5Yap1Jd4gsFC9MBbMQMLNsimIR1STa36TcXqIcXhTnysi/
 yfWd32cQsik6wVdTwwm1pQp7TY2dmRr5MC9FhHnwbbjm6dgfDD0OfhEk4foU7sg7stHCBL5UjuO
 WumOmArUCNUv66Hw170RoQZmyi4DjjKghPtfeJj27om5Des4jxI+CVopYGLuzS/NXwh14WhoztG
 xjqtmQEAQukIfshxIiao9s20/ToSXt0FbtVTttYrSL1fsIGVfefQiw9ahsl8mhjIPYAzGEbdXw6
 xaFX2A9D2tBeHBOaYkfPfTqGAPjLzI9qOcToAf2MZm7WMlGtCTokgamPPWOIAmV++rN4JW6hSDu
 FmPRVM1jk4AVUHC1r+JPkue7WF7QtZuGQtlh6jdt2WLDNigsIEQ8Ps4vppLK+fhlbvNxDZyyBVy
 o36QWcGr/ablOdRCCdA==
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

The following changes since commit 8f1d3b586f1265023f75ea9c227c35d463321aef:

  Merge tag 'pbouvier/pr/ci-20260625' of https://gitlab.com/p-b-o/qemu into staging (2026-06-26 07:58:03 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260626

for you to fetch changes up to ee03a20aabd2783a575035bd9dcbd46883647d0f:

  docs/system: add general note about architecture and machine differences (2026-06-26 12:10:41 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v3] docs/system: add general note about architecture and (Linisha <linisha232@gmail.com>)
  Link: https://lore.kernel.org/qemu-devel/20260626181118.1136-1-linisha232@gmail.com

----------------------------------------------------------------
Linisha (1):
      docs/system: add general note about architecture and machine differences

 docs/system/introduction.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

