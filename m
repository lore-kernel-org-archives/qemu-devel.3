Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D83C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Mkq-0001l7-9a; Tue, 07 May 2024 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4Mkp-0001ko-16
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4Mkn-0002SC-Gg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715095754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/HyBI5Ilo3IaqlIxR2VFzCHihsVxurm7xG9CWeZWYM=;
 b=R6RMAqxPdaMrslkZ1Fo8Ytdh6st54DU6H/DjT+QexuSd6oyzgtlhMiC2k9x3M/LQqL2bp+
 /Lh3hCCKp8wXwF5yAf2K+zZ6uATduWvWaU6SbnETKo/p0yDLahAi6zBU+6lYmXxBGZYura
 L6igUh+17kWrHi9WJlZfPeidLh4hbR0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-JSPlMUMBOq61fjs2ZQsPuw-1; Tue, 07 May 2024 11:29:13 -0400
X-MC-Unique: JSPlMUMBOq61fjs2ZQsPuw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5b2080e9b6cso1352628eaf.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715095752; x=1715700552;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p/HyBI5Ilo3IaqlIxR2VFzCHihsVxurm7xG9CWeZWYM=;
 b=hTCkw0ASwgz4UK2OkXsF+nc/4nNVal27IkLwrEDoQ1vTyNhSpRH3YmGfE/ruzBfQKU
 v2GLTZWHqyNvZOPV/NLL7rx5pPQKwETyBSMNhGoo2iArmYycsBiH+ZGyZRDVQQKivblA
 gC250etGhND+Wgaih5ga6DjCar7t+UugrjC6oOWLKydoeDJcZTEYZyizSIccXpAyRBig
 Cj04KaKee5wzHX4Ne3ve/wkTwyn13OGDNUnVQ2VV4zVQfo/z0IpWh+2mhmJDsy96XMLA
 Jx6zIir9kPfh+k4X/2Uk87MBMqRzwId6nFPYXaia/r4Cob2bmRBIMVRBum4vVJ+tyDOs
 3Bcg==
X-Gm-Message-State: AOJu0Yyo26222WjKECYUKvIy1As3pN8MpszIqg1VdyMbR/Or+i8j2pod
 qBmgC+Xl3wqLbPjebTrP01T2tJwdAqVnxihUtqIu3GSc89Yj+OT5r4nvjMg34j6nHsoBYve/aJ0
 k5D/cCA/yp7xAk+sHOOwGN6mPK5HbbmjUKRY6IQXI621fW1zOZPFq
X-Received: by 2002:a05:6358:5904:b0:192:82da:43df with SMTP id
 e5c5f4694b2df-192d2d2b874mr6738355d.1.1715095752235; 
 Tue, 07 May 2024 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSL0NJ57Pjq8kgr5C+tTKvoZpmQ0lljudpZ9mC5xxbOMM5/N/zAWIs7xyUXFoWro0K4kWVzg==
X-Received: by 2002:a05:6358:5904:b0:192:82da:43df with SMTP id
 e5c5f4694b2df-192d2d2b874mr6733655d.1.1715095751472; 
 Tue, 07 May 2024 08:29:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 p28-20020a631e5c000000b005e438fe702dsm9838226pgm.65.2024.05.07.08.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 08:29:11 -0700 (PDT)
Date: Tue, 7 May 2024 11:29:01 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 1/4] migration: add "exists" info to load-state-field trace
Message-ID: <ZjpIvQyndIL4iwN5@x1n>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507111920.1594897-2-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 07, 2024 at 03:19:17PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


