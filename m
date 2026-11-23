Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA3606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FBeRvveJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BFNHpZLr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVd48-00071U-M0; Mon, 23 Nov 2026 18:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVd43-0006zi-U7
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 18:03:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVd41-0007j3-Nd
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 18:03:11 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJu7RL3513820
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4lEo/90vzTUq7c12vbtFx9O3B4c6FkAXyppvF2xxPOo=; b=FBeRvveJNZRwTbXJ
 Xx8FnMRWRD7afWNihOQxhwwu4yTHoQDWkS1D+fhNLK3s9qA0l28p/BuwLKERh+FT
 7JBP1Jj/EgUMdagirKTEW9CWihs7Ocm7e4kaWAYFzgFD7LN0jDhDl4HxNauE3Rro
 8JpXMvxxVRI280EdMXnyUV7b/xdgvKA2C4MZ8sR58NxErdDmjT+oO7WwGCPNxPn/
 UYM798zSswurhMYfep4rZG5bgQzhvhOVNZaxf4Np46hQU0DB4qrIKxiHWT9HY15B
 wUt5FHjJikh8nN+6J2sAXtIQeepbUaK6OQED0SQqqYwy13w97ABVNoQOIxAFZs02
 95VqpA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukr8r3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:03:07 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b4f7d6b98eso57765077b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 15:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474987; x=1796079787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4lEo/90vzTUq7c12vbtFx9O3B4c6FkAXyppvF2xxPOo=;
 b=BFNHpZLrYy+Q2rd1P93SLU6IFpO1zx6EEuzEYtuVYuUUdDSvZwJuwiNj+Zf0tf/+P6
 Tx05V/goHmgHUzBiUL2FlQmMQoznmbmZjguzO9PhpsZcaVhTRYWGGlYcJaUMjfxzQIkh
 w7f/dZDVI3u40EM9MM1znwv5je0Jq9OoZGf0gTCm9FHAoUIJ25jSeMyba/qEe6YqJoQ3
 hHB42J9hXuJG500BnGLITAjbx9JLjEGwJFCy8+gPPi4wbZU6KGObcMXZIkJfqhq4rJ8r
 FafVDPXkaBG0WTrue1pBZSA9KLw7MSB5+gf2gcIgc9xBH2rfw7feMlKpzUvsR8cFNYTm
 P1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474987; x=1796079787;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4lEo/90vzTUq7c12vbtFx9O3B4c6FkAXyppvF2xxPOo=;
 b=w3URS0U5EXIpoN2hZ3sDU6mCPiw26m/lu/YCwc9MP13UJY3d6oKrSdwPdn8oLETKQj
 nEKJ0nqO+JJUxzP0+KJGn2u8uumzpj/1n2FqGmEhtXU+nxCFCUe0keb55aZZw7x9E7oT
 0PQ1B8flaFQIkjwm94du2e56pOo4SlPnYjqPHBiwunCLchITQzTfaONdDJHRtOkjLDFq
 2YVi6/ID0XptWALwToSLiE/Afig3h/t/f333InV8Y6IKekhwhBWEUARBop5H7TbvlXnv
 3ck6VOV1PW/ITwhOrjGkVc5K0zNpjsUPD3rwhfJqiypBaYHekRjsfX75Pg+g/NETbUhf
 7wPw==
X-Forwarded-Encrypted: i=1;
 AL+hErFVJgv92K26/mzJj17do3flxwZ7knatMJ0r/kQSz4OJ0Kjn93SCF9Ky3r8zpxP2ztDh7yApdTD9Ct/O@nongnu.org
X-Gm-Message-State: APuU4Z9t24EDURNs3PJb9MofnVE4GI5X+KcET1HJ4/v2tg/iLWM9trVF
 g/k4zS+RTnJTelhRkvGtV/xdIb35Nk+vl+QNT6ov9980102dWSz8KBvqCJNRX/3Zb21MeSchdiD
 68QOgeGgBGN1DxVPu8d0Emzmn4q53n0phcsOj3ulOkLIQkEINtaohljVwuw==
X-Gm-Gg: AZFdTZdOtmDR5yvk/Fp2pDd6JGKnjo6IuwVUSY0CpFHf5wPZPRe+TJP0cqIGPI33VDt
 yL/J4SD8Cmyqg76FlJCxRudTC5lfwbPYes+W7eXTe0YbmzWM870XC6Xag6To5wkLcsL5tfSTtil
 CRY0FZWf9qDvsVz8jaNN2+X9gnpO9G9a8CU6u5VwJD9fO9bL9XSuKqQ7aNjmZbfpQ1m2Wns4WXU
 XQIQzdWdYttfcpA6Y6SWAcg4ouEN0mU2UuWZ4v6/jmdkzoVX6SKXNcIHe4eKjgxSl+HEFGyQWwx
 azChqDNtpZpMYAr/7+Pm+Xt1NtFI9piT0CpB80Y/yDwOuKH3c5LQPh/H2KhW6RpvZdJsPCTdR/L
 gOuOg/trprl3gRfLw2IAmgze190VyGgePBOojAGGcgWgA6IRDngbb2m8Vc+UP6POl3Q6rrAp9PV
 Nt1Y16k3Q=
