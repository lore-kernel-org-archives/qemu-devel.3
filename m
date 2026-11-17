Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14290606A895
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=izNKbThv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ef3wYwNm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFOZ-0001OG-FO; Tue, 17 Nov 2026 04:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTFOP-0001Ng-G3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:22:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTFON-0001Z9-QS
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:22:21 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH8nLYg844338
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aSP0ylQGd/BxdisFXMRQMhtoZyp4cdpWdqn221kA6Fs=; b=izNKbThvn3KZD88Q
 inkpovWAGrqFKOKvTwDudDCUGf5/bFv9AvXiMWtjz2/ucBWu2+cqjosmct+x/ht2
 U4EqM1gx12HZ1YOFQKLl0MffkV3/U2MYcPcLVBN9c89S6EaeBwSt6OCx/Cf1qYOy
 S03uXk/+YGjI2dQQ02/Vzp++IQE02mYO1MlkaSx8G4LQTeBmZj9JjZD2SnnbPGMs
 f3juo+8ct6Vb1Jmu/85LOaINK/Afwq9vWsZ5/tqkBeTM0eRd3JfQcIzlEp2X91h5
 yQ+dVLKLj9hxDTOdSjMslt0nP9MKF3wRiiNZwTqWV4M3yrAePaBgjYMtXlmzOZ7J
 7vAALg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0c7h1snb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:22:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so444395085a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794907338; x=1795512138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSP0ylQGd/BxdisFXMRQMhtoZyp4cdpWdqn221kA6Fs=;
 b=ef3wYwNm0mm0sVccX6MimHQ2A3c5lNW0elahuydaSqtc4hMoZKZn7ngTyVN3objn3L
 7gsPHFQGbaL+aPKCYYQ1M6bAGUScrf3JQbitt81zUadXBEWV1XOyRDTAVITEGJnkIJwP
 qG6qmv9R5IYSbBVvEffK/RQea0nto9K0GBHz4nL+w4zlhfiHOMGUbEQzNeEePzT2SguJ
 +iQLY26pFOD+AM+mMCyFpOvFqKN7nvbZ2/BW5xEzKmyBvsqISelMvP1nGqOUuNB/Jsdq
 hiCY06m8esNR4fsuBIWIZHaT0vm3sMgGB0E8p2/dFo2QXAPchypvabmq9z5bVRAiJpqa
 Kl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794907338; x=1795512138;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aSP0ylQGd/BxdisFXMRQMhtoZyp4cdpWdqn221kA6Fs=;
 b=D5SBfWKsjbRZl5yDAcWU1xe+UaQH+2LSDRj3hnTm8sNO1ATeciNwwsRA40LdWpmkZp
 e0WUgkvR9AIh3ayYXKxOsvaBiEdQn6NIMezPlg0Tc6QQ5FLIsC/2rBJr3xviivvxlE//
 3Jt21Ls8CZWzj/9+N7jFMGFRaEvpdK+Gqr8ROT50CNhIrnf4eY0JUHlmsXkm0BpT4w51
 B0tAoGPgDTEe5bJ24Fk5eabAj3k2ikPXY4V26jaRboI73p5ilZgoahaad62AD2LL/3+r
 Z0d3DGp0xbJ9amfiiuNh3Hr1Em+OstOMORqPpEf7gPNM0x9AuVbtzLydTGjLfLMI7Jx6
 6Gqg==
X-Gm-Message-State: APuU4Z+LkqKIamu5om1LPJdA9Dpq6sbiXrNnusxjDuIrckhh+L6RME8E
 GdG6azSBmXgkCGkETIcA9QT2KyOSwQUbk6VVK1MMkZ5RiyybbxvW6/p9aHo9QRpIyzsmHGWpyFG
 j8lekDScmgfJc4gwDneaI6KM+YxDudvzDUVFC6wyIDDFCKkcFGtCY1wkj4rhDceHgmA==
