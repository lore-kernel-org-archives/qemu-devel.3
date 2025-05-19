Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5380C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 11:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGyez-0004s0-53; Mon, 19 May 2025 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uGyex-0004rn-ON
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uGyet-0007ET-PI
 for qemu-devel@nongnu.org; Mon, 19 May 2025 07:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747654070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ruh72etsSmTHBHL8yVKTOdb7DWKCz5J1IkvkJxVqURQ=;
 b=NCqaPku96wighRhPQjiqqlCwENO48zYoz9qyayZz1XCPXKmM37LXfHifzTXLVaCwcZkG0a
 vHi/1lUeQAnh9PrltfH/aq/o/EW8WkVJTLTuaYVnGURc2iZ86/Qi150J9/+PR5fCeuTYAK
 eGe33wDya8UB6iBfmrnC5oI1pTWDhAM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-u2NJrQxYOd6afuMKi2A_8A-1; Mon, 19 May 2025 07:27:48 -0400
X-MC-Unique: u2NJrQxYOd6afuMKi2A_8A-1
X-Mimecast-MFC-AGG-ID: u2NJrQxYOd6afuMKi2A_8A_1747654067
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-550ecc7b237so1587082e87.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 04:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747654067; x=1748258867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ruh72etsSmTHBHL8yVKTOdb7DWKCz5J1IkvkJxVqURQ=;
 b=vinPpIWJx6BW+FhBKzAWys+fwmZlHqR4aqFP6Ste248umJ3K9961mUa5YYEabIyEka
 RZDjS5JV40/Gy4c42AWoPD3lDoVVTENibOYCNN/U3lTXwJiCiCgzYMfmt78roFd546eF
 kMe/TRnC9Tssr6jtTv6h9rqu4MBgf/4Ct5eZD646wgIPAgDAnXVMV8VY9DmlkHBcBORO
 E9S5XMqbAzth+Wn7ljlhRGpbTaRUK014d8lV0snIrsujW9AGDFlxAJomQ5lqMcKdlbBP
 PW8S1aG0UF0dQxu3PdijCyHQqXXsA6Z7H/HIlD3OYGecxVbewW0JYruUJEw103eES/NN
 HHRw==
X-Gm-Message-State: AOJu0Yy2MDlOvOIOQOXxyhv2TakhdQeWuRzoG4Gk+0750PT4Rg/MMJRX
 LzrRKtpMpGrfJF3rEyWBDXIHfem3vcfYSKqkwTMjeeSZ8XxS5fqYikFsqzXKhHi6S8eMkxwQms+
 /b/gr7gwC8ctw+Gx7DpmFGWGWIvdwjScC/72QcmWyKzF9U62J5pzr3fmWeXWWPwzCP6Paw9V8Zj
 3NU/gZRSXjZezMPqfKt8IZJhxFy6OtzOE=
X-Gm-Gg: ASbGnct8UC1/g9EmAWuRoQMy2lHJ8QJRV7JfQ8FXKATnnNmtOtXiZEOf1bd2q4HVNGY
 1sL4GU3YiXlxmxjN7FF4dRYcmBP9FaGdOikXQBgTqMEsumC54Hs+cgZ1e15hVWkrmF1wz
X-Received: by 2002:a05:6512:461b:b0:54e:93cf:338d with SMTP id
 2adb3069b0e04-550e7197991mr3518850e87.12.1747654066876; 
 Mon, 19 May 2025 04:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXSB761Y5IthFM4tw7qYgdrTIM5ysc6QSYeelm8ZGL98+xWTj3nrxotGsILEWfHDQB9EcEYy6eyGAtHUiIiI=
X-Received: by 2002:a05:6512:461b:b0:54e:93cf:338d with SMTP id
 2adb3069b0e04-550e7197991mr3518844e87.12.1747654066474; Mon, 19 May 2025
 04:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250514200137.581935-1-peterx@redhat.com>
In-Reply-To: <20250514200137.581935-1-peterx@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 19 May 2025 13:27:35 +0200
X-Gm-Features: AX0GCFsovBoV3vgId1o3NuAS5MnEVgoYJXGysjqQyWBI5BbTTiLTZZwe9MpNtIM
Message-ID: <CAMXpfWvhQCXa_tYGnf+e=vrt7XtrJE4Bxz6BnO6fnS_OU+8s6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] migration: Some fix and enhancements to HMP "info
 migrate"
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series has been successfully tested. Now the HMP info migrate
command is more compact and readable. With the -a option the values of
the globals are displayed as well.

(qemu) info migrate
Status: active
Time (ms): total=3D4029, setup=3D36, exp_down=3D300
RAM info:
  Throughput (mbps): 938.03
  Sizes (KB): psize=3D4, total=3D16798280
    transferred=3D426629, remain=3D6121884,
    precopy=3D426752, multifd=3D0, postcopy=3D0
  Pages: normal=3D105457, zero=3D466489, rate_per_sec=3D28728
  Others: dirty_syncs=3D1

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Wed, May 14, 2025 at 10:03=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> v2:
> - Dropped patch 2, dump globals only if "-a" in the last patch [Dave]
> - Keep using "Throughput" for dumping ->mbps [Juraj]
> - Rearranged some more, e.g. put xbzrle/globals under -a too, added inden=
ts
>   for the global dump, etc.
>
> Patch 1 was a bug I found set capabilities, so it's pretty separate issue=
.
>
> Patch 2 was an attempt that I made the HMP "info migrate" looks slightly
> easier to read.  A new option "-a" is added to request a full dump,
> otherwise only the important info will be dumped.
>
> Comments welcomed, thanks.
>
> Peter Xu (2):
>   migration: Allow caps to be set when preempt or multifd cap enabled
>   migration/hmp: Add "info migrate -a", reorg the dump
>
>  migration/migration-hmp-cmds.c | 186 +++++++++++++++++----------------
>  migration/options.c            |   4 +-
>  hmp-commands-info.hx           |   6 +-
>  3 files changed, 101 insertions(+), 95 deletions(-)
>
> --
> 2.49.0
>
>


