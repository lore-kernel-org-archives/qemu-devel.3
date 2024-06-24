Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4B4C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcMU-0007pb-Ru; Mon, 24 Jun 2024 01:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcM2-0007fb-AA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcLz-0004r7-Lq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70666aceb5bso1221045b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207294; x=1719812094;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CBtlUKvL7QA1JOLexsqKLMt0NTeLClAOuCY4s6N/l7M=;
 b=HIwgUKvH+H+U/J8pjjIOyxbekWF9VnshWV7FKDST+7X/5sN2EtpsMIcOuQiOkM5Fr1
 P/BSSgQbNeIJeFNW51B7x+acrEVUzuRTOD5KQC8pG9S6cgiwZUKUvl9kw3MmLsdF937y
 3qO1g8PicE3IIZmOD+YtD0g1YeNJk+b4NOF8xbfh6CQXqyEu7qf0GvcF+ZBknS7rr0+S
 Qm/sQAtm2s9okMLDnUKrhVcHt31IUR4Hlj96aw3fJWY9ODocb6fkYHqOlH4F3/L295to
 by+f9YQMF2iU5iUmr7VQ6kU9lc2W0Th9//VdihbAUJsVDW/36Cs6E+ugxFeLceGtXvCE
 jSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207294; x=1719812094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CBtlUKvL7QA1JOLexsqKLMt0NTeLClAOuCY4s6N/l7M=;
 b=IEiFX5aAlQlIKG3FFgLBCQh0L9N1j0Sk4/U6vrRlYupyweOD9uHHTeXm8ueUsuzcDA
 6AClzDAv+o+1N7QGuNkbeoukJYBNQPoPcdEc8H8NvYaEmGgk5HHV5jdC9YWddAHxsG97
 fwDMEnpFNa5ALe4Q7q1V4D+plwEVzb4szFlS89jh6JD0ZHTH1lwBEO2fu4xW9MJtBnIg
 I9N+bB8TAVBXDyc3waHtnUIC3drjbnW+b8AlvMsinV9QRca1Oj4ANvRU1DAHKeAtEvPv
 RLkVRyRSwS7U4AoRiAMeHXjahEykA/wJVC+ZcXbv8lO8vFE8siOMgjdgVKRAEfLEIcrL
 HMqg==
X-Gm-Message-State: AOJu0YwUU7gT1upOGSC9H558gSLCsFirK4s6bh3bEby3MKz1hNVZ8v6r
 YSZAv7dSNyeFz3pNApxJvxhh3riFuhq7oDG/cdyiWJffjJAisbziCNcAOqBp5C4=
X-Google-Smtp-Source: AGHT+IGrJgFmpkpBfY07CjZ+Z5LCOmCNI8+OD/YcwlMMQso7VEKa5HdjURwTvfLO8ZvnbRdBNz/HTQ==
X-Received: by 2002:a05:6a20:a895:b0:1b8:9f3b:65d9 with SMTP id
 adf61e73a8af0-1bcf80059b0mr3633520637.54.1719207293820; 
 Sun, 23 Jun 2024 22:34:53 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70651cd4ea3sm5441991b3a.99.2024.06.23.22.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:34:53 -0700 (PDT)
Message-ID: <f5a8c73c-a9c8-43b0-a353-fa1424b9281a@daynix.com>
Date: Mon, 24 Jun 2024 14:34:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/13] virtio-gpu: Use trace events for tracking
 number of in-flight fences
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/24 0:23, Dmitry Osipenko wrote:
> Replace printf's used for tracking of in-flight fence inc/dec events
> with tracing, for consistency with the rest of virtio-gpu code that
> uses tracing.
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

