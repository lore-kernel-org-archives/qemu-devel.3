Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD4FCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOVa-0002sk-Rk; Wed, 10 Jun 2026 15:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVZ-0002sO-5l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVX-0008TD-2o
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJM5ZD2489412
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KWD5xNovQqd0aban++1IkOwNUJzYLLmLBviPpSEoDMM=; b=cKgG+1AvbABmLyR8
 W/QDKekrSnbvC+vRHH+9bRTiymmEqR09FaAFSGqq7qtIkTRjF+C1UqYN8D73vB0Y
 psLZ7iAuq7wR+VvYO5mbY2EWbvc9uy6zWTPEGw8ccModw/5oqyFO+xtgOCtpd9kQ
 h+TxYZzWh8EIKmNcokvXrdiVf0WsNhEL1r/KoHKGpFG/EDjDMtP1enCOorwTCYWl
 bPYT+v7oi+kVxUFeqlNEbg1aj1OzLmqoh3ysysHh8HOv7X+NZjGmnmQuT34SUmNy
 kxrY7JdUSElqBQGYmXc5Y6TiqDbKiHb0U78hKm3Z75tWLe3VvsQijjt0af/VfkcR
 Rcrh6A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqdeug56s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso9479011eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119352; x=1781724152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWD5xNovQqd0aban++1IkOwNUJzYLLmLBviPpSEoDMM=;
 b=Tk3RFpLENsMMiL4eukfpZ1FsQPJNREBYr1NoTIeHjG1fOm0ZL0+hBlMHgrYIzaqLHn
 tSzVmcSK3XhEchnbmRKAGjHBDoo7ePM1DuXtxjOPkHLSG9KaxhLlmT89wJ9rZb7GBIQr
 M+RGwvcMKQZ/0viybsFKAoEVYMUY4FZFCFnAUbQG2efQrMyjDUe9HiVYSIp3f9jBVCdq
 6QbFT8fLH+h2JtzXO9sIxV4f5GncEyz82Nn6s9BEmCLgFdiChGvQIv5tV+9FyxQiqeB0
 dEhcU+wJJK3CyrfNLiqh0jlG5XSMyVF9sY1PGDvK/LvuVb/OYjBiOXKH8kgVoMIRtD2n
 /EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119352; x=1781724152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KWD5xNovQqd0aban++1IkOwNUJzYLLmLBviPpSEoDMM=;
 b=S47wpzCnZY2iz16hIs+yju2o0kKrAKl6XUYFpnqnXIh2gOLc4NJRFrsS/x4sPBFxGn
 7H+/iRO65+zmKaUY4DuqLaOdFnpoQaCKWlVQG8iRaLgx6Stn8w1R+udekO9SP6mGn8RF
 UnYr/a99S95SXCck2RletpPdeTJB+3u2v/Xj4vFQV/VcyYsBst3akzPxSeHiUinerYw4
 4oz4rCYOcgaBhQgHbgQYgiSVsuirY1x+0tUq2k5Fij/fzaZ1t6MMZtAOkODx8XzRJ1/x
 OrPfaTac3rc3+808Yw34QsSryT2pnTvt4xWm8qu0o2FNs5pnaRrfUK33L6z542Ex17tO
 fyYw==
X-Gm-Message-State: AOJu0Yz0N1l5iDjILj5O/TLYbrllV46xTJjT1PJJlc+KFDc7VPG8gLDh
 MHo4expPjFsIgcy5t9GcHktNrQ18cnOog5BAKkX5GX7X/1v0HltwFeD+rzolU5PATBk6fxf9Gwr
 MwiGHAa8QQOrI8wzBMO11eZj4OMg6LNB/PvZx62vofNbzGoUiwYkItDkU5CZpZvIiz+7w
