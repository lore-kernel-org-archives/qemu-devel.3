Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905AFCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlai-0003Tj-QB; Mon, 20 Oct 2025 04:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlaZ-0003O0-Er
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:50:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlaS-0002L5-Li
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:49:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so26384725e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760950190; x=1761554990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bztMGLMezk36UBUTHyqsP1OwBRLQheeJnZkkDDVgZhE=;
 b=NkLa3iE5dzPsICFYwW9wyIMVf4ZMsJ137eW5/Va7HOUqaQhu3zJZFDTxvGjR8dBnrC
 luHHiO1Q5ZodVhMhRKwRnzotj2jrwnuZo1bnTi9vFbdVh5iWx1aJFhhFp1BE044tOZZr
 B/8F42XMNVO2mregfhdC3aDH63MaehwaLach02uqX+iWa/saxMSoLZ+cEAD2Rz+Eb/Dl
 tbdtNF/Nz0yA66ldxfVHuWbQWGF2jRZg+FB9aDJ8kM9oxTl0XWrv3idspH0D3uO3QOTW
 H/7qmGePTXZTLqhA+Cu4GygNEMuI7IqFCrRYA7sSTF+yy8drEGuMrkLV5zAMt1MqZenA
 QY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760950190; x=1761554990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bztMGLMezk36UBUTHyqsP1OwBRLQheeJnZkkDDVgZhE=;
 b=S4qHf69OrnxKiLMniTHWncnLGW+NySAyo8GxNevJIPBKWj9JMcQgUl86441prruvP4
 OXLuA1adUmdPUBXRzZ2cwkZtv5UEH4zZaH9A8mhP6h6+3/PjKGwBlefxy6oto4kNKLll
 Ap0Efts3xniJnz4em4X7hnnpbXySqkL1ALYSBWi/zW5aQOM56IjYSHlqcIxL/3UJ7Yea
 cYL+yNoWBXMovA6sOFmBPv5ReFHmnCLz8ptJ/ysEK97fFWPjrgWd9Gi+cvHYolv/pWWo
 zuDwOe30qNeIgv7uloLmKmgxzg+kLY2134I/l7xRQHJ/O6ldRVJtVnGNCC/jGVZ1Edj1
 PCHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq0h6DT9LjE/dbfKsNO/ha+6v5CHYUdryEBsNVdcYjBG/2tug0mdp1SDAkmndLcqMsVtZZ/+JM9hsu@nongnu.org
X-Gm-Message-State: AOJu0YywwHA5+fa7Sj1yS0xfSJctfHREXkzLY+J51PrnYxLPygTfXMg9
 btJIhOVfDxBZ5VC9krRm6DNu34pbpHMpcBSohkKTrYFv9KOfcm9ubFV2IHYmupfei48=
X-Gm-Gg: ASbGncthfxfRegspqM0L0ywU0wEgVfxGsNZYi61/+bbljVkuqOD2wiELZFlqe1s2rjS
 7ABM1BhOEL7lULww9lBm3+y6hYQ48BAPL0t9un5LdRGMAl6sf4ykM1hFols14DxK9+Yoj38DUal
 z+D2SZ8L42mayuqWZbvnrmwE/SC6S/7g2j1HBITUeszR2L4wlx/RL7wuz1g8QZ5lJ1ihEHF28SI
 Kw6RWoKD3I6IkvwSHfv7vPteVjQmeNxzDy9+zrMU2kI8wx6y9aly4YUWHy3oE1pPkTtSe/1K/Go
 GPZafh5vFU2Xp9IK5m1HhRiqW31zcsweKltrWdGl1H8mHa15Gh8OEhqkLS3N3i/3rFEgf9+6dBB
 HowTQm1Gr4BJ5Tugv+CHSy3IRAgWRt6foaQFDMU7tu6oaB0wBXuP+FPKJu+QzfnSFl9a6Ebgjsr
 +0oGN7Kp9mqfWqJhObRzU1uBghBropNqh3FLskQM70TIvQ/rdjezMSNg==
X-Google-Smtp-Source: AGHT+IEfJDb9Y7pJcSlEjl4ajDGMZD5Glw67cv2lSC4LWTvVLryTV11Jha5dohoynmk0VRNM3wd+kg==
X-Received: by 2002:a05:600c:a4a:b0:471:145b:dd0d with SMTP id
 5b1f17b1804b1-4711790c334mr69539185e9.24.1760950190316; 
 Mon, 20 Oct 2025 01:49:50 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb49051sm107504575e9.1.2025.10.20.01.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:49:49 -0700 (PDT)
Message-ID: <33e964a1-a299-4b9e-8a7b-5ab20ca71d2d@linaro.org>
Date: Mon, 20 Oct 2025 10:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] hw/ppc/pegasos2: Introduce abstract superclass
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <0e63602b0381c20c4ef0ac1e741d5250b8b3b257.1760798392.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e63602b0381c20c4ef0ac1e741d5250b8b3b257.1760798392.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/10/25 17:11, BALATON Zoltan wrote:
> Rename machine state struct to PegasosMachineState as it will be used
> for pegasos1 too.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 66 ++++++++++++++++++++++++-----------------------
>   1 file changed, 34 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


