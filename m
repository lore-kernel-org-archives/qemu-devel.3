Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3399606A885
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IYROJWY2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DGZLOEP6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5gf-0002nj-PU; Mon, 16 Nov 2026 18:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT5gQ-0002h9-6C
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:00:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT5gN-0007eq-Jx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:00:17 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJf94i2589355
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xi4BNiCjZX1DqUAqVKtC1cVvEfaHJH96/pUoiUSs6k8=; b=IYROJWY2ZqLqIJfk
 7ieesz7bL1QkgXuCM6eS86qw3hmSmhtALYKK+P+z2CubPGS+57/ZmqP09mcDfgub
 u1sDNtHWjW1fxPQjGXdjp6R0U67vAXtLeeQA/d9cwDQXveVB0LoVzPVS/k9OXmtL
 UYm95Cq6UtlxT8CKDVZ2Dkzs2K6syh+z1q+YRTn3tYmCsuYPUvCtTA0TCegcek0U
 1GQX7yQSsI6trOZXg/ijR2wJE+p+H0kTLm2FU64w9P3ZpdwV4PXNT6Qq6HF2Pkkv
 qjxarMzEeOHw0ds6jN474hCmb9lT/35zVIx+I0433DR+aD6ZM5iXxPkGyMtpVa5a
 W5cr2Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k5mj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:00:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3724667bc16so222395eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794870013; x=1795474813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xi4BNiCjZX1DqUAqVKtC1cVvEfaHJH96/pUoiUSs6k8=;
 b=DGZLOEP65Zljr+/AUrz8x/ubwPESA9thIi3wjyJuYwcl32NXwpfWMEY4P72U+lG2pY
 OGF4VNgxYcmlupMbIvwAubT8cF50Z7M5zpJOaJerOpywhDNHkT9fyWzxB6x4Skn96R1u
 16vFup5P5cxibiGruKElsjBqV7dDFzjxZ79pHgL5pH009C2ieO59MvAKzit0Zyn7tWYO
 9DHEhROVbnAFF3ZIjcACksXAtjufc+zrP6Dc2rQMAF23ZbJuVP85hiMS4S01Ri+lNens
 TbVJTKvIdQhL3odl4WlgLatHrybZL4fCi7rIe5UuzYeePlfSSHu6qBWcmh/cE/b6hBz6
 412A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794870013; x=1795474813;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xi4BNiCjZX1DqUAqVKtC1cVvEfaHJH96/pUoiUSs6k8=;
 b=x/K/f/Ulwo/A+SWgUnQ9i97RKHGedeBfLCWf8qTDYHp8CmSsf6/tRxZ6BmlFhl3ZQ5
 nhlygBpAgrfPjRQEKAX6cYNn+rF7Ml37WAY9OgE3SE5KrEBj50ZVrxjjQsZ5Dax4IsyB
 JnneLuh0joMxbd+kv/mZk7axOIxbEkHnYogn3qrq8lqx7CGS01je+XpSK2W6vW9LFm7m
 HSCDr7CrEML3IWAOZBo616hjbEDozxLfsBHK7gxKf3kd5FBTxpwxK/XXHlo/EqgYc5x/
 bYRsORFIjSCqUKWB/BezJUghcN9crR0je2m+qV6KhBwhgNyF8FhliIaRYFfAYcdyXO6Y
 Llew==
X-Forwarded-Encrypted: i=1;
 AL+hErFDBW+4PQ3l6g1xJaCaIt4RkOEIvMAe+j6XjbJpp1JMpPu3AUk8jzsn61fPmmvX+hQWF5Tn6mWrJrnj@nongnu.org
X-Gm-Message-State: APuU4Z8ZwtxP7QddL8UketEagYNflnFtkIpnv+RULW+bpo94ZiyRp53f
 46PR/RK9kFLa8FOYCZmAkzwdCJNy9+3DtTL0SwUms6RsKYR0WolDU/SQ2oJ4pXmR60nrtZXKmgm
 QKNplt0Brn3Fkcd4HE+DJWfkJ9AtQoXa8ReY3OUuFUsSqHcQZLC9u6nBg1Q==