X-Received: by 2002:a05:690c:290:b0:895:8474:3c6f with SMTP id
 00721157ae682-8b5201eff64mr52017617b3.0.1795474986390; 
 Mon, 23 Nov 2026 15:03:06 -0800 (PST)
X-Received: by 2002:a05:690c:290:b0:895:8474:3c6f with SMTP id
 00721157ae682-8b5201eff64mr52017127b3.0.1795474985731; 
 Mon, 23 Nov 2026 15:03:05 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm24821488f8f.44.2026.11.23.15.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 15:03:04 -0800 (PST)
Message-ID: <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 00:03:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix abort when a rate-limited event races with
 its timer
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-stable@nongnu.org
References: <20261123212957.242482-1-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261123212957.242482-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfXxtCkBcvREFHp
 rmC3F/W/nwn8Ba0Vd14M1FGbwJ+rz5wRjUq/NEfSf/dUJr82VGxAwqhyL+6UdTpNfJ7sPcoGgwU
 KXrbtOaVNkh9nNG6yFcI6bKS8YNCBNk=
X-Proofpoint-ORIG-GUID: L_n5ph-HUb12O25p0bAMfP4VAi29SApk
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b04c62b cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=9Ea6QHORQOKNjpTeo7YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=Hx1yvPaMooE3kwe23bt7:22 a=1cNuO-ABBywtgFSQhe9S:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfXzkuHLVoFDyBr
 iskzuEVVUbAdKxbULCAIUnep6tLWUVvxgqBF4nJD6kW9v28Ibie54Fz86RnHeDJ2RMSFfsiTDjU
 GY5mYKHVGyV3eY6dFr0mWNdgETSAsVMd0qI+3RXqi60NNGTh2hibJKFNNU5Mji3zWAyxhKymVcK
 /cu5NBpvzxM9XPnAS7pPmsq2eRPVTrSiReLtu+CXcpNw7SGMSmJmhf5fuHmbQ/IFPAZQajDEPxU
 F2lOHJTKhBb3g3uf8oqgDbrgufskyw8hlmQ4qunPbCxJYIT4xRQfibOhVqPMAG58olqX5bE1HoZ
 B6LaaO05Sey69Lprrl0fJRCaCkgfA9rlWZvFDn2RXjgg0Jfd6XkFQP5ralTXl8wUR0hsYsgXpYb
 BcWztYwZuvZ1n0NKBdzdHEjdIOAcGMzGkHnpToqvAT7JXDqx6d+f/d8y3JaKaF3gCpJZCX565eC
 mlkFMKUjVAdbaGZkpBw==
X-Proofpoint-GUID: L_n5ph-HUb12O25p0bAMfP4VAi29SApk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
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

On 23/11/26 22:29, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Rate-limited events can be raised from iothreads, outside the BQL.
> QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
> rate limited too, and any disk on an iothread raises it.
> 
> The rate-limit timer runs in the main loop. timerlist_run_timers()
> takes it off the active list before it calls the handler, and only then
> does the handler take monitor_lock. An iothread raising the same event
> for the same device in between finds the rate-limit entry with a timer
> that is no longer pending, and QEMU aborts with:
> 
>    Assertion `!evstate || timer_pending(evstate->timer)' failed.
> 
> This hits virtio-blk on an iothread with an error policy other than
> stop when the storage goes away and every guest request fails.
> 
> The state is fine, the assert is wrong. Once the timer has fired, the
> handler is committed to run: it takes the lock as soon as the iothread
> drops it, sends the stored event and re-arms the timer, exactly as for
> an event stored while the timer was pending. The event goes out at the
> same moment it would have had the iothread come in after the handler.
> The entry is only created, re-armed and freed under monitor_lock, so it
> cannot go away under the iothread. Drop the assert.
> 
> Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a hash table")
> Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_ERROR reports")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: qemu-stable@nongnu.org
> ---
>   monitor/monitor.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 2654b81890..22c00b6195 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>           MonitorQAPIEventState key = { .event = event, .data = data };
>   
>           evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
> -        assert(!evstate || timer_pending(evstate->timer));
>   
>           if (evstate) {
>               /*
>                * Timer is pending for (at least) evconf->rate ns after
> -             * last send.  Store event for sending when timer fires,
> -             * replacing a prior stored event if any.
> +             * last send, or it has expired and its handler has not
> +             * taken monitor_lock yet. Either way the handler will
> +             * send what is stored here. Store event for sending
> +             * then, replacing a prior stored event if any.

How about:

   +             * last send, or its handler has not taken monitor_lock
   +             * yet (the timer may have fired, or not been armed yet).
   +             * Either way the handler will send what is stored here.
   +             * Store event for sending then, replacing a prior stored
   +             * event if any.

?

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>                */
>               qobject_unref(evstate->qdict);
>               evstate->qdict = qobject_ref(qdict);
> 
> base-commit: 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e


