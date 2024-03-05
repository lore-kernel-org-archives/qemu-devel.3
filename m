Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8974C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPgj-0004SJ-2E; Tue, 05 Mar 2024 02:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhPgh-0004Rd-2k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhPgc-0001Yc-5M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJa5T3j+PS5eERn4JMAgNeB/NUFDm/NB2HIVEuYLnfQ=;
 b=Dn6KtBZt8E3AZNzlpkVR4DHWcq0x53jg0nLOZ3RmnkjenJUtggPABIOKNvlBgZsGQhKT/+
 jQGuuapLOqbxjPKdmC7Q4QzZey3s0LiUH+GFgmyxdnsgjdUQdBV8zw+4P3XY7P/8reS0aC
 upiifD949JvnAi/ACHVC5L1AJFuRvoQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-zvH_XmM7NMCD4KKTfji1TA-1; Tue, 05 Mar 2024 02:58:03 -0500
X-MC-Unique: zvH_XmM7NMCD4KKTfji1TA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc9884569bso1216775ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625483; x=1710230283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJa5T3j+PS5eERn4JMAgNeB/NUFDm/NB2HIVEuYLnfQ=;
 b=P9WSNkN4LQ2mlAtGtvYRlUyJ/ELrJOq2TpvbvES6OPHYqND8g+QtnYG7akIhd2ZFd9
 PlP+vV6zwDryY3gBeZkyaMTOfv2q1NtxSY1Rc7Kk/HzTj6JTZb4ZaY3607DnBnlmaEgU
 KMQfG1QxMnNrHQ5s23x8+XdfnqFS+HUkSoF48Tl4xYDsuWYU83YMMlAXaz81sfPltGg5
 xb0IhSl5CU3gFLAFm4Hz9V/PNkZzvFjlKZF57VeBaNFYfa9SorCUZyLDq0Yh0WTXmkew
 Wkn2xIfNbKTx+mYwkMPr6s4+fw72WbbcCxxBXefub7HWemykzKSIbNUO7GnSZMXB7BR4
 zcXg==
X-Gm-Message-State: AOJu0YztY6i/f4wd99NlOvzlKtKJzeea8yo5pFRxPeaBdqOcgrzRuy6O
 dmMdRxiNGI/yDnCdrHJvDOSCHsuGtV1BwAKMg/U9ob+eD6b4c7S0h84rraL2b7EfxBK4Kop1MQx
 HYk5058bNkIkYjiwQW8Gbbs24s8p4AMe2fLNalMkRpCtGJ6HrvgJB
X-Received: by 2002:a17:902:7282:b0:1dc:e469:6f5d with SMTP id
 d2-20020a170902728200b001dce4696f5dmr12048714pll.4.1709625482594; 
 Mon, 04 Mar 2024 23:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV1Duwgi46F/9U2CRGoPAdBy6HpH6qjTp/NRA3A9/+nRwklbuEhSU46Njd/V/vtZsY3jv4GA==
X-Received: by 2002:a17:902:7282:b0:1dc:e469:6f5d with SMTP id
 d2-20020a170902728200b001dce4696f5dmr12048695pll.4.1709625482185; 
 Mon, 04 Mar 2024 23:58:02 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170902b58d00b001db5fc51d71sm9792837pls.160.2024.03.04.23.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 23:58:01 -0800 (PST)
Date: Tue, 5 Mar 2024 15:57:53 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 14/26] memory: Add Error** argument to .log_global*()
 handlers
Message-ID: <ZebQgd3uRuBNACRI@x1n>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-15-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304122844.1888308-15-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Mar 04, 2024 at 01:28:32PM +0100, Cédric Le Goater wrote:
> @@ -2936,15 +2975,22 @@ void memory_global_dirty_log_start(unsigned int flags)
>      trace_global_dirty_changed(global_dirty_tracking);
>  
>      if (!old_flags) {
> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
> +        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward,
> +                                        &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return;

Returns here means global_dirty_tracking will keep the new value even if
it's not truly commited globally (in memory_region_transaction_commit()
later below).  I think it'll cause inconsistency: global_dirty_tracking
should reflect the global status of dirty tracking, and that should match
with the MR status cached in FlatViews (which is used in memory core to
reflect address space translations).

For some details on how that flag applied to each MR, feel free to have a
quick look in address_space_update_topology_pass() of the "else if (frold
&& frnew && flatrange_equal(frold, frnew))".

Here IIUC if to fully support a graceful failure (IIUC that is the goal for
VFIO.. and this op should be easily triggerable by the user), then we need
to do proper unwind on both:

  - Call proper log_global_stop() on those who has already been started
    successfully before the current failed log_global_start(), then,

  - Reset global_dirty_tracking to old_flags before return

We may want to make sure trace_global_dirty_changed() is only called when
all things succeeded.

I don't have a strong opinion on whether do we need similar error report
interfaces for _stop() and _log_sync().  I'd still suggest the same that we
drop them to make the patch simpler, but only add such error reports for
log_global_start().  If they never get triggered they're dead code anyway,
so I don't think "having errp for all APIs" is a must-to-have at least to me.

Thanks,

> +        }
>          memory_region_transaction_begin();
>          memory_region_update_pending = true;
>          memory_region_transaction_commit();
>      }
>  }

-- 
Peter Xu


