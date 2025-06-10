Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA263C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6VD-0004wP-Bf; Tue, 10 Jun 2025 17:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uP6VA-0004w9-L2
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uP6V8-0000cu-2B
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749590840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=50L+3Sm7Qm75YnYeW/Wg+ncKDoM2t1d9CU1/WYWofWk=;
 b=RLzRP3pF2+LQl2fbfrPc26OamFJBVKt8ukTQzR1ISbN6R8UKnDPqYk5/zfKmVQ6F4hsMuc
 v9VcWFdgM3ctGs8O9hVGAqnsmnLn64lYukLttrgGFIFKS7l7opX3nKlnpyXgTQvYRJ+CcH
 lxzc92SzvKQvBz1+m6jOum15x9/x8GI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-zHYmIvBtNMyfITxdu2jlpA-1; Tue, 10 Jun 2025 17:27:18 -0400
X-MC-Unique: zHYmIvBtNMyfITxdu2jlpA-1
X-Mimecast-MFC-AGG-ID: zHYmIvBtNMyfITxdu2jlpA_1749590838
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb2910dd04so17213706d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749590838; x=1750195638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50L+3Sm7Qm75YnYeW/Wg+ncKDoM2t1d9CU1/WYWofWk=;
 b=wt7BCs1wivTcELp67lahDF5218whlRqvZEr3ApO4G0be6Jw2KoAitb+12eQ5cLxuOO
 XWa+LbUwGVuGc5wyR4KYgA4cWNFgAkTpLlyxdwanN5LhxUhXgkkKjEPPhtbr/k+Jc7G2
 81mqO8vE6LT3pONToYnjW22Ze3qHTgDTYdxMxb3ZsugftkOGXc88MOLLmChUlmh317Py
 JgUz3ZUU1rUcoojsj778C0zfZfkYE2zbFGhSwQAYyC3QznVoIj0HV7IMGFrtMTRBy+ZN
 a8DhVnJb35jkjEM7V88l2xYJJyZifME5cFgParoeHmg9UQLAcdsA+JBx5rGXQaAdsVIA
 sa9A==
X-Gm-Message-State: AOJu0Yx264Myxv6rT9t+XltW61/+S7gINX0+QPcv6sc145koQqWBrAhT
 dTFsVYUc1gd0tqOkUnDrzOJ35VfuZXcLYnFFbnMzy9hY6rlPurWgKvMOLs8Kh62sGBXr8HmTVmx
 UWSqUBzRYBbkkczlkqe45xhWmaJRcTMD5qggpxowTWhv4xnqKY8GqZ6Nc
X-Gm-Gg: ASbGncvzNmf9mr5ZxTTOMFGuN0Kp7cwpWzRrEzZ5odWwNCvLkoUkn9Ff7CsgXkMBK1d
 ve07lp1hgf/A1hfx493pUk8RgiK4reizfo0GnIuvLPo69cHVIrvQ7amN6LYInDKzXp19i6vSHNX
 3wj/zW5rbwX7uahEGt2H5mkDNLD50vrY6R7jzPR9o7hs/k73MACUqg9lZiCNCTObanK94bChoeb
 oR4CjQRJQExjnpJmqHWT1+FnWRlgyhRzVA/+j6f0+yvCNsYwIgUl5cpH8VAbO8TA+s0OufJGYPP
 irMfT9PcKWahAw==
X-Received: by 2002:a05:6214:c82:b0:6fa:bf2f:41ad with SMTP id
 6a1803df08f44-6fb2c33154emr18724476d6.19.1749590838273; 
 Tue, 10 Jun 2025 14:27:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCL+iZQpZaTi3j5UisN+VcD2d/4O82UGTgv7BpurpN4/nFMGwda63fZfTODuiDoFwJtA7IJQ==
X-Received: by 2002:a05:6214:c82:b0:6fa:bf2f:41ad with SMTP id
 6a1803df08f44-6fb2c33154emr18724036d6.19.1749590837894; 
 Tue, 10 Jun 2025 14:27:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95absm73228236d6.22.2025.06.10.14.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 14:27:17 -0700 (PDT)
Date: Tue, 10 Jun 2025 17:27:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEijMrXY2r0BQgEX@x1.local>
References: <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <87y0u1ugkx.fsf@suse.de>
 <aEcC9X5i6eV4N7An@x1.local> <87v7p4vlnl.fsf@suse.de>
 <aEcwaZFSyarnFTPv@x1.local> <87plfcvh2l.fsf@suse.de>
 <aEdFgjAAuagXUyT9@x1.local> <87jz5juxj0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jz5juxj0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 10, 2025 at 05:55:31PM -0300, Fabiano Rosas wrote:
> I think I caused some confusion here. I wrote migrate_params_override()
> last thing on a friday and forgot it did the right thing from the
> beginning:
> 
>     migrate_params_apply(&s->defaults);
>     qmp_migrate_set_parameters(new, errp);
> 
> This s->defaults is poorly named and is actualy already the merge of
> defaults + globals, because qdev does it for us. migrate_params_apply()

Ha!  I didn't remember this part of details when reading, but then I
followed with that idea it won't apply to &defaults.

> will then copy that to s->parameters and qmp_migrate_set_parameters()
> will apply the 'new' params from 'config' on top s->parameters. An
> example:
> 
> Setting multifd-channels (default 2) using various methods and querying
> both QMP and HMP:
> 
> a) global overrides default:
> 
>  $ ./qemu-system-x86_64 -global migration.multifd-channels=4 ...
>  => QMP: "multifd-channels": 4, HMP: multifd-channels: 4
> 
> b) migrate-set-parameter overrides global:
> 
>  { 'execute': 'migrate-set-parameters', 'arguments': { 'multifd-channels': 8 } }
>  => QMP: "multifd-channels": 8, HMP: multifd-channels: 8
> 
> c) config not touching the parameter, value is reset to global:
> 
>  { 'execute': 'migrate', 'arguments': { ..., 'config': { 'multifd': true } } }
>  => QMP: "multifd-channels": 4, HMP: multifd-channels: 4
> 
> d) config overrides all:
> 
>  { 'execute': 'migrate', 'arguments': { ..., 'config': {'multifd-channels': 16 } } }
>  => QMP: "multifd-channels": 16, HMP: multifd-channels: 16
> 
> Without global:
> 
> e) default is set initially
> 
>  $ ./qemu-system-x86_64 ...
>  => QMP: "multifd-channels": 2, HMP: multifd-channels: 2
> 
> f) migrate-set-parameter overrides default:
> 
>  { 'execute': 'migrate-set-parameters', 'arguments': { 'multifd-channels': 8 } }
>  => QMP: "multifd-channels": 8, HMP: multifd-channels: 8
> 
> g) config not touching the parameter, value is reset to default:
> 
>  { 'execute': 'migrate', 'arguments': { ..., 'config': { 'multifd': true } } }
>  => "multifd-channels": 2, HMP: multifd-channels: 2
> 
> h) config overrides all:
> 
>  { 'execute': 'migrate', 'arguments': { ..., 'config': {'multifd-channels': 16 } } }
>  => QMP: "multifd-channels": 16, HMP: multifd-channels: 16
> 
> I'll update the variable names and code comments to be more
> precise. Sorry for the noise.

Good to know it's even working.  Thanks for digging it.

-- 
Peter Xu


