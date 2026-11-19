Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFF60A2614
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R+AonUvC;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jw836XkO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyk9-0005zq-Uh; Thu, 19 Nov 2026 04:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjp-0005kA-JF
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjm-0006OB-GD
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNbyFIDODwI06hCwH9i3quh0ISVp3K1bMaePzo6+Uh4=;
 b=R+AonUvC56CD3KqhoAOyaYvwfZxY6OB/VYdXx7MOEVqA65mTRgIlPwQmU5Z9ELa5823h/k
 neDufM2ftzcY4iKcuYX2a0XO9m+xVfq8KvUjAnjaHxoVdVr3bmTlGdU5vQ86nH+glyjj2X
 bNWsEB21+0UqlDYxvyjx+iUBANjRgDw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-pWIqr7IpPZmtgQsyslIDfg-1; Thu, 19 Nov 2026 04:47:24 -0500
X-MC-Unique: pWIqr7IpPZmtgQsyslIDfg-1
X-Mimecast-MFC-AGG-ID: pWIqr7IpPZmtgQsyslIDfg_1795081643
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4a799d93bc3so757766f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081643; x=1795686443; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CNbyFIDODwI06hCwH9i3quh0ISVp3K1bMaePzo6+Uh4=;
 b=jw836XkObx0ADIn1NmyyKq87f/n+vLE+P/c3kJbpQnA+hrLtDAgmzM2qt8yqQdqS49
 0rhCVivQDGxGwnLfUpVGF5fpGRamcM4bryMwovxFIeNzrQqMwHFsIE4t++eLRBstUDAg
 dRJ/UrhOXFiHhARiFEj+V6ueDHoBtbLk98OLi5kV5/unm7StnDTqeIAwV6SkfxWSuMBl
 CllA+uF2aSOGV9M8vXI2uW1LeHNDqQfZ/gR1u2y/sPQV60YLvFXlsduK135KM03+iQsg
 K1oWMO786QjqjgVARL4xK7fPsxFYak0nWwi7ImOhu6UrRObLgB4eaEfX8bIfoYeJpTwx
 68Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081643; x=1795686443;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CNbyFIDODwI06hCwH9i3quh0ISVp3K1bMaePzo6+Uh4=;
 b=rnusSzPvPAm+VKLWE35TGqziwn/k0IlheaeEbuyLCXjviaYHF0fa+NT2b3uiCNnll2
 97BSnIFJyk2egdgqKr1Z5YLzGbDwkdTQAKEQ6DDZT498aRi+gSczzrQbi5j3S/I/Mrup
 dyHTew+bH3prZp9wZoRoK+IbEXuCVXF/PcEHQLJ4mq88MEW6jmwOfNkPiST14hBjgeRs
 nuUWzx9SuHV5b4VKpyJhdNCfDdpQw/Y7jq998biLCSiakJmXgxXO9A/qeGvSW8RmHSN0
 DBnKBt/P/EtSGYpgOQspuga4z3DkkXlV1cLGuzePaoBvkooCHOqxN7JNeNnYPBzOeloS
 v7+w==
X-Gm-Message-State: APuU4Z8OMQ257a91xPe5vlThROOKXNMuOT/lcoq6hehl5TJyvtEWWrEx
 ETV9VGORctPppzfiMN9iv29SUtloOxJTwl6MYswvFx3Zd9GidLnW4SLIYXqvPULEvMQvFAwS6eN
 gV+dtpRHSMmMxY5l21hrhvoM7Ce3dwyujl8vuHjT9IOm8LVh/qpbvNdjxN68lWMH1wC8VycxWl4
 XEakXl4a7yRK5zBksdyWNTklosFKd8vCrBog==
X-Gm-Gg: AYBFou3xeM7tXiAGATPGej3bo8UiFquF9wf8PMw10dmMH2UoUnbnc9TvgAHQj70jFMU
 Lz55nSESpUC92/6F8QXz93b3G6PTiX2YJEr/DZr8lPpmUSL8+JgHNv2zuxgbs5Ei0QPyQO8JDcG
 Iekk1Ru4XhUNkdYNd+qy8GkP2XwSVGPRPGDxWWQOvOJh2K7GbdCkr0viIHfpG5wE0xXaHJK8eKe
 PS6nLKByu/90pW91ih9TELmGVfXjpCa+QbjjskXdQMKRuFfWFHSy3oS2r9e38ANEGGqPcRZIplN
 T71AmVHkKTBzq8wz7+GoXcV2MAo4kaAxppEraGkBsNeuRX64Eos/XmVXCbrRFvALPhgohdtsGto
 syYZvo/yA8X0hxQ3f4dV3U2tt6+FaqOM1LsMRcQom2KQ=
X-Received: by 2002:a05:600c:6290:b0:4bb:7b4d:6396 with SMTP id
 5b1f17b1804b1-4bb7d6cd4f3mr106643635e9.3.1795081643154; 
 Thu, 19 Nov 2026 01:47:23 -0800 (PST)
X-Received: by 2002:a05:600c:6290:b0:4bb:7b4d:6396 with SMTP id
 5b1f17b1804b1-4bb7d6cd4f3mr106643135e9.3.1795081642490; 
 Thu, 19 Nov 2026 01:47:22 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm24935355e9.1.2026.11.19.01.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:21 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Simon Lucido <simonlucido@meta.com>,
 Stefano Garzarella <sgarzare@redhat.com>, vhost-user@lists.linux.dev
Subject: [PULL 6/8] libvhost-user: return the backend mapping address for
 SET_MEM_TABLE
Message-ID: <9a90624000367faea6f2809d1f21b9d7d168031c.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Simon Lucido <simonlucido@meta.com>

During postcopy, the vhost-user backend ought to return the base address
at which they mapped regions during SET_MEM_TABLE and ADD_MEM_REG calls
[0]. This was done properly for ADD_MEM_REG, but not for SET_MEM_TABLE,
so any frontend that was relying on that call would not work.

The bug appeared in d288eef3a0a8, which, to silence the
address-of-packed-member warning, created a local copy of vhost message.
That's fine for reading the table, but for postcopy, we also write into
it to send the base addresses back, and after d288eef3a0a8 we ended up
writing into the copy.

This bug was affecting ADD_MEM_REG and SET_MEM_TABLE alike, until
905e8c7e260d fixed the ADD_MEM_REG path by copying back the memory into
the payload.

This commit fixes the SET_MEM_TABLE path by doing exactly that: copying
back the memory table into the payload.

QEMU wasn't affected as it uses ADD_MEM_REG, but any combination of a
frontend that uses SET_MEM_TABLE and libvhost-user backend is.

[0]: https://gitlab.com/qemu-project/qemu/-/blob/144393da8d4bd307a22525c7feea2bb29a0a7556/docs/interop/vhost-user.rst#L1263

Fixes: d288eef3a0a8 ("libvhost-user: fix -Waddress-of-packed-member")
Signed-off-by: Simon Lucido <simonlucido@meta.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261112-setmemtable-fix-v2-1-b38ee27e8f19@meta.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 52817cc733d..df215810339 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1119,6 +1119,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     if (dev->postcopy_listening) {
         /* Send the message back to qemu with the addresses filled in */
+        vmsg->payload.memory = m;
         vmsg->fd_num = 0;
         if (!vu_send_reply(dev, dev->sock, vmsg)) {
             vu_panic(dev, "failed to respond to set-mem-table for postcopy");
-- 
MST


