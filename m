Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20E606A337
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O/NRtcAc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RpQ9nkTQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5JU-0002yX-FC; Mon, 16 Nov 2026 17:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT5JS-0002s5-BI
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:36:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT5JQ-0004hP-2i
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:36:34 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfIkc2729026
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7VL7yt1gZqj/1Wmi5C5gdJ
 ZR161bYCNHu/sjedQgVTE=; b=O/NRtcAcTznndhyj0VU6V7p9FTRSVGMXZpbNO1
 XfJR84bjtgozsMegTd94/1ysfcrf/rqtvy6N6ED0ZjZxhGAKF1rVOwqFJSf9FICS
 O22U4BRC2ddjV5nlImoat2LNt6W4FxRRF+GSaEMnUkaVNHmueckVHW3ZW/h4Zt/y
 9OECfAH+5iAB/zQAXEuaYyeUp3tySrMipxobHIrZSA08yeFHaXlwjmIJuzIFtqH3
 xfEXFq/5fBaUx/FnvLa/okCRhaRLzlrXndVM4gAsBBDXb8NIs5lLKKRDfl7AKItw
 Z5dypvNZyl/f8DYQGBtqVTKeV+sqt3idTYqkTYQ3WYMCPtJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regq25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:36:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495af07676so567428285a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794868589; x=1795473389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7VL7yt1gZqj/1Wmi5C5gdJZR161bYCNHu/sjedQgVTE=;
 b=RpQ9nkTQPZjlrx60I4DaLGlqJ3qLVcvCBccsZsq7w9wJ+4jKxywpOUJRixxaxogoMA
 uZXjN/1unxu47ynUZcb08ftHle2ShSI/Kc5FGICIO5e9JzVn/zozbYHIdyQl+OWqtfxM
 WVxLy3No9TyN7OiMVVxiBD+MRUD0pTmeLSJRSht5jApTr8IsHfA0vIchW52jnMWoPjDm
 OiAQ699Imp/UcD0odrS8kn5MPvHF2+KPFdtcilSIa/42rmDbYTXaRT/zG6XXv3mujtOt
 I7bfH8sDo+Qz/TxlzO8eWFRg8hM1pgLmPVIuvg102wrdCr1UE1mqfMsHTTQ07Uf/Erci
 4arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868589; x=1795473389;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7VL7yt1gZqj/1Wmi5C5gdJZR161bYCNHu/sjedQgVTE=;
 b=C7tCvCA++DjyEpeNtfJs2doFVLSImeacJorjNqYJMuMwV+tb+wjYiRXFbSpQ5ON9hY
 JKGBBrNSJpOVtCAe4LGEGtag47oDMt2RCFddgRKV7aZpkCOa1uxeVv306UXDuIp61EhY
 bSmZlTSZitqy3nWTESQpYYYx3SU3SZSwF2nWFdkFGHcorpm+XnsM2WnsOD31fl5BpFI+
 eEMT8FOcKQ6iAc5SupXLopgCfDs6PKIcLiOIX9NX9a4n2QdlgPSeuFUzwaG3FfvjLbBx
 mSH7cycQD+Szh3uJ4R1ZIhdcWM+l4ok4sj9BCuvF1C0hk4oalpJhy5878Kg9Y1BC0AO6
 aFyg==
X-Gm-Message-State: APuU4Z+1q93sYxByYYAZzyDCsJaA5EnlTE3pedrvrnaV0Zqmv3nAta/M
 2qNh0Jp26YgVhyXlRLzGqsGotvVueBQ8FCOrj/CSY2ctICJJiss3Ziuyvr2Z4cHsdMRCYmXuLp4
 /U6bLRVobbFWLRJB3NHBj7pHmd6uF9uDljZiiOz6JfC2MCXmvwe/NDy1SPWjCQZXRGA==
X-Gm-Gg: AYBFou17tGmQRJwYCTLQKGbd3OiN70hl98kfkvYcFJLCNYt23f4gBU77RkKsQFh/A6+
 SVjJfbE3lLwdvYiWze/Ethuj5rZB+3Qv3Zv+JjerYLY+5y5dAeyANBhb/ozwpYNdiP3TP8msKPR
 ZgzWC+whrbv1qk6uOR5w+DYdZuev1PMTFpfeCfRB5zYs0MXxy0pXZEL8YeBBV+AuL9cLV0bu/D3
 KzTDEMrHZMWbZU33AdPZz9fn6ZoRlMUGrVacBfCFMWJR+qlLc1y9GRZi05s1xEYRGpdgqxjSHiS
 hwIu3bXSUCYyqVrZJKltk4K81qESNSt/eqfslAXhfQMkqVZzqoysAbw0PAhz8ywfN7SM0HcnaRL
 r8nFuO4vAYTgnU+T5CaichyCB8NQVAleZsglAD2hicHsRbB7FcMoqc50xf61GdxLhgS7kn+d/B6
 RNjT1raisY54dmuQ==
X-Received: by 2002:a05:620a:6910:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-9494bbc8dd4mr1989070885a.65.1794868588817; 
 Mon, 16 Nov 2026 14:36:28 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-9494bbc8dd4mr1989068485a.65.1794868588400; 
 Mon, 16 Nov 2026 14:36:28 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f782396sm24422817f8f.24.2026.11.16.14.36.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 14:36:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] hw/usb/u2f-emulated: Use QemuSemaphore rather than QemuCond
