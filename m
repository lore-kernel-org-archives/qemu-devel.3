Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E9DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ay3-0005yL-4Y; Tue, 30 Sep 2025 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v3axx-0005xa-0y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:04:29 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v3axr-0005QE-1K
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:04:28 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b554bb615dcso4669250a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759241055; x=1759845855; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/rou46H96aHACzgtbm881R4dP4L4UsBowYdEdDp1KU=;
 b=MGZWV/gPYQ/OepZ269z2SG96SMjL/t9dF+NupYiXvtJIXtPXQKX2c6QiFRYGhlzg3d
 yih1SEynSEVNVjKa2F9Uwjy4WL7yOFwUlXs+xyIuBdwaymtCr4UYkohl3pDAdwb2BuwJ
 BmmnEAWGU9Y0x8VwQOKzYDrQHyTMJdFJwYhT/CUSH+Ndlt/HyYAOUBfV8J8mSnQGlR0S
 LFidAxEB3CVbEIuWnJxzIpo2jYPR3fIGVIXK2hQvULfZRjy60LcYqAZpcA9bPjqBcAmh
 LaI8tMHEdr3kxHIWZD4SzgUwBsrsv2bNbjeOVqkHEUVwwJX4+F9vYFLH3dL9iNGBuWzp
 e0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759241055; x=1759845855;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/rou46H96aHACzgtbm881R4dP4L4UsBowYdEdDp1KU=;
 b=lJEYedRtopUb1RNZcP2+OdVk/VRdiW0/o3ySwmid5fEOIuHKLL3M+fBvJEQzelXl0B
 xAlbCgcB2m8Sm8/AcJ5HGiWwL1hgOItQvx8GZYe5B7YEro0WgfCdufN/F0z5rLf7pWrI
 TfC7NujFiYk0YtlR7jkDi74MZq2lw1iushWppvFacSvvaXVZKSVJie7H8RBqRVs8apd3
 X3insviEqLhd/pWroYcCebSnXmnomt1cO2s98VnHJorN+iNuyq+Feu6LPb0s7rb86ALj
 qEog0EilkqcePMXL4ayPVcm7MxTZVSndDMHpbRvdEYsynPdukP+nDwcPCrY6dEB/zS0z
 ut+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuGTEOERffPJXZcP6P4gWgv+b0WZv10YK1Td/hq7A9rYRIILmvIHtZNODbDUgy9/UUtAaWJKerm1qi@nongnu.org
X-Gm-Message-State: AOJu0YxY8CS0aOC37SmPS/wwEccg/8yssHtKjxZC+VL5tR3FjGg7i26o
 c5NX5icSpg3T4RRCqkKd3u35lqHf2tSxoEa2nRVVc/aL22LOGpM03ZomRxyyuOQJ2t7odDeBfOy
 GwY7Hny1XGig6f3LbbxFKkRn/h7YAu6KuUnQK
X-Gm-Gg: ASbGncvydOihxjBcFUAU0TtKCc0dCpHJoi+EDtAqgC+lSFyF9S/9EWipn1ald0Ebb5R
 YJK+cn0RHPSTH7Nj+B313RZC0ntIbx6/HdGyCD7exDDQcMfgpV9sGKY1tJkuKPawKlyPENEM7MO
 9/mSbOWn5EQXydvVyKjfxClmft6PX4nANCoL412XRU0wxXSt99qYUgf+vGUpJtGR/6nIO4XWEOE
 XsP/i2zDYQL6O1As0LI879JzRPevYvfx+sVNHfwhQ==
X-Google-Smtp-Source: AGHT+IGYj8z19n6+l2+EpCMq/1kc+QQRza60lue3ajnUABirJYGJcOi4HBY5Hb3L40l2XF9vRm3fewh6389+6xuQgZE=
X-Received: by 2002:a17:902:f64d:b0:259:5284:f87b with SMTP id
 d9443c01a7336-27ed49d0965mr220965905ad.16.1759241055335; Tue, 30 Sep 2025
 07:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEDrbUb+MGXU6k7ZHL4ik-VK8hoS8KVQwmCe6cHNjHis-YySUg@mail.gmail.com>
 <82256b42-f625-4a42-ba8f-00b99bf84d2e@linaro.org>
In-Reply-To: <82256b42-f625-4a42-ba8f-00b99bf84d2e@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 30 Sep 2025 23:04:03 +0900
X-Gm-Features: AS18NWAvu7yIKnUvb6LSlQi3vTCZlnLEYLtBv18i8yaq7PMldgLPL2FOB6Yp-Cc
Message-ID: <CAEDrbUaAxkh5AX0G2pYn8xQBfLXxWQq1g19hmNFaA1AnROLi8Q@mail.gmail.com>
Subject: Re: Reqeust for a QEMU Wiki account
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002d7ac40640053a2a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002d7ac40640053a2a
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

Thank you for creating the account.

Regards,
Kohei

--0000000000002d7ac40640053a2a
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Hi Philippe,<br><br>Thank you for creating the account.<br><br>Regards,<br>Kohei</div></div>

--0000000000002d7ac40640053a2a--

