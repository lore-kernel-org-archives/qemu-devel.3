Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE04C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eYI-0002kp-3t; Mon, 21 Sep 2026 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x8eXz-0002k6-Tj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:59:09 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x8eXw-0005LT-Ke
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:59:06 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso2564869a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789999143; x=1790603943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vw8h1SswmEoM6PEa7KACXCFjMPM52nHG2Og5QW19auI=;
 b=GCWD1TEGTYEEGw/jmwG+9q/CSmmIhx4GzdMmDrHw3M22ktFwedvvfiIOqXVknwk/SI
 cTeUgMDsIqsaOfF3yKSvHoXO693Snm2R1IfcJOSA/UUn98kSujOBSv5iQNHVoGIMoL2q
 3kaWI9rXKjwwH2hQGw3mM4Brz36mP2tZy32QVZLV/wDJI8A+PThh1FIQj2QFT1aFAjt2
 6AkGL0lshgSCUVT1LtpSIbvqPVKPQjOVLhe06BBNNMEmjMEkDUk/RSY20pQWdIZdjiUF
 sXF5APcGj7Sk13eI6/w4z2e15/A/ST7/NARI7z6gBJays/iLAEZBSJiqTf4wHXnxLmsd
 pEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789999143; x=1790603943;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vw8h1SswmEoM6PEa7KACXCFjMPM52nHG2Og5QW19auI=;
 b=uEU7zBJb6Trvhz0F6EZ+h6R1GNRa0O3pjPqRyAtO19cqYvC7tKHmTPTOoUTaTj43hk
 jR4O8WSyXTOgK47/ufjHA0PLlPyXvsFIwoW5xQpO/o7Crt8SUYc6DLKH67LLpa34jvsa
 k/njjWCHmY4XLfbu0ARV2zDBMCO0biGq4nf2uyC7WDU0ASeT/BAfWyoZwhmWlcO1U9q2
 +jwlbPM4KIb+EIWl1mmJxy9IGhGbEii41TdX96OhRVMFck7t5/lKR3vdXg0b4OqQ0m79
 sQ1pD+i6lOO1WE3dF5iEs5t9oYpDz2qi44YGt5ceWnDpjyXJ75+Q+trGvmGWb+oA12rG
 j/Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzunDY1B1pSseQyDV607LjkxlhDa0+YI+98oeFe8PyG1NtJud6syANrc4I86TWkcM7lzktl9v/E0f1z@nongnu.org
X-Gm-Message-State: AFuF++mKYqFNz6bJz2dpPsVlVBUk4tUpaWspU+4TFHqalTbzKnowUSmM
 Pbc3DjLA4wTJKUpqx41d6V0PIFWVk1EWFqIkPZD4PNE7ULAgt2ICtPcr
X-Gm-Gg: AYBFou2kmj7rM1NIbhna6NzIW0fBwmbc1XpSjvUXxHio6hKjcnYBc7bIW6hYNAl2R7j
 igN4Hmy32nhCmtTG35qiuViQEhm9qWAjvhpTOE5Ht5OB3z0Cv0HiDpJQDka4QEc+P6vAXaGm1rI
 K/UDYnj0yW83sy45QbmHPrYZyFXmR5eCQGeRJd1VPoNZiAOloBvkh2zXrH1ZjqSFzEPGtHPi4f2
 O+N8G4C1a4FZzoCpZvYEd55T1J6FG4jf0eJoNWkqq+OYpfQexdEqBoIw7XN+0I1esd/9yIt/7eY
 rG2mBwWhnl3bnhUczFcvJih3QCAxKfOrzuF7Tyon+ale61ytMIDT5bnTqGQ42kRLyHGqu+zmv49
 tcxNgaHniO3/y8i/5SiZ+j3eQ8mCoQGn13wlN4llqWQHlwFmiguSXldz9vwEnZWccoM1gKxqHYi
 cEbKLHufNlHUoyVNvMQMA7qLfLgFpNbS4JjvRDldRZtxyixanjiuUEcC7fI2pn9SXe68LPm9cJL
 71118+QGG2tM2rPhg==
X-Received: by 2002:a17:90b:5626:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39e54fb868bmr22562887a91.12.1789999142721; 
 Mon, 21 Sep 2026 06:59:02 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063b86538sm236422a91.9.2026.09.21.06.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:59:02 -0700 (PDT)
Message-ID: <44ff3276-0400-494a-bb82-2c69b0f21319@gmail.com>
Date: Mon, 21 Sep 2026 22:58:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ufs: Reset controller and MCQ state on HCE
 transition to 0
Content-Language: ko
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jinyoung Choi <j-young.choi@samsung.com>, Stanley Jhu <stanleyjhu@google.com>
References: <20260902081610.2290123-1-stanleyjhu@google.com>
 <21bbbab6-192b-4243-980e-4167b450c478@gmail.com>
 <18d61b20acd45382.3137322e31362e3131332e313435.ea6a.0000sendgmr@google.com>
 <20260917144122.GJ162769@fedora>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260917144122.GJ162769@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/17/2026 11:41 PM, Stefan Hajnoczi wrote:
> On Thu, Sep 17, 2026 at 12:22:09PM +0000, Stanley Jhu wrote:
>> On Thu, Sep 03, 2026 at 03:06:42PM +0900, Jeuk Kim wrote:
>>> Thank you for your contribution.
>>> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> Hi Jeuk, Stefan, and all,
>>
>> Gentle ping on this patch. It has held Reviewed-by from Jeuk for two
>> weeks:
>> https://lore.kernel.org/qemu-devel/20260902081610.2290123-1-stanleyjhu@google.com/
>>
>> Could this please be queued for the next UFS or block pull request?
> Jeuk: Are you planning to send a UFS pull request?
>
> Stefan


Hi Stefan

Yes, I've already sent a UFS pull request:
https://lore.kernel.org/qemu-devel/cover.1789689763.git.jeuk20.kim@samsung.com/

Thanks,
Jeuk


