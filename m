Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F6606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V3FLybKe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OrKc5l/g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPeL-0000w0-K8; Mon, 09 Nov 2026 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQPeK-0000va-MN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:43:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQPeI-0005gp-JN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:43:04 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF1D63460931
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 13:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BashHvQVKzrPU87i7rHaG3p0Uz/FNFZix/bqZkl6SXk=; b=V3FLybKefECZMnUE
 WKsjPM+nWxRWBXKoXgJCZhNmoMaQl2WFM6Gd93XrVL0n/tAMQ9qqlRuRnEiHW2vl
 G//6pPnM37q0z+4RZVUv7DaCp29pImE2b4hp0t7oVA13hrVrup2UTvnbN1ZZTgxX
 ENtqzOnFpgGZAEun+CMaIgD5VljlqxYr967tF5uvNHClCxFqAkrzmNZFBG3hIjyr
 Grqh+7TSmK3Cs6nGojtjAbrezPwWM5En6nAwwQvzE9vfKK3WnPukQipSAoI56IUU
 OQI3IlGpbumQEKQI3jWPy5sEJDB1tDBrzHF9CNTbHaMz4qirGpigiPt3E8Ig9mpZ
 gH6cAA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0rra0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 13:42:59 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-990ca9607c3so580842241.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794231779; x=1794836579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BashHvQVKzrPU87i7rHaG3p0Uz/FNFZix/bqZkl6SXk=;
 b=OrKc5l/goXIKEdxRxmK4H/Nimuhn2lw9MMJRMl3LW6V8a0QTvmM7dMVf8OgZRQkkfs
 E/4OOWFTS3ydAMyW1K0U5vxov+v9VM8zzaFmTxkt1faQ5iMFjnepIZgtGWue6QgTT0E4
 +HMpSgbmREoFItENuzRkyi+ycONSY4h1g6km+MjupENC7Yu9LjSXlMeR20f52KPZA/r/
 7GEXEDRlSeovL5FT/EZ7WakDdghjNzbrHlQPcjf6xxWWIwFsIKFoVf5jRLqAdCe9GbFX
 T6xSV+nBq1lp6BVmcoZb5XiZuyBEbdld/S6lFNNGjUVKQj8GRLGHLoq7QtaWy9i7mSVa
 ZkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794231779; x=1794836579;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BashHvQVKzrPU87i7rHaG3p0Uz/FNFZix/bqZkl6SXk=;
 b=HDpjJY+lSB+iukgVZQkhQcy+yScMs3ldToV5tFhWuskvlblXr+MJ1ejjy2PlFelfmj
 av/GRwx0r/aFK5GncF0GI1aGpSp6OtCYjY+vNzSb+F7xvB0fAmkrzFTOlrS0A70wWbCe
 n4Gx7eY+B2GTtli7V83Zvnan2PWMNWCmf+PBIHdOQfmOxlBLRaSCxSkCaK1ctCfJqXmy
 Gy+9mkxFiCWEulFai3S25N+DlSv8FqA5Nwj7NepM3zF7P6WiK4Klr/hTDo36MtEyRylm
 bGyQJGQrtaZVNchPf956xpfKEG23HhuGDqhDfSBDCeZsm04h1puMSsbaRizxtePz8Abs
 BjAg==
X-Forwarded-Encrypted: i=1;
 AL+hErGb4DYZiJjy8tLugm6FmKDxz5vbtz0/G1Jh1aDjIhaK7rklr8Ytm2GbgHPPwNFvUwn2J9zpkpkZOMvb@nongnu.org
X-Gm-Message-State: APuU4Z99FICMDyzq7nDBsBa3TQvSz726rseDbAWwuFZUiJ0BU8Tby/I2
 WVhei21lez+7eLVxv8akcxgDyqt0fKgfzeiubG7UFtvvN5SE1zBl/iMPDmuSMSdQpTILVCxc48K
 lm2he/tc13JHKzYgRQjnMjpS2X7ylgxO9sbwMX+Ejt8WkJl1eQ6Yt54d4zQ==
X-Gm-Gg: AYBFou2okTPSpGS8AS3IcyQu4h2EgW1XuSLhv7+0oMu6DgD4b9aKJ+TJF7Tf1uAP6aw
 OVQQKAq7urpOeDz55RQxJ7u8u6va/lJNiLpcvnAZXczK7rK1jHh7ff3j4WriZ8XZqUfngF9/jy+
 MeIGFMBAkBDrxijo/gQUUD6g3XTLVhc2Md1EVf7sW/CBIUt/ecVWJ1T2XL2gcIcxWvCOf2uYm/d
 uy0Ohhxxi+mCbYJxo6lJYotc2XrXB/XmvIkj+hmv2+eTn0p4t79jsRzF42iFg3ZLvdzMuyndKJ+
 vUNFPHrCA5yl9FR9YmCnzp9EKjd4EG/bI/928MK+4eLobZw9dJC0Plc6+nBD4QIGv94TO1jz2c/
 FofefwR7pOVxSQ1ja7Y/CT1j4s6TVrIs+bwsfay5hl72uKVr25dzC0KCJfZpnOR+dLEL2VNQnLi
 MJqWcK4g==