X-Gm-Gg: AYBFou1P6T4o7qGLM9LqQrx/wCfonmklAaUaXcf58EMf8v/CMzGjLY1Jbh8tImoHf8V
 hhudRBhZsbFvPwzbO0S5TONQCxb2IOwdGTgbxgeNjrQjQ21cA1FFeeWC2BZqonw0vjdV+SB+ICh
 gxZa+bM27lJRDuG3TgDazrvBu9wvEV+aeXcvpRzAk8mBbizL59AfwqZFK7gwS5TwL+kwDOCYtpd
 BNqDelKb9JXxMTGDtTUMsv/wi/32mEheVgOWDRBAgif9uqZiOpBMJgU525ybyedctx0iD3drPuI
 ttJO7Af1usTOJXLIhFmUmBDMwzotSqQpwVxzhvkjTBrMQIouUDkL/zzooXvMG6Onyj19EjbHVz2
 KpJCY0vZGAvgLKFCnxX7r2iGgaGplYMA5Kd95SC4Y0Z7yJfY6AZVNTyKwrmCMcmkkbXoci2Bvso
 SFHaxwYxbmyaEC+Zcv5/eDQQ9RGNO3sk03WNLn7ugQIig=
X-Received: by 2002:a05:7301:2019:b0:36a:2f6c:490e with SMTP id
 5a478bee46e88-3810e419e97mr764847eec.6.1794870012428; 
 Mon, 16 Nov 2026 15:00:12 -0800 (PST)
X-Received: by 2002:a05:7301:2019:b0:36a:2f6c:490e with SMTP id
 5a478bee46e88-3810e419e97mr764786eec.6.1794870011567; 
 Mon, 16 Nov 2026 15:00:11 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad6casm36739877eec.26.2026.11.16.15.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 15:00:11 -0800 (PST)
Message-ID: <df46f13f-b43d-4792-9f6a-50f807da1ab2@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 15:00:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/u2f-emulated: Use QemuSemaphore rather than
 QemuCond
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261116223625.24296-1-philmd@oss.qualcomm.com>
 <edeff463-31cb-4579-bbb0-8513140ee5d9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <edeff463-31cb-4579-bbb0-8513140ee5d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb8afd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=puCLdeK-po_IDJeTcnoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfX/ZPHpyLoqUDn
 KCVMGlxaR6CXZAGwT3gMRbaE9ys/grPeq90QkiTKD+h4DTYYjyyineiDHnb1epC+cdaQLo6xEHK
 oJAGvvm6rv9/qk/Gs1iN3kuIE3zJ3+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfX8qXfhUXygDMm
 uNSe2Y3amYIRSOdvx4Rmb5F3rYDriRrmPwGpRDQafr+15droBYcIDe3MWtnpWhf3TXn/DkJ1Wr2
 jWsms6hiqh/0tsKs2Fb9n90REdkg/4iUVUFIi+Y3N8Rsg+pT83nDdkQPHf6LkZ6mPOyEwDPXsRz
 wcUtvbJPqfBx5TSxyuziqX9vYUCrcVn6VoqZ7t6YFtmby5z5IBlVRy1VOiHaFHW72S+kRa0IvVv
 XkBXK78dYhrE3kcuMF5s55ktNwgjNxdDVBQInl5ogoOPWNMLaEQVC3K1/QAHLcfkI8WgcCp6yue
 j9TD4yL/oP9DEV18lFN7JmyEBp2FSO49c44cSz3L75vNslCqQO4u+0/PeMapporzYTGgKW7XGWp
 fRF13Gj6ObgWuUXEBCTkRJB1ZT+BHvJ40lMvT75G1/mXEi56mXWdZoBGQx+JbJmIWx2iztGzKnW
 xQVgtj6pPIJQYQFM1+Q==
X-Proofpoint-GUID: cuf-uWen6d_UsogS4lzwlFcYDtoAOxQF
X-Proofpoint-ORIG-GUID: cuf-uWen6d_UsogS4lzwlFcYDtoAOxQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160091
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

