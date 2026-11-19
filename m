Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46C606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l7eri8GC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J807N4Ts
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBeu-0004in-Fu; Thu, 19 Nov 2026 18:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBes-0004ha-AI
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:35:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBeq-0000fs-Eg
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:35:14 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1MwX2620064
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ymKj50E18spiZP94moaLQi3y7YP/vaVJy2iEJ2wUDOs=; b=l7eri8GC2LL60k8+
 akuS2QD9N08EzF5Z+uZ4WWtThs5PK/xfu+k81xShV2vGFjobHw/SRpPbHtJzS5xQ
 6N1met7xzU5X8AZiW04nPErMSTNzVYYvCrrBFstX6AHvr12FelffWq2UtXTmr3/V
 nncMDELWgu0eRaHKdLvhb/0kYoWhotvXlsXgJldfHnj6JWL5MSp01Mu7Ho+OGNJY
 adFhEeo/WsF6StsnHTtAu18EVhhLzZa3GL1OXGSkpzLNkz1fWlLkOuIivvcaHhEp
 mKqAG5p+fIkNvkxtXAjcT9VX8MxAiRRIj5wszVjy1tmksznuWBL4sOa5DRdHNvIx
 6rOPhQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yghketq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:35:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f559420f3so43536785a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795131310; x=1795736110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ymKj50E18spiZP94moaLQi3y7YP/vaVJy2iEJ2wUDOs=;
 b=J807N4Tsb7LD6pi3pqjsaavjBvLjbFEfxWiE4oww2I9D0d1m2SdbnGLSu853mu7QqG
 aQpUXb4mXEt8UbAoDZ4KQBA+dks6v/1vOFC41ldn4+ttyFIpeJ4eC5fKqJpahdas/0XT
 1DmagpYxz4eQfVVLvX/89kSNLZDYSWhlluBqi/f9z877qpPxWIF/Iuu8+pnl9/6fN1k0
 DRxOIOTI5d1qM0XcqRicWt8PZTSgGG14G6/l6pe6KH9apngK5K6KabhZji7TPibYwvI6
 vwt1NapxmMFfZE4dPgR2ZSZkj9ttXtB7k5wnV8Se9xz4/888VL2apKfFno985Ug8a54z
 FPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131310; x=1795736110;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ymKj50E18spiZP94moaLQi3y7YP/vaVJy2iEJ2wUDOs=;
 b=yHaQp1SU9H/mFOPirvYWQhuTG5Xl3dW18ZEsBzBIfJpNze+fhXq5oHts78G4YUO6oR
 9aa0SNfAna259Vn7ik91kdxCfQwNb/rpadRJUYf5kho3Oq+OzLTwgep/A17c8NJvr0Ef
 RVdFqatIniW3goIY+aa0lymZjFUVZGLSySnmUQ1HnN9RHpdO97xKi1u6NzyBrA7aFGyF
 7r0eJJysq1l/aBuX18+nrgovOTV96TUKNw5yebj9e5S9KrKKyr4WDvAW22FLJqBR/5eA
 o7tAvDcs0gRSsFkWjAke72b+VJq6L4xHOmvo6Q0InBCokI1YOrbbv7iKQorRgvil9yPS
 Q10A==
X-Gm-Message-State: APuU4Z8ED+wY8zX89aEcj6/Ufw9UMx59M313VTxVq/rbAeyRlbcTvXJg
 O3bbhaTzpDROWCH6syvL86v6CA+wIkZc0CcL/RlI1Lu0PafL8JDPnwaGC571kkdqoaA6jE4CfcI
 aCD56BNxJDA7VM0BX/zEVp9T9LnXm9Ia1YQtg91hE4rjLZw7NgGs77DOJBXpb8FhrIThG
X-Gm-Gg: AYBFou2zcQukYr/xfKCZBz1GhTrpWhLLDcXtgvROR6VxY7JBwACp2rxg9VPiwLIPj0y
 rLbSD1MjCVUVrAJYuDaUXqhVThY/T7UC5aNwEzKkbl0HfoLkz0eq2Qeyscx7epysii9T1cVJpSw
 uezcLhqokB6w7hOMhj06lfCPiGgYWi0zxnQ1gM8qR21JDm+lnVIcfon7YE3NCikpT5JGlhpwfj2
 EUJKBJWiRkS3OnPZrWx/rUPbUKOpyw7jHcAlcb1xx9q2hpijN46GlLdU0ap0WJrEWomSfPKa6wH
 wFPcp9elhFVHWdlfM03JVr61jBzgHaUV/hoj8biuL/EXaMVecf/IxI18nu0K5a06M1T8JuBgXSn
 y2AM64HfvDugDJJoSs/olopc0o7kylm+jrWgO9BUPvObjHUZ5ClrFwP2ZNeqrkQv70uH6nrcdBn
 10VrFVm44sR+TJoA==
X-Received: by 2002:a05:620a:44c2:b0:949:8a03:c35e with SMTP id
 af79cd13be357-949bab32eaemr212584485a.54.1795131309648; 
 Thu, 19 Nov 2026 15:35:09 -0800 (PST)
