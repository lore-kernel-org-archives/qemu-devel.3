Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B10C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAXP-0008KZ-9v; Wed, 30 Apr 2025 12:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAAXL-0008BE-5R; Wed, 30 Apr 2025 12:43:56 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uAAXG-0001KH-2Y; Wed, 30 Apr 2025 12:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1746031113; bh=1ZGBTz4x3LhPONyN87aK3yB8MYzxEM/xYM9k9iCNOaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ktAyS659lJ2FJ2K9JfE/PxgjlhmFy/BrGsR1jn+7EaeHDJKA6x1A5BD4M9i8EULFq
 w2kfWZ4bHcUWU/odKhSOtEmx2Pw3pnyVMn5Hr5uzMAjR+lsDYPh0IoTeLlnbtCBR9B
 qbUguJo6sq/nIL0RAcx5ThQ7PF7f7iDR7mTG5A1k=
Received: from 192.168.182.133 ([117.147.34.111])
 by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
 id 99E92823; Thu, 01 May 2025 00:38:30 +0800
X-QQ-mid: xmsmtpt1746031110tj4hpphsc
Message-ID: <tencent_896794CDF9345EF41DF2DCA4B08380B22D07@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQpGu9SkD+8lnK4zLutLMmaTHwKWobjlKV117YhfTBaJYOanypFn
 g4ERgNTW6C5lN4tjKZUJj1bubOc3SRc1sdoXBCxK3Kc7Ip7HmL3R72lZesjwWnhN+7KsaJ22+iKe
 Z71rY72HEVaIWgUw+LmIKI//NGgXjfQAg7snhsIjBBk8z2mvrd+o80OukR9rudaonIDewaZld2yU
 CX6WN0XUlbprcffpphAwLRplDd1LIWVKIsfAVsqq1oDGWKQVtmFeTJEPIAB0PH9qYo3kLBxV+YDx
 uFS1ntYv3SV6Yc4Lk4H7WurIRNLXQVQsqV9YgaSQnrvUJueCih8t9K5SHZGAE4YyGs2MzVkFnWf3
 cfRWFxSfIkfazn/+YUPoun9ALn3QI55urWysJP+6Ih46+wdT5ktbofg+afTNZXBsJdYplvllKHJq
 NtmoqnT6K7/n9tPx/qzYfFneK9qOKCKGz1OfMlGtdNOvtz67C0o54lhyrl4nyC/cYP4jSK9SamPA
 onbmNl0hVQmtLfw1c2Tl/R2vvGwINE6DNwoBHFhDcZQ6y4OR8+Nk9ZoAbKt/3jRlZY3tppxJ7kxv
 +SZnObGYuACz8Xc0JD0BVqYm6H9OlBvFw9ThVqNQC5HqvYhQIpVWbjpGUCqCuXvU8GuD+ls5s/dx
 vapIXxriW3ikE6uWtqsiZgMV3TzgX9TAp23ic4zLGEVa9aKUOZsoxmYplpv0+/w2pfM34fUNAnzx
 PQIlh7G/0fJaBxgISawobmQMdDE17j6mN0JlRhLdJgEQN84CcMPtucfFtsTvlIezyciHeLya9cR6
 eQ8x556uojw+glbNIg5IrD7h4kaN2XF/sPt9eta+8wVk8y1s+Sn81E4VqUcFwSfttpftdpiYSkOg
 bT6p7nyIO5i08vz6VcArGLlDdmcFo2sgvqovvTThh3nBV9HEu8nmBnJOBP9QSRa8oGlMFWAT3ahv
 iN9OLvcsE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re [PATCH v3 08/11] mirror: Skip writing zeroes when target is
 already zero
Date: Thu,  1 May 2025 00:38:30 +0800
X-OQ-MSGID: <20250430163830.47692-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425005439.2252467-21-eblake@redhat.com>
References: <20250425005439.2252467-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.54; envelope-from=sunnyzhyy@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

on Thu 24 Apr 2025 19:52:08 -0500, Eric wrote:
>      if (s->zero_target) {
> +        int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> +
>          offset = 0;
>          bdrv_graph_co_rdlock();
>          ret = bdrv_co_is_all_zeroes(target_bs);
> @@ -856,6 +898,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>          if (ret < 0) {
>              return ret;
>          }
> +        s->zero_bitmap = bitmap_new(bitmap_length);
>          /*
>           * If the destination already reads as zero, and we are not
>           * requested to punch holes into existing zeroes, then we can
> @@ -864,6 +907,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>          if (ret > 0 &&
>              (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
>               !bdrv_can_write_zeroes_with_unmap(target_bs))) {
> +            bitmap_set(s->zero_bitmap, 0, bitmap_length);

when arg->mode != NEW_IMAGE_MODE_EXISTING && bdrv_has_zero_init(target_bs) is true
in drive_mirror (This means the target image is newly created), in which case
s->zero_target == false, we still need to execute bitmap_set(s->zero_bitmap, 0, bitmap_length) 

>              offset = s->bdev_length;
>          }
>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
> @@ -875,6 +919,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>          while (offset < s->bdev_length) {
>              int bytes = MIN(s->bdev_length - offset,
>                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));


