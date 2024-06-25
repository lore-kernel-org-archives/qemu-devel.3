Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A06C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM67X-0000Cd-1r; Tue, 25 Jun 2024 09:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rajurastogijkt@gmail.com>)
 id 1sM5IG-0007SW-Bi
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:29:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rajurastogijkt@gmail.com>)
 id 1sM5IE-0000HA-MW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:29:04 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7178727da84so2576107a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719318540; x=1719923340; darn=nongnu.org;
 h=content-language:mime-version:user-agent:date:message-id:subject:to
 :from:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=WCdoKFbLeIS0j7UjsChNNgOrZixtul9Bpu9Zm2TdKt4=;
 b=bx/jPdJd4RmxWAYIySa1JYxpINg/R7PNmwE6GBdGXhiK17S+nhvTQxiOgPPYWhUVyf
 pa1HQIL8ASgY7F7ao3Dv+ow5B6g99AnPlYHCwZHUnsEAjWXKTtsHwRfTWw+GOWU5cwcI
 nUJOnGH+PyER3ZG0L50blMZoH3wZjXNOvfVHBFhsGxSIx5qThFQ5nKdr0BSuSV5hnRIO
 0GaM7tg1y2aKrFVskja38/8HBsXfbsyj7gakpANm823hlB4UmTI1BkMyTWjQoqgwos39
 DAWL7GiVEO+X1C2we5ff9+JVQnnfUfsNGu4aXaecWi3IBcI9dAGWDQNlXuy5AiIJxtdy
 nOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719318540; x=1719923340;
 h=content-language:mime-version:user-agent:date:message-id:subject:to
 :from:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WCdoKFbLeIS0j7UjsChNNgOrZixtul9Bpu9Zm2TdKt4=;
 b=I/1vssuNN+9W7FlAn8rNRrit1RsFdSbWpAe50Shma1iWreKqbkgVfs/PUDJP9HfP0I
 l+dX5ugza/DH3xqD5V+OBm0wht0BvKeBM15Gn6kNauyUlj0Rg6oY/2oeGwEdM6p4jLax
 yYEabu5G1NQmyrg7+OwWR9I83GshEr08Rz0WnbsnqHrwSJNmEqIDe7bYfY2jp/Rks5SB
 bEKu5rCOl/lKMpPYR9mwh7/6u/h/fo6nFnxBJ2y5uQQ51TSNIm3H9NRt7wDLdnF1j7xq
 +4d4Lr+cr6ehaLkPyUtjrocpXlyQYhk8mJb2WKHa2L8+ezLeiWIMvSDybvbadCD4W9zm
 fZbg==
X-Gm-Message-State: AOJu0YwuCV1UU9ixB9X/2krpjPxvtz/YhHDP4UlOdAmFxXvLNzDL/q1s
 uVxvnw7jnsijWvI2T3gYcOhmCJ/FPfXZdPgWvAapxPWM0jiIdDKEHUHCww==
X-Google-Smtp-Source: AGHT+IFTiis0WJZUcLJsxSSyxxG3KGdMDEVRE0+KeqieDXJ0UjkaSqfS3YSeWCWOut5Xk0FlviFfqQ==
X-Received: by 2002:a05:6a20:1896:b0:1b5:e80d:2fe0 with SMTP id
 adf61e73a8af0-1bcee6ebd00mr6572877637.19.1719318540112; 
 Tue, 25 Jun 2024 05:29:00 -0700 (PDT)
Received: from [192.168.1.103] ([103.15.252.203])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706953ca94dsm1636644b3a.199.2024.06.25.05.28.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 05:28:59 -0700 (PDT)
From: Raju Rastogi <rajurastogijkt@gmail.com>
To: qemu-devel@nongnu.org
Subject: [FOLLOW UP] RE: Meeting request- Artificial Intelligence and Machine
 Learning
Message-ID: <1b4381ac-f27e-880b-80da-99323d3496ab@gmail.com>
Date: Tue, 25 Jun 2024 17:58:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------A5C9D1E43ADA4385080A19C6"
Content-Language: en-GB
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=rajurastogijkt@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLYTO=1, FREEMAIL_REPLYTO_END_DIGIT=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 09:22:01 -0400
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
Reply-To: ideasb39@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------A5C9D1E43ADA4385080A19C6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Following up on my last email.

Can we schedule a quick call so we can discuss this further?

Please suggest a day and time to connect and also share the best phone 
number to reach you.

Thank you
Raju Rastogi

On Friday 19 April 2024 5:43 PM, Raju Rastogi wrote:

Hi,

Stay ahead in today's fast-paced business world with our cutting-edge 
AI/ML services!

We're here to help your business make data-driven decisions and gain a 
competitive edge using the power of artificial intelligence and machine
learning.

Let's schedule a quick call to explore how we can integrate these 
technologies into your business.

Regards,
Raju Rastogi


--------------A5C9D1E43ADA4385080A19C6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-text-html" lang="x-western">Hi,<br>
      <div style="font-size: 11pt;"> <br>
        Following up on my last email.<br>
        <br>
        Can we schedule a quick call so we can discuss this further?<br>
        <br>
        Please suggest a day and time to connect and also share the best
        phone number to reach you.<br>
        <br>
        Thank you<br>
        Raju Rastogi<br>
        <br>
        On Friday 19 April 2024 5:43 PM, Raju Rastogi wrote:<br>
        <br>
        Hi,<br>
        <br>
        Stay ahead in today's fast-paced business world with our
        cutting-edge AI/ML services!<br>
        <br>
        We're here to help your business make data-driven decisions and
        gain a competitive edge using the power of artificial
        intelligence and machine<br>
        learning.<br>
        <br>
        Let's schedule a quick call to explore how we can integrate
        these technologies into your business.<br>
        <br>
        Regards,<br>
        Raju Rastogi<br>
        <br>
      </div>
    </div>
  </body>
</html>

--------------A5C9D1E43ADA4385080A19C6--

