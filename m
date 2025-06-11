Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67BFC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKfP-00068R-3g; Wed, 11 Jun 2025 08:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPKfN-00068C-5V
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPKfK-000176-SW
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749645287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YC5xrWN13iwQDXbXxQdzl4kHdfFWvmJiuYU3/Pg/VU0=;
 b=Vq2/Xmq6FsE52JAOuUmUyveq9k7NqWPkOJ2YHg1BZPHgtVes8fe8W4LM4AjmNgkA/JBDF1
 wizUtgHUZB055srg4eL5WxjhelqHv1MJv8g3xdcf/ze+Z8vaPJY/5W8jaTMz6KHRBYbm1r
 YRnOFIZmvBvly02ZqS0WaH7bv1QERO4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-keV6iwMaNSGyCW62FZL70Q-1; Wed, 11 Jun 2025 08:34:46 -0400
X-MC-Unique: keV6iwMaNSGyCW62FZL70Q-1
X-Mimecast-MFC-AGG-ID: keV6iwMaNSGyCW62FZL70Q_1749645286
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c53e316734so1008616085a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749645286; x=1750250086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YC5xrWN13iwQDXbXxQdzl4kHdfFWvmJiuYU3/Pg/VU0=;
 b=EVbey2m7orErdFy2o0RvIwrycFZGPFqRdMyemuzY1YueSCm1Mn0flIZzh69/W4Q/Mj
 J8A+x/F1wWOAfka5/A7xTAE9MIVDBqiGp3c+x3veN0Qt5KaRnKL+piDJOPZ7ximl9fB6
 czfiLhE8ZCyMa+fhPnsb/SfCJ3V8ESrdytpg4CNqlysr3T3XZGiuVBgeLxPJxE+iSNa6
 CYz/2iIV/+NUplzHV+1ImnNLyorhdWeB9gXamzl5MSwjhJDRrstyM9ZrVBXv39YUbU5Y
 d18zlLKORzN8sMEPJcQWs+hWW+Mkqf0EEXxKFh/jAhIwyEplJkRHpla/YOodq+v66DZ8
 VMIQ==
X-Gm-Message-State: AOJu0YziaEcsfUVCFEjk34taZvKvBSCUlMK7vZcP6WdJLLunbZUWlfRp
 zZeiPfPi6ZCLcDeaiHcit5+Hjp2TU2W5xTNstwSWjOsLnNsJX33GY26ySLqO33gxB/1MUNMcE+A
 DpPbP9+yKq7+iym9h95BFnx3yHhc437yusLMrYC3V7Ze8I6ew6gZdxo+4MiMWHCsf
X-Gm-Gg: ASbGncuolUg4130MjhMKzoeQGt9NiJMNB98akcm9Ae0c/4uUZno75CidWfXdJatfttz
 4ZhWARz3BHBwpxnDmvGl2iw7aJCwQdv7p0SggT5zPanzxL9VsjRrSMGYrSoshnJD8qa6NcrYVfw
 tk3XMhMDHWEgbaPz0Ug6f8LtNtFLeMr2B/jyGaUH4gx5cuLJeki6I+5I8/72qaKP4P6nJ+PBZYk
 XiB1/7HVtaZMOeYVpjGsTGmMUaskd9KLJXYeXvPGiel7VXhVVi6oNvm/YfpLt9EaLTGTCJ/Jl0m
 oC9+3iJtMOdK1w==
X-Received: by 2002:a05:620a:44d6:b0:7d3:908f:141a with SMTP id
 af79cd13be357-7d3a87fa66bmr522318985a.9.1749645285748; 
 Wed, 11 Jun 2025 05:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8uNGTScBVg1WYWGLVT7Rqbl+AtlWBL3T8gXIydo161JjLPCgV3bNMMu+Cf8j6pCCrpzGtvQ==
X-Received: by 2002:a05:6214:d6a:b0:6fa:fc96:d10a with SMTP id
 6a1803df08f44-6fb2c365da6mr56177586d6.27.1749645273700; 
 Wed, 11 Jun 2025 05:34:33 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09adc0cesm81192456d6.54.2025.06.11.05.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 05:34:33 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:34:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
Message-ID: <aEl31gjAjlt5zj-l@x1.local>
References: <20250521151616.3951178-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521151616.3951178-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> If a virtual machine is paused for an extended period time, for example,
> due to an incoming migration, there are also no changes on the screen.
> VNC in such case increases the display update interval by
> VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> to VNC_REFRESH_INTERVAL_MAX (3000 ms).
> 
> When the machine resumes, it can then take up to 3 seconds for the first
> display update. Furthermore, the update interval is then halved with
> each display update with changes on the screen. If there are moving
> elements on the screen, such as a video, this can be perceived as
> freezing and stuttering for few seconds before the movement is smooth
> again.
> 
> This patch resolves this issue, by adding a listener to VM state changes
> and changing the update interval when the VM state changes to RUNNING.
> The update_displaychangelistener() function updates the internal timer,
> and the display is refreshed immediately if the timer is expired.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

[add Dan]

Ping - anyone is willing to pick this one up?

Thanks,

-- 
Peter Xu


