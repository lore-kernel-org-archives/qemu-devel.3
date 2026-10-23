Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC300606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZbcfLUqX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbW-0006kX-MF; Fri, 23 Oct 2026 07:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3M0fbagoKCow89q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbU-0006jm-A6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:32 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3M0fbagoKCow89q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbS-00065m-Hp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:32 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8a08903566dso1408154b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755508; x=1793360308; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qfmLrTe7dWkYF26PecD+fqBQjzC7Imhutt56uVa06N0=;
 b=ZbcfLUqXuItQvHTiy3fyAusUlBvQwDszZSez9797EYPmitJJBsbJaYh68jqPJ4QoaV
 SB2XwMmexGs5PN8r0jAghXkyMI2iAAbwSc72vXG7JLZagkZbNBcI6XGs3AXizfdVrOjr
 qHiNwh19Owj8vnZt006xxUbplcxJUuXr+29sDrANUYw9M32QGwtip5Zm29TUNL95+ikl
 Ij9nfI1LimGd6ifhU9Xio3HuaeNp03w6zGG0IxXI3V+FJ+5ZOxl0Bxna6I8GcB9dU9c/
 iz+wYdWtqzDjCNlyaTL1MpQiiq++BehewuDl1SdVuCsh8t5DPyI1hE9HuAaD5aoO1mBn
 UILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755508; x=1793360308;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfmLrTe7dWkYF26PecD+fqBQjzC7Imhutt56uVa06N0=;
 b=IuW61i3F57NOqD5UMUlCDaBcwnzz7U6idZiU8XWQ3DJPOwFJrtO6H/dNdZ2JfqL1OZ
 VUWzPBsa3ZUYAhlCblKVQmnkD3viCmFO3r5hvX62cnSzL9vqX22YgvY+tPPhxZZSoddC
 xj636KvD0jgF8Idmvpx1NEwFy4qr3aG92zB9ixiCrWZiDNNf4PwhpEFgXwKNVWklULrc
 T8hNPXSgAzNP3ibcVm8H57ju3hc0YFNeSZE0vc5D0t/F4ig9Ofbac13ezQAGyvPrPb5M
 CLqwnmDD4xReRLsssoxPv7HoTvSO04HI6/0iV/1yQtNVlKHQVP3P8rBsFCSnihV1l4fg
 W7Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdb6qDIStxGB2pzmcJ8GDPvcEXqY9Rdjr/8jQdTWhmPPnm4f1Clka/ylFFz/62Bf17S7K28DGvt+1/@nongnu.org
X-Gm-Message-State: AFq9FYItW/nCXQGV+elV04w5QyY0g9SSSA8YrLYflC40Wp29gfRf/wO0
 EvVpjQOTSSoEUq9wTXXATXrgxHhgRYTC914i+jl9+iVbN6Qo6oE4bIdvDBwSQ/bybCJDbAcxQAS
 RgvmMNgiafimfxFsGsCCquA==
X-Received: from pfbhm13.prod.google.com
 ([2002:a05:6a00:670d:b0:89f:dd5e:68c4])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8881:0:b0:8a0:5b29:269c with SMTP id
 d2e1a72fcca58-8a0a0486d7amr3236208b3a.13.1792755507823; 
 Fri, 23 Oct 2026 04:38:27 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:26 +0800
In-Reply-To: <20261023080101epcms2p7070aa02ae311188492d194457eea1a3d@epcms2p7>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
 <20261022074513.2292281-3-stanleyjhu@google.com>
 <20261023080101epcms2p7070aa02ae311188492d194457eea1a3d@epcms2p7>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113826.3368071-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>,
 qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3M0fbagoKCow89q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 17:01:01 +0900, Daejun Park wrote:
> Which host path is in-transition meant to reach? In Linux, QUERY TASK
> is sent only by ufshcd_try_to_abort_task(). When it runs from
> ufshcd_abort() after a SCSI timeout, scsi_timeout() has already set
> SCMD_STATE_COMPLETE (drivers/scsi/scsi_error.c:391), so scsi_done()
> drops the completion posted here (drivers/scsi/scsi_lib.c:1772). The
> request stays MQ_RQ_IN_FLIGHT, ufshcd_cmd_inflight() stays true, and
> the loop returns -EBUSY after 100 "not pending" replies
> (drivers/ufs/core/ufshcd.c:7993-8026). The "completed" branch is never
> taken, and recovery ends in a host reset, as with abort-failed. I got
> this with O_DIRECT writes on mainline 7.3-rc7 (MCQ and legacy) and on
> ACK android17-6.18 (MCQ).
>
> If the target is a path where the host does take this completion, for
> example ufshcd_abort_all() from the error handler, the host would see a
> WRITE succeed although no data reached the LU.

You are right that the completion posted after scsi_timeout() is
dropped and recovery ends in a host reset. The mode does not target a
specific host branch. It reproduces a device that finishes a command at
the moment the host times it out and aborts it, which is hard to hit on
real hardware. That window already exposed a few races in the Linux
error handler, such as a double completion.

Whether the host should take that completion is a Linux policy. The
device model should not decide it. v3 no longer fakes the completion.
When QUERY TASK arrives, the held command really runs and its data
reaches the LU. QUERY TASK then reports the actual task status.

> This repeats the generic ABORT TASK code in ufs_process_tmr(). The held
> request is in UFS_REQUEST_RUNNING, so ufs_find_req_by_tag() finds it,
> and releasing the hold and returning false gives the same result. The
> same is true for the QUERY TASK SUCCEEDED branch above. With both
> changed (17 deletions, 4 insertions), the UFS qtests pass 29/29.

Done.

Thanks,
Stanley

