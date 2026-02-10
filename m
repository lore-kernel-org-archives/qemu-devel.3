Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E74EA8123
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpotN-0007aS-8i; Tue, 10 Feb 2026 09:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpotL-0007Zp-Ck
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpotJ-00084d-54
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770734339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6H1Duy4KHWFh3Qn/Jjvd+VckborwkoT/GYKOryjCy2U=;
 b=OqfKij0R6Jnitn4lV+AZtJi/JQ6ql3JfMVX9zclHsJQ1ToTiId0DBIwL3rTsPWWNRGDq+P
 RjtKr6oV123Djfiq/1eUpKENzzTx8OWMub+E2QKLOwMkqrIpSZcoGJZ4Gk9SzCIwIbgEyL
 0hfv5f7yEzp9lLSk3bQX/fbp9lXC8HI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-SX4vdRElM1CneaU2e_NrIw-1; Tue, 10 Feb 2026 09:38:56 -0500
X-MC-Unique: SX4vdRElM1CneaU2e_NrIw-1
X-Mimecast-MFC-AGG-ID: SX4vdRElM1CneaU2e_NrIw_1770734336
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50341fddb89so174813811cf.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770734336; x=1771339136; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6H1Duy4KHWFh3Qn/Jjvd+VckborwkoT/GYKOryjCy2U=;
 b=kqGU1Gb1BCr2C8evaz54S+Zb7RJXoaYAYcudDcO+Opv8w9DZWlnd9pg1YO1q0oNiaN
 gVU6SNJlqjq/svS2nOnwYMsIz/lPK2MoSuDwCqQmqFiLLn88kOl+VH0tcjQo9rEViADI
 61SB7EaD1lGXkjFzTIZKoCm9UevrYzybJxOMAkQR4b6gIAkl08qDAhyPa97Q41HWgYDk
 51HJd6ksqf1OBRhXHrqvt6K9X3lshmpqWi3wNkSOyyu2yavj2T4fYOYtZjivGuJSh7cS
 YlzklRUl/R3iPU4aQLPklDfGlhdNBpFTfK+xgVSvLGspiEIcRcEQV3BGObXxMAj1yHtO
 PhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770734336; x=1771339136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6H1Duy4KHWFh3Qn/Jjvd+VckborwkoT/GYKOryjCy2U=;
 b=LJ/P+lV7zpKSW9/kB5Cn/DbYsqKvTsVqb8Du4xB0nEJ82/UwAw1xAYfFledQBZSA6C
 vdex8b2YKsPtR4TA2yo6la0L2U9FhQcZnAODZ4SlPL7tgQX+GPItK6JK2pbi+LDf4VH2
 hrbOKCzfKvCz39Ci0f5b+a1dwFF9Mj1r/PzPQrbOKa3zmxu99HLXjxhVvJiSdQIwzCdv
 sDFcY9xyvEt5QPfJERpDIHk/RGyCl9uQwAnwpy50nKX4Q29R+sEamYhz+lwk0TwHKcu+
 5SSsJCWVv62bFTSOftf6PHQs7118GoGsF7XPBn1AhtfIIg4j4wE9kwu9JAuMUbAbT/0K
 mBHw==
X-Gm-Message-State: AOJu0Yz/piCHDW2BN1XftvJNoFOx4/sCK9QfdtL3knBbPpsLb4EUrx44
 yP9uFGkHZuY22Osi2kqbuJ+JLg9FdZLkAzvxaWQUrfFHcupwNDCGFI7QE1p0EdAqIR7Qkbp3rYE
 Fc5RQQ4GDllbHM70Q/3VAps1fTszSshyeeSj+5lD39usR6jceTV0nPDHm
X-Gm-Gg: AZuq6aItCvz1R9mr6B4XuHvRedqQ4ZajiALWhUpq+yPD8X0JXJpY+sUSfW1mPQA38B2
 pn+lM0+2qQZvs3fQSC28tlQ65BXDW7Gd4TqYcFMmZKjCVMBJOdW8hOMBE6KSP9TRWIggtWsDMSp
 QF5HNJ9uYHwzUgyU0smxJPleetRdY/n2sRx/nc0NITIZ+jgtmXSmn+yJ5S/49P4Tdw56oeuNdQH
 MN3PhmLQl7FFD0j2rEhsBRxS1UfPpKyQcnL20D+6lOL/tNQ9gcfseFZAij4GTpq6CCAOmMnGDoZ
 /WL7E2a0COA0dWn08QlfUBtV91M1v8YcyRHJ0WyTJWYHB63i5cZfO19xH+FGRZ9fBKtB9Ljd6y9
 AuYAGn2XFPLu9aA==
X-Received: by 2002:a05:622a:4b:b0:503:41f2:df94 with SMTP id
 d75a77b69052e-5063995282fmr228001501cf.52.1770734335781; 
 Tue, 10 Feb 2026 06:38:55 -0800 (PST)
X-Received: by 2002:a05:622a:4b:b0:503:41f2:df94 with SMTP id
 d75a77b69052e-5063995282fmr228001011cf.52.1770734335308; 
 Tue, 10 Feb 2026 06:38:55 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50639e26b9fsm104015561cf.15.2026.02.10.06.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 06:38:54 -0800 (PST)
Date: Tue, 10 Feb 2026 09:38:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 05/16] colo: Remove ENABLE_COLO loadvm command functions
Message-ID: <aYtC8yxRQPxh7tKn@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-5-57508b7389f6@web.de>
 <aYoHn5DSsia4mxMW@x1.local> <20260210142835.6622e72e@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210142835.6622e72e@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 10, 2026 at 02:28:35PM +0100, Lukas Straub wrote:
> On Mon, 9 Feb 2026 11:13:19 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Feb 03, 2026 at 11:15:11AM +0100, Lukas Straub wrote:
> > > No need for it anymore now that x-colo capability is required
> > > on incoming side.
> > > 
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>  
> > 
> > IIUC this patch needs to be squashed into the next or it will break COLO..
> > 
> 
> No it's fine actually. Now when we receive the MIG_CMD_ENABLE_COLO
> command, we just go to the return 0 at the end of
> loadvm_process_command().

Indeed, but we should actually raise an error when receiving deprecated
commands because they're unexpected.

Please still consider merging these two patches.  When at it, we could
change the previous check into a "default" here:

    if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
        return -EINVAL;
    }

Or we just add a "default" to cover deprecated commands.

Thanks,

-- 
Peter Xu


