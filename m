Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 01:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdKA9-0007MM-OG; Sun, 11 Aug 2024 21:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sdKA7-0007HQ-NN
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 21:47:55 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sdKA6-0003RC-76
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 21:47:55 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-44febbc323fso22515901cf.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1723427270; x=1724032070; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:from:user-agent
 :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=FOgH6pgz2fxZJYKX4Z2eZxcjmBPCUkK7yb9qccCT0r8=;
 b=bDjwvcV8UOiC9t5yApwqR9w9C0Mm+d4hKn8cXzFCJ8PbGnEDoihxNcKazuRDgFL3GU
 uiaLAyEyX23tjua0qBu4UmdAsM70vghTQKjRU5ALLm7/KzMGd/hN39+VbRgtZVBvIffw
 ZBtDQ/D4CTHwF67+bl5D3lW7nzjF3BH/IWuc8ulPuGQQZBlCgsRhZwIrY/UUWlLtfeSo
 i6NfTP/PTzcoHHh/HdUaA4jSyLmb//02Dv1ose7F5LPsZ8e9QRjGymdcT5UCgVI9OCvv
 dZkUKmWQtkQWexwRb6fAI5cTLqOdGuggVv5Wt1Qgq7ZcbZvFQG1XOUMx/ozU6N/psGGr
 hbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723427270; x=1724032070;
 h=cc:to:subject:message-id:date:mime-version:from:user-agent
 :references:in-reply-to:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOgH6pgz2fxZJYKX4Z2eZxcjmBPCUkK7yb9qccCT0r8=;
 b=uwtaF7gP2MEQ7mWI/EAfTT+icxg4m3mVcUnkmZSzsH2yw/nUfCc3XDW4zGwlKOknCR
 SPfo9m5sCIUEVJ305/RS8AiUcs6P717kOM3FSZ0sXF7LzTSs7fZFF/piIXwd2lBX6pMt
 Ht2GuphFCNoHrbtdegAXM77OsnZegOLpySovJRewd7wryIB3fmZ6W4AOFP4fE2j9YbtT
 w5PxsZJENg+FFDbpJ/ByZ/PqF0bGzVAUL6a8oDL7Xwt7hUF8jPCUgP7xv48CgoRKTGPX
 iO51e650nia2CVLiBJ/L7XK684jmVbuW8kxEJkDbmFd4UZyWzWjQZigD5sdz1x4rJo7T
 tjmA==
X-Gm-Message-State: AOJu0YzyRJ1gFXRTJqWjDegkmabAq2W1pE+OpHXlFTAeJeSTiWGAuSeA
 L0sK2VHgrhTKQ2zDL4x6LqU563oUxFypQc6KyxGSH2NybSiALc2mP/MJ7pndLtmCICoYjzOZfzr
 z1l6AsBtOYz739iM6GEO5Mtt957/0VjpsbBHiBQ==
X-Google-Smtp-Source: AGHT+IEdTI6SxL3FJvfngH9l2eILCskFt03DoOKYqECfseU2TdQWuf4stXwskJROzLuJMWIhnz4Y8BJmE8qvhZqN06o=
X-Received: by 2002:a05:622a:1dcc:b0:451:d4ba:5a3e with SMTP id
 d75a77b69052e-4531254a78dmr72583021cf.1.1723427270275; Sun, 11 Aug 2024
 18:47:50 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 11 Aug 2024 18:47:49 -0700
In-Reply-To: <87cymirinn.fsf@pond.sub.org>
References: <87cymirinn.fsf@pond.sub.org>
X-Original-From: zhenwei pi <pizhenwei@bytedance.com>
User-Agent: Mozilla Thunderbird
From: zhenwei pi <pizhenwei@bytedance.com>
Mime-Version: 1.0
Date: Sun, 11 Aug 2024 18:47:49 -0700
Message-ID: <CABoGon+MhGknWsTx20_2bSLGAz2o7Z80kLFV-7dmryDcJK4fJA@mail.gmail.com>
Subject: Re: The members of QCryptodevBackendServiceType are undocumented
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003dcb2d061f72ae62"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--0000000000003dcb2d061f72ae62
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Sorry for the lack of necessary description. I sent a patch, please
review it.

On 8/9/24 02:09, Markus Armbruster wrote:
> Hi Zhenwei Pi,
>
> You added the type in commit bc304a6442e (cryptodev: Introduce server
> type in QAPI). The doc comment describes none of the members. Can you
> supply me brief descriptions? I'm happy to do the actual patch.
>

-- 
zhenwei pi

--0000000000003dcb2d061f72ae62
Content-Type: text/html; charset="UTF-8"

<p>Hi Markus,
<br>
<br>Sorry for the lack of necessary description. I sent a patch, please
<br>review it.
<br>
<br>On 8/9/24 02:09, Markus Armbruster wrote:
<br>&gt; Hi Zhenwei Pi,
<br>&gt; 
<br>&gt; You added the type in commit bc304a6442e (cryptodev: Introduce server
<br>&gt; type in QAPI).  The doc comment describes none of the members.  Can you
<br>&gt; supply me brief descriptions?  I&#39;m happy to do the actual patch.
<br>&gt; 
<br>
<br>-- 
<br>zhenwei pi</p>

--0000000000003dcb2d061f72ae62--

