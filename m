Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y0ceMrFI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IjPGiBgr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5au-0000J2-B7; Mon, 16 Nov 2026 17:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT5as-0000Hy-67
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:54:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT5ap-0007zE-QW
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:54:33 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLH07u2245591
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EZxZq5l/MPNzTIRitFM9cY/6L1aYjPKky4gO2+gtDK8=; b=Y0ceMrFIqSdkxGVp
 MTNNEIfJI8xc36Zg8RVJMrv0crbx/9yF+Tx/7G7aR+84BQXKKfIOfVOpSPADApDf
 Du8Q209lHq4pMp5VK0CWdvn8B9W3Rx1hV7N1vPvyxdHNT4HDyZjFz0a4CVVnX3Uv
 ed9x9T4RUloDFnBpSowgNPaQBAb1Ipyp3EeD2M5PfUZanQfT1XPloqS8qTBdHsvU
 7vAJzIi4vBo7dBAurmAq+gfIZE2E60iV6hMLhm6yF4Cfc5gsjCtSxudM483ArARk
 YZx6J88ESnafwJHWb7pmozNK/cjm2E9rhnjIhFW1I3aXm1bwJw6zxYpuZHKoWSLD
 VoXgKw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m089s3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:54:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5734953eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794869669; x=1795474469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EZxZq5l/MPNzTIRitFM9cY/6L1aYjPKky4gO2+gtDK8=;
 b=IjPGiBgrA0Jdo4FMIrrE7BoqLqEPcfIssTXdoKHwx6ZhKkmcTeK4DyYs9DZiU+7Un0
 cQrBDj3edxl+7M1JIJuj3g973zj7lym1UnrxIg6sG4Yn7mlYbJzfyEiWN+Ecm+t3DLw2
 WKtZTjdyEguAi6zBuwZdp8GiB5kRl+DBt6ldXAo30QdeXt0g91l70qvh6aFEnHskZoni
 jpSWV1LId+LBtDe6NJdBn5Z4u/CzAbgzsxIrzgZQfhd6iXUciud03So1Qd8W/w/OIEQU
 IScO4Cl4//O1tglzswxJI8BNYb4g/V9jexj4hPkpOQjEqN+izDciu0KoF+DhTpgX2WUx
 cp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794869669; x=1795474469;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZxZq5l/MPNzTIRitFM9cY/6L1aYjPKky4gO2+gtDK8=;
 b=uLAxDMFe8ePOamtlvTL/ZvgUI6aFKKqQEpEPxuU/RT4Grmoubq1o78wejiZy9hqq1h
 0LWzcpb3M24tDxTqTp2xYUtiNcpvT2uZ5ZRXMVtaFe1Cb+K9FCbvUtVfpxlR2zul5gCs
 xeIXu4oCFs4ukZ3TtJ5GiNqCXHfUfVKZQA1wvSy+xFgchvBcPSbm+/BoXANAq9b+F6Vi
 t2rsFbrHRitPUVJEzcTC815Z0ZiUWwrpPD3Xx8g+zM4FMUEM9krajr5w9MwzWnQJ1p1/
 mEfwRJx82NMR737MkPsxTdr7pDuiPQNejpGJWWKHt+JqPq9drNBrfSRZV4jLHsdoaR+o
 7BFg==
X-Forwarded-Encrypted: i=1;
 AL+hErEh+lOuGBpeSxNJvA1ORZKQSmtJ9Bp8jXQnJlQ6rygELiNe+sWTWSzVRBBSEoYufQifEtocciTIKsOU@nongnu.org
X-Gm-Message-State: APuU4Z+NXkqJpSCZ4AAbJn1WoBlsLYAQebphzDRSz/6jNMHZ0jV8EBfI
 Qc7IDKtEC/umJDAOpWEYWJhryOMNvqOB7PXBwsxmgHxVZ83Lp75Uxr7zXLeJJ6/ajg8JRi/n47I
 RQJ2wb/UQjB+AAA6lbW87JIW3XNTkl6DWOr+qWvRR+E5Tu795sb0P1Z2ZXw==
