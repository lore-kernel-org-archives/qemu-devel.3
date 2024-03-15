Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A22C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5KJ-0005On-5m; Fri, 15 Mar 2024 07:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5K8-0005KO-Cb
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5K6-0004A2-O1
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710500521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HEtOnZx7X1bml+0RIOaXt+HVPacOXFPnIikuhAPZCY=;
 b=TndzO8NLdaCA2UHQrLdpJI8Ry77N+JQ0iHuUEKi8l9s7iuHTP00uDFXIx20v2kd1LAu7cH
 gQmDA+HD2yTFGivxMfOpjR0qbk45oDQzd+gXIFRUJah5ZXUPs/cK2+Hmo9t0b3+qWCvZgo
 bcTvPuLQaqTdF2TF5p3+Uow9wKHVK0U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-wcwP27HYMfu8X8AzrPrWEQ-1; Fri, 15 Mar 2024 07:01:59 -0400
X-MC-Unique: wcwP27HYMfu8X8AzrPrWEQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69152af7760so3966256d6.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710500519; x=1711105319;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1HEtOnZx7X1bml+0RIOaXt+HVPacOXFPnIikuhAPZCY=;
 b=jh5F7kPoLBsDnBK3mmrBQVeHGyR7opYV3grJ4W27x8Gl+Oqempl+fshpNB6u2mvk2g
 U0vyuoBpJOXOOgedD4kPOJuNIuImeh0ju4eYDLBWaudPwQPC/jRsoyjVV8Pf6cugmUdD
 myksLQh+yrmc/1fP5q8YurYQU0gxJ4BNhGoMre/Ov6YG9jbXNXnPmbESq3+OoFD4lvkA
 +bmhrYO2fkFFQM7YruvNFdiaZfD6TmSwiyiN5FCqWx//rXgVytOvSjSt+41T7r9C6kbL
 YebzlnBU3A1IjWKESBCBbO7XCTVN3REc0SaMZYYhsZ58iw3VZY347vyYL5JHhre2pz5O
 qlwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf7eFWg718WB7KOLTC10fu7t48U841WpjzhP/c2zupWzOB48q088rxvAJXtCgRuAdL3dNnuEqshykWBY+7krwiyekMTzk=
X-Gm-Message-State: AOJu0Yx6hKpJd+qah9CcPH3x3YGtr4bMiZn+q911MO4QWBRqjaldg+sG
 DZlEwlm+OriT9GnE96p646wOer6nce+vPsyDt85zROzDDjNJzXaMVOdQCTxd7/ELDcStD+mBWRd
 6ZTrLkXK4zTfQnBwtGXFWlc5jMYNQ0W+Rl62T+HumHOx3gSLFb6Pb
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr1742394qvb.6.1710500519401; 
 Fri, 15 Mar 2024 04:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX5dZenAd0eOzp2a058DKA8ft/D5fBKtCsJVF2Daafw1Kmj7FdILE2JI4uZJtmXrmqRtCgEw==
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr1742357qvb.6.1710500519005; 
 Fri, 15 Mar 2024 04:01:59 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 p14-20020a05621421ee00b00691631154a2sm1517544qvj.43.2024.03.15.04.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 04:01:58 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:01:56 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZfQqpK0xCwygYYho@x1n>
References: <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com>
 <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
 <874jdbmst4.fsf@suse.de> <ZfByYiL3Gl9d9u7h@x1n>
 <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 15, 2024 at 11:17:45AM +0100, Cédric Le Goater wrote:
> > migrate_set_state is also unintuitive because it ignores invalid state
> > transitions and we've been using that property to deal with special
> > states such as POSTCOPY_PAUSED and FAILED:
> > 
> > - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
> >    migrate_init() will try to set the state NONE->SETUP, which is not
> >    valid.
> > 
> > - After save_setup fails, the migration goes into FAILED, but wait_unplug
> >    will try to transition SETUP->ACTIVE, which is also not valid.
> > 
> 
> I am not sure I understand what the plan is. Both solutions are problematic
> regarding the state transitions.
> 
> Should we consider that waiting for failover devices to unplug is an internal
> step of the SETUP phase not transitioning to ACTIVE ?

If to unblock this series, IIUC the simplest solution is to do what Fabiano
suggested, that we move qemu_savevm_wait_unplug() to be before the check of
setup() ret.  In that case, the state change in qemu_savevm_wait_unplug()
should be benign and we should see a super small window it became ACTIVE
but then it should be FAILED (and IIUC the patch itself will need to use
ACTIVE as "old_state", not SETUP anymore).

For the long term, maybe we can remove the WAIT_UNPLUG state?  The only
Libvirt support seems to be here:

commit 8a226ddb3602586a2ba2359afc4448c02f566a0e
Author: Laine Stump <laine@redhat.com>
Date:   Wed Jan 15 16:38:57 2020 -0500

    qemu: add wait-unplug to qemu migration status enum

Considering that qemu_savevm_wait_unplug() can be a noop if the device is
already unplugged, I think it means no upper layer app should rely on this
state to present.

Thanks,

-- 
Peter Xu


