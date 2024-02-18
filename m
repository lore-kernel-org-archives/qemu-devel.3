Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D918AC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 07:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbbSS-0002pz-2K; Sun, 18 Feb 2024 02:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbSO-0002oa-UB
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:19:25 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbSN-0002JU-Ak
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:19:24 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e2da00185dso2015400a34.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 23:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708240761; x=1708845561;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1lVnzMMkpIRhlqySheub8knNaPlPlRU5oAlDojkSjhE=;
 b=QJy9AbfA31a9W7Ff+RZ3+1SqyLwi6PMhiss+kNWZ1gCZBUPo8fQdI5yvVKlnit6Y0E
 48dwhzHYgkuLfQwqj1dvGZ2oEs6g0zkqfbUEgbB8asypwgMtH8ULu7Ck3OlT6w/XEosg
 Vg0coaqxT7U90iHkRw+Ea87IaviVFRCtt6QPRD7ThGQnSV7B00OpkHKGYynhAEOVQ2VP
 z+2hLkG6jz9XH5iUs9BpwMizwgflMchwYOCMRbKyahujPHMPrbiJT9gvkcFJxARUSxOn
 lnel4fnbHXlDqJTzQNzNTqnAe82fio6HYxoOP7W8l0UcijKJJuHzPTiv0hXlwuX0Z0Kg
 VWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708240761; x=1708845561;
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1lVnzMMkpIRhlqySheub8knNaPlPlRU5oAlDojkSjhE=;
 b=ZeUqymV2LfZXC0Stm3Qt/AbKPmBFyds3MK+9Bib2/ZWY3qaETo/8kE93OkI0MKmFDy
 xOpX+E8Us4eFkbzVYaAFR0PAVQ+T++/5+JkGy/WSDNsdUTFT7WgVCuiBUemORZPAE8Or
 ZoHskDm+dj9zipT1iBFegi/5IskHDMRRQpnp+UPSxWpRnTxny1d/pYurlJbFt1Wy7nE2
 ZPmsACGcy2zKnl1jheiYf46RNp9rwPsPq9Jq3IRwqWxoRI4kkX/FOfvq4V0Pkfwg2S8W
 D09RGEs9+Qyt1h7gkmNrJICpnDoz1jbAHlBPrBxf8oVEtQfc8IFjweN3HSLIIDxSuhgT
 piCg==
X-Gm-Message-State: AOJu0YyviPa8Ij2IW1S8In4xYRhES1q1CJfJE+TYHJRYWJjMXl+JTZYP
 e+R4x+bZ/7odqJI1/YTLnMj/sjkQImLW7mcmKFalZKufsLjqZloeAa5nX3YiBrIT/31AnbHbSTm
 Q
X-Google-Smtp-Source: AGHT+IFIXhegcBWrMQXEBc5zBwvz9PIi8hZwOpdTfxeiKq4D4srV8zms3uAjUDePCCp4cTpjfq+IjA==
X-Received: by 2002:a9d:5914:0:b0:6e4:3e64:b01 with SMTP id
 t20-20020a9d5914000000b006e43e640b01mr4888666oth.5.1708240761626; 
 Sat, 17 Feb 2024 23:19:21 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a628104000000b006e3c8eb705fsm1216766pfd.151.2024.02.17.23.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 23:19:21 -0800 (PST)
Message-ID: <f6560bab-705e-4f2a-9f08-158667a23a70@daynix.com>
Date: Sun, 18 Feb 2024 16:19:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] util: Introduce qemu_get_runtime_dir()
Content-Language: en-US
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

This patch series has been forgotten for a while but can still be 
applied. Can anyone review it?

Regards,
Akihiko Odaki

On 2023/09/21 16:54, Akihiko Odaki wrote:
> qemu_get_runtime_dir() returns a dynamically allocated directory path
> that is appropriate for storing runtime files. It corresponds to "run"
> directory in Unix.
> 
> With a tree-wide search, it was found that there are several cases
> where such a functionality is implemented so let's have one as a common
> utlity function.
> 
> A notable feature of qemu_get_runtime_dir() is that it uses
> $XDG_RUNTIME_DIR if available. While the function is often called by
> executables which requires root privileges, it is still possible that
> they are called from a user without privilege to write the system
> runtime directory. In fact, I decided to write this patch when I ran
> virtiofsd in a Linux namespace created by a normal user and realized
> it tries to write the system runtime directory, not writable in this
> case. $XDG_RUNTIME_DIR should provide a writable directory in such
> cases.
> 
> This function does not use qemu_get_local_state_dir() or its logic
> for Windows. Actually the implementation of qemu_get_local_state_dir()
> for Windows seems not right as it calls g_get_system_data_dirs(),
> which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
> "/usr/share", not "/var", which qemu_get_local_state_dir() is intended
> to provide. Instead, this function try to use the following in order:
> - $XDG_RUNTIME_DIR
> - LocalAppData folder
> - get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
> 
> This function does not use g_get_user_runtime_dir() either as it
> falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
> available. In the case, we rather use:
> get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
> 
> V2 -> V3:
>    Rebase to the current master.
>    Dropped patch "qga: Remove platform GUID definitions" since it is
>    irrelevant.
> 
> V1 -> V2:
>    Rebased to the current master since Patchew complains.
> 
> Akihiko Odaki (8):
>    util: Introduce qemu_get_runtime_dir()
>    ivshmem-server: Use qemu_get_runtime_dir()
>    contrib/rdmacm-mux: Use qemu_get_runtime_dir()
>    qga: Use qemu_get_runtime_dir()
>    scsi: Use qemu_get_runtime_dir()
>    module: Use qemu_get_runtime_dir()
>    util: Remove qemu_get_local_state_dir()
>    spice-app: Use qemu_get_runtime_dir()
> 
>   include/qemu/osdep.h           | 10 +++++++---
>   contrib/ivshmem-server/main.c  | 20 ++++++++++++++++----
>   contrib/rdmacm-mux/main.c      | 22 ++++++++++++++--------
>   qga/main.c                     |  9 ++++-----
>   scsi/qemu-pr-helper.c          |  6 +++---
>   ui/spice-app.c                 |  4 ++--
>   util/module.c                  |  3 ++-
>   util/oslib-posix.c             |  9 +++++++--
>   util/oslib-win32.c             | 24 ++++++++++++++++++++----
>   contrib/rdmacm-mux/meson.build |  2 +-
>   10 files changed, 76 insertions(+), 33 deletions(-)
> 