X-Gm-Gg: AYBFou3+D64zdLFhrp4J4OweTHHVkd2GnIhIo2iiDuSuLTiGP0mglZwGvTmYNIPmyW2
 eyqYBS/ZCXFFb1Y4hWwozr8sfAAD1i5QxE3UKFAkVdOh0IZq/OJxYtrzzKTO8Z8yDwsnLavkBmp
 l7V3vaBpuLw5+SAzlgq2N2KMtGJDje1rQ/6mt2lC+a8mY5fy1CAtOzbd3VLJVhp/EFj/TxSXn3L
 x/L7X/hUYYK27As9nqMJznDro0k88VNbG9jr84HB5df4TWEyefsWwSa8ap0NDrdU8j5BRyZzm9a
 H4o9Sy/c2UBrr9gKqgeNGgkjjHjTWbxexXXRLNwUTYIpLsNpIvdKlnNCwaw4oQeKVoI5f5knUdF
 AH79S0qYJli7cwU2sK71Xeoh9xPeO/v5UhqhTmL2eXo4Gjlh2WTlURTiUqqIKW5xEv/demuCMLX
 q+K9YVUk8xyjYOLzjdR9vmeyj0WGSHvO+fq3y6J5IBlxw=
X-Received: by 2002:a05:7301:f08:b0:376:aa76:6a15 with SMTP id
 5a478bee46e88-37967027f1dmr10779606eec.28.1794869669085; 
 Mon, 16 Nov 2026 14:54:29 -0800 (PST)
X-Received: by 2002:a05:7301:f08:b0:376:aa76:6a15 with SMTP id
 5a478bee46e88-37967027f1dmr10779585eec.28.1794869668504; 
 Mon, 16 Nov 2026 14:54:28 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563df84fsm73288732eec.20.2026.11.16.14.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:54:28 -0800 (PST)
Message-ID: <edeff463-31cb-4579-bbb0-8513140ee5d9@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 14:54:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/u2f-emulated: Use QemuSemaphore rather than
 QemuCond
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261116223625.24296-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261116223625.24296-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfX915JOVMzjNDP
 Yz58ZllDi+PwruZfBDzqZ4D4sQqlN2gwqdDTYWGwlzoeb58sEToUnWyuVJ3x89PBSVmKJ3sn+JQ
 T39OH5W+KlI6GcTallXXxEnBgbkfCak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MSBTYWx0ZWRfX6BOqrv46cwTe
 pze+CdN6W/FTtVq51jnvqAia5NR3l3sFREmlEEsbCgkb39TquEglMlS6s63QL90HqkpHHsKoR6Q
 NLpWjOW4YWTAKOGYyk4Eh5wJ1ZMHZRuhetuaEYw6xoxGickwENn8MW7l/VIQt6AN4KoY7JHsR6e
 rREFKJ7SjI0pDmKLHTbqJzkaTggAkxI7cc9sfnOWs6bAK7M2/BZ1QWcvZvOpulTCEfwZBXp2Ku5
 vJ8Cnaju4vuXPHcOfMByl3Id4hhsTdcBLJPxsKj9h3MySJKpeWj6f3cGU9ebiicgzmls/6Uubq7
 Av4Xaz4zHLyS08h2gpKpy/mAOFljeh5/A/54spUKdLjOch2GJBBynz6ra8K14/0Xy5EkuPt/FhL
 xIZ6asojqD+fepxtZgvJ+BdAj4BAaCfGfft4UC9BuT+VQRP6duQUdmYhg7Nm/RISX4wWMbwsR8U
 NoDyb3QCMvN+BQz/0MQ==
X-Proofpoint-GUID: _cC5Wx01SgBloFEPZTdkkeRa5018zR8E
X-Proofpoint-ORIG-GUID: _cC5Wx01SgBloFEPZTdkkeRa5018zR8E
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afb89a5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zH0KmYVa45M7S5-DxacA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160091
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

