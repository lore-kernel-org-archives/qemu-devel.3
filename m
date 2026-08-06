Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35FEC5AC9E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4fz-0003u0-6X; Thu, 06 Aug 2026 16:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fl-0003pL-8R
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fj-0004y6-NG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso3292353b3a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786047994; x=1786652794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EWHONfUCX/FGEBUZFGh5qRrolvfMef8ddxzy0OMFxgM=;
 b=F8x23kXYkyi9DdrZI0m/10YCiQ13Zh9MhjYJrCpR+89mtY7cxE55zcaup4l/RvvFkG
 tj0t2OtH2Nl5zWRRtL4PZ8tu98BYW1Q5dXCpiiJar43fXIL/3zemkqGhj/CsFdoCogTl
 QYlGlvoCcobzS5eNFv3R93jjNSIe8+VH2XYnSy/2guLGcIhO0cGWJbq1NsO3Mr1aJtCU
 H/gc9itFNl+DjO7x3AmF+2dKQQcHVCdPs2SfGPOHfKcaPzM1BuTGJMpNlvRCBzMC8gxm
 AwMFgnhP0qcdlL6Tp0pdcl49Hn2TkbfTiCii2tarp+9xVAvapptdM6VHopQG0coigl1E
 SVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786047994; x=1786652794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EWHONfUCX/FGEBUZFGh5qRrolvfMef8ddxzy0OMFxgM=;
 b=s34IzA4Y0Ck5vlXgTpRRBo2rRdtR04FUuGYjwCPL8z5tw/gngfLNcApRBHUwegNwtw
 EZRksd11LD/5J/CoU9eRW3iKnVsKSiTHMuGTvGgqHo1clX4RMDHpeJhxGQ84jVksMfU6
 LRYa2gCo+whLqMDXk5RTFzyMv3ubyQOaSXvrPzFhYPa1HdqGPmHI2nTKauoHvfBEIa9K
 qAckuIakFYd4ExIkOvadB+lZVHQxvEWDmfXVfavx9QL+x48fsetPyzNMBngehBgxGH7v
 ccJayI9OnuaMuw2F5pizVoEbl593SVPVFdo7Zk4hwo+3ML28eLmRdyn1t/MGicn1WNQV
 vBwA==
X-Gm-Message-State: AOJu0Yw4CNx3uvPSNTiFXN6WHxUYFl+906PTPO7DOh43bMnS1+vNSmdh
 2Vx02WxDYWz0Rs1eR6Egj+9bZ0Na5a2ZjAAXq85y2JtlzL9YRFpmNtQZGGBgc/+yKowjXmeU
X-Gm-Gg: AR+sD10mJF2RkZtCUxx8jk3AMV6dnUbjTfFjaO0Mi6+BasbGBqNy6LMNhUg08VziNFf
 Xsz+kZFcedAEKx18Ml4bOH+2FLFvUGK+C5sTcpbjMXVJVpjQFigtvKN5lL3Y3hk1GLySjMd5FKy
 Bvu8nLiHp45Cs57m7tjE6i9gQNYCytbS2VQF4422JMPW9WoaLXZ2pzkpomhFQU6GHsUcSzOR+Go
 sVb7Ut/bI/uurLKvNbxkZDWp2Qpt2l2Q7zSV3lG839w0oOSmbiuV20p8+TjbyK/cFLIOMGuZvOE
 LcHNj0j4aTTUJId+1x/tz6z5MsdHxcSpSYIQbMKBk7ik+Fmjp0N2I3bJt3+igbWFhWUPSK5wkAd
 5K/RAeZRnrP6XEXHWEL6/j2DBl4Hpz2xYfS1ytoryr47UfXLiXKHsCwhPEAvZ9ulYuufwGv1Uv7
 1slHHeKpdMslnjZYmpGYvX35M9F8kL4/Ydsw9Dvlwup5vrQf1SJxu/KcsYOdZgm7S+mqbE9ouaL
 98govzjhuMnmc83
X-Received: by 2002:a05:6a20:cfa2:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3cb85dc28femr23180052637.10.1786047993817; 
 Thu, 06 Aug 2026 13:26:33 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V11 01/15] qapi/misc: Fix missed query-iothreads items
Date: Fri,  7 Aug 2026 04:25:10 +0800
Message-ID: <20260806202531.243806-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.53.0


