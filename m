Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3635EEA870
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgcy-0001Wo-Ud; Thu, 12 Feb 2026 19:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vqgcx-0001Wd-DL
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vqgcv-0008Aa-3m
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770940899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyxfQwQo34PfUJtKLKu1rbKEh66N9E1v9mhKHW719Wg=;
 b=Ewxlt4TU1O/7iUWEesM01ke4B8/TaSXNa8rwWkmDBI/L6Ngy3zvkzkQ2kUNPD88WYpIkGt
 aSyoEC/UqTvphdpfBdD643FAUHFfbH+zhOv0ZekrfIunIcgilhSdX0BKKUhSgZGToUmgB7
 vD3iiVZEfjoqd5WNVo5TS0YJp4JF9d8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-hDLC6DpUOxm8bfZiz7mCYQ-1; Thu, 12 Feb 2026 19:01:38 -0500
X-MC-Unique: hDLC6DpUOxm8bfZiz7mCYQ-1
X-Mimecast-MFC-AGG-ID: hDLC6DpUOxm8bfZiz7mCYQ_1770940897
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee3dd7fc8so2549755e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770940897; x=1771545697; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gyxfQwQo34PfUJtKLKu1rbKEh66N9E1v9mhKHW719Wg=;
 b=s8p+iNHQDBx1qswsD8HWdeBLt3LT3oj6wL2UKiJjHvm4Pxbq80V6n+3gcUomnbJEtn
 oxodLEKLgid9W52aPii6Om7qYZk55vN7V1LHbLpFD6cjxnyjZlDMvNoBEPeRDWwSSuJk
 dO/8kYyRhzepnWeP5rtUPs4JhTzjqeSZiEbpsa3qwB0f6yhUiiaS1s1Yx4E/TPsLMhzP
 vhSCyFxXkQ42FJp+SnL3L/O1A1B4Ybjy+4jMM/Sp2W7ZRFWuEqaKMqLTdbRIhyv+Jgs/
 +O1eVOR+LhG5e/tqF2HsO1bghsBvoVnG1hsjB+UbAAUeC3rl9P2GEkJ19cPdTHwUQXve
 L81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770940897; x=1771545697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyxfQwQo34PfUJtKLKu1rbKEh66N9E1v9mhKHW719Wg=;
 b=vpHHivTyjN14gKYRgJi/v2N4iLPRbfdAeVsjLKDwE9OJQBEs/G9FZtSEgWvM17hFJ+
 YZdwBN9Pl+uts7SZVn46bR8fyfBJHfvPHTEDQ0YGHZhLMidsT9q9uuOMDN8kIgYnas/k
 +yZb+tdv3nOJ/3HWv1+kkAqTCA1mX7I9YrF7Ca1uJD3+5V5/8yjYqRFy7tFq3x9b3Plb
 bKyDrUNFVFW6eTC1Xyq0RUVABNiD+6i2ZzXTqlkeFoOuhiX1EyxsTCq1ImriJpzvCjje
 dtWkUM/wnqb3xrmHVlT1BxcrS3sMuR2d8sijMxm1ChbFyhRxwqs1i6Q/zdBiWY0MCS7B
 2bPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY4pFMMX6L0p2ssFeItTtsL+pgRoylHllfGakH/zJo0Em7MqTfMJ8mu/C8lUkxTmWlqLhtcK76B8kF@nongnu.org
X-Gm-Message-State: AOJu0Yz1RcXax8d9iyokdm7qJKRD27zD4A6NlwJeDgCl0c9uiU47vvkR
 o8ZkZtQIJyOdMFr8MO3UBrMZus6KbXus4vYQ/T6J6OAWW5FJf5sB4G0O+RVXhkL0P1tDHIjydl8
 0EvgULCM6AGbk49C8wLRfq4orJDGfWVLDaSZTXcNXSBnnX6nEBikDR5F1
X-Gm-Gg: AZuq6aKlwN9+nkjn3alCNwWwnSaEscJUX6/zQ0TFsEfXPWzmC5AjFVlvAwFZxOpwAf2
 fu0qvkzUE4vv2tbwtC2ipVxZMhoJBa4k3cnUEnVPkP926u86mYIUP03uNeh7tZLShqq8fba50rJ
 S6dJPmyQb/JAq4OEGHOSfITz2yRIOkXqc9Wu8Xb3R2TyGSg4TERp16GZ4uMw8p+nyxfU9cbCerk
 zWQZpoWjZieMIjM9pDHG02SVeANBDmOWldor2obivEjHa7dFgqH17xSzg4mHjXijIMnBEpARHHw
 0CpaZ6dvps3htSAe268IjtnT3IX6rrIq8zbtRaQdLyOE5hZA9siMsrfmhZxW7Iq+CnK+bGnEZvS
 cKBqLaYQAOrXGpaI7C7M+OtVsL1YCGV+QdFHEX2blT5vVwQ==
X-Received: by 2002:a05:600c:5391:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-48371040392mr13094465e9.28.1770940896704; 
 Thu, 12 Feb 2026 16:01:36 -0800 (PST)
X-Received: by 2002:a05:600c:5391:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-48371040392mr13094085e9.28.1770940896219; 
 Thu, 12 Feb 2026 16:01:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d834ebesm223715585e9.13.2026.02.12.16.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:01:35 -0800 (PST)
Date: Thu, 12 Feb 2026 19:01:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
Message-ID: <20260212190108-mutt-send-email-mst@kernel.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
 <20260212020117-mutt-send-email-mst@kernel.org>
 <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
 <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 12, 2026 at 03:57:04PM -0800, Joelle van Dyne wrote:
> > Joelle, are you aware of this problem with the version that got applied
> > to the qemu/staging tree? If yes, could you please send patch fixing it?
> Unfortunately, this means that the patch should not have been back
> ported. It is possible that the crash which this patch was addressing
> was introduced as a result of changes elsewhere. For example
> https://lore.kernel.org/all/20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp/
> changed some internal mechanics of finalize. I didn't raise any
> objection to the back port because it seemed like the original code
> where the object was its own parent was wrong but I guess it was
> working fine somehow. I think in the meantime the best course of
> action is to revert the patch in the stable branches.

wait a sec the crash is on stable? not master?


