Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC6AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 23:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFiBV-0005bN-Cg; Thu, 15 May 2025 19:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiBS-0005Yn-Fb; Thu, 15 May 2025 19:40:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiBQ-000095-EJ; Thu, 15 May 2025 19:40:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so1554343b3a.0; 
 Thu, 15 May 2025 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747352410; x=1747957210; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QaRU+RgrAdsoCxi5Pb4PB+3AYgS92tueUAT4mUHPqY=;
 b=DrP8eolsb8zJfllVwEKc2TACq54hrp02yae2hnukXW+fu0OpPZsJKTPu8+oXm3M/Oq
 Z/buFeh3CcbaYx76YwVlrZ5wb+TbdQ92ThcufLS51W+OONeLI1b1Rnp3qL6RwplwKHYg
 plto64OVp5I5Mwp0hDmWRVAKh4hsSbNRk1XRWnzfeo0vaflxLvdkhcUQv42wPaMe14+r
 oCZnBNksio8YOaANFRW2wykfTMZ2KhJpDc0vEq1M4xm+/i0Sr6fGgUQDf3pAAZDZijwR
 nNYZGjHNJao7zospQscV6freEDKvm5JEz9dPgX1U2j28dylU2ePOjK8+RjyWCkm9CIeY
 4hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352410; x=1747957210;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6QaRU+RgrAdsoCxi5Pb4PB+3AYgS92tueUAT4mUHPqY=;
 b=cWuQPhUfuV7dVv0JYxtsh0d76C+nTdx3Q7ZD/sPGQ6lljF45OGt9pLjv2aUGwuza+p
 gZXHDQ2UyXGPRxnmmzXXoQ2q9hT0MXyis1JV+bUAAipep3uzj4+s8I/imhzvByTxMLAO
 H2reui9HtT4JXXXEtGFagd+D5n2aS2ujr8X1cmnzhundt5tcRP+YCqXwK1fo8FoAOAbW
 zzwiiauEjUlZKWYwbTZf82/u5473gk5dLNWURaNhvY9qrKoDSn0KuEUuPFdhMido8C1j
 etellQMxdUevmDox83X9HV2nSdkwLI4JvdYP2AvkP38CaOxcPVQ/Vi1EofGfEji2/KpC
 nBKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfXLieD95ZuPgrm6buef2JccqsmDAdWPk1OMByrr5YxJIj9i3r+swoHBQUlKUF2Ce6eEC53jmTrA==@nongnu.org
X-Gm-Message-State: AOJu0Yyfx3NAH10G6+geawY+YtIeLW7A669LmEUf+XRQftcGpd+oeMQJ
 c8NeY4iyLnFSJEKvsVuq+xE9UMAXvDlZ6Bkj/4voqsFOKyL5EeBmMXGj
X-Gm-Gg: ASbGncs0FIRppE/srVhP4GRqxbe7IHcJCJBvS0mm2toQD13Chn+INuiS8u+rZvG58CA
 Odz6WYbwk/IYZBu6t2XZ0oFpdeHsNMnh+rf7CBTcXj5HG7x5tF9/X5IdEMLb5o1EbHyLjzAmBav
 yCo0F9xI03up4yMS9xMsI88JZoq1FwtJt+YE0XXULXc73o/soOLQWQ4Jnxvos60WyWmkZZT2ULS
 JTrcPyxJQ7Km/RsOypEPrCWwoFs7mYMP4256Dqfky6HLK+0tgprkDCDCyFA3ENs6As6SE03hPup
 m0fV/0U+LK3wAVH26fTYHFV7HbUY/CkKobDS0CjLybw+jpw=
X-Google-Smtp-Source: AGHT+IFuaHqT5kPlh0SKm7UTfJyuJDT68SlCE8WkTukkaQj1zDpl8Px1nZrp3hAJm5e2RIZmN4lGng==
X-Received: by 2002:a05:6a21:3a89:b0:20a:4698:9d3 with SMTP id
 adf61e73a8af0-2170cafa323mr736540637.8.1747352410154; 
 Thu, 15 May 2025 16:40:10 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a0d0sm473374a12.14.2025.05.15.16.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 16:40:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 09:40:03 +1000
Message-Id: <D9X4QCJD77MZ.1Q31IX85570MJ@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Caleb
 Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 28/50] ppc/xive: Change presenter .match_nvt to match
 not present
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-29-npiggin@gmail.com>
 <66c54651-e743-4da7-ba78-e2fd41a11c1d@linux.ibm.com>
In-Reply-To: <66c54651-e743-4da7-ba78-e2fd41a11c1d@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 15, 2025 at 5:54 AM AEST, Mike Kowal wrote:
>
> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>> Have the match_nvt method only perform a TCTX match but don't present
>> the interrupt, the caller presents. This has no functional change, but
>> allows for more complicated presentation logic after matching.
>
>
> I always found the count meaning less since we do not support the XIVE=20
> Histogram...

Right, nothing gets done with it at the moment which is confusing.
We could remove it.

Histogram looks like a LRU type selection as opposed to this
round-robin we do?=20

Thanks,
Nick

