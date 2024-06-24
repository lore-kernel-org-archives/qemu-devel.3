Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0768C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 19:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLpER-0001B5-DH; Mon, 24 Jun 2024 15:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLpEP-0001AF-Uq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLpEK-0001wJ-Vz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719256795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=utxLLICRn+TR8tml8kvQvlWgcVDWcXrEh99dAtBcq/c=;
 b=ZIbSeF17kkBQnewCTbUJjshOdvnIHjvIjOxr70ml4gYpWWEN0JMON1tW1zf0wlVZRvWeMN
 wxdFk1p4bwrPZVlIxWN6eL8S8VAvdgDA9SqiK1hkOka/hM99TDD1u9vAzwxOd+HiHBAGVJ
 +DaxgscEqdLuQfGibTY0FyWRjo3g2LM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-_J57kllsPZ670cDPvpxUDQ-1; Mon, 24 Jun 2024 15:19:53 -0400
X-MC-Unique: _J57kllsPZ670cDPvpxUDQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7955a7df54cso46121685a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 12:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719256793; x=1719861593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utxLLICRn+TR8tml8kvQvlWgcVDWcXrEh99dAtBcq/c=;
 b=mnUuwfdMcpLmuPamoOS+pFlgMR13Lrh6UUwGYSUIzxAj2Wrr4xlKOShKfI0UygoD7F
 WhnMoEYaLpksBtpIkY1lBHhIhyDA3LUN/SoeY1nfqw95V4EkFccnYlHg7M/KwEoB11c1
 DWXa8RUvdZyRalDp1FoDEcTVPbGG7PrKF1AvCBdjZ23ZU5dBNYwVkhvxkef8Ah6oNrDU
 FzgPoRco3vrz3BRvV5a2RfijXDL0TJ1HRIPKK5GjTifh3wuEXkBssKbCPEkpdbmfYtYj
 oCSTEB5HkgR3PsUIrVaelaq2hj+khkmidQGCD9fSM/PiHZEWoWHJcYeMa9OfFWyxZKpj
 BMZQ==
X-Gm-Message-State: AOJu0YxfU18vqMvNQmq4E5XleVTtaObGKhSqTXvUqYNdpl3oXzhiR7Qq
 zoBhqNZ1yMYHSzPMOdYpAP2Pw1XoOlYa8jqzUpitTm7/aVOh4xV4oXVdBEA4W2PZZn02YYqmfmE
 W+5ErpBSeqx0Aip7p2+aznKBxS0vB7TJ34Yhp0ERtykfQyNqjSnQx
X-Received: by 2002:a05:620a:4152:b0:795:a5d4:4aea with SMTP id
 af79cd13be357-79bdd75d3f0mr682065885a.2.1719256792492; 
 Mon, 24 Jun 2024 12:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCM1kyqkTa4KCEPnet1Tzsna1qFRYh1vIfy5dJhzjJ6ineoJAP0VELBckcur0wTCJk2uiq6g==
X-Received: by 2002:a05:620a:4152:b0:795:a5d4:4aea with SMTP id
 af79cd13be357-79bdd75d3f0mr682063685a.2.1719256791976; 
 Mon, 24 Jun 2024 12:19:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce9432fcsm336958285a.131.2024.06.24.12.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 12:19:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:19:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH RFC 1/2] migration: abort when switchover limit exceeded
Message-ID: <ZnnG1PrbQ_7nOu9e@x1n>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-2-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621143221.198784-2-elena.ufimtseva@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 07:32:20AM -0700, Elena Ufimtseva wrote:
> @@ -16,6 +16,7 @@ bool migrate_background_snapshot(void);
>  bool migrate_dirty_limit(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_switchover_ack(void);
> +bool migrate_switchover_abort(void);

This does look like an interesting feature.  The challenge might reside in
the details.  For the interface part, one parameter should be enough?
Since when set to 0 it can already mean disabled.

Thanks,

-- 
Peter Xu


