Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D72DC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 09:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQkmt-0007fT-1n; Mon, 08 Jul 2024 05:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQkmq-0007cD-Fo
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:35:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQkmn-0007SM-NB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:35:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426602e8050so10925395e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720431352; x=1721036152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CPpoGW6D+jpQfrlKuQZxSi2WludfwjjB75NCWT84/w4=;
 b=XfBJvGatoeWb9522t7foB41eN5cypt0VTxTC3Tic7BicMhgbjH7rYG+fiFUMkqDxzk
 +3R29cAFabiCbYhJX1h1jzAxYLT9k0VvULQDqdOiE9QHlRKHZ2ZljW5oZTxpHD3EJ8OH
 y4D07TSuX0WDMInSQBbtxkflZgwUyF5pVMxLvdfdJFq8mUOw4PNC1VOagOEcdXsttR01
 5iyItkqy4Z3wkg2UYdJg4zN2/WlcNmo0rNDgEB5Qzmkaevyu0CzXzku67OsP2gk2V1kV
 V49Y+yQC4vhfevJ/9w0psfnCUl9OJkDZqn6ezCR63rOQIXIfpoFRHcTT6QsU9UP54ydV
 K/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720431352; x=1721036152;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CPpoGW6D+jpQfrlKuQZxSi2WludfwjjB75NCWT84/w4=;
 b=UShbLjBtKWqlgnKaFgy3T4OZCklTjS6S+oucinpFXWJMiLqsEfYUPXWbtfCmOpOZVk
 Tjk9mDJbZW1fI/nvePHmkDUvkYr95itXOK+UhhWiCgqIJbVVODvxtdAI9Uz2kStx8bo4
 sV5orthomTfIP6grDbs3znoSxhI6VdnrovTdlB6SnaBAe9d038j3FKjJGo9oYZds/sX8
 h+MMAmQhv3ylQ20gJTt1501IaT+C13EpqSn775/FzSPn9iiboUfHEgenajium3f1eGLb
 0ZnQAtx/+0XolN7scJBbciPqZfquXB/kKEVic7nLPHKFJRWclQQLxfVYDywki8zFv7LK
 6HXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWliNDFYVK0++GNV5Qvic2PASu+VwB4217d9t3/iBnCT0cW8ZaR+bZDdgD62xL7nWv3kgcX8Zq7+ZDZBQU3Z4QUaay0K9A=
X-Gm-Message-State: AOJu0YymyKFPieZlS7k4ms7B4zuml5UPbKOJHRHeZXXtZsL++vMgA/Z4
 KBKiovSITIUDuZmlTby/4VO4DNf48U3fzRvrPXn8Jucl+iB4j46VjmQywQpcsoU=
X-Google-Smtp-Source: AGHT+IFF18KwOf+jrOgN8/moW3rT5HtTw0gSFeX0QBiDXADGOVX37ZGWiGD+9ZY9zpH/z+JbJ1xFQQ==
X-Received: by 2002:a05:600c:254:b0:426:5dde:627a with SMTP id
 5b1f17b1804b1-4265dde6512mr42121465e9.23.1720431352020; 
 Mon, 08 Jul 2024 02:35:52 -0700 (PDT)
Received: from meli-email.org (adsl-147.37.6.160.tellas.gr. [37.6.160.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4265e9de055sm86823245e9.34.2024.07.08.02.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 02:35:51 -0700 (PDT)
Date: Mon, 08 Jul 2024 12:29:43 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v1 1/1] virtio-snd: add max size bounds check in input cb
User-Agent: meli 0.8.6
References: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
 <86e04959-4d48-49fd-b065-a9288a7b064a@linaro.org>
In-Reply-To: <86e04959-4d48-49fd-b065-a9288a7b064a@linaro.org>
Message-ID: <gatbq.jld0hhud3s8l@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

Thanks for the review Philippe,

On Mon, 08 Jul 2024 11:28, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> +            max_size = iov_size(buffer->elem->in_sg, 
>>               buffer->elem->in_num);
>>               for (;;) {
>> +                if (buffer->size >= max_size) {
>> +                    return_rx_buffer(stream, buffer);
>
>return_rx_buffer() could be renamed
>flush_input_stream_to_buffer() for clarity.
>

return_rx_buffer() is vague but I think flush_input_stream_to_buffer() 
is more vague 🤔. I tried to use short names as much as possible and 
document the purpose in doc comments. Unfortunately the device's state 
machine is complex so the code complexity is necessary :/

Manos

