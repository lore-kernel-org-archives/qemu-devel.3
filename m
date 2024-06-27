Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2C2C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqIX-0005Yc-Qe; Thu, 27 Jun 2024 10:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqIW-0005YS-Bb
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqIU-0001TK-Fx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719499224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNS6+eD17aoggtkGeNKsZKY+U9f9/42f6AmkTfqSuFs=;
 b=Pl//KFZNu9AXDSVdKchb2kyhA5OZXlINMZ2nLRXx0jmStqKNeuqvUk1mOKNQ+RWbO2h1ba
 sT+k0M2wFi2OxKIhwjI5fgfkkypiP9qmVNDe+0kxAVn/Y84tIWgOZ38PG+YKFpMv41iZL+
 Dt4HLXzpnxP/pomiw/6p4oGLwSHP3SI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-guhVnPhJNMy1XKi-cJN2nw-1; Thu, 27 Jun 2024 10:40:21 -0400
X-MC-Unique: guhVnPhJNMy1XKi-cJN2nw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3d5668f8e8fso214532b6e.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719499221; x=1720104021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNS6+eD17aoggtkGeNKsZKY+U9f9/42f6AmkTfqSuFs=;
 b=gzYH4G4VkdZQy+LwOMW4/pMyEROcTglYKAM14TmJ40Gz9qQyn+MxLkjT/84a54fuBZ
 AanvkTuuqbxczFSdLot4QOE4ymBbfveH9XuLnZtoARF0WNGdCMvZbAcq//yWiCSFxDik
 f0bFzlVEqMxAgU4ODK5f2nFxiGS8HcDYwYiy+rR2R/5FQxjWSdYtzCjblvxy6hXVdojw
 HM5mtfQuDpXCPHAz+87ciI1cKzupTsgmBnvsVYRonqqAkK39KCB0V9jCg2ItaPxjeG9P
 jO0Ni2MZ75xgSz3b7mftVF+4lyQtj7aZ/UInEfpD4D8r0p+ziJ3s3YW6EQirkBgTaLMe
 zxHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+0kQC4Cm5Z9c4fq05a2zAKCn3A5c6pz5VqsogF9gUXK416ydwoNHj4YusY24W0HKmtv3Xx9QVYbvSI/fH7He3VJUyX94=
X-Gm-Message-State: AOJu0YxYO+f3+Pdq0ZH0BLbvEU5dR9fQuLo1xfmWbhP+qhY9qM3Muway
 4FoSdSVs06Y4GQJwTYNraVGhBurORQJUZnXZBe3ClJHHobluoL3k+t8tm7FdzbWBmOG9Toi0iEV
 QNsUy1X9limDWudzuBzq0iH7SBivPOttmh/4X63GkDcCvp+i59RJH
X-Received: by 2002:a9d:6244:0:b0:700:ca11:1158 with SMTP id
 46e09a7af769-700ca11150cmr8425176a34.1.1719499220417; 
 Thu, 27 Jun 2024 07:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnGVqjt5jyuh/Rcg6XrCepScOi39OZ3GnxR9vpjBXuRdgOCu/89PlqwxAq4J3nbLXe3jzCdA==
X-Received: by 2002:a9d:6244:0:b0:700:ca11:1158 with SMTP id
 46e09a7af769-700ca11150cmr8425131a34.1.1719499219590; 
 Thu, 27 Jun 2024 07:40:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59292874asm5489036d6.145.2024.06.27.07.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:40:18 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:40:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <Zn15y693g0AkDbYD@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Thu, Jun 27, 2024 at 11:27:08AM +0800, Wang, Lei wrote:
> > Or graphically:
> > 
> > 1) client fills the active slot with data. Channels point to nothing
> >    at this point:
> >   [a]      <-- active slot
> >   [][][][] <-- free slots, one per-channel
> > 
> >   [][][][] <-- channels' p->data pointers
> > 
> > 2) multifd_send() swaps the pointers inside the client slot. Channels
> >    still point to nothing:
> >   []
> >   [a][][][]
> > 
> >   [][][][]
> > 
> > 3) multifd_send() finds an idle channel and updates its pointer:
> 
> It seems the action "finds an idle channel" is in step 2 rather than step 3,
> which means the free slot is selected based on the id of the channel found, am I
> understanding correctly?

I think you're right.

Actually I also feel like the desription here is ambiguous, even though I
think I get what Fabiano wanted to say.

The free slot should be the first step of step 2+3, here what Fabiano
really wanted to suggest is we move the free buffer array from multifd
channels into the callers, then the caller can pass in whatever data to
send.

So I think maybe it's cleaner to write it as this in code (note: I didn't
really change the code, just some ordering and comments):

===8<===
@@ -710,15 +710,11 @@ static bool multifd_send(MultiFDSlots *slots)
      */
     active_slot = slots->active;
     slots->active = slots->free[p->id];
-    p->data = active_slot;
-
-    /*
-     * By the next time we arrive here, the channel will certainly
-     * have consumed the active slot. Put it back on the free list
-     * now.
-     */
     slots->free[p->id] = active_slot;
 
+    /* Assign the current active slot to the chosen thread */
+    p->data = active_slot;
===8<===

The comment I removed is slightly misleading to me too, because right now 
active_slot contains the data hasn't yet been delivered to multifd, so
we're "putting it back to free list" not because of it's free, but because
we know it won't get used until the multifd send thread consumes it
(because before that the thread will be busy, and we won't use the buffer
if so in upcoming send()s).

And then when I'm looking at this again, I think maybe it's a slight
overkill, and maybe we can still keep the "opaque data" managed by multifd.
One reason might be that I don't expect the "opaque data" payload keep
growing at all: it should really be either RAM or device state as I
commented elsewhere in a relevant thread, after all it's a thread model
only for migration purpose to move vmstates..

Putting it managed by multifd thread should involve less change than this
series, but it could look like this:

typedef enum {
    MULTIFD_PAYLOAD_RAM = 0,
    MULTIFD_PAYLOAD_DEVICE_STATE = 1,
} MultifdPayloadType;

typedef enum {
    MultiFDPages_t ram_payload;
    MultifdDeviceState_t device_payload;
} MultifdPayload;

struct MultiFDSendData {
    MultifdPayloadType type;
    MultifdPayload data;
};

Then the "enum" makes sure the payload only consumes only the max of both
types; a side benefit to save some memory.

I think we need to make sure MultifdDeviceState_t is generic enough so that
it will work for mostly everything (especially normal VMSDs).  In this case
the VFIO series should be good as that was currently defined as:

typedef struct {
    MultiFDPacketHdr_t hdr;

    char idstr[256] QEMU_NONSTRING;
    uint32_t instance_id;

    /* size of the next packet that contains the actual data */
    uint32_t next_packet_size;
} __attribute__((packed)) MultiFDPacketDeviceState_t;

IIUC that was what we need exactly with idstr+instance_id, so as to nail
exactly at where should the "opaque device state" go to, then load it with
a buffer-based loader when it's ready (starting from VFIO, to get rid of
qemufile).  For VMSDs in the future if ever possible, that should be a
modified version of vmstate_load() where it may take buffers not qemufiles.

To Maciej: please see whether above makes sense to you, and if you also
agree please consider that with your VFIO work.

Thanks,

> 
> >   []
> >   [a][][][]
> > 
> >   [a][][][]
> >   ^idle

-- 
Peter Xu