On 11/16/2026 2:54 PM, Pierrick Bouvier wrote:
> On 11/16/2026 2:36 PM, Philippe Mathieu-Daudé wrote:
>> The emulation thread only waits to be signalled that a packet
>> is pending, which a semaphore expresses directly. This also
>> avoids the Coverity complaint that the condition variable is
>> not used in the standard lock / while (!predicate) / cond_wait
>> pattern. Same change as ccid-card-emulated in <GIT_SHA>.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>> GIT_SHA -> 20261109203817.1683717-1-peter.maydell@linaro.org
>> ---
>>  hw/usb/u2f-emulated.c | 19 ++++++-------------
>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
>> index b82a31501934..0aabfc514b7b 100644
>> --- a/hw/usb/u2f-emulated.c
>> +++ b/hw/usb/u2f-emulated.c
>> @@ -90,8 +90,7 @@ struct U2FEmulatedState {
>>      QemuMutex pending_out_mutex;
>>  
>>      /* Emulation thread and sync */
>> -    QemuCond key_cond;
>> -    QemuMutex key_mutex;
>> +    QemuSemaphore key_sem;
>>      QemuThread key_thread;
>>      bool stop_thread;
>>      EventNotifier notifier;
>> @@ -148,9 +147,7 @@ static void u2f_emulated_recv_from_guest(U2FKeyState *base,
>>      u2f_pending_out_add(key, packet);
>>      qemu_mutex_unlock(&key->pending_out_mutex);
>>  
>> -    qemu_mutex_lock(&key->key_mutex);
>> -    qemu_cond_signal(&key->key_cond);
>> -    qemu_mutex_unlock(&key->key_mutex);
>> +    qemu_sem_post(&key->key_sem);
>>  }
>>  
>>  static void *u2f_emulated_thread(void* arg)
>> @@ -162,9 +159,7 @@ static void *u2f_emulated_thread(void* arg)
>>  
>>      while (true) {
>>          /* Wait signal */
>> -        qemu_mutex_lock(&key->key_mutex);
>> -        qemu_cond_wait(&key->key_cond, &key->key_mutex);
>> -        qemu_mutex_unlock(&key->key_mutex);
>> +        qemu_sem_wait(&key->key_sem);
>>  
>>          /* Exit thread check */
>>          if (key->stop_thread) {
>> @@ -331,10 +326,9 @@ static void u2f_emulated_realize(U2FKeyState *base, Error **errp)
>>      event_notifier_set_handler(&key->notifier, u2f_emulated_event_handler);
>>  
>>      /* Synchronization */
>> -    qemu_cond_init(&key->key_cond);
>> +    qemu_sem_init(&key->key_sem, 0);
>>      qemu_mutex_init(&key->vdev_mutex);
>>      qemu_mutex_init(&key->pending_out_mutex);
>> -    qemu_mutex_init(&key->key_mutex);
>>      u2f_emulated_reset(key);
>>  
>>      /* Thread */
>> @@ -349,7 +343,7 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
>>  
>>      /* Thread */
>>      key->stop_thread = true;
>> -    qemu_cond_signal(&key->key_cond);
>> +    qemu_sem_post(&key->key_sem);
>>      qemu_thread_join(&key->key_thread);
>>  
>>      /* Notifier */
>> @@ -357,9 +351,8 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
>>      event_notifier_cleanup(&key->notifier);
>>  
>>      /* Synchronization */
>> -    qemu_cond_destroy(&key->key_cond);
>> +    qemu_sem_destroy(&key->key_sem);
>>      qemu_mutex_destroy(&key->vdev_mutex);
>> -    qemu_mutex_destroy(&key->key_mutex);
>>      qemu_mutex_destroy(&key->pending_out_mutex);
>>  
>>      /* Vdev */
> 
> A difference between the two patterns is that a semaphore has an
> associated counter. If you miss any underlying condition signal,
> qemu_sem_wait will wait forever.
> 
> The previous version was not impacted, has any cond_signal can wake up
> the emulated_thread no matter if you miss a previous signal.
> 
> In current code, do we have a guarantee we can't miss a cond_signal
> while treating a previous receive?
>

I misread qemu_sem_wait implementation, we wait only if counter is 0.
So the patch actually fixes the existing issue of missing a signal
before waiting.

Thus, it's correct.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

