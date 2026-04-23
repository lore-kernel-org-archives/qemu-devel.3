Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF707F9936D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrko-0000re-QV; Thu, 23 Apr 2026 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFrkn-0000qr-6K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFrkl-0004yh-MD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776941867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xO65QkZiCOSg+fF+Bh5H2j5fVXiD/wQD6CQMVpL7xdM=;
 b=CLp6Sk2Gh6rTl0F/au4RMB+3Q4XWgXDaKALxHw/iUk9OuJe6Fnh4L9rdwaQ81KXya99VfB
 gSzc0Kk791rpIDdSp/lc2Zc6a4/pgg0Ei7p+8qwZVx59kjBUP4r09JPd8+rEymDRSF2StW
 W1m03kGPiMZ9IhzVzMEoXNAGQdQ+TMM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-eOcQ4IINN-CgpGcoS4a8Ng-1; Thu, 23 Apr 2026 06:57:46 -0400
X-MC-Unique: eOcQ4IINN-CgpGcoS4a8Ng-1
X-Mimecast-MFC-AGG-ID: eOcQ4IINN-CgpGcoS4a8Ng_1776941865
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-354bc535546so6601624a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776941865; x=1777546665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xO65QkZiCOSg+fF+Bh5H2j5fVXiD/wQD6CQMVpL7xdM=;
 b=hcTUVlLZ9ue5br81mxw5MobLkKfO3Hlov2fShxc7aF/B5XYgh354SocL9CZQ6SmGGA
 h+/heyJGqj4PzSytC4awoYraWs9n/+zoVw3a3lSwlmdMp0iN3lYXAPGVBBHllxJqwlww
 RIL+G4dJ6Z/hT+PJ/Ankt77EhI9tLfNYrbyQfo4LV8RBpZhvznq09KI1MvWzxRimCezn
 atuHIi/pGoWJaWdRMaNmXn3a9HBwqU4c8mAjuOjVtxrAvhqx72zJDK0UNWTXyTqpRX7C
 +m7RDRTUijI+wKqYhnfCS/6n+iMt2g5Wxx95HwOBQKefH2QLJ03ueU3uuB8PJxtK6fPF
 WmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776941865; x=1777546665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xO65QkZiCOSg+fF+Bh5H2j5fVXiD/wQD6CQMVpL7xdM=;
 b=VSK9p0+sJLifBOxybZULFFF07tRrKsqoQLe9EiOn0Orb5x+LNdcdeFxwf4eIeoS5/9
 4rhbYkq9UFRvF+Ud1/jOO9NUc9AAmX+afbr/ltiGu1Bw9G508RJw5zs2xInNF2iLOVlA
 ubeuF0fWi9bB15cTRx68tMMjlJLfwUZXRn4DufJWyQNQqgvHdIYZ7sMZNKZHGkDFqksM
 eHt9lCBWQd6dSQiyJb1W1nRbrE0VsBJWv8N0W+YkGwcen5h7Xp5eGPSbDDrcYDQ29qL0
 tC8StYxCsa0FdsU8cdKZCLc0SYjFJvZ8h7VEyRpF0K6iBWxNfMMX7SPP8ylXi8nVb6Xz
 +T8A==
X-Gm-Message-State: AOJu0YzHZLOI+iimxI86/9zrftho43p3E1f6S/fQTQz8eQZUsEYPDBLd
 h261Ou0ZxuOR/FfBgctZ49zpRQMJXhqXsAKW3caqVVN11/qQis1R6V7duP7ESwuet/3WTdRXGz5
 sJibhMn9v2EHtuwK3rExuyuHJ+BWWYuNFUnKQb52nScbFsNR1CiVdtbKHhwziIRIbqUJULI+Pfu
 JOkx3LbX5Xe3Uv4cuSQ4fj0LMg4k+VBebwJPRYip0=
X-Gm-Gg: AeBDieu1Pulnsz6XxpbkRUkX+8H7tlCVzJs5CCYLaXw3uc++/TBlcQrChv5nst1Jut/
 Pnrpa3KlGe7AGLwdWogwwiuRG8mEUyogSx+1iR52+q31cTdBgN2o3Qq4JxshZQjh3VRyx1ACL/J
 W7iZhdOp7GpXoHTi4XCJgTi/16dKGyJt3dOkpgjms+4o/qOlgH+zq/oasZxkWYj1tCs+ZHbjNHg
 RWz3euTXFBp0sSXOPoOYmnilOJSCnjfoXfV0zl9csJOtFHcVyEvz8IQ6UEerG52KmySAKclp6pQ
 mZcJOljSqOGEyH/1kv9NdBMr0loe8sr3Pn7YQXJlcmgyNcQDnJ4OxyQK3Dvwgq4CgYm5CJ07oz/
 IVTquoGp8so9snE4Li1itXUY7u9Ge7q1NQE61aiV6fNCn5iuCt1NFMAwNL73PaUAtWgODjShhOA
 ==
X-Received: by 2002:a17:90b:2892:b0:35e:5ae3:2993 with SMTP id
 98e67ed59e1d1-36140462ae6mr25545164a91.15.1776941865036; 
 Thu, 23 Apr 2026 03:57:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2892:b0:35e:5ae3:2993 with SMTP id
 98e67ed59e1d1-36140462ae6mr25545142a91.15.1776941864415; 
 Thu, 23 Apr 2026 03:57:44 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc575bsm19835240a91.4.2026.04.23.03.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:57:44 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 0/2] migration/vmstate: Add VMState support to safely
 migrate GByteArray
Date: Thu, 23 Apr 2026 16:27:31 +0530
Message-ID: <20260423105733.113046-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In GLib, GByteArray is an object managed by the library. Currently,
migrating a GByteArray requires treating it as a raw C struct and using
VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
ui/vdagent.c

QEMU cannot pretend that GByteArray is a C struct and simply use
VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
overwrites the data pointer with a newly allocated buffer, thereby
leaking the previous memory. Besides, GLib tracks the array's capacity
in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
sync with the newly allocated buffer, potentially leading to heap buffer
overflows during subsequent g_byte_array_append() calls.

This series adds a new VMState called VMSTATE_GBYTEARRAY, which will
directly use GLib library API calls to create, or resize the object.
This is then used in ui/vdaagent.c replacing the use of
VMSTATE_VBUFFER_ALLOC_UINT32.

Changes in v4:
- Applied Peter Xu's feedback: unwrapped GByteArray pointer immediately.
- Removed redundant assert() and ternary logic.
- Removed unneeded len>0 check around qemu_get_buffer and
  qemu_put_buffer.

Changes in v3:
- Add assert() checks to get and put functions to prevent NULL pointer
  dereferences, as suggested by Peter Xu.

Changes in v2:
- Marc-André pointed out the problem of not updating the device state
  itself. To do that we should essentially pass a pointer to the
  GByteArray pointer. Remove VMS_POINTER from VMSTATE_GBYTEARRAY. This
  changes 'pv' to be the address of the pointer field (GByteArray **)
  instead of the pointer's value.
- Update get_g_byte_array and put_g_byte_array to handle this additional
  level of indirection, allowing safe allocation and updating device state.
- Link to v1: https://lore.kernel.org/all/20260406115247.4879-1-armenon@redhat.com/

Arun Menon (2):
  migration/vmstate: Add VMState support for GByteArray
  ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate outbuf

 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 28 ++++++++++++++++++++++++++++
 ui/vdagent.c                | 13 +------------
 3 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.53.0


