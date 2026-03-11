Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1591125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NV4-0000nF-Pp; Wed, 11 Mar 2026 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0NV2-0000lY-44
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0NUy-00034o-R8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773250651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ToyDvXxTl4dvyFR44x+Q5ypiFRuF0LVLNVZxrHziwtM=;
 b=DuTUhRqPCmOHCA9PMOUh5VU4h/gqkguvPysPptzhXjqhwg3EuhAyKspBy9cjqpEGIMdMO9
 /55Q+qkVB/353wZpdbZl9CpkKBgqm2Fkx/0FaiDUF00UelpWMEH54ZG8AuF08Z7urF+FKZ
 qslpuKl4YBYEovhB98YElZtICOaicdQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-DUG0-T48PEyhI3Fwu5pM7Q-1; Wed, 11 Mar 2026 13:37:30 -0400
X-MC-Unique: DUG0-T48PEyhI3Fwu5pM7Q-1
X-Mimecast-MFC-AGG-ID: DUG0-T48PEyhI3Fwu5pM7Q_1773250650
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd98d96382so15152885a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773250650; x=1773855450; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ToyDvXxTl4dvyFR44x+Q5ypiFRuF0LVLNVZxrHziwtM=;
 b=lSpljhqTvh6Xu2oTHazbii8cDyTJRiCvGT4hU6Me/I3DIhqgN5gkYrzPP7dNMlOhBU
 aU11uZ8t+V5paImZfaE0125V5jALaovY2E8r2mGvKbG0yjUWxayTOOOZYbmryxQdEyjJ
 gazFV1GH9U4MxFAUlNqo3rPZx5l3sF6qQEf/QWPcDJOCJFe1/hs67Qi2VeklcC/GmeK3
 Yba6Ul83FAytmxhiKdJHrLtEjU7raqtiUm8nSpxprDFqsMLjgY20cnES0RXi+ABCIaiR
 Ot//W/WIy4gpx4pF3047xP05eNQ7qECtq6iWiLnI45WAknqxuXHVa35oM/Q0YdYfSVBV
 BKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773250650; x=1773855450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToyDvXxTl4dvyFR44x+Q5ypiFRuF0LVLNVZxrHziwtM=;
 b=iZQKVKAduqHDUkm+uSRyLYwZFGulbjPgLnO3rl3pDpuc36DmruCEKGmnNSGpn/2bqZ
 Dv5xYwxlYKx/ysHg/h4S1VGQoG0R8OWnSs1pTtzptl6Q0UuSbTH5yU9U/U1Ea0eDEKTe
 V/zCTWoBiG5aWMEnMSJ+5lTJDWFLbhtHOZ0E8UFqk3gR+vDXpxpyFmjMSEQfgVq2vY0/
 AXIfhy5E4R+kRdgMHmJgH+S5uPsB1pt4HMxvtu4+dvtUfrl5YG+z1HZDL8DT9IVoNZ+O
 WqSTfV4Kzbo1wP3mlrKDJty+UyiU92f6VUgAaR/AoibddgOJle0YLL0XWHYONWsEanBt
 UbAg==
X-Gm-Message-State: AOJu0Yzl4LnzszwY8sR2WQJAwFF5+9MKDGGG6jNjj8in7y/GkOr5+EAE
 RpwAEHsNQRMPk/+ElppzvZncgkVcpl9lacMjZi0I8hJvCT9iGl2BIA994g/aZnWQN2qDAihzCot
 9dfXBb6bfWJ8nk6gKuwGzTmb2Gnnydw+58M/JzzfHsqkEOoNKo+dV2Zgz
X-Gm-Gg: ATEYQzxVWt0K70s33DGTi0EBeqLthErkworbRXHqlGcs0vyW3yU/AbwL+s9RW6sLO11
 dOy6r4zfx6XHlR19pI361xDT+Y+/2Ux6jfQvFiOaSBeNxJzdAOEzpBEONbbWRIlV5w5tHnUg+GL
 D/EkyYf0MgswZ/hpEKvOyVYEi7MVBIQHw+W2zPmTOCf9bRa2xN7tiUJShUMjUD3el1dzm8nyTPR
 BO+UlhzAxno7ilA8bRwaqu3uWTbxKSmGFv8NQoL7RHz55pcZezmv7O18ps34oE9C80KTxrDK4gH
 E14gDofvct7RgKf3JKIZftWjmy0hGPDp1AAATwYmmqQZOCBhkpuxQo7dbYETNwmDIUWxul3UHAe
 9hT/Wp+SaklJHOQ==
X-Received: by 2002:a05:620a:29c6:b0:8c6:e224:d55b with SMTP id
 af79cd13be357-8cda1a2d8a4mr428287185a.41.1773250649896; 
 Wed, 11 Mar 2026 10:37:29 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:8c6:e224:d55b with SMTP id
 af79cd13be357-8cda1a2d8a4mr428282785a.41.1773250649377; 
 Wed, 11 Mar 2026 10:37:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda216b7fasm173175785a.47.2026.03.11.10.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 10:37:28 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:37:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH v4 0/4] Fix a few minor issues reported by Coverity
Message-ID: <abGoUkNv0sqgm5QH@x1.local>
References: <20260311131522.58600-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311131522.58600-1-heifetz@yandex-team.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, Mar 11, 2026 at 06:15:18PM +0500, Sergei Heifetz wrote:
> Hi. This patch series fixes several minor issues reported by our local
> Coverity installation.
> 
> Changes in v4:
> - Included Peter's explanation why `assert` is redundant in the commit
>   message of the third patch.
> - Added `Reviewed-by` tags that I missed in v2 to the other three patches.
> 
> Changes in v3:
> - Nothing. I sent the second version of the series without the corresponding
> 'v2' suffix by mistake. I apologise.
> 
> Changes in v2:
> - Remove assert(block) in system/physmem.c instead of placing it
>   before the dereference.
> 
> Sergei Heifetz (4):
>   migration/savevm.c: reorder usage and assertion of mis->from_src_file
>   dump/dump.c: reorder usage and assertion of block
>   system/physmem.c: remove useless assertion of block
>   hw/usb/core.c: reorder usage and assertion of p->ep

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


