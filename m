Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BBEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rooT4-0004ge-3Z; Mon, 25 Mar 2024 13:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rooT2-0004gH-TC
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:50:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rooSz-0000Uj-7O
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:50:40 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4751063318so206095266b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711389035; x=1711993835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1uiuCJQg2So4tRBliZR+NbU2eE2QLya/9doEeFFxlg=;
 b=BNqFGvlwBxH+nJXto4B2lfn1Ph1c2Lx18j4E24bqNVKPM+CecYqMa9wC6ehTywdu3E
 /DocaP4xlrcxPyQtEaM4sEvUrMudVkC7UGN6rb+XmeZHc3fDaFLyLrwyk4XitCkVRrVw
 ywnq4TTB3rxu4PsM0SCZXyguZwiAIvYNX5KdzusFZc70MyXi0It57POQH6JPpmRzhcu5
 //E8pydW/IzHI/hVL2VJ51L7p7ta9W24sIyWMG7/v1opzU2lsgTQ37zXnf8t/8DVEKd6
 5pc5nsYQ6BxWxRmprTVfEFJ/zegwiSaT8Zhzns69eCQkbH7HUarnNCuP6QyDOhlmyyKw
 mJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711389035; x=1711993835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1uiuCJQg2So4tRBliZR+NbU2eE2QLya/9doEeFFxlg=;
 b=lbRB+m9kHb2QiPPZyTSIVzwYV4Oc35CLNfkgOtBiOeK9uqyf+DZCxVnCZV1BSMKE+K
 3tpfy/aVxlt90mc+BxRucjy2XBlsimPRX8MkC0/Sz0vq2QM79yWzZtug3tRPnnEB5nm/
 eZGlkW1odyqPVEehUKXiIkU/DWPm2TE/VWQo21tPBJpQGb6xb7bZR8VQe1kq/Sb7yFVD
 omk5wgiwRxGPxuM0XQydvdSxdnyis+LtC5MgocihZk3AdOG1dGJn6MPMUhEwy5nayw8S
 oH/9xcUpnPizUE5v5Gs9xWI6Jw5gdEKDhlaTVBeg4mw0yeHuVFTJ0k7tYVWxCQuDoVqd
 Su8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNQNYPAYXY0gxZM4ImDyz75NktnnbRcL9prOmGxn+w6W4RDb3A3tBymEZCfDeAglu04iwXI2nE7Cg6VRHHh2AwynubBc=
X-Gm-Message-State: AOJu0YwidQpQqD3Y3/r5TRczZRMkrNRrsR0UFTo2DA0hj/zLqHS9bxhQ
 dtQCOtFPX6oPBu3t1ZO1jFosKX8IHfu8G2NtSkv1wAathoCJ9x+W17tPsD68v4U=
X-Google-Smtp-Source: AGHT+IGb+2GxE/FNl1Cr2DkGYBXrpVQrXwkCMGOEJuP37Jjt4CuJMkQODISQkJPf+AP/OnyZpeGHew==
X-Received: by 2002:a17:906:308f:b0:a46:df38:6d4b with SMTP id
 15-20020a170906308f00b00a46df386d4bmr4396699ejv.66.1711389035159; 
 Mon, 25 Mar 2024 10:50:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 i27-20020a170906265b00b00a471481ef3csm3240098ejc.124.2024.03.25.10.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 10:50:34 -0700 (PDT)
Message-ID: <330d90fc-e5ff-4b7d-a01f-5587274a5f2a@linaro.org>
Date: Mon, 25 Mar 2024 18:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
Content-Language: en-US
To: aidan_leuck@selinc.com, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, berrange@redhat.com
References: <20240322174637.499113-1-aidan_leuck@selinc.com>
 <20240322174637.499113-3-aidan_leuck@selinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322174637.499113-3-aidan_leuck@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 22/3/24 18:46, aidan_leuck@selinc.com wrote:
> From: Aidan Leuck <aidan_leuck@selinc.com>
> 
> Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
> ---
>   qga/commands-windows-ssh.c | 791 +++++++++++++++++++++++++++++++++++++

Huge file, I'm skipping it.

>   qga/commands-windows-ssh.h |  26 ++
>   qga/meson.build            |   5 +-
>   qga/qapi-schema.json       |  17 +-
>   4 files changed, 828 insertions(+), 11 deletions(-)
>   create mode 100644 qga/commands-windows-ssh.c
>   create mode 100644 qga/commands-windows-ssh.h


> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 9554b566a7..a64a6d91cf 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1562,9 +1562,8 @@
>   { 'struct': 'GuestAuthorizedKeys',
>     'data': {
>         'keys': ['str']
> -  },
> -  'if': 'CONFIG_POSIX' }
> -

For Windows you have to check the CONFIG_WIN32 definition,
so you want:

   'if': { 'any': [ 'CONFIG_POSIX',
                    'CONFIG_WIN32' ] },

> +  }
> +}
>   
>   ##
>   # @guest-ssh-get-authorized-keys:
> @@ -1580,8 +1579,8 @@
>   ##
>   { 'command': 'guest-ssh-get-authorized-keys',
>     'data': { 'username': 'str' },
> -  'returns': 'GuestAuthorizedKeys',
> -  'if': 'CONFIG_POSIX' }
> +  'returns': 'GuestAuthorizedKeys'
> +}
>   
>   ##
>   # @guest-ssh-add-authorized-keys:
> @@ -1599,8 +1598,8 @@
>   # Since: 5.2
>   ##
>   { 'command': 'guest-ssh-add-authorized-keys',
> -  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
> -  'if': 'CONFIG_POSIX' }
> +  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' }
> +}
>   
>   ##
>   # @guest-ssh-remove-authorized-keys:
> @@ -1617,8 +1616,8 @@
>   # Since: 5.2
>   ##
>   { 'command': 'guest-ssh-remove-authorized-keys',
> -  'data': { 'username': 'str', 'keys': ['str'] },
> -  'if': 'CONFIG_POSIX' }
> +  'data': { 'username': 'str', 'keys': ['str'] }
> +}
>   
>   ##
>   # @GuestDiskStats:


