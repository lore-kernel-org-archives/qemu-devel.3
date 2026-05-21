Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E661CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Tr-00039T-8w; Thu, 21 May 2026 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ1Te-00035U-Fc
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:22:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ1Tc-0001bs-9c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:22:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso44616765e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779362526; x=1779967326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H24iN7RpW3SVwAyLiH7LM91eta0Z7q4hWqLl36mfpsY=;
 b=RDKo3egEg6yFrVJy4v2V3I3EgO7TQQVoqHisdGonrGTNySlbIy0TTULgDWq7mZwGLt
 nLy5Z0CKNtTWudVBClimQZrxxWcYDHlKJrKtNSGvWaItyx49wiZ7a/i5CxZy+QEN8KIa
 /U3Gkl1bvBIdpqjSVMyXV55DY95aCyaW8//0gBmtFp07u4d0qGiU7C5cj98z5wrSwEyV
 pV/XJ5py5mqeAos6tHi9YnC72PFr+t/yZ0Q/ESI4AfXa/pEzaHVxmM/T5a9RhWpy8oJt
 SAWNFugBXSWEpRtuUZIAGHUGajElXN7np5w8p7Yclud9VLWNq2ffgHOinRYGhx+x4z0r
 zK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362526; x=1779967326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H24iN7RpW3SVwAyLiH7LM91eta0Z7q4hWqLl36mfpsY=;
 b=FINvWbpzbZblL0dY05C0hY7lcSc2y7HjCm2mHmEx//uSErtN0T1pcAbhheuhWZAPwy
 6V8ucRHPgYV+L5nPoWkeMrwscSgZFBHLPz6198rj5gSaIYlEltszrDomYIDlgNHIBI+Z
 wjCEKuwWudrhJBasjAuXbeOVsJ0MzYlvbicw0gi9YctlKKl94zMI1qNTiky7EOumAW9G
 C8i8cVo7g2c0AxPQhu9nPCaJTAj2NOpjHN81DCXiGnnWtTS9af4Fx6SGk3v3OdvaBf/E
 mjL5jX8RAT9CWXpqJAFIEHRnrm583I8Q1SEjpSxPV0wVhc9SNeYQaEFqKcpMPRyCj2Zo
 +XMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bHIoztnH5v7A8578AQqy2uzuqtY3OiyFJzP0mSAOqf9+H2M/hZbIXhgRwL2mH7cL3NgZJWVIMKsEf@nongnu.org
X-Gm-Message-State: AOJu0YxqdajkASOJEgvFaE2T4ejqVpsl/ut3hlweDjudJqZjViomL8Av
 j+l9G2kwAsVpyHcBcRY/c4Zoi8sRzl8ly0TiGhED/uhkqd9YiZhlgelyg+aqr6OwGWs=
X-Gm-Gg: Acq92OE/7n7ekgxIsRBZvjTq8E01L3yWjy+O0PHevamn0YcfDdamnlVHgsGJKGfhq2P
 2vNBZOV+XMOReVKpFCIOvy/DX9F3k6m+gMImXix2m8cIihVb69L+WfAedWRy3et2AA/giaIW1xu
 XFi2NZdgOiYGKcgO5wwyQltRWsLnENeHgroWKGy2crKZuL3gQx3+EbqoMqwfbCYR/A0luktLWEp
 MhVNU+rk9FVUmIChnmWlI9H6yKEPBZD5APCfFQXuRYV8tOv+g9XVKzAmD5z9y0oyzGmjL1TWAlH
 5QXV6kW1MmQCQmOopyL4D0qDeIhkpnhqnfxGTgSuKCNfOITlVsEEq+0meH8GenTjLVP51XGcq0G
 JVgdrlqvUfCWcnRRtx5ovqztETIN/mbRIwq1E0TbpCj1g2jfSb0i0zal3czpcRKR/LLMPNgwKVO
 Gnu1RaMhVYPNcWW7YMGwsZHGg5y5erKIV7uMEcnurE9GNFBrMIG1nxgtc6276zKKe5eQ==
X-Received: by 2002:a05:600c:b95:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-49036067420mr31867065e9.11.1779362526496; 
 Thu, 21 May 2026 04:22:06 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035ea1bfdsm13766065e9.18.2026.05.21.04.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 04:22:05 -0700 (PDT)
Message-ID: <33b6d382-b48b-4212-bf3c-6f01b742cad0@linaro.org>
Date: Thu, 21 May 2026 13:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ui/vnc: fix OOB write in lossy rect worker code
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260521103353.1645561-1-berrange@redhat.com>
 <20260521103353.1645561-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521103353.1645561-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/5/26 12:33, Daniel P. Berrangé wrote:
> Incorrect calculation of the boundary condition when tracking lossy
> rectangles in the worker thread will result in an OOB write which
> can corrupt further worker state, and/or trigger any guard pages
> that may lie beyond the VncWorker struct. This can be triggered
> through careful choice of the display resolution in the guest
> OS by an unprivileged user.
> 
> Fixes: CVE-2026-48002
> Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ui/vnc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 56dd43d53f..ee567700a5 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2982,13 +2982,13 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
>   {
>       int i, j;
>   
> -    w = (x + w) / VNC_STAT_RECT;
> -    h = (y + h) / VNC_STAT_RECT;
> +    w = DIV_ROUND_UP((x + w), VNC_STAT_RECT);
> +    h = DIV_ROUND_UP((y + h), VNC_STAT_RECT);

        assert(h < VNC_STAT_ROWS);
        assert(w < VNC_STAT_COLS);

>       x /= VNC_STAT_RECT;
>       y /= VNC_STAT_RECT;
>   
> -    for (j = y; j <= h; j++) {
> -        for (i = x; i <= w; i++) {
> +    for (j = y; j < h; j++) {
> +        for (i = x; i < w; i++) {
>               worker->lossy_rect[j][i] = 1;
>           }
>       }


