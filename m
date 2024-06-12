Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06D1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQHQ-0006sj-Ue; Wed, 12 Jun 2024 11:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQHO-0006sL-P5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:52:54 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQHN-0007gg-69
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:52:54 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57c83100cb4so4272961a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718207571; x=1718812371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OL+/kufviDZIBvCHNhr1KBxpOpxTxDzkys9AvSzKcX4=;
 b=IO1m62blPHHBWUorYrae9WJPgd6o34GxHMlHP8F6mPfgP9sWZttc6IWaZZvIcITSbZ
 ZJi6YO9P67501DGyigWmWaXFtDwnPw/XAQ/y4sf/Utekp37JtXnXlXXQZDQmdQFc39QI
 x17xxKGGba4FinfFteTbl7KfZDt2Gcn0OvycWhpnOEg2sldPmsCORY3Rry7Y0xLzyOz3
 bU+a4HUG/YdFMzODWtuA3bJ7k8+cRzYOb2rgMOFrKVaEeLFN0lo+V2T9TixMwUrbrN+N
 LyGDsL/EOwI6rag2AV04rlc3YWpKXNcTDNU/tn+Gdc1MnrdovPNPYOkKcXUwt3qjHM/s
 k/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718207571; x=1718812371;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OL+/kufviDZIBvCHNhr1KBxpOpxTxDzkys9AvSzKcX4=;
 b=iKC60JlBfsB4WxeO9K9oP8vUrC/ged6RvARV7aHzAe5t+AR04Q4ynVgypkSko/Awja
 MH7st/0BnDnl1Hw/1Co/iDWuRR9Q0O/ryFVIyKFRiMjxk9N9fEmCV4SfQSDuzFata3Q+
 MkKq9VjdXqsC8oQzzyPnbwasFwSL7GLZyCfECzR65oTj2F5pMkNtC6KWcHyL1QLIrZED
 vg4XlKlbU6cwEeTttAsEgYMp9EDGtApKvyqDG+L82l06GCmCuWPRRRKRE5j8R4ktiVv7
 jJAAzdkdSZNehNSygelbbMo0j8uuzJi1qHVIV9AWmRHLU+buubk24apLr3oTWHrV+TfW
 RQbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViwxOZwwHl/4nRfNnroWMCJI9uegmhgmDKwrSGkytMRTq7sTuiLHDDmPPHfs6AN/EA/zj1vKog76tQfX3ZV+H/Zvi2OYc=
X-Gm-Message-State: AOJu0YzruZDvUeW5CizFUw6PtITsN5LuQwnTmqrYf+G29utpSH1Ftf9g
 udmpWmWSIKtPiWXAOc05fJNTUM8bbUBhKY3UWJuMBoJ7prnOI+w9n3EprvoblUg=
X-Google-Smtp-Source: AGHT+IHWO4pgZUOZ7GPm1FF7WjQzXXbaSFjhUDW392TE4Ivp3KPrWmELZ5Um4k6qg9sx6gvc/XyUVw==
X-Received: by 2002:a17:906:5919:b0:a6f:1045:d5e2 with SMTP id
 a640c23a62f3a-a6f47d5284amr150964666b.4.1718207571462; 
 Wed, 12 Jun 2024 08:52:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f29bda0c7sm316534666b.41.2024.06.12.08.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:52:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 781115F893;
 Wed, 12 Jun 2024 16:52:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/4] usb/hub: mark as deprecated
In-Reply-To: <ZmHKotWS7ywfIvOj@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 6 Jun 2024 15:41:38 +0100")
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-3-kraxel@redhat.com>
 <ZmHKotWS7ywfIvOj@redhat.com>
Date: Wed, 12 Jun 2024 16:52:50 +0100
Message-ID: <87r0d2w431.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jun 06, 2024 at 04:30:08PM +0200, Gerd Hoffmann wrote:
>> The hub supports only USB 1.1.  When running out of usb ports it is in
>> almost all cases the much better choice to add another usb host adapter
>> (or increase the number of root ports when using xhci) instead of using
>> the usb hub.
>
> Is that actually a strong enough reason to delete this device though ?
> This reads like its merely something we don't expect to be commonly
> used, rather than something we would actively want to delete.

This does seem quite aggressive because there may be cases when users
explicitly want to use old devices. Maybe there is need for a third
state (better_alternatives?) so we can steer users away from old command
lines they may have picked up from the web to the modern alternative?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

