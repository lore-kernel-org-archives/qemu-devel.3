Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33496C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0l2-0002tp-HJ; Mon, 22 Jul 2024 17:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0kz-0002hU-IT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:39:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0kw-0003WI-HA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:39:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so34079725e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721684380; x=1722289180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dCrdl72LSWragEGP7BnhNbhzXcUtJIuMyH4LenVtq6M=;
 b=p80fEW/RskQD6OSZu3zxdg5neb5Q7x8/jU07+j++XORqxLLa8TF+7Q8qG7iV4kyrSD
 EDv2XZy5CbMVNtgjyovhzK/lI4hhKaZyMtmbzTL4myliozh4vUxgRSPYUnAVJYBwM0Wo
 NiNNNS+v/aN1WP4uBn5pteDg20zyNru2tdKe2dYoZ/eoV8yAAYzKqg9CC3nK5uu/HhFw
 GFJ+aQDoVRCtdJhlEFxQEVlEfI6HlODSwPKieV4KJHbVxnEYBm9SS15SLjWNyQMbTF3d
 Ye4rvE9kAsGT1PFA4zAjCHY/dJgjv5kZrGGHdKiOAwGciAayufTUjiEG2MfQnj4GSNI5
 1EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684380; x=1722289180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCrdl72LSWragEGP7BnhNbhzXcUtJIuMyH4LenVtq6M=;
 b=XgNehmrhiATDgbGM/mUtr1IpbD3vfCXiaa7KEbR+2sYNUE09ySHs5qgbSiaiZKcu4x
 67neGXYTO5IK7cK/IFM7GTvYwQBDhXZCjEd8vnmVtcaeSucN/PiKrq6WDylWvtDc/IX8
 tSWvsXJbyRaNJkNeIeoIxOxMobiZf6Mycsn0oy82RFrRfWhJr35qnFGed8LuWc0bzDZe
 hHOkjzkMpnzsSUteXKSdyGhfA/kGmLuOyS6Ulg/eS05P5tMZxLB3T83ABuWm0jsBUxh5
 ou/sfusnraXMkch3ScAwz0bVxBTYcuAL9vvIWRLIlJvvw6NL/Npuu2dXVO/b0ag2PlzH
 Z3lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ky92pGpqkUfml3ncrNWh6QqmjOAdV7XD4iSvKzG49jxswp2t+9+hCcJoqejQg6r+x2J8i2rFnq7zH4PSrmLsthJnQGQ=
X-Gm-Message-State: AOJu0YzyviJyduCDHwGs6TT6dyMJTAnQ0R9g/6HAqA0hLKHhXUSolsze
 51L704G9Y4NW01lVQ2sqiKxFHSUMLoyM46uKPuOz5kAL3D4a46xtA71HtEy3LSw=
X-Google-Smtp-Source: AGHT+IGZscwFiaLWDTmSVk3DoLeljMoIcJHacnJhALDGrK7Km5wjNpG23V838AjCJsSD7IMP35+m0Q==
X-Received: by 2002:adf:a3c4:0:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-369bae48d87mr5287913f8f.36.1721684380323; 
 Mon, 22 Jul 2024 14:39:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm144900665e9.10.2024.07.22.14.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:39:39 -0700 (PDT)
Message-ID: <8fcc1b96-3b8e-4d5e-9154-3abf9b6f730b@linaro.org>
Date: Mon, 22 Jul 2024 23:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] util/fifo8: Expose fifo8_pop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-7-philmd@linaro.org>
 <7e222b69-49e6-4d0c-9b44-45c42e18cfb2@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7e222b69-49e6-4d0c-9b44-45c42e18cfb2@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Mark,

On 22/7/24 23:26, Mark Cave-Ayland wrote:
> On 22/07/2024 17:07, Philippe Mathieu-Daudé wrote:
> 
>> Extract fifo8_pop_buf() from hw/scsi/esp.c and expose
>> it as part of the <qemu/fifo8.h> API. This function takes
>> care of non-contiguous (wrapped) FIFO buffer (which is an
>> implementation detail).
> 
> I wonder if it is also worth updating the comment for fifo8_pop_bufptr() 
> indicating that it returns a pointer to the internal buffer without 
> checking for overflow,

We document:

  * The function may return fewer bytes than requested when the data wraps
  * around in the ring buffer; in this case only a contiguous part of 
the data
  * is returned.

but I'll try to reword a bit.

> and that in general fifo8_pop_buf() is 
> recommended instead?

Yes, this was my first motivation but then I forgot to write it :)

BTW I now see fifo8_pop/peek_bufptr() as dangerous API and am thinking
of deprecating them (after release). AFAICT the difference is a pair of
memcpy(), when I expect to not be that important performance wise.

> Otherwise:
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!

BTW I'll respin this series including the fifo8_peek_buf() patch that
I forgot and is the one I need in PL011. Preview:

+uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+{
+    uint32_t tail_count, head_count = 0;
+
+    if (destlen == 0) {
+        return 0;
+    }
+
+    destlen = MIN(destlen, fifo->num);
+    tail_count = MIN(fifo->capacity - fifo->head, destlen);
+
+    if (dest) {
+        memcpy(dest, &fifo->data[fifo->head], tail_count);
+    }
+
+    /* Add FIFO wraparound if needed */
+    destlen -= tail_count;
+    head_count = MIN(destlen, fifo->head);
+    if (head_count && dest) {
+        memcpy(&dest[tail_count], &fifo->data[0], head_count);
+    }
+
+    return tail_count + head_count;
+}

---

