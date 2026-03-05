Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB5F3D333
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC3n-0007Q0-0E; Thu, 05 Mar 2026 12:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyC3U-0007Oe-60
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyC3S-0003lj-9k
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772730005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zefqOHTxG5vv3Mko1njyQnQmXHEz3QoE0naifHiyX0o=;
 b=dEAJpWUTjo6GpeUthrFk5reymlag7NDLfjMGkXbZTts7nvktTPVpTJiWMyiQegeEJQWng5
 k5lMteyUbP95MgAADTzMiaJMU+TTJI3u9RsMESxEuGYF7kZgt0IZJKjNUzGl/2LXUfDDFG
 C5rqfuVzABViLsMzrJCNcU6p5d1X7jg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-3Lfz9rCkOGWbJoWcgc25Ww-1; Thu, 05 Mar 2026 12:00:03 -0500
X-MC-Unique: 3Lfz9rCkOGWbJoWcgc25Ww-1
X-Mimecast-MFC-AGG-ID: 3Lfz9rCkOGWbJoWcgc25Ww_1772730003
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb42f56c4aso4992160385a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772730003; x=1773334803; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zefqOHTxG5vv3Mko1njyQnQmXHEz3QoE0naifHiyX0o=;
 b=cFMkNjkmNNshGI39nIQEcgr9an6T03/IRrd1p8+lNLHmaYTfNSKH/EEJDb6Dfh8r4r
 X5OV7DGMxEGAslsutlK/wCz8Ta51hDNmsIyAVKZARK8siHbJsGAEWwXmx6BjtslmpAg3
 4GH8kkquM3udom5Lw6RMOKdzQF/a/1QnIXvFaBeco4Vic319y1d9xYJ2gRG9T2su1fWZ
 ONGUh+MOHutqX6NKLDGfCNATf0KlshoFiSafbu+Sv8ymeREm95Dcopyzk1mCRlk20hYa
 ulrUu6ad/Pf9B9h7iyYLsy4HSUTF35+9tip+05Uhxl5l97WMrMEBHImqAmvPjYU+hO3n
 k1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730003; x=1773334803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zefqOHTxG5vv3Mko1njyQnQmXHEz3QoE0naifHiyX0o=;
 b=wQohSTx4MO9Nc++P7u1SsXBymGyVQCzvvGcEk5f/tn34ODzgE6qXyXTSF0nVJD0B1h
 4vwhisvYB2GYeS9OEKBlVsz0Cm9JrWdr10+gSiamlDuWn38uQBslhGnxy9r+bQr+YaXb
 BCcYMJ2dHExoZLz11vez+xN3CU6RtH66EZYuIforD9qe0qd6klbHVY+TyGJoDOSjChtq
 1G96AAYhZ/e26A6/6jF3cC6Z0BBY1LsnOupenmVjxFfNcSrETEmhJkxKnXSIOaGTCMrk
 qMx4aCE5OXH1b8SC2ExYQNKA4360/7PdLhGnLzb+NTgH0aA/l7hqqPNgFhelFTTjDbjl
 Jzfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVJF352HVLa+LILQJ17kuRuX/eGDNm4eoa8fRzrvNZx9NTKqHMKk1t1thnue7GcEqama5KbFKqQ72R@nongnu.org
X-Gm-Message-State: AOJu0Yx8TKyykHagRhzBHt+C/f9IM1ZNM4nI8jAMlUPYQCQcxUblYV4D
 spHndoBxGCDKH9oPklMybzZEYXTjmc3PI7mCsIBXfHAFXk60E40oi55bfeDkF98Juu1seund8d+
 +3vj8PyXgCQr2EsKRti8Fdu6JxlHrlhfbUvS0CAw8tz1IRZGeP95bsEmu
X-Gm-Gg: ATEYQzwJ+7at6ym/JkV3Fiittlf4TPE8MgwN6kTe24wFFKbTkk1j5pJODl2ITDnNk6d
 a7bYR0UivXgAhfDuem9K4nMfjTs5QminFa0eurSj1g8K8ALwry/13KnZgmvtKQpyv3exXrHQzkf
 vVnUv7DZ/cmmsS0motKaaUXWFIGYOc+D2yQX2pGmOEAv6VyTz3jWcAOGtSAm+qNloStM88rgMYF
 TVk8w4VH58ISjS0tJnOoaHqOyXj4hD+iJRpIAfmxKsi9mVpCWjlOk1ATWgEyQfjRIZPHlA1l+PL
 VYjplAHKBp/ndGJN1ZMCLi3/TelWM8c9Ii3p5g/yJ3gKjjgQFZ30gKgCA9CO7YaKvcFtgaOr12D
 0u1t6/E8KULOGvw==
X-Received: by 2002:a05:620a:708b:b0:8c6:d398:4a76 with SMTP id
 af79cd13be357-8cd6af4101dmr72800885a.2.1772730003156; 
 Thu, 05 Mar 2026 09:00:03 -0800 (PST)
X-Received: by 2002:a05:620a:708b:b0:8c6:d398:4a76 with SMTP id
 af79cd13be357-8cd6af4101dmr72794385a.2.1772730002531; 
 Thu, 05 Mar 2026 09:00:02 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf73451csm1944981985a.47.2026.03.05.09.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:00:02 -0800 (PST)
Date: Thu, 5 Mar 2026 11:59:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 05/18] migration: vmstate_save/load_state(): refactor
 tracing errors
Message-ID: <aam2h3QdDlsDINFF@x1.local>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304212303.667141-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 05, 2026 at 12:22:49AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> To simplify further changes (convertion to bool+errp APIs),
> let's rework some error paths:
> 
> - get rid of int ret in traces, as we are moving to bool+errp APIs
> - split traces to _fail / _success (seems better than add boolean
>   result to the message).
> - prefer short error paths (return immediately on error)
> - around trace_vmstate_load_field_error(), do not call
>   qemu_file_set_error(), if the erroc comes from qemu_file_get_error()
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


