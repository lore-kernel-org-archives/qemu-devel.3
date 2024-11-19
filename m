Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA7ED6C290
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUHS-0006Zg-4N; Tue, 19 Nov 2024 14:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUHQ-0006ZY-9Z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUHO-0001zb-Jw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732045971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p/i/KGo4BS+eIxTOi9p4lESuwmH0MfG7DiiJwKJ4yE=;
 b=hfv0watgs6jMNPkFWj2PRpfMDijmxuVrJ1jGMVPRJiWoDdDMjCqZdlXzXCCk0WIPOlAMKe
 h5giqrgkSf5G6eCMXY44T8hl/Xw/lE2OhXTA2SDeJN9kI3ANPzXYyyLRCLXUrS+S03VQ4Q
 0EAyUIBak0JfOPaOEmSSC4Ed09q40kM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-jWTu3X8RMMW8cknPzlwbmQ-1; Tue, 19 Nov 2024 14:52:45 -0500
X-MC-Unique: jWTu3X8RMMW8cknPzlwbmQ-1
X-Mimecast-MFC-AGG-ID: jWTu3X8RMMW8cknPzlwbmQ
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b161d4c422so158244285a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732045965; x=1732650765;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0p/i/KGo4BS+eIxTOi9p4lESuwmH0MfG7DiiJwKJ4yE=;
 b=pFxGq22+1bgpcM1LX7DbhW2qSzGrf1EVC25U0iRf5m2Xi0TRoaGBw3x2xTtrmyPrAy
 6dQO/CDOqJoRMIT+oaCmX6x0jzq0B3wKjvN27BJCF8lmSAR+XRf0pedSxvj3vpq73EvM
 QX48k1EhKmZ2EHyP0rrmTBwTmTyx6jSDL/xFhNsLVGjulxIovd7l6bUzWCouFX029FJQ
 ye9Q17LoprePHcb0SfHNToptMNh0fBJfqtvcPNVRlRjLt5iivUopAt3eOigMbOrHqTpO
 GhdD89KNnYwXI6CB+qkKD3T0THN5D6JMZJN+EO41ZjIilBX8wcCKFxjkiCdLtDn6h2mW
 csVQ==
X-Gm-Message-State: AOJu0YzfsMRnkfyQB5PFczElWrLbQHlaAQ2ZMy+CJYBdqM4ySmG2xhW5
 SmZ+gbIkmXI3OcGNNeCaYKuJEDSvoK06YGLYIRe5Ytp4lOxLLpcJ+oqGVmScl8qqU74FxnaYyGg
 SW96nLK6BuDCpKZWktWhCfxFfXuU1/qLnehw4MV0+z+vb/pdrstJs
X-Received: by 2002:a05:620a:2484:b0:7ac:b220:309a with SMTP id
 af79cd13be357-7b42ee7118emr23973685a.15.1732045965137; 
 Tue, 19 Nov 2024 11:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+NarEunhAVTVya8CRd9XnvyRIEQjtRf/b9/Z53Oi0GbQQkk0tHYCkkKqncN2S9uJ1UHLWxA==
X-Received: by 2002:a05:620a:2484:b0:7ac:b220:309a with SMTP id
 af79cd13be357-7b42ee7118emr23972085a.15.1732045964808; 
 Tue, 19 Nov 2024 11:52:44 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a89f837sm127173785a.104.2024.11.19.11.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:52:44 -0800 (PST)
Date: Tue, 19 Nov 2024 14:52:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] qom: Add TYPE_CONTAINER macro
Message-ID: <ZzzsiqChzyzT73fC@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-2-peterx@redhat.com>
 <ZzxdlQJE-8nyWb0w@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzxdlQJE-8nyWb0w@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 19, 2024 at 09:42:45AM +0000, Daniel P. Berrangé wrote:
> > -#define TYPE_OBJECT "object"
> > +#define  TYPE_OBJECT                 "object"
> > +#define  TYPE_CONTAINER              "container"
> 
> nitpick - 1 space too many before "TYPE_", and it is not worth
> trying to vertically align "object" and "container", just leave
> the existing line for TYPE_OBJECT unchanged.

Sure.

-- 
Peter Xu