Date: Mon, 16 Nov 2026 23:36:25 +0100
Message-ID: <20261116223625.24296-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX4vqf8ZKnvMjO
 diq1Munx9GF3S1/g/eKv1KY/K0VYLo7GeO20h2zRDQ8ARO7B9dOjjlZpLt/+Oe7m4PxvLnT1wGd
 ijSDHYfdnz7q/keMUHVdIPkDxlFG2AA=
X-Proofpoint-ORIG-GUID: n_nG9C3TpDiLPVMFCJLIH_Thubj-G3Wr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX0qS8eulyHGfM
 BBJn/CxpdD6bplgmLobT5a2DRXPWFh2bC7/459Xi4B78APSGWxxBxmVjoANOiH/n0vBhxWG7m3A
 siBF1rpF1qFVKSAUVjgFQG7r0ZKlR6RfHiianhxq/FT0RSririwjUbCmmI4n7WmFsS/DbPbGWxt
 RCbVKi57S4/J+8TwcowStu2uBi19xqmHWqKAejZAF4L+RbfqY8awJPYF/GGXwJJi2whpmp9/XW6
 ZPWCKsXHv7PQrA9kJAKMrQzAOlTTb/FOE0+oZ2amVNhlH2as/W1NVU9Ns2yfrReMeyy43e+OIgR
 3K2hc8px6o7Y5le6/HpeHvFa4w9EchzxwC/j5c2A91E56A++51O1BqYjrLpISgHTiTIf8Gk8Oi/
 Cgtz7PThrs7Xh68xWXPWUG17NylgzSoDMPo+4ph6rr8jgLna6BhuDEGGnuTtLnTxSScUz5jOKrJ
 BAVePpVtTf2gmK4kszg==
X-Proofpoint-GUID: n_nG9C3TpDiLPVMFCJLIH_Thubj-G3Wr
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb856d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=B8pVnTZ1yy_fOrvyf7sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160090
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

The emulation thread only waits to be signalled that a packet
is pending, which a semaphore expresses directly. This also
avoids the Coverity complaint that the condition variable is
not used in the standard lock / while (!predicate) / cond_wait
pattern. Same change as ccid-card-emulated in <GIT_SHA>.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
GIT_SHA -> 20261109203817.1683717-1-peter.maydell@linaro.org
---
 hw/usb/u2f-emulated.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index b82a31501934..0aabfc514b7b 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -90,8 +90,7 @@ struct U2FEmulatedState {
     QemuMutex pending_out_mutex;
 
     /* Emulation thread and sync */
-    QemuCond key_cond;
-    QemuMutex key_mutex;
+    QemuSemaphore key_sem;
     QemuThread key_thread;
     bool stop_thread;
     EventNotifier notifier;
@@ -148,9 +147,7 @@ static void u2f_emulated_recv_from_guest(U2FKeyState *base,
     u2f_pending_out_add(key, packet);
     qemu_mutex_unlock(&key->pending_out_mutex);
 
-    qemu_mutex_lock(&key->key_mutex);
-    qemu_cond_signal(&key->key_cond);
-    qemu_mutex_unlock(&key->key_mutex);
+    qemu_sem_post(&key->key_sem);
 }
 
 static void *u2f_emulated_thread(void* arg)
@@ -162,9 +159,7 @@ static void *u2f_emulated_thread(void* arg)
 
     while (true) {
         /* Wait signal */
-        qemu_mutex_lock(&key->key_mutex);
-        qemu_cond_wait(&key->key_cond, &key->key_mutex);
-        qemu_mutex_unlock(&key->key_mutex);
+        qemu_sem_wait(&key->key_sem);
 
         /* Exit thread check */
         if (key->stop_thread) {
@@ -331,10 +326,9 @@ static void u2f_emulated_realize(U2FKeyState *base, Error **errp)
     event_notifier_set_handler(&key->notifier, u2f_emulated_event_handler);
 
     /* Synchronization */
-    qemu_cond_init(&key->key_cond);
+    qemu_sem_init(&key->key_sem, 0);
     qemu_mutex_init(&key->vdev_mutex);
     qemu_mutex_init(&key->pending_out_mutex);
-    qemu_mutex_init(&key->key_mutex);
     u2f_emulated_reset(key);
 
     /* Thread */
@@ -349,7 +343,7 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
 
     /* Thread */
     key->stop_thread = true;
-    qemu_cond_signal(&key->key_cond);
+    qemu_sem_post(&key->key_sem);
     qemu_thread_join(&key->key_thread);
 
     /* Notifier */
@@ -357,9 +351,8 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
     event_notifier_cleanup(&key->notifier);
 
     /* Synchronization */
-    qemu_cond_destroy(&key->key_cond);
+    qemu_sem_destroy(&key->key_sem);
     qemu_mutex_destroy(&key->vdev_mutex);
-    qemu_mutex_destroy(&key->key_mutex);
     qemu_mutex_destroy(&key->pending_out_mutex);
 
     /* Vdev */
-- 
2.55.0


