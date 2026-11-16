Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB09606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XG3vIuU1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cgW6RZsr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT652-00073C-A6; Mon, 16 Nov 2026 18:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64z-0006wE-6k
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64x-0006OL-4n
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:40 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLH7Wo2245783
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EjrkEOTCTRQf9c7lyt2Pfmwv9PvkZRgk//FbamjNfL0=; b=XG3vIuU1IAut2r9H
 mAWKXfYx/uEnFnWjRGcwyUlUsU7VEkMK28Mx78buyV7NJuOA90PJLdflK1/AlfIn
 yEVkY+DEi4ojrqanPiP5K6p+VwIonJghjTWMugAOuc5q35xV17w4pm7PblkLLHkY
 8XAok/s2ICkNr71AG4qUqF2rQV94/YXBWmuBoLc8fo1NG+eLeJ8ofLmkZ3YHRMXh
 bgeMIjJQ3jcLMwfP5H0Ef4OBGHvDA5NH+QFjW+rkRqEd1qrWKw6k4B7QPizUGNa4
 ydiPhTVR1yPqDtXGSqieueuQKqBsVy/pfP4XYlm9TIUe+gTZqQQ411F3uTPDrQEj
 C+PL3g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m08d7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so713223485a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871536; x=1795476336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EjrkEOTCTRQf9c7lyt2Pfmwv9PvkZRgk//FbamjNfL0=;
 b=cgW6RZsrOVFOxXWQGm1qc+5jFSK1NHjNn/gRrqc2+Ky7DGWK9d14Gp3xjDb6utRJo8
 p8SPZwItkHdWxXmHv0CCN7mj3JdDWFFbzQpJ3CRSSOeU1x92D6zH3/HLvqEF+H3m8eBm
 7siSdtRlzf6LsOcDHsLWdrEWnoh3LTdemwI3WHyRr7v6mtDQ53G5/ACdwGDVjOyIPeek
 xr7tIrkpG5m83jPYUfoYsv8WreJEQvCWMocbXcwUXNCJ5LVm/a5Q0cSgwAb/kXHtelXY
 FuQ1Sja8MMvKJ79EVPMDPm2f0tLrmGGe2qnKlj1+RWBaBzZScXeHMWL2sYufpVBolxDd
 i8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871536; x=1795476336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EjrkEOTCTRQf9c7lyt2Pfmwv9PvkZRgk//FbamjNfL0=;
 b=bd8MmFb1HuS9Dq8OILkLHx0+POYmDmiQkATOin5tf7a1KZoFAjEKRwsyGuVsKJb5wM
 r9p4gIZRjvv25mWHNi6H4swTM1WOtxWKq6cWcKZdOhQPSaJuiOA9qL6xEksKnW7T5Azb
 8eOFTrV+aptM4RcgM3jsXX2OCNCsbjG9jZ6xBVYfpXQt79EFzm872mf1nP/e+TAitW16
 Tey7T2re97jnXBNtu5+83Os9swdueqQW/T0ow8D+JvA4e1m/PTGoxehztFk7dcHptFsC
 9TxQ0VlhEkSOL8yt8yJdkIgB5Uxip2uo7jPblEh32KVGusPegl4frS57e/BcSsvbaU3V
 17MQ==
X-Gm-Message-State: APuU4Z96qJOLfn/HETUA/Gw7N4g+ChzQYLhxFjImK+C5gD+ani3EKYkl
 MOqbxUDNWjlzIdsM4Sj/9SYk/6yqY08ydFDnUMK9GXP/Lq+O4kPCe4qhwS5eVZzrTjrnUg31zs6
 GptEGPuDj2osKV/L8wOUuklx98AQMI077uGbtH866VuPpkdspl6/d61pNChmlsQch3w==
X-Gm-Gg: AYBFou0Wpe6yRUmCelelTHUdegA5yWm150Dpi2FPBxSv13vCTaKFugeuB13C9EoOYVt
 9jeMhABdPp5EdWCtrkM74WW6z/wVhs9SclSQSO9JUISSrS34LbffKEzrKNVu36UrB3Xsmyw1oRa
 l5Up+MG87daY7XMZLzwpWtjm79KVQ+VMtKQcruhmqI5cU9qKb4NK4dJbocrVW5kANSiZtG6bNhn
 JZIwDBxn+bdEbxgSjb3tODLsh15UNZSda1oiwU8wQXvkN+EnBq4fvtOElmrCzNmEPwaSJ+/chGO
 h10BHtdYZm+ddPLS5ZtKDTl7VjPLmA1Upso9p6WYpx9wiUDkg9W2xn5Oqt+Wr8VuFdTOWvhJzX7
 q8FJ5Ehqg6qOouGXSG/pC+1TOL/+zROAckKysqkQud//y4mjOdVOem/o3dDV5VvJ0o1KE5oqFDJ
 v8z2IXqW3yBda1OA==
X-Received: by 2002:a05:620a:1b9c:b0:948:48b8:6736 with SMTP id
 af79cd13be357-9494bb96cf1mr1856062785a.16.1794871536382; 
 Mon, 16 Nov 2026 15:25:36 -0800 (PST)
X-Received: by 2002:a05:620a:1b9c:b0:948:48b8:6736 with SMTP id
 af79cd13be357-9494bb96cf1mr1856059685a.16.1794871535940; 
 Mon, 16 Nov 2026 15:25:35 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4e2esm24384463f8f.36.2026.11.16.15.25.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/22] hw/usb/ccid-card-emulated: Use QemuSemaphore rather than
 QemuCond
Date: Tue, 17 Nov 2026 00:23:28 +0100
Message-ID: <20261116232335.31593-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX6TavKQ0JEC7Q
 knLEv61VhZpOpAVuV5qDmPfr3oWSi4b5HpIC6N2/SP+KsGouDSGaTb2GXb+irzKwyGkPjgenLZJ
 49USpbP8Di2UKjfMwiGoSoMZ9X4mqtM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX2aJDwZGYvg2f
 GkPgzP9N+WJd/TQqJbNsGwgbLiWVU8NxOoPOeHqCAP1DAbaUisF5jzMDuoQD8PqE8nhv1hEqMD5
 FhkpM+GGjz2349+tugdVtSPF1xZN9VKaR4UpPNwGYq0nXw1/3NvPUmjkz4kLs2M92Y+PbnTzgoI
 LGGYYbExEf3WnnE7h1DMo1W008dQG+iqCOg/6IeJ1Z4MaEb4AW1NUENR7g+5mPAxmrVheCEeegx
 MbAiQBmmRsyeGaWx+G5hTuswFIr//32ZnsItM8TphXLlbmxW8DdwP7xll1dfm/9UUu4g0tRyKrr
 G6fdoUiCtz8r9IScE2atSOzHzSCakJIk+ujqt5Iipkfy/V5alahxwX41GeflCKGreBFFVu/MQeU
 h1+SKmKj3kjwH2oGC2oPju740cdo6RFK/7mAJeVeF9tFaN00xvdQTKGMQGspTQn1XlLRjBJksdw
 1TLMHle6Ll3T0W2wk8Q==
X-Proofpoint-GUID: uTwm3taYHD4F7Aa4_9Yz28_ttiF-ocbP
X-Proofpoint-ORIG-GUID: uTwm3taYHD4F7Aa4_9Yz28_ttiF-ocbP
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afb90f1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aOiLcrS4A5S5HNe15wYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160093
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261109203817.1683717-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/ccid-card-emulated.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 6c8eec39faa9..c504c52a7cdc 100644
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


