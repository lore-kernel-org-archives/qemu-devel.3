Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BC7C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg0Kw-0007ip-GP; Fri, 01 Mar 2024 05:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rg0Ku-0007gv-KO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rg0Ks-0001LA-1a
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709289707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/XQzgiI5aU+1JhO6Uph6h+T0BZpyhA1+oIw1T8fZPP8=;
 b=Dyp8wFQRUBdFQzfkn4VlFp3vgg0pdykY0HJTKlZuxCSNxYuQvjnWIXqsu9WCsUCrY7S3s+
 Lepcu2TTEb9pXdG4jmHkj+epRkgZ808mGFQB280D8Q7tstudYGvDlrocTmaI895eDOfYI1
 s50PQmJ7q72iGvORAAa55en70YX6etk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-BFjR48D8Ohm_SD4K0Hiq_w-1; Fri, 01 Mar 2024 05:41:46 -0500
X-MC-Unique: BFjR48D8Ohm_SD4K0Hiq_w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42e8a7e0555so55912831cf.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 02:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709289705; x=1709894505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/XQzgiI5aU+1JhO6Uph6h+T0BZpyhA1+oIw1T8fZPP8=;
 b=I09PJVU+a4lt86UY0IeoJ6F2d597FHiFSCLrvkM5l1jTknVbvFWdmSvuziqKwClP2t
 ZqHc1nW7uhwJxYN58mNJ82hmWuuyIT1qapdAyy+ToxNu9oywO7XcWDJ4BJJ4y+coS2uD
 R5MLqI9oXt1bQzfDTG19WzPw8Me+1P1fdzCgb7n2p1E8Xvcz1E6QA/y4+uaZrSlml8ry
 UextLLtpFI8t23dGBFwMzf/HrafiwnaCl/YjWqksP7HW9EOWSa7DfELErwGlFQpLgTKf
 AExBscJIrgZjv6Y4YsbYd8QguwWkU1EptxA6bj99nkHjYc54nZDeo7VJidxjOPK6a+g+
 WtWg==
X-Gm-Message-State: AOJu0YzhYb1/dgWXzNceGvrRgcYvPigFwJ2GR6ArlfzNsrV3VYHTPenG
 h2yz0wa2KLm/WPchogqL1exshZl6qVasMk2DQHBj7v5Xsegd5Y464f9u1XjVGY4ummKH13JBYRn
 ZrON8JBUK9w/V/ojf6c6dYhQb/SrdXSKR0dopHmAUDwJH4D+ZsZCJ
X-Received: by 2002:ac8:7d0d:0:b0:42e:b13f:56d2 with SMTP id
 g13-20020ac87d0d000000b0042eb13f56d2mr6994359qtb.28.1709289705701; 
 Fri, 01 Mar 2024 02:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3yCoNJxQnn9Z8uIU+bIJExdnTxZwac87iASMIh+kC0j3UTBXV9TEv2bw9gvMMqhHPHeA5RQ==
X-Received: by 2002:ac8:7d0d:0:b0:42e:b13f:56d2 with SMTP id
 g13-20020ac87d0d000000b0042eb13f56d2mr6994347qtb.28.1709289705426; 
 Fri, 01 Mar 2024 02:41:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a0ce353000000b00690314356a4sm1723396qvm.80.2024.03.01.02.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 02:41:45 -0800 (PST)
Message-ID: <c8dbb835-64f8-48e2-afc0-388b586268c3@redhat.com>
Date: Fri, 1 Mar 2024 11:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/14] migration: stop vm for cpr
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
 <ZdvyuazPp6Lrn5Mr@x1n> <9d560585-8f3b-4ad4-82e6-333e8c74b496@oracle.com>
 <ZeEvSLgKW96KCy-N@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZeEvSLgKW96KCy-N@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/1/24 02:28, Peter Xu wrote:
> On Thu, Feb 29, 2024 at 10:21:14AM -0500, Steven Sistare wrote:
>> On 2/25/2024 9:08 PM, Peter Xu wrote:
>>> On Thu, Feb 22, 2024 at 09:28:36AM -0800, Steve Sistare wrote:
>>>> When migration for cpr is initiated, stop the vm and set state
>>>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>>>> possibility of ram and device state being out of sync, and guarantees
>>>> that a guest in the suspended state remains suspended, because qmp_cont
>>>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> cpr-reboot mode keeps changing behavior.
>>>
>>> Could we declare it "experimental" until it's solid?  Maybe a patch to
>>> document this?
>>>
>>> Normally IMHO we shouldn't merge a feature if it's not complete, however
>>> cpr-reboot is so special that the mode itself is already merged in 8.2
>>> before I started to merge patches, and it keeps changing things.  I don't
>>> know what else we can do here besides declaring it experimental and not
>>> declare it a stable feature.
>>
>> Hi Peter, the planned/committed functionality for cpr-reboot changed only once, in:
>>      migration: stop vm for cpr
>>
>> Suspension to support vfio is an enhancement which adds to the basic functionality,
>> it does not change it.  This was planned all along, but submitted as a separate
> 
> If VFIO used to migrate without suspension and now it won't, it's a
> behavior change?
> 
>> series to manage complexity, as I outlined in my qemu community presentation,
>> which I emailed you at the time.
>>
>> Other "changes" that arose during review were just clarifications and explanations.
>>
>> So, I don't think cpr-reboot deserves to be condemned to experimental limbo.
> 
> IMHO it's not about a feature being condemned, it's about a kindful
> heads-up to the users that one needs to take risk on using it until it
> becomes stable, it also makes developers easier because of no limitation on
> behavior change.  If all the changes are landing, then there's no need for
> such a patch.
> 
> If so, please propose the planned complete document patch. I had a feeling
> that cpr is still not fully understood by even many developers on the list.
> It'll be great that such document will contain all the details one needs to
> know on the feature, etc. meaning of the name cpr-reboot (what is "cpr"),
> when to use it, how to use it, how it differs from "normal" mode
> (etc. lifted limitations on some devices that used to block migration?),
> what is enforced (vm stop, suspension, etc.) and what is optionally offered
> (VFIO, shared-mem, etc.), the expected behaviors, etc.
> 
> When send it, please copy relevant people (Alex & Cedric for VFIO, while
> Markus could also be a good candidate considering the QMP involvement).

I second that. If we could have a file under docs/, it would be great.

Thanks,

C.


