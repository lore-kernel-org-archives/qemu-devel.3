Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99764C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wb1-00019F-VL; Mon, 13 May 2024 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wb1-00018o-5z
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:24:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Way-0001Bl-Kw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:24:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42016c8daa7so6384815e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715610242; x=1716215042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H8gMrWF430J36N9AnIKeDwdDy+iJAsYK2gLkVjhskPY=;
 b=nsgnqS58kSqM5pudr9G9ckmi0mEqLlZ6pdFc5J+t9ttgqUgSwe/Km9efO7LsyGtokI
 hKxQ4i5VlArtKR9FQ9RG+jkFVRbRUCEdQKSYdk1reXx/SVS+TfBTkizjWk0y0Hi5e/zz
 BeJS3WvSHekcTrf+5AenRH/RbPyieQVstUYLmBU4mS5tJVsiHJ6kH9gih+SsOwKzH+os
 dECBJljdeUX4VRDn0fgPruAprXl4zw6JSOg2a0KoNGz1VEKW5uev0XV+NFrA2pRksPY0
 B0B58sc7vd04Z7OlBG1Q06xaGva3uZ2HQQejxIIpW9P6kHIAFgRqNKduD+ylhoCv7KKD
 t0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610242; x=1716215042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8gMrWF430J36N9AnIKeDwdDy+iJAsYK2gLkVjhskPY=;
 b=BBRqmIG/fyctee9XhuxrzubJOxuIvyrj0Ag4WdjUel94WE1mJc+/G2jfnSAt40bmzO
 RSdy/4cJXOIbhgPg1912EmdPB9PYY0cJ0Uaw3My04d81nd7MNFr0Vvpc+3JhPxsj1CzH
 +2BB5M2KYGVDsAO7vZOs0LtGkGnjCv/ymqdBKG5wOESx3rF+7OSSxVoufWMkWSfsr3Xl
 2ucsGFdNDs2RPYrX++c+JUwzwW3p7slUdpCGJ+b+aoWyqzeWveZPVlQDxIbRbyPLKcQg
 d9bwkTiDb1IQxpoDYmfRhiSak7Np+5k3gFD9PHTLDLpfJhBmmY/BNogBcj8Xc5f4nv8P
 G2IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwSpEd11igHFuMu/133F5AA4t1p48d9baq2q3s++3NeM5l7ZbJ6bhP7wFFAkUNDl8sF2R7MERSyPVD/Sxz1cBD4Uh6xxo=
X-Gm-Message-State: AOJu0Yyk3xeZa2VEMYk+qxcdbcBYXJoc+7a7qJGXaEoMfeyVln+XfG8L
 lUA7maHoHyzsSSjKY3nkvac9kJrDI5VycF8PO8U0z7ShX8MdNCuU54hgBd5L2KY=
X-Google-Smtp-Source: AGHT+IHzF7Kxs4uGWEAexa7BDlJCAgIAO8feJXxSzRoqdiKg84vpMgxAkbINIyf9XV5Ry2kfuYcH4g==
X-Received: by 2002:adf:e8cc:0:b0:34d:71a9:8837 with SMTP id
 ffacd0b85a97d-3504a954ebbmr7168360f8f.44.1715610242290; 
 Mon, 13 May 2024 07:24:02 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a77easm11209136f8f.53.2024.05.13.07.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:24:01 -0700 (PDT)
Message-ID: <4df52eea-4eac-4537-9167-fd2fdbe06872@linaro.org>
Date: Mon, 13 May 2024 16:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] migration: Rephrase message on failure to save / load
 Xen device state
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-6-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513141703.549874-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/5/24 16:17, Markus Armbruster wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
> 
> qmp_xen_save_devices_state() and qmp_xen_load_devices_state() violate
> this principle: they call qemu_save_device_state() and
> qemu_loadvm_state(), which call error_report_err().
> 
> I wish I could clean this up now, but migration's error reporting is
> too complicated (confused?) for me to mess with it.
> 
> Instead, I'm merely improving the error reported by
> qmp_xen_load_devices_state() and qmp_xen_load_devices_state() to the
> QMP core from
> 
>      An IO error has occurred
> 
> to
>      saving Xen device state failed
> 
> and
> 
>      loading Xen device state failed
> 
> respectively.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   migration/savevm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


