Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C10C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8xe-0002Dc-MR; Tue, 12 Mar 2024 16:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk8xV-0002DF-7a
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:42:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk8xS-00066h-8r
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:42:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56838e00367so436748a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710276164; x=1710880964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rw7OFmtlT7DLZ5gYqKo9j78RPrCNhXdDC0j+dInMk0=;
 b=lEWccIF5yBomp5kLIN4CMmHSYMGhsgSWSfaL7ip56+NTlVrXWPaMjBLkIL9EboHcrA
 MPotAma/sRpV44qwp1c4b2tjPza50LfUhCvT7ddAoOmCDdR+frVjy9QiH59PFlhvborf
 IIYZMPq3ypPRfKQTYTsuTq0qbiG+mYC0RaEzl6bV4mBo9te9nF14GfQSNcRroqByX4Xx
 IDER8eDM19w6y9A3iIhPU1CygOflAxWx5qBa4R0KKDq7to/WQTQp4ASsbnoGg0uPQ5F7
 zzAyNTuT8xMU4HUDWMDpoUdcfyTWVCq2xnxcEpC8QKwfc8+WlEwBQN8hH5LJq8gslSed
 n+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710276164; x=1710880964;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3rw7OFmtlT7DLZ5gYqKo9j78RPrCNhXdDC0j+dInMk0=;
 b=n7HnZyJiZwa532EIkSsGNtF4prOHu8g4aucId0borVm1RKZv9t7xd/GKo/6wEDpbfu
 BhmQrhtpGxzfwCri4RoqJFHJCdd5K+bELVdeYtHGv63LMheWF54vMgm0qkg8/unyKsvf
 SEbZiGDu0cm7xbeIjTXJuYAD8vr9PCiSDVOR3otUAtRenuhTTiKRwHjBYkaB9QxRMbYp
 WbhBtpbMOqglAeO5UWwW6vPyBtKOwUsQuAWKv8BOCeT4vzwVM1cs6MjQI1g/Xe42g4d1
 MfEDKl6941JiOaHB90sWomx6n+GdeyxjsGe+tKMKrgqmPm4EbJrNnl6/XNLwpUdh+0qo
 KxQQ==
X-Gm-Message-State: AOJu0YzPHLm9rOvc+dLS8+fuTCJe+/9PQ5pX7XfyYXXWr6zpTt52y+GX
 1GBafM+O2uZv/z1bEILROqbFOmpqEGoFUyT/P+eyD5GIBIiLhB0f+WWnR8VXL7wIAolUOZOXq1H
 A
X-Google-Smtp-Source: AGHT+IGsCgBg0U3C9zUbh9wEtwKT7V0bB8XJ+0st0A98IOfnitl/RGXMEuV5kYKnJBzjE+kYJ75VHQ==
X-Received: by 2002:a17:906:38d2:b0:a46:24fd:4a75 with SMTP id
 r18-20020a17090638d200b00a4624fd4a75mr3337971ejd.29.1710276163251; 
 Tue, 12 Mar 2024 13:42:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 qx26-20020a170906fcda00b00a45a687b52asm4158232ejb.213.2024.03.12.13.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 13:42:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E1FD5F888;
 Tue, 12 Mar 2024 20:42:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?0JzQuNGF0LDQuNC7INCh0LXQstC10YDQvtCy?= <senserk71@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Possible memory release problem
In-Reply-To: <CAL1vMp0KdjfVMOnLcDxr9Cdcvr34jp2aHorZ3F6ibiSRavLiiw@mail.gmail.com>
 (=?utf-8?B?ItCc0LjRhdCw0LjQuyDQodC10LLQtdGA0L7QsiIncw==?= message of "Tue,
 12 Mar 2024 21:45:24 +0300")
References: <CAL1vMp0KdjfVMOnLcDxr9Cdcvr34jp2aHorZ3F6ibiSRavLiiw@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 20:42:42 +0000
Message-ID: <87r0gfmbb1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB =D0=A1=D0=B5=D0=B2=D0=B5=D1=80=D0=BE=
=D0=B2 <senserk71@gmail.com> writes:

> Colleagues, can you tell me in /migration/ram.c :2837 whether it is not n=
ecessary to perform memory release for
> block->bmap, after memory has been allocated in :2831. If not please
> explain why

It's easier if you post the context for the code as things do move
around:

  static void ram_list_init_bitmaps(void)
  {
      MigrationState *ms =3D migrate_get_current();
      RAMBlock *block;
      unsigned long pages;
      uint8_t shift;

      /* Skip setting bitmap if there is no RAM */
      if (ram_bytes_total()) {
          shift =3D ms->clear_bitmap_shift;
          if (shift > CLEAR_BITMAP_SHIFT_MAX) {
              error_report("clear_bitmap_shift (%u) too big, using "
                           "max value (%u)", shift, CLEAR_BITMAP_SHIFT_MAX);
              shift =3D CLEAR_BITMAP_SHIFT_MAX;
          } else if (shift < CLEAR_BITMAP_SHIFT_MIN) {
              error_report("clear_bitmap_shift (%u) too small, using "
                           "min value (%u)", shift, CLEAR_BITMAP_SHIFT_MIN);
              shift =3D CLEAR_BITMAP_SHIFT_MIN;
          }

          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
              pages =3D block->max_length >> TARGET_PAGE_BITS;
              /*
               * The initial dirty bitmap for migration must be set with all
               * ones to make sure we'll migrate every guest RAM page to
               * destination.
               * Here we set RAMBlock.bmap all to 1 because when rebegin a
               * new migration after a failed migration, ram_list.
               * dirty_memory[DIRTY_MEMORY_MIGRATION] don't include the who=
le
               * guest memory.
               */
              block->bmap =3D bitmap_new(pages);
              bitmap_set(block->bmap, 0, pages);
              if (migrate_mapped_ram()) {
                  block->file_bmap =3D bitmap_new(pages);
              }
              block->clear_bmap_shift =3D shift;
              block->clear_bmap =3D bitmap_new(clear_bmap_size(pages, shift=
));
          }
      }
  }

On my copy the code the two bitmap_new()'s are for different variables.
Are you asking where they are freed? AFAICT here:

  static void ram_save_cleanup(void *opaque)
  {
      RAMState **rsp =3D opaque;
      RAMBlock *block;

      /* We don't use dirty log with background snapshots */
      if (!migrate_background_snapshot()) {
          /* caller have hold BQL or is in a bh, so there is
           * no writing race against the migration bitmap
           */
          if (global_dirty_tracking & GLOBAL_DIRTY_MIGRATION) {
              /*
               * do not stop dirty log without starting it, since
               * memory_global_dirty_log_stop will assert that
               * memory_global_dirty_log_start/stop used in pairs
               */
              memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
          }
      }

      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
          g_free(block->clear_bmap);
          block->clear_bmap =3D NULL;
          g_free(block->bmap);
          block->bmap =3D NULL;
      }

      xbzrle_cleanup();
      compress_threads_save_cleanup();
      ram_state_cleanup(rsp);
      g_free(migration_ops);
      migration_ops =3D NULL;
  }


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

