Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB7C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyOs-0005Yv-LA; Fri, 01 Mar 2024 03:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfyOi-0005WO-SY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:37:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfyOg-0003Ys-Vw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709282258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3vxHbxBKab9POJaZqpNae6vAEcDoQnGQH6kvCmBln0=;
 b=dhlSIsRjEVxhCZTY9HlaKV4jBnaQxSgtq1i+6ymwWegBPS9xk2TY73FZLJXftgoFrOBGlc
 XwVTx9lGoaoeBBbNYtpiN8PLPCV1su9cZsij5Y+L56REOq45Naf5LRWErhH16bYysI3M4f
 N1fdMiBvMRjnuhI9pOVYvO4/g5hseoY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-hSq7kXyIMqO7XHo5myXx5w-1; Fri, 01 Mar 2024 03:37:36 -0500
X-MC-Unique: hSq7kXyIMqO7XHo5myXx5w-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c1b28c488fso533658b6e.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 00:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709282256; x=1709887056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3vxHbxBKab9POJaZqpNae6vAEcDoQnGQH6kvCmBln0=;
 b=sMI8xHw3nbyvTJxMdlCk8Vr0S62xNmILQwHSpQXrQwkA+OvtveYFXfEt4BThwl5mU6
 7NRZqTu8Zz0ZURLSRh4baO/I+0mWv7YSURl4KNotQVViZY+NABKwPSjnX98tSFWTtx9R
 1qhLpaDFqp8X/MnH3JKeWboR8/Va0K3u7Wt1dE4vFPZKGVAZj14LiDpXvKzqapAdIeRf
 tlMYfcgeA7QSxbKVXAzhrqeeAA7tfVnHIcb/fghg2uF7OPjQo1EI0mOYApvIEoTiLy5y
 dJlne5EqUESFAWK8DRver6/NGhxd+sYuGJdtaZLdCrfFWdm4FTaoWREbqY9L6V7+SDHA
 cjjA==
X-Gm-Message-State: AOJu0Yz86IHrxzEpFo1Qv6Qvr0U/25ei+VL2MUP3sF97ExaSGPxMNB7G
 +L84HMPV4qI3pp2sUBJcr9fR+Mling62pWVBqk0/t+EsIeo5gdsCmSVlWuJ471lkm1fWA9V1R5y
 K9RiUbUYgSrC86qIGpAQnwSgW1OZTcLE/cpvQD3nJA5p0Bu7Ew3BD
X-Received: by 2002:a05:6808:bc7:b0:3c1:3ffc:e1c7 with SMTP id
 o7-20020a0568080bc700b003c13ffce1c7mr1186974oik.2.1709282255867; 
 Fri, 01 Mar 2024 00:37:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTYzL2yqHe+werSduT8i/YIT6u33iZwJJ9siz2mzW9kEc74tA368EGFQK6Kmu+mn9hQu6s3A==
X-Received: by 2002:a05:6808:bc7:b0:3c1:3ffc:e1c7 with SMTP id
 o7-20020a0568080bc700b003c13ffce1c7mr1186961oik.2.1709282255593; 
 Fri, 01 Mar 2024 00:37:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p20-20020a62ab14000000b006e47e57d976sm2453096pff.166.2024.03.01.00.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 00:37:35 -0800 (PST)
Date: Fri, 1 Mar 2024 16:37:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeGTxnuYXtaryiax@x1n>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> Based-on: 74aa0fb297 (migration: options incompatible with cpr) # peterx/migration-next
> 
> Hi,
> 
> In this v6:
> 
> - Minor fixes to 17/23 and 19/23

Thanks both for confirming, queued now.

-- 
Peter Xu


