Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F453C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrk-00006W-Fi; Mon, 27 Jul 2026 15:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQri-00005T-Ba
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrg-0000Lr-Op
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1895M+UpGSv0E/zHw1pl3GXC82tC3h2kRRWVl1rs6Y=;
 b=hSR+iYgyyUbCb4mXtmq3cM3azKlEb/fdXmeWjZxtN9pFet1KAJum1e3csZj62lq9JmuALu
 05cVB3P5UCYtcUIp+Z2qrvey+zsplHiBlL7x7qH7+yBIe6bjBOHewkxGecogX1J85gWRQj
 0zN7TP1uojp2xT6KIJ+qI6Z0ufdbFnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573--70U5AniNjm_OXEtngPlwg-1; Mon, 27 Jul 2026 15:19:50 -0400
X-MC-Unique: -70U5AniNjm_OXEtngPlwg-1
X-Mimecast-MFC-AGG-ID: -70U5AniNjm_OXEtngPlwg_1785179989
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so1795193f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179989; x=1785784789; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y1895M+UpGSv0E/zHw1pl3GXC82tC3h2kRRWVl1rs6Y=;
 b=mU823NB3eLHO+P+c3DqEnGRE7ooVlofg6/av7jjqjm+qA31itNVt0HTwrIs3qmfMpE
 DCLBfP6P8XVvB6Yc737JmTqxGDUzn5kubn3lhCvhqVJOPuwQWKZbwbUSbEdFxYI5Kv6l
 AWNdfnTkwosXq1uHCht1RTPAXSto+DEL2HjhLCRl5aZ/kVpRw+yzymZnzwcvRyAnez/y
 +b0O3YIrJGuQWqKNc5K39jRvLJeZSzh0hcOvadPSjetOTYfGFXkTspmXmfLd35C5yXax
 42pl2oBFuVh0FJrkeQjXCUCcAl/n/4KGlisxXcKp51gdDqzp1VRL8vrGfKRIWHS+7OXk
 7nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179989; x=1785784789;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y1895M+UpGSv0E/zHw1pl3GXC82tC3h2kRRWVl1rs6Y=;
 b=ccoTc13eSA2jE/VYJ9glmnvOVTzzTPry0vPdfVCVgwKFWBDSWnJ522Dm70ATtUxyp+
 2qDOcyA9y+1ms/Vs3lbMyzE3D3S4Nn0KDBGNjy0UeqiBVYjmxsJ13uHUHSAyeqKj7IaM
 fZEmM1MPA5ojkbfgUxHCO5VyWGMdlubfTacvNcwzHeIPPZeTPF1H5MUYDf2dHeo4xbxq
 +SfWIK6A0ppI+9wMaAOugpTaNSMfp5/l+hZ4EJJ1QmGBB5++Qxku8JjCs01SflYF83TQ
 Cm819PuEiOxNIkpwpEuuSekmauaNMdPbbISCKal54rUYNDT4X93PqKXI2fd98KKgY6P4
 p1CQ==
X-Gm-Message-State: AOJu0YxLAjZ8rdvL421CSpsBVVxIQ987bbIUkjz3VNAxfgRhtaIeINQ8
 5xnHXzyPSLFDzae5n8iKsyU+pmKgqBFqFwHuSmDl+Ma/MXQ4SRydNjWxfQJ+BZk/2vpLpVx6+Ki
 AnDTChWsN1FxDUfCi72/jyxL5bs7jWzXg/REsqL2Zartsg1rOTEU6e7ufKomjjpEzRfQaR7RAn8
 SaAnRBmHPHk/xK4bOqsqy+ugE5UKUOBEm0Ag==
X-Gm-Gg: AR+sD10lXS+vTXRXmttHi/zSBScQZYX8zVTtfb/TIh7fNqOhEfUzMTM4HiiYAV9+oGu
 KrWAsHcEhulKWhtU1XFgkKE5JzuddWkD/Gh6Zo3Cr1H+FTUB380VU0LQG6GD21LL5L2xRPxFPMD
 qwRJ83+kt0yJtXl1lz6qKsyu/D2+gl0n3zumNJ03ODIkUSAwzsc3NAB8k9wyHR5EvZR/qgR8HWs
 onFSG82PsT+hdJRBArQ1zurpLYTr9PqSjfKPu2fPMow/KduyDpVtRlSzIo8YeHEH47Gtl2HDbOs
 qeV3QWyl0EwIxzvtH8nHOB3ImpwajwJukUI5U1UK8R9nYx2F+btIVZUuEXDy1XZVhwv3VfXkgEU
 jm0yzR5lh0YzW6QfhNaSS1g==
X-Received: by 2002:a05:600c:5487:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-496b57170aamr112086845e9.9.1785179989350; 
 Mon, 27 Jul 2026 12:19:49 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-496b57170aamr112086475e9.9.1785179988780; 
 Mon, 27 Jul 2026 12:19:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45e0424sm14762205e9.13.2026.07.27.12.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:48 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xlabai <xlabai@tencent.com>
Subject: [PULL v2 05/30] libvhost-user: protect against OOB vring queue access
Message-ID: <758ef96a2dba157e930af7709f327435a153f7a3.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SET_VRING_NUM, SET_VRING_ADDR, SET_VRING_BASE, and GET_VRING_BASE
handlers all use the queue index from the message to access dev->vq[]
without checking that it is below dev->max_queues, so a malformed
message causes an out-of-bounds heap access.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3741
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: xlabai <xlabai@tencent.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <dbba777b25f86587c8d131891a2b4b2be97e5c5b.1784899069.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 28 ++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8208265588..42a5e2f1f5 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1200,6 +1200,12 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_num index: %u", index);
+        return false;
+    }
+
     dev->vq[index].vring.num = num;
 
     return false;
@@ -1210,7 +1216,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     struct vhost_vring_addr addr = vmsg->payload.addr, *vra = &addr;
     unsigned int index = vra->index;
-    VuVirtq *vq = &dev->vq[index];
+    VuVirtq *vq;
 
     DPRINT("vhost_vring_addr:\n");
     DPRINT("    index:  %d\n", vra->index);
@@ -1220,6 +1226,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", (uint64_t)vra->avail_user_addr);
     DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->log_guest_addr);
 
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_addr index: %u", index);
+        return false;
+    }
+
+    vq = &dev->vq[index];
     vq->vra = *vra;
     vq->vring.flags = vra->flags;
     vq->vring.log_guest_addr = vra->log_guest_addr;
@@ -1256,6 +1268,12 @@ vu_set_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        return false;
+    }
+
     dev->vq[index].shadow_avail_idx = dev->vq[index].last_avail_idx = num;
 
     return false;
@@ -1267,6 +1285,14 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     unsigned int index = vmsg->payload.state.index;
 
     DPRINT("State.index: %u\n", index);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        vmsg->payload.state.num = 0;
+        vmsg->size = sizeof(vmsg->payload.state);
+        return true;
+    }
+
     vmsg->payload.state.num = dev->vq[index].last_avail_idx;
     vmsg->size = sizeof(vmsg->payload.state);
 
-- 
MST