X-Gm-Gg: Acq92OHsng/uXvNMs1QU68EmCdL9zIMaShMc3h/Pq0irxlZJV5OuXXLDPAxiGz/MixY
 K+z8dazErMxZH9jpkQXp29VQ8EIWmVaN1wZdiUh3imjCF4ao7sgmt6uKAJLpaB3A19vDimSoZfP
 2bKZ80+7g7WnrABk0tdqa0sX+o2TY0lu2VgqWquP7e/zZ0uLuonjNE/jvtgZ4rU8PDter0U/bxu
 ySiSOVFkrcnQ0McDA3tBTLqdXsaHdyF0aywWfNdptWNXv2YCAM51JaCTGW1StwkPwImEAd5Cayy
 ndau65RsrAiliFKfEr0uTT16wpcpEcYc9EHm7fjD7wygleoMwdpQjbmBeNLtiVj5WoHEc+EXpVB
 e0rh+H1ZtHuF835gBXdO2Fq0YzXm+IuIvyKlxg66x2QspsoV+0LCdehkWknzWHLK9r0W2fq3smR
 7JHmS+NK0M2DADistH
X-Received: by 2002:a05:7301:1e4a:b0:304:de2b:446f with SMTP id
 5a478bee46e88-3077b7ebe91mr17249060eec.28.1781119351672; 
 Wed, 10 Jun 2026 12:22:31 -0700 (PDT)
X-Received: by 2002:a05:7301:1e4a:b0:304:de2b:446f with SMTP id
 5a478bee46e88-3077b7ebe91mr17249034eec.28.1781119351142; 
 Wed, 10 Jun 2026 12:22:31 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm34128986eec.23.2026.06.10.12.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:22:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 1/5] net/af-xdp.c: maybe-uninitialized warning with gcov
 build on ubuntu2404
Date: Wed, 10 Jun 2026 12:22:18 -0700
Message-ID: <20260610192222.2709135-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p1C5xcxdr9l-Z45nHIVFeP-5V_NNyesJ
X-Proofpoint-GUID: p1C5xcxdr9l-Z45nHIVFeP-5V_NNyesJ
X-Authority-Analysis: v=2.4 cv=HJvz0Itv c=1 sm=1 tr=0 ts=6a29b979 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=dURgFwUa2F1EbzCuMrAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfX1OnK9u8BhBd4
 W0rQf8H7R0ZkX2Feb+YklrReNyZQob/rn/SUG9rrxuHf/tTODtLOl4UtK+CsVTnJXHq76I5FkLC
 MvNz3URGuxohg8sUF/HSctVpb3KyeD/RUQbR1fa0gtXUsCjK5KcJK2Y+bzlYrs9uJ/ZIxj/hqn4
 OzfPolzM1mgSI+S6ddhJ5EI6rNMLg3y+r76OR2LP5rJo6TCn5vaR7quR8fdyE66PAOCW3k95mE1
 /L2H1uCuZ6n4t68HCvn/JlTpNx6A17QpTozYgDq2WSHbWHQDEBnjKPdzaPC4qR+fMtIT2vax0R7
 RShwsygXvrxwqNb0W6G1AncjMhu6QTfgDZ5Nm3flOQeLoR6J8eypzr1gKZ15AJj+V+FWnGAROlG
 p4iPcFNeyI56h+yHOxI/ugNcDX+H90QURvd/JwlyOuPCu5h4EdBKSZISTXUKvG1CayCyjLYS7kE
 msovpOz1J6qGGHS11TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100183
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

This is a false positive, fixed by explicitly initializing
variable to NULL. Variable is always initialized during the for loop
above, which is guaranteed to run since queues >= 1.
This is correctly detected for normal builds, but not for gcov builds.

In function ‘af_xdp_read_poll’,
    inlined from ‘net_init_af_xdp’ at ../net/af-xdp.c:546:5:
../net/af-xdp.c:78:10: error: ‘s’ may be used uninitialized [-Werror=maybe-uninitialized]
   78 |     if (s->read_poll != enable) {
      |         ~^~~~~~~~~~~
../net/af-xdp.c: In function ‘net_init_af_xdp’:
../net/af-xdp.c:461:17: note: ‘s’ was declared here
  461 |     AFXDPState *s;
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 net/af-xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 1ffd6363a8c..72d75748c6d 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -458,7 +458,7 @@ int net_init_af_xdp(const Netdev *netdev,
     g_autofree int *sock_fds = NULL;
     int i, queues;
     Error *err = NULL;
-    AFXDPState *s;
+    AFXDPState *s = NULL;
     bool inhibit;
 
     ifindex = if_nametoindex(opts->ifname);
-- 
2.43.0


