Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB0C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 23:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf7AI-000858-7G; Tue, 27 Feb 2024 18:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rf7AC-000807-JZ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 18:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rf7AB-0008PL-6c
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 18:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709077625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JOdeJ2AByoV4xIihXvXFwsovQzSxy/xY+A8jgDiw1iA=;
 b=BO4nEcQqIKLXmA2qQhMhASHFx1AdkH5ai+DYFdjnZH2OcAQRiOGScIFvXCOXbYT/aCqh7D
 QmLMngQAmXwQSX/+LK5E5CSjs51t/+uk1+g9T3sB9++5A62d/vrmVcz/W3RQOIhNg35UeR
 JYOPEgXPEMedzZnuSQ4MhuN62CaMYYs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Bc5r2gNUPFiHkAAXxqP9Iw-1; Tue, 27 Feb 2024 18:47:03 -0500
X-MC-Unique: Bc5r2gNUPFiHkAAXxqP9Iw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so1639145a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 15:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709077622; x=1709682422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOdeJ2AByoV4xIihXvXFwsovQzSxy/xY+A8jgDiw1iA=;
 b=Fwl5tjUzgDg8kUYMzplfwDzIapVqbiylTZ7KDUCpvBIVi6ZE1x9uIOBpxizKWsFeG4
 KRhkZFxijvbxPUMMWZdM4Ut9B8JMvCRJHJw7X22diODgl2+XcWEy6qcoPYcTZziF5xZq
 MQpGvAenv7rSUfpgjqeeh8mlGE3dHnG47pUuHgiu6XypbiZaE6r/wQ7TeErhaGsRxH07
 tpOmp4vnrtxZvGH/dWY3o0mWiIkC6G4K/9XzuKgyxxQsdJLec7V0c6M5XUVBlxSgv24X
 HWIb/CKih8pCYOWfAwVX1HNABxAiO8qywPz4P2p28TX0BJj2Hos75jYhF6MBIc859euU
 I5Ng==
X-Gm-Message-State: AOJu0YxCum3qi/Tm+/JFRBl0RIVmAvHPeFBXs/TUEej4p/C/z1KYFVdw
 zkvauc9NncTbeT8Xivbf2jRg/yktcvJ04RHUvxkaRn/TWqbndLxrLXxoDfTk81fQtwZPcb20R4E
 VlfaNvftBacqcXlYxpBIG58bjiYs01RCeAxQWvhTpTB35FRqJ6MQW
X-Received: by 2002:a17:903:41cb:b0:1db:a770:81a4 with SMTP id
 u11-20020a17090341cb00b001dba77081a4mr12090122ple.1.1709077622120; 
 Tue, 27 Feb 2024 15:47:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD8KduqWaySWufJYnfjEWUQ2awFF9KnzjJDYtd+hODh8qf20lJC5J/I/EsFM9oA8gPstXBuA==
X-Received: by 2002:a17:903:41cb:b0:1db:a770:81a4 with SMTP id
 u11-20020a17090341cb00b001dba77081a4mr12090110ple.1.1709077621745; 
 Tue, 27 Feb 2024 15:47:01 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l8-20020a17090270c800b001dc23e877c9sm2066648plt.106.2024.02.27.15.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 15:47:01 -0800 (PST)
Date: Wed, 28 Feb 2024 07:46:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 22/34] migration/multifd: Prepare multifd sync for
 fixed-ram migration
Message-ID: <Zd50bQE42Qt6VR5n@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-23-farosas@suse.de> <ZdxCLmKFirsXPia-@x1n>
 <87y1b6alej.fsf@suse.de> <Zd1cj4jkIpUktu6k@x1n>
 <87plwivwfn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plwivwfn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 11:00:44AM -0300, Fabiano Rosas wrote:
> I don't really like the interleaving of file and socket logic at
> multifd_recv_sync_main(), but I can live with it.

The idea was to share the "wait" part and the semaphore.  If you don't like
the form of it, an alternative is we can provide three helpers (file_kick,
wait, socket_kick), then:

  if (file) {
    file_kick();
    wait();
  } else {
    wait();
    socket_kick();
  }

> 
> Waiting on multifd_recv_state->sem_sync is problematic because if the
> thread has an error, that will hang forever.
> 
> Actually, I don't even see this being handled in _current_ code
> anywhere, we probably have a bug there. I guess we need to add one more
> "post this sem just because" somewhere. multifd_recv_kick_main probably.

Might because dest qemu is even less of a concern? As if something wrong on
dest, then src is probably already failing the migration, then libvirt or
upper layer can directly kill dest qemu (while we can't do that to src).
But yeah we should still fix it at some point.. to make dest qemu quit
gracefully in error cases, and it'll also help more in the future if
multifd will support postcopy, then both src/dst can't be killed.

-- 
Peter Xu


