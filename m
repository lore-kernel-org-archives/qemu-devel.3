Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1ADC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MzP-0002Ih-IH; Fri, 10 May 2024 05:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5MzO-0002IY-Ju
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:56:30 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5MzM-0002qN-3m
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:56:30 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59a9d66a51so417986666b.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715334985; x=1715939785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ITb12DsiF3/JzU3Jwa96yJuW+DmCD7GbMqFA7wbu3Ck=;
 b=d2jRMsEeejTTqM7UVvFHNTQ9BYZNqPcloB5lThE+vYW7y6qgqOgD1EAQh2aKoNLpZQ
 FYxKnp5Dr2+8MSjIfgO0kEWPGIEnxO9iR6pW8Kb7i9Z06QurCM77NULLftcl4CTMkpTV
 jvG2vdpfHbXDX8JidxRp2QSPluEFMvfpgDiti3E85GIvdpan2aitOYl9Q4giJ40bX1H5
 PKM/rogxNuKwsPcZ7F12SOUSWkWgJLZgkp74N22yiLfjRM7RL3i6TOzqWZSk3rt1lVHs
 FeIKH5IXjRw7QKwPQbxQtB+rE7fQ26TQ294ZTLk7GgCSLyIdhrd4PA1g710si/AjkMLl
 pWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715334985; x=1715939785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ITb12DsiF3/JzU3Jwa96yJuW+DmCD7GbMqFA7wbu3Ck=;
 b=ODpfK0ytUQBYOF/NPFSVNf3P3QrBEihxtySIOQhXj9VIw1eN51/vf255rmEEIK/OWQ
 kw8MxmSJu/eFBibx6bOCr5uzRgr4UTlQz1MTxuhOD543AfP3h+CaCdvQSN7uT9zTBxUJ
 NU4nkhNlx9DBfZgF0NNuuFWqEl+zEVrxWAFobafHRYaD9JPHIorB4KaUYo1v1l49kF/T
 MIyJpg15qFRboJlRqBEzmxE3BsxTVoIebgm6Rnd9tZ/0+WDe2x3QC9S8sfQ49AVv66H6
 rhdWW8eEoZ0Pz2/Yc8tbVTDZHSrVwQeUb0mcC9r9S0+qhW1ZjSrPtIeSaTIj68HiBLSp
 BUaA==
X-Gm-Message-State: AOJu0YytLQylya4hR9FxMl4hGtkz+FqlodeyBDSHZ1Qtl1dbEnBxRZfL
 uNfD5cbnRXO938eI/iv+O+up+4pax5fSMrdglcizDr7WdKteZMtunw8AhEc0X/I=
X-Google-Smtp-Source: AGHT+IFYMRex5U8xZnOcw/Qe/KlzRIzDkQWDZmKXcAlq5eIf9pHuvu8jrD52myQnGafX3ctoHGctAQ==
X-Received: by 2002:a50:cd13:0:b0:572:51fb:5571 with SMTP id
 4fb4d7f45d1cf-5734d59d65cmr1319174a12.5.1715334985484; 
 Fri, 10 May 2024 02:56:25 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb6d5sm1643665a12.34.2024.05.10.02.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:56:25 -0700 (PDT)
Message-ID: <965e115e-15bb-4b30-8884-ba08d9ba5436@linaro.org>
Date: Fri, 10 May 2024 11:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] libvhost-user: enable it on any POSIX system
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-9-sgarzare@redhat.com>
 <74f4593a-eada-40cc-8371-0f53a62f39ad@linaro.org>
 <mxo4rug3bs4nnce3jdhcjpt2pzavpdh4m6wkxsydfel7p6e226@hcrtk37vnx3c>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <mxo4rug3bs4nnce3jdhcjpt2pzavpdh4m6wkxsydfel7p6e226@hcrtk37vnx3c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 10/5/24 10:56, Stefano Garzarella wrote:
> On Wed, May 08, 2024 at 12:36:30PM GMT, Philippe Mathieu-Daudé wrote:
>> On 8/5/24 09:44, Stefano Garzarella wrote:
>>> The vhost-user protocol is not really Linux-specific so let's enable
>>> libvhost-user for any POSIX system.


>> Alternatively add in subprojects/libvhost-user/include/osdep.h.
> 
> I like the idea, but we also have other things already present before
> this patch (e.g. G_GNUC_PRINTF, MIN, etc.) so do you think it's better
> to add 2 patches (move everything to osdep.h, add things from this
> patch), or after this series is merged, send a patch to introduce
> osdep.h?
> 
> I'm tempted for the last option just to prevent this series from
> becoming too big, but I don't have a strong opinion.

Whichever is simpler for your workflow works for me :)

Regards,

Phil.

