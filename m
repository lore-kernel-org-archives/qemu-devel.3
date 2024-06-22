Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D11AC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu2o-0008Li-MC; Sat, 22 Jun 2024 02:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2j-0008K5-N0
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2f-0006NG-R5
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YSCOHApccYoLBq+W6uZx9RtGQ0xPmTOB1+7n96OYzX0=;
 b=TFeeOEzPyd9wN66MgXyAPVZdyM8gzeKk66H36e959/EJaqHKuH0b0FjqmViCaCi1m+6KqD
 oGZv81qxc+hZD83HkR4zaj1hbR9oD9Nln236mV0R0iE7rnuXTDUqp4BF1KM1fgrNhJTmFf
 XjoZosDhq11oY+9sUgm2xKSdi0+5bzw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-1EBWvxznM2aH91jIouE0EQ-1; Sat, 22 Jun 2024 02:16:02 -0400
X-MC-Unique: 1EBWvxznM2aH91jIouE0EQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a306c4b1eso1742700a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036961; x=1719641761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YSCOHApccYoLBq+W6uZx9RtGQ0xPmTOB1+7n96OYzX0=;
 b=jXDjgDMijQjpzKntf/bhsCXve+9g84bTL4/b6T4kgJbNGcVa+UZnFxeeMMD5EoA4xz
 Koei54/2n8ZyKtDUOHZxKZZJXmuKYUE3vtykd6ZbI4HgKARfaGCcNCnyi1QlqQUDwQ6D
 w3Ooar32KhFjz+U6iu5WEH+ImJf8uBIv4yx8IH0VizFulvfy8qXmbP8wjL8zDaPjvGob
 nF0IKWWD1gTUrBCPFc0MMFleU4bPYOJXeSv+jGVOQ/HC/HczwbA0CiY7R7+iKoOUiibH
 V0BE6gtR1IIaDbVR/r9tVnB9P8QrgA3ROK8jtqNhSsnDlhwbdQVL6lMQPKp2+VHm6mc8
 kgIg==
X-Gm-Message-State: AOJu0YzaZniQ2BuIDzlqDMvZThLkDBShPkxUd+qdHNxbOZeT/+p9kAk0
 rZAzvhbkge72qMcSFarxdnOpIbJsicuZmvwM4cUH0Jov+beMzPFoDrGiIBkEqfmHcY3wsWeddB2
 wVPT9bXiBniKvOBtcXOQZKaROF2v5xXdN0KRkWCcmjgs5EYGM8RDFil9I3xEYm9jgAyY2uAg667
 ZowXaAoUQgTxSodxiAq0njmV24EElhw3T7ncjv
X-Received: by 2002:a50:bb45:0:b0:57c:bf3b:76f5 with SMTP id
 4fb4d7f45d1cf-57d45809d0dmr172380a12.35.1719036960813; 
 Fri, 21 Jun 2024 23:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOsDNbIeL+Dpyq9tfFEUc9xuh8nKpAArVYMeZrq9LBbGGTCzY+dLj2mTdYt0a91eKXGmceOA==
X-Received: by 2002:a50:bb45:0:b0:57c:bf3b:76f5 with SMTP id
 4fb4d7f45d1cf-57d45809d0dmr172363a12.35.1719036960075; 
 Fri, 21 Jun 2024 23:16:00 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30413446sm1899848a12.31.2024.06.21.23.15.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:15:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] Misc changes for 2024-06-22
Date: Sat, 22 Jun 2024 08:15:34 +0200
Message-ID: <20240622061558.530543-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 223696363bb117241ad9c2facbff0c474afa4104:

  Merge tag 'edgar/xilinx-queue-2024-06-17.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-06-18 13:08:01 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b9b51004033983589e00fb4697f620b903cfcf0e:

  exec: don't use void* in pointer arithmetic in headers (2024-06-21 18:32:18 +0200)

----------------------------------------------------------------
* configure: detect --cpu=mipsisa64r6
* target/i386: decode address before going back to translate.c
* meson: allow configuring the x86-64 baseline
* meson: remove dead optimization option
* exec: small changes to allow compilation with C++ in Android emulator

----------------------------------------------------------------
Paolo Bonzini (21):
      configure: detect --cpu=mipsisa64r6
      target/i386: fix CC_OP dump
      target/i386: use cpu_cc_dst for CC_OP_POPCNT
      target/i386: give CC_OP_POPCNT low bits corresponding to MO_TL
      target/i386: convert bit test instructions to new decoder
      target/i386: try not to force EFLAGS computation for CC_OP_ADOX/ADCX
      target/i386: decode address before going back to translate.c
      target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder
      target/i386: do not check PREFIX_LOCK in old-style decoder
      target/i386: list instructions still in translate.c
      target/i386: assert that cc_op* and pc_save are preserved
      target/i386: remove gen_ext_tl
      Revert "host/i386: assume presence of POPCNT"
      Revert "host/i386: assume presence of SSSE3"
      Revert "host/i386: assume presence of SSE2"
      meson: allow configuring the x86-64 baseline
      meson: remove dead optimization option
      block: make assertion more generic
      block: do not check bdrv_file_open
      block: remove separate bdrv_file_open callback
      block: rename former bdrv_file_open callbacks

Roman Kiryanov (2):
      exec: avoid using C++ keywords in function parameters
      exec: don't use void* in pointer arithmetic in headers

 configure                        |   2 +-
 meson.build                      |  54 +++--
 host/include/i386/host/cpuinfo.h |   2 +
 include/block/block_int-common.h |   3 -
 include/exec/memory.h            |   6 +-
 target/i386/cpu.h                |  13 +-
 target/i386/tcg/decode-new.h     |  19 +-
 tcg/i386/tcg-target.h            |   5 +-
 block.c                          |  17 +-
 block/blkdebug.c                 |   2 +-
 block/blkio.c                    |   8 +-
 block/blkverify.c                |   2 +-
 block/curl.c                     |   8 +-
 block/file-posix.c               |   8 +-
 block/file-win32.c               |   4 +-
 block/gluster.c                  |   6 +-
 block/iscsi.c                    |   4 +-
 block/nbd.c                      |   6 +-
 block/nfs.c                      |   2 +-
 block/null.c                     |   8 +-
 block/nvme.c                     |   8 +-
 block/rbd.c                      |   3 +-
 block/ssh.c                      |   6 +-
 block/vvfat.c                    |   2 +-
 target/i386/cpu-dump.c           | 101 ++++----
 target/i386/tcg/cc_helper.c      |   2 +-
 target/i386/tcg/translate.c      | 492 ++++++++-------------------------------
 util/bufferiszero.c              |   4 +-
 util/cpuinfo-i386.c              |   6 +-
 target/i386/tcg/decode-new.c.inc | 136 ++++++++---
 target/i386/tcg/emit.c.inc       | 249 +++++++++++++++++++-
 meson_options.txt                |   5 +-
 scripts/meson-buildoptions.sh    |   6 +-
 33 files changed, 618 insertions(+), 581 deletions(-)
-- 
2.45.2


