Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71C8C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZ9q-00067b-CW; Thu, 29 Feb 2024 00:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfZ9j-000677-BF
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfZ9g-0002VN-NZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709185225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p07KKKwR9b/nR3s60Msis9Cs4WK2Q8MBl6/lzBDWfCU=;
 b=g2Ewmwacs6JDYl+1t/75U4zzG37yOsnqkyWGedsKb8yGbHdt8Sq5gkiEIzOArgcXFlDWE5
 mwPM35iOCI5Al7ZyTjfAh4MwcS/vO8lKQEhcfrFG98fZeYQmwmivzQ8Mc25PJDQziwOvMd
 WFnPs9VvGsjlM/h1BswM6Dj1rTbbZNg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-YIeaXX8ZNS6VnBCYmKvEfg-1; Thu, 29 Feb 2024 00:40:23 -0500
X-MC-Unique: YIeaXX8ZNS6VnBCYmKvEfg-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5a0c27598b7so118051eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709185223; x=1709790023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p07KKKwR9b/nR3s60Msis9Cs4WK2Q8MBl6/lzBDWfCU=;
 b=jEPUBGfXPoAYNTyjrHhPcayJUr3WOyyVdF0II1eOp3v+Ga/XyO231xlFZpvNSUUC1Q
 EuNNifkdc8rhOImQuUrka5ko3xzvEyjdkcwKka5cSDF01bJXkeNo2erfT1QtXMGWv5Xs
 OEdo6rd4XlcdfOdpIyxZ372rCRBQvZGrhoBnYmvlYp72noSY3kCPhySYmd+XG1lwRVPF
 wS9/k6+mqbNkzW1yRADt3l/JVZhRmTOxx9aLMzyabEpkWAulETP4dlVXZNZssOPTmLkh
 EbWx8zRBv/gy2UQp2fDHgwW6qLE5gD1aJMmgF7LGdX/IuFtxagJ7qSblhJSY5I+eZjaY
 d35g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAAOrClXlgxXwKpkBUgkZaJs5GEDsek+A9Cd9PrHpg7MmMqOGLrBrfOCPO17Bkoe3wZrXK5ws3eDczhCtveEQ4kv8kn+M=
X-Gm-Message-State: AOJu0Yy51agmmfN2o9jVuCEup2SZn82ZMLWw6mXyeMVGQprrjffcV/fr
 KoEzKO1CwcafYHqfwZHlFtctPBzNOZe2wUHiM1+x28TjJKHdf/KNjHb2Z0KbHZM2AfjTmAYlQG2
 dxdIHru+tZTugiMEX4psvRFP4prNjwI9Y3I1Zn3bZZjAtSXyG4nw0
X-Received: by 2002:a05:6808:1813:b0:3c1:3733:8aa6 with SMTP id
 bh19-20020a056808181300b003c137338aa6mr1312575oib.5.1709185222850; 
 Wed, 28 Feb 2024 21:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ1CLqD0qp+zJZDVMjbLgdJaWbGjOP/IFa+3OWEGlpdXp46BKgNRf6HSDSRbWMyG0cTADfgA==
X-Received: by 2002:a05:6808:1813:b0:3c1:3733:8aa6 with SMTP id
 bh19-20020a056808181300b003c137338aa6mr1312561oib.5.1709185222585; 
 Wed, 28 Feb 2024 21:40:22 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j4-20020a654284000000b005d8be4c125csm350232pgp.80.2024.02.28.21.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:40:22 -0800 (PST)
Date: Thu, 29 Feb 2024 13:40:12 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V4 14/14] migration: options incompatible with cpr
Message-ID: <ZeAYvLZDyL4jPHVU@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
 <87cysh3vg0.fsf@pond.sub.org>
 <d54495fa-063d-4cb0-9e6a-4a57a312237d@oracle.com>
 <87il28vajw.fsf@pond.sub.org>
 <2089875c-17fd-4148-ba3b-6a0283d4ea3f@oracle.com>
 <87il27u98x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il27u98x.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Thu, Feb 29, 2024 at 06:31:26AM +0100, Markus Armbruster wrote:
> Hmm, perhaps Peter can still squash in the corrections before posting
> his PR.  Peter?

The PR was sent yesterday, it's already in PeterM's -staging.  I worry it's
a bit late to call a stop now.

https://lore.kernel.org/qemu-devel/20240228051315.400759-23-peterx@redhat.com

Steve, could you provide a standalone patch for the update?  Then I'll do
the best accordingly (e.g. if the PR failed to apply I'll squash when
resend v2; or I'll pick it up for the next).

Thanks,

-- 
Peter Xu


