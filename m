Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C2DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4eP-0000Hm-H7; Fri, 31 May 2024 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD4eN-0000HD-Sb
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD4eM-0004qL-Fz
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717171117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJI8N7hH9TLGrmQr5Di9miB2eUmHmhjlG+pqpkB+dNI=;
 b=F9qoHDwmI0x1V+aOK0qzDWQIon3ea8AeMLv8jTh/M0ACADo4hkNafI9/ssDnFEErG1HaF8
 7ykOFqWT2FERQteyDgrHu1I0Sy0tpYcS7q8cRt3dmV0zrQN/9JqxHhOP5Pn1/yZNKGbKZG
 7nP49tezcFAydP89BgUTmzx9Hh6ahXQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-QSRQFPQbMGCstZyqYI3SJQ-1; Fri, 31 May 2024 11:58:35 -0400
X-MC-Unique: QSRQFPQbMGCstZyqYI3SJQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6aed66131f5so2138876d6.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717171114; x=1717775914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJI8N7hH9TLGrmQr5Di9miB2eUmHmhjlG+pqpkB+dNI=;
 b=UVLLUBcm0qqtMx1y76ldkerIRnUy0xZB04MgLkr6JinI0G6HsxpgAqN+G++Qk+oHAy
 ToCjzVTi0O7ZQVT8XP5kAAoIfodfjdAZtOMVI2dnNDiexYUnjdAuNalkbdxcKnHn9MgU
 qpTGUfsczOSow1MMUaaDuayNXY4mgoxO0dCMsBb5rYLH9Vg/c/v7DEtLe20Q/hXRuRfA
 xFmE0v7aNzMl60J349Rkrtc2Y1pfQqa8/Iz1jZcE2kD/u8kJCZ0E2vY7I0v+WdCoRCva
 E+0QrR7QUs+3luJk5GAnbMDtzqD6+UuHDmdGUdiYajVQDw+1Ww/AI7yTM9mL7jXJ69qj
 KNPQ==
X-Gm-Message-State: AOJu0Yx2+KGOfNE0e/LiSU+Us+LxLnOEEruGm+dEXFmiB4ihKjT6o4Hv
 YHrOEpBaUpoGNs10xgQL8+oVS0qMe/nk4u9FF+CY5tZ01blbE1HdeUTps2D0yO59FI3/2ztZwWa
 nMtru1Nj8Hrxo50hDVZWiUO+Y+r0h6wBdBv0FmoGruWVLQoyUgAW5
X-Received: by 2002:a05:6214:4114:b0:6ab:8427:6afe with SMTP id
 6a1803df08f44-6aecd6a0434mr24656036d6.2.1717171114161; 
 Fri, 31 May 2024 08:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES5JZ64WS94RaI4tXiedTFonfj4JB0ODlasGBGkYxdaFHmSZ5xije7rauzSo4vmrKhBwo0cA==
X-Received: by 2002:a05:6214:4114:b0:6ab:8427:6afe with SMTP id
 6a1803df08f44-6aecd6a0434mr24655666d6.2.1717171113382; 
 Fri, 31 May 2024 08:58:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b4070d1sm7274686d6.82.2024.05.31.08.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 08:58:32 -0700 (PDT)
Date: Fri, 31 May 2024 11:58:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 07/18] monitor: Simplify fdset and fd removal
Message-ID: <Zlnzp7ggXE5DRWmL@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:37PM -0300, Fabiano Rosas wrote:
> Remove fds right away instead of setting the ->removed flag. We don't
> need the extra complexity of having a cleanup function reap the
> removed entries at a later time.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


