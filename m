Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3364BD3177E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OKh-0004vZ-Kx; Tue, 05 Nov 2024 13:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8OKf-0004vP-SN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:31:13 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8OKe-0007AO-0U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:31:13 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso3907491a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730831470; x=1731436270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z/ttMqRr+tW7aGcvZvNWXGyZ7BvWGgTgnbmrsbKlDMs=;
 b=qPo4r4+PIvWOnB8tdiZJ+TyiTOrf9b5iEUJmDEAl/u1dzpZX3/735nOrmkvQiJQ1eJ
 wZgPJ+8CDfPyc+HGN2mOo0WblevLZwrPgE9MUoh3C24oobnm+uXm0iXqREBXD+ynV3ij
 ddPU4RDROmBUr8W7fH5H/GjlIXo+WDfscBue7g3DvyYg4ypcsKofIeT1C8e+ItqpnL+d
 /HwQwMd7NNkjtZA2TO8pjVbjFd75nCvIoGCUpNlQBuesN/iXWb2L/HngY0ns4hQ3IfBV
 Ua7kFdCOwrBBF9cuaJmsQx3THirLT817dvzM0Oe+jHuJnUxSUuYv558KvnWCJ9J9tdhC
 Ossg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730831470; x=1731436270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z/ttMqRr+tW7aGcvZvNWXGyZ7BvWGgTgnbmrsbKlDMs=;
 b=h59eoMHQWWn8o+yZLnPYdYxv0hn6xdsVnGy8+48uls8woPGph53cad2fxCj09aQbCg
 bEL+Bg4MSL502kj90i3hniHqVi+TOxw2GB26Zu2EZRImnp50bug7LEiw2/JaTtDABGrL
 cwDmTXX3IVaDMrqAZIez+4ZmBhZUlPKtsbv9FsoXo0dH1pt21AXXrNdIIYkTfWThhmCb
 7yDzOl6T/PNfIsbN5f8dQrQsf98PzBWhH39oCzBF7gImfl1WSr6qIw+1TaII48fnDX+g
 hmUyzdEkkUmmlmyxsrCkKUfH1m/UV+9c7ZNjQ0os8AZTCy5Ia/PqkVLtl47TxfciT/o2
 qQGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVmtutaG0tFmQ47ZIcP1lgAWBHt8Xm/5suqGqTv97JpOHoVtUe7lSi2nf9kMPG/idfwxNS+mIG1eDv@nongnu.org
X-Gm-Message-State: AOJu0YzdITlTpEOnQWukGhrwc3v/ZqR3x/Vj1Un69CFVTuSe0b3WWNFr
 cLf4/Wx/4Q/7SvWi6mrSW0ixLP5gELL3/fPmykij+bxQd0pxhc7EHOx6xLKCXgY=
X-Google-Smtp-Source: AGHT+IG5/4zll80yVaJ52kFVa2FcDK4JlbknnDtkzBuisO1HgVxFUYFiLG+wYR+WPWtDziqFTw7u+w==
X-Received: by 2002:a05:6a20:121a:b0:1db:a33e:2c6 with SMTP id
 adf61e73a8af0-1dba33e02f1mr17129042637.18.1730831470490; 
 Tue, 05 Nov 2024 10:31:10 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc206f05sm10255987b3a.90.2024.11.05.10.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 10:31:09 -0800 (PST)
Message-ID: <98c542f8-4dcb-4126-9433-9c29917f4ab9@linaro.org>
Date: Tue, 5 Nov 2024 10:31:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Check current_migration in
 migration_is_running()
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20241105182725.2393425-1-peterx@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241105182725.2393425-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 11/5/24 10:27, Peter Xu wrote:
> Report shows that commit 34a8892dec broke iotest 055:
> 
> https://lore.kernel.org/r/b8806360-a2b6-4608-83a3-db67e264c733@linaro.org
> 
> When replacing migration_is_idle() with "!migration_is_running()", it was
> overlooked that the idle helper also checks for current_migration being
> available first.
> 
> The check would be there if the whole series was applied, but since the
> last patches in the previous series rely on some other patches to land
> first, we need to recover the behavior of migration_is_idle() first before
> that whole set will be merged.
> 
> I left migration_is_active / migration_is_device alone, as I don't think
> it's possible for them to hit his case (current_migration not initialized).
> Also they're prone to removal soon from VFIO side.
> 
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 34a8892dec ("migration: Drop migration_is_idle()")
> Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/migration.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index aedf7f0751..8c5bd0a75c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1117,6 +1117,10 @@ bool migration_is_running(void)
>   {
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return false;
> +    }
> +
>       switch (s->state) {
>       case MIGRATION_STATUS_ACTIVE:
>       case MIGRATION_STATUS_POSTCOPY_ACTIVE:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

