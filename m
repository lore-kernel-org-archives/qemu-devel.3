Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22D606A335
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IHJpI2x9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VBgRgLYV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXO5-00022L-8j; Mon, 09 Nov 2026 16:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXNt-00021X-LO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 16:58:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXNr-00006g-G9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 16:58:36 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9tlR435352
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 21:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3mVaGX8g7rp2WMxEe+1AUS4/mhaVVIvaLYNdZUV6C2w=; b=IHJpI2x9mGUO9uWn
 uLnfsr4iK2BoIFIg5XxI8q68BWaTUFFVCxwgqRUtGjvL8VYM71f81L6VIXXPMbQI
 59xKfkS3lZjZ/opj3LvwWnA/d5bLHGttPnrHmfetUAh0FDoGOSHl6JAeTsJ2cAoP
 06YZd1WGyaps1fyQjz87UIQl7zqDDsGykwBDdr6Jov2O2xh30o+U5hN/21H+DpO1
 n9e8t+EEUC0TnGy2GCHZqwurmD+f6uGcD9fr4c1UUsQqlNcYgdzLriF1PDYx1pBH
 ZAPfELhA8CBBlDMpdWwwJH3itWJOjjlNQHnrr2frCJ+uevGL97EFwmZ81WuOdn7L
 jrgV0A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcja6wr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 21:58:33 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d2dd8c5aeeso234276137.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 13:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794261513; x=1794866313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3mVaGX8g7rp2WMxEe+1AUS4/mhaVVIvaLYNdZUV6C2w=;
 b=VBgRgLYV8wuSqIibZTHVXNMI6M1+FSqznbWimbQ7DKvERGipjtm0VAR39DcYPg/gg/
 alQ0rrsnagdBhh6e0RWA7w8z76jdQblsEeXQtSjqw9dvGvNQBzI+AaNkYkuvG9qKAdR2
 eLiOPDcQvWTs43bcVfcfYTZ01j+RaEAkea79MuJxcJBEAURkrEmPm4It7YbCDo+3CoFo
 5bwIkq+3HLCLP36/UhzeqpKVQb+ZhOELtL2CDJIN7cXyiNPz8DRzyVT+kaNAGMKcjEvc
 PlkVAuI6bAS72/2eTmgmb9oPdhbRrYKrvWJ4dm2NtCkkO28PGWtd4tuoFTK5WZ9Yz82K
 JpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261513; x=1794866313;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3mVaGX8g7rp2WMxEe+1AUS4/mhaVVIvaLYNdZUV6C2w=;
 b=Z/ejLEgCwUf/yQxgLhlqGcQ9lBq2RTVwAT6C7svQm8kcUCSGxZG1ZVnD2P2KPZLgs5
 61AmLNgKFin186UnskTQphS+TDpGWFKmw111Juq0ce6KfJ1Vzl3gQrQQof70Q55TO2L8
 zpp2adsgOsmQxlnlYh0/fewmc72nYPco1H2Ntwqd1cGJ0pdsFWIfOas/Cp5OlZzH3Yhp
 fq4QfZ6BgNi1N6ZuAOaxt+j3vDNzdtD4DKwjFNQuLL3r5gnenmB9zfS8xunWb6lQPJOD
 eXDRXUad8GwqfvUfmFSVLmtU+LtMAx55kyuLauTxn0YILo3u6Bun3ag/ztQo2zvMNJi3
 JVTw==
X-Forwarded-Encrypted: i=1;
 AL+hErFuqL6CRV42m7CsNKt0wW0aepCPyEQwVX+hWRAqT2iJN07VWEdpGiJa2ThmgOA8rQxSqtoDR/6SGUPl@nongnu.org
X-Gm-Message-State: APuU4Z+sTpafMcwjf5S+ynNmruHkR/aEx4ATzk3XDqRwz/gLj0b8ZWXf
 0wO947G7wz5vwAE7sibB6acp/9+D4z8PJPA7kcHnI0YOeG/NJaZwxRoBFo+JTyIoS0Z7vODDDg2
 mBKSesxeSOfby0yS3MKe+FkVBj6+XTkPA3LuK9PVj6r6dWOveEMJ+htV4pg==
X-Gm-Gg: AYBFou24nRLvtojft269z4ksEXsYGRAAxnmoDvYhdX6q8fWExlx1DlIA+c5eeEziyS9
 Wq2QVEoZYIk66j/7vsMp+qVVfLb7NsO2v8LiXaw9RQFDtbFfLHukVM1I03fXeiweO4WV3hkm22y
 JNcsY/8+U9dlGtudZACFbep3Z/wv4U8JREMDuMeMqv0//5BkqQiv4ZKm0m0uduP+wpVrPWJ0fUC
 SxE+H04X9P58vJiUQoPh7jFHhuSKPcped2N1sRN1pAsc/tQlmxGAfU3LNHO9bmsQr3HVebG5bw6
 dKbKBfXq8PTmZV8RnAlhy2Yl1pHFxeT5PfaenL1YWFzvTxCT+mLIfrG/ijTCymJj63dwZEbNegU
 nNbvIlTVjm6ghhTOH7JSW3ty5Vh91ixXo/80/GTSG0Cg/BReAHavqvgXvCPqnk8/Z0PwFKaBZVn
 XbYKWyPA==
