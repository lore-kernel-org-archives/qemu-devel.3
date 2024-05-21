Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EEFC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 07:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9JhB-0002oJ-FJ; Tue, 21 May 2024 03:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9JhA-0002nt-3I
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9Jh4-0000Jo-Mj
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716275633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J2sS6ye/jedBdUUHdeiSoOFNPijH2iMnBKcXSWbArRU=;
 b=alnSRB+jgYrtlmRQVrhSZDWCHPohTncyvH+txpbkzYG7WxzttfKgddwHmqyYHyzaVXQihD
 xWbJOezD4aBlTCO16vcoJhhYxIIdon596zns9WqNBKe58sD2ZckAf9azhvLaFg5SJHUNUc
 Isda05rXCM4NpGhPretGVvVCm7sPHSE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-0r8MQPI4Owq0lNCbbHeTlw-1; Tue, 21 May 2024 03:13:50 -0400
X-MC-Unique: 0r8MQPI4Owq0lNCbbHeTlw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52395bc1813so5218088e87.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 00:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716275628; x=1716880428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2sS6ye/jedBdUUHdeiSoOFNPijH2iMnBKcXSWbArRU=;
 b=KppFRqu9fuIQ0DOUnEjPIhDNQu3R1cohawA/C6+YX6rEf3fxcK5piO1njqFsBAe/6X
 SzD2215mJikWz9gI6Gt/bmGnZFK/xPfItHVMfXblyTU48gpSYa720kHmmhRLlOzD5x0p
 sXWYDyuuLjtO1TVmRYcqL/0oTkjcrPUZxv5qBj1O3ueK6wE1Iimym5ZIdNtKuE1MuuQD
 ghsNQU4Ahc6A0dBrOBFqTGlRrhDIe0N1EWnZtMRr0+ZUnPiCPIT69kokeXCTbGMFfFAx
 ir5NPK3OOs2ywNlSnM+unB0TM3ZRTVuVC1kTSddITmI+aBc0wkLpopOE31dsVJGdkzu1
 9RxA==
X-Gm-Message-State: AOJu0YypkUC3JIiaFxPyAFf0scLJdKvtLBQZ+mr43vv0FvhDmZWKP9rp
 HuqZXCrqFPZ8HeAEFU0NvbDbaQkHNL2BGhw9kOx+2HRqrDhyS9e5TxBe0vMgFxKl5vwsFJJ3q2r
 QVOdcZk0LNepPjCCD4bLcGZt01T4gb3L+PMpUB5qcdTDY/VHWZAFv/5sNZmmJzjHrj/RwFL4qJP
 dka4ttIsUqYt8lWAGuXYFwVG71XhHB31rXvOI=
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id
 2adb3069b0e04-5220fb77429mr26806053e87.4.1716275628198; 
 Tue, 21 May 2024 00:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmI+igKMxD5RGVNA6LcEaNvyRjyshFHQYf92+w2zM9mDd4XoAoFU49lRBE/EnTSvCc2/E6PSP//XOj/CS+SY0=
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id
 2adb3069b0e04-5220fb77429mr26806026e87.4.1716275627673; Tue, 21 May 2024
 00:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240508175507.22270-1-shentey@gmail.com>
 <20240508175507.22270-7-shentey@gmail.com>
 <4A8C51D4-D809-474F-8E6C-DCCEDCBD3857@gmail.com>
In-Reply-To: <4A8C51D4-D809-474F-8E6C-DCCEDCBD3857@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 May 2024 09:13:37 +0200
Message-ID: <CABgObfbpNEmM53go0hqKn9sL+isZ950imER5pSg5Hjr1Oc=Xzw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002017300618f18f6f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000002017300618f18f6f
Content-Type: text/plain; charset="UTF-8"

Il mar 21 mag 2024, 09:10 Bernhard Beschow <shentey@gmail.com> ha scritto:

> This is the only patch in this series which hasn't got an R-b tag yet (the
> others are already in master) and I'm not aware of any open issues.
>

I will queue it then.

Paolo


> Best regards,
> Bernhard
>
>

--0000000000002017300618f18f6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 21 mag 2024, 09:10 Bernhard Beschow &lt;<a href=
=3D"mailto:shentey@gmail.com">shentey@gmail.com</a>&gt; ha scritto:</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
This is the only patch in this series which hasn&#39;t got an R-b tag yet (=
the others are already in master) and I&#39;m not aware of any open issues.=
<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I will queue it then.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pa=
olo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
Bernhard<br>
<br>
</blockquote></div></div></div>

--0000000000002017300618f18f6f--