On 11/16/2026 2:36 PM, Philippe Mathieu-Daudé wrote:
> The emulation thread only waits to be signalled that a packet
> is pending, which a semaphore expresses directly. This also
> avoids the Coverity complaint that the condition variable is
> not used in the standard lock / while (!predicate) / cond_wait
> pattern. Same change as ccid-card-emulated in <GIT_SHA>.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> GIT_SHA -> 20261109203817.1683717-1-peter.maydell@linaro.org
> ---
>  hw/usb/u2f-emulated.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
> index b82a31501934..0aabfc514b7b 100644
> --- a/hw/usb/u2f-emulated.c
> +++ b/hw/usb/u2f-emulated.c
> @@ -90,8 +90,7 @@ struct U2FEmulatedState {
>      QemuMutex pending_out_mutex;
>  
>      /* Emulation thread and sync */
> -    QemuCond key_cond;
> -    QemuMutex key_mutex;
> +    QemuSemaphore key_sem;
>      QemuThread key_thread;
>      bool stop_thread;
>      EventNotifier notifier;
> @@ -148,9 +147,7 @@ static void u2f_emulated_recv_from_guest(U2FKeyState *base,
>      u2f_pending_out_add(key, packet);
>      qemu_mutex_unlock(&key->pending_out_mutex);
>  
> -    qemu_mutex_lock(&key->key_mutex);
> -    qemu_cond_signal(&key->key_cond);
> -    qemu_mutex_unlock(&key->key_mutex);
> +    qemu_sem_post(&key->key_sem);
>  }
>  
>  static void *u2f_emulated_thread(void* arg)
> @@ -162,9 +159,7 @@ static void *u2f_emulated_thread(void* arg)
>  
>      while (true) {
>          /* Wait signal */
> -        qemu_mutex_lock(&key->key_mutex);
> -        qemu_cond_wait(&key->key_cond, &key->key_mutex);
> -        qemu_mutex_unlock(&key->key_mutex);
> +        qemu_sem_wait(&key->key_sem);
>  
>          /* Exit thread check */
>          if (key->stop_thread) {
> @@ -331,10 +326,9 @@ static void u2f_emulated_realize(U2FKeyState *base, Error **errp)
>      event_notifier_set_handler(&key->notifier, u2f_emulated_event_handler);
>  
>      /* Synchronization */
> -    qemu_cond_init(&key->key_cond);
> +    qemu_sem_init(&key->key_sem, 0);
>      qemu_mutex_init(&key->vdev_mutex);
>      qemu_mutex_init(&key->pending_out_mutex);
> -    qemu_mutex_init(&key->key_mutex);
>      u2f_emulated_reset(key);
>  
>      /* Thread */
> @@ -349,7 +343,7 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
>  
>      /* Thread */
>      key->stop_thread = true;
> -    qemu_cond_signal(&key->key_cond);
> +    qemu_sem_post(&key->key_sem);
>      qemu_thread_join(&key->key_thread);
>  
>      /* Notifier */
> @@ -357,9 +351,8 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
>      event_notifier_cleanup(&key->notifier);
>  
>      /* Synchronization */
> -    qemu_cond_destroy(&key->key_cond);
> +    qemu_sem_destroy(&key->key_sem);
>      qemu_mutex_destroy(&key->vdev_mutex);
> -    qemu_mutex_destroy(&key->key_mutex);
>      qemu_mutex_destroy(&key->pending_out_mutex);
>  
>      /* Vdev */

A difference between the two patterns is that a semaphore has an
associated counter. If you miss any underlying condition signal,
qemu_sem_wait will wait forever.

The previous version was not impacted, has any cond_signal can wake up
the emulated_thread no matter if you miss a previous signal.

In current code, do we have a guarantee we can't miss a cond_signal
while treating a previous receive?

Regards,
Pierrick

