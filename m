Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F19EDA694
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSQl-0001B2-GJ; Tue, 03 Mar 2026 11:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSQV-0000pM-BR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:16:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSQN-0006PD-ME
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772554594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PEih3AzcQVei/KMb19KLXPvqfhHw7CxukldISfW6khE=;
 b=RQAkqokP20uA8fOtSOnq31neJcBldaoGVEYCKElIs5mXAqbATjyoqqIzCZCsDf6tgEY0CA
 BXstc0IGt1jAncYXvsAMbzOEgGzZtEmuPkbbpuVvHPq3qLtDCCeYOYj4uXJEGKcUCoFVt5
 7LxPTwyrrotCOitV9RgeacNkvVEOQlM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-lMZ-bJ_rPD2Blh1Yk1viqA-1; Tue, 03 Mar 2026 11:16:31 -0500
X-MC-Unique: lMZ-bJ_rPD2Blh1Yk1viqA-1
X-Mimecast-MFC-AGG-ID: lMZ-bJ_rPD2Blh1Yk1viqA_1772554590
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb3d11b913so3888674785a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772554590; x=1773159390; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PEih3AzcQVei/KMb19KLXPvqfhHw7CxukldISfW6khE=;
 b=gUKDJFYbKjOWi8XuNxMF1VjWm9CtbL+AObS0Y5Qdkk1tZk/ntY0q968YWNlr+7DKW1
 CCozN7wh1aCNoAMluH+9Kh4xxdAqzCUR0Q7t4qh1B23yBlKUBzT2LnPnNj2b8qNEPf4O
 Fr858g7Gco9KBZgFjFw4fAvDZF9bPq3qW7Xhfm7fW1D9Mat7Df/1f9c5+EJhAulFnVVj
 nnASTA4L815AfsS2zxMQoWG50M4FdWGKzB5ROoIwEOqM9syA0mMU7w7tz+IVBAOARTt+
 AgFBJ3mqq07V3aaMCe9saBE7QraeyWfEkBQU0r6v4Vd6mfyA5iygloonATF86/QjQtw3
 bn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554590; x=1773159390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEih3AzcQVei/KMb19KLXPvqfhHw7CxukldISfW6khE=;
 b=mnJshRWb6VeHefS41uj2d7etx6oCvAFPmzB+mHWpx6/6xuYBcqEHcqwBhSKxqTqosB
 M9iTttqdQcSEgM0vzduOKkmMM4nalqhxoLbndmwAEG8UitwYs8brACNsnw1v8GDsK2f/
 3t8gRQOeTP5t+9UzuEbJhp+xrtgthRRGNs+PbJHBV49seggkpRuqatOvIEdN8lMWR1Fw
 ong13TQN3/FqwWp5QMm4a7lAUw9Qee6zUygiSQficoUMujH/NstTLpuvR4pwsRIvgca6
 twB6a9crER7ujPu3UmkFBup4/rLh5QtRNec+DVhOrBVqLYsi41X+Y6o/zBPcNvEJSvOf
 CPgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQSpYMpOblcJlxW1AIWWAkrMwGdk1fMqNq9ga3ZaqiY+uTD5oyCNS7WjakrO4EEmREFB2JnXLJ4aeP@nongnu.org
X-Gm-Message-State: AOJu0YyGfr7u1NEqHgqDyhV059kvJcifEFVm+kZBBSkr9bwwatL6e/0M
 S6gTbpdY60hsrgXE/JY1GmsDPSeIsANJKbOYrF6eorXXvMeksOSZC2TPFUcPkOMEipg8EeTlXjd
 fZ+GNqZHsyfSAZUM+j4UHKEP5NfqWFf6neFuo+32BdAC8urWzmGIdsWfv
X-Gm-Gg: ATEYQzwO8bbaBBZ73x7WonZNC1cdjaUubK+pp47rxf/dH3KSas17ch/J3wvjnS8n/65
 /GNpMnFx/vEiRyCbnTFDHAPhiEz4AX9e1/vPUAzbJF14rB45Z7RqE54N+4RV6LNlmWmsnBQMXel
 6T7AoIS1K15PYpA/cnSO7/yqQDV5M6nwvTu0//MxxpUaHoKzQO4tqA97rN1veCqfbjk9NK8iU+2
 Im1ztLloFAQKwnGtuTJHPQJhAnLhK1dZK0/RbxkDlrUWe3Uf79aN8qO1tJrDXLx99XbcsT0vgPb
 EmBtG0B5qLt/YcQ+eaCFjmqga31+U9hqD8pGSbstK2JIiJHGdsuiOp7Af/xbrWh6XrIAaYAsYlG
 TpgYh3ZBajXKPaA==
X-Received: by 2002:a05:620a:4041:b0:8ca:2cf9:8198 with SMTP id
 af79cd13be357-8cbc8e4b61bmr1985538685a.40.1772554590433; 
 Tue, 03 Mar 2026 08:16:30 -0800 (PST)
X-Received: by 2002:a05:620a:4041:b0:8ca:2cf9:8198 with SMTP id
 af79cd13be357-8cbc8e4b61bmr1985534285a.40.1772554589868; 
 Tue, 03 Mar 2026 08:16:29 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66c515sm1433247985a.11.2026.03.03.08.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:16:29 -0800 (PST)
Date: Tue, 3 Mar 2026 11:16:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 10/16] migration: factor out vmstate_post_load() from
 vmstate_load_state()
Message-ID: <aacJUizUH0lWINE_@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-11-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-11-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 21, 2026 at 12:02:08AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Simplify vmstate_load_state() which is rather big, and simplify further
> refactoring.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