X-Gm-Gg: AYBFou0A8xQOufY+5ALuBq+BPe58BlZ05caZUNT4S8oQOEpJkVq07FBKgVY6IFYzoRB
 dh2Q0+59VbOCE/vx8L3LILu9Ma0pURrAUjB1WiBW8W+uq/QF2yOfLprOmmvW7qiaUnRahUXrWk5
 8HBh41Ujreq6qAFhyg/8NYf8xx8yvITe+QCgp85u5bzz1LRwEjcvKNtLJkCN5yvCT9zBrrJbdS/
 mQUCTeaZQajS22CHRCZtSWBHDrRX+hMEa5Exra/sbOsDR2iN//BDO3ZY0gtXp7Y05ebSJVXEjQt
 EJ8YG4jZ38u280y2xOfx5e1t5BDOeC1lfi1ak35Sby2Z31NdTOBXsTdNwkP+T7WdiVVCWKsEVH7
 c6BtMxDAlJqQjny7k3YGGUYD+r+ZtAotIR6vUCCTsv/bmzcZv027va210fxjIham439fihLGcM5
 FDDjOFysippklkIg==
X-Received: by 2002:a05:620a:710d:b0:93e:c691:a1c with SMTP id
 af79cd13be357-9494bcdb46fmr2160225585a.76.1794907337881; 
 Tue, 17 Nov 2026 01:22:17 -0800 (PST)
X-Received: by 2002:a05:620a:710d:b0:93e:c691:a1c with SMTP id
 af79cd13be357-9494bcdb46fmr2160222185a.76.1794907337266; 
 Tue, 17 Nov 2026 01:22:17 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f7828a4sm27000485f8f.23.2026.11.17.01.22.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Nov 2026 01:22:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/22] hw/usb/ccid-card: Use QemuSemaphore rather than
 QemuCond
Date: Tue, 17 Nov 2026 10:22:08 +0100
Message-ID: <20261117092208.50442-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117092208.50442-1-philmd@oss.qualcomm.com>
References: <20261117092208.50442-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TUAJD8aMiS6nxr2QZ2m5go6IyAIYu1Ve
X-Proofpoint-ORIG-GUID: TUAJD8aMiS6nxr2QZ2m5go6IyAIYu1Ve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfX+TH2/FFbvzs5
 0oDsfjPrdJeZF0JnJ/lObJW7kA/57vqf7aBIgyAn64vpRErQMsf24R339JqHfLv83L332L5cVhp
 uwPs/3oghAGTA68hdHptNGBXWqbDi0h4eKQ8gx7A2fs4hfbdkO7J6qd35HNxV9pprr/U0Tyvrm7
 B9t65HRJPsKwEl+NOwIPx5jrhFrRBamzODbCHOaYIMueKsJhGIKLMDTFqBSCX575pEpZLYw3eyb
 p/7BgOm3xhFb7wX2r4wKEikNYxUbvUyo9v61u480fdyPR+KYN0yD6MAn4nH9VXwXTlNiqAAPfq5
 MGOgZUXXyngPQkwr7EeaAALBJAoyq9fP7NnKsk5ZelKR63zyRy8NweZUdJ3zib4FDz7quZMtyI9
 Y57eeKAsga5uljohh1nLqfsHHK5bXtre/b0HA0Reui6aWedqbmOprRdqEBIwWZG90avhsGym+Tq
 ohDEV5CEhqik456jLLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfX090NkbK0Ys14
 xYLZpLWcS8lkmwH7JxDB7h2bi+k27PWcN+IM/qsjCfZ3fgxCMqo1hq+dNX54RMuazxFU3dwI/xB
 GkkOtvHKRPLZzlNKCvwRwDKXIwPBIIk=
X-Authority-Analysis: v=2.4 cv=bobZl0ai c=1 sm=1 tr=0 ts=6afc1cca cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aOiLcrS4A5S5HNe15wYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170037
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The emulated CCID card uses a QemuMutex and QemuCond to communicate
with its helper thread, but all it's trying to do here is "make the
helper thread loop wait until is signalled that it has more work to
do".  The existing code functions correctly, but "wait until the
other thread signals you" is more simply implemented with a
QemuSemaphore.

