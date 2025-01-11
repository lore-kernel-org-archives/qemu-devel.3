Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8331BE7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 05:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWTqV-000744-Qt; Sat, 11 Jan 2025 00:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWTqQ-00073h-E8
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:15:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWTqO-0004bF-Jt
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:15:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2161eb95317so46146155ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 21:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736572530; x=1737177330;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Esq+DC/6wReneB8EcYt9lCpQXmNVwAKF77CiTK+GSbo=;
 b=EPpAfv5jGP6bsgnndSTFDFXFFW6C1Bam1jElYunVfR5F4DHcX7iqHEPgv251cm5enU
 yJ99M7+Xa5SPFIxK/Pbhxgvm9QFMzCT1hMJqMEf5VGI2td4FLFg1h1y842o42gxuuUlD
 l8H7ktfYA0V7grcv9cJYNZiE2qVkUl4ascQBiR8dxySP2JftNkUTtsWLi7BtUamLh7U7
 oMa6j2S00KDWcQjT1ckaZ45pIWWCC2NqfwcuNsiYx312Rd4tVSoOe0tOEungn4ENr/37
 2tmXdBIM2BDcVdQQaBIPXEzix3hSGqm2e25mDEFkLBqK7u3sIWlCTADSCrPnPa5NtOIq
 HHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736572530; x=1737177330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Esq+DC/6wReneB8EcYt9lCpQXmNVwAKF77CiTK+GSbo=;
 b=pDtPZ+dwnqklm2eCUyZG5PJsAsQv0PxVRtaM8bKD5gft3JI+qTsCYh9YvW9iljigit
 MnO/mTMjqWeYEmtYgds4mHNk7Gdx3N6msDK7y93wxMYVZ06SOjeSQDlkIMNWVhGvVK0F
 kmLTMpIqwZo8bC2RVWgViqHsUWj2ZATpswAVyHSYEmbDnonQTnvpr4kRGk9zR07I6wMr
 4+PpudpVxVxxNgAkSYoEPtQ4W0TCg2eUVwitBXynqxzgTF9B3rHAEHhs4iGZ1qyLJ09m
 KbQhUs9Zt3tqfxjBVudOgO5/ocgAn+EZY+w+bRT/fVYiCoNKy24C+OvWRpYiuZHHc4Rx
 BonQ==
X-Gm-Message-State: AOJu0YwC/4Fds8E+gpLV/tOyJPCESrSL/NOK6RnLCh4DzD0yM6i2962X
 WBv2l3/uC0BDe57RCuDdRVM9ycAnmd7fzsjI/I/JtL70HozVgz/9Hg1oCGfR0LRmSGPnCZDCYt/
 53eg=
X-Gm-Gg: ASbGncvmlCAhWLOHcmcrDl7dNjgjIqpmX8xnjfarBQhethzDxjoS7dVVO++Vbk/Sw/R
 O2aedfsiMDluW9BM/IVQrdKOS7qJVa93o1S5akWTVs2O2G3SxPCNbyZx9x0z5i1Yt0DirwPT3yE
 8YWRgVUvfUznyHWmqGU5dJobfB8q1MbJBiSCD8FHFf/pMFbsNQ0jcWNhFKg3XiBaje6atuBD6Xz
 1Nw6TmoPwGNxMXe0aKvxYGo6zBQbffdpDX6hvu8GhNO1EYkd6muYxYxB4/hwmcQMB0=
X-Google-Smtp-Source: AGHT+IEhDXv/NuaW25ccC2A5s3ib8uiBF22lBHcgB6+dDVmneh2JOLjZwp3JGdjR3aHEt69RTcli+Q==
X-Received: by 2002:a17:903:41c3:b0:216:18f9:528b with SMTP id
 d9443c01a7336-21a83f6299emr195891145ad.26.1736572529789; 
 Fri, 10 Jan 2025 21:15:29 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f253fd3sm20834055ad.229.2025.01.10.21.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 21:15:29 -0800 (PST)
Message-ID: <d9d9cb3d-29fe-4978-8c1b-00aee167831f@daynix.com>
Date: Sat, 11 Jan 2025 14:15:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

It seems this series has been forgotten for a while. Can anyone take a 
look at it?

Regards,
Akihiko Odaki

On 2024/07/16 16:27, Akihiko Odaki wrote:
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
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v4:
> - Rebased.
> - Link to v3: https://lore.kernel.org/r/20230921075425.16738-1-akihiko.odaki@daynix.com
> 
> ---
> Akihiko Odaki (7):
>        util: Introduce qemu_get_runtime_dir()
>        ivshmem-server: Use qemu_get_runtime_dir()
>        qga: Use qemu_get_runtime_dir()
>        scsi: Use qemu_get_runtime_dir()
>        module: Use qemu_get_runtime_dir()
>        util: Remove qemu_get_local_state_dir()
>        spice-app: Use qemu_get_runtime_dir()
> 
>   include/qemu/osdep.h          | 10 +++++++---
>   contrib/ivshmem-server/main.c | 20 ++++++++++++++++----
>   qga/main.c                    |  9 ++++-----
>   scsi/qemu-pr-helper.c         |  6 +++---
>   ui/spice-app.c                |  4 ++--
>   util/module.c                 |  3 ++-
>   util/oslib-posix.c            |  9 +++++++--
>   util/oslib-win32.c            | 24 ++++++++++++++++++++----
>   8 files changed, 61 insertions(+), 24 deletions(-)
> ---
> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
> change-id: 20240218-run-6f0d91ec7439
> 
> Best regards,


