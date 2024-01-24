Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8538EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSSCB-00083q-Us; Tue, 23 Jan 2024 20:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rSSCA-00083S-DC
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rSSC8-0004tm-Ns
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706060207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLQ7etTJN6X8ECNfO9QO2r/aTw82hLziht+HY9KFy/o=;
 b=iw8Y0aSvZu6+Dlt8Ys6MR+xFr1d/UcSrkTvwfPdgMOXVpDUcB//sKyPRzaTrbYYn7UQ2vF
 isqwdITFdqNozfQRQ1UTCDTXpNLZesbDGZIPI5rB+343Uic3P1X4vDAFycwALRhb6+KEPW
 8kePzGIA9PUZji7rUXWlz7MuV4dVTBM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-G3EQRtSpNJ-FaLH3-aVGPg-1; Tue, 23 Jan 2024 20:36:45 -0500
X-MC-Unique: G3EQRtSpNJ-FaLH3-aVGPg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d9b3a964a1so1749280b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706060204; x=1706665004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLQ7etTJN6X8ECNfO9QO2r/aTw82hLziht+HY9KFy/o=;
 b=ih9QJk8fI4jw+STZE50dBc5GxJf3I4H0MjSbOFPWatC1VJRTdPFy/aJKQ+j2GwN77u
 el0o8uJZwzSQLRtYxJ9qw75TEJRzgMpCx2MTaIkhkAlc+IWl4HbKjILobag3zXS+E8AG
 qINgH4U/88A7f8XTGohFrvQPrXXUO7TMzD4r1FQV9Hphw/JGt530dDIQeDsVavPsKUVL
 EmJUsX0LdTc4p30ZzYjt1NWmR3yU2PBB3zC/6rl7RU9kESSE+QqhREEUqPrVFFgfANGY
 y2Ij1vJrAApxyZw+FYJVlgc4PO7+xBhJlOJPq6lsO+s09PNkZ/oQL/4sUakXc5X35JCf
 stgA==
X-Gm-Message-State: AOJu0YwCylsjdbA40bv/v1fStg+YJSKYNR+RYru2TEGtjZZkfGxh4ucw
 dZ6SYgl25nRz6irsZghZREnl1f+Zk/VW0CivkFLEMgL1ioyvfJNrVlMPdRIv4bodhar32qXRSCm
 nGJURASWVryaMXDA9tir+fVdrpE+Nj6dGYrFCAwNbtzx6N/lzz4u7
X-Received: by 2002:a05:6a21:3991:b0:196:16b0:c554 with SMTP id
 ad17-20020a056a21399100b0019616b0c554mr16805362pzc.5.1706060204187; 
 Tue, 23 Jan 2024 17:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoiDyagALzGkkP8fzpzUOMt86y8Vsyh2xG+bNtzyqZ6cSQXq9oYguebqopLpH3racKjd+SLQ==
X-Received: by 2002:a05:6a21:3991:b0:196:16b0:c554 with SMTP id
 ad17-20020a056a21399100b0019616b0c554mr16805345pzc.5.1706060203851; 
 Tue, 23 Jan 2024 17:36:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i24-20020aa787d8000000b006dd8532765bsm846707pfo.191.2024.01.23.17.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 17:36:43 -0800 (PST)
Date: Wed, 24 Jan 2024 09:36:37 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, het.gala@nutanix.com
Subject: Re: [PATCH] migration: Plug memory leak on HMP migrate error path
Message-ID: <ZbBppQ_4sfyYgl4n@x1n>
References: <20240117140722.3979657-1-armbru@redhat.com>
 <CAFEAcA-tX=GPm1zDq5pnL+T_cbivKUQ1dZe_vQ0XAjvehWLdpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-tX=GPm1zDq5pnL+T_cbivKUQ1dZe_vQ0XAjvehWLdpQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 04:33:43PM +0000, Peter Maydell wrote:
> On Wed, 17 Jan 2024 at 19:49, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > hmp_migrate() leaks @caps when qmp_migrate() fails.  Plug the leak
> > with g_autoptr().
> >
> > Fixes: 967f2de5c9ec (migration: Implement MigrateChannelList to hmp migration flow.) v8.2.0-rc0
> > Fixes: CID 1533124
> 
> Isn't this 1533125 ? 1533124 is a false positive in
> the migrate_mode() function.

Indeed.. I fixed it in the staging branch (which will be in the final
pull), thanks.

https://gitlab.com/peterx/qemu/-/commit/74278c11b980429916116baf0f742357af51ebb4

-- 
Peter Xu


