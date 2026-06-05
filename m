Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6922FCD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWao-00024k-J4; Fri, 05 Jun 2026 11:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVWam-00024S-IU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVWal-0002ju-2f
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780673773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4amOZVsy9Zmr90O2mhACK2tz/etVYqWejUs+r5y6E4g=;
 b=DdWGQwb74sfskXWs+PPIlMTq9WbSCiQ/d27apP8WjFwXYp7LbSLgX3+yatwdIAPC5+H6xc
 JL5ev4WNPyqYpygPn7WbmLZ/+8D0uiE9KPktZas4JscKw3bIEncF4q7BMVfRok+dygEuIX
 uylYExwn/suerjmLzy4jXkGJ0oZEHPk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-zqNifU5kMqaslnQqORALtA-1; Fri, 05 Jun 2026 11:36:11 -0400
X-MC-Unique: zqNifU5kMqaslnQqORALtA-1
X-Mimecast-MFC-AGG-ID: zqNifU5kMqaslnQqORALtA_1780673771
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91571300242so726322285a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780673771; x=1781278571; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4amOZVsy9Zmr90O2mhACK2tz/etVYqWejUs+r5y6E4g=;
 b=R6iKH67zXejuhAIkIVQhG82kv+ti+fqAU8EQJN4gywyCeUv6DUSJfRRZvDe/SRPUch
 Csj2yxKR3+bqGccOWMQRU6XtkD/IxsJlorSQcloC8j5a6Ip2xvn8UVPNIDk6s4iCvxAL
 o3QoIeGcmP34XvreJUuBPXx6WXAso4VQf+ZoED/CRotSKYdKKNGwpRN4BeuUSy5TuL2b
 oJFopys/PvZDs+OvnOgG+8nHOI1upU43+KC5FHSI0/RH6k3oF761Q3zydNOH5qfq6e9E
 GQgF0H74TqtxWMoUVpaHR5uYpQ1RGFpK/zGMwE+/JIPTaETFyqtevHyORW/6brdN6dnA
 1R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780673771; x=1781278571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4amOZVsy9Zmr90O2mhACK2tz/etVYqWejUs+r5y6E4g=;
 b=TnSFtmGiWhmg94c1EWZOm9hqtrocmrr43j1a7ZgJ0T4HaZ1NG0rGWuzC6KnGjozq+1
 dDCIXuh+Euiqt6FdHP6CXSTZpOZQZq+eaxOQLPVJo7nkdJFzTZ0uKlFqDloqrIP+RqEZ
 dhKlbysSYLR0pC++RIAjWIwZ1nCaynJGKQ5L4vSTYTm9tRgaqKZO+oVITxIOrS6FH+iH
 MmSfJ4Iscyc5/I0zmLgOPTB3irp4FsgPTT3GEzimTJh8FZI3mbm2HWaXwbwI/gSx6yQj
 1GOBAGcSbYxmdEczjE7V4xIgUXUsBMo8dv1OPllnOhlFusjlsLf9kh2izZfDRIwWBsrO
 PiOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UJMrXL2aSG/khkpNkxtRgVcwSybY1OvdYoa+uaS5XGqHYhvKaT5mRLleFsgi7LovQcnj7C6W70nam@nongnu.org
X-Gm-Message-State: AOJu0YwQX1DdcLbpcTnB1l0ryQv0DSJwARAkTJBrcw7u6Uhtr5ZRZdlL
 5i461+VJGsP9yUEVjveIHvH7IvdhaP8DmI4DHqRYZZh1mRYEm0Vz4vgxPG+vOr67SDDLHjFQ1J5
 LQYgqebR4G9RUwmLVCKSnIS8ucO00vC5XVrKzaO3Gl9w35mONbIXuFv7g
X-Gm-Gg: Acq92OFNgW+WOzuargtR9wOvAmG8C1VwQL0Aa3oR5rrEJE+CNRY6nyOOO7pjWg4KJN3
 5XBvfN44qc57rFlvvK1geAW6Y5znTRaS2DQMsueRXW0bRQqARwH9P7KJv/5N/m1Pw1MmzhP7tu4
 f3mspbFSZVdgbaCu21byMau31uilLujxFI5TLWMkVeGp49Ewt7mkIzC4xnDgB7RgMLx5MhDCCDP
 gRDqWZ6UQcZz36fLkG57mTOWSCvlwuTRqt5WnqfnIlbXGY+n46yf8eI+bKpl9mOuDEI5SB8sajU
 +GETKKabTEYo6BrHBpUjpOm+tcMgCf7MGteVgPRkymlDjwfnMVFSYX5eUToatD/t0sH72pg3LuF
 UbNMIthYDzOLtc//nCYRhQWBPbg==
X-Received: by 2002:a05:620a:700b:b0:915:4c9b:4120 with SMTP id
 af79cd13be357-915ad33b3f9mr436160585a.37.1780673770922; 
 Fri, 05 Jun 2026 08:36:10 -0700 (PDT)
X-Received: by 2002:a05:620a:700b:b0:915:4c9b:4120 with SMTP id
 af79cd13be357-915ad33b3f9mr436153385a.37.1780673770300; 
 Fri, 05 Jun 2026 08:36:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9fa7fsm85931396d6.9.2026.06.05.08.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:36:09 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:36:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 4/4] migration: Remove dependency to TYPE_DEVICE
Message-ID: <aiLs6BzDCSxaIe1y@x1.local>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-5-peterx@redhat.com>
 <CAJ+F1CLLOd0YUkaQifbzn5vDDh28UAv2=8Z3vpb9BNRYd-JYaQ@mail.gmail.com>
 <aiKNkDvO0cx92zz-@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiKNkDvO0cx92zz-@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 05, 2026 at 09:49:20AM +0100, Daniel P. Berrangé wrote:
> Do we even need a MigrationClass struct ? It has nothing except
> the parent_class field, so feels redundant. Could the code just
> use  OBJECT_DECLARE_SIMPLE_TYPE instead.

True, I'll add a small patch at the beginning.

Thanks,

-- 
Peter Xu


