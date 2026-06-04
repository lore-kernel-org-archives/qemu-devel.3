Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A16CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFz3-0006rc-0k; Thu, 04 Jun 2026 17:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyz-0006rF-Of
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyx-0006i3-Qp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654HNpN8944431
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 81gSMsjHz7u/XT/45GCehHPFwYouwBtX864P/FusbOw=; b=lX7SiMJrvOPUWyb7
 PNYPeRp9zdnnyN/UdjuwbsAiku3U+EYSdfNoDN0kYfroeOh2JPOGQZxbLu5/aAoE
 EXeEZvd0UVyUg9Omv++AS4Rc0LJ84t/QCVXqi/T+BwYVTsXvu10zNFfBX5B9B3EU
 nIO1gFTuju+slLYlKk/zhRCOBjhXTtdz2Y5qata0pG+f9pwdCadfWWcx1WHj0PWu
 TElTdlTK7TtO/CjNHLI01UGxBqw1w5Pb4MZ8RcJxfKhszNJoK+d2s8UXbHe3COJP
 EV5wegUrBiSHaok3kkS3rkYu4mrhODV6KquuVRc03t45eh0IrGFpmxPp153dEZsH
 UY/+dA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8d52u38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:52:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3074797dfa9so1670800eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780609924; x=1781214724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81gSMsjHz7u/XT/45GCehHPFwYouwBtX864P/FusbOw=;
 b=WhcAH/HcxAonyeQw6R4C7Q374HO1xrOyx8DULx7X9MsBkZHW2OlZJFUYeqEVTA0BjS
 Nb+7sDaNhtOaR5GD9EEBiXqT/HxF52SuGasmMvquFrIoChteZ5f8sZV6PmLJvsAU/s2T
 PP+ZNxYiUpbYdRepCKLtTAN6baqxL+g61afbNGOzRSDXdVcyOd6awhV/QwEm9WtKaDDc
 Ldmdch50KhlB+eLZCq6PZ05ClWW7NZ0VcdL8WrCD128D8UiWAS1OEhU0j4VZk4oH0Jvo
 IKyGF3RgyUOiDhrBwV0I4BO9rcDDZJmRgiDS0kTK+TZZy6X+HW0XEpEsm+dsEMglIF85
 fPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780609924; x=1781214724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=81gSMsjHz7u/XT/45GCehHPFwYouwBtX864P/FusbOw=;
 b=hhmkOyqbzXQs5ecUMw5Jz7l92QKv+zq5zm5NK+V9y3ozOmen8sj6gIJUvbtg6fKd1A
 Gik2E1ntmcesno8LLWE3/B0A6Hz9e+9l6oLg+/FRBjdIP6bGmBmHlp0iNrq7EkTYtFke
 R3qoIXz9KlQoJq/JErTwBf1+2HBHCSRtBhhGS+mLIsE+6pmNdXbMDBUA1NfRy7CMINuJ
 SGWNqrrRrqi90rXXCVnu2kw8foqNVwZasElsn7zxuHxePp3ttEiFAt7bjDQOLuB3W1dX
 2FFmCtRyCaGGIUlmgt1kYd/2w4vAfJlWZ5GJx4YJcIG/G8jgOwTlu8XQJfbBeSfa4e04
 i5bA==
X-Gm-Message-State: AOJu0YxwyXmgWlAf1gsd99reHWOH3331nqIRWenbBDZV7ya2wqvOvktW
 +tBKX3Erc/8A22vXND3LIcyBxm5bTXhNuB/iy1qvv8shldJ6j+KX/SorkBOROqIly3EJgSSXtOm
 Eog3SIHT5k7bP7YFl+jgk6wDrVvEGNnd8HAZ6VoGlb8GoBEt4LOqNYqgrAe+KEhBmrLQZ
X-Gm-Gg: Acq92OGlnGxdpkP7krfEQ5W4fseY9lQ0nBp8wHqMREfWWzrPq725hGA4SUTvmn+2Cp/
 7Ndt59B4+eydPc8YKD+stFNCwiHBdqhw8SxVRNEqQMYsfQ0PJ5/qWAwCB4rXlfKYumHMPBYuBA4
 QKq2HTcQspD1C3aiiwAQ8SUO/Jc6lPksvWuUXp+eRTRS+85cjneBlXKrCRe48Cpvk7dj2lOpmn7
 QJzAgxry5TN3HDcCIw9mZ/aIulcExbZ7tkiSfpIiMWzvRx5NwAQxtUHbF9qxg0omYgeU3e214eJ
 v0fQyof/R6wFM6kv4bz0EzWW0l9eg49K5Ak/fdKrYaoSOUpxjaFqHc5rNaPQWNXG6uxC/21DFGf
 RItpRoGXkIHCnwE3Ef1HFLB+bZ0R194VgFAYkng6hpXuKd6jVQX49z4gp00u4mBA1x/ZDokgoA/
 W1MyX/q1P/BHY8Qb6Y
X-Received: by 2002:a05:7300:1352:b0:2d9:5cd9:b8ff with SMTP id
 5a478bee46e88-3077ae86decmr295134eec.6.1780609924024; 
 Thu, 04 Jun 2026 14:52:04 -0700 (PDT)
X-Received: by 2002:a05:7300:1352:b0:2d9:5cd9:b8ff with SMTP id
 5a478bee46e88-3077ae86decmr295123eec.6.1780609923522; 
 Thu, 04 Jun 2026 14:52:03 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5270115eec.25.2026.06.04.14.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 14:52:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] net/af-xdp.c: maybe-uninitialized warning with gcov build
 on ubuntu2404
Date: Thu,  4 Jun 2026 14:51:43 -0700
Message-ID: <20260604215148.3769627-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xoUTqrjx0ozu7Fg7k18wGV5HaOzXAZyb
X-Authority-Analysis: v=2.4 cv=IZG3n2qa c=1 sm=1 tr=0 ts=6a21f384 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VTEhrdiSVsHaVhHLs3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfXzpCECoW5QTsp
 4R/d3dlKHNPkArHWQ/StJIlrXDzxzwUQb0RkzzUaZpXhxHcnOlhBLi+uf7Den3CeLwl5wMGg3pm
 pthMoXyNOLmpINELBQS72EeC9MwnNFUwLMrJ7jKj17ViUk6lp5Solq4Dw5EvBPI1oJsUJcvOo/w
 a2aSxmrcz2TWoVAyMub7JTSN+4I3ELYJNy62/zWx/1zw+7PMIilYrwqTJ1069m2vjsOc4PzpEQ8
 TGUo6xqsaNU+i2uZmlWvCYtY5A8h4qrSpi5mh8v/OsfHOt7e9xblNkM7z/BrgYJL0UjxZee/ch0
 7i65eCkpqkg9vhQfCFKntG7s30eUlOZaREkWmx31TKBslxBYlRY9F0skIdXIlSBuQnqdY/L9CGE
 22b4tCHIAVWuqpC6975sZ0pZJn4shtCBI8dWZXxvCL+MiW6wRrF/GRKgL3K4YrvTKcTOk17Ze77
 SrZevGYQDrE4LgadP+A==
X-Proofpoint-GUID: xoUTqrjx0ozu7Fg7k18wGV5HaOzXAZyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040214
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

Seems like a false positive, easily fix by explicitly initializing
variable to NULL.

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


