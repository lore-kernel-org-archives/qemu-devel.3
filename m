Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D52C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4Dq-000356-Fv; Mon, 03 Mar 2025 06:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tp4Do-00034V-Bl
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tp4Dk-0001HF-Ob
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741002266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMCsTry0/tMA2LX2Pnd9SJ3q80EavfrAdPGWYQpVvC8=;
 b=fbdRVx8Oy0/ZhfHt7bmQOw7cOYLeBeGQaWrvdzhH+WWrk/qWELaMov70DBme4ShIRXNqFx
 fDDzkqzdjJ+2BB1ePqjpXhmx88QhOSWbJ0fY+78FilzCixMcfcOXy1NAp2buOagwfETnbV
 qifnEP7Yr28/EJqM8t7o8J+OxiWt9PY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-0Dvt0OvRMqKn-oPM29v-7g-1; Mon, 03 Mar 2025 06:44:14 -0500
X-MC-Unique: 0Dvt0OvRMqKn-oPM29v-7g-1
X-Mimecast-MFC-AGG-ID: 0Dvt0OvRMqKn-oPM29v-7g_1741002254
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so23167585e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741002254; x=1741607054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pMCsTry0/tMA2LX2Pnd9SJ3q80EavfrAdPGWYQpVvC8=;
 b=DKp2SN4ELYmpSZZcCyS/126SAjDSYe9NFzCllG9nDH8jtlntOdyCG2nL9glgEahfbk
 PohrkRKFpWFRsDFTtL93vmkke93jIi5z3FGXF+KdBSAHjE9ATtHyNm/HplrEOp4gOKo0
 BuSPKP57Ii94KwtqEHTvUMPXh4LomvxAKy//RLVj7p78I7eKdNSksCtnZQA8ntFR9ibj
 ET337DfwMiMDk4k5K9MuRigW6SiiccUOoRBIkmMg0kgfMGT9cESDizFxo1aypykiXyxA
 q/8BELxQJTkjFsJ2qUBZci1F4AouvWuvxpGla9/MIrriATg8B7+k5RSUFRFwBZOO9sSb
 jTkg==
X-Gm-Message-State: AOJu0Yx5zBRT9wqWG/YQl8ao9y9rFw84QidXwvVyplafnQ0Zfqoa8cWd
 JC5rz1l+AO/mUuiZAQegrdtFfwHTiqA+8my16iR8iA8KAPa5Xw03tYUMqBi9m4IX8MfQD+eep5N
 AiMtZTSaFp/B6g+Nd7jPeM5QspNQC0us3LG08FoTbVtZHGLMhkkQx88pWr2Y9WAmVpsfqAdsd4B
 H9wWyo79PhpyIqRojD3RC8/f1RQO8=
X-Gm-Gg: ASbGncsrTW/ZaQdcsMXUvACWJmxGwA3D9R+RYrREVOaX0wM+UB4fC4j45HLeFEM+XLb
 Qw6xdtmmPXk5JaFkp5bgnJY9yZBuMD2uNGDF0K45X/GnycSEcWYmVDUOcQuJ1d3e9Sy3d9KsQHb
 w=
X-Received: by 2002:a05:600c:1da8:b0:439:9b3f:2de1 with SMTP id
 5b1f17b1804b1-43ba6702c10mr117703085e9.15.1741002253675; 
 Mon, 03 Mar 2025 03:44:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkPDrf4BubXbzrj+SyhqLEtb5gCXPeYzZHtuRsk17Zeu1Ub8/jlYHqOarXLNY9dLz9RJbrafa27RP9jMf8o/g=
X-Received: by 2002:a05:600c:1da8:b0:439:9b3f:2de1 with SMTP id
 5b1f17b1804b1-43ba6702c10mr117702795e9.15.1741002253314; Mon, 03 Mar 2025
 03:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
In-Reply-To: <Z8G9Wj3DWSgdLkNQ@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 3 Mar 2025 17:13:56 +0530
X-Gm-Features: AQ5f1Joi-_XsuKCh1kK3NPGbxLT8aILrEuiyWxKl-qRrMGMcGlgoz6fjrDKBVTk
Message-ID: <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hello Peter,

On Fri, 28 Feb 2025 at 19:13, Peter Xu <peterx@redhat.com> wrote:
> We should be able to do multifd's flush and sync before VM
> stopped in postcopy_start()..
>
> What I actually think the easiest is to do flush and sync once in
> postcopy_start() as mentioned above.  I think that'll serialize with
> postcopy messages later on the main channel, making sure all channels are
> flushed before moving to postcopy work.

* Is there some specific benefit to calling
'multifd_ram_flush_and_sync()' from OR before postcopy_start()? Maybe
that is missing on me.

* I'll try to explain why adding a migration command makes sense:

   - I did call 'multifd_ram_flush_and_sync()' before calling
postcopy_start() in migration_iteration_run(). After flushing the
'multifd_send' queue, all it does is send
'RAM_SAVE_FLAG_MULTIFD_FLUSH' flag on the main channel. On the
destination side the 'qemu_loadvm_state_main()' function does not
understand that message, because it looks for 'section_type'; And when
it is not able to identify the section, it leads to an error.

          "Expected vmdescription section, but got %d", section_type(=0)"

   - ie. multifd_ram_flush_and_sync() is not reusable by itself. To
make it work, we need to add a (RAM) section header to the message.
Because then it'll go to ram_load_precopy() and call ->
multifd_recv_sync_main().

   - But sending a lone RAM section header from
migration_iteration_run() OR even in postcopy_start() does not seem
right. That is out-of-place, because both migration_iteration_run()
and postcopy_start() have nothing to do with RAM sections.

   - I think  'flush' and 'sync' ought to be small individual
functions/operations that are section agnostic. We should be able to
call 'flush' and 'sync' from anywhere in the code without
side-effects. So tying 'flush' and 'sync' with RAM sections does not
seem right, because we need to be able to call 'flush' and 'sync' from
other parts too, like before calling postcopy_start() OR maybe some
other code parts.

   - Another observation is: when multifd and postcopy are enabled
together and the guest VM is writing to its RAM,
multifd_ram_flush_and_sync() is called only during setup, not after
that.
=====
2025-03-02 18:13:26.425+0000: initiating migration
2025-03-02T18:13:26.508809Z qemu-system-x86_64:
multifd_ram_flush_and_sync: called
2025-03-02 18:15:20.070+0000: shutting down, reason=migrated

2025-03-03 11:26:41.340+0000: initiating migration
2025-03-03T11:26:41.415625Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-03 11:30:22.766+0000: shutting down, reason=migrated
=====

   - If we untie the 'flush and sync' from RAM sections and make it a
general migration command, we shall be able to call it from anywhere
else.

> If you want to stick with shutdown channels, I'm OK.  But then we at least
> need one message to say "the recv side finished joining all recv threads".
> That needs to be an ACK sent from dest to src, not src to dest.

* But earlier we discussed 'flush and sync' is enough for that, no?
Because 'multifd_ram_flush_and_sync' only notifies the destination to
sync multifd_recv threads. It does not receive any acknowledgement
back.

* And multifd_recv_sync_main() function on the destination blocks the
'main' thread until all multfd_recv_threads (mig/dst/recv_x) have
exited, only then it proceeds to accept the incoming new postcopy
connection.


Thank you.
---
  - Prasad