X-Received: by 2002:a05:6102:418a:b0:7d2:7827:c03 with SMTP id
 ada2fe7eead31-7d2db227350mr1085481137.25.1794231778774; 
 Mon, 09 Nov 2026 05:42:58 -0800 (PST)
X-Received: by 2002:a05:6102:418a:b0:7d2:7827:c03 with SMTP id
 ada2fe7eead31-7d2db227350mr1085470137.25.1794231778213; 
 Mon, 09 Nov 2026 05:42:58 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7da62edb4sm284345455e9.1.2026.11.09.05.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 05:42:57 -0800 (PST)
Message-ID: <4aa852f2-9bb4-4b37-bdaa-56de711d1754@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:42:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] runstate: do not force prelaunch on reset during save-vm
Content-Language: en-US
To: Erik Fastermann <e.fastermann@proxmox.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
References: <20260916101215.98436-1-e.fastermann@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260916101215.98436-1-e.fastermann@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L1M65_YTmmkt_QubqP2vk_wWb1gU1gvO
X-Authority-Analysis: v=2.4 cv=MpfHeGae c=1 sm=1 tr=0 ts=6af1cde3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Qm8iP6mkAAAA:8 a=CqBVmhJUZrEXpEXEO2UA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NCBTYWx0ZWRfXzisCnWncGzJS
 Lt9XAiHgcJWa9hPOxprm2MahY0UKpStwebNlnc5a1TGINY2NtoQNOnjMuFrlOYOceBZxj023KKi
 s1SXYOySN6tE0DN0hQzKfu7qrDvW8/YxpOpnDMqZw4QcFXdUYd1GVGM/HSBAmsHrrejn9gsx/ox
 9zPxPn43NN38rTV0OfWzJ3YMZkK44G0sz9aOg+QjrvlJ8y5COCGDxIhmPVorOtEeCE/TGvvtaty
 pIB7HBZlyn7vHRcNzgjC8Y0ZIZNqqa+Z1F6+KtT6H4DjpzOtZ0Zm4YvLCXMogdxTAeiDQyfU2Te
 mzcCZWhYvUPyvOXrZkDp6Yg70qUw+2In/jEf2bVH7s3nFs9pdTUPnCYjkwPZ4/zh6AXwCliuxL/
 4hY1JOMolCkqSkGiddTuFPGC121b0iulEbMPyNNZHxBxoGI1coITrEiCY9oyRtPg+mNpjS9UtmE
 wmEiOZmppbqd1Zf1k4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NCBTYWx0ZWRfX+V3JrJH9nNX1
 uxdlRxVU8wvBurCIkcgsO8bLaEsLqcPqaYX0hVUanXtuhKj9Bx7uFVrm6te9PXR6cXH+Xk4N3W5
 11kcqXYeqQUkyLXIstnxjypJg5MBD5Q=
X-Proofpoint-ORIG-GUID: L1M65_YTmmkt_QubqP2vk_wWb1gU1gvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090054
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Erik,

On 16/9/26 12:12, Erik Fastermann wrote:
> A reset processed while the VM sits in 'save-vm' aborts QEMU:
> 
>      invalid runstate transition: 'save-vm' -> 'prelaunch'
> 
> The window is reachable over QMP. dump-guest-memory with detach=true
> stops the VM with vm_stop(RUN_STATE_SAVE_VM) in dump_init() and then
> returns once dump_thread has been spawned, so the main loop keeps
> running with the VM in 'save-vm' for the whole duration of the dump.
> A system_reset in that window kills the guest, as
> main_loop_should_exit() forces the run state to 'prelaunch'.

Since this is in rebuild_guest() path, Cc'ing Ani in case the dump
thread could read an unmapped or stale block list on confidential
guest.

> 'save-vm' needs the same treatment as 'finish-migrate' in commit
> 1bd71dce4b ("runstate: ignore exit request in finish migrate state").
> The reset cannot be applied to a run state whose only exits are back to
> 'running' or 'suspended',

The reset is applied; only the runstate is kept at SAVE_VM.

> so leave it alone: dump_cleanup() ends it
> with vm_start() once the dump thread is done.

I haven't checked in which state are devices during a detached dump,
pre- or post-reset, do you happent to know? (could the reset be
deferred / rejected in that case?)

The abort fix is reasonable but could you add a qtest?

> Signed-off-by: Erik Fastermann <e.fastermann@proxmox.com>
> ---
>   system/runstate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/system/runstate.c b/system/runstate.c
> index d3e64d2b62..1d65a4d444 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -1075,7 +1075,8 @@ static bool main_loop_should_exit(int *status)
>            */
>           if (!runstate_check(RUN_STATE_RUNNING) &&
>                   !runstate_check(RUN_STATE_INMIGRATE) &&
> -                !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +                !runstate_check(RUN_STATE_FINISH_MIGRATE) &&
> +                !runstate_check(RUN_STATE_SAVE_VM)) {

Side note, it seems we reached the usefulness of runstate_check()
calls here; adding another local helper would help readability.

>               runstate_set(RUN_STATE_PRELAUNCH);
>           }
>       }