X-Received: by 2002:a05:6102:604f:b0:7d2:d194:3dd7 with SMTP id
 ada2fe7eead31-7d301c2bbccmr179301137.36.1794261512551; 
 Mon, 09 Nov 2026 13:58:32 -0800 (PST)
X-Received: by 2002:a05:6102:604f:b0:7d2:d194:3dd7 with SMTP id
 ada2fe7eead31-7d301c2bbccmr179296137.36.1794261512063; 
 Mon, 09 Nov 2026 13:58:32 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49836c83432sm1106677f8f.58.2026.11.09.13.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:58:31 -0800 (PST)
Message-ID: <b0152f39-1e0a-460f-975d-aef91a8e34f3@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 22:58:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/ccid-card-emulated: Use QemuSemaphore rather than
 QemuCond
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261109203817.1683717-1-peter.maydell@linaro.org>
 <e9317931-6d8d-436f-b250-0c0a9429dd84@oss.qualcomm.com>
In-Reply-To: <e9317931-6d8d-436f-b250-0c0a9429dd84@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tCUyX_k4Lr6CZifbWwTm51rEkQ2jZyUj
X-Proofpoint-ORIG-GUID: tCUyX_k4Lr6CZifbWwTm51rEkQ2jZyUj
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af24209 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ljQ6RXDrGc5jxz0txh0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NyBTYWx0ZWRfXwnEwvGDAt9U+
 1LuUYfwa//UUkdi8JPDCgrzoBTDa17Lttv0LZuGBVqeCX5qAKJufr+yYSflNNyfrgdgFtNThg5N
 df8lFnLujtNSIHasMjrPAt4s9hgQRSU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NyBTYWx0ZWRfXwkQBrQOSemJh
 C2ATxMg3p7BpXuKI0FpmK+gfXd722kqosqWdfWghiOY8IoNSvElT5Y0kwR4HRhgog/ywJsHgT/c
 zoz5TcH+XYycTaTMyqI4ZW5RPyHb1qax8Ksl118Ml4Bf2+jnNkU5sl55tAYuKXET6trNElTTpM9
 eXeV6ki/iRCTdtiYzTapVdU06ZSzMZov9X32vOGmVblkaM9ZnJ9X22Oj3xR3hLthcnSctshqWmm
 hdbPS6kbTnqbDC4RFrhhqcOa1Ai7lRo3xzuocMZZ/uA/7mkzNsWZQSIXFbrYQXRC4wO5g96vRtl
 5E6djn18ZNPKUi+5hQ7lRlFsLhyRP9HvTe7FjL39V6Bqf08quPPT7HyOmp4VSn11YDUgASk1ovC
 oGnlCANv5tiV7gBcsmley0wzfRQcVZ39wtcz3hhDJfsp6lIKZhZYshhPZmOeywddD/7RAYbc/yv
 oK8T7r+K4U+b3h/XqlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090087
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 22:38, Philippe Mathieu-DaudÃ© wrote:
> On 9/11/26 21:38, Peter Maydell wrote:
>> The emulated CCID card uses a QemuMutex and QemuCond to communicate
>> with its helper thread, but all it's trying to do here is "make the
>> helper thread loop wait until is signalled that it has more work to
>> do".  The existing code functions correctly, but "wait until the
>> other thread signals you" is more simply implemented with a
>> QemuSemaphore.
>>
>> This avoids a Coverity complaint that we're not using the condition
>> variable in the standard
>>
>>     lock mutex;
>>     while (!some_predicate) {
>>         cond_wait(condvar, mutex);
>>     }
>>     do stuff;
>>     unlock mutex;
>>
>> pattern.

Similarly on hw/usb/u2f-emulated.c:

-- >8 --
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
@@ -148,9 +147,7 @@ static void u2f_emulated_recv_from_guest(U2FKeyState 
*base,
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
@@ -331,10 +326,9 @@ static void u2f_emulated_realize(U2FKeyState *base, 
Error **errp)
      event_notifier_set_handler(&key->notifier, 
u2f_emulated_event_handler);

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

---

I'll send later.

>>
>> Resolves: Coverity CID 1547639
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
> 
> 
>> ---
>>   hw/usb/ccid-card-emulated.c | 22 +++++++---------------
>>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