X-Received: by 2002:a05:620a:44c2:b0:949:8a03:c35e with SMTP id
 af79cd13be357-949bab32eaemr212580585a.54.1795131309131; 
 Thu, 19 Nov 2026 15:35:09 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm34030645e9.15.2026.11.19.15.35.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 15:35:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH 2/2] util/qemu-timer: Honor sub-ms poll timeouts on Darwin
Date: Fri, 20 Nov 2026 00:34:51 +0100
Message-ID: <20261119233451.47453-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119233451.47453-1-philmd@oss.qualcomm.com>
References: <20261119233451.47453-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX+D38W3PSuS21
 BrRHlrsCuhQTTdjo8EYEibcxBxjGxUkpPo268ICzjuqG757EIzrKU0DoXz6ZdLgwTjNjOgtP20j
 NJCFE4lwMsOf1KM52KC/C4jzKUD1Adj6iN7FAI0VYZd4ZzhF11nsM8cT4HihHH266P7Hqi50Rdz
 U52eMLf2nlwjV/5Vq+vOhopuTTedogbKaGBCanUPQ1AZ/Ts9yCm8tysLC8FvGzXv4/vVF1f5I0e
 RlcsAgc2sGTKrg600jXWXqNG+fwNOtsCogO90hQjqMlqwvm5iwCNCOJPY8QIqKUbu1EjEglpnGT
 gyXA3zhKc8Dj9IUFFENj76gCA0cYXexh7QwNsc/919Z/D+Bl7qpLyvJckFn6iGhtBU+8t5lFEIo
 jrXlZ43fkZY8B58KLDXrHoWVp6zB7TEfcF2PxjcCoonjf3F4ot7/XReB9AF7DYawmCMqdjihioX
 uWZGkzHmv0w3asWanUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX/iKXkPOpoF7Y
 jx7ZCXYOMWepI61rmpioksdxGUSE2iq5orm8z6GiH5gz+747o6jeV5oBpPOyf7BuZ48VIp08ZsZ
 LM/qZ9BsDggggotF2Yke1/JqMV9LrFA=
X-Authority-Analysis: v=2.4 cv=Vvi2kO2n c=1 sm=1 tr=0 ts=6aff87ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=v8LqF1X_Tm2BGTBEl24A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: QJI1NV0rvRtz1MB4XXVG9TsnkzSC6A2x
X-Proofpoint-ORIG-GUID: QJI1NV0rvRtz1MB4XXVG9TsnkzSC6A2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Darwin has no ppoll(2), so qemu_poll_ns() falls back to g_poll(),
which rounds timeouts up to whole milliseconds. Sub-millisecond
timers on QEMU_CLOCK_VIRTUAL can then fire up to 2x late:
a 1.047 ms periodic timer was measured firing every 2.52 ms on
the host clock.

Poll the floored millisecond timeout, then nanosleep() the
remainder when no descriptor is ready. This avoids busy-waiting
and the whole-ms rounding overshoot, at the cost of up to one
millisecond of extra fd readiness latency during the final sleep.
Clamp the millisecond timeout to INT32_MAX.

Microbenchmark on Apple Silicon M1 (period 1.047 ms, medians of
3 runs; median ms / CPU us per wait):

  poll ms-up (old)   2.264 / 11
  poll ms-down       1.138 / 10  (busy-waits below 1 ms)
  pselect ns         1.318 / 8
  kevent ns          1.187 / 7
  nanosleep          1.319 / 7
  hybrid (this)      1.139 / 11
  poll+spin          1.047 / 1038
  mach-thread        1.317 / 9
  kevent-timer       1.351 / 9

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 util/qemu-timer.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index d93a020064fe..86a97a6403af 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -342,6 +342,33 @@ int qemu_poll_ns(GPollFD *fds, guint nfds, int64_t timeout)
         ts.tv_nsec = timeout % 1000000000LL;
         return ppoll((struct pollfd *)fds, nfds, &ts, NULL);
     }
+#elif defined(__APPLE__)
+    /*
+     * Darwin has no ppoll(2) and g_poll() rounds the timeout up to whole
+     * milliseconds, making sub-millisecond timers fire up to 2x late.
+     * Poll with a truncated (floored) millisecond timeout, then sleep the
+     * sub-millisecond remainder with nanosleep() when no descriptor is
+     * ready, so we never busy-wait and never overshoot a full ms.
+     */
+    if (timeout < 0) {
+        return g_poll(fds, nfds, -1);
+    }
+    if (!timeout) {
+        return g_poll(fds, nfds, 0);
+    } else {
+        int64_t ms = MIN(timeout / SCALE_MS, INT32_MAX);
+        int r = g_poll(fds, nfds, ms);
+        if (r != 0) {
+            return r;
+        }
+        if (timeout % SCALE_MS > 0) {
+            struct timespec ts = { 0, timeout % SCALE_MS };
+            while (nanosleep(&ts, &ts) < 0 && errno == EINTR) {
+                /* retry with the remaining time */
+            }
+        }
+        return 0;
+    }
 #else
     return g_poll(fds, nfds, qemu_timeout_ns_to_ms(timeout));
 #endif
-- 
2.55.0


