Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E7DC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbMq-0000z8-NM; Fri, 20 Jun 2025 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbMm-0000ws-T9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbMl-0003fp-IE
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750424469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXoO3w+AAUrwkhiN5hiuL+BP73w5x/IxZN038Wb3mUI=;
 b=GppjbYlr9yqnUhCJG69uoAitsvA7IkPIW11DfK74dABIXqVsyrxnXh51o4JVLmISxObp/f
 ie4kcgqKnB+0M1XKzz6zh5hIXAnjqrQ6czJFzhxIseVemUe8jJzsJrrFcRz4M2CUea2m74
 vNO1kN/2QGUKwJNgdaPRLsLqOKFBeTM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-fv59TaUEO6GPjqo2ornsGg-1; Fri, 20 Jun 2025 09:01:07 -0400
X-MC-Unique: fv59TaUEO6GPjqo2ornsGg-1
X-Mimecast-MFC-AGG-ID: fv59TaUEO6GPjqo2ornsGg_1750424466
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so1308045f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424466; x=1751029266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qXoO3w+AAUrwkhiN5hiuL+BP73w5x/IxZN038Wb3mUI=;
 b=nL9z68mJbQCUA1YqPbSx7+xOFq1koEQ1X6wfa2FcGr+1T67pIcYLPQ8FPzlEkNJxna
 DFlJ+sVnsdH/q+AFpeR7/i4i9okqfHlo30uMOmRdMpVj+Iwvzu1DotnaaJKRZ7NPhAQ3
 o1omhMy4uuKaPt+QlOz7e0dA5zjlCpvk903IpkogkSJX2eipMBI4zZkvN4coB21KrCuJ
 aXoewHEYz/Ta5YE2notTl5ULBgvWfYRRAnUBJDHmQbu1Q5cgUysdm7qMhW1b7FZdULQb
 0P0tHO8R3cbpk/0DGg4DQLlsi7/I/FdRUJ2prvINsWmyz4S6c+ePLUol9LCafGgNifaS
 WTbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwWQUAbp7LCePKkNzKsQlaigoUZpQmHpO4L3m4ilBsKr8DVFmNyApx4c0pam5OPZBSEzbVP9TLOBLu@nongnu.org
X-Gm-Message-State: AOJu0YznlsDfJGEx/uBE3xCxbRTPM0ycujidmWgRl+zhIMDHdCmIEEnz
 lC5dhk9LoUDG6GkbxVL13scLfZ0RDC4xqAO+4dII88/blPKRZtxURASczIQueDlKyCl0HpK5uIM
 EX1l8gxb7zmq3FNd7YqMROgV7QwergETqnLFnPn5y1yCImbDXzXHgD3/I
X-Gm-Gg: ASbGncsdb3u4GqvvFbzFphd3kYEVKwJu6lQirnvwEc02fE0Wwzw2gJ8qpGY+y75VoA9
 bgBS7SJsRcRPxd+mwbyyuEOe3Bzk9G8CT0IsfDKA8pclhP7fU6Ccuco4mBbmBZoncGV0XIa1+xR
 Yw9c+hLAJO6YgT4TfrP7gKREtxpbf1xgsBL8u7kveCL2JBixgbStxSrjY1v0GIwtsiUsQjCfx1K
 IeacitBNgdxS9bbydo0UuZ+LuS12JkkTVg3gdLVyx9UJH3R9Kyo7TeN7UitCUD9vtqbnOwzeF0W
 uX7o4er8PuVa
X-Received: by 2002:a05:6000:178b:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3a6d12c4595mr2517298f8f.5.1750424465874; 
 Fri, 20 Jun 2025 06:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7urp9EKEeyvqZ7uauXlJ0TdmjDRJT4c8ncQUYTtSUWLI4rggGLpGQKlKPpkl1R8zPmoVE1Q==
X-Received: by 2002:a05:6000:178b:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3a6d12c4595mr2517210f8f.5.1750424465135; 
 Fri, 20 Jun 2025 06:01:05 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187df7sm2018151f8f.66.2025.06.20.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:01:04 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:01:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 20/29] hw/acpi/ged: Prepare the device to react to
 PCI hotplug events
Message-ID: <20250620150102.702a8078@fedora>
In-Reply-To: <20250616094903.885753-21-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-21-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Jun 2025 11:46:49 +0200
Eric Auger <eric.auger@redhat.com> wrote:

[...]

> @@ -433,6 +443,12 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>              cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>                                  &s->cpuhp_state, 0);
>              break;
> +        case ACPI_GED_PCI_HOTPLUG_EVT:
> +            memory_region_init(&s->container_pcihp, OBJECT(dev),
> +                               ACPI_PCIHP_REGION_NAME, ACPI_PCIHP_SIZE);
> +            sysbus_init_mmio(sbd, &s->container_pcihp);
> +            acpi_pcihp_init(OBJECT(s), &s->pcihp_state,
> +                            s->pcihp_state.root, &s->container_pcihp, 0);

bus flow looks weird,
I'd suggest to
  * set root bus link on x86 as well for consistency reasons and proper ref accounting
  * and then drop 'bus' from acpi_pcihp_init() its arguments

>          }
>          ged_events--;
>      }
[...]


