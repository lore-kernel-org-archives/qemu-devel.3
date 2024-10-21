Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B58D1712A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2xwx-0003Ps-ID; Mon, 21 Oct 2024 15:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2xww-0003PR-8a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2xwt-0007Xj-Tg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729538414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dOw0GyT9P39/OQMOJfFY8reWHdsV+eK5eJ7/CZYQ3lQ=;
 b=EA/tZoiFHmzfiRyu/OusN/bO5c6VMLLie+Ohdi2pY4tL7TPfFptnbKPrFrF6snwdSFwGlj
 XpJjOCCdmjNfIkmh4EZT5nxLH6tDcfo7SE3ZiClkuiULCN+ITGiesRMOvmuTItvmoCf/RW
 wsnLwJ/gkQoSdjT8klH5WZ/t2l0HPFU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-CwcdFtUlMcSJ7vHq89SPeA-1; Mon, 21 Oct 2024 15:20:12 -0400
X-MC-Unique: CwcdFtUlMcSJ7vHq89SPeA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5eb65120f2cso3645430eaf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 12:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729538412; x=1730143212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOw0GyT9P39/OQMOJfFY8reWHdsV+eK5eJ7/CZYQ3lQ=;
 b=VdzcFJ7E1OB4d8FjR7nqjcfgCBNpgvfkkJl2idTzEh0mRuOf4FMyN3hwhu9dvh/i0R
 S7KU3HmIHnaFq+aTzkoUw2ni75TSBGbPZNk2DB8rZtJFdDLz4eYR3yN3E6jXhRadfuoA
 ZhN3rvqFcWHvAIHVBheOn7AipSHLda+85BCte3pTNkMMU2txzFDMll4Cek7SmiiA3B4Y
 Ssg9ua6ebZOY3POJAmR47MRB42u7UiX8vz+aKfpdIABzIvaKdsBiCMP2FK6AH+K1XyEu
 kFBIBbOWkRr27OrpcX4z0Ssi9zEUycqKAHIqRZdWMWgRMELJfd2TftnrGt8TofJ/Gxf7
 bCGA==
X-Gm-Message-State: AOJu0YwTzy79SVv2W/AwTUxbOCbf3FSGzfsrThzikYHk0bQTrFcaTOdY
 sJfySvhV+E+NpH9SFrDTRkAxYbeJVOqkAW2dqYFvRPoVEhI0mvFkQ1zDQ4wZjve7LYyiwouBoZn
 HrYg1l9NLpGULtiSRd+GH8iCDJzvR4Mt2lIdLx8lbVLZP96BSuCnz
X-Received: by 2002:a05:6358:52c9:b0:1ac:f7ac:e302 with SMTP id
 e5c5f4694b2df-1c3cae6d7dbmr145642255d.18.1729538412162; 
 Mon, 21 Oct 2024 12:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTf6uOyw7jaIi/IPLhwWNspxlUu/4lS5nrTFV+VGGuffwdByNpN2rAK64gGVpIsHK3PlSNyw==
X-Received: by 2002:a05:6358:52c9:b0:1ac:f7ac:e302 with SMTP id
 e5c5f4694b2df-1c3cae6d7dbmr145638755d.18.1729538411763; 
 Mon, 21 Oct 2024 12:20:11 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3db17basm20485841cf.91.2024.10.21.12.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 12:20:11 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:20:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 13/14] net: cleanup for precreate phase
Message-ID: <ZxapaTo8D5VhnCd4@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-14-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1729178055-207271-14-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 17, 2024 at 08:14:14AM -0700, Steve Sistare wrote:
> Guard against unconfigured state if cleanup is called early, such as
> during the precreate phase.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick..

> ---
>  net/net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index d9b23a8..207fdb0 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1687,7 +1687,9 @@ void net_cleanup(void)
>          }
>      }
>  
> -    qemu_del_vm_change_state_handler(net_change_state_entry);
> +    if (net_change_state_entry) {
> +        qemu_del_vm_change_state_handler(net_change_state_entry);

Can also rest net_change_state_entry to NULL.

> +    }
>  }
>  
>  void net_check_clients(void)
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