This avoids a Coverity complaint that we're not using the condition
variable in the standard

   lock mutex;
   while (!some_predicate) {
       cond_wait(condvar, mutex);
   }
   do stuff;
   unlock mutex;

pattern.

Resolves: Coverity CID 1547639
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261109203817.1683717-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/ccid-card-emulated.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 4083cf8f4be0..4bd5399fb6e0 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -129,8 +129,7 @@ struct EmulatedState {
     VReader *reader;
     QSIMPLEQ_HEAD(, EmulEvent) guest_apdu_list;
     QemuMutex vreader_mutex; /* and guest_apdu_list mutex */
-    QemuMutex handle_apdu_mutex;
-    QemuCond handle_apdu_cond;
+    QemuSemaphore handle_apdu_sem;
     EventNotifier notifier;
     int      quit_apdu_thread;
     QemuThread apdu_thread_id;
@@ -149,9 +148,7 @@ static void emulated_apdu_from_guest(CCIDCardState *base,
     qemu_mutex_lock(&card->vreader_mutex);
     QSIMPLEQ_INSERT_TAIL(&card->guest_apdu_list, event, entry);
     qemu_mutex_unlock(&card->vreader_mutex);
-    qemu_mutex_lock(&card->handle_apdu_mutex);
-    qemu_cond_signal(&card->handle_apdu_cond);
-    qemu_mutex_unlock(&card->handle_apdu_mutex);
+    qemu_sem_post(&card->handle_apdu_sem);
 }
 
 static const uint8_t *emulated_get_atr(CCIDCardState *base, uint32_t *len)
@@ -238,9 +235,7 @@ static void *handle_apdu_thread(void* arg)
     EmulEvent *event;
 
     while (1) {
-        qemu_mutex_lock(&card->handle_apdu_mutex);
-        qemu_cond_wait(&card->handle_apdu_cond, &card->handle_apdu_mutex);
-        qemu_mutex_unlock(&card->handle_apdu_mutex);
+        qemu_sem_wait(&card->handle_apdu_sem);
         if (card->quit_apdu_thread) {
             card->quit_apdu_thread = 0; /* debugging */
             break;
@@ -496,8 +491,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
     QSIMPLEQ_INIT(&card->guest_apdu_list);
     qemu_mutex_init(&card->event_list_mutex);
     qemu_mutex_init(&card->vreader_mutex);
-    qemu_mutex_init(&card->handle_apdu_mutex);
-    qemu_cond_init(&card->handle_apdu_cond);
+    qemu_sem_init(&card->handle_apdu_sem, 0);
     card->reader = NULL;
     card->quit_apdu_thread = 0;
     if (init_event_notifier(card, errp) < 0) {
@@ -556,8 +550,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
 out2:
     clean_event_notifier(card);
 out1:
-    qemu_cond_destroy(&card->handle_apdu_cond);
-    qemu_mutex_destroy(&card->handle_apdu_mutex);
+    qemu_sem_destroy(&card->handle_apdu_sem);
     qemu_mutex_destroy(&card->vreader_mutex);
     qemu_mutex_destroy(&card->event_list_mutex);
 }
@@ -571,13 +564,12 @@ static void emulated_unrealize(CCIDCardState *base)
     qemu_thread_join(&card->event_thread_id);
 
     card->quit_apdu_thread = 1; /* stop handle_apdu thread */
-    qemu_cond_signal(&card->handle_apdu_cond);
+    qemu_sem_post(&card->handle_apdu_sem);
     qemu_thread_join(&card->apdu_thread_id);
 
     clean_event_notifier(card);
     /* threads exited, can destroy all condvars/mutexes */
-    qemu_cond_destroy(&card->handle_apdu_cond);
-    qemu_mutex_destroy(&card->handle_apdu_mutex);
+    qemu_sem_destroy(&card->handle_apdu_sem);
     qemu_mutex_destroy(&card->vreader_mutex);
     qemu_mutex_destroy(&card->event_list_mutex);
 
-- 
2.55.0


